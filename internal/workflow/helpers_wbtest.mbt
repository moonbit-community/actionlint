///|
fn behavior_node(source : String) -> @model.Node raise {
  let check = @model.Check::{ errors: [], }
  let root = @yaml.parse_yaml(source, check)
  assert_eq(check.errors.length(), 0)
  guard root is Some(root) else { fail("expected YAML document") }
  root
}

///|
fn format_errors(
  format : String,
  errors : Json,
  extra_kinds~ : Array[String] = [],
) -> String raise @model.CliError {
  let (output, error) = @template.try_format_errors(
    format,
    errors,
    extra_kinds~,
  )
  if error is Some(message) {
    raise CliError(message)
  }
  output
}
