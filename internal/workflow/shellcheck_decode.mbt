///|
priv struct ShellcheckDiagnostic {
  code : Int64
  line : Int64
  column : Int64
  level : String
  message : String
}

///|
fn shellcheck_json_type(value : Json) -> String {
  match value {
    Object(_) => "object"
    Array(_) => "array"
    Number(_, ..) => "number"
    String(_) => "string"
    _ => "bool"
  }
}

///|
fn decode_shellcheck(
  output : String,
) -> Array[ShellcheckDiagnostic] raise @model.CliError {
  fn invalid(output : String, reason : String) -> Unit raise @model.CliError {
    raise CliError(
      "could not parse JSON output from shellcheck: \{reason}: stdout=\{@model.quote(output)}",
    )
  }
  let value = @jsonutil.json_preserve_numbers(output) catch {
    _ => {
      invalid(output, @jsonutil.json_syntax_error(output).1)
      return []
    }
  }
  if value is Null {
    return []
  }
  guard value is Array(items) else {
    invalid(
      output,
      "json: cannot unmarshal \{shellcheck_json_type(value)} into Go value of type []actionlint.shellcheckError",
    )
    return []
  }
  let diagnostics = []
  for item in items {
    if !(item is (Null | Object(_))) {
      invalid(
        output,
        "json: cannot unmarshal \{shellcheck_json_type(item)} into Go value of type actionlint.shellcheckError",
      )
    }
    let fields : Map[String, Json] = Map([])
    if item is Object(props) {
      for key, value in props {
        fields[key.to_lower()] = value
      }
    }
    for name in ["line", "column", "level", "code", "message"] {
      if fields.get(name) is Some(v) && v != Json::null() {
        let numeric = ["code", "line", "column"].contains(name)
        let valid = if numeric {
          match v {
            Number(n, repr~) =>
              (try
                @string.parse_int64(repr.unwrap_or(n.to_string()), base=10)
              catch {
                _ => None
              } noraise {
                n => Some(n)
              })
              is Some(_)
            _ => false
          }
        } else {
          v is String(_)
        }
        if !valid {
          let source_type = if v is Number(n, repr~) {
            "number " + repr.unwrap_or(n.to_string())
          } else {
            shellcheck_json_type(v)
          }
          invalid(
            output,
            "json: cannot unmarshal \{source_type} into Go struct field shellcheckError.\{name} of type \{if numeric { "int" } else { "string" }}",
          )
        }
      }
    }
    fn string_field(fields : Map[String, Json], name : String) -> String {
      match fields.get(name) {
        Some(String(s)) => s
        _ => ""
      }
    }
    diagnostics.push({
      code: shellcheck_int(fields.get("code").unwrap_or(Json::null())),
      line: shellcheck_int(fields.get("line").unwrap_or(Json::null())),
      column: shellcheck_int(fields.get("column").unwrap_or(Json::null())),
      level: string_field(fields, "level"),
      message: string_field(fields, "message"),
    })
  }
  diagnostics
}

///|
fn shellcheck_int(value : Json) -> Int64 {
  match value {
    Number(n, repr~) =>
      @string.parse_int64(repr.unwrap_or(n.to_string()), base=10) catch {
        _ => 0L
      }
    _ => 0L
  }
}
