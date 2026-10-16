///|
async test "semantic errors suppress interpolation diagnostics for the entire string" {
  let source = "on: push\njobs:\n  test:\n    runs-on: ubuntu-latest\n    steps:\n      - run: echo ${{ null }} ${{ no_such }}\n"
  let errors = lint_source(
    source,
    { labels: [], variables: None, paths: [], },
    metadata_cache(),
    None,
    None,
  )
  assert_eq(errors.length(), 1)
  assert_true(errors[0].message.has_prefix("undefined variable \"no_such\""))
}

///|
test "numeric decoding reports failed literals instead of using positive defaults" {
  let root = behavior_node(
    "hex: 0x10\noverflow: 9223372036854775808\nnegative: -1\n",
  )
  assert_eq(root.get("overflow").unwrap().tag, "!!int")
  let check = @model.Check::{ errors: [], }
  check.number_value(root.get("hex").unwrap(), false, positive=true)
  check.number_value(root.get("overflow").unwrap(), true, positive=true)
  check.number_value(root.get("negative").unwrap(), false, positive=true)
  assert_eq(check.errors.length(), 3)
  assert_true(
    check.errors[0].message.contains(
      "strconv.ParseFloat: parsing \"0x10\": invalid syntax",
    ),
  )
  assert_true(
    check.errors[1].message.contains(
      "strconv.Atoi: parsing \"9223372036854775808\": value out of range",
    ),
  )
  assert_true(check.errors[2].message.contains("must be greater than zero"))
}

///|
test "metadata bool decoding distinguishes implicit bools quoted bools and YAML legacy strings" {
  for
    (literal, required, valid) in [
      ("true", true, true),
      ("True", true, true),
      ("false", false, true),
      ("yes", true, true),
      ("\"yes\"", true, true),
      ("off", false, true),
      ("null", false, true),
      ("\"true\"", false, false),
      ("\"false\"", false, false),
      ("garbage", false, false),
      ("1", false, false),
      ("[]", false, false),
    ] {
    let definition = behavior_node("required: " + literal + "\n")
    let errors = []
    metadata_bool(definition.get("required").unwrap(), errors)
    assert_eq(errors.is_empty(), valid, msg=literal)
    if valid {
      assert_eq(metadata_required(definition, true), required, msg=literal)
    }
  }
}

///|
test "metadata null defaults preserve required inputs and secret defaults are ignored" {
  for
    (literal, required) in [
      ("null", true),
      ("~", true),
      ("\"\"", false),
      ("false", false),
    ] {
    let definition = behavior_node("required: true\ndefault: " + literal + "\n")
    assert_eq(metadata_required(definition, true), required)
    assert_true(metadata_required(definition, false))
  }
  assert_true(metadata_specified(Some(behavior_node("[]"))))
  assert_true(metadata_specified(Some(behavior_node("{}"))))
  assert_false(metadata_specified(Some(behavior_node("null"))))
  assert_false(metadata_specified(None))
}

///|
test "action and reusable metadata validate nested field types" {
  let root = behavior_node(
    "runs:\n  using: composite\n  steps: 1\ninputs:\n  Foo:\n    required: garbage\n",
  )
  assert_eq(action_metadata_errors(root), [
    "line 3: cannot unmarshal !!int `1` into []interface {}", "line 6: cannot unmarshal !!str `garbage` into bool",
  ])
  let body = behavior_node("inputs:\n  Foo:\n    required: garbage\n")
  assert_eq(
    reusable_metadata_error(body),
    Some(
      "yaml: unmarshal errors:   line 3: cannot unmarshal !!str `garbage` into bool",
    ),
  )
}

///|
test "Docker URI decoding checks host path fragments and first-colon tags" {
  for
    (uri, expected) in [
      ("docker://a%xx", Some("invalid URL escape \"%xx\"")),
      ("docker://a%41", Some("invalid URL escape \"%41\"")),
      ("docker://a b", Some("invalid character \" \" in host name")),
      ("docker://[abc", Some("missing ']' in host")),
      ("docker://a/path%xx", Some("invalid URL escape \"%xx\"")),
      ("docker://a?query=%xx", None),
      ("docker://a%ff", None),
    ] {
    assert_eq(docker_uri_error(uri), expected)
  }
  let check = @model.Check::{ errors: [], }
  check.check_docker_action(
    @model.node(1, "docker://a:b:", 1, 1, 0, "!!str", 0),
  )
  assert_eq(check.errors.length(), 0)
  check.check_docker_action(@model.node(1, "docker://a:", 1, 1, 0, "!!str", 0))
  assert_eq(check.errors.length(), 1)
}

///|
test "cron searches separately for consecutive occurrences including leap days" {
  assert_eq(cron_interval("0 0 31 FEB *"), 0)
  assert_eq(cron_interval("0 0 29 FEB *"), 126230400)
  assert_eq(cron_interval("TZ=Asia/Shanghai */5 * * * *"), 300)
  let message = try {
    ignore(cron_interval("CRON_TZ=Bad/Zone * * * * *"))
    "accepted"
  } catch {
    CliError(message) => message
  }
  assert_eq(
    message, "provided bad location Bad/Zone: unknown time zone Bad/Zone",
  )
}

///|
async test "rejected event sections cannot expose nested expressions through field lookups" {
  for section in ["outputs", "secrets"] {
    let source = "on:\n  workflow_dispatch:\n    " +
      section +
      ":\n      x:\n        description: ${{ missing }}\njobs:\n  test:\n    runs-on: ubuntu-latest\n    steps:\n      - run: echo ok\n"
    let errors = lint_source(
      source,
      { labels: [], variables: None, paths: [], },
      metadata_cache(),
      None,
      None,
    )
    assert_eq(errors.length(), 1)
    assert_eq(errors[0].kind, "syntax-check")
    assert_true(errors[0].message.has_prefix("expected \"inputs\" key"))
  }
}
