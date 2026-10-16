///|
fn format_errors(
  format : String,
  errors : Json,
  extra_kinds~ : Array[String] = [],
) -> String raise @model.CliError {
  let (output, error) = try_format_errors(format, errors, extra_kinds~)
  if error is Some(message) {
    raise CliError(message)
  }
  output
}
