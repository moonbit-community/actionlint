///|
pub fn parse_yaml_number(
  value : String,
  integer : Bool,
) -> Double raise @model.CliError {
  let function = if integer { "Atoi" } else { "ParseFloat" }
  fn invalid(
    value : String,
    function : String,
    reason : String,
  ) -> Unit raise @model.CliError {
    raise CliError(
      "strconv.\{function}: parsing \{@model.quote(value)}: \{reason}",
    )
  }
  if integer {
    if !@matching.regex_match("^[+-]?[0-9]+$", value) {
      invalid(value, function, "invalid syntax")
    }
    let number = @string.parse_int64(value, base=10) catch {
      _ => {
        invalid(value, function, "value out of range")
        return 0.0
      }
    }
    return number.to_double()
  }
  let number = @string.parse_double(value) catch {
    _ => {
      let numeric = @matching.regex_match(
        "^[+-]?([0-9]+(\\.[0-9]*)?|\\.[0-9]+)([eE][+-]?[0-9]+)?$",
        value.replace_all(old="_", new=""),
      )
      invalid(
        value,
        function,
        if numeric {
          "value out of range"
        } else {
          "invalid syntax"
        },
      )
      return 0.0
    }
  }
  // MoonBit accepts integer-style hexadecimal literals; strconv.ParseFloat
  // requires a binary exponent for hexadecimal floating-point literals.
  let lower = value.to_lower().trim_start(char_set="+-")
  if lower.has_prefix("0x") && !lower.contains("p") {
    invalid(value, function, "invalid syntax")
  }
  if number.is_inf() && !["inf", "infinity"].contains(lower.to_owned()) {
    invalid(value, function, "value out of range")
  }
  number
}

///|
fn yaml_timestamp(value : String) -> Bool {
  if !@matching.regex_match(
      "^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}([Tt ][0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}([.,][0-9]+)?(Z|[+-][0-9]{2}:[0-9]{2})?)?$",
      value,
    ) {
    return false
  }
  let date = value
    .split("T")
    .next()
    .unwrap_or("")
    .split("t")
    .next()
    .unwrap_or("")
    .split(" ")
    .next()
    .unwrap_or("")
  let parts = date.split("-").to_array()
  if parts.length() != 3 {
    return false
  }
  let year = @string.parse_int(parts[0], base=10) catch { _ => 0 }
  let month = @string.parse_int(parts[1], base=10) catch { _ => 0 }
  let day = @string.parse_int(parts[2], base=10) catch { _ => 0 }
  let length = if month == 2 {
    if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0) {
      29
    } else {
      28
    }
  } else if [4, 6, 9, 11].contains(month) {
    30
  } else {
    31
  }
  if month < 1 || month > 12 || day < 1 || day > length {
    return false
  }
  if date.length() == value.length() {
    return true
  }
  let mut time = value[date.length() + 1:]
  let utc = time.has_suffix("Z")
  let plus = time.find("+")
  let minus = time.find("-")
  let offset = match plus {
    Some(_) => plus
    None => minus
  }
  let zoned = utc || offset is Some(_)
  if (value[date.length()] == ' ') == zoned {
    return false
  }
  if utc {
    time = time[:time.length() - 1]
  }
  if offset is Some(at) {
    let zone = time[at + 1:].split(":").to_array()
    let hours = @string.parse_int(zone[0], base=10) catch { _ => 99 }
    let minutes = @string.parse_int(zone[1], base=10) catch { _ => 99 }
    if hours > 24 || minutes > 60 {
      return false
    }
    time = time[:at]
  }
  let fields = time.split(":").to_array()
  let hour = @string.parse_int(fields[0], base=10) catch { _ => 99 }
  let minute = @string.parse_int(fields[1], base=10) catch { _ => 99 }
  let second = @string.parse_int(
    fields[2].split(".").next().unwrap_or("").split(",").next().unwrap_or(""),
    base=10,
  ) catch {
    _ => 99
  }
  hour < 24 && minute < 60 && second < 60
}
