///|
fn expression_lex_error(
  source : String,
  offset : Int32,
  where_ : String,
  expected : String,
) -> Unit raise ExprError {
  let what = if source.get_char(offset) is Some(c) {
    "character " + @model.char_quote(c)
  } else {
    "EOF"
  }
  let note = if source.get_char(offset) == Some('"') {
    ". do you mean string literals? only single quotes are available for string delimiter"
  } else {
    ""
  }
  raise ExprError(
    offset,
    "got unexpected \{what} while lexing \{where_}, expecting \{expected}\{note}",
  )
}

///|
fn lex_number(
  source : String,
  start : Int32,
) -> (Int32, String) raise ExprError {
  fn at(source : String, offset : Int32) -> UInt16 {
    source.get(offset).unwrap_or(0)
  }
  fn digit(c : UInt16) -> Bool {
    c is ('0'..<='9')
  }
  fn hex(c : UInt16) -> Bool {
    c is ('0'..<='9' | 'a'..<='f' | 'A'..<='F')
  }
  let mut i = start
  if at(source, i) == '-' {
    i += 1
  }
  let mut kind = "INTEGER"
  let mut hexadecimal = false
  if at(source, i) == '0' {
    i += 1
    if at(source, i) == 'x' {
      i += 1
      hexadecimal = true
      if at(source, i) == '0' {
        i += 1
      } else {
        if !hex(at(source, i)) {
          expression_lex_error(
            source, i, "hex integer", "'0'..'9', 'a'..'f', 'A'..'F'",
          )
        }
        while hex(at(source, i)) {
          i += 1
        }
      }
    }
  } else {
    if !digit(at(source, i)) {
      expression_lex_error(source, i, "integer part of number", "'0'..'9'")
    }
    while digit(at(source, i)) {
      i += 1
    }
  }
  if !hexadecimal {
    if at(source, i) == '.' {
      i += 1
      if !digit(at(source, i)) {
        expression_lex_error(
          source, i, "fraction part of float number", "'0'..'9'",
        )
      }
      while digit(at(source, i)) {
        i += 1
      }
      kind = "FLOAT"
    }
    if at(source, i) is ('e' | 'E') {
      i += 1
      if at(source, i) == '-' {
        i += 1
      }
      if at(source, i) == '0' {
        i += 1
      } else {
        if !digit(at(source, i)) {
          expression_lex_error(
            source, i, "exponent part of float number", "'0'..'9'",
          )
        }
        while digit(at(source, i)) {
          i += 1
        }
      }
      kind = "FLOAT"
    }
  }
  if expr_alpha(at(source, i)) || digit(at(source, i)) {
    let what = if hexadecimal { "hex integer" } else { "number" }
    expression_lex_error(
      source,
      i,
      "character following \{what} \{source[start:i]}",
      "''', '}', '(', ')', '[', ']', '.', '!', '<', '>', '=', '&', '|', '*', ',', ' '",
    )
  }
  (i, kind)
}

///|
fn check_number_literal(token : ExprToken) -> Unit raise ExprError {
  if token.kind == "INTEGER" {
    let value = @string.parse_int64(token.value, base=0) catch {
      _ =>
        raise ExprError(
          token.offset,
          "parsing invalid integer literal \{@model.quote(token.value)}: strconv.ParseInt: parsing \{@model.quote(token.value)}: value out of range",
        )
    }
    if value < -2147483648L || value > 2147483647L {
      raise ExprError(
        token.offset,
        "parsing invalid integer literal \{@model.quote(token.value)}: strconv.ParseInt: parsing \{@model.quote(token.value)}: value out of range",
      )
    }
  } else {
    let value = @string.parse_double(token.value) catch {
      _ =>
        raise ExprError(
          token.offset,
          "parsing invalid float literal \{@model.quote(token.value)}: strconv.ParseFloat: parsing \{@model.quote(token.value)}: value out of range",
        )
    }
    if value.is_inf() {
      raise ExprError(
        token.offset,
        "parsing invalid float literal \{@model.quote(token.value)}: strconv.ParseFloat: parsing \{@model.quote(token.value)}: value out of range",
      )
    }
  }
}
