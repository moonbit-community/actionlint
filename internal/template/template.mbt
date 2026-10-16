///|
priv enum TemplateNode {
  Text(String)
  Action(String)
  Conditional(String, Array[TemplateNode], Array[TemplateNode])
  Range(String, Array[TemplateNode], Array[TemplateNode])
  With(String, Array[TemplateNode], Array[TemplateNode])
  Define(String, Array[TemplateNode])
}

///|
priv struct TemplateParser {
  tokens : Array[(Bool, String)]
  mut index : Int32
  mut stop : String
}

///|
fn template_tokens(
  source : String,
) -> Array[(Bool, String)] raise @model.CliError {
  let tokens = []
  let mut pos = 0
  let mut trim_left = false
  while pos < source.length() {
    guard source[pos:].find("{{") is Some(relative) else {
      let rest = source[pos:]
      tokens.push(
        (false, (if trim_left { rest.trim_start() } else { rest }).to_owned()),
      )
      break
    }
    let start = pos + relative
    let mut literal = source[pos:start]
    if trim_left {
      literal = literal.trim_start()
    }
    let trim_right = start + 2 < source.length() && source[start + 2] == '-'
    if trim_right {
      literal = literal.trim_end()
    }
    if literal != "" {
      tokens.push((false, literal.to_owned()))
    }
    let mut end = start + 2
    let mut quoted : UInt16 = 0
    let mut escaped = false
    while end + 1 < source.length() {
      let c = source[end]
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
      } else if c == '}' && source[end + 1] == '}' {
        break
      }
      end += 1
    }
    if end + 1 >= source.length() {
      raise CliError(
        "template to format error messages could not be parsed: unclosed action",
      )
    }
    let mut body = source[start + 2:end]
    if trim_right {
      body = body.strip_prefix("-").unwrap_or(body)
    }
    trim_left = body.has_suffix("-")
    if trim_left {
      body = body.strip_suffix("-").unwrap_or(body)
    }
    let action = body.trim().to_owned()
    if !action.has_prefix("/*") {
      tokens.push((true, action))
    }
    pos = end + 2
  }
  tokens
}

///|
fn TemplateParser::parse(
  self : TemplateParser,
) -> Array[TemplateNode] raise @model.CliError {
  let result = []
  self.stop = ""
  while self.index < self.tokens.length() {
    let (action, content) = self.tokens[self.index]
    self.index += 1
    if !action {
      result.push(TemplateNode::Text(content))
      continue
    }
    if content == "end" || content == "else" || content.has_prefix("else ") {
      self.stop = content
      return result
    }
    let kind = template_split(content, ' ').get(0).unwrap_or("")
    if kind == "if" ||
      kind == "range" ||
      kind == "with" ||
      kind == "define" ||
      kind == "block" {
      let expr = content[kind.length():].trim().to_owned()
      let yes = self.parse()
      let no = if self.stop == "else" {
        self.parse()
      } else if self.stop.has_prefix("else if ") {
        let nested = self.stop[8:].to_owned()
        let nested_yes = self.parse()
        let nested_no = if self.stop == "else" { self.parse() } else { [] }
        [Conditional(nested, nested_yes, nested_no)]
      } else {
        []
      }
      if self.stop != "end" {
        raise CliError(
          "template to format error messages could not be parsed: unexpected EOF",
        )
      }
      self.stop = ""
      if kind == "block" {
        let words = template_split(expr, ' ')
        guard words.get(0) is Some(name) else {
          raise CliError(
            "template to format error messages could not be parsed: missing block name",
          )
        }
        result.push(Define(name, yes))
        result.push(Action("template " + expr))
      } else {
        result.push(
          match kind {
            "if" => Conditional(expr, yes, no)
            "range" => Range(expr, yes, no)
            "with" => With(expr, yes, no)
            _ => Define(expr, yes)
          },
        )
      }
    } else {
      result.push(Action(content))
    }
  }
  result
}

///|
fn template_split(source : String, delimiter : Char) -> Array[String] {
  let parts = []
  let mut start = 0
  let mut quote_ : UInt16 = 0
  let mut depth = 0
  let mut escaped = false
  for i in 0..<source.length() {
    let c = source[i]
    if quote_ != 0 {
      if escaped {
        escaped = false
      } else if c == '\\' && quote_ != '`' {
        escaped = true
      } else if c == quote_ {
        quote_ = 0
      }
    } else if c is ('"' | '\'' | '`') {
      quote_ = c
    } else if c == '(' {
      depth += 1
    } else if c == ')' {
      depth -= 1
    } else if depth == 0 &&
      (
        source.get_char(i) == Some(delimiter) ||
        (delimiter == ' ' && c is ('\t' | '\r' | '\n'))
      ) {
      if delimiter != ' ' || i > start {
        parts.push(source[start:i].trim().to_owned())
      }
      start = i + 1
    }
  }
  if start < source.length() {
    parts.push(source[start:].trim().to_owned())
  }
  parts
}

///|
fn template_definitions(
  nodes : Array[TemplateNode],
  definitions : Map[String, Array[TemplateNode]],
) -> Unit {
  for node in nodes {
    match node {
      Define(name, body) => {
        definitions[name] = body
        template_definitions(body, definitions)
      }
      Conditional(_, yes, no) | Range(_, yes, no) | With(_, yes, no) => {
        template_definitions(yes, definitions)
        template_definitions(no, definitions)
      }
      _ => ()
    }
  }
}

///|
pub fn try_format_errors_bytes(
  format : String,
  errors : Json,
  extra_kinds~ : Array[String] = [],
) -> (Bytes, String?) raise @model.CliError {
  let source = unescape_format(format)
  let parser = TemplateParser::{
    tokens: template_tokens(source),
    index: 0,
    stop: "",
  }
  let nodes = parser.parse()
  if parser.stop != "" {
    raise CliError(
      "template to format error messages could not be parsed: unexpected \{parser.stop}",
    )
  }
  let kinds = @jsonutil.data_get(@data.builtin_data, "rule_descriptions")
  let names = @jsonutil.data_keys(kinds).filter(name => {
    name != "shellcheck" || extra_kinds.contains(name)
  })
  names.sort_by(String::lexical_compare)
  let descriptions = Json::array(
    names.map(name => {
      Json::object({
        "Name": Json::string(name),
        "Description": @jsonutil.data_get(kinds, name),
      })
    }),
  )
  let definitions : Map[String, Array[TemplateNode]] = Map([])
  template_definitions(nodes, definitions)
  let state = TemplateOutput::{ out: @buffer.Buffer(), action: "", }
  let root = template_from_json(errors)
  ignore(
    template_render(
      nodes,
      root,
      template_env(root, template_kinds(descriptions)),
      definitions,
      state,
    ) catch {
      CliError(message) =>
        return (
          state.out.to_bytes(),
          Some(template_execution_error(source, state.action, message)),
        )
    },
  )
  (state.out.to_bytes(), None)
}

///|
fn unescape_format(source : String) -> String {
  let out = StringBuilder()
  let mut i = 0
  while i < source.length() {
    if source[i] == '\\' && i + 1 < source.length() {
      let escaped : Char? = match source[i + 1] {
        'a' => Some('\u0007')
        'b' => Some('\u0008')
        'f' => Some('\u000c')
        'n' => Some('\n')
        'r' => Some('\r')
        't' => Some('\t')
        'v' => Some('\u000b')
        '\\' => Some('\\')
        _ => None
      }
      if escaped is Some(c) {
        out.write_char(c)
        i += 2
        continue
      }
    }
    let c = source.get_char(i).unwrap_or(' ')
    out.write_char(c)
    i += if c.to_int() > 0xffff { 2 } else { 1 }
  }
  out.to_string()
}

///|
pub fn try_format_errors(
  format : String,
  errors : Json,
  extra_kinds~ : Array[String] = [],
) -> (String, String?) raise @model.CliError {
  let (bytes, error) = try_format_errors_bytes(format, errors, extra_kinds~)
  (@utf8.decode_lossy(bytes), error)
}
