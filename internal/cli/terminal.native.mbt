///|
extern "c" fn terminal_fd(fd : Int32) -> Bool = "actionlint_isatty"

///|
fn stdout_is_terminal() -> Bool {
  terminal_fd(1)
}
