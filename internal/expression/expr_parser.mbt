///|
pub struct Expr {
  kind : String
  value : String
  priv offset : Int32
  children : Array[Expr]
} derive(Debug)

///|
priv struct ExprToken {
  kind : String
  value : String
  offset : Int32
}

///|
pub suberror ExprError {
  ExprError(Int32, String)
}

///|
priv struct ExprParser {
  tokens : Array[ExprToken]
  mut index : Int32
  consumed : Int32
}

///|
fn expr_alpha(c : UInt16) -> Bool {
  c is ('a'..<='z' | 'A'..<='Z' | '_')
}

///|
fn collect_expression_tokens(
  source : String,
  tokens : Array[ExprToken],
) -> Int32 raise ExprError {
  let mut i = 0
  let expected = "'a'..'z', 'A'..'Z', '_', '0'..'9', ''', '}', '(', ')', '[', ']', '.', '!', '<', '>', '=', '&', '|', '*', ',', ' '"
  while i < source.length() {
    let c = source[i]
    if c is (' ' | '\t' | '\r' | '\n') {
      i += 1
      continue
    }
    let start = i
    if c == '}' && i + 1 < source.length() && source[i + 1] == '}' {
      tokens.push({ kind: "END", value: "", offset: i, })
      return i + 2
    }
    let kind = if expr_alpha(c) {
      i += 1
      while i < source.length() &&
            (expr_alpha(source[i]) || source[i] is ('0'..<='9' | '-')) {
        i += 1
      }
      "IDENT"
    } else if c == '\'' {
      i += 1
      let mut closed = false
      while i < source.length() {
        if source[i] == '\'' {
          if i + 1 < source.length() && source[i + 1] == '\'' {
            i += 2
          } else {
            i += 1
            closed = true
            break
          }
        } else {
          i += 1
        }
      }
      if !closed {
        expression_lex_error(source, i, "end of string literal", "'''")
      }
      "STRING"
    } else if c is ('0'..<='9' | '-') {
      let (end, kind) = lex_number(source, start)
      i = end
      kind
    } else {
      i += 1
      let first = source[start:i].to_owned()
      if c == '}' {
        expression_lex_error(source, i, "end marker }}", "'}'")
      }
      if c is ('=' | '&' | '|') && (i >= source.length() || source[i] != c) {
        expression_lex_error(
          source,
          i,
          first + first + " operator",
          @model.char_quote(source.get_char(start).unwrap()),
        )
      }
      if ["!", "<", ">", "=", "&", "|"].contains(first) && i < source.length() {
        let second = source[i]
        if (
            second == '=' &&
            (first == "!" || first == "<" || first == ">" || first == "=")
          ) ||
          (second == c && (c == '&' || c == '|')) {
          i += 1
        }
      }
      let operator = source[start:i].to_owned()
      if ![
          "(", ")", "[", "]", ".", "!", "<", ">", "<=", ">=", "==", "!=", "&&", "||",
          "*", ",",
        ].contains(operator) {
        let note = if c == '"' {
          ". do you mean string literals? only single quotes are available for string delimiter"
        } else {
          ""
        }
        raise ExprError(
          start,
          "got unexpected character \{@model.char_quote(source.get_char(start).unwrap_or(' '))} while lexing expression, expecting \{expected}\{note}",
        )
      }
      operator
    }
    tokens.push({ kind, value: source[start:i].to_owned(), offset: start, })
  }
  raise ExprError(i, "unexpected EOF while lexing expression")
}

///|
// Lexical failures are deferred until the parser requests that token. This
// preserves syntax-error priority while retaining tokens for trailing input.
fn lex_expression(source : String) -> ExprParser {
  let tokens : Array[ExprToken] = []
  let consumed = collect_expression_tokens(source, tokens) catch {
    ExprError(offset, message) => {
      tokens.push({ kind: "ERROR", value: message, offset, })
      source.length()
    }
  }
  { tokens, index: 0, consumed, }
}

///|
fn ExprParser::peek(self : ExprParser) -> ExprToken raise ExprError {
  let token = self.tokens[self.index.min(self.tokens.length() - 1)]
  if token.kind == "ERROR" {
    raise ExprError(token.offset, token.value)
  }
  token
}

///|
fn ExprParser::next(self : ExprParser) -> ExprToken raise ExprError {
  let token = self.peek()
  self.index += 1
  token
}

///|
fn ExprParser::unexpected(
  self : ExprParser,
  where_ : String,
  expected : Array[String],
) -> Unit raise ExprError {
  let t = self.peek()
  let what = if t.kind == "END" {
    "end of input"
  } else {
    "token " + @model.quote(t.kind)
  }
  raise ExprError(
    t.offset,
    "unexpected \{what} while parsing \{where_}. expecting \{expected.map(@model.quote).join(", ")}",
  )
}

///|
fn expression(
  kind : String,
  value : String,
  offset : Int32,
  children : Array[Expr],
) -> Expr {
  { kind, value, offset, children, }
}

///|
fn ExprParser::primary(self : ExprParser) -> Expr raise ExprError {
  let token = self.peek()
  let mut result = match token.kind {
    "IDENT" => {
      ignore(self.next())
      if self.peek().kind == "(" {
        ignore(self.next())
        let args = []
        if self.peek().kind != ")" {
          while true {
            args.push(self.binary(1))
            if self.peek().kind == ")" {
              break
            }
            if self.peek().kind != "," {
              self.unexpected("arguments of function call", [",", ")"])
            }
            ignore(self.next())
          }
        }
        ignore(self.next())
        expression("call", token.value, token.offset, args)
      } else {
        expression(
          match token.value {
            "null" => "null"
            "true" | "false" => "bool"
            _ => "variable"
          },
          token.value,
          token.offset,
          [],
        )
      }
    }
    "STRING" => {
      ignore(self.next())
      expression(
        "string",
        token.value[1:token.value.length() - 1]
        .to_owned()
        .replace_all(old="''", new="'"),
        token.offset,
        [],
      )
    }
    "INTEGER" | "FLOAT" => {
      check_number_literal(token)
      ignore(self.next())
      expression("number", token.value, token.offset, [])
    }
    "(" => {
      ignore(self.next())
      let nested = self.binary(1)
      if self.peek().kind != ")" {
        self.unexpected("closing ')' of nested expression (...)", [")"])
      }
      ignore(self.next())
      nested
    }
    _ => {
      self.unexpected(
        "variable access, function call, null, bool, int, float or string",
        ["IDENT", "(", "INTEGER", "FLOAT", "STRING"],
      )
      expression("null", "", token.offset, [])
    }
  }
  while true {
    match self.peek().kind {
      "." => {
        ignore(self.next())
        let property = self.peek()
        if property.kind != "IDENT" && property.kind != "*" {
          self.unexpected(
            "object property dereference like 'a.b' or array element dereference like 'a.*'",
            ["IDENT", "*"],
          )
        }
        ignore(self.next())
        result = expression(
          if property.kind == "*" {
            "filter"
          } else {
            "property"
          },
          property.value.to_lower(),
          result.offset,
          [result],
        )
      }
      "[" => {
        ignore(self.next())
        let index = self.binary(1)
        if self.peek().kind != "]" {
          self.unexpected("closing bracket ']' for index access", ["]"])
        }
        ignore(self.next())
        result = expression("index", "", result.offset, [result, index])
      }
      _ => break
    }
  }
  result
}

///|
fn operator_precedence(op : String) -> Int32 {
  match op {
    "||" => 1
    "&&" => 2
    "==" | "!=" | "<" | ">" | "<=" | ">=" => 3
    _ => 0
  }
}

///|
fn ExprParser::binary(
  self : ExprParser,
  minimum : Int32,
) -> Expr raise ExprError {
  let mut left = if self.peek().kind == "!" {
    let token = self.next()
    expression("not", "!", token.offset, [self.binary(4)])
  } else {
    self.primary()
  }
  while operator_precedence(self.peek().kind) >= minimum {
    let op = self.peek().kind
    ignore(self.next())
    left = expression("binary", op, left.offset, [
      left,
      self.binary(operator_precedence(op)),
    ])
  }
  left
}

///|
pub fn parse_expression(source : String) -> (Expr, Int32) raise ExprError {
  let parser = lex_expression(source)
  let expr = parser.binary(1)
  if parser.peek().kind != "END" {
    let remaining = parser.tokens[parser.index:].filter(t => {
      t.kind != "ERROR" && t.kind != "END"
    })
    raise ExprError(
      parser.peek().offset,
      "parser did not reach end of input after parsing the expression. \{remaining.length()} remaining token(s) in the input: \{remaining.map(t => @model.quote(t.kind)).join(", ")}",
    )
  }
  (expr, parser.consumed)
}

///|
pub fn Expr::constant(self : Expr) -> Bool {
  match self.kind {
    "null" | "bool" | "number" | "string" => true
    "not" | "binary" => self.children.iter().all(Expr::constant)
    "call" =>
      ["contains", "startswith", "endswith", "format", "join", "tojson", "case"].contains(
        self.value.to_lower(),
      ) &&
      self.children.iter().all(Expr::constant)
    _ => false
  }
}
