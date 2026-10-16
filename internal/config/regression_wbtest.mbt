///|
test "configuration preserves null versus empty variables and coerces scalar labels" {
  let empty = parse_config("")
  assert_true(empty.variables is None)
  assert_eq(empty.labels, [])
  let configured = parse_config(
    "config-variables: []\nself-hosted-runner:\n  labels: [linux, 123, true, null]\n",
  )
  assert_true(configured.variables is Some([]))
  assert_eq(configured.labels, ["linux", "123", "true"])
}

///|
test "invalid configurations report schema and ignore pattern errors" {
  for
    (source, expected) in [
      ("self-hosted-runner: 42", "cannot unmarshal"),
      ("paths:\n  foo:\n    ignore: foo+", "\"ignore\" must be a sequence node"),
      (
        "paths:\n  foo:\n    ignore: ['(foo']", "invalid regular expression \"(foo\" in \"ignore\"",
      ),
      ("paths:\n  foo.{txt,xml:", "invalid glob pattern"),
      (
        "config-variables: []\nconfig-variables: []", "already defined at line 1",
      ),
    ] {
    try {
      ignore(parse_config(source))
      fail("invalid config was accepted: " + source)
    } catch {
      @model.CliError(message) =>
        assert_true(message.contains(expected), msg=message)
      error => raise error
    }
  }
}

///|
test "path ignores match repository relative paths and all matching configurations" {
  let config = parse_config(
    "paths:\n  '.github/workflows/**/*.yml':\n    ignore: ['undefined variable']\n  '**/test.*':\n    ignore: ['unknown']\n",
  )
  assert_true(
    config.ignored(
      "/repo/.github/workflows/nested/test.yml",
      "undefined variable x",
      Some("/repo"),
    ),
  )
  assert_true(
    config.ignored(
      "/repo/.github/workflows/test.yml",
      "unknown runner",
      Some("/repo"),
    ),
  )
  assert_false(
    config.ignored("/repo/action.yml", "undefined variable x", Some("/repo")),
  )
  assert_false(
    config.ignored(
      "/repo/.github/workflows/test.yml",
      "syntax error",
      Some("/repo"),
    ),
  )
}
