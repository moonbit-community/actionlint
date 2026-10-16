///|
fn normalize_tag(tag : @yaml_parser.Tag) -> String {
  let full = tag.handle + tag.suffix
  match full.strip_prefix("tag:yaml.org,2002:") {
    Some(suffix) => "!!" + suffix.to_owned()
    None => full
  }
}

///|
fn yaml_parse_error(
  receiver : NodeReceiver,
  line : Int32,
  column : Int32,
  info : String,
) -> (Int32, Int32, String) {
  if info.contains("tabs disallowed within this context") {
    return (
      if line == 1 {
        0
      } else {
        line
      },
      (column - 1).max(0),
      "found character that cannot start any token",
    )
  }
  if info == "while scanning a plain scalar, found a tab" {
    return (line, column, "found a tab character that violates indentation")
  }
  if info.contains("did not find expected key") {
    let lines = receiver.source.split("\n").to_array()
    let problem = lines.get(line - 1).unwrap_or("")
    let indentation = problem.length() -
      problem.trim_start(char_set=" ").length()
    return (line - 1, indentation, "did not find expected key")
  }
  let message = if info.find(", ") is Some(at) &&
    info.has_prefix("while parsing ") {
    let tail = info[at + 2:].to_owned()
    if tail.has_prefix("expected ") {
      "did not find " + tail
    } else {
      tail
    }
  } else {
    info
  }
  // yaml/v4 prefers a nonzero context mark over the problem mark, and
  // exposes those parser coordinates as zero-based. Flow context marks are
  // the opening collection tokens, not the final scalar or end of input.
  if info.contains("flow sequence") || info.contains("flow mapping") {
    let kind = if info.contains("flow sequence") { 2 } else { 3 }
    for i = receiver.stack.length() - 1; i >= 0; i = i - 1 {
      let context = receiver.stack[i]
      if context.kind == kind {
        return (
          if context.line > 1 {
            context.line - 1
          } else {
            line - 1
          },
          if context.column > 1 {
            context.column - 1
          } else {
            column
          },
          message,
        )
      }
    }
  }
  (
    if info.has_prefix("while parsing ") ||
      info.has_prefix("did not find expected") {
      line - 1
    } else {
      line
    },
    column,
    message,
  )
}
