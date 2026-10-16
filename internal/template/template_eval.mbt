///|
priv enum TemplateAtom {
  Token(String)
  Nested(Array[TemplateCommand], Array[String])
}

///|
priv struct TemplateCommand {
  atoms : Array[TemplateAtom]
}

///|
fn template_expression(
  source : String,
) -> Array[TemplateCommand] raise @model.CliError {
  template_split(source, '|').map(part => {
    let atoms = template_split(part, ' ').map(token => {
      if token.has_prefix("(") && template_parenthesis(token) is Some(end) {
        Nested(
          template_expression(token[1:end].to_owned()),
          if end + 1 == token.length() {
            []
          } else {
            token[end + 2:].split(".").map(s => s.to_owned()).to_array()
          },
        )
      } else {
        Token(token)
      }
    })
    { atoms, }
  })
}

///|
fn template_atom(
  atom : TemplateAtom,
  dot : TemplateValue,
  env : TemplateEnv,
) -> TemplateValue raise @model.CliError {
  guard atom is Token(token) else {
    guard atom is Nested(expr, fields) else { return Missing }
    let mut value = template_evaluate(expr, dot, env)
    for field in fields {
      value = template_field(value, field)
    }
    return value
  }
  let text = token.trim()
  if text == "." {
    return dot
  }
  if text == "allKinds" {
    return env.get("__allKinds")
  }
  if text == "true" || text == "false" {
    return Boolean(text == "true")
  }
  if text == "nil" {
    return Nil
  }
  if text.has_prefix("\"") {
    return template_from_json(
      @json.parse(text) catch {
        _ => raise CliError("invalid quoted string")
      },
    )
  }
  if text.has_prefix("`") && text.has_suffix("`") {
    return Text(text[1:text.length() - 1].to_owned())
  }
  if text.has_prefix("'") && text.has_suffix("'") {
    let decoded = @json.parse(
      "\"" + text[1:text.length() - 1].to_owned() + "\"",
    ) catch {
      _ => Json::string(text[1:text.length() - 1].to_owned())
    }
    guard decoded is String(s) && s.iter().count() == 1 else {
      raise CliError("malformed character constant")
    }
    return Integer(s.iter().next().unwrap().to_int().to_int64())
  }
  if text.has_prefix(".") || text.has_prefix("$") {
    let fields = text.split(".").to_array()
    let mut value = if text.has_prefix(".") {
      dot
    } else {
      env.get(fields[0].to_owned())
    }
    for field in fields[1:] {
      value = template_field(value, field.to_owned())
    }
    return value
  }
  if !text.contains(".") &&
    !text.contains("e") &&
    !text.contains("E") &&
    !text.contains("p") &&
    !text.contains("P") {
    if (try @string.parse_int64(text) catch {
        _ => None
      } noraise {
        n => Some(n)
      })
      is Some(n) {
      return Integer(n)
    }
  }
  if (try @string.parse_double(text) catch {
      _ => None
    } noraise {
      n => Some(n)
    })
    is Some(n) {
    return Floating(n)
  }
  template_call(text.to_owned(), [])
}

///|
fn template_evaluate(
  commands : Array[TemplateCommand],
  dot : TemplateValue,
  env : TemplateEnv,
) -> TemplateValue raise @model.CliError {
  let mut value : TemplateValue = Missing
  for i, command in commands {
    if command.atoms.is_empty() {
      continue
    }
    let first = command.atoms[0]
    if i == 0 && command.atoms.length() == 1 {
      if first is Token("nil") {
        raise CliError("nil is not a command")
      }
      value = template_atom(first, dot, env)
      continue
    }
    guard first is Token(name) else {
      raise CliError("can't give argument to non-function")
    }
    if name == "and" || name == "or" {
      if command.atoms.length() == 1 && i == 0 {
        raise CliError(
          "wrong number of args for \{name}: want at least 1 got 0",
        )
      }
      let mut selected : TemplateValue? = None
      for atom in command.atoms[1:] {
        let argument = template_atom(atom, dot, env)
        selected = Some(argument)
        if template_truth(argument) == (name == "or") {
          break
        }
      }
      if selected is Some(last) && template_truth(last) == (name == "or") {
        value = last
      } else if i == 0 {
        value = selected.unwrap_or(Missing)
      }
      continue
    }
    let args = command.atoms[1:].map(atom => template_atom(atom, dot, env))
    if i > 0 {
      args.push(value)
    }
    value = template_call(name, args)
  }
  value
}

///|
fn template_eval(
  source : String,
  dot : TemplateValue,
  env : TemplateEnv,
) -> TemplateValue raise @model.CliError {
  template_evaluate(template_expression(source), dot, env)
}

///|
fn template_compare(
  a : TemplateValue,
  b : TemplateValue,
  equality : Bool,
) -> Int32 raise @model.CliError {
  match (a, b) {
    (Integer(a), Integer(b)) => a.compare(b)
    (Floating(a), Floating(b)) => a.compare(b)
    (Text(_) | RawText(_), Text(_) | RawText(_)) => {
      let a = template_value_bytes(a)
      let b = template_value_bytes(b)
      for i in 0..<a.length().min(b.length()) {
        if a[i] != b[i] {
          return a[i].to_int().compare(b[i].to_int())
        }
      }
      a.length().compare(b.length())
    }
    (Boolean(a), Boolean(b)) if equality => if a == b { 0 } else { 1 }
    (Record(a, at), Record(b, bt)) if equality &&
      at.has_prefix("*") &&
      bt.has_prefix("*") => if at == bt && physical_equal(a, b) { 0 } else { 1 }
    (Missing | Nil, Missing | Nil) if equality => 0
    (Missing | Nil, _) | (_, Missing | Nil) if equality => 1
    _ =>
      raise CliError(
        if equality {
          "incompatible types for comparison"
        } else {
          "invalid type for comparison"
        },
      )
  }
}

///|
fn template_kinds(value : Json) -> TemplateValue {
  match template_from_json(value) {
    Sequence(xs, _) => Sequence(xs, "[]*actionlint.ruleTemplateFields")
    _ => Missing
  }
}

///|
fn template_call(
  name : String,
  args : Array[TemplateValue],
) -> TemplateValue raise @model.CliError {
  fn arg(args : Array[TemplateValue], i : Int32) -> TemplateValue {
    args.get(i).unwrap_or(Missing)
  }
  fn text(args : Array[TemplateValue], i : Int32) -> String {
    template_value_string(arg(args, i))
  }
  let arity = match name {
    "not" | "len" | "json" | "toPascalCase" => Some(1)
    "ne" | "lt" | "le" | "gt" | "ge" => Some(2)
    "getVersion" | "allKinds" => Some(0)
    _ => None
  }
  if arity is Some(want) && args.length() != want {
    raise CliError(
      "wrong number of args for \{name}: want \{want} got \{args.length()}",
    )
  }
  match name {
    "getVersion" => Text("0.0.1")
    "json" => Text(@jsonutil.json_encode(template_to_json(arg(args, 0))) + "\n")
    "allKinds" => {
      let data = @jsonutil.data_get(@data.builtin_data, "rule_descriptions")
      let names = @jsonutil.data_keys(data)
      names.sort_by(String::lexical_compare)
      template_kinds(
        Json::array(
          names.map(name => {
            Json::object({
              "Name": Json::string(name),
              "Description": @jsonutil.data_get(data, name),
            })
          }),
        ),
      )
    }
    "not" => Boolean(!template_truth(arg(args, 0)))
    "len" =>
      Integer(
        (match arg(args, 0) {
          Text(s) => @utf8.encode(s).length()
          RawText(s) => s.length()
          Sequence(xs, _) => xs.length()
          Record(m, ty) if !ty.has_prefix("*") => m.length()
          _ =>
            raise CliError(
              "error calling len: len of type \{template_type(arg(args, 0))}",
            )
        }).to_int64(),
      )
    "index" => {
      if args.length() == 0 {
        raise CliError("wrong number of args for index: want at least 1 got 0")
      }
      let mut value = args[0]
      if value is (Missing | Nil) {
        raise CliError("error calling index: index of untyped nil")
      }
      for index in args[1:] {
        value = match value {
          Sequence(xs, _) => {
            let at = template_index_arg(index, xs.length(), "index")
            if at == xs.length() {
              raise CliError(
                "error calling index: reflect: slice index out of range",
              )
            }
            xs[at]
          }
          Text(_) | RawText(_) => {
            let bytes = template_value_bytes(value)
            let at = template_index_arg(index, bytes.length(), "index")
            if at == bytes.length() {
              raise CliError(
                "error calling index: reflect: string index out of range",
              )
            }
            Integer(bytes[at].to_int().to_int64())
          }
          Record(m, ty) if !ty.has_prefix("*") => {
            guard index is Text(key) else {
              raise CliError(
                "error calling index: value has type \{template_type(index)}; should be string",
              )
            }
            m.get(key).unwrap_or(Nil)
          }
          _ =>
            raise CliError(
              "error calling index: can't index item of type \{template_type(value).strip_prefix("*").unwrap_or(template_type(value)[:])}",
            )
        }
      }
      value
    }
    "slice" => {
      if args.length() == 0 {
        raise CliError("wrong number of args for slice: want at least 1 got 0")
      }
      if args[0] is (Missing | Nil) {
        raise CliError("error calling slice: slice of untyped nil")
      }
      if args.length() > 4 {
        raise CliError(
          "error calling slice: too many slice indexes: \{args.length() - 1}",
        )
      }
      if args.length() == 4 && args[0] is (Text(_) | RawText(_)) {
        raise CliError("error calling slice: cannot 3-index slice a string")
      }
      let length = match args[0] {
        Sequence(xs, _) => xs.length()
        Text(s) => @utf8.encode(s).length()
        RawText(s) => s.length()
        _ =>
          raise CliError(
            "error calling slice: can't slice item of type \{template_type(args[0])}",
          )
      }
      let indices = args[1:].map(value => {
        template_index_arg(value, length, "slice")
      })
      let lo = indices.get(0).unwrap_or(0)
      let hi = indices.get(1).unwrap_or(length)
      if lo > hi {
        raise CliError(
          "error calling slice: invalid slice index: \{lo} > \{hi}",
        )
      }
      if indices.get(2) is Some(capacity) && hi > capacity {
        raise CliError(
          "error calling slice: invalid slice index: \{hi} > \{capacity}",
        )
      }
      match args[0] {
        Sequence(xs, ty) => Sequence(xs[lo:hi].to_owned(), ty)
        Text(_) | RawText(_) =>
          RawText(template_value_bytes(args[0])[lo:hi].to_owned())
        _ => Missing
      }
    }
    "eq" | "ne" | "lt" | "le" | "gt" | "ge" => {
      if args.length() < 2 {
        raise CliError("error calling \{name}: missing argument for comparison")
      }
      let mut equal = false
      for right in args[1:] {
        let cmp = template_compare(args[0], right, name == "eq" || name == "ne") catch {
          CliError(reason) => raise CliError("error calling \{name}: \{reason}")
        }
        equal = match name {
          "eq" => cmp == 0
          "ne" => cmp != 0
          "lt" => cmp < 0
          "le" => cmp <= 0
          "gt" => cmp > 0
          _ => cmp >= 0
        }
        if equal {
          break
        }
      }
      Boolean(equal)
    }
    "printf" => {
      if args.is_empty() {
        raise CliError("wrong number of args for printf: want at least 1 got 0")
      }
      if !(args[0] is (Text(_) | RawText(_))) {
        raise CliError(
          "wrong type for value; expected string; got \{template_type(args[0])}",
        )
      }
      RawText(template_printf(args))
    }
    "print" | "println" => {
      let out = StringBuilder()
      for i, value in args {
        if i > 0 &&
          (
            name == "println" ||
            (!(value is Text(_)) && !(args[i - 1] is Text(_)))
          ) {
          out.write_char(' ')
        }
        out.write_string(template_value_string(value))
      }
      if name == "println" {
        out.write_char('\n')
      }
      Text(out.to_string())
    }
    "replace" => {
      if args.length() % 2 != 1 {
        raise CliError(
          "could not format error messages: replace requires pairs of old and new strings",
        )
      }
      let source = template_value_bytes(args[0])
      let out = @buffer.Buffer()
      let mut offset = 0
      let mut empty_at = -1
      while offset <= source.length() {
        let mut matched = false
        for i = 1; i + 1 < args.length(); i = i + 2 {
          let old = template_value_bytes(args[i])
          if old.is_empty() && empty_at == offset {
            continue
          }
          if old.length() <= source.length() - offset &&
            source[offset:offset + old.length()] == old[:] {
            out.write_bytes(template_value_bytes(args[i + 1]))
            if old.is_empty() {
              empty_at = offset
            } else {
              offset += old.length()
            }
            matched = true
            break
          }
        }
        if !matched {
          if offset == source.length() {
            break
          }
          out.write_byte(source[offset])
          offset += 1
        }
      }
      RawText(out.to_bytes())
    }
    "toPascalCase" => {
      let out = StringBuilder()
      let mut first = true
      for c in text(args, 0) {
        if c is ('a'..<='z' | 'A'..<='Z' | '0'..<='9') {
          out.write_string(
            if first {
              c.to_string().to_upper()
            } else {
              c.to_string()
            },
          )
          first = false
        } else {
          first = true
        }
      }
      Text(out.to_string())
    }
    "html" =>
      Text(
        template_print(args)
        .replace_all(old="&", new="&amp;")
        .replace_all(old="'", new="&#39;")
        .replace_all(old="\"", new="&#34;")
        .replace_all(old="<", new="&lt;")
        .replace_all(old=">", new="&gt;"),
      )
    "js" => {
      let out = StringBuilder()
      for c in template_print(args) {
        match c {
          '\\' => out.write_string("\\\\")
          '\'' => out.write_string("\\'")
          '"' => out.write_string("\\\"")
          _ => {
            let quoted = @model.char_quote(c)
            if c is ('<' | '>' | '&' | '=') ||
              c < ' ' ||
              quoted.has_prefix("'\\u") ||
              quoted.has_prefix("'\\U") {
              let hex = c.to_int().to_string(radix=16).to_upper()
              out.write_string(
                "\\u" + "0".repeat((4 - hex.length()).max(0)) + hex,
              )
            } else {
              out.write_char(c)
            }
          }
        }
      }
      Text(out.to_string())
    }
    "urlquery" => {
      let out = StringBuilder()
      let hex = "0123456789ABCDEF"
      for b in @utf8.encode(template_print(args)) {
        let n = b.to_int()
        if n
          is (0x30..<=0x39
          | 0x41..<=0x5a
          | 0x61..<=0x7a
          | 0x2d
          | 0x2e
          | 0x5f
          | 0x7e) {
          out.write_char(n.unsafe_to_char())
        } else if n == 32 {
          out.write_char('+')
        } else {
          out.write_char('%')
          out.write_char(hex.get_char(n / 16).unwrap())
          out.write_char(hex.get_char(n % 16).unwrap())
        }
      }
      Text(out.to_string())
    }
    _ =>
      raise CliError(
        "template to format error messages could not be parsed: function \{@model.quote(name)} not defined",
      )
  }
}

///|
fn template_print(args : Array[TemplateValue]) -> String {
  let out = StringBuilder()
  for i, value in args {
    if i > 0 && !(value is Text(_)) && !(args[i - 1] is Text(_)) {
      out.write_char(' ')
    }
    out.write_string(template_value_string(value))
  }
  out.to_string()
}

///|
fn template_index_arg(
  value : TemplateValue,
  capacity : Int32,
  operation : String,
) -> Int32 raise @model.CliError {
  match value {
    Integer(n) => {
      if n < 0L || n > capacity.to_int64() {
        raise CliError("error calling \{operation}: index out of range: \{n}")
      }
      n.to_int()
    }
    Nil | Missing =>
      raise CliError(
        "error calling \{operation}: cannot index slice/array with nil",
      )
    _ =>
      raise CliError(
        "error calling \{operation}: cannot index slice/array with type \{template_type(value)}",
      )
  }
}
