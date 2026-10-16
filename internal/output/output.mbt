///|
fn display_width(s : StringView) -> Int32 {
  let mut width = 0
  for c in s {
    let n = c.to_int()
    if n < 32 ||
      n == 127 ||
      n
      is (0x300..<=0x36f
      | 0x200b..<=0x200f
      | 0xfe00..<=0xfe0f
      | 0x1f3fb..<=0x1f3ff) {
      continue
    }
    width += if n >= 0x1100 &&
      (
        n <= 0x115f ||
        n == 0x2329 ||
        n == 0x232a ||
        n
        is (0x2e80..<=0xa4cf
        | 0xac00..<=0xd7a3
        | 0xf900..<=0xfaff
        | 0xfe10..<=0xfe19
        | 0xfe30..<=0xfe6f
        | 0xff00..<=0xff60
        | 0xffe0..<=0xffe6
        | 0x1f300..<=0x1faff
        | 0x20000..<=0x3fffd)
      ) {
      2
    } else {
      1
    }
  }
  width
}

///|
fn snippet(error : @model.Diagnostic, source : String) -> (String, String) {
  let lines = source.split("\n").to_array()
  if error.line <= 0 || error.line > lines.length() {
    return ("", "")
  }
  // Match bufio.Scanner's default token limit used by the original formatter.
  for i in 0..<error.line {
    if @utf8.encode(lines[i]).length() >= 65536 {
      return ("", "")
    }
  }
  let line = lines[error.line - 1]
    .strip_suffix("\r")
    .unwrap_or(lines[error.line - 1])
  let bytes = @utf8.encode(line)
  if error.column <= 0 || error.column - 1 > bytes.length() {
    return (line.to_owned(), "")
  }
  let index = error.column - 1
  let width = display_width(@utf8.decode_lossy(bytes[:index])[:])
  let mut underline = 0
  for c in @utf8.decode_lossy(bytes[index:]) {
    if c is (' ' | '\t' | '\r' | '\n') {
      break
    }
    underline += display_width(c.to_string()[:])
  }
  (
    line.to_owned(),
    " ".repeat(width) + "^" + "~".repeat((underline - 1).max(0)),
  )
}

///|
pub fn diagnostic_json(
  error : @model.Diagnostic,
  file : String,
  source : String,
) -> Json {
  let (line, indicator) = snippet(error, source)
  let fields : Map[String, Json] = {
    "message": Json::string(error.message),
    "filepath": Json::string(file),
    "line": Json::number(error.line.to_double()),
    "column": Json::number(error.column.to_double()),
    "kind": Json::string(error.kind),
  }
  if line != "" {
    fields["snippet"] = Json::string(
      line + (if indicator == "" { "" } else { "\n" + indicator }),
    )
  }
  fields["end_column"] = Json::number(
    (if indicator == "" { error.column } else { indicator.length() }).to_double(),
  )
  Json::object(fields)
}

///|
pub fn render_diagnostic(
  error : @model.Diagnostic,
  file : String,
  source : String,
  oneline : Bool,
  color : Bool,
) -> String {
  fn paint(s : String, code : String, enabled : Bool) -> String {
    if enabled {
      "\u001b[" + code + "m" + s + "\u001b[0m"
    } else {
      s
    }
  }
  let gray = "90"
  let header = if color {
    paint(file, "33", true) +
    paint(":", gray, true) +
    "\{error.line}" +
    paint(":", gray, true) +
    "\{error.column}" +
    paint(": ", gray, true) +
    paint(error.message, "1", true) +
    paint(" [\{error.kind}]\n", gray, true)
  } else {
    error.oneline(file) + "\n"
  }
  if oneline || source == "" {
    return header
  }
  let (line, indicator) = snippet(error, source)
  if indicator == "" {
    return header
  }
  let prefix = "\{error.line} | "
  let indent = " ".repeat(prefix.length() - 2)
  header +
  paint(indent + "|\n", gray, color) +
  paint(prefix, gray, color) +
  line +
  "\n" +
  paint(indent + "| ", gray, color) +
  paint(indicator, "32", color) +
  "\n"
}
