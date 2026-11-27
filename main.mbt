///|
async fn main {
  let status = @cli.run_cli(@env.args())
  @env.exit(status)
}
