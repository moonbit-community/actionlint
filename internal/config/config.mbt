///|
pub(all) struct Config {
  labels : Array[String]
  variables : Array[String]?
  paths : Array[(String, Array[String])]
}

///|
pub let default_config : String =
  #|self-hosted-runner:
  #|  # Labels of self-hosted runner in array of strings.
  #|  labels: []
  #|
  #|# Configuration variables in array of strings defined in your repository or
  #|# organization. `null` means disabling configuration variables check.
  #|# Empty array means no configuration variable is allowed.
  #|config-variables: null
  #|
  #|# Configuration for file paths. The keys are glob patterns to match to file
  #|# paths relative to the repository root. The values are the configurations for
  #|# the file paths. Note that the path separator is always '/'.
  #|# The following configurations are available.
  #|#
  #|# "ignore" is an array of regular expression patterns. Matched error messages
  #|# are ignored. This is similar to the "-ignore" command line option.
  #|paths:
  #|#  .github/workflows/**/*.yml:
  #|#    ignore: []
  #|

///|
fn config_type_error(
  n : @model.Node,
  expected : String,
  errors : Array[String],
) -> Unit {
  let value = if n.kind == 1 { " `" + n.value + "`" } else { "" }
  errors.push(
    "  line \{n.line}: cannot unmarshal \{n.tag}\{value} into \{expected}",
  )
}

///|
fn config_duplicates(n : @model.Node, errors : Array[String]) -> Unit {
  let seen : Map[String, @model.Node] = Map([])
  for (key, value) in n.pairs() {
    if seen.get(key.value) is Some(previous) {
      errors.push(
        "  line \{key.line}: mapping key \{@model.quote(key.value)} already defined at line \{previous.line}",
      )
    } else {
      seen[key.value] = key
    }
    ignore(value)
  }
}

///|
fn config_strings(n : @model.Node, errors : Array[String]) -> Array[String] {
  if n.tag == "!!null" {
    return []
  }
  if n.kind != 2 {
    config_type_error(n, "[]string", errors)
    return []
  }
  let values = []
  for child in n.children {
    if child.tag == "!!null" {
      continue
    }
    if child.kind != 1 {
      config_type_error(child, "string", errors)
    } else {
      values.push(child.value)
    }
  }
  values
}

///|
pub fn parse_config(source : String) -> Config raise @model.CliError {
  let check = @model.Check::{ errors: [], }
  guard @yaml.parse_yaml(source, check, aliases=false) is Some(root) else {
    if check.errors.is_empty() {
      return { labels: [], variables: None, paths: [], }
    }
    raise CliError(check.errors.map(e => e.message).join(" "))
  }
  if root.tag == "!!null" {
    return { labels: [], variables: None, paths: [], }
  }
  let errors = []
  config_duplicates(root, errors)
  if root.kind != 3 {
    config_type_error(root, "actionlint.Config", errors)
  }
  let labels : Array[String] = []
  if root.get("self-hosted-runner") is Some(runner) && runner.tag != "!!null" {
    config_duplicates(runner, errors)
    if runner.kind != 3 {
      config_type_error(
        runner, "struct { Labels []string \"yaml:\\\"labels\\\"\" }", errors,
      )
    }
    if runner.get("labels") is Some(ls) {
      labels.append(config_strings(ls, errors))
    }
  }
  let variables = match root.get("config-variables") {
    Some(n) =>
      if n.tag == "!!null" {
        None
      } else {
        Some(config_strings(n, errors))
      }
    None => None
  }
  let paths = []
  if root.get("paths") is Some(ps) {
    if ps.kind != 3 && ps.tag != "!!null" {
      config_type_error(ps, "map[string]actionlint.PathConfig", errors)
    }
    config_duplicates(ps, errors)
    for (pattern, settings) in ps.pairs() {
      config_duplicates(settings, errors)
      if !@matching.glob_valid(pattern.value) {
        raise CliError(
          "invalid glob pattern \{@model.quote(pattern.value)} in \"paths\"",
        )
      }
      if settings.kind != 3 && settings.tag != "!!null" {
        config_type_error(settings, "actionlint.PathConfig", errors)
      }
      let ignores : Array[String] = []
      if settings.get("ignore") is Some(is_) && is_.tag != "!!null" {
        if is_.kind != 2 {
          errors.push(
            "  line \{is_.line}: yaml: \"ignore\" must be a sequence node at line:\{is_.line},col:\{is_.column}",
          )
        }
        for p in is_.children {
          ignore(
            @matching.compile_re2(p.value) catch {
              CliError(error) =>
                raise CliError(
                  "yaml: unmarshal errors:   line \{is_.line}: invalid regular expression \{@model.quote(p.value)} in \"ignore\" at line\{is_.line},col:\{is_.column}: \{error}",
                )
            },
          )
          ignores.push(p.value)
        }
      }
      paths.push((pattern.value, ignores))
    }
  }
  if !errors.is_empty() {
    raise CliError("yaml: unmarshal errors: " + errors.join(" "))
  }
  { labels, variables, paths, }
}

///|
pub async fn load_config(explicit : String, project : String?) -> Config {
  let mut path = explicit
  if path == "" && project is Some(root) {
    for name in ["actionlint.yaml", "actionlint.yml"] {
      let candidate = @project.path_join(root, ".github/" + name)
      if @fs.exists(candidate) {
        path = candidate
        break
      }
    }
  }
  if path == "" {
    return { labels: [], variables: None, paths: [], }
  }
  let source = @fs.read_file(path).text() catch {
    error =>
      raise @model.CliError(
        "could not read config file \{@model.quote(path)}: " +
        @project.file_error(error, path),
      )
  }
  parse_config(source) catch {
    CliError(message) => {
      let prefix = "could not parse config file \{@model.quote(path)}: "
      raise @model.CliError(
        prefix + (if explicit == "" { prefix } else { "" }) + message,
      )
    }
  }
}

///|
pub fn Config::ignored(
  self : Config,
  filename : String,
  message : String,
  project : String?,
) -> Bool {
  let path = match project {
    Some(root) => @project.path_relative(filename, root)
    None => filename
  }
  self.paths
  .iter()
  .any(pair => {
    @matching.glob_match(pair.0, path, true) &&
    pair.1.iter().any(pattern => @matching.regex_match(pattern, message))
  })
}
