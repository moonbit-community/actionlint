///|
test "ShellCheck decodes typed fields with zero values and preserves numeric tokens" {
  assert_eq(decode_shellcheck("null").length(), 0)
  let empty = decode_shellcheck("[{}]")[0]
  assert_eq(
    (empty.code, empty.line, empty.column, empty.level, empty.message),
    (0L, 0L, 0L, "", ""),
  )
  assert_eq(
    decode_shellcheck("[{\"code\":9223372036854775807}]")[0].code,
    9223372036854775807L,
  )
  assert_eq(
    decode_shellcheck("[{\"endLine\":{},\"file\":[],\"message\":null}]")[0].message,
    "",
  )
  for
    payload in [
      "{}", "true", "[1]", "[{\"line\":1.0}]", "[{\"line\":1e0}]", "[{\"message\":2}]",
      "[{\"code\":9223372036854775808}]",
    ] {
    let rejected = try {
      ignore(decode_shellcheck(payload))
      false
    } catch {
      CliError(_) => true
    }
    assert_true(rejected, msg=payload)
  }
}
