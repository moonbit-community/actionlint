///|
fn @model.Check::glob_error(
  self : @model.Check,
  n : @model.Node,
  offset : Int32,
  message : String,
) -> Unit {
  let quoted = if n.style == 1 || n.style == 2 { 1 } else { 0 }
  self.errors.push({
    message: message +
    ". note: filter pattern syntax is explained at https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#filter-pattern-cheat-sheet",
    line: n.line,
    column: n.column + quoted + (offset - 1).max(0),
    kind: "glob",
  })
}

///|
fn @model.Check::check_glob(
  self : @model.Check,
  n : @model.Node,
  ref_ : Bool,
) -> Unit {
  let s = n.value
  if s == "" {
    return
  }
  if !ref_ {
    if s.trim() != s[:] {
      self.glob_error(
        n, 0, "leading and trailing spaces are not allowed in glob path",
      )
      return
    }
    let p = s.strip_prefix("!").unwrap_or(s[:])
    if p == "." || p == ".." || p.has_prefix("./") || p.has_prefix("../") {
      self.glob_error(n, 0, "'.' and '..' are not allowed in glob path")
      return
    }
  }
  let cs = s.to_array()
  let mut i = 0
  let mut preceding = false
  if cs[0] == '!' {
    i = 1
    if cs.length() == 1 {
      self.glob_error(
        n, 1, "invalid glob pattern. unexpected character '!' while checking ! at first character (negate pattern). at least one character must follow !",
      )
      return
    }
  }
  while i < cs.length() {
    let c = cs[i]
    let mut prec = true
    match c {
      '?' | '+' => {
        if !preceding {
          let meaning = if c == '?' { "zero or one" } else { "one or more" }
          self.glob_error(
            n,
            i + 1,
            "invalid glob pattern. unexpected character \{@model.char_quote(c)} while checking special character \{c} (\{meaning}). the preceding character must not be special character",
          )
        }
        prec = false
      }
      '*' => prec = false
      '[' => {
        i += 1
        let mut count = 0
        while i < cs.length() && cs[i] != ']' {
          let start = cs[i]
          count += 1
          if i + 1 < cs.length() && cs[i + 1] == '-' {
            i += 2
            count += 1
            if i < cs.length() && cs[i] == ']' {
              self.glob_error(
                n,
                i + 1,
                "invalid glob pattern. unexpected character ']' while checking character range in []. end of range is missing",
              )
              break
            }
            if i < cs.length() && cs[i] < start {
              self.glob_error(
                n,
                i + 1,
                "invalid glob pattern. unexpected character \{@model.char_quote(cs[i])} while checking character range in []. start of range \{@model.char_quote(start)} (\{start.to_int()}) is larger than end of range \{@model.char_quote(cs[i])} (\{cs[i].to_int()})",
              )
            }
          }
          i += 1
        }
        if i >= cs.length() {
          self.glob_error(
            n,
            cs.length(),
            "invalid glob pattern. unexpected EOF while checking end of character match []. missing ]",
          )
          return
        }
        if count == 0 {
          self.glob_error(
            n,
            i + 1,
            "invalid glob pattern. unexpected character ']' while checking content of character match []. character match must not be empty",
          )
        }
        if count == 1 {
          self.glob_error(
            n,
            i + 1,
            "invalid glob pattern. unexpected character ']' while checking character match []. character match with single character is useless. simply use x instead of [x]",
          )
        }
      }
      '\\' =>
        if i + 1 < cs.length() &&
          ['[', '?', '*', '+', '\\', '!'].contains(cs[i + 1]) {
          i += 1
        } else if ref_ {
          self.glob_error(
            n,
            i + 1,
            "character '\\' is invalid for branch and tag names. only special characters [, ?, +, *, \\, ! can be escaped with \\. see `man git-check-ref-format` for more details. note that regular expression is unavailable",
          )
          i += 1
        }
      '\n' | '\r' =>
        self.glob_error(
          n,
          0,
          "invalid glob pattern. unexpected character \{@model.char_quote(c)}. newline cannot be contained",
        )
      ' ' | '\t' | '~' | '^' | ':' =>
        if ref_ {
          self.glob_error(
            n,
            i + 1,
            "character \{@model.char_quote(c)} is invalid for branch and tag names. ref name cannot contain spaces, ~, ^, :, [, ?, *. see `man git-check-ref-format` for more details. note that regular expression is unavailable",
          )
        }
      '/' =>
        if ref_ && i == 0 {
          self.glob_error(
            n, 1, "character '/' is invalid for branch and tag names. ref name must not start with /. see `man git-check-ref-format` for more details. note that regular expression is unavailable",
          )
        }
      _ => ()
    }
    if ref_ && i == cs.length() - 1 && (c == '/' || c == '.') {
      self.glob_error(
        n,
        i + 1,
        "character \{@model.char_quote(c)} is invalid for branch and tag names. ref name must not end with / and .. see `man git-check-ref-format` for more details. note that regular expression is unavailable",
      )
    }
    preceding = prec
    i += 1
  }
}
