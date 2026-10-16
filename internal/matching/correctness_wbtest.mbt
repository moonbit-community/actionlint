///|
test "Go regex adapter accepts ordinary patterns" {
  for
    (pattern, input) in [
      ("^[+-]?[0-9]+$", "5"),
      ("\\d+", "5"),
      ("^(\\.[A-Za-z_][A-Za-z_0-9]*)+$", ".Kind"),
      ("(?i)foo", "FOO"),
      ("[[:alpha:]]", "z"),
      ("\\p{Greek}", "α"),
    ] {
    let compiled = compile_re2(pattern) catch {
      CliError(reason) =>
        fail(
          pattern + ": " + reason + "; translated: " + re2_translate(pattern),
        )
    }
    assert_true(compiled.execute(input).matched(), msg=pattern)
  }
  assert_true(regex_match("^(?i)\\Qab\\E+$", "ABBB"))
  assert_false(regex_match("^(?i)\\Qab\\E+$", "ABAB"))
  assert_true(regex_match("[a-z-a]", "-"))
}

///|
test "runner and config glob dialects match their own character classes and segments" {
  assert_true(glob_match("foo[!x]", "foo!", false))
  assert_false(glob_match("foo[!x]", "fooy", false))
  assert_true(glob_match("foo[!x]", "fooy", true))
  assert_true(glob_match("foo[^x]", "fooy", false))
  assert_true(glob_match("[!]", "!", false))
  assert_false(glob_valid("[!]"))
  assert_true(parse_path_glob("[]", false) is None)
  assert_true(glob_match("a/**/b", "a/b", true))
  assert_true(glob_match("a/**/b", "a/x/y/b", true))
  assert_false(glob_match("a**b", "a/x/b", true))
  assert_true(glob_match("foo/**", "foo", true))
  assert_true(glob_match("[z-a]", "z", true))
  assert_false(glob_match("[z-a]", "z", false))
  assert_true(glob_match("{a,b}/**/*.yml", "b/main.yml", true))
  assert_false(glob_match("{a,b}", "a", false))
  assert_true(glob_match("[é-中]", "界", false) == false)
}
