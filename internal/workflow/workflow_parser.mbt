///|
fn @model.Check::string_value(
  self : @model.Check,
  n : @model.Node,
  empty~ : Bool = false,
) -> Unit {
  if n.kind != 1 {
    n.retained = false
    self.syntax(
      n,
      "expected scalar node for string value but found \{n.kind_name()} node with \{@model.quote(n.tag)} tag",
    )
  } else if !empty && n.value == "" {
    self.syntax(n, "string should not be empty")
  }
}

///|
fn @model.Check::expression_value(
  self : @model.Check,
  n : @model.Node,
  expected : String,
) -> Unit {
  if !n.is_expression() {
    n.retained = false
    self.syntax(
      n,
      "expecting a single ${{...}} expression or \{expected}, but found plain text node",
    )
  }
}

///|
fn @model.Check::number_value(
  self : @model.Check,
  n : @model.Node,
  integer : Bool,
  positive~ : Bool = false,
) -> Unit {
  let what = if integer { "integer" } else { "float" }
  if n.kind != 1 ||
    (n.tag != "!!str" && n.tag != "!!int" && (integer || n.tag != "!!float")) {
    self.syntax(
      n,
      "expected scalar node for \{what} value but found \{n.kind_name()} node with \{@model.quote(n.tag)} tag",
    )
  } else if n.tag == "!!str" {
    self.expression_value(
      n,
      if integer {
        "integer literal"
      } else {
        "float number literal"
      },
    )
  } else {
    let parsed = @yaml.parse_yaml_number(n.value, integer) catch {
      CliError(message) => {
        self.syntax(
          n,
          "invalid \{what} value: \{@model.quote(n.value)}: \{message}",
        )
        return
      }
    }
    if positive && parsed <= 0.0 {
      let field = if integer { "max-parallel" } else { "timeout-minutes" }
      self.syntax(
        n,
        "value at \{@model.quote(field)} must be greater than zero: \{parsed}",
      )
    }
  }
}

///|
fn @model.Check::bool_value(self : @model.Check, n : @model.Node) -> Unit {
  if n.kind != 1 || (n.tag != "!!bool" && n.tag != "!!str") {
    self.syntax(
      n,
      "expected bool value but found \{n.kind_name()} node with \{@model.quote(n.tag)} tag",
    )
  } else if n.tag == "!!str" {
    self.expression_value(n, "boolean literal \"true\" or \"false\"")
  }
}

///|
fn @model.Check::mapping(
  self : @model.Check,
  n : @model.Node,
  where_ : String,
  empty : Bool,
  sensitive~ : Bool = true,
) -> Array[(@model.Node, @model.Node)] {
  if n.kind == 1 && n.tag == "!!null" {
    if !empty {
      self.syntax(
        n,
        "\{where_} should not be empty. please remove this section if it's unnecessary",
      )
    }
    return []
  }
  if n.kind != 3 {
    n.retained = false
    self.syntax(
      n,
      "\{where_} is \{n.kind_name()} node but mapping node is expected",
    )
    return []
  }
  let seen : Map[String, @model.Node] = Map([])
  let entries = []
  for (key, value) in n.pairs() {
    self.string_value(key)
    if key.value == "<<" {
      self.syntax(key, "GitHub Actions does not support YAML merge key \"<<\"")
      continue
    }
    let id = if sensitive { key.value } else { key.value.to_lower() }
    if seen.get(id) is Some(previous) {
      let note = if sensitive {
        ""
      } else {
        ". note that this key is case insensitive"
      }
      self.syntax(
        key,
        "key \{@model.quote(key.value)} is duplicated in \{where_}. previously defined at line:\{previous.line},col:\{previous.column}\{note}",
      )
    } else {
      seen[id] = key
      entries.push((key, value))
    }
  }
  if !empty && entries.is_empty() {
    self.syntax(
      n,
      "\{where_} should not be empty. please remove this section if it's unnecessary",
    )
  }
  n.children.clear()
  for (k, v) in entries {
    n.children.push(k)
    n.children.push(v)
  }
  entries
}

///|
fn @model.Check::sequence(
  self : @model.Check,
  n : @model.Node,
  section : String,
  empty~ : Bool = false,
) -> Array[@model.Node] {
  if n.kind != 2 {
    n.retained = false
    self.syntax(
      n,
      "\{@model.quote(section)} section must be sequence node but got \{n.kind_name()} node with \{@model.quote(n.tag)} tag",
    )
    return []
  }
  if !empty && n.children.is_empty() {
    self.syntax(n, "\{@model.quote(section)} section should not be empty")
  }
  n.children
}

///|
fn @model.Check::strings(
  self : @model.Check,
  n : @model.Node,
  section : String,
  scalar~ : Bool = false,
  empty~ : Bool = false,
  item_empty~ : Bool = false,
) -> Unit {
  if scalar && n.kind == 1 {
    if !(empty && n.tag == "!!null") {
      self.string_value(n, empty=item_empty)
    }
  } else {
    for item in self.sequence(n, section, empty~) {
      self.string_value(item, empty=item_empty)
    }
  }
}

///|
fn @model.Check::unexpected(
  self : @model.Check,
  key : @model.Node,
  section : String,
  allowed : Array[String],
) -> Unit {
  key.retained = false
  let where_ = if section.contains(" ") {
    section
  } else {
    "\{@model.quote(section)} section"
  }
  if allowed.length() == 1 {
    self.syntax(
      key,
      "expected \{@model.quote(allowed[0])} key for \{where_} but got \{@model.quote(key.value)}",
    )
  } else {
    self.syntax(
      key,
      "unexpected key \{@model.quote(key.value)} for \{where_}. expected one of \{@model.quotes(allowed)}",
    )
  }
}

///|
fn @model.Check::string_map(
  self : @model.Check,
  n : @model.Node,
  section : String,
  empty~ : Bool = false,
) -> Unit {
  for
    (_, v) in self.mapping(
      n,
      "\{@model.quote(section)} section",
      empty,
      sensitive=false,
    ) {
    self.string_value(v, empty=true)
  }
}

///|
fn @model.Check::parse_section(
  self : @model.Check,
  n : @model.Node,
  section : String,
  key : @model.Node,
) -> Unit {
  match section {
    "env" =>
      if n.kind == 1 {
        self.expression_value(n, "mapping value for \"env\" section")
      } else {
        self.string_map(n, "env")
      }
    "permissions" =>
      if n.kind == 1 {
        self.string_value(n)
      } else {
        for
          (_, v) in self.mapping(
            n,
            "\"permissions\" section",
            true,
            sensitive=false,
          ) {
          self.string_value(v)
        }
      }
    "defaults" => {
      for (k, v) in self.mapping(n, "\"defaults\" section", false) {
        if k.value != "run" {
          self.unexpected(k, "defaults", ["run"])
        } else {
          for (rk, rv) in self.mapping(v, "\"run\" section", false) {
            if rk.value != "shell" && rk.value != "working-directory" {
              self.unexpected(rk, "run", ["shell", "working-directory"])
            } else {
              self.string_value(rv)
            }
          }
        }
      }
      if n.get("run") is None {
        self.syntax(n, "\"defaults\" section should have \"run\" section")
      }
    }
    "concurrency" | "environment" | "credentials" => {
      if n.kind == 1 && section != "credentials" {
        self.string_value(n)
        return
      }
      if section == "credentials" && n.is_expression() {
        return
      }
      let allowed = match section {
        "concurrency" => ["group", "cancel-in-progress"]
        "environment" => ["deployment", "name", "url"]
        _ => ["username", "password"]
      }
      for (k, v) in self.mapping(n, "\{@model.quote(section)} section", false) {
        if !allowed.contains(k.value) {
          self.unexpected(k, section, allowed)
        } else if k.value == "cancel-in-progress" || k.value == "deployment" {
          self.bool_value(v)
        } else {
          self.string_value(v)
        }
      }
      match section {
        "concurrency" =>
          if n.get("group") is None {
            self.syntax(key, "group name is missing in \"concurrency\" section")
          }
        "environment" =>
          if n.get("name") is None {
            self.syntax(key, "name is missing in \"environment\" section")
          }
        _ =>
          if n.get("username") is None || n.get("password") is None {
            self.syntax(
              key, "both \"username\" and \"password\" must be specified in \"credentials\" section",
            )
          }
      }
    }
    "container" | "services-container" => {
      if n.kind == 1 {
        self.string_value(n)
        return
      }
      let sec = if section == "container" { "container" } else { "services" }
      let allowed = [
        "image", "credentials", "env", "ports", "volumes", "options",
      ]
      if sec == "services" {
        allowed.push("command")
        allowed.push("entrypoint")
      }
      for (k, v) in self.mapping(n, "\{@model.quote(sec)} section", false) {
        match k.value {
          "image" => self.string_value(v)
          "credentials" | "env" => self.parse_section(v, k.value, k)
          "ports" | "volumes" => self.strings(v, k.value, empty=true)
          "options" | "command" | "entrypoint" =>
            if allowed.contains(k.value) {
              self.string_value(v, empty=true)
            } else {
              self.unexpected(k, sec, allowed)
            }
          _ => self.unexpected(k, sec, allowed)
        }
      }
      if n.get("image") is None {
        self.syntax(key, "\"image\" is missing in \{@model.quote(sec)} section")
      }
    }
    "services" => {
      if n.is_expression() {
        return
      }
      for
        (k, v) in self.mapping(
          n,
          "\"services\" section",
          false,
          sensitive=false,
        ) {
        self.parse_section(v, "services-container", k)
      }
    }
    "outputs" => {
      self.string_map(n, section)
      if n.pairs().is_empty() {
        self.syntax(n, "\"outputs\" section should not be empty")
      }
    }
    "with" => self.string_map(n, section)
    "runs-on" => {
      if n.is_expression() {
        return
      }
      if n.kind == 1 || n.kind == 2 {
        self.strings(n, section, scalar=true)
        return
      }
      for (k, v) in self.mapping(n, "\"runs-on\" section", false) {
        match k.value {
          "group" => self.string_value(v)
          "labels" =>
            if !v.is_expression() {
              self.strings(v, "labels", scalar=true)
            }
          _ => self.unexpected(k, section, ["group", "labels"])
        }
      }
    }
    "strategy" =>
      for (k, v) in self.mapping(n, "\"strategy\" section", false) {
        match k.value {
          "matrix" => self.parse_section(v, "matrix", k)
          "fail-fast" => self.bool_value(v)
          "max-parallel" => self.number_value(v, true, positive=true)
          _ =>
            self.unexpected(k, section, ["matrix", "fail-fast", "max-parallel"])
        }
      }
    "matrix" => {
      if n.kind == 1 {
        self.expression_value(n, "matrix")
        return
      }
      for
        (k, v) in self.mapping(n, "\"matrix\" section", false, sensitive=false) {
        if k.value.to_lower() == "include" || k.value.to_lower() == "exclude" {
          if v.kind == 1 {
            self.expression_value(v, "array of matrix combination")
          } else {
            for combination in self.sequence(v, k.value.to_lower()) {
              if combination.kind == 1 {
                self.expression_value(combination, "matrix combination")
              } else {
                for
                  (_, item) in self.mapping(
                    combination,
                    "element in \{@model.quote(k.value.to_lower())} section",
                    false,
                    sensitive=false,
                  ) {
                  self.raw_syntax(item)
                }
              }
            }
          }
        } else if v.kind == 1 {
          self.expression_value(v, "array value for matrix variations")
        } else {
          for item in self.sequence(v, "matrix values") {
            self.raw_syntax(item)
          }
        }
      }
    }
    "snapshot" => {
      if n.kind == 1 {
        self.string_value(n)
        return
      }
      if n.kind != 3 {
        self.syntax(
          n,
          "\"snapshot\" section value must be string or mapping but found \{n.kind_name()} node",
        )
        return
      }
      for (k, v) in self.mapping(n, "\"on\" section", false) {
        if !["image-name", "version", "if"].contains(k.value) {
          self.unexpected(k, "snapshot", ["image-name", "version", "if"])
        } else {
          self.string_value(v)
        }
      }
      if n.get("image-name") is None {
        self.syntax(
          key, "\"snapshot\" section must have \"image-name\" configuration",
        )
      }
    }
    _ => self.string_value(n)
  }
}

///|
fn @model.Check::raw_syntax(self : @model.Check, n : @model.Node) -> Unit {
  if n.kind == 3 {
    for (_, value) in self.mapping(n, "matrix row value", true, sensitive=false) {
      self.raw_syntax(value)
    }
  } else if n.kind == 2 {
    for value in n.children {
      self.raw_syntax(value)
    }
  } else if n.kind != 1 {
    self.syntax(
      n,
      "unexpected \{n.kind_name()} node on parsing value in matrix row",
    )
  }
}

///|
fn @model.Check::parse_step(self : @model.Check, n : @model.Node) -> Unit {
  let entries = self.mapping(n, "element of \"steps\" section", false)
  let mut exec = ""
  for (k, _) in entries {
    if k.value == "run" || k.value == "uses" {
      exec = k.value
    }
  }
  if exec == "" {
    self.syntax(
      n, "step must run script with \"run\" section or run action with \"uses\" section",
    )
  }
  let common = [
    "id", "if", "name", "env", "continue-on-error", "timeout-minutes",
  ]
  let allowed = common.copy()
  let where_ = if exec == "uses" {
    allowed.push("uses")
    allowed.push("with")
    "step to execute action"
  } else {
    allowed.push("run")
    allowed.push("shell")
    allowed.push("working-directory")
    "step to run shell command"
  }
  for (k, v) in entries {
    if !allowed.contains(k.value) {
      if exec != "" {
        self.unexpected(k, where_, allowed)
      }
      continue
    }
    match k.value {
      "continue-on-error" => self.bool_value(v)
      "timeout-minutes" => self.timeout(v)
      "env" | "with" => self.parse_section(v, k.value, k)
      "name" => self.string_value(v, empty=true)
      _ => self.string_value(v)
    }
  }
}

///|
fn @model.Check::timeout(self : @model.Check, n : @model.Node) -> Unit {
  self.number_value(n, false, positive=true)
}

///|
fn @model.Check::parse_job(
  self : @model.Check,
  id : @model.Node,
  n : @model.Node,
) -> Unit {
  let allowed = [
    "name", "needs", "runs-on", "permissions", "environment", "concurrency", "outputs",
    "env", "defaults", "if", "steps", "timeout-minutes", "strategy", "continue-on-error",
    "container", "services", "uses", "with", "secrets", "snapshot",
  ]
  let mut step_key : @model.Node? = None
  let mut call_key : @model.Node? = None
  for (k, v) in self.mapping(n, "\{@model.quote(id.value)} job", false) {
    match k.value {
      "needs" => self.strings(v, "needs", scalar=true)
      "steps" => {
        step_key = Some(k)
        for s in self.sequence(v, "steps") {
          self.parse_step(s)
        }
      }
      "timeout-minutes" => {
        step_key = Some(k)
        self.timeout(v)
      }
      "continue-on-error" => {
        step_key = Some(k)
        self.bool_value(v)
      }
      "name" => self.string_value(v, empty=true)
      "if" => self.string_value(v)
      "uses" => {
        call_key = Some(k)
        self.string_value(v)
      }
      "with" => {
        call_key = Some(k)
        self.string_map(v, "with")
      }
      "secrets" => {
        call_key = Some(k)
        if v.kind == 1 {
          if v.value != "inherit" {
            self.syntax(
              v,
              "expected mapping node for secrets or \"inherit\" string node but found \{@model.quote(v.value)} node",
            )
          }
        } else {
          self.string_map(v, "secrets")
        }
      }
      _ =>
        if allowed.contains(k.value) {
          if [
              "runs-on", "environment", "outputs", "env", "defaults", "container",
            ].contains(k.value) {
            step_key = Some(k)
          }
          self.parse_section(v, k.value, k)
        } else {
          self.unexpected(k, "job", allowed)
        }
    }
  }
  if n.get("uses") is Some(_) {
    if step_key is Some(k) {
      for field in ["uses", "with", "secrets"] {
        if n.get(field) is Some(value) {
          value.retained = false
        }
      }
      self.syntax(
        k,
        "when a reusable workflow is called with \"uses\", \{@model.quote(k.value)} is not available. only following keys are allowed: \"name\", \"uses\", \"with\", \"secrets\", \"needs\", \"if\", and \"permissions\" in job \{@model.quote(id.value)}",
      )
    }
  } else {
    if !n
      .get("steps")
      .map(s => s.kind == 2 && !s.children.is_empty())
      .unwrap_or(false) {
      self.syntax(
        id,
        "\"steps\" section is missing in job \{@model.quote(id.value)}",
      )
    }
    if n.get("runs-on") is None {
      self.syntax(
        id,
        "\"runs-on\" section is missing in job \{@model.quote(id.value)}",
      )
    }
    if call_key is Some(k) {
      self.syntax(
        k,
        "\{@model.quote(k.value)} is only available for a reusable workflow call with \"uses\" but \"uses\" is not found in job \{@model.quote(id.value)}",
      )
    }
  }
}

///|
fn @model.Check::parse_workflow(self : @model.Check, n : @model.Node) -> Unit {
  let allowed = [
    "name", "run-name", "on", "permissions", "env", "defaults", "concurrency", "jobs",
  ]
  for (k, v) in self.mapping(n, "\"workflow\" section", false) {
    match k.value {
      "name" => self.string_value(v, empty=true)
      "run-name" => self.string_value(v)
      "on" => self.parse_events(v)
      "jobs" =>
        for
          (id, job) in self.mapping(
            v,
            "\"jobs\" section",
            false,
            sensitive=false,
          ) {
          self.parse_job(id, job)
        }
      _ =>
        if allowed.contains(k.value) {
          self.parse_section(v, k.value, k)
        } else {
          self.unexpected(k, "workflow", allowed)
        }
    }
  }
  let root = @model.node(0, "", n.document_line, n.document_column, 0, "", 0)
  if n.get("on") is None {
    self.syntax(root, "\"on\" section is missing in workflow")
  }
  if n.get("jobs") is None {
    self.syntax(root, "\"jobs\" section is missing in workflow")
  }
}
