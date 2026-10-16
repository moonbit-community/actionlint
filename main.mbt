///|
async fn main {
  let status = @cli.run_cli(@env.args())
  exit_process(status)
}
