///|
fn try_format_errors(
  format : String,
  errors : Json,
  extra_kinds~ : Array[String] = [],
) -> (String, String?) raise @model.CliError {
  let (bytes, error) = try_format_errors_bytes(format, errors, extra_kinds~)
  (@utf8.decode_lossy(bytes), error)
}

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
