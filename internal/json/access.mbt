///|
pub fn json_strings(value : Json) -> Array[String] {
  match value {
    Array(xs) =>
      xs.map(x => {
        match x {
          String(s) => s
          _ => ""
        }
      })
    _ => []
  }
}

///|
pub fn data_get(value : Json, key : String) -> Json {
  match value {
    Object(m) => m.get(key).unwrap_or(Json::null())
    _ => Json::null()
  }
}

///|
pub fn data_keys(value : Json) -> Array[String] {
  match value {
    Object(m) => m.keys().to_array()
    _ => []
  }
}

///|
// Non-template callers use JSON strings without borrowing missing-value semantics.
pub fn template_string(value : Json) -> String {
  match value {
    String(s) => s
    Null => "<no value>"
    _ => value.stringify()
  }
}
