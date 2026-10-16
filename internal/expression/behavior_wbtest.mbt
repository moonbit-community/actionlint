///|
test "format placeholders use 64-bit saturated indices and brace parity" {
  for
    (text, expected) in [
      ("{2147483648}", [2147483648L]),
      ("{9223372036854775807}", [9223372036854775807L]),
      ("{9223372036854775808}", [9223372036854775807L]),
      ("{" + "9".repeat(100) + "}", [9223372036854775807L]),
      ("{{0}}", []),
      ("{0}}", []),
      ("{0}}}", [0L]),
      ("{{{0}}}", [0L]),
      ("{} {x{1} {0002}", [1L, 2L]),
    ] {
    let actual = format_placeholders(text).keys().to_array()
    actual.sort()
    assert_eq(actual, expected, msg=text)
  }
}

///|
test "JSON object keys remain case sensitive" {
  let ty = type_from_json({ "Foo": 1, "foo": true })
  assert_eq(ty.name(), "{Foo: number; foo: bool}")
}

///|
test "array merging clears filtering except for unknown-element shortcuts" {
  let filtered = ArrayTy(object_type(props={ "x": NumberTy }), true)
  assert_eq(
    filtered.merge(filtered),
    ArrayTy(object_type(props={ "x": NumberTy }), false),
  )
  assert_eq(ArrayTy(AnyTy, true).merge(filtered), ArrayTy(AnyTy, true))
  assert_eq(filtered.merge(ArrayTy(AnyTy, false)), ArrayTy(AnyTy, false))
}
