///|
fn @model.Check::invalid_action(
  self : @model.Check,
  uses : @model.Node,
  why : String,
) -> Unit {
  self.report(
    uses,
    "action",
    "specifying action \{@model.quote(uses.value)} in invalid format because \{why}. available formats are \"{owner}/{repo}@{ref}\" or \"{owner}/{repo}/{path}@{ref}\"",
  )
}

///|
fn @model.Check::check_action_inputs(
  self : @model.Check,
  step : @model.Node,
  metadata : Json,
  describe : String,
) -> Unit {
  if @jsonutil.data_get(metadata, "skip_inputs") == Json::boolean(true) {
    return
  }
  let inputs = @jsonutil.data_get(metadata, "inputs")
  let specified : Map[String, Bool] = Map([])
  if step.get("with") is Some(with_) {
    for (key, _) in with_.pairs() {
      let name = key.value.to_lower()
      specified[name] = true
      match @jsonutil.data_get(inputs, name) {
        Null =>
          self.report(
            key,
            "action",
            "input \{@model.quote(key.value)} is not defined in action \{describe}. available inputs are \{@model.quotes(@jsonutil.data_keys(inputs).map(name => action_input_name(inputs, name)))}",
          )
        Array(settings) =>
          if settings.length() >= 4 &&
            settings[2] == Json::boolean(true) &&
            settings[1] != Json::boolean(true) {
            let message = @jsonutil.template_string(settings[3])
              .trim_end(char_set=". ")
              .to_owned()
              .split("\n")
              .map(line => line.trim().to_owned())
              .to_array()
              .join(" ")
            self.report(
              key,
              "action",
              "avoid using deprecated input \{@model.quote(key.value)} in action \{describe}" +
              (if message == "" { "" } else { ": " + message }),
            )
          }
        _ => ()
      }
    }
  }
  let required = @jsonutil.data_keys(inputs).filter(name => {
    match @jsonutil.data_get(inputs, name) {
      Array(xs) => xs.length() > 1 && xs[1] == Json::boolean(true)
      _ => false
    }
  })
  let required_names = required.map(name => action_input_name(inputs, name))
  for name in required {
    if specified.get(name) != Some(true) && step.get("uses") is Some(uses) {
      self.report(
        uses,
        "action",
        "missing input \{@model.quote(action_input_name(inputs, name))} which is required by action \{describe}. all required inputs are \{@model.quotes(required_names)}",
      )
    }
  }
}

///|
fn @model.Check::check_actions(
  self : @model.Check,
  workflow : @model.Node,
) -> Unit {
  guard workflow.get("jobs") is Some(jobs) else { return }
  let actions = @jsonutil.data_get(@data.builtin_data, "actions")
  let outdated = @jsonutil.json_strings(
    @jsonutil.data_get(@data.builtin_data, "outdated_actions"),
  )
  for (_, job) in jobs.pairs() {
    if job.get("uses") is Some(uses) &&
      uses.retained &&
      !uses.contains_expression() &&
      uses.value != "" {
      let s = uses.value
      let is_local = s.has_prefix("./") && s.length() > 2 && !s.contains("@")
      let remote = workflow_repo_reference(s)
      if !is_local && !remote {
        self.report(
          uses,
          "workflow-call",
          "reusable workflow call \{@model.quote(s)} at \"uses\" is not following the format \"owner/repo/path/to/workflow.yml@ref\" nor \"./path/to/workflow.yml\". see https://docs.github.com/en/actions/learn-github-actions/reusing-workflows for more details",
        )
      }
    }
    if job.get("steps") is Some(steps) && steps.kind == 2 {
      for step in steps.children {
        guard step.get("uses") is Some(uses) && !uses.contains_expression() else {
          continue
        }
        let spec = uses.value
        if spec.has_prefix("./") {
          continue
        }
        if spec.has_prefix("docker://") {
          self.check_docker_action(uses)
          continue
        }
        if spec.find("@") is Some(at) {
          let repo = spec[:at]
          let ref_ = spec[at + 1:]
          if repo.find("/") is Some(slash) {
            if slash == 0 ||
              slash == repo.length() - 1 ||
              repo[slash + 1:].has_prefix("/") ||
              ref_ == "" {
              self.invalid_action(
                uses, "owner and repo and ref should not be empty",
              )
            }
          } else {
            self.invalid_action(uses, "owner is missing")
            continue
          }
        } else {
          self.invalid_action(uses, "ref is missing")
          continue
        }
        if outdated.contains(spec) {
          self.report(
            uses,
            "action",
            "the runner of \{@model.quote(spec)} action is too old to run on GitHub Actions. update the action's version to fix this issue",
          )
          continue
        }
        let metadata = @jsonutil.data_get(actions, spec)
        if metadata is Object(_) {
          self.check_action_inputs(step, metadata, @model.quote(spec))
        }
      }
    }
  }
}

///|
fn workflow_repo_reference(source : String) -> Bool {
  if source.has_prefix(".") {
    return false
  }
  guard source.find("/") is Some(owner) && owner > 0 else { return false }
  let rest = source[owner + 1:]
  guard rest.find("/") is Some(repo) && repo > 0 else { return false }
  let rest = rest[repo + 1:]
  guard rest.find("@") is Some(path) && path > 0 else { return false }
  path + 1 < rest.length()
}
