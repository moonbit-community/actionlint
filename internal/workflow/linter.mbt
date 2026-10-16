///|
pub async fn lint_source(
  source : String,
  config : @config.Config,
  cache : MetadataCache,
  project : String?,
  shellcheck : String?,
  log~ : ((String) -> Unit)? = None,
  filename~ : String = "<stdin>",
  debug~ : Bool = false,
  shellcheck_name~ : String = "",
) -> Array[@model.Diagnostic] {
  let started = @async.now()
  let check = @model.Check::{ errors: [], }
  let workflow = @yaml.parse_yaml(source, check)
  if workflow is Some(root) {
    check.parse_workflow(root)
  } else if check.errors.is_empty() {
    check.syntax(@model.node(0, "", 1, 1, 0, "", 0), "workflow is empty")
  }
  if log is Some(write) {
    write(
      "verbose: Found \{check.errors.length()} parse errors in \{@async.now() - started} ms for \{filename}\n",
    )
  }
  if workflow is Some(root) {
    if log is Some(write) && shellcheck is None {
      write(
        if shellcheck_name == "" {
          "verbose: Rule \"shellcheck\" was disabled since shellcheck command name was empty\n"
        } else {
          "verbose: Rule \"shellcheck\" was disabled: command \{@model.quote(shellcheck_name)} was not found\n"
        },
      )
    }
    let (actions, workflows) = cache.load(check, root, project)
    check.check_basic(root, config.labels)
    check.check_events(root)
    check.check_matrix(root)
    check.check_actions(root)
    check.check_local_calls(root, actions, workflows)
    check.check_expressions(root, config.variables, actions~, workflows~)
    check.external_checkers(root, shellcheck)
  }
  if log is Some(write) {
    if debug {
      for
        kind in [
          "matrix", "credentials", "shell-name", "runner-label", "events", "job-needs",
          "action", "env-var", "id", "glob", "permissions", "workflow-call", "expression",
          "deprecated-commands", "if-cond",
        ] {
        write(
          "[Linter] \{kind} found \{check.errors.iter().filter(e => e.kind == kind).count()} errors\n",
        )
      }
    }
  }
  @model.sorted_diagnostics(check.errors)
}
