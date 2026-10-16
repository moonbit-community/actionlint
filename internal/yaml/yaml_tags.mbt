///|
// The dependency's verbatim-tag scanner does not advance over URI characters.
// Translate standard verbatim tags to shorthand before parsing, keeping all
// offsets and the original receiver source. Quoted/plain scalar contents and
// block scalar bodies must stay byte-for-byte intact.
fn yaml_parser_source(source : String) -> String {
  let prefix = "!<tag:yaml.org,2002:"
  if !source.contains(prefix) {
    return source
  }
  let out = StringBuilder()
  let mut quoted : UInt16 = 0
  let mut block_indent : Int32? = None
  for line in source.split("\n") {
    let indentation = line.length() - line.trim_start(char_set=" ").length()
    if block_indent is Some(parent) {
      if line.trim() == "" || indentation > parent {
        out.write_view(line)
        out.write_char('\n')
        continue
      }
      block_indent = None
    }
    let mut i = 0
    let mut expect_node = true
    let mut escaped = false
    while i < line.length() {
      let c = line[i]
      if quoted != 0 {
        let ch = line.get_char(i).unwrap_or(' ')
        out.write_char(ch)
        if escaped {
          escaped = false
        } else if c == '\\' && quoted == '"' {
          escaped = true
        } else if c == quoted {
          if quoted == '\'' && i + 1 < line.length() && line[i + 1] == '\'' {
            out.write_char('\'')
            i += 1
          } else {
            quoted = 0
          }
        }
        i += if ch.to_int() > 0xffff { 2 } else { 1 }
        continue
      }
      if c == '#' && (i == 0 || line[i - 1] is (' ' | '\t')) {
        out.write_view(line[i:])
        break
      }
      if expect_node &&
        line[i:].has_prefix(prefix) &&
        line[i:].find(">") is Some(end) {
        let tag = "!!" + line[i + prefix.length():i + end].to_owned()
        out.write_string(tag + " ".repeat(end + 1 - tag.length()))
        i += end + 1
        continue
      }
      if expect_node && c is ('\'' | '"') {
        quoted = c
        expect_node = false
      } else if expect_node && c is ('|' | '>') {
        block_indent = Some(indentation)
        out.write_view(line[i:])
        break
      } else if c is ('[' | '{' | ',') ||
        (
          (c == ':' || (c == '-' && expect_node)) &&
          (i + 1 == line.length() || line[i + 1] is (' ' | '\t'))
        ) {
        expect_node = true
      } else if !(c is (' ' | '\t')) {
        expect_node = false
      }
      let ch = line.get_char(i).unwrap_or(' ')
      out.write_char(ch)
      i += if ch.to_int() > 0xffff { 2 } else { 1 }
    }
    out.write_char('\n')
  }
  // split includes the final empty line; remove only the newline added here.
  let result = out.to_string()
  result[:result.length() - 1].to_owned()
}

///|
// YAML recognizes NEL, LS and PS as line breaks in plain nodes. Leave quoted
// nodes intact so their line separator characters keep their scalar meaning.
fn yaml_line_breaks(source : String) -> String {
  if !source.iter().any(c => c is ('\u0085' | '\u2028' | '\u2029')) {
    return source
  }
  let out = StringBuilder()
  let mut quoted : Char? = None
  let mut escaped = false
  let mut expect_node = true
  let mut previous : Char = '\n'
  for c in source {
    if quoted is Some(quote) {
      out.write_char(c)
      if escaped {
        escaped = false
      } else if c == '\\' && quote == '"' {
        escaped = true
      } else if c == quote {
        quoted = None
      }
    } else if c is ('\u0085' | '\u2028' | '\u2029') {
      out.write_char('\n')
      expect_node = true
    } else {
      out.write_char(c)
      if expect_node && c is ('"' | '\'') {
        quoted = Some(c)
        expect_node = false
      } else if c is ('\n' | '[' | '{' | ',' | ':') ||
        (c == '-' && previous is (' ' | '\n')) {
        expect_node = true
      } else if !(c is (' ' | '\t' | '\r')) {
        expect_node = false
      }
    }
    previous = c
  }
  out.to_string()
}
