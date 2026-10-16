///|
// Specifiers are committed only after the run of closing braces ends. Odd
// runs close a placeholder; even runs escape it. Match strconv.Atoi's 64-bit
// saturation on overflow without trapping on either backend.
fn format_placeholders(format : String) -> Map[Int64, Bool] {
  let used : Map[Int64, Bool] = Map([])
  let mut start = -1
  let mut end = -1
  fn record(used : Map[Int64, Bool], text : StringView) -> Unit {
    let index = @string.parse_int64(text, base=10) catch {
      _ => 9223372036854775807L
    }
    used[index] = true
  }
  for i in 0..<format.length() {
    let c = format[i]
    if start == -1 {
      if c == '{' {
        start = i + 1
      }
    } else if end == -1 {
      if c == '{' && i == start {
        start = -1
      } else if c == '}' {
        if i == start {
          start = -1
        } else {
          end = i
        }
      } else if !(c is ('0'..<='9')) {
        start = if c == '{' { i + 1 } else { -1 }
      }
    } else if c != '}' {
      if (i - end) % 2 == 1 {
        record(used, format[start:end])
      }
      start = if c == '{' { i + 1 } else { -1 }
      end = -1
    }
  }
  if start > -1 && end > -1 && (format.length() - end) % 2 == 1 {
    record(used, format[start:end])
  }
  used
}
