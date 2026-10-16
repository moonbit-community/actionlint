///|
test "YAML timestamp resolution validates dates times and timezone form" {
  for
    value in [
      "2024-2-29", "2026-1-1T2:3:4Z", "2026-1-1t2:3:4+08:00", "2026-1-1 2:3:4.125",
    ] {
    assert_true(yaml_timestamp(value), msg=value)
  }
  for
    value in [
      "2026-2-29", "2026-01-01T99:00:00Z", "2026-01-01T00:00:00", "2026-01-01 00:00:00Z",
      "2026-01-01T00:00:60Z",
    ] {
    assert_false(yaml_timestamp(value), msg=value)
  }
}
