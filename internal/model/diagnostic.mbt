///|
pub(all) struct Diagnostic {
  message : String
  line : Int32
  column : Int32
  kind : String
}

///|
pub fn quote(s : String) -> String {
  string_quote(s)
}

///|
pub fn quotes(ss : Array[String]) -> String {
  let sorted = ss.copy()
  sorted.sort_by(String::lexical_compare)
  sorted.map(quote).join(", ")
}

///|
pub fn Diagnostic::oneline(self : Diagnostic, file : String) -> String {
  "\{file}:\{self.line}:\{self.column}: \{self.message} [\{self.kind}]"
}

///|
pub fn sorted_diagnostics(errors : Array[Diagnostic]) -> Array[Diagnostic] {
  errors.sort_by((a, b) => {
    if a.line != b.line {
      a.line.compare(b.line)
    } else if a.column != b.column {
      a.column.compare(b.column)
    } else {
      a.message.lexical_compare(b.message)
    }
  })
  let result : Array[Diagnostic] = []
  for error in errors {
    if result.last() is Some(previous) &&
      previous.line == error.line &&
      previous.column == error.column &&
      previous.message == error.message {
      continue
    }
    result.push(error)
  }
  result
}

///|
pub(all) struct Check {
  errors : Array[Diagnostic]
}

///|
pub fn Check::report(
  self : Check,
  n : Node,
  kind : String,
  message : String,
) -> Unit {
  self.errors.push({ message, line: n.line, column: n.column, kind, })
}

///|
pub fn Check::syntax(self : Check, n : Node, message : String) -> Unit {
  self.report(n, "syntax-check", message)
}
