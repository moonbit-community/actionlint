///|
fn @model.Check::check_local_calls(
  self : @model.Check,
  workflow : @model.Node,
  actions : Map[String, @model.Node],
  workflows : Map[String, @model.Node],
) -> Unit {
  guard workflow.get("jobs") is Some(jobs) else { return }
  for (_, job) in jobs.pairs() {
    if job.get("uses") is Some(uses) &&
      uses.retained &&
      workflows.get(uses.value) is Some(metadata) {
      for (kind, section) in [("input", "with"), ("secret", "secrets")] {
        if kind == "secret" && job.text("secrets") == "inherit" {
          continue
        }
        let definitions = metadata.get(kind + "s")
        let specified = job.get(section)
        if definitions is Some(definitions) {
          for (name, definition) in definitions.pairs() {
            if metadata_required(definition, kind == "input") &&
              !specified
              .map(s => s.get_ci(name.value) is Some(_))
              .unwrap_or(false) {
              self.report(
                uses,
                "workflow-call",
                "\{kind} \{@model.quote(name.value)} is required by \{@model.quote(uses.value)} reusable workflow",
              )
            }
          }
        }
        if specified is Some(specified) {
          for (name, _) in specified.pairs() {
            if !definitions
              .map(d => d.get_ci(name.value) is Some(_))
              .unwrap_or(false) {
              let names = definitions
                .map(d => d.pairs().map(p => p.0.value))
                .unwrap_or([])
              let note = if names.is_empty() {
                "no \{kind} is defined"
              } else if names.length() == 1 {
                "defined \{kind} is \{@model.quote(names[0])}"
              } else {
                "defined \{kind}s are \{@model.quotes(names)}"
              }
              self.report(
                name,
                "workflow-call",
                "\{kind} \{@model.quote(name.value)} is not defined in \{@model.quote(uses.value)} reusable workflow. \{note}",
              )
            }
          }
        }
      }
    }
    if job.get("steps") is Some(steps) && steps.kind == 2 {
      for step in steps.children {
        if step.get("uses") is Some(uses) &&
          actions.get(uses.value) is Some(metadata) {
          self.check_action_inputs(
            step,
            local_action_json(metadata),
            "\{@model.quote(metadata.text("name"))} defined at \{@model.quote(uses.value)}",
          )
        }
      }
    }
  }
}
