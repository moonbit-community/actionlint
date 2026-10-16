///|
priv struct JsonValidator {
  source : String
  mut offset : Int32
}

///|
priv suberror JsonSyntax {
  JsonSyntax(Int32, String)
}

///|
fn JsonValidator::space(self : JsonValidator) -> Unit {
  while self.offset < self.source.length() &&
        self.source[self.offset] is (' ' | '\t' | '\n' | '\r') {
    self.offset += 1
  }
}

///|
fn JsonValidator::invalid(
  self : JsonValidator,
  context : String,
) -> Unit raise JsonSyntax {
  if self.offset >= self.source.length() {
    raise JsonSyntax(
      @utf8.encode(self.source).length(),
      "unexpected end of JSON input",
    )
  }
  let character = self.source.get_char(self.offset).unwrap_or(' ')
  raise JsonSyntax(
    @utf8.encode(self.source[:self.offset + 1]).length(),
    "invalid character \{@model.char_quote(character)} \{context}",
  )
}

///|
fn JsonValidator::string(self : JsonValidator) -> Unit raise JsonSyntax {
  self.offset += 1
  while self.offset < self.source.length() {
    let c = self.source[self.offset]
    if c == '"' {
      self.offset += 1
      return
    }
    if c < 32 {
      self.invalid("in string literal")
    }
    if c == '\\' {
      self.offset += 1
      if self.offset >= self.source.length() {
        self.invalid("")
      }
      if self.source[self.offset] == 'u' {
        for _ in 0..<4 {
          self.offset += 1
          if self.offset >= self.source.length() {
            self.invalid("")
          }
          if !(self.source[self.offset]
            is ('0'..<='9' | 'a'..<='f' | 'A'..<='F')) {
            self.invalid("in \\u hexadecimal character escape")
          }
        }
      } else if !(self.source[self.offset]
        is ('"' | '\\' | '/' | 'b' | 'f' | 'n' | 'r' | 't')) {
        self.invalid("in string escape code")
      }
    }
    self.offset += 1
  }
  self.invalid("")
}

///|
fn JsonValidator::value(self : JsonValidator) -> Unit raise JsonSyntax {
  self.space()
  if self.offset >= self.source.length() {
    self.invalid("")
  }
  let c = self.source[self.offset]
  if c == '"' {
    self.string()
    return
  }
  if c == '{' || c == '[' {
    let object_ = c == '{'
    let close : UInt16 = if object_ { '}' } else { ']' }
    self.offset += 1
    self.space()
    if self.offset >= self.source.length() {
      self.invalid("")
    }
    if self.source[self.offset] == close {
      self.offset += 1
      return
    }
    while true {
      self.space()
      if object_ {
        if self.offset >= self.source.length() ||
          self.source[self.offset] != '"' {
          self.invalid("looking for beginning of object key string")
        }
        self.string()
        self.space()
        if self.offset >= self.source.length() ||
          self.source[self.offset] != ':' {
          self.invalid("after object key")
        }
        self.offset += 1
      }
      self.value()
      self.space()
      if self.offset >= self.source.length() {
        self.invalid("")
      }
      if self.source[self.offset] == close {
        self.offset += 1
        return
      }
      if self.source[self.offset] != ',' {
        self.invalid(
          if object_ {
            "after object key:value pair"
          } else {
            "after array element"
          },
        )
      }
      self.offset += 1
    }
  }
  if c is ('t' | 'f' | 'n') {
    let literal = if c == 't' {
      "true"
    } else if c == 'f' {
      "false"
    } else {
      "null"
    }
    for i in 0..<literal.length() {
      if self.offset >= self.source.length() {
        self.invalid("")
      }
      if self.source[self.offset] != literal[i] {
        self.invalid(
          "in literal \{literal} (expecting '\{literal.get_char(i).unwrap_or(' ')}')",
        )
      }
      self.offset += 1
    }
    return
  }
  if c == '-' || c is ('0'..<='9') {
    if c == '-' {
      self.offset += 1
      if self.offset >= self.source.length() {
        self.invalid("")
      }
      if !(self.source[self.offset] is ('0'..<='9')) {
        self.invalid("in numeric literal")
      }
    }
    if self.source[self.offset] == '0' {
      self.offset += 1
    } else {
      while self.offset < self.source.length() &&
            self.source[self.offset] is ('0'..<='9') {
        self.offset += 1
      }
    }
    if self.offset < self.source.length() && self.source[self.offset] == '.' {
      self.offset += 1
      if self.offset >= self.source.length() ||
        !(self.source[self.offset] is ('0'..<='9')) {
        self.invalid("after decimal point in numeric literal")
      }
      while self.offset < self.source.length() &&
            self.source[self.offset] is ('0'..<='9') {
        self.offset += 1
      }
    }
    if self.offset < self.source.length() &&
      self.source[self.offset] is ('e' | 'E') {
      self.offset += 1
      if self.offset < self.source.length() &&
        self.source[self.offset] is ('+' | '-') {
        self.offset += 1
      }
      if self.offset >= self.source.length() ||
        !(self.source[self.offset] is ('0'..<='9')) {
        self.invalid("in exponent of numeric literal")
      }
      while self.offset < self.source.length() &&
            self.source[self.offset] is ('0'..<='9') {
        self.offset += 1
      }
    }
    return
  }
  self.invalid("looking for beginning of value")
}

///|
pub fn json_syntax_error(source : String) -> (Int32, String) {
  let validator = JsonValidator::{ source, offset: 0, }
  try {
    validator.value()
    validator.space()
    if validator.offset < source.length() {
      validator.invalid("after top-level value")
    }
    (@utf8.encode(source).length(), "unexpected end of JSON input")
  } catch {
    JsonSyntax(offset, message) => (offset, message)
  }
}

///|
// Preserve numeric tokens for typed protocol decoders. Json.parse normally
// normalizes small numbers, losing the distinction between 1, 1.0 and 1e0.
fn JsonValidator::decode(self : JsonValidator) -> Json raise JsonSyntax {
  self.space()
  let start = self.offset
  let c = self.source[start]
  if c == '{' {
    self.offset += 1
    self.space()
    let fields : Map[String, Json] = Map([])
    if self.source[self.offset] != '}' {
      while true {
        self.space()
        let key_start = self.offset
        self.string()
        let key = match
          (@core_json.parse(self.source[key_start:self.offset]) catch {
            _ => Json::null()
          }) {
          String(s) => s
          _ => ""
        }
        self.space()
        self.offset += 1 // colon, validated before decoding
        fields[key] = self.decode()
        self.space()
        if self.source[self.offset] != ',' {
          break
        }
        self.offset += 1
      }
    }
    self.offset += 1
    return Json::object(fields)
  }
  if c == '[' {
    self.offset += 1
    self.space()
    let values = []
    if self.source[self.offset] != ']' {
      while true {
        values.push(self.decode())
        self.space()
        if self.source[self.offset] != ',' {
          break
        }
        self.offset += 1
      }
    }
    self.offset += 1
    return Json::array(values)
  }
  self.value()
  let token = self.source[start:self.offset].to_owned()
  let value = @core_json.parse(token) catch { _ => Json::null() }
  match value {
    Number(n, ..) => Json::number(n, repr=token)
    _ => value
  }
}

///|
pub fn json_preserve_numbers(source : String) -> Json raise @model.CliError {
  ignore(
    @core_json.parse(source) catch {
      _ => raise CliError(json_syntax_error(source).1)
    },
  )
  JsonValidator::{ source, offset: 0, }.decode() catch {
    JsonSyntax(_, reason) => raise CliError(reason)
  }
}
