///|
test "YAML document marks and tag marks are retained" {
  let root = behavior_node("# comment\n---\non: push\nnumber: !!int \"1\"\n")
  assert_eq((root.document_line, root.document_column), (2, 1))
  let number = root.get("number").unwrap()
  assert_eq((number.tag, number.line, number.column), ("!!int", 4, 9))
  let long = behavior_node("number: !<tag:yaml.org,2002:int> \"1\"\n")
  assert_eq(long.get("number").unwrap().tag, "!!int")
  assert_eq(long.get("number").unwrap().column, 9)
  let check = @model.Check::{ errors: [], }
  assert_true(parse_yaml("# comment\n", check) is None)
  assert_eq(check.errors.length(), 0)
}

///|
test "verbatim tag adaptation preserves quoted plain and block scalar content" {
  for
    source in [
      "x: \"!<tag:yaml.org,2002:int> 😀\"\n", "x: '!<tag:yaml.org,2002:int>'\n",
      "x: plain !<tag:yaml.org,2002:int>\n", "x: |\n  !<tag:yaml.org,2002:int>\n",
      "# !<tag:yaml.org,2002:int>\nx: 1\n",
    ] {
    assert_eq(yaml_parser_source(source), source)
  }
}

///|
test "YAML flow parser context and scanner coordinates follow baseline" {
  for
    (source, line, column, message) in [
      ("on: [push\n", 1, 4, "did not find expected ',' or ']'"),
      ("on:\n  push: [foo\n", 1, 8, "did not find expected ',' or ']'"),
      ("on: {push\n", 1, 4, "did not find expected ',' or '}'"),
      ("on: [push}\n", 0, 4, "did not find expected ',' or ']'"),
      (
        "on: push\njobs: - foo\n", 2, 6, "block sequence entries are not allowed in this context",
      ),
    ] {
    let check = @model.Check::{ errors: [], }
    assert_true(parse_yaml(source, check) is None)
    assert_eq(check.errors.length(), 1)
    let error = check.errors[0]
    assert_eq((error.line, error.column), (line, column))
    assert_eq(error.message, "could not parse as YAML: " + message)
  }
}
