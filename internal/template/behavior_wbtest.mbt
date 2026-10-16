///|
test "printf handles width zero padding alignment and precision" {
  assert_eq(
    format_errors(
      "{{printf \"%04d|%6.2f|%-5s|%.2s\" 3 1.234 \"x\" \"hello\"}}",
      [],
    ),
    "0003|  1.23|x    |he",
  )
  assert_eq(
    format_errors("{{printf \"%05d|%+05d|%5.3d\" -3 3 3}}", []),
    "-0003|+0003|  003",
  )
}

///|
test "template parentheses and loop control use the nearest range" {
  let data = Json::array([
    Json::object({ "kind": "one", "message": "x", "filepath": "a" }),
    Json::object({ "kind": "two", "message": "y", "filepath": "a" }),
  ])
  for format in ["{{printf \"%s\" (index . 0).Kind}}", "{{((index . 0).Kind)}}"] {
    validate_template(format)
    assert_eq(format_errors(format, data), "one")
  }
  for
    (format, expected) in [
      ("{{range .}}A{{continue}}B{{end}}", "AA"),
      ("{{range .}}A{{range $x := $}}{{break}}B{{end}}C{{end}}", "ACAC"),
      ("{{range .}}{{if .Kind}}X{{break}}{{end}}Y{{end}}", "X"),
    ] {
    validate_template(format)
    assert_eq(format_errors(format, data), expected)
  }
}

///|
test "template runtime failures retain prior output and distinguish empty fields" {
  let data = Json::array([
    Json::object({ "message": "x", "filepath": "a", "kind": "events" }),
  ])
  let (output, error) = try_format_errors(
    "before{{range .}}X{{.Unknown}}Y{{end}}after", data,
  )
  assert_eq(output, "beforeX")
  assert_eq(
    error,
    Some(
      "could not format error messages: template: error formatter:1:20: executing \"error formatter\" at <.Unknown>: can't evaluate field Unknown in type *actionlint.ErrorTemplateFields",
    ),
  )
  assert_eq(
    try_format_errors("{{range .}}[{{.Snippet}}]{{end}}", data),
    ("[]", None),
  )
  assert_eq(try_format_errors("before{{nil}}after", data).0, "before")
}

///|
test "decimal formatting rounds the exact binary value and half ties to even" {
  assert_eq(
    format_errors("{{printf \"%.0f|%.0f|%.2f|%.2f\" 2.5 3.5 2.675 1.005}}", []),
    "2|4|2.67|1.00",
  )
  assert_eq(
    format_errors("{{printf \"%.3e|%.3E|%F|%#g\" 9.9999 9.9999 1.25 1.25}}", []),
    "1.000e+01|1.000E+01|1.250000|1.25000",
  )
  assert_eq(
    format_errors("{{printf \"%.20f\" 0.1}}", []),
    "0.10000000000000000555",
  )
}

///|
test "template string operations preserve bytes across invalid UTF8 boundaries" {
  let (bytes, error) = try_format_errors_bytes(
    "before{{replace \"中\" \"\" \"-\"}}after",
    [],
  )
  assert_eq(bytes, b"before-\xe4-\xb8-\xad-after")
  assert_eq(error, None)
  let (bytes, error) = try_format_errors_bytes("{{slice \"中文\" 0 2}}", [])
  assert_eq(bytes, b"\xe4\xb8")
  assert_eq(error, None)
}

///|
test "known diagnostic references compare by identity across dot and root" {
  let data = Json::array([
    Json::object({ "message": "x", "filepath": "a", "kind": "events" }),
    Json::object({ "message": "x", "filepath": "a", "kind": "events" }),
  ])
  assert_eq(
    format_errors(
      "{{eq (index . 0) (index $ 0)}}|{{eq (index . 0) (index . 1)}}", data,
    ),
    "true|false",
  )
}
