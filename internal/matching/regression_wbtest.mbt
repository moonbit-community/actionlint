///|
test "regex ignores accept literal braces named captures and flags" {
  assert_true(regex_match("(?i)unknown", "UNKNOWN runner"))
  assert_true(regex_match("(?P<name>missing)", "missing variable"))
  assert_true(regex_match("${{", "contains ${{") == false)
  assert_true(regex_match("\\$\\{\\{", "contains ${{"))
  assert_true(regex_match("x{2}", "xxx"))
}
