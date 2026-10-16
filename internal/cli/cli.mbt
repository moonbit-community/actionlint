///|
priv struct CliOptions {
  mut shellcheck : String
  mut oneline : Bool
  mut format : String
  mut config_file : String
  mut init_config : Bool
  mut color : Bool
  mut no_color : Bool
  mut verbose : Bool
  mut debug : Bool
  mut version : Bool
  mut help : Bool
  mut stdin_filename : String
  ignores : Array[String]
  files : Array[String]
}

///|
fn default_options() -> CliOptions {
  {
    shellcheck: "shellcheck",
    oneline: false,
    format: "",
    config_file: "",
    init_config: false,
    color: false,
    no_color: false,
    verbose: false,
    debug: false,
    version: false,
    help: false,
    stdin_filename: "<stdin>",
    ignores: [],
    files: [],
  }
}

///|
fn parse_arguments(argv : Array[String]) -> CliOptions raise @model.CliError {
  let opts = default_options()
  let mut i = 1
  while i < argv.length() {
    let arg = argv[i]
    if arg == "--" {
      opts.files.append(argv[i + 1:])
      break
    }
    if arg == "-" || !arg.has_prefix("-") {
      opts.files.append(argv[i:])
      break
    }
    let stripped = arg.strip_prefix("--").unwrap_or(arg[1:])
    let split = stripped.find("=")
    let key = match split {
      Some(p) => stripped[:p].to_owned()
      None => stripped.to_owned()
    }
    if key == "h" || key == "help" {
      opts.help = true
      break
    }
    if key == "" || key.has_prefix("-") {
      raise CliError("bad flag syntax: \{arg}")
    }
    let mut value = match split {
      Some(p) => stripped[p + 1:].to_owned()
      None => ""
    }
    if ["ignore", "shellcheck", "format", "config-file", "stdin-filename"].contains(
        key,
      ) {
      if split is None {
        i += 1
        if i >= argv.length() {
          raise CliError("flag needs an argument: -\{key}")
        }
        value = argv[i]
      }
      match key {
        "ignore" => opts.ignores.push(value)
        "shellcheck" => opts.shellcheck = value
        "format" => opts.format = value
        "config-file" => opts.config_file = value
        _ => opts.stdin_filename = value
      }
    } else {
      if ![
          "oneline", "init-config", "color", "no-color", "verbose", "debug", "version",
        ].contains(key) {
        raise CliError("flag provided but not defined: -\{key}")
      }
      let boolean = if split is None {
        true
      } else {
        match value {
          "true" | "1" | "t" | "T" | "TRUE" | "True" => true
          "false" | "0" | "f" | "F" | "FALSE" | "False" => false
          _ =>
            raise CliError(
              "invalid boolean value \{@model.quote(value)} for -\{key}: parse error",
            )
        }
      }
      match key {
        "h" | "help" => {
          opts.help = true
          break
        }
        "oneline" => opts.oneline = boolean
        "init-config" => opts.init_config = boolean
        "color" => opts.color = boolean
        "no-color" => opts.no_color = boolean
        "verbose" => opts.verbose = boolean
        "debug" => opts.debug = boolean
        "version" => opts.version = boolean
        _ => raise CliError("flag provided but not defined: -\{key}")
      }
    }
    i += 1
  }
  if opts.stdin_filename == "" {
    opts.stdin_filename = "<stdin>"
  }
  opts
}

///|
/// Run the CLI with an argument vector that includes the executable at index 0.
/// Reads stdin and writes diagnostics using the process standard streams. Returns
/// the actionlint exit status (0, 1, 2, or 3); the caller controls process exit.
pub async fn run_cli(argv : Array[String]) -> Int32 {
  let opts = parse_arguments(argv) catch {
    CliError(message) => {
      @stdio.stderr.write(message + "\n" + usage())
      return 2
    }
  }
  if opts.help {
    @stdio.stderr.write(usage())
    return 0
  }
  if opts.version {
    @stdio.stdout.write(
      "0.0.1\nMoonBit port based on actionlint 1.7.12 (Pyflakes integration removed)\nbuilt with MoonBit for native/wasm\n",
    )
    return 0
  }
  run_linter(opts) catch {
    @model.CliError(message) => {
      @stdio.stderr.write(message + "\n")
      3
    }
    error => {
      @stdio.stderr.write(error.to_string() + "\n")
      3
    }
  }
}

///|
async fn run_linter(opts : CliOptions) -> Int32 {
  for pattern in opts.ignores {
    ignore(
      @matching.compile_re2(pattern) catch {
        CliError(error) =>
          raise @model.CliError(
            "invalid regular expression for ignore pattern \{@model.quote(pattern)}: \{error}",
          )
      },
    )
  }
  if opts.format != "" && !opts.format.contains("{{") {
    raise @model.CliError(
      "template to format error messages must contain at least one {{ }} placeholder: \{opts.format}",
    )
  }
  if opts.format != "" {
    @template.validate_template(opts.format)
  }
  let explicit_config = if opts.config_file == "" {
    None
  } else {
    Some(@config.load_config(opts.config_file, None))
  }
  let files = opts.files
  if opts.init_config {
    return generate_default_config()
  }
  if files.is_empty() {
    let cwd = @env.current_dir().unwrap_or(".")
    guard @project.find_project(cwd) is Some(project) else {
      raise @model.CliError(
        "no project was found in any parent directories of \{@model.quote(cwd)}. check workflows directory is put correctly in your Git repository",
      )
    }
    let dir = @project.path_join(project, ".github/workflows")
    @project.collect_workflows(dir, files)
    if files.is_empty() {
      raise @model.CliError("no YAML file was found in \{@model.quote(dir)}")
    }
    files.sort_by(String::lexical_compare)
  }
  let mut count = 0
  let fields : Array[Json] = []
  let cache = @workflow.metadata_cache()
  let shellcheck = @workflow.resolve_checker(opts.shellcheck)
  let color = !opts.no_color &&
    @env.get_env_var("NO_COLOR").unwrap_or("") == "" &&
    (
      opts.color ||
      (@env.get_env_var("TERM").unwrap_or("") != "dumb" && stdout_is_terminal())
    )
  if opts.debug {
    @stdio.stderr.write("[Linter] Create a Linter instance (MoonBit)\n")
  }
  let diagnostics = StringBuilder()
  for file in files {
    let stdin_ = files.length() == 1 && file == "-"
    let filename = if stdin_ {
      opts.stdin_filename
    } else {
      @project.path_relative(file, @env.current_dir().unwrap_or("."))
    }
    if opts.verbose || opts.debug {
      @stdio.stderr.write(
        if stdin_ {
          "verbose: Reading the input from stdin\n"
        } else {
          "verbose: Reading \{filename}\n"
        },
      )
      @stdio.stderr.write("verbose: Linting \{filename}\n")
    }
    let project = if stdin_ &&
      (opts.stdin_filename == "<stdin>" || !@fs.exists(opts.stdin_filename)) {
      None
    } else {
      @project.find_project(if stdin_ { opts.stdin_filename } else { file })
    }
    let config = match explicit_config {
      Some(config) => config
      None => @config.load_config("", project)
    }
    let source = if stdin_ {
      @stdio.stdin.read_all().text()
    } else {
      @fs.read_file(file).text() catch {
        error =>
          raise @model.CliError(
            "could not read \{@model.quote(file)}: " +
            @project.file_error(error, file),
          )
      }
    }
    let started = @async.now()
    let log_output = StringBuilder()
    let errors = @workflow.lint_source(
      source,
      config,
      cache,
      project,
      shellcheck,
      log=if opts.verbose || opts.debug {
        Some(message => log_output.write_string(message))
      } else {
        None
      },
      filename~,
      debug=opts.debug,
      shellcheck_name=opts.shellcheck,
    )
    if opts.verbose || opts.debug {
      @stdio.stderr.write(log_output.to_string())
    }
    let filtered = errors.filter(error => {
      !opts.ignores.iter().any(p => @matching.regex_match(p, error.message)) &&
      !config.ignored(filename, error.message, project)
    })
    if opts.verbose || opts.debug {
      @stdio.stderr.write(
        "verbose: Found total \{filtered.length()} errors in \{@async.now() - started} ms for \{filename}\n",
      )
    }
    count += filtered.length()
    for error in filtered {
      fields.push(@output.diagnostic_json(error, filename, source))
      if opts.format == "" {
        diagnostics.write_string(
          @output.render_diagnostic(
            error,
            filename,
            source,
            opts.oneline,
            color,
          ),
        )
      }
    }
  }
  @stdio.stdout.write(diagnostics.to_string())
  if opts.format != "" {
    let extra_kinds = []
    if shellcheck is Some(_) {
      extra_kinds.push("shellcheck")
    }
    let (output, error) = @template.try_format_errors_bytes(
      opts.format,
      Json::array(fields),
      extra_kinds~,
    )
    @stdio.stdout.write(output)
    if error is Some(message) && files.length() > 1 {
      raise @model.CliError(message)
    }
  }
  if count > 0 {
    1
  } else {
    0
  }
}

///|
async fn generate_default_config() -> Int32 {
  guard @project.find_project(@env.current_dir().unwrap_or("."))
    is Some(project) else {
    raise @model.CliError(
      "project is not found. check current project is initialized as Git repository and \".github/workflows\" directory exists",
    )
  }
  for name in ["actionlint.yaml", "actionlint.yml"] {
    let path = @project.path_join(project, ".github/" + name)
    if @fs.exists(path) {
      raise @model.CliError(
        "config file already exists at \{@model.quote(path)}",
      )
    }
  }
  let path = @project.path_join(project, ".github/actionlint.yaml")
  @fs.write_file(path, @config.default_config)
  @stdio.stdout.write("Config file was generated at \{@model.quote(path)}\n")
  0
}
