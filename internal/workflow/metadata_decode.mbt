///|
fn metadata_specified(value : @model.Node?) -> Bool {
  value.map(n => n.tag != "!!null").unwrap_or(false)
}

///|
fn metadata_required(definition : @model.Node, default_allowed : Bool) -> Bool {
  definition
  .get("required")
  .map(n => {
    n.kind == 1 &&
    n.tag != "!!null" &&
    ["true", "True", "TRUE", "yes", "Yes", "YES", "y", "Y", "on", "On", "ON"].contains(
      n.value,
    )
  })
  .unwrap_or(false) &&
  (!default_allowed || !metadata_specified(definition.get("default")))
}

///|
fn metadata_type_error(
  n : @model.Node,
  expected : String,
  errors : Array[String],
) -> Unit {
  let literal = if n.kind == 1 { " `" + n.value + "`" } else { "" }
  errors.push(
    "line \{n.line}: cannot unmarshal \{n.tag}\{literal} into \{expected}",
  )
}

///|
fn metadata_collection(
  n : @model.Node,
  kind : Int32,
  expected : String,
  errors : Array[String],
) -> Unit {
  if n.tag != "!!null" && n.kind != kind {
    metadata_type_error(n, expected, errors)
  }
}

///|
fn metadata_struct(
  n : @model.Node,
  expected : String,
  errors : Array[String],
) -> Unit {
  metadata_collection(n, 3, expected, errors)
}

///|
fn metadata_scalar(
  n : @model.Node,
  expected : String,
  errors : Array[String],
) -> Unit {
  if n.tag != "!!null" && n.kind != 1 {
    metadata_type_error(n, expected, errors)
  }
}

///|
fn metadata_bool(n : @model.Node, errors : Array[String]) -> Unit {
  if n.tag == "!!null" {
    return
  }
  let canonical = n.tag == "!!bool" &&
    ["true", "True", "TRUE", "false", "False", "FALSE"].contains(n.value)
  let legacy = n.tag == "!!str" &&
    [
      "yes", "Yes", "YES", "no", "No", "NO", "y", "Y", "n", "N", "on", "On", "ON",
      "off", "Off", "OFF",
    ].contains(n.value)
  if n.kind != 1 || !(canonical || legacy) {
    metadata_type_error(n, "bool", errors)
  }
}

///|
fn action_input_name(inputs : Json, key : String) -> String {
  match @jsonutil.data_get(inputs, key) {
    Array(values) =>
      match values.get(0) {
        Some(String(name)) => name
        _ => key
      }
    _ => key
  }
}

///|
// YAML's decoder checks each mapping it actually decodes. Custom name maps
// implement their own name collisions independently of ordinary YAML keys.
fn metadata_duplicates(n : @model.Node) -> Array[String] {
  let pairs = n.pairs()
  let errors = []
  for i in 0..<pairs.length() {
    for j in (i + 1)..<pairs.length() {
      let previous = pairs[i].0
      let key = pairs[j].0
      if key.value == previous.value && key.tag == previous.tag {
        errors.push(
          "line \{key.line}: mapping key \{@model.quote(key.value)} already defined at line \{previous.line}",
        )
      }
    }
  }
  errors
}

///|
fn metadata_decoded_duplicates(n : @model.Node) -> Array[String] {
  let errors = metadata_duplicates(n)
  if !errors.is_empty() {
    return errors
  }
  if n.kind == 3 {
    for (_, value) in n.pairs() {
      errors.append(metadata_decoded_duplicates(value))
    }
  } else if n.kind == 2 {
    for value in n.children {
      errors.append(metadata_decoded_duplicates(value))
    }
  }
  errors
}
