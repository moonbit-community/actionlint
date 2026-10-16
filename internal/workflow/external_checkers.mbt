///|
pub async fn find_executable(command : String) -> String? {
  if command == "" {
    return None
  }
  if command.contains("/") {
    if (@fs.can_execute(command) catch { _ => false }) {
      return Some(command)
    }
    return None
  }
  for directory in @env.get_env_var("PATH").unwrap_or("").split(":") {
    if directory == "" || directory == "." {
      continue
    }
    let path = @project.path_join(directory.to_owned(), command)
    if (@fs.can_execute(path) catch { _ => false }) {
      return Some(path)
    }
  }
  None
}

///|
// Parse arguments without invoking a shell, expanding variables, or executing substitutions.
fn shell_words(source : String) -> Array[String]? {
  let words = []
  let mut word = StringBuilder()
  let mut quote_ : Char? = None
  let mut escaped = false
  let mut started = false
  for c in source {
    if escaped {
      if quote_ == Some('"') &&
        c != '"' &&
        c != '\\' &&
        c != '$' &&
        c != '`' &&
        c != '\n' {
        word.write_char('\\')
      }
      if c != '\n' {
        word.write_char(c)
      }
      escaped = false
      started = true
    } else if c == '\\' && quote_ != Some('\'') {
      escaped = true
      started = true
    } else if quote_ is Some(q) {
      if c == q {
        quote_ = None
      } else {
        word.write_char(c)
      }
    } else if c == '\'' || c == '"' {
      quote_ = Some(c)
      started = true
    } else if c is (' ' | '\t' | '\n' | '\r') {
      if started {
        words.push(word.to_string())
        word = StringBuilder()
        started = false
      }
    } else {
      word.write_char(c)
      started = true
    }
  }
  if quote_ is Some(_) || escaped {
    return None
  }
  if started {
    words.push(word.to_string())
  }
  Some(words)
}

///|
pub async fn resolve_checker(command : String) -> String? {
  if find_executable(command) is Some(path) {
    return Some(path)
  }
  if shell_words(command) is Some(words) &&
    words.get(0) is Some(executable) &&
    find_executable(executable) is Some(_) {
    return Some(command)
  }
  None
}

///|
fn sanitize_script(source : String) -> String {
  let out = StringBuilder()
  let mut remaining = source[:]
  while remaining.find("${{") is Some(start) {
    guard remaining[start:].find("}}") is Some(end_) else { break }
    let end = start + end_ + 2
    out.write_view(remaining[:start])
    out.write_string("_".repeat(@utf8.encode(remaining[start:end]).length()))
    remaining = remaining[end:]
  }
  out.write_view(remaining)
  out.to_string()
}

///|
async fn run_checker(
  command : String,
  args : Array[String],
  input : String,
) -> String {
  let (executable, arguments) = if find_executable(command) is Some(path) {
    (path, args)
  } else {
    guard shell_words(command) is Some(words) &&
      words.get(0) is Some(program) &&
      find_executable(program) is Some(path) else {
      raise @model.CliError(
        "could not resolve external command " + @model.quote(command),
      )
    }
    (path, words[1:].to_owned() + args)
  }
  let (code, stdout, stderr) = @async.with_task_group(group => {
    let (reader, writer) = @process.write_to_process()
    group.spawn_bg(() => {
      defer writer.close()
      writer.write(input) catch {
        _ => ()
      }
    })
    @process.collect_output(executable, arguments, stdin=reader)
  })
  let result = stdout.text()
  if code != 0 && result == "" {
    raise @model.CliError(
      "\{command} exited with status \{code} but stdout was empty. stderr: \{@model.quote(stderr.text())}",
    )
  }
  result
}

///|
async fn @model.Check::external_checkers(
  self : @model.Check,
  workflow : @model.Node,
  shellcheck : String?,
) -> Unit {
  guard workflow.get("jobs") is Some(jobs) else { return }
  let workflow_shell = default_shell(workflow)
  for (_, job) in jobs.pairs() {
    let job_shell = default_shell(job)
    guard job.get("steps") is Some(steps) && steps.kind == 2 else { continue }
    for step in steps.children {
      guard step.get("run") is Some(run) else { continue }
      let key = step.key("run").unwrap_or(run)
      let step_shell = step.text("shell")
      let configured = if step_shell != "" {
        step_shell
      } else if job_shell != "" {
        job_shell
      } else {
        workflow_shell
      }
      let shell = if configured != "" {
        configured
      } else if runner_platform(job) == 2 {
        "pwsh"
      } else {
        "bash"
      }
      let source = sanitize_script(run.value)
      if shellcheck is Some(command) &&
        (
          shell == "bash" ||
          shell == "sh" ||
          shell.has_prefix("bash ") ||
          shell.has_prefix("sh ")
        ) {
        let shell = if shell.has_prefix("bash") { "bash" } else { "sh" }
        let setup = if shell == "bash" { "set -eo pipefail" } else { "set -e" }
        let args = [
          "--norc", "-f", "json", "-x", "--shell", shell, "-e", "SC1091,SC2194,SC2050,SC2153,SC2154,SC2157,SC2043",
          "-",
        ]
        let output = run_checker(command, args, setup + "\n" + source + "\n") catch {
          error => {
            let reason = match error {
              @model.CliError(reason) => reason
              _ => error.to_string()
            }
            raise @model.CliError(
              "`\{command} \{args.join(" ")}` did not run successfully while checking script at line:\{key.line},col:\{key.column}: \{reason}",
            )
          }
        }
        for error in decode_shellcheck(output) {
          self.report(
            key,
            "shellcheck",
            "shellcheck reported issue in this script: SC\{error.code}:\{error.level}:\{error.line - 1L}:\{error.column}: \{error.message.strip_suffix(".").unwrap_or(error.message[:])}",
          )
        }
      }
    }
  }
}
