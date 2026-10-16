///|
fn scalar_tag(
  value : String,
  style : Int32,
  explicit : @yaml_parser.Tag?,
) -> String {
  if explicit is Some(tag) {
    return normalize_tag(tag)
  }
  if style != 0 {
    return "!!str"
  }
  match value {
    "" | "~" | "null" | "Null" | "NULL" => "!!null"
    "true" | "True" | "TRUE" | "false" | "False" | "FALSE" => "!!bool"
    ".nan"
    | ".NaN"
    | ".NAN"
    | ".inf"
    | ".Inf"
    | ".INF"
    | "+.inf"
    | "+.Inf"
    | "+.INF"
    | "-.inf"
    | "-.Inf"
    | "-.INF" => "!!float"
    _ => {
      if yaml_timestamp(value) {
        return "!!timestamp"
      }
      let plain = value.replace_all(old="_", new="")
      if (try @string.parse_int64(plain) catch {
          _ => None
        } noraise {
          _ => Some(())
        })
        is Some(_) ||
        (try @string.parse_uint64(plain) catch {
          _ => None
        } noraise {
          _ => Some(())
        })
        is Some(_) {
        return "!!int"
      }
      if @matching.regex_match(
          "^[-+]?(\\.[0-9]+|[0-9]+(\\.[0-9]*)?)([eE][-+]?[0-9]+)?$", plain,
        ) {
        if (try @string.parse_double(plain) catch {
            _ => None
          } noraise {
            n => Some(n)
          })
          is Some(n) &&
          !n.is_inf() {
          return "!!float"
        }
      }
      "!!str"
    }
  }
}

///|
priv struct NodeReceiver {
  source : String
  stack : Array[@model.Node]
  roots : Array[@model.Node]
  anchors : Map[Int32, @model.Node]
  used : Map[Int32, Bool]
  mut document : (Int32, Int32)
}

///|
impl @yaml_parser.MarkedEventReceiver for NodeReceiver with fn on_event(
  self,
  event,
  mark,
) {
  let n = match event {
    DocumentStart => {
      self.document = (mark.line, 1)
      return
    }
    Scalar(value~, style~, id~, tag~) => {
      let style = match style {
        Plain => 0
        SingleQuoted => 1
        DoubleQuoted => 2
        Literal => 3
        Folded => 4
      }
      @model.node(
        1,
        value,
        mark.line,
        mark.col + 1,
        style,
        scalar_tag(value, style, tag),
        id,
      )
    }
    SequenceStart(id~, tag~) =>
      @model.node(
        2,
        "",
        mark.line,
        mark.col + 1,
        0,
        tag.map(normalize_tag).unwrap_or("!!seq"),
        id,
      )
    MappingStart(id~, tag~) =>
      @model.node(
        3,
        "",
        mark.line,
        mark.col + 1,
        0,
        tag.map(normalize_tag).unwrap_or("!!map"),
        id,
      )
    Alias(id~) => {
      self.used[id] = true
      @model.node(4, "", mark.line, mark.col + 1, 0, "", id)
    }
    SequenceEnd | MappingEnd => {
      ignore(self.stack.pop())
      return
    }
    _ => return
  }
  let explicit = match event {
    Scalar(tag~, ..) | SequenceStart(tag~, ..) | MappingStart(tag~, ..) =>
      tag is Some(_)
    _ => false
  }
  n.tagged = explicit
  if explicit {
    let lines = self.source.split("\n").to_array()
    let line = lines.get(n.line - 1).unwrap_or("")
    let prefix = line[:(n.column - 1).min(line.length())]
    // The event marks the scalar/collection after its tag. Find the beginning
    // of the tag token in that prefix, including verbatim !<...> tags.
    if prefix.rev_find("!") is Some(at) {
      let start = if at > 0 && prefix[at - 1] == '!' { at - 1 } else { at }
      n.column = start + 1
    }
  }
  if self.stack.last() is Some(parent) &&
    parent.kind == 3 &&
    parent.children.length() % 2 == 1 &&
    parent.children.last() is Some(key) {
    let lines = self.source.split("\n").to_array()
    if key.line > 0 && key.line <= lines.length() {
      let line = lines[key.line - 1]
      if line[(key.column - 1).min(line.length()):].find(":") is Some(relative) {
        let colon = key.column - 1 + relative
        if n.kind == 1 && n.value == "" && n.style == 0 && n.anchor == 0 {
          n.line = key.line
          n.column = colon + 2
        }
        let tail = line[colon + 1:]
        if n.anchor != 0 && n.kind != 4 && tail.find("&") is Some(start) {
          let rest = tail[start + 1:]
          let name = rest.split(" ").next().unwrap_or("").trim().to_owned()
          n.anchor_name = name
          n.line = key.line
          n.column = colon + start + 2
        } else if n.kind == 1 && (n.style == 3 || n.style == 4) {
          let start = colon + 1 + (tail.length() - tail.trim_start().length())
          n.line = key.line
          n.column = start + 1
        }
      }
    }
  }
  if n.kind == 1 &&
    n.value == "" &&
    n.style == 0 &&
    n.anchor == 0 &&
    self.stack.last() is Some(parent) &&
    parent.kind == 2 {
    let lines = self.source.split("\n").to_array()
    let lower = parent.children.last().map(n => n.line).unwrap_or(parent.line)
    let mut i = (n.line - 1).min(lines.length() - 1)
    while i >= lower - 1 && i >= 0 {
      let line = lines[i]
      let stripped = line.trim_start()
      if stripped.has_prefix("-") &&
        (stripped[1:].trim() == "" || stripped[1:].trim_start().has_prefix("#")) {
        n.line = i + 1
        n.column = line.length() - stripped.length() + 2
        break
      }
      i -= 1
    }
  }
  if n.kind == 1 &&
    (n.style == 3 || n.style == 4) &&
    self.stack.last() is Some(parent) &&
    parent.kind == 2 {
    let lines = self.source.split("\n").to_array()
    let mut i = (n.line - 2).min(lines.length() - 1)
    while i >= 0 {
      let line = lines[i]
      let trimmed = line.trim_start()
      if trimmed.has_prefix("- |") || trimmed.has_prefix("- >") {
        n.line = i + 1
        n.column = line.length() - trimmed.length() + 3
        break
      }
      i -= 1
    }
  }
  if n.anchor != 0 && n.kind != 4 {
    self.anchors[n.anchor] = n
  }
  match self.stack.last() {
    Some(parent) => parent.children.push(n)
    None => {
      n.document_line = self.document.0
      n.document_column = self.document.1
      self.roots.push(n)
    }
  }
  if n.kind == 2 || n.kind == 3 {
    self.stack.push(n)
  }
}

///|
fn resolve_alias(
  n : @model.Node,
  anchors : Map[Int32, @model.Node],
  active : Map[Int32, Bool],
  check : @model.Check,
) -> @model.Node {
  if n.kind == 4 {
    if anchors.get(n.anchor) is Some(target) {
      if active.get(n.anchor) == Some(true) {
        check.syntax(
          n,
          "recursive alias \{@model.quote(target.anchor_name)} is found. anchor was declared at line:\{target.line}, column:\{target.column}",
        )
        return n
      }
      return target
    }
    return n
  }
  if n.anchor != 0 {
    active[n.anchor] = true
  }
  for i in 0..<n.children.length() {
    n.children[i] = resolve_alias(n.children[i], anchors, active, check)
  }
  if n.anchor != 0 {
    active[n.anchor] = false
  }
  n
}

///|
pub fn parse_yaml(
  source : String,
  check : @model.Check,
  aliases~ : Bool = true,
) -> @model.Node? {
  if source
    .iter()
    .any(c => {
      !(c
      is ('\t'
      | '\n'
      | '\r'
      | '\u0020'..<='\u007e'
      | '\u0085'
      | '\u00a0'..<='\ud7ff'
      | '\ue000'..<='\ufffd'
      | '\u{10000}'..<='\u{10ffff}'))
    }) {
    check.errors.push({
      message: "could not parse as YAML: control characters are not allowed",
      line: 0,
      column: 0,
      kind: "syntax-check",
    })
    return None
  }
  let source = yaml_line_breaks(source)
  // The dependency skips tab-only lines before a document. yaml/v4 treats
  // a tab in indentation as a scanner error, including comment-only input.
  for i, line in source.split("\n").to_array() {
    let tail = line.trim_start(char_set=" ")
    if tail.has_prefix("\t") {
      check.errors.push({
        message: "could not parse as YAML: found character that cannot start any token",
        line: if i == 0 {
          0
        } else {
          i + 1
        },
        column: line.length() - tail.length(),
        kind: "syntax-check",
      })
      return None
    }
    if tail != "" && !tail.has_prefix("#") {
      break
    }
  }
  let receiver = NodeReceiver::{
    source,
    stack: [],
    roots: [],
    anchors: {},
    used: {},
    document: (1, 1),
  }
  @yaml_parser.Parser::new(yaml_parser_source(source)).load(receiver, false) catch {
    YamlError(mark~, info~) => {
      if info.contains("unknown anchor") {
        let lines = source.split("\n").to_array()
        let line = lines.get(mark.line - 1).unwrap_or("")
        let tail = line[mark.col.min(line.length()):]
          .strip_prefix("*")
          .unwrap_or("")
        let name = tail.split(" ").next().unwrap_or("").trim().to_owned()
        check.errors.push({
          message: "could not parse as YAML: yaml: unknown anchor '\{name}' referenced",
          line: 0,
          column: 0,
          kind: "syntax-check",
        })
      } else {
        let (line, column, message) = yaml_parse_error(
          receiver,
          mark.line,
          mark.col,
          info,
        )
        check.errors.push({
          message: "could not parse as YAML: " + message,
          line,
          column,
          kind: "syntax-check",
        })
      }
      return None
    }
  }
  // Anchor identifiers are assigned in source order by the event parser. Recover
  // spelling and definition coordinates from each anchored node's source prefix.
  let lines = source.split("\n").to_array()
  for _, n in receiver.anchors {
    let mut found = n.anchor_name != ""
    let mut ln = n.line - 1
    while ln >= 0 && !found {
      let line = lines[ln]
      let end = if ln == n.line - 1 {
        (n.column - 1).min(line.length())
      } else {
        line.length()
      }
      let prefix = line[:end].to_owned()
      if prefix.rev_find("&") is Some(start) {
        let rest = prefix[start + 1:]
        let name = rest
          .split(" ")
          .next()
          .unwrap_or("")
          .to_owned()
          .trim()
          .to_owned()
        if name != "" {
          n.anchor_name = name
          n.line = ln + 1
          n.column = start + 1
          found = true
        }
      }
      ln -= 1
    }
    if aliases && receiver.used.get(n.anchor) != Some(true) {
      check.syntax(
        n,
        "anchor \{@model.quote(n.anchor_name)} is defined but not used",
      )
    }
  }
  if receiver.roots.get(0) is Some(root) {
    normalize_nodes(root, source)
    Some(resolve_alias(root, receiver.anchors, {}, check))
  } else {
    None
  }
}

///|
fn normalize_nodes(n : @model.Node, source : String) -> Unit {
  for child in n.children {
    normalize_nodes(child, source)
  }
  if n.kind == 3 && n.anchor == 0 && !n.tagged {
    if n.children.get(0) is Some(key) {
      let lines = source.split("\n").to_array()
      if key.line <= 0 || key.line > lines.length() {
        return
      }
      let line = lines[key.line - 1]
      let prefix = line[:(key.column - 1).min(line.length())].trim_end()
      n.line = key.line
      n.column = if prefix.has_suffix("{") {
        prefix.length()
      } else {
        key.column
      }
    }
  }
}
