///|
priv struct TemplateOutput {
  out : @buffer.Buffer
  mut action : String
}

///|
// Shared by validation and evaluation, including field chains after a group.
fn template_parenthesis(token : String) -> Int32? {
  let mut depth = 0
  let mut quoted : UInt16 = 0
  let mut escaped = false
  for i in 0..<token.length() {
    let c = token[i]
    if quoted != 0 {
      if escaped {
        escaped = false
      } else if c == '\\' && quoted != '`' {
        escaped = true
      } else if c == quoted {
        quoted = 0
      }
    } else if c is ('"' | '\'' | '`') {
      quoted = c
    } else if c == '(' {
      depth += 1
    } else if c == ')' {
      depth -= 1
      if depth == 0 {
        return Some(i)
      }
    }
  }
  None
}

///|
fn template_execution_error(
  source : String,
  action : String,
  reason : String,
) -> String {
  let mut expression = action
  let mut position = source.find(action).unwrap_or(0)
  if reason.has_prefix("can't evaluate field ") {
    let field = reason[21:].split(" ").next().unwrap_or("").to_owned()
    for token in template_split(action, ' ') {
      if token.contains("." + field) {
        expression = token
        position = source.find(token).unwrap_or(position)
        if token.has_prefix("(") && template_parenthesis(token) is Some(end) {
          let inner = template_split(token[1:end].to_owned(), ' ')
          expression = inner.last().unwrap_or(token)
          position += token[:end].rev_find(expression).unwrap_or(0)
        }
        break
      }
    }
  }
  let prefix = source[:position]
  let line = prefix.split("\n").count()
  let column = @utf8.encode(prefix.split("\n").last().unwrap_or("")).length()
  "could not format error messages: template: error formatter:\{line}:\{column}: executing \"error formatter\" at <\{expression}>: \{reason}"
}
