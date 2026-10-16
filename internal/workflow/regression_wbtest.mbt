///|
test "checker arguments preserve quoting empty arguments and escaped whitespace" {
  assert_eq(
    shell_words("python3 'path with spaces.py' \"\" argument\\ with\\ spaces"),
    Some(["python3", "path with spaces.py", "", "argument with spaces"]),
  )
  assert_eq(shell_words("python3 'unclosed"), None)
  assert_eq(shell_words("python3 trailing\\"), None)
}

///|
test "script substitutions keep UTF-8 byte offsets for external checkers" {
  assert_eq(
    sanitize_script("echo ${{ github.ref }}\necho '${{ '中文' }}'"),
    "echo " + "_".repeat(17) + "\necho '" + "_".repeat(15) + "'",
  )
}

///|
test "cron intervals account for fields names and Sunday" {
  assert_eq(cron_interval("*/5 * * * *"), 300)
  assert_eq(cron_interval("* * * * *"), 60)
  assert_eq(cron_interval("0 0 * * SUN"), 604800)
  assert_eq(cron_interval("0 0 1 JAN *"), 31536000)
}
