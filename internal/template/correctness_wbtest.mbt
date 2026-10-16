///|
test "template scopes restore shadows and retain outer assignments" {
  let data = Json::array([Json::object({ "message": "hello", "filepath": "a" })])
  for
    (format, expected) in [
      (
        "{{$x:=\"outer\"}}{{if true}}{{$x:=\"inner\"}}{{$x}}{{end}}{{$x}}", "innerouter",
      ),
      ("{{$x:=\"outer\"}}{{if true}}{{$x=\"inner\"}}{{end}}{{$x}}", "inner"),
      ("{{$x:=\"outer\"}}{{range .}}{{$x:=\"inner\"}}{{end}}{{$x}}", "outer"),
      ("{{$x:=\"outer\"}}{{range .}}{{$x=\"inner\"}}{{end}}{{$x}}", "inner"),
      ("{{if $x:=true}}{{$x}}{{end}}", "true"),
      ("{{define \"t\"}}{{$}}{{end}}{{template \"t\" \"inner\"}}", "inner"),
    ] {
    validate_template(format)
    assert_eq(format_errors(format, data), expected)
  }
  for
    format in [
      "{{if false}}{{$x:=1}}{{end}}{{$x}}", "{{$x:=1}}{{define \"t\"}}{{$x}}{{end}}",
    ] {
    let rejected = try {
      validate_template(format)
      false
    } catch {
      CliError(_) => true
    }
    assert_true(rejected, msg=format)
  }
}

///|
test "template short circuit evaluates only selected arguments including pipelines" {
  let data = Json::array([])
  for
    (format, expected) in [
      ("{{and false (index . 99)}}", "false"),
      ("{{or true (index . 99)}}", "true"),
      ("{{false | and true}}", "false"),
      ("{{true | or false}}", "true"),
    ] {
    assert_eq(format_errors(format, data), expected)
  }
  assert_true(try_format_errors("{{and true (index . 99)}}", data).1 is Some(_))
  assert_true(try_format_errors("{{eq 1 1.0}}", data).1 is Some(_))
  assert_eq(
    format_errors("{{printf \"%T %T %d\" 1 1.0 9223372036854775807}}", data),
    "int float64 9223372036854775807",
  )
  assert_eq(
    format_errors("{{printf \"%v %d\" nil nil}}", data),
    "<nil> %!d(<nil>)",
  )
  assert_eq(
    format_errors("{{printf \"%s\" \"a\" nil}}", data),
    "a%!(EXTRA <nil>)",
  )
}
