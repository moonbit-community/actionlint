///|
fn node_present(n : @model.Node?) -> Bool {
  match n {
    None => false
    Some(n) => if n.kind == 1 { n.value != "" } else { !n.children.is_empty() }
  }
}

///|
fn @model.Check::check_event_filters(
  self : @model.Check,
  event : @model.Node,
  settings : @model.Node,
) -> Unit {
  let hook = event.value
  for
    (filter, available) in [
      ("paths", ["push", "pull_request", "pull_request_target"]),
      (
        "branches",
        [
          "merge_group", "push", "pull_request", "pull_request_target", "workflow_run",
        ],
      ),
      ("tags", ["push"]),
    ] {
    let normal = settings.get(filter)
    let ignore_ = settings.get(filter + "-ignore")
    if available.contains(hook) {
      if node_present(normal) && node_present(ignore_) {
        let a = settings.key(filter).unwrap()
        let b = settings.key(filter + "-ignore").unwrap()
        let pos = if a.line < b.line ||
          (a.line == b.line && a.column < b.column) {
          b
        } else {
          a
        }
        self.report(
          pos,
          "events",
          "both \{@model.quote(filter)} and \{@model.quote(filter + "-ignore")} filters cannot be used for the same event \{@model.quote(hook)}. note: use '!' to negate patterns",
        )
      }
    } else {
      for name in [filter, filter + "-ignore"] {
        if node_present(settings.get(name)) && settings.key(name) is Some(key) {
          self.report(
            key,
            "events",
            "\{@model.quote(name)} filter is not available for \{hook} event. it is only for \{available.join(", ")} \{if available.length() < 2 { "event" } else { "events" }}",
          )
        }
      }
    }
    for n in [normal, ignore_] {
      if n is Some(patterns) {
        for pattern in patterns.items() {
          self.check_glob(pattern, filter != "paths")
        }
      }
    }
  }
}

///|
fn @model.Check::check_event(
  self : @model.Check,
  event : @model.Node,
  settings : @model.Node,
) -> Unit {
  let hook = event.value
  if hook == "schedule" {
    if settings.kind == 2 {
      for entry in settings.children {
        if entry.get("cron") is Some(cron) && cron.value != "" {
          self.check_cron(cron)
        }
        if entry.get("timezone") is Some(tz) && tz.value != "" {
          let names = @jsonutil.json_strings(
            @jsonutil.data_get(@data.builtin_data, "timezones"),
          )
          if tz.value.to_lower() == "utc" ||
            tz.value.to_lower() == "local" ||
            !names.contains(tz.value) {
            self.report(
              tz,
              "events",
              "invalid timezone \{@model.quote(tz.value)} in schedule event. it must be a valid IANA timezone name",
            )
          }
        }
      }
    }
    return
  }
  if hook == "workflow_call" || hook == "workflow_dispatch" {
    self.check_event_inputs(event, settings)
    return
  }
  if hook == "image_version" {
    if settings.get("versions") is Some(versions) {
      for version in versions.children {
        self.check_glob(version, true)
      }
    }
    return
  }
  if hook == "repository_dispatch" {
    return
  }
  let webhooks = @jsonutil.data_get(@data.builtin_data, "webhooks")
  if !@jsonutil.data_keys(webhooks).contains(hook) {
    self.report(
      event,
      "events",
      "unknown Webhook event \{@model.quote(hook)}. see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names",
    )
    return
  }
  let types = @jsonutil.json_strings(@jsonutil.data_get(webhooks, hook))
  if settings.get("types") is Some(configured) && node_present(Some(configured)) {
    if types.is_empty() {
      self.report(
        event,
        "events",
        "\"types\" cannot be specified for \{@model.quote(hook)} Webhook event",
      )
    } else {
      for activity in configured.items() {
        if !types.contains(activity.value) {
          self.report(
            activity,
            "events",
            "invalid activity type \{@model.quote(activity.value)} for \{@model.quote(hook)} Webhook event. available types are \{@model.quotes(types)}",
          )
        }
      }
    }
  }
  let has_workflows = node_present(settings.get("workflows"))
  if hook == "workflow_run" && !has_workflows {
    self.report(
      event, "events", "no workflow is configured for \"workflow_run\" event",
    )
  } else if hook != "workflow_run" && has_workflows {
    self.report(
      event,
      "events",
      "\"workflows\" cannot be configured for \{@model.quote(hook)} event. it is only for workflow_run event",
    )
  }
  self.check_event_filters(event, settings)
}

///|
fn @model.Check::check_events(
  self : @model.Check,
  workflow : @model.Node,
) -> Unit {
  if workflow.get("on") is Some(on) {
    if on.kind == 3 {
      for (event, settings) in on.pairs() {
        self.check_event(event, settings)
      }
    } else {
      for event in on.items() {
        if event.value != "" && event.value != "schedule" {
          self.check_event(
            event,
            @model.node(3, "", event.line, event.column, 0, "!!map", 0),
          )
        }
      }
    }
  }
  if workflow.get("jobs") is Some(jobs) {
    for (_, job) in jobs.pairs() {
      if job.get("snapshot") is Some(snapshot) &&
        snapshot.get("version") is Some(version) {
        self.check_glob(version, true)
      }
    }
  }
}

///|
fn @model.Check::check_event_inputs(
  self : @model.Check,
  event : @model.Node,
  settings : @model.Node,
) -> Unit {
  guard settings.get("inputs") is Some(inputs) else { return }
  let call = event.value == "workflow_call"
  for (id, definition) in inputs.pairs() {
    let kind = definition.text("type")
    let options = match definition.get("options") {
      Some(options) if options.retained => options.children
      Some(_) => []
      None => []
    }
    let default = definition.get("default")
    if !call && kind == "choice" {
      if options.is_empty() {
        self.report(
          id,
          "events",
          "input type of \{@model.quote(id.value.to_lower())} is \"choice\" but \"options\" is not set",
        )
        continue
      }
      let seen : Map[String, Bool] = Map([])
      for option in options {
        if seen.get(option.value) == Some(true) {
          self.report(
            option,
            "events",
            "option \{@model.quote(option.value)} is duplicated in options of \{@model.quote(id.value.to_lower())} input",
          )
        }
        seen[option.value] = true
      }
      if default is Some(default) &&
        !options.iter().any(o => o.value == default.value) {
        self.report(
          default,
          "events",
          "default value \{@model.quote(default.value)} of \{@model.quote(id.value.to_lower())} input is not included in its options \{@model.quote(options.map(o => @model.quote(o.value)).join(", "))}",
        )
      }
    } else {
      if !call && !options.is_empty() {
        self.report(
          id,
          "events",
          "\"options\" can not be set to \{@model.quote(id.value.to_lower())} input because its input type is not \"choice\"",
        )
      }
      if default is Some(default) && (!call || !default.contains_expression()) {
        let number_error = if kind == "number" {
          try {
            ignore(@yaml.parse_yaml_number(default.value, false))
            None
          } catch {
            CliError(reason) => Some(reason)
          }
        } else {
          None
        }
        if number_error is Some(parsing) {
          self.report(
            default,
            "events",
            if call {
              "input of workflow_call event \{@model.quote(id.value)} is typed as number but its default value \{@model.quote(default.value)} cannot be parsed as a float number: \{parsing}"
            } else {
              "type of \{@model.quote(id.value)} input is \"number\" but its default value \{@model.quote(default.value)} cannot be parsed as a float number: \{parsing}"
            },
          )
        }
        if kind == "boolean" &&
          !["true", "false"].contains(default.value.to_lower()) {
          self.report(
            default,
            "events",
            if call {
              "input of workflow_call event \{@model.quote(id.value)} is typed as boolean. its default value must be true or false but got \{@model.quote(default.value)}"
            } else {
              "type of \{@model.quote(id.value.to_lower())} input is \"boolean\". its default value \{@model.quote(default.value)} must be \"true\" or \"false\""
            },
          )
        }
      }
    }
    if call && default is Some(default) && definition.text("required") == "true" {
      self.report(
        default,
        "events",
        "input \{@model.quote(id.value)} of workflow_call event has the default value \{@model.quote(default.value)}, but it is also required. if an input is marked as required, its default value will never be used",
      )
    }
  }
  if !call && inputs.pairs().length() > 25 {
    self.report(
      event,
      "events",
      "maximum number of inputs for \"workflow_dispatch\" event is 25 but \{inputs.pairs().length()} inputs are provided. see https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#providing-inputs",
    )
  }
}
