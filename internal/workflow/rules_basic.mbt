///|
fn valid_id(s : String) -> Bool {
  let chars = s.to_array()
  if chars.is_empty() {
    return true
  }
  fn alpha(c : Char) -> Bool {
    c is ('a'..<='z' | 'A'..<='Z' | '_')
  }
  alpha(chars[0]) && chars.iter().all(c => alpha(c) || c is ('0'..<='9' | '-'))
}

///|
fn @model.Check::check_id(
  self : @model.Check,
  n : @model.Node,
  what : String,
) -> Unit {
  if n.contains_expression() || valid_id(n.value) {
    return
  }
  self.report(
    n,
    "id",
    "invalid \{what} ID \{@model.quote(n.value)}. \{what} ID must start with a letter or _ and contain only alphanumeric characters, -, or _",
  )
}

///|
fn @model.Check::check_env(self : @model.Check, n : @model.Node) -> Unit {
  for (k, _) in n.pairs() {
    if !k.contains_expression() &&
      k.value.iter().any(c => c is ('&' | '=' | ' ' | '\t')) {
      self.report(
        k,
        "env-var",
        "environment variable name \{@model.quote(k.value)} is invalid. '&', '=' and spaces should not be contained",
      )
    }
  }
}

///|
fn @model.Check::check_permissions(
  self : @model.Check,
  n : @model.Node,
) -> Unit {
  if n.kind == 1 {
    if n.value != "write-all" && n.value != "read-all" {
      self.report(
        n,
        "permissions",
        "\{@model.quote(n.value)} is invalid for permission for all the scopes. available values are \"read-all\", \"write-all\" or {}",
      )
    }
    return
  }
  let scopes = @jsonutil.data_get(@data.builtin_data, "permissions")
  for (k, v) in n.pairs() {
    let allowed = @jsonutil.json_strings(@jsonutil.data_get(scopes, k.value))
    if allowed.is_empty() {
      self.report(
        k,
        "permissions",
        "unknown permission scope \{@model.quote(k.value)}. all available permission scopes are \{@model.quotes(@jsonutil.data_keys(scopes))}",
      )
    } else if !allowed.contains(v.value) {
      self.report(
        v,
        "permissions",
        "\{@model.quote(v.value)} is invalid as permission of scope \{@model.quote(k.value)}. available values are \{allowed.map(@model.quote).join(", ")}",
      )
    }
  }
}

///|
fn runner_labels(job : @model.Node) -> Array[@model.Node] {
  match job.get("runs-on") {
    Some(n) =>
      if n.kind == 3 {
        match n.get("labels") {
          Some(ls) => if ls.kind == 1 || ls.kind == 2 { ls.items() } else { [] }
          None => []
        }
      } else {
        n.items()
      }
    None => []
  }
}

///|
fn runner_platform(job : @model.Node) -> Int32 {
  let mut result = 0
  for n in runner_labels(job) {
    let label = n.value.to_lower()
    let os = if label.has_prefix("windows-") || label == "windows" {
      2
    } else if label.has_prefix("macos-") ||
      label.has_prefix("ubuntu-") ||
      label == "macos" ||
      label == "linux" {
      1
    } else {
      0
    }
    if os != 0 {
      if result != 0 && result != os {
        return 0
      }
      result = os
    }
  }
  result
}

///|
fn @model.Check::check_shell(
  self : @model.Check,
  n : @model.Node,
  platform : Int32,
) -> Unit {
  if n.value.contains("{0}") || n.contains_expression() {
    return
  }
  let all = ["bash", "pwsh", "python", "sh", "cmd", "powershell"]
  let available = if platform == 1 {
    ["bash", "pwsh", "python", "sh"]
  } else if platform == 2 {
    ["bash", "pwsh", "python", "cmd", "powershell"]
  } else {
    all
  }
  if available.contains(n.value.to_lower()) {
    return
  }
  let on_platform = if all.contains(n.value.to_lower()) {
    if platform == 1 {
      " on macOS or Linux"
    } else if platform == 2 {
      " on Windows"
    } else {
      ""
    }
  } else {
    ""
  }
  self.report(
    n,
    "shell-name",
    "shell name \{@model.quote(n.value)} is invalid\{on_platform}. available names are \{@model.quotes(available)}",
  )
}

///|
fn default_shell(scope : @model.Node) -> String {
  match scope.get("defaults") {
    Some(d) =>
      match d.get("run") {
        Some(r) => r.text("shell")
        None => ""
      }
    None => ""
  }
}

///|
fn @model.Check::check_scope(
  self : @model.Check,
  n : @model.Node,
  platform : Int32,
) -> Unit {
  if n.get("env") is Some(env) {
    self.check_env(env)
  }
  if n.get("permissions") is Some(p) {
    self.check_permissions(p)
  }
  if n.get("defaults") is Some(d) &&
    d.get("run") is Some(r) &&
    r.get("shell") is Some(s) {
    self.check_shell(s, platform)
  }
}

///|
fn @model.Check::check_credentials(
  self : @model.Check,
  n : @model.Node,
  where_ : String,
) -> Unit {
  if n.get("env") is Some(e) {
    self.check_env(e)
  }
  if n.get("credentials") is Some(c) &&
    c.get("password") is Some(p) &&
    !p.is_expression() {
    self.report(
      p,
      "credentials",
      "\"password\" section in \{where_} should be specified via secrets. do not put password value directly",
    )
  }
}

///|
fn @model.Check::check_if(self : @model.Check, n : @model.Node) -> Unit {
  if n.value.find("${{") is Some(start) && n.value.find("}}") is Some(end) {
    if start != 0 ||
      end + 2 != n.value.length() ||
      n.value[start + 3:].contains("${{") {
      self.report(
        n,
        "if-cond",
        "if: condition \{@model.quote(n.value)} is always evaluated to true because extra characters are around ${{ }}",
      )
    }
  }
}

///|
fn @model.Check::check_basic(
  self : @model.Check,
  workflow : @model.Node,
  labels : Array[String],
) -> Unit {
  self.check_scope(workflow, 0)
  if workflow.get("jobs") is Some(jobs) {
    for (id, job) in jobs.pairs() {
      self.check_id(id, "job")
      let platform = runner_platform(job)
      self.check_scope(job, platform)
      self.check_runner(job, labels)
      if job.get("if") is Some(cond) {
        self.check_if(cond)
      }
      if job.get("snapshot") is Some(snapshot) &&
        snapshot.get("if") is Some(cond) {
        self.check_if(cond)
      }
      if job.get("container") is Some(c) {
        self.check_credentials(c, "\"container\" section")
      }
      if job.get("services") is Some(services) {
        for (k, c) in services.pairs() {
          self.check_credentials(c, "\{@model.quote(k.value)} service")
        }
      }
      let seen : Map[String, @model.Node] = Map([])
      if job.get("steps") is Some(steps) && steps.kind == 2 {
        for step in steps.children {
          if step.get("id") is Some(id) {
            self.check_id(id, "step")
            let lower = id.value.to_lower()
            if seen.get(lower) is Some(prev) {
              self.report(
                id,
                "id",
                "step ID \{@model.quote(id.value)} duplicates. previously defined at line:\{prev.line},col:\{prev.column}. step ID must be unique within a job. note that step ID is case insensitive",
              )
            } else {
              seen[lower] = id
            }
          }
          if step.get("env") is Some(env) {
            self.check_env(env)
          }
          if step.get("if") is Some(cond) {
            self.check_if(cond)
          }
          if step.get("run") is Some(run) {
            if step.get("shell") is Some(shell) {
              self.check_shell(shell, platform)
            }
            self.check_deprecated(run)
          }
        }
      }
    }
    self.check_needs(jobs)
  }
}

///|
fn @model.Check::check_deprecated(self : @model.Check, n : @model.Node) -> Unit {
  for
    (command, replacement) in [
      ("set-output", "echo \"{name}={value}\" >> $GITHUB_OUTPUT"),
      ("save-state", "echo \"{name}={value}\" >> $GITHUB_STATE"),
      ("set-env", "echo \"{name}={value}\" >> $GITHUB_ENV"),
      ("add-path", "echo \"{path}\" >> $GITHUB_PATH"),
    ] {
    let pattern = if command == "add-path" {
      "::add-path::\\S+"
    } else {
      "::" + command + "\\s+name=[a-zA-Z][a-zA-Z_-]*::\\S+"
    }
    if @matching.regex_match(pattern, n.value) {
      self.report(
        n,
        "deprecated-commands",
        "workflow command \{@model.quote(command)} was deprecated. use `\{replacement}` instead: https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions",
      )
    }
  }
}

///|
fn @model.Check::check_runner(
  self : @model.Check,
  job : @model.Node,
  custom : Array[String],
) -> Unit {
  let known = @jsonutil.json_strings(
    @jsonutil.data_get(@data.builtin_data, "runners"),
  )
  let presets = [
    "linux", "macos", "windows", "self-hosted", "x64", "arm", "arm64",
  ]
  let compat_table = @jsonutil.data_get(@data.builtin_data, "runner_compat")
  let seen : Array[(String, @model.Node)] = []
  let labels = runner_labels(job)
  for original in labels {
    let expanded = matrix_runner_labels(original, job)
    let pending : Array[(String, @model.Node)] = []
    for label in expanded {
      let lower = label.value.to_lower()
      if !known.contains(lower) && !presets.contains(lower) {
        let mut matched = false
        for pattern in custom {
          if !@matching.glob_valid(pattern, doublestar=false) {
            self.report(
              label,
              "runner-label",
              "label pattern \{@model.quote(pattern)} is an invalid glob. kindly check list of labels in actionlint.yaml config file: syntax error in pattern",
            )
            matched = true
            break
          }
          if @matching.glob_match(pattern, label.value, false) {
            matched = true
            break
          }
        }
        if !matched {
          let all = known.copy()
          all.append([
            "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows",
          ])
          all.append(custom)
          self.report(
            label,
            "runner-label",
            "label \{@model.quote(label.value)} is unknown. available labels are \{all.map(@model.quote).join(", ")}. if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file",
          )
        }
      }
      if @jsonutil.data_get(compat_table, lower) is String(compat) {
        let mut conflict = false
        if labels.length() != 1 {
          for (other, prev) in seen {
            let os1 = compat.split(" | ").to_array()
            let os2 = other.split(" | ").to_array()
            if !os1.iter().any(x => os2.contains(x)) {
              self.report(
                label,
                "runner-label",
                "label \{@model.quote(label.value)} conflicts with label \{@model.quote(prev.value)} defined at line:\{prev.line},col:\{prev.column}. note: to run your job on each workers, use matrix",
              )
              conflict = true
              break
            }
          }
        }
        if !conflict {
          pending.push((compat, label))
        }
      }
    }
    seen.append(pending)
  }
}

///|
fn matrix_runner_labels(
  label : @model.Node,
  job : @model.Node,
) -> Array[@model.Node] {
  if !label.contains_expression() {
    return [label]
  }
  if !label.is_expression() {
    return []
  }
  let text = label.value.trim()
  let (expr, _) = @expression.parse_expression(text[3:].to_owned()) catch {
    _ => return []
  }
  if expr.kind != "property" ||
    expr.children[0].kind != "variable" ||
    expr.children[0].value.to_lower() != "matrix" {
    return []
  }
  guard job.get("strategy") is Some(strategy) &&
    strategy.get("matrix") is Some(matrix) else {
    return []
  }
  let result = []
  if matrix.get_ci(expr.value) is Some(row) && row.kind == 2 {
    for value in row.children {
      if value.kind == 1 && !value.contains_expression() {
        result.push(value)
      }
    }
  }
  if matrix.get_ci("include") is Some(included) && included.kind == 2 {
    for combination in included.children {
      if combination.get_ci(expr.value) is Some(value) &&
        value.kind == 1 &&
        !value.contains_expression() {
        result.push(value)
      }
    }
  }
  result
}

///|
fn @model.Check::check_needs(self : @model.Check, jobs : @model.Node) -> Unit {
  let nodes : Map[String, (@model.Node, @model.Node)] = Map([])
  for (id, job) in jobs.pairs() {
    nodes[id.value.to_lower()] = (id, job)
  }
  let mut valid = true
  for (id, job) in jobs.pairs() {
    if job.get("needs") is Some(needs) {
      let seen : Map[String, Bool] = Map([])
      for dep in needs.items() {
        self.check_id(dep, "job")
        let name = dep.value.to_lower()
        if seen.get(name) == Some(true) {
          self.report(
            dep,
            "job-needs",
            "job ID \{@model.quote(dep.value)} duplicates in \"needs\" section. note that job ID is case insensitive",
          )
        } else if !nodes.contains(name) && name != "" {
          self.report(
            id,
            "job-needs",
            "job \{@model.quote(id.value.to_lower())} needs job \{@model.quote(name)} which does not exist in this workflow",
          )
          valid = false
        }
        seen[name] = true
      }
    }
  }
  if !valid {
    return
  }
  let states : Map[String, Int32] = Map([])
  for (id, _) in jobs.pairs() {
    if find_cycle(id.value.to_lower(), nodes, states, []) is Some(cycle) {
      let mut start = 0
      for i in 1..<cycle.length() {
        if nodes[cycle[i]].0.line < nodes[cycle[start]].0.line {
          start = i
        }
      }
      let ordered = []
      for i in 0..<cycle.length() {
        ordered.push(cycle[(i + start) % cycle.length()])
      }
      ordered.push(ordered[0])
      self.report(
        nodes[ordered[0]].0,
        "job-needs",
        "cyclic dependencies in \"needs\" job configurations are detected. detected cycle is \{ordered.map(@model.quote).join(" -> ")}",
      )
      return
    }
  }
}

///|
fn find_cycle(
  id : String,
  nodes : Map[String, (@model.Node, @model.Node)],
  states : Map[String, Int32],
  stack : Array[String],
) -> Array[String]? {
  if states.get(id) == Some(1) {
    let mut start = 0
    for i in 0..<stack.length() {
      if stack[i] == id {
        start = i
        break
      }
    }
    return Some(stack[start:].to_owned())
  }
  if states.get(id) == Some(2) {
    return None
  }
  states[id] = 1
  stack.push(id)
  if nodes.get(id) is Some((_, job)) && job.get("needs") is Some(needs) {
    for dep in needs.items() {
      if find_cycle(dep.value.to_lower(), nodes, states, stack) is Some(cycle) {
        return Some(cycle)
      }
    }
  }
  ignore(stack.pop())
  states[id] = 2
  None
}
