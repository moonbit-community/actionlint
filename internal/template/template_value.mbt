///|
priv enum TemplateValue {
  Missing
  Nil
  Boolean(Bool)
  Integer(Int64)
  Floating(Double)
  Text(String)
  RawText(Bytes)
  Sequence(Array[TemplateValue], String)
  Record(Map[String, TemplateValue], String)
} derive(Eq)

///|
fn template_from_json(value : Json) -> TemplateValue {
  match value {
    Null => Nil
    True => Boolean(true)
    False => Boolean(false)
    Number(n, ..) =>
      if n == n.to_int64().to_double() {
        Integer(n.to_int64())
      } else {
        Floating(n)
      }
    String(s) => Text(s)
    Array(xs) =>
      Sequence(xs.map(template_from_json), "[]*actionlint.ErrorTemplateFields")
    Object(m) => {
      let fields = m.map((_, v) => template_from_json(v))
      let ty = if m.contains("filepath") && m.contains("message") {
        "*actionlint.ErrorTemplateFields"
      } else if m.contains("Name") && m.contains("Description") {
        "*actionlint.ruleTemplateFields"
      } else {
        "map[string]interface {}"
      }
      Record(fields, ty)
    }
  }
}

///|
fn template_to_json(value : TemplateValue) -> Json {
  match value {
    Missing | Nil => Json::null()
    Boolean(b) => Json::boolean(b)
    Integer(n) =>
      @json.parse(n.to_string()) catch {
        _ => Json::number(n.to_double())
      }
    Floating(n) => Json::number(n)
    Text(s) => Json::string(s)
    RawText(s) => Json::string(@utf8.decode_lossy(s))
    Sequence(xs, _) => Json::array(xs.map(template_to_json))
    Record(m, _) => Json::object(m.map((_, v) => template_to_json(v)))
  }
}

///|
fn template_type(value : TemplateValue) -> String {
  match value {
    Missing | Nil => "<nil>"
    Boolean(_) => "bool"
    Integer(_) => "int"
    Floating(_) => "float64"
    Text(_) | RawText(_) => "string"
    Sequence(_, ty) | Record(_, ty) => ty
  }
}

///|
fn template_truth(value : TemplateValue) -> Bool {
  match value {
    Missing | Nil => false
    Boolean(b) => b
    Integer(n) => n != 0L
    Floating(n) => n != 0.0
    Text(s) => s != ""
    RawText(s) => !s.is_empty()
    Sequence(xs, _) => !xs.is_empty()
    Record(fields, ty) => ty.has_prefix("*") || !fields.is_empty()
  }
}

///|
fn template_value_string(value : TemplateValue) -> String {
  match value {
    Missing | Nil => "<no value>"
    Boolean(b) => b.to_string()
    Integer(n) => n.to_string()
    Floating(n) => n.to_string()
    Text(s) => s
    RawText(s) => @utf8.decode_lossy(s)
    Sequence(xs, _) => "[" + xs.map(template_value_string).join(" ") + "]"
    Record(m, ty) => {
      if ty.has_prefix("*") {
        return template_struct(m, ty, false, false)
      }
      let names = m.keys().to_array()
      names.sort_by(String::lexical_compare)
      "map[" +
      names.map(k => k + ":" + template_value_string(m[k])).join(" ") +
      "]"
    }
  }
}

///|
fn template_field(
  value : TemplateValue,
  field : String,
) -> TemplateValue raise @model.CliError {
  match value {
    Record(m, ty) => {
      let key = if ty == "*actionlint.ErrorTemplateFields" {
        if ![
            "Message", "Filepath", "Line", "Column", "Kind", "Snippet", "EndColumn",
          ].contains(field) {
          raise CliError("can't evaluate field \{field} in type \{ty}")
        }
        if field == "EndColumn" {
          "end_column"
        } else {
          field.to_lower()
        }
      } else {
        field
      }
      m
      .get(key)
      .unwrap_or(
        if ty == "*actionlint.ErrorTemplateFields" {
          if ["line", "column", "end_column"].contains(key) {
            Integer(0L)
          } else {
            Text("")
          }
        } else {
          Missing
        },
      )
    }
    Missing => Missing
    Nil => raise CliError("nil pointer evaluating interface {}.\{field}")
    _ =>
      raise CliError(
        "can't evaluate field \{field} in type \{template_type(value)}",
      )
  }
}

///|
priv struct TemplateEnv {
  scopes : Array[Map[String, TemplateValue]]
}

///|
fn TemplateEnv::get(self : TemplateEnv, name : String) -> TemplateValue {
  for i = self.scopes.length() - 1; i >= 0; i = i - 1 {
    if self.scopes[i].get(name) is Some(value) {
      return value
    }
  }
  Missing
}

///|
fn TemplateEnv::bind(
  self : TemplateEnv,
  name : String,
  value : TemplateValue,
  declaration : Bool,
) -> Unit raise @model.CliError {
  if !declaration {
    for i = self.scopes.length() - 1; i >= 0; i = i - 1 {
      if self.scopes[i].contains(name) {
        self.scopes[i][name] = value
        return
      }
    }
    raise CliError("undefined variable: \{name}")
  }
  self.scopes[self.scopes.length() - 1][name] = value
}

///|
fn template_env(root : TemplateValue, kinds : TemplateValue) -> TemplateEnv {
  { scopes: [{ "$": root, "__allKinds": kinds }], }
}

///|
fn template_value_bytes(value : TemplateValue) -> Bytes {
  match value {
    RawText(bytes) => bytes
    _ => @utf8.encode(template_value_string(value))
  }
}
