///|
fn docker_escape_error(text : String, host : Bool) -> String? {
  fn hex(c : UInt16) -> Bool {
    c is ('0'..<='9' | 'a'..<='f' | 'A'..<='F')
  }
  let mut i = 0
  while i < text.length() {
    let c = text[i]
    if c == '%' {
      let end = (i + 3).min(text.length())
      let invalid = end - i != 3 || !hex(text[i + 1]) || !hex(text[i + 2])
      if invalid || (host && text[i + 1] < '8' && text[i:end] != "%25") {
        return Some(
          "invalid URL escape " + @model.quote(text[i:end].to_owned()),
        )
      }
      i += 3
    } else {
      if host &&
        c < 128 &&
        !(c is ('a'..<='z' | 'A'..<='Z' | '0'..<='9')) &&
        !"!$&'()*+,;=:[]<>\"-_.~".contains(
          c.to_int().unsafe_to_char().to_string(),
        ) {
        return Some(
          "invalid character " +
          @model.quote(c.to_int().unsafe_to_char().to_string()) +
          " in host name",
        )
      }
      i += 1
    }
  }
  None
}

///|
fn docker_uri_error(uri : String) -> String? {
  // The caller has already split off the first colon following docker://.
  if uri.iter().any(c => c.to_int() < 32 || c.to_int() == 127) {
    return Some("net/url: invalid control character in URL")
  }
  let body = uri[9:].to_owned()
  let fragment = body.find("#")
  let before_fragment = match fragment {
    Some(i) => body[:i]
    None => body[:]
  }
  let query = before_fragment.find("?")
  let path = match query {
    Some(i) => before_fragment[:i]
    None => before_fragment
  }
  let slash = path.find("/").unwrap_or(path.length())
  let authority = path[:slash].to_owned()
  let host = match authority.rev_find("@") {
    Some(i) => authority[i + 1:].to_owned()
    None => authority
  }
  if host.has_prefix("[") {
    guard host.rev_find("]") is Some(end) else {
      return Some("missing ']' in host")
    }
    if end + 1 < host.length() {
      return Some(
        "invalid port " +
        @model.quote(host[end + 1:].to_owned()) +
        " after host",
      )
    }
  }
  if docker_escape_error(host, true) is Some(error) {
    return Some(error)
  }
  if authority.rev_find("@") is Some(i) {
    let user = authority[:i].to_owned()
    if !user
      .iter()
      .all(c => {
        c is ('a'..<='z' | 'A'..<='Z' | '0'..<='9') ||
        "-._~!$&'()*+,;=:%@".contains(c.to_string())
      }) {
      return Some("net/url: invalid userinfo")
    }
    if docker_escape_error(user, false) is Some(error) {
      return Some(error)
    }
  }
  if docker_escape_error(path[slash:].to_owned(), false) is Some(error) {
    return Some(error)
  }
  if fragment is Some(i) {
    return docker_escape_error(body[i + 1:].to_owned(), false)
  }
  None
}

///|
fn @model.Check::check_docker_action(
  self : @model.Check,
  uses : @model.Node,
) -> Unit {
  let spec = uses.value
  let colon = spec[9:].find(":").map(i => i + 9)
  let uri = match colon {
    Some(i) => spec[:i].to_owned()
    None => spec
  }
  let tag = match colon {
    Some(i) => spec[i + 1:].to_owned()
    None => ""
  }
  if docker_uri_error(uri) is Some(error) {
    self.report(
      uses,
      "action",
      "URI for Docker container \{@model.quote(uri)} is invalid: parse \{@model.quote(uri)}: \{error} (tag=\{tag})",
    )
  }
  if colon is Some(_) && tag == "" {
    self.report(
      uses,
      "action",
      "tag of Docker action should not be empty: \{@model.quote(uri)}",
    )
  }
}
