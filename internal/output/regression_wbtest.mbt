///|
test "UTF-8 diagnostic positions render wide emoji combining characters and CRLF" {
  let diagnostic = @model.Diagnostic::{
    message: "error",
    line: 1,
    column: 12,
    kind: "expression",
  }
  let (line, indicator) = snippet(diagnostic, "中文😀 x\r\n")
  assert_eq(line, "中文😀 x")
  assert_eq(indicator, "       ^")
  assert_eq(display_width("é中文😀"[:]), 7)
  assert_eq(snippet(diagnostic, "x".repeat(65536)).0, "")
}
