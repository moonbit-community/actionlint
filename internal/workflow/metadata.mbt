///|
pub struct MetadataCache {
  priv actions : Map[String, @model.Node?]
  priv workflows : Map[String, @model.Node?]
}

///|
pub fn metadata_cache() -> MetadataCache {
  { actions: {}, workflows: {}, }
}

///|
fn local_action_json(root : @model.Node) -> Json {
  let inputs : Map[String, Json] = Map([])
  if root.get("inputs") is Some(definitions) {
    for (name, definition) in definitions.pairs() {
      inputs[name.value.to_lower()] = Json::array([
        Json::string(name.value),
        Json::boolean(metadata_required(definition, true)),
        Json::boolean(definition.get("deprecationMessage") is Some(_)),
        Json::string(definition.text("deprecationMessage").trim().to_owned()),
      ])
    }
  }
  let outputs = match root.get("outputs") {
    Some(outputs) => outputs.pairs().map(p => Json::string(p.0.value))
    None => []
  }
  Json::object({
    "inputs": Json::object(inputs),
    "outputs": Json::array(outputs),
  })
}

///|
async fn MetadataCache::load(
  self : MetadataCache,
  check : @model.Check,
  workflow : @model.Node,
  project : String?,
) -> (Map[String, @model.Node], Map[String, @model.Node]) {
  let actions : Map[String, @model.Node] = Map([])
  let workflows : Map[String, @model.Node] = Map([])
  guard project is Some(project) && workflow.get("jobs") is Some(jobs) else {
    return (actions, workflows)
  }
  for (_, job) in jobs.pairs() {
    if job.get("uses") is Some(uses) &&
      uses.retained &&
      uses.value.has_prefix("./") &&
      !uses.value.contains("@") &&
      !uses.contains_expression() {
      let path = @project.path_join(project, uses.value)
      match self.workflows.get(path) {
        Some(Some(body)) => workflows[uses.value] = body
        Some(None) => ()
        None => {
          self.workflows[path] = None
          if !@fs.exists(path) {
            check.report(
              uses,
              "workflow-call",
              "could not read reusable workflow file for \{@model.quote(uses.value)}: open \{path}: no such file or directory",
            )
          } else {
            let source = @fs.read_file(path).text()
            let parse_check = @model.Check::{ errors: [], }
            if @yaml.parse_yaml(source, parse_check, aliases=false)
              is Some(root) {
              let on = root.get("on")
              let body = match on {
                Some(on) =>
                  if on.kind == 3 {
                    on.get_ci("workflow_call")
                  } else if on
                    .items()
                    .iter()
                    .any(n => n.value.to_lower() == "workflow_call") {
                    Some(@model.node(3, "", on.line, on.column, 0, "!!map", 0))
                  } else {
                    None
                  }
                None => None
              }
              if body is Some(body) {
                if reusable_metadata_error(body) is Some(error) {
                  check.report(
                    uses,
                    "workflow-call",
                    "error while parsing reusable workflow \{@model.quote(uses.value)}: " +
                    error,
                  )
                  continue
                }
                for section in ["inputs", "outputs", "secrets"] {
                  if body.get(section) is Some(names) {
                    metadata_last_names(names)
                  }
                }
                self.workflows[path] = Some(body)
                workflows[uses.value] = body
              } else {
                check.report(
                  uses,
                  "workflow-call",
                  "error while parsing reusable workflow \{@model.quote(uses.value)}: " +
                  (match on {
                    None => "\"on:\" is not found"
                    Some(on) =>
                      "\"workflow_call\" event trigger is not found in \"on:\" at line:\{on.line}, column:\{on.column}"
                  }),
                )
              }
            } else {
              check.report(
                uses,
                "workflow-call",
                "error while parsing reusable workflow \{@model.quote(uses.value)}: " +
                parse_check.errors.map(e => e.message).join(" "),
              )
            }
          }
        }
      }
    }
    if job.get("steps") is Some(steps) && steps.kind == 2 {
      for step in steps.children {
        guard step.get("uses") is Some(uses) &&
          uses.value.has_prefix("./") &&
          !uses.contains_expression() else {
          continue
        }
        let dir = @project.path_join(project, uses.value)
        match self.actions.get(dir) {
          Some(Some(root)) => actions[uses.value] = root
          Some(None) => ()
          None => {
            self.actions[dir] = None
            for name in ["action.yaml", "action.yml"] {
              let file = @project.path_join(dir, name)
              if !@fs.exists(file) {
                continue
              }
              let parse_check = @model.Check::{ errors: [], }
              if @yaml.parse_yaml(
                  @fs.read_file(file).text(),
                  parse_check,
                  aliases=false,
                )
                is Some(root) {
                let errors = action_metadata_errors(root)
                if !errors.is_empty() {
                  let message = if errors.length() == 1 {
                    errors[0]
                  } else {
                    "yaml: unmarshal errors:  " + errors.join("  ")
                  }
                  check.report(
                    uses,
                    "action",
                    "could not parse action metadata in \{@model.quote(dir)}: " +
                    message,
                  )
                  break
                }
                actions[uses.value] = root
                self.actions[dir] = Some(root)
                check.validate_action_metadata(uses, root, dir, name)
              } else {
                check.report(
                  uses,
                  "action",
                  "could not parse action metadata in \{@model.quote(dir)}: " +
                  parse_check.errors.map(e => e.message).join(" "),
                )
              }
              break
            }
          }
        }
      }
    }
  }
  (actions, workflows)
}

///|
fn metadata_mapping_error(section : String, n : @model.Node) -> String {
  "yaml: \{section} must be mapping node but \{n.kind_name()} node was found at line:\{n.line}, col:\{n.column}"
}

///|
fn action_metadata_errors(root : @model.Node) -> Array[String] {
  let errors = metadata_duplicates(root)
  if !errors.is_empty() {
    return errors
  }
  metadata_struct(root, "actionlint.ActionMetadata", errors)
  for (key, value) in root.pairs() {
    match key.value {
      "name" | "description" => metadata_scalar(value, "string", errors)
      "runs" => {
        let duplicates = metadata_duplicates(value)
        if !duplicates.is_empty() {
          errors.append(duplicates)
          continue
        }
        metadata_struct(value, "actionlint.ActionMetadataRuns", errors)
        for (field, entry) in value.pairs() {
          match field.value {
            "steps" | "args" => {
              metadata_collection(entry, 2, "[]interface {}", errors)
              errors.append(metadata_decoded_duplicates(entry))
            }
            "env" => {
              metadata_collection(entry, 3, "map[string]interface {}", errors)
              errors.append(metadata_decoded_duplicates(entry))
            }
            "using"
            | "main"
            | "pre"
            | "pre-if"
            | "post"
            | "post-if"
            | "image"
            | "pre-entrypoint"
            | "entrypoint"
            | "post-entrypoint" => metadata_scalar(entry, "string", errors)
            _ => ()
          }
        }
      }
      "branding" => {
        let duplicates = metadata_duplicates(value)
        if !duplicates.is_empty() {
          errors.append(duplicates)
          continue
        }
        metadata_struct(value, "actionlint.ActionMetadataBranding", errors)
        for (field, entry) in value.pairs() {
          if field.value == "icon" || field.value == "color" {
            metadata_scalar(entry, "string", errors)
          }
        }
      }
      _ => ()
    }
  }
  for section in ["inputs", "outputs"] {
    guard root.get(section) is Some(n) && n.tag != "!!null" else { continue }
    if n.kind != 3 {
      errors.push("line \{n.line}: " + metadata_mapping_error(section, n))
      continue
    }
    let seen : Map[String, Bool] = Map([])
    for (id, definition) in n.pairs() {
      let what = if section == "inputs" { "input" } else { "output" }
      if seen.get(id.value.to_lower()) == Some(true) {
        errors.push(
          "line \{n.line}: \{what} \{@model.quote(id.value)} is duplicated",
        )
        break
      }
      seen[id.value.to_lower()] = true
      if section == "inputs" {
        let duplicates = metadata_duplicates(definition)
        if !duplicates.is_empty() {
          errors.append(duplicates)
          break
        }
        metadata_struct(definition, "actionlint.actionInputMetadata", errors)
        for (key, value) in definition.pairs() {
          if !["description", "required", "default", "deprecationMessage"].contains(
              key.value,
            ) {
            errors.push(
              "line \{n.line}: unexpected key \{@model.quote(key.value)} for definition of input \{@model.quote(id.value)}",
            )
          } else if key.value == "required" {
            metadata_bool(value, errors)
          } else if key.value == "default" || key.value == "deprecationMessage" {
            metadata_scalar(value, "string", errors)
          }
        }
      }
    }
  }
  errors
}

///|
fn reusable_metadata_error(body : @model.Node) -> String? {
  let errors = metadata_duplicates(body)
  if !errors.is_empty() {
    return Some("yaml: unmarshal errors:   " + errors.join("   "))
  }
  metadata_struct(body, "actionlint.ReusableWorkflowMetadata", errors)
  for section in ["inputs", "outputs", "secrets"] {
    if body.get(section) is Some(n) && n.tag != "!!null" {
      if n.kind != 3 {
        return Some(metadata_mapping_error("on.workflow_call." + section, n))
      }
      if section == "outputs" {
        continue
      }
      for (_, definition) in n.pairs() {
        let duplicates = metadata_duplicates(definition)
        if !duplicates.is_empty() {
          errors.append(duplicates)
          break
        }
        metadata_struct(
          definition,
          if section == "inputs" {
            "actionlint.metadata"
          } else {
            "actionlint.ReusableWorkflowMetadataSecret"
          },
          errors,
        )
        for (key, value) in definition.pairs() {
          if key.value == "required" {
            metadata_bool(value, errors)
          } else if section == "inputs" &&
            (key.value == "default" || key.value == "type") {
            metadata_scalar(value, "string", errors)
          }
        }
      }
    }
  }
  if !errors.is_empty() {
    return Some("yaml: unmarshal errors:   " + errors.join("   "))
  }
  None
}

///|
async fn @model.Check::validate_action_metadata(
  self : @model.Check,
  uses : @model.Node,
  root : @model.Node,
  dir : String,
  file : String,
) -> Unit {
  let path = @project.path_join(dir, file)
  let name = root.text("name")
  if name == "" {
    self.report(
      uses,
      "action",
      "name is required in action metadata \{@model.quote(path)}",
    )
  }
  if root.text("description") == "" {
    self.report(
      uses,
      "action",
      "description is required in metadata of \{@model.quote(name)} action at \{@model.quote(path)}",
    )
  }
  if root.get("branding") is Some(branding) {
    for
      (prop, table, what) in [
        ("icon", "BrandingIcons", "icons"),
        ("color", "BrandingColors", "colors"),
      ] {
      let value = branding.text(prop)
      let known = @jsonutil.template_string(
        @jsonutil.data_get(@data.builtin_data, table),
      )
      if value != "" && !known.contains(@model.quote(value.to_lower()) + ":") {
        self.report(
          uses,
          "action",
          "incorrect \{prop}\{if prop == "icon" { " name" } else { "" }} \{@model.quote(value)} at branding.icon in metadata of \{@model.quote(name)} action at \{@model.quote(path)}. see the official document to know the exhaustive list of supported \{what}: https://docs.github.com/en/actions/creating-actions/metadata-syntax-for-github-actions#branding\{prop}",
        )
      }
    }
  }
  if root.get("inputs") is Some(inputs) {
    for (id, definition) in inputs.pairs() {
      if definition.get("deprecationMessage") is Some(_) &&
        definition.text("deprecationMessage").trim() == "" {
        self.report(
          uses,
          "action",
          "input \{@model.quote(id.value)} is deprecated but \"deprecationMessage\" is empty in metadata of \{@model.quote(name)} action at \{@model.quote(path)}",
        )
      }
    }
  }
  guard root.get("runs") is Some(runs) else {
    self.report(
      uses,
      "action",
      "\"runs.using\" is missing in local action \{@model.quote(name)} defined at \{@model.quote(dir)}",
    )
    return
  }
  let runner = runs.text("using")
  let kind = if runner == "docker" {
    "Docker"
  } else if runner == "composite" {
    "Composite"
  } else {
    "JavaScript"
  }
  if runner == "" {
    self.report(
      uses,
      "action",
      "\"runs.using\" is missing in local action \{@model.quote(name)} defined at \{@model.quote(dir)}",
    )
    return
  }
  if !["docker", "composite", "node20", "node24"].contains(runner) {
    self.report(
      uses,
      "action",
      "invalid runner name \{@model.quote(runner)} at runs.using in \{@model.quote(name)} action defined at \{@model.quote(dir)}. valid runners are \"composite\", \"docker\", \"node20\", and \"node24\". see https://docs.github.com/en/actions/creating-actions/metadata-syntax-for-github-actions#runs",
    )
    if !runner.has_prefix("node") {
      return
    }
  }
  let required = if runner == "docker" {
    "image"
  } else if runner == "composite" {
    "steps"
  } else {
    "main"
  }
  let present = if required == "steps" {
    metadata_specified(runs.get(required))
  } else {
    node_present(runs.get(required))
  }
  if !present {
    self.report(
      uses,
      "action",
      "\{@model.quote(required)} is required in \"runs\" section because \{@model.quote(name)} is a \{kind} action. the action is defined at \{@model.quote(dir)}",
    )
  }
  let invalid = if runner == "docker" {
    ["main", "pre", "pre-if", "post", "post-if", "steps"]
  } else if runner == "composite" {
    [
      "main", "pre", "pre-if", "post", "post-if", "image", "pre-entrypoint", "entrypoint",
      "post-entrypoint", "args", "env",
    ]
  } else {
    [
      "steps", "image", "pre-entrypoint", "entrypoint", "post-entrypoint", "args",
      "env",
    ]
  }
  for prop in invalid {
    let specified = if prop == "args" || prop == "env" {
      metadata_specified(runs.get(prop))
    } else {
      node_present(runs.get(prop))
    }
    if specified {
      self.report(
        uses,
        "action",
        "\{@model.quote(prop)} is not allowed in \"runs\" section because \{@model.quote(name)} is a \{kind} action. the action is defined at \{@model.quote(dir)}",
      )
    }
  }
  let files = if runner == "docker" {
    ["image", "pre-entrypoint", "entrypoint", "post-entrypoint"]
  } else if runner == "composite" {
    []
  } else {
    ["main", "pre", "post"]
  }
  for prop in files {
    let file = runs.text(prop)
    if file == "" {
      continue
    }
    if prop == "image" &&
      ["docker://", "gcr.io/", "pkg.dev/", "ghcr.io/", "docker.io/"]
      .iter()
      .any(prefix => file.has_prefix(prefix)) {
      continue
    }
    if !@fs.exists(@project.path_join(dir, file)) {
      self.report(
        uses,
        "action",
        "file \{@model.quote(file)} does not exist in \{@model.quote(dir)}. it is specified at \{@model.quote(prop)} key in \"runs\" section in \{@model.quote(name)} action",
      )
    }
    if prop == "image" &&
      !file.has_suffix("/Dockerfile") &&
      file != "Dockerfile" {
      self.report(
        uses,
        "action",
        "the local file \{@model.quote(file)} referenced from \"image\" key must be named \"Dockerfile\" in \{@model.quote(name)} action. the action is defined at \{@model.quote(dir)}",
      )
    }
  }
  if kind == "JavaScript" {
    for prop in ["pre", "post"] {
      if runs.text(prop) == "" && runs.text(prop + "-if") != "" {
        self.report(
          uses,
          "action",
          "\{@model.quote(prop)} is required when \{@model.quote(prop + "-if")} is specified in \"runs\" section in \{@model.quote(name)} action. the action is defined at \{@model.quote(dir)}",
        )
      }
    }
  }
}

///|
// Reusable workflow name maps use ordinary map assignment in their custom
// unmarshaler: the final occurrence wins, including a case-only collision.
fn metadata_last_names(names : @model.Node) -> Unit {
  let entries : Map[String, (@model.Node, @model.Node)] = Map([])
  for (key, value) in names.pairs() {
    entries[key.value.to_lower()] = (key, value)
  }
  names.children.clear()
  for _, (key, value) in entries {
    names.children.push(key)
    names.children.push(value)
  }
}
