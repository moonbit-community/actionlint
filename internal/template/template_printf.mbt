///|
fn template_printf(args : Array[TemplateValue]) -> Bytes {
  let format = args.get(0).map(template_value_string).unwrap_or("")
  let out = @buffer.Buffer()
  let mut i = 0
  let mut argument = 1
  let mut indexed = false
  while i < format.length() {
    if format[i] != '%' {
      let c = format.get_char(i).unwrap_or(' ')
      out.write_char_utf8(c)
      i += if c.to_int() > 0xffff { 2 } else { 1 }
      continue
    }
    i += 1
    if i < format.length() && format[i] == '%' {
      out.write_char_utf8('%')
      i += 1
      continue
    }
    let start = i
    while i < format.length() && format[i] is ('-' | '+' | ' ' | '#' | '0') {
      i += 1
    }
    let mut flags = format[start:i].to_owned()
    let mut bad_index = false
    let mut reordered = false
    if i < format.length() && format[i] == '[' {
      let (next, index) = template_argument_index(format, i)
      i = next
      argument = index
      bad_index = index <= 0 || index >= args.length()
      reordered = true
      indexed = true
    }
    let mut width = 0
    let mut bad_width = false
    if i < format.length() && format[i] == '*' {
      i += 1
      match args.get(argument) {
        Some(Integer(n)) if n > -1000000L && n < 1000000L => {
          width = n.to_int().abs()
          if n < 0L {
            flags += "-"
          }
        }
        _ => bad_width = true
      }
      if argument < args.length() {
        argument += 1
      }
      reordered = false
    } else {
      let at = i
      while i < format.length() && format[i] is ('0'..<='9') {
        i += 1
      }
      if reordered && i > at {
        bad_index = true
      }
      if i > at {
        width = @string.parse_int(format[at:i]) catch { _ => 0 }
      }
    }
    let mut precision : Int32? = None
    let mut bad_precision = false
    if i < format.length() && format[i] == '.' {
      i += 1
      if i < format.length() && format[i] == '[' {
        let (next, index) = template_argument_index(format, i)
        i = next
        argument = index
        indexed = true
        bad_index = index <= 0 || index >= args.length()
      }
      if i < format.length() && format[i] == '*' {
        i += 1
        match args.get(argument) {
          Some(Integer(n)) if n >= 0L && n < 1000000L =>
            precision = Some(n.to_int())
          _ => bad_precision = true
        }
        if argument < args.length() {
          argument += 1
        }
      } else {
        let at = i
        while i < format.length() && format[i] is ('0'..<='9') {
          i += 1
        }
        precision = Some(@string.parse_int(format[at:i]) catch { _ => 0 })
      }
      reordered = false
    }
    if !reordered && i < format.length() && format[i] == '[' {
      let (next, index) = template_argument_index(format, i)
      i = next
      argument = index
      indexed = true
      bad_index = index <= 0 || index >= args.length()
    }
    if bad_width {
      out.write_string_utf8("%!(BADWIDTH)")
    }
    if bad_precision {
      out.write_string_utf8("%!(BADPREC)")
    }
    if i >= format.length() {
      out.write_string_utf8("%!(NOVERB)")
      break
    }
    let verb = format[i]
    i += 1
    if verb == '%' {
      out.write_char_utf8('%')
      continue
    }
    if bad_index {
      out.write_string_utf8(
        "%!" + verb.to_int().unsafe_to_char().to_string() + "(BADINDEX)",
      )
      continue
    }
    guard args.get(argument) is Some(value) else {
      out.write_string_utf8(
        "%!" + verb.to_int().unsafe_to_char().to_string() + "(MISSING)",
      )
      continue
    }
    argument += 1
    let type_name = template_type(value)
    let verb_text = verb.to_int().unsafe_to_char().to_string()
    if verb == 'T' {
      out.write_string_utf8(type_name)
      continue
    }
    let valid = match verb {
      'v' => true
      's' => value is (Text(_) | RawText(_))
      'q' => value is (Text(_) | RawText(_) | Integer(_))
      'x' | 'X' => value is (Integer(_) | Text(_) | RawText(_))
      'd' | 'b' | 'o' | 'O' | 'c' | 'U' => value is Integer(_)
      'f' | 'F' | 'e' | 'E' | 'g' | 'G' => value is Floating(_)
      't' => value is Boolean(_)
      _ => false
    }
    if !valid {
      out.write_string_utf8(
        "%!" +
        verb_text +
        "(" +
        template_bad_operand(value, flags, width, precision) +
        ")",
      )
      continue
    }
    if value is RawText(bytes) &&
      (verb == 's' || (verb == 'v' && !flags.contains("#"))) {
      let bytes = if precision is Some(count) {
        template_truncate_bytes(bytes, count)
      } else {
        bytes
      }
      let padding = (width - @utf8.decode_lossy(bytes).iter().count()).max(0)
      if !flags.contains("-") {
        out.write_string_utf8(
          (if flags.contains("0") { "0" } else { " " }).repeat(padding),
        )
      }
      out.write_bytes(bytes)
      if flags.contains("-") {
        out.write_string_utf8(" ".repeat(padding))
      }
      continue
    }
    let mut rendered = if value is (Missing | Nil) {
      "<nil>"
    } else if verb == 'v' && flags.contains("#") && value is Text(text) {
      @model.quote(text)
    } else if verb == 'q' {
      let text = template_value_string(value)
      if flags.contains("#") &&
        text
        .iter()
        .all(c => {
          (c >= ' ' || c == '\t') && c != '\u007f' && c != '`' && c != '\ufeff'
        }) {
        "`" + text + "`"
      } else {
        @model.string_quote(text, ascii=flags.contains("+"))
      }
    } else {
      template_value_string(value)
    }
    let integer = verb is ('d' | 'b' | 'o' | 'O' | 'x' | 'X') &&
      value is Integer(_)
    if integer && value is Integer(number) {
      let base = match verb {
        'b' => 2
        'o' | 'O' => 8
        'x' | 'X' => 16
        _ => 10
      }
      rendered = number.to_string(radix=base)
      if verb == 'X' {
        rendered = rendered.to_upper()
      }
      if precision is Some(digits) {
        let negative = rendered.has_prefix("-")
        let magnitude = if negative {
          rendered[1:].to_owned()
        } else {
          rendered
        }
        rendered = (if negative { "-" } else { "" }) +
          "0".repeat((digits - magnitude.length()).max(0)) +
          magnitude
        if digits == 0 && number == 0L {
          rendered = ""
        }
      }
    } else if value is Floating(number) {
      rendered = template_float(number, verb, precision, flags.contains("#"))
    } else if (verb == 's' || verb == 'q') &&
      precision is Some(length) &&
      value is Text(text) {
      let shortened = text
        .iter()
        .take(length)
        .map(c => c.to_string())
        .to_array()
        .join("")
      rendered = if verb == 'q' {
        if flags.contains("#") && template_can_backquote(shortened) {
          "`" + shortened + "`"
        } else {
          @model.string_quote(shortened, ascii=flags.contains("+"))
        }
      } else {
        shortened
      }
    }
    if integer && rendered != "" && (flags.contains("#") || verb == 'O') {
      let prefix = match verb {
        'b' => "0b"
        'x' => "0x"
        'X' => "0X"
        'O' =>
          if flags.contains("#") &&
            !(rendered.has_prefix("0") || rendered.has_prefix("-0")) {
            "0o0"
          } else {
            "0o"
          }
        'o' => if rendered.has_prefix("0") { "" } else { "0" }
        _ => ""
      }
      rendered = if rendered.has_prefix("-") {
        "-" + prefix + rendered[1:].to_owned()
      } else {
        prefix + rendered
      }
    }
    if value is Integer(number) {
      if verb == 'c' {
        rendered = if number >= 0L &&
          number <= 0x10ffffL &&
          !(number >= 0xd800L && number <= 0xdfffL) {
          number.to_int().unsafe_to_char().to_string()
        } else {
          "�"
        }
      }
      if verb == 'q' {
        let c = if number >= 0L &&
          number <= 0x10ffffL &&
          !(number >= 0xd800L && number <= 0xdfffL) {
          number.to_int().unsafe_to_char()
        } else {
          '�'
        }
        rendered = @model.char_quote(c, ascii=flags.contains("+"))
      }
      if verb == 'U' {
        let digits = number.to_string(radix=16).to_upper()
        rendered = "U+" + "0".repeat((4 - digits.length()).max(0)) + digits
        if flags.contains("#") &&
          number >= 0L &&
          number <= 0x10ffffL &&
          !(number >= 0xd800L && number <= 0xdfffL) {
          let c = number.to_int().unsafe_to_char()
          let quoted = @model.char_quote(c)
          if c is ('\'' | '\\') || !quoted.has_prefix("'\\") {
            rendered += " " + quoted
          }
        }
      }
    }
    if (verb == 'x' || verb == 'X') && value is (Text(_) | RawText(_)) {
      let bytes = template_value_bytes(value)
      let count = precision.unwrap_or(bytes.length()).min(bytes.length())
      let prefix = if verb == 'X' { "0X" } else { "0x" }
      let digits = bytes[:count]
        .iter()
        .map(b => {
          let s = b.to_int().to_string(radix=16)
          let s = "0".repeat(2 - s.length()) + s
          if verb == 'X' {
            s.to_upper()
          } else {
            s
          }
        })
        .to_array()
      rendered = if flags.contains(" ") {
        digits
        .map(s => (if flags.contains("#") { prefix } else { "" }) + s)
        .join(" ")
      } else {
        (if flags.contains("#") && count > 0 { prefix } else { "" }) +
        digits.join("")
      }
    }
    if verb == 'v' && value is Record(m, ty) && ty.has_prefix("*") {
      rendered = template_struct(
        m,
        ty,
        flags.contains("+"),
        flags.contains("#"),
      )
    }
    let numeric = integer || value is Floating(_)
    if numeric && !rendered.has_prefix("-") {
      if flags.contains("+") {
        rendered = "+" + rendered
      } else if flags.contains(" ") {
        rendered = " " + rendered
      }
    }
    let prefix_width = if integer &&
      flags.contains("#") &&
      verb is ('x' | 'X' | 'b') {
      2
    } else if integer && verb == 'O' {
      if flags.contains("#") {
        3
      } else {
        2
      }
    } else {
      0
    }
    let padding = (width.min(1000000) -
    rendered.iter().count() +
    (if flags.contains("0") && precision is None { prefix_width } else { 0 })).max(
      0,
    )
    if flags.contains("-") {
      out.write_string_utf8(rendered + " ".repeat(padding))
    } else if flags.contains("0") && !(integer && precision is Some(_)) {
      if integer && prefix_width > 0 {
        let sign_width = if rendered.has_prefix("-") ||
          rendered.has_prefix("+") ||
          rendered.has_prefix(" ") {
          1
        } else {
          0
        }
        let at = sign_width + prefix_width
        out.write_string_utf8(rendered[:at])
        out.write_string_utf8("0".repeat(padding))
        out.write_string_utf8(rendered[at:])
      } else if numeric &&
        (
          rendered.has_prefix("-") ||
          rendered.has_prefix("+") ||
          rendered.has_prefix(" ")
        ) {
        out.write_string_utf8(rendered[:1])
        out.write_string_utf8("0".repeat(padding))
        out.write_string_utf8(rendered[1:])
      } else {
        out.write_string_utf8("0".repeat(padding) + rendered)
      }
    } else {
      out.write_string_utf8(" ".repeat(padding) + rendered)
    }
  }
  if !indexed && argument < args.length() {
    out.write_string_utf8(
      "%!(EXTRA " +
      args[argument:].map(template_format_operand).join(", ") +
      ")",
    )
  }
  out.to_bytes()
}

///|
fn template_format_operand(value : TemplateValue) -> String {
  match value {
    Missing | Nil => "<nil>"
    _ => template_type(value) + "=" + template_value_string(value)
  }
}

///|
fn template_argument_index(format : String, start : Int32) -> (Int32, Int32) {
  if format[start + 1:].find("]") is Some(length) {
    let end = start + 1 + length
    (end + 1, @string.parse_int(format[start + 1:end]) catch { _ => 0 })
  } else {
    (start + 1, 0)
  }
}

///|
fn template_struct(
  fields : Map[String, TemplateValue],
  ty : String,
  names : Bool,
  go : Bool,
) -> String {
  let keys = if ty == "*actionlint.ErrorTemplateFields" {
    [
      ("Message", "message"),
      ("Filepath", "filepath"),
      ("Line", "line"),
      ("Column", "column"),
      ("Kind", "kind"),
      ("Snippet", "snippet"),
      ("EndColumn", "end_column"),
    ]
  } else {
    [("Name", "Name"), ("Description", "Description")]
  }
  let values = keys.map(pair => {
    let value = fields
      .get(pair.1)
      .unwrap_or(
        if ["Line", "Column", "EndColumn"].contains(pair.0) {
          Integer(0L)
        } else {
          Text("")
        },
      )
    (if names || go { pair.0 + ":" } else { "" }) +
    (if go && value is Text(text) {
      @model.quote(text)
    } else {
      template_value_string(value)
    })
  })
  "&" +
  (if go { ty[1:].to_owned() } else { "" }) +
  "{" +
  values.join(if go { ", " } else { " " }) +
  "}"
}

///|
fn template_truncate_bytes(bytes : Bytes, count : Int32) -> Bytes {
  let mut end = 0
  let mut runes = 0
  while end < bytes.length() && runes < count {
    let n = bytes[end].to_int()
    let width = if n < 0x80 {
      1
    } else if n < 0xe0 {
      2
    } else if n < 0xf0 {
      3
    } else {
      4
    }
    // Invalid UTF-8 bytes each count as one rune, as in Go range.
    let chunk = bytes[end:(end + width).min(bytes.length())]
    end += if (@utf8.decode(chunk) catch { _ => "" }) != "" { width } else { 1 }
    runes += 1
  }
  bytes[:end].to_owned()
}

///|
fn template_bad_operand(
  value : TemplateValue,
  flags : String,
  width : Int32,
  precision : Int32?,
) -> String {
  if value is (Missing | Nil) {
    return "<nil>"
  }
  let verb = match value {
    Integer(_) => "d"
    Floating(_) => "g"
    Text(_) | RawText(_) => "s"
    Boolean(_) => "t"
    _ => "v"
  }
  let format = "%" +
    flags +
    (if width > 0 { width.to_string() } else { "" }) +
    precision.map(p => "." + p.to_string()).unwrap_or("") +
    verb
  template_type(value) +
  "=" +
  @utf8.decode_lossy(template_printf([Text(format), value]))
}

///|
fn template_can_backquote(text : String) -> Bool {
  text
  .iter()
  .all(c => {
    (c >= ' ' || c == '\t') && c != '\u007f' && c != '`' && c != '\ufeff'
  })
}
