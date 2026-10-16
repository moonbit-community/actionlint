///|
async fn stdout_is_terminal() -> Bool {
  if @workflow.find_executable("sh") is Some(shell) {
    (@process.run(
      shell,
      ["-c", "test -t 1"],
      stdout=@stdio.stdout,
      stderr=@stdio.stderr,
    ) catch {
      _ => 1
    }) ==
    0
  } else {
    false
  }
}
