///|
fn template_functions() -> Array[String] {
  [
    "json", "replace", "toPascalCase", "getVersion", "allKinds", "and", "or", "not",
    "len", "index", "slice", "print", "printf", "println", "html", "js", "urlquery",
    "eq", "ne", "lt", "le", "gt", "ge", "call",
  ]
}

///|
fn validate_template_expr(
  source : String,
  variables : Map[String, Bool],
) -> Unit raise @model.CliError {
  let assignment = template_assignment(source)
  let source = assignment.map(a => a.2).unwrap_or(source)
  for part in template_split(source, '|') {
    let tokens = template_split(part, ' ')
    for i in 0..<tokens.length() {
      let token = tokens[i]
      if token.has_prefix("(") && template_parenthesis(token) is Some(end) {
        let suffix = token[end + 1:].to_owned()
        if suffix != "" &&
          !@matching.regex_match("^(\\.[A-Za-z_][A-Za-z_0-9]*)+$", suffix) {
          raise CliError("invalid field chain after parenthesized expression")
        }
        validate_template_expr(token[1:end].to_owned(), variables)
        continue
      }
      if token.has_prefix("$") {
        let name = token.split(".").next().unwrap_or("").to_owned()
        if variables.get(name) != Some(true) {
          raise CliError("undefined variable \{@model.quote(name)}")
        }
        continue
      }
      if token.has_prefix("\"") && token.contains("\n") {
        raise CliError("unterminated quoted string")
      }
      if token.has_prefix("\"") ||
        token.has_prefix("'") ||
        token.has_prefix("`") ||
        token.has_prefix(".") ||
        token.has_prefix("$") ||
        token == "true" ||
        token == "false" ||
        token == "nil" {
        continue
      }
      if (try @string.parse_double(token) catch {
          _ => None
        } noraise {
          n => Some(n)
        })
        is Some(_) {
        continue
      }
      if !template_functions().contains(token) {
        raise CliError(
          "template to format error messages could not be parsed: function \{@model.quote(token)} not defined",
        )
      }
    }
  }
  if assignment is Some((names, declaration, _)) {
    for name in names {
      if !declaration && variables.get(name) != Some(true) {
        raise CliError("undefined variable \{@model.quote(name)}")
      }
      variables[name] = true
    }
  }
}

///|
fn validate_template_nodes(
  nodes : Array[TemplateNode],
  range_depth~ : Int32 = 0,
  variables~ : Map[String, Bool] = { "$": true },
) -> Unit raise @model.CliError {
  for node in nodes {
    match node {
      Text(_) => ()
      Action(action) =>
        if action == "break" || action == "continue" {
          if range_depth == 0 {
            raise CliError("{{" + action + "}} outside {{range}}")
          }
        } else if action.has_prefix("template ") {
          let tokens = template_split(action[9:].to_owned(), ' ')
          if tokens.length() > 1 {
            validate_template_expr(tokens[1:].join(" "), variables)
          }
        } else {
          validate_template_expr(action, variables)
        }
      Define(_, body) => validate_template_nodes(body)
      Range(expr, yes, no) => {
        let scope = variables.copy()
        validate_template_expr(expr, scope)
        validate_template_nodes(
          yes,
          range_depth=range_depth + 1,
          variables=scope.copy(),
        )
        validate_template_nodes(no, range_depth~, variables=scope.copy())
      }
      Conditional(expr, yes, no) | With(expr, yes, no) => {
        let scope = variables.copy()
        validate_template_expr(expr, scope)
        validate_template_nodes(yes, range_depth~, variables=scope.copy())
        validate_template_nodes(no, range_depth~, variables=scope.copy())
      }
    }
  }
}

///|
pub fn validate_template(format : String) -> Unit raise @model.CliError {
  let parser = TemplateParser::{
    tokens: template_tokens(unescape_format(format)),
    index: 0,
    stop: "",
  }
  let nodes = parser.parse()
  if parser.stop != "" {
    raise CliError(
      "template to format error messages could not be parsed: unexpected \{parser.stop}",
    )
  }
  validate_template_nodes(nodes) catch {
    CliError(message) => {
      if message.contains("outside {{range}}") ||
        message.has_prefix("undefined variable ") ||
        message == "unterminated quoted string" {
        raise CliError(
          "template \{@model.quote(format)} to format error messages could not be parsed: template: error formatter:1: \{message}",
        )
      }
      raise CliError(message)
    }
  }
}
