///|
pub(all) struct Node {
  mut retained : Bool
  kind : Int32
  value : String
  mut line : Int32
  mut column : Int32
  mut document_line : Int32
  mut document_column : Int32
  style : Int32
  tag : String
  anchor : Int32
  mut tagged : Bool
  mut anchor_name : String
  children : Array[Node]
} derive(Debug)

///|
pub fn node(
  kind : Int32,
  value : String,
  line : Int32,
  column : Int32,
  style : Int32,
  tag : String,
  anchor : Int32,
) -> Node {
  {
    retained: true,
    kind,
    value,
    line,
    column,
    document_line: line,
    document_column: column,
    style,
    tag,
    anchor,
    tagged: false,
    anchor_name: "",
    children: [],
  }
}

///|
pub fn Node::get(self : Node, key : String) -> Node? {
  for i = 0; i + 1 < self.children.length(); i = i + 2 {
    if self.children[i].retained && self.children[i].value == key {
      return Some(self.children[i + 1])
    }
  }
  None
}

///|
pub fn Node::key(self : Node, key : String) -> Node? {
  for i = 0; i + 1 < self.children.length(); i = i + 2 {
    if self.children[i].retained && self.children[i].value == key {
      return Some(self.children[i])
    }
  }
  None
}

///|
pub fn Node::text(self : Node, key : String) -> String {
  match self.get(key) {
    Some(n) => n.value
    None => ""
  }
}

///|
pub fn Node::pairs(self : Node) -> Array[(Node, Node)] {
  if self.kind != 3 {
    return []
  }
  let pairs = []
  for i = 0; i + 1 < self.children.length(); i = i + 2 {
    if self.children[i].retained {
      pairs.push((self.children[i], self.children[i + 1]))
    }
  }
  pairs
}

///|
pub fn Node::items(self : Node) -> Array[Node] {
  if self.kind == 2 {
    self.children
  } else {
    [self]
  }
}

///|
pub fn Node::is_expression(self : Node) -> Bool {
  let s = self.value.trim()
  s.has_prefix("${{") && s.has_suffix("}}") && s[3:].find("${{") is None
}

///|
pub fn Node::kind_name(self : Node) -> String {
  match self.kind {
    1 => "scalar"
    2 => "sequence"
    3 => "mapping"
    4 => "alias"
    _ => "document"
  }
}

///|
pub fn Node::raw_repr(self : Node) -> String {
  match self.kind {
    1 => quote(self.value)
    2 => "[" + self.children.map(Node::raw_repr).join(", ") + "]"
    3 => {
      let pairs = self
        .pairs()
        .map(pair => quote(pair.0.value.to_lower()) + ": " + pair.1.raw_repr())
      pairs.sort_by(String::lexical_compare)
      "{" + pairs.join(", ") + "}"
    }
    _ => ""
  }
}

///|
pub fn Node::get_ci(self : Node, key : String) -> Node? {
  for (k, v) in self.pairs() {
    if k.value.to_lower() == key.to_lower() {
      return Some(v)
    }
  }
  None
}

///|
pub fn Node::contains_expression(self : Node) -> Bool {
  match (self.value.find("${{"), self.value.find("}}")) {
    (Some(start), Some(end)) => start < end
    _ => false
  }
}
