///|
priv struct Re2Parser {
  source : String
  mut offset : Int32
  mut flags : String
}

///|
fn re2_error(reason : String, fragment : String) -> Unit raise @model.CliError {
  raise CliError("error parsing regexp: \{reason}: `\{fragment}`")
}

///|
fn re2_literal(text : String) -> String {
  let out = StringBuilder()
  for c in text {
    if "\\.+*?()[]{}^$|".contains(c.to_string()) {
      out.write_char('\\')
    }
    out.write_char(c)
  }
  out.to_string()
}

///|
fn re2_ascii_class(name : String) -> String? {
  match name {
    "alnum" => Some("0-9A-Za-z")
    "alpha" => Some("A-Za-z")
    "ascii" => Some("\\u{0}-\\u{7f}")
    "blank" => Some("\\t ")
    "cntrl" => Some("\\u{0}-\\u{1f}\\u{7f}")
    "digit" => Some("0-9")
    "graph" => Some("!-~")
    "lower" => Some("a-z")
    "print" => Some(" -~")
    "punct" => Some("!-#%-/:-@\\[-`{-~\\$")
    "space" => Some("\\t\\n\\v\\f\\r ")
    "upper" => Some("A-Z")
    "word" => Some("0-9A-Z_a-z")
    "xdigit" => Some("0-9A-Fa-f")
    _ => None
  }
}

///|
fn Re2Parser::escape(
  self : Re2Parser,
  in_class : Bool,
) -> String raise @model.CliError {
  let start = self.offset
  self.offset += 1
  if self.offset >= self.source.length() {
    raise CliError(
      "error parsing regexp: trailing backslash at end of expression: ``",
    )
  }
  let c = self.source[self.offset]
  self.offset += 1
  match c {
    'A' | 'z' if !in_class => if c == 'A' { "(?-m:^)" } else { "(?-m:$)" }
    'b' | 'B' if !in_class => self.source[start:self.offset].to_owned()
    'a' => "\\u{7}"
    'f' | 't' | 'n' | 'r' | 'v' => self.source[start:self.offset].to_owned()
    'd' => "[0-9]"
    'D' => "[^0-9]"
    'w' => "[0-9A-Z_a-z]"
    'W' => "[^0-9A-Z_a-z]"
    's' => "[\\t\\n\\f\\r ]"
    'S' => "[^\\t\\n\\f\\r ]"
    'p' | 'P' => {
      let name = if self.offset < self.source.length() &&
        self.source[self.offset] == '{' {
        self.offset += 1
        let at = self.offset
        guard self.source[at:].find("}") is Some(end) else {
          re2_error(
            "invalid character class range",
            self.source[start:].to_owned(),
          )
          return ""
        }
        self.offset += end + 1
        self.source[at:self.offset - 1].to_owned()
      } else {
        let at = self.offset
        if self.offset < self.source.length() {
          self.offset += 1
        }
        self.source[at:self.offset].to_owned()
      }
      let negated = (c == 'P') != name.has_prefix("^")
      let name = name.strip_prefix("^").unwrap_or(name[:]).to_owned()
      let ranges = if name == "Any" {
        Some("\\u{0}-\\u{10ffff}")
      } else {
        re2_unicode_ranges.get(name)
      }
      guard ranges is Some(ranges) else {
        re2_error(
          "invalid character class range",
          self.source[start:self.offset].to_owned(),
        )
        return ""
      }
      "[" + (if negated { "^" } else { "" }) + ranges + "]"
    }
    'x' => {
      let braced = self.offset < self.source.length() &&
        self.source[self.offset] == '{'
      if braced {
        self.offset += 1
      }
      let at = self.offset
      while self.offset < self.source.length() &&
            self.source[self.offset] is ('0'..<='9' | 'a'..<='f' | 'A'..<='F') &&
            (braced || self.offset - at < 2) {
        self.offset += 1
      }
      let digits = self.source[at:self.offset]
      let code = @string.parse_int(digits, base=16) catch { _ => -1 }
      if code < 0 ||
        code > 0x10ffff ||
        (!braced && digits.length() != 2) ||
        (
          braced &&
          (
            self.offset >= self.source.length() ||
            self.source[self.offset] != '}'
          )
        ) {
        re2_error(
          "invalid escape sequence",
          self.source[start:self.offset].to_owned(),
        )
      }
      if braced {
        self.offset += 1
      }
      "\\u{" + code.to_string(radix=16) + "}"
    }
    '0'..<='7' => {
      let at = self.offset - 1
      while self.offset < self.source.length() &&
            self.offset - at < 3 &&
            self.source[self.offset] is ('0'..<='7') {
        self.offset += 1
      }
      if c != '0' && self.offset - at == 1 {
        re2_error(
          "invalid escape sequence",
          self.source[start:self.offset].to_owned(),
        )
      }
      let code = @string.parse_int(self.source[at:self.offset], base=8) catch {
        _ => 0
      }
      "\\u{" + code.to_string(radix=16) + "}"
    }
    _ => {
      if c is ('a'..<='z' | 'A'..<='Z' | '0'..<='9') {
        re2_error(
          "invalid escape sequence",
          self.source[start:self.offset].to_owned(),
        )
      }
      re2_literal(self.source[self.offset - 1:self.offset].to_owned())
    }
  }
}

///|
fn Re2Parser::character_class(self : Re2Parser) -> String raise @model.CliError {
  let start = self.offset
  self.offset += 1
  let out = StringBuilder()
  out.write_char('[')
  if self.offset < self.source.length() && self.source[self.offset] == '^' {
    out.write_char('^')
    self.offset += 1
  }
  let mut first = true
  let mut range_start = 0
  let mut previous : Int32? = None
  while self.offset < self.source.length() {
    let c = self.source[self.offset]
    if c == ']' && !first {
      self.offset += 1
      out.write_char(']')
      return out.to_string()
    }
    if c == '-' &&
      previous is Some(low) &&
      self.offset + 1 < self.source.length() &&
      self.source[self.offset + 1] != ']' &&
      self.source[self.offset + 1] != '\\' {
      let high = self.source.get_char(self.offset + 1).unwrap().to_int()
      if high < low {
        re2_error(
          "invalid character class range",
          self.source[range_start:self.offset + 2].to_owned(),
        )
      }
      previous = None
      out.write_char('-')
      let endpoint = self.source.get_char(self.offset + 1).unwrap()
      out.write_char(endpoint)
      self.offset += 1 + (if endpoint.to_int() > 0xffff { 2 } else { 1 })
      first = false
      continue
    } else {
      range_start = self.offset
      previous = if c == '\\' || c == '[' {
        None
      } else {
        Some(self.source.get_char(self.offset).unwrap().to_int())
      }
    }
    if c == '[' && self.source[self.offset:].has_prefix("[:") {
      let at = self.offset
      guard self.source[at + 2:].find(":]") is Some(end) else {
        re2_error("invalid character class range", self.source[at:].to_owned())
        return ""
      }
      let name = self.source[at + 2:at + 2 + end].to_owned()
      self.offset = at + 4 + end
      guard re2_ascii_class(
          name.strip_prefix("^").unwrap_or(name[:]).to_owned(),
        )
        is Some(ranges) else {
        re2_error(
          "invalid character class range",
          self.source[at:self.offset].to_owned(),
        )
        return ""
      }
      out.write_string(
        if name.has_prefix("^") {
          re2_complement(ranges)
        } else {
          ranges
        },
      )
    } else if c == '\\' {
      let escaped = self.escape(true)
      if escaped.has_prefix("[") {
        if escaped.has_prefix("[^") {
          // Expand a complemented class before embedding it in another class.
          out.write_string(
            re2_complement(escaped[2:escaped.length() - 1].to_owned()),
          )
        } else {
          out.write_view(escaped[1:escaped.length() - 1])
        }
      } else {
        out.write_string(escaped)
      }
    } else {
      if c == '[' || c == ']' {
        out.write_char('\\')
      }
      out.write_char(self.source.get_char(self.offset).unwrap())
      self.offset += if self.source.get_char(self.offset).unwrap().to_int() >
        0xffff {
        2
      } else {
        1
      }
    }
    first = false
  }
  re2_error("missing closing ]", self.source[start:].to_owned())
  ""
}

///|
fn re2_complement(ranges : String) -> String {
  fn rune(source : String, offset : Int32) -> (Int32, Int32) {
    if source[offset] != '\\' {
      let c = source.get_char(offset).unwrap()
      return (c.to_int(), offset + (if c.to_int() > 0xffff { 2 } else { 1 }))
    }
    if source[offset + 1] == 'u' && source[offset + 2] == '{' {
      let end = offset + 3 + source[offset + 3:].find("}").unwrap_or(0)
      return (
        @string.parse_int(source[offset + 3:end], base=16) catch {
          _ => 0
        },
        end + 1,
      )
    }
    let c = source[offset + 1]
    (
      match c {
        't' => 9
        'n' => 10
        'v' => 11
        'f' => 12
        'r' => 13
        _ => c.to_int()
      },
      offset + 2,
    )
  }
  let intervals : Array[(Int32, Int32)] = []
  for i = 0; i < ranges.length(); {
    let (low, next) = rune(ranges, i)
    if next < ranges.length() &&
      ranges[next] == '-' &&
      next + 1 < ranges.length() {
      let (high, end) = rune(ranges, next + 1)
      intervals.push((low, high))
      continue end
    }
    intervals.push((low, low))
    continue next
  }
  intervals.sort_by((a, b) => a.0.compare(b.0))
  let out = StringBuilder()
  let mut cursor = 0
  fn append_range(out : StringBuilder, low : Int32, high : Int32) -> Unit {
    out.write_string("\\u{" + low.to_string(radix=16) + "}")
    if high != low {
      out.write_string("-\\u{" + high.to_string(radix=16) + "}")
    }
  }
  for (low, high) in intervals {
    if low > cursor {
      append_range(out, cursor, low - 1)
    }
    cursor = cursor.max(high + 1)
  }
  if cursor <= 0x10ffff {
    append_range(out, cursor, 0x10ffff)
  }
  out.to_string()
}

///|
fn Re2Parser::group(
  self : Re2Parser,
  nested : Bool,
) -> String raise @model.CliError {
  let out = StringBuilder()
  let mut has_atom = false
  let mut repeated = false
  while self.offset < self.source.length() {
    let start = self.offset
    let c = self.source[self.offset]
    if c == ')' {
      if !nested {
        re2_error("unexpected )", self.source)
      }
      self.offset += 1
      return out.to_string()
    }
    if c == '|' {
      out.write_char('|')
      self.offset += 1
      has_atom = false
      repeated = false
      continue
    }
    if c == '(' &&
      self.source[self.offset:].has_prefix("(?") &&
      !(self.source[self.offset:].has_prefix("(?P<") ||
      self.source[self.offset:].has_prefix("(?<")) {
      self.offset += 2
      let mut flags = self.flags
      let mut remove = false
      let mut valid = false
      while self.offset < self.source.length() {
        let flag = self.source.get_char(self.offset).unwrap()
        if flag == '-' {
          remove = true
          self.offset += 1
          continue
        }
        if !(flag is ('i' | 'm' | 's' | 'U')) {
          break
        }
        valid = true
        flags = flags.replace_all(old=flag.to_string(), new="")
        if !remove {
          flags += flag.to_string()
        }
        self.offset += 1
      }
      if self.offset < self.source.length() &&
        self.source[self.offset] == ')' &&
        valid {
        self.flags = flags
        self.offset += 1
        continue
      }
      if self.offset >= self.source.length() || self.source[self.offset] != ':' {
        let end = (self.offset + 1).min(self.source.length())
        re2_error(
          "invalid or unsupported Perl syntax",
          self.source[start:end].to_owned(),
        )
      }
      self.offset += 1
      let previous = self.flags
      self.flags = flags
      let inner = self.group(true)
      self.flags = previous
      out.write_string("(?:" + inner + ")")
      has_atom = true
      repeated = false
      continue
    }
    if c is ('*' | '+' | '?') || c == '{' {
      let mut quantifier = ""
      if c == '{' {
        if self.source[start:].find("}") is Some(end) {
          let text = self.source[start + 1:start + end]
          let counts = text.split(",").to_array()
          let valid = counts.length() <= 2 &&
            counts[0] != "" &&
            counts
            .iter()
            .all(s => {
              (s == "" || s == "0" || !s.has_prefix("0")) &&
              s.iter().all(c => c is ('0'..<='9'))
            })
          if valid {
            quantifier = self.source[start:start + end + 1].to_owned()
          }
        }
      } else {
        quantifier = c.to_int().unsafe_to_char().to_string()
      }
      if quantifier != "" {
        self.offset += quantifier.length()
        if !has_atom {
          re2_error("missing argument to repetition operator", quantifier)
        }
        if repeated {
          re2_error("invalid nested repetition operator", quantifier)
        }
        let reluctant = self.offset < self.source.length() &&
          self.source[self.offset] == '?'
        if reluctant {
          self.offset += 1
        }
        out.write_string(quantifier)
        if reluctant != self.flags.contains("U") {
          out.write_char('?')
        }
        repeated = true
        continue
      }
    }
    let atom = if c == '[' {
      self.character_class()
    } else if c == '\\' && self.source[start:].has_prefix("\\Q") {
      self.offset += 2
      let end = self.source[self.offset:].find("\\E")
      let stop = self.offset + end.unwrap_or(self.source.length() - self.offset)
      let characters = self.source[self.offset:stop].to_owned().to_array()
      self.offset = if end is Some(_) { stop + 2 } else { stop }
      if characters.is_empty() {
        continue
      }
      let flags = self.flags.replace_all(old="U", new="")
      for character in characters[:characters.length() - 1] {
        let literal = re2_literal(character.to_string())
        out.write_string(
          if flags == "" {
            literal
          } else {
            "(?" + flags + ":" + literal + ")"
          },
        )
      }
      re2_literal(characters[characters.length() - 1].to_string())
    } else if c == '\\' {
      self.escape(false)
    } else if c == '(' {
      self.offset += 1
      if self.source[self.offset:].has_prefix("?P<") ||
        self.source[self.offset:].has_prefix("?<") {
        let skip = if self.source[self.offset:].has_prefix("?P<") {
          3
        } else {
          2
        }
        let at = self.offset + skip
        guard self.source[at:].find(">") is Some(end) else {
          re2_error("invalid named capture", self.source[start:].to_owned())
          return ""
        }
        let name = self.source[at:at + end]
        if name == "" ||
          !name
          .iter()
          .all(c => c is ('a'..<='z' | 'A'..<='Z' | '0'..<='9' | '_')) {
          re2_error(
            "invalid named capture",
            self.source[start:at + end + 1].to_owned(),
          )
        }
        self.offset = at + end + 1
      }
      let flags = self.flags
      let inner = self.group(true)
      self.flags = flags
      "(" + inner + ")"
    } else {
      let ch = self.source.get_char(self.offset).unwrap()
      self.offset += if ch.to_int() > 0xffff { 2 } else { 1 }
      if c == '{' || c == '}' || c == ']' {
        re2_literal(ch.to_string())
      } else {
        ch.to_string()
      }
    }
    let flags = self.flags.replace_all(old="U", new="")
    out.write_string(
      if flags == "" {
        atom
      } else {
        "(?" + flags + ":" + atom + ")"
      },
    )
    has_atom = true
    repeated = false
  }
  if nested {
    re2_error("missing closing )", self.source)
  }
  out.to_string()
}

///|
fn re2_translate(source : String) -> String raise @model.CliError {
  Re2Parser::{ source, offset: 0, flags: "", }.group(false)
}
