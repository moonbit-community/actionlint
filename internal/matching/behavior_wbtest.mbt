///|
test "RE2 quotes and repeat limits are shared by config and CLI patterns" {
  assert_true(regex_match("\\Q[unknown]{1001}\\E", "[unknown]{1001}"))
  assert_true(regex_match("\\Qunknown", "unknown"))
  assert_true(regex_match("\\Qx+\\Ey{2}", "x+yy"))
  ignore(compile_re2("x{1000}"))
  ignore(compile_re2("x{1000,}"))
  ignore(compile_re2("(x{100}){10}"))
  for pattern in ["x{1001}", "x{1,1001}", "x{2,1}", "(x{100}){11}"] {
    let message = try {
      ignore(compile_re2(pattern))
      "accepted"
    } catch {
      CliError(message) => message
    }
    assert_true(
      message.has_prefix("error parsing regexp: invalid repeat count:"),
    )
  }
}
