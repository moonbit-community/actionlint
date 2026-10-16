///|
fn @model.Check::parse_events(self : @model.Check, n : @model.Node) -> Unit {
  if n.kind == 1 || n.kind == 2 {
    let events = if n.kind == 1 { [n] } else { self.sequence(n, "on") }
    for event in events {
      self.string_value(event)
      if event.value == "schedule" {
        self.syntax(event, "schedule event must be configured with mapping")
      }
    }
    return
  }
  if n.kind != 3 {
    self.syntax(
      n,
      "\"on\" section value is expected to be mapping or sequence but found \{n.kind_name()} node",
    )
    return
  }
  for (event, config) in self.mapping(n, "\"on\" section", false) {
    match event.value {
      "schedule" =>
        for schedule in self.sequence(config, "schedule") {
          for
            (k, v) in self.mapping(
              schedule, "element of \"schedule\" section", false,
            ) {
            if k.value == "cron" || k.value == "timezone" {
              self.string_value(v)
            } else {
              self.unexpected(k, "element of \"schedule\" section", [
                "cron", "timezone",
              ])
            }
          }
        }
      "workflow_call" | "workflow_dispatch" => {
        let call = event.value == "workflow_call"
        let allowed = if call {
          ["inputs", "outputs", "secrets"]
        } else {
          ["inputs"]
        }
        for
          (section, settings) in self.mapping(
            config,
            "\{@model.quote(event.value)} section",
            true,
          ) {
          if !allowed.contains(section.value) {
            self.unexpected(section, event.value, allowed)
            continue
          }
          for
            (id, definition) in self.mapping(
              settings,
              "\{@model.quote(section.value)} section",
              true,
              sensitive=false,
            ) {
            let where_ = if call {
              "\{section.value.strip_suffix("s").unwrap_or(section.value[:])} of workflow_call event"
            } else {
              "input settings of workflow_dispatch event"
            }
            let props = match section.value {
              "inputs" =>
                if call {
                  ["description", "required", "default", "type"]
                } else {
                  ["description", "required", "default", "type", "options"]
                }
              "outputs" => ["description", "value"]
              _ => ["description", "required"]
            }
            for (k, v) in self.mapping(definition, where_, true) {
              match k.value {
                "required" => self.bool_value(v)
                "options" =>
                  if !call {
                    self.strings(v, "options")
                  } else {
                    self.unexpected(k, "inputs at workflow_call event", props)
                  }
                "type" => {
                  self.string_value(v)
                  if v.kind != 1 || v.value == "" {
                    continue
                  }
                  let types = if call {
                    ["boolean", "number", "string"]
                  } else {
                    ["string", "number", "boolean", "choice", "environment"]
                  }
                  if !types.contains(v.value) {
                    self.syntax(
                      v,
                      if call {
                        "invalid value \{@model.quote(v.value)} for input type of workflow_call event. it must be one of \"boolean\", \"number\", or \"string\""
                      } else {
                        "input type of workflow_dispatch event must be one of \"string\", \"number\", \"boolean\", \"choice\", \"environment\" but got \{@model.quote(v.value)}"
                      },
                    )
                  }
                }
                _ =>
                  if props.contains(k.value) {
                    self.string_value(v, empty=k.value != "value")
                  } else {
                    self.unexpected(
                      k,
                      if section.value == "inputs" && call {
                        "inputs at workflow_call event"
                      } else if section.value == "outputs" {
                        "outputs at workflow_call event"
                      } else {
                        section.value
                      },
                      if !call && section.value == "inputs" {
                        ["description", "required", "default"]
                      } else {
                        props
                      },
                    )
                  }
              }
            }
            if call &&
              section.value == "inputs" &&
              definition.get("type") is None {
              self.syntax(
                id,
                "\"type\" is missing at \{@model.quote(id.value)} input of workflow_call event",
              )
            }
            if call &&
              section.value == "outputs" &&
              definition.get("value") is None {
              self.syntax(
                id,
                "\"value\" is missing at \{@model.quote(id.value)} output of workflow_call event",
              )
            }
          }
        }
      }
      "repository_dispatch" =>
        for
          (k, v) in self.mapping(
            config, "\"repository_dispatch\" section", true,
          ) {
          if k.value == "types" {
            self.strings(v, "types", scalar=true)
          } else {
            self.unexpected(k, "repository_dispatch", ["types"])
          }
        }
      "image_version" =>
        for (k, v) in self.mapping(config, "\"image_version\" section", true) {
          if k.value == "names" || k.value == "versions" {
            self.strings(v, k.value)
          } else {
            self.unexpected(k, "image_version", ["names", "versions"])
          }
        }
      _ => {
        let allowed = [
          "types", "branches", "branches-ignore", "tags", "tags-ignore", "paths",
          "paths-ignore", "workflows",
        ]
        for
          (k, v) in self.mapping(
            config,
            "\{@model.quote(event.value)} section",
            true,
          ) {
          if !allowed.contains(k.value) {
            self.unexpected(k, event.value, allowed)
          } else {
            self.strings(v, k.value, scalar=true)
          }
        }
      }
    }
  }
}
