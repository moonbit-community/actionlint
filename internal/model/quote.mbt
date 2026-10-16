///|
fn go_escape(c : Char, quote : Char, ascii : Bool) -> String {
  match c {
    '\u0007' => "\\a"
    '\b' => "\\b"
    '\f' => "\\f"
    '\n' => "\\n"
    '\r' => "\\r"
    '\t' => "\\t"
    '\u000b' => "\\v"
    '\\' => "\\\\"
    _ => {
      if c == quote {
        return "\\" + c.to_string()
      }
      let n = c.to_int()
      if n < 32 || n == 127 {
        let digits = n.to_string(radix=16)
        return "\\x" + "0".repeat(2 - digits.length()) + digits
      }
      if (ascii && n > 127) || !go_printable(n) {
        let digits = n.to_string(radix=16)
        let width = if n > 0xffff { 8 } else { 4 }
        return (if width == 8 { "\\U" } else { "\\u" }) +
          "0".repeat(width - digits.length()) +
          digits
      }
      c.to_string()
    }
  }
}

///|
pub fn char_quote(c : Char, ascii~ : Bool = false) -> String {
  "'" + go_escape(c, '\'', ascii) + "'"
}

///|
pub fn string_quote(s : String, ascii~ : Bool = false) -> String {
  "\"" + s.iter().map(c => go_escape(c, '"', ascii)).to_array().join("") + "\""
}
