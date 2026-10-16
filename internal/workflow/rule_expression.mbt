///|
priv enum ExprExpected {
  Interpolation
  RawValue
  ObjectValue
  ArrayValue
  NumberValue
  RunnerValue
  BoolValue
} derive(Eq)

///|
fn @model.Check::expr_string(
  self : @model.Check,
  n : @model.Node,
  key : String,
  contexts : Map[String, @expression.ExprType],
  variables : Array[String]?,
  condition~ : Bool = false,
  script~ : Bool = false,
  expected~ : ExprExpected = Interpolation,
  expected_at~ : String = "",
) -> @expression.ExprType? {
  if (!n.retained || n.kind != 1) && !condition {
    return None
  }
  let raw_condition = condition && !n.contains_expression()
  let mut offset = 0
  let mut result : @expression.ExprType? = None
  let interpolations : Array[@model.Diagnostic] = []
  while offset < n.value.length() || (raw_condition && offset == 0) {
    let start = if raw_condition {
      0
    } else {
      guard n.value[offset:].find("${{") is Some(index) else { break }
      offset + index + 3
    }
    let source = n.value[start:].to_owned() +
      (if raw_condition { "}}" } else { "" })
    let base = @utf8.encode(n.value[:start]).length() +
      (if !raw_condition && (n.style == 1 || n.style == 2) { 1 } else { 0 })
    let scope = @expression.ExprScope::{
      check: self,
      contexts,
      variables,
      node: n,
      source,
      base,
      workflow_key: key,
      untrusted: if script {
        Some(@expression.untrusted_checker())
      } else {
        None
      },
    }
    let (expr, consumed) = @expression.parse_expression(source) catch {
      ExprError(offset, message) => {
        scope.report(offset, message)
        return None
      }
    }
    let before = self.errors.length()
    let ty = scope.infer(expr)
    if scope.untrusted is Some(state) {
      scope.untrusted_end(state)
    }
    let semantic_errors = self.errors.length() > before
    if condition &&
      (
        raw_condition ||
        (
          n.value.has_prefix("${{") &&
          n.is_expression() &&
          consumed + start == n.value.length()
        )
      ) &&
      expr.constant() {
      let condition = if raw_condition {
        n.value.trim().to_owned()
      } else {
        source[:consumed - 2].trim().to_owned()
      }
      self.report(
        n,
        "if-cond",
        "constant expression \{@model.quote(condition)} in condition. remove the if: section",
      )
    }
    if semantic_errors {
      return None
    }
    if expected == Interpolation &&
      !raw_condition &&
      ty is (ObjectTy(_, _) | ArrayTy(_, _) | NullTy) {
      interpolations.push({
        message: "object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type \{ty.name()}",
        line: n.line,
        column: n.column + base - 3,
        kind: "expression",
      })
    }
    result = Some(ty)
    if raw_condition {
      break
    }
    offset = start + consumed
  }
  self.errors.append(interpolations)
  if n.is_expression() && result is Some(ty) && expected != Interpolation {
    let good = match expected {
      ObjectValue => ty is (AnyTy | ObjectTy(_, _))
      ArrayValue => ty is (AnyTy | ArrayTy(_, _))
      NumberValue => ty is (AnyTy | NumberTy)
      RunnerValue => ty is (AnyTy | StringTy | ArrayTy(_, _))
      BoolValue => ty is (AnyTy | BoolTy)
      _ => true
    }
    if !good {
      if expected == BoolValue {
        self.report(
          n,
          "expression",
          "type of expression must be bool but found type \{ty.name()}",
        )
      } else if expected == RunnerValue {
        self.report(
          n,
          "expression",
          "type of expression at \"runs-on\" must be string or array but found type \{@model.quote(ty.name())}",
        )
      } else {
        let name = match expected {
          ObjectValue => "object"
          ArrayValue => "array"
          NumberValue => "number"
          _ => ""
        }
        let at = if expected_at != "" {
          expected_at
        } else if expected == NumberValue {
          if key.has_suffix("strategy") {
            "integer value"
          } else {
            "float number value"
          }
        } else {
          key.split(".").last().unwrap_or("").to_owned()
        }
        self.report(
          n,
          "expression",
          "type of expression at \{@model.quote(at)} must be \{name} but found type \{ty.name()}",
        )
      }
    }
  }
  result
}

///|
fn @model.Check::expr_env(
  self : @model.Check,
  n : @model.Node,
  key : String,
  contexts : Map[String, @expression.ExprType],
  variables : Array[String]?,
) -> Unit {
  if n.kind == 1 {
    ignore(self.expr_string(n, key, contexts, variables, expected=ObjectValue))
  } else {
    for (k, v) in n.pairs() {
      ignore(self.expr_string(k, key, contexts, variables))
      ignore(self.expr_string(v, key, contexts, variables))
    }
  }
}

///|
fn @model.Check::expr_walk(
  self : @model.Check,
  n : @model.Node,
  key : String,
  contexts : Map[String, @expression.ExprType],
  variables : Array[String]?,
) -> Unit {
  if !n.retained {
    return
  }
  if n.kind == 1 {
    ignore(self.expr_string(n, key, contexts, variables))
  } else if n.kind == 3 {
    for (k, v) in n.pairs() {
      if k.retained {
        self.expr_walk(v, key, contexts, variables)
      }
    }
  } else {
    for c in n.children {
      self.expr_walk(c, key, contexts, variables)
    }
  }
}

///|
fn @model.Check::expr_container(
  self : @model.Check,
  n : @model.Node,
  prefix : String,
  contexts : Map[String, @expression.ExprType],
  variables : Array[String]?,
) -> Unit {
  if n.kind == 1 {
    ignore(self.expr_string(n, prefix, contexts, variables))
    return
  }
  for (k, v) in n.pairs() {
    if !k.retained {
      continue
    }
    if k.value == "env" {
      self.expr_env(v, prefix + ".env.<env_id>", contexts, variables)
    } else if k.value == "credentials" {
      if v.kind == 1 {
        ignore(
          self.expr_string(
            v,
            prefix + ".credentials",
            contexts,
            variables,
            expected=ObjectValue,
          ),
        )
      } else {
        for (key, value) in v.pairs() {
          if !key.retained {
            continue
          }
          ignore(
            self.expr_string(
              value,
              prefix + ".credentials",
              contexts,
              variables,
            ),
          )
        }
      }
    } else {
      self.expr_walk(
        v,
        prefix.strip_suffix(".<service_id>").unwrap_or(prefix[:]).to_owned(),
        contexts,
        variables,
      )
    }
  }
}

///|
fn @model.Check::raw_type(
  self : @model.Check,
  n : @model.Node,
  contexts : Map[String, @expression.ExprType],
  variables : Array[String]?,
) -> @expression.ExprType {
  if n.kind == 1 {
    let ty = self.expr_string(
      n,
      "jobs.<job_id>.strategy",
      contexts,
      variables,
      expected=RawValue,
    )
    if n.is_expression() {
      return ty.unwrap_or(AnyTy)
    }
    let value = n.value.trim()
    if value == "true" || value == "false" {
      BoolTy
    } else if value == "null" {
      NullTy
    } else if (try @string.parse_double(value) catch {
        _ => None
      } noraise {
        n => Some(n)
      })
      is Some(_) {
      NumberTy
    } else {
      StringTy
    }
  } else if n.kind == 2 {
    let mut elem = if n.children.is_empty() {
      @expression.AnyTy
    } else {
      self.raw_type(n.children[0], contexts, variables)
    }
    for child in n.children[1:] {
      elem = elem.merge(self.raw_type(child, contexts, variables))
    }
    ArrayTy(elem, false)
  } else if n.kind == 3 {
    let props : Map[String, @expression.ExprType] = Map([])
    for (key, value) in n.pairs() {
      props[key.value.to_lower()] = self.raw_type(value, contexts, variables)
    }
    ObjectTy(props, None)
  } else {
    AnyTy
  }
}

///|
fn @model.Check::matrix_combinations(
  self : @model.Check,
  n : @model.Node,
  section : String,
  contexts : Map[String, @expression.ExprType],
  variables : Array[String]?,
) -> @expression.ExprType {
  if n.kind == 1 {
    let ty = self
      .expr_string(
        n,
        "jobs.<job_id>.strategy",
        contexts,
        variables,
        expected=ArrayValue,
        expected_at=section,
      )
      .unwrap_or(AnyTy)
    return match ty {
      ArrayTy(elem, _) =>
        if !(elem is (AnyTy | ObjectTy(_, _))) {
          self.report(
            n,
            "expression",
            "type of expression at \"\{section}\" must be object but found type \{elem.name()}",
          )
          @expression.object_type(mapped=AnyTy)
        } else {
          elem
        }
      _ => @expression.object_type(mapped=AnyTy)
    }
  }
  let mut result = @expression.object_type()
  for combination in n.children {
    let ty = if combination.kind == 1 {
      self
      .expr_string(
        combination,
        "jobs.<job_id>.strategy",
        contexts,
        variables,
        expected=ObjectValue,
        expected_at=section,
      )
      .unwrap_or(AnyTy)
    } else {
      self.raw_type(combination, contexts, variables)
    }
    result = match ty {
      ObjectTy(_, _) => result.merge(ty)
      _ =>
        match result {
          ObjectTy(props, _) => ObjectTy(props, Some(AnyTy))
          _ => @expression.object_type(mapped=AnyTy)
        }
    }
  }
  result
}

///|
fn @model.Check::matrix_type(
  self : @model.Check,
  n : @model.Node,
  contexts : Map[String, @expression.ExprType],
  variables : Array[String]?,
) -> @expression.ExprType {
  if n.kind == 1 {
    let ty = self
      .expr_string(
        n,
        "jobs.<job_id>.strategy",
        contexts,
        variables,
        expected=ObjectValue,
        expected_at="matrix",
      )
      .unwrap_or(AnyTy)
    guard ty is ObjectTy(props, mapped) else {
      return @expression.object_type(mapped=AnyTy)
    }
    let rows = props.copy()
    let included = rows.get("include")
    rows.remove("include")
    rows.remove("exclude")
    let result = @expression.ObjectTy(rows, mapped)
    return match included {
      Some(ArrayTy(ObjectTy(_, _) as elem, _)) => result.merge(elem)
      Some(AnyTy | ArrayTy(AnyTy, _)) => ObjectTy(rows, Some(AnyTy))
      _ => result
    }
  }
  if n.get_ci("exclude") is Some(excluded) {
    ignore(self.matrix_combinations(excluded, "exclude", contexts, variables))
  }
  let props : Map[String, @expression.ExprType] = Map([])
  for (key, value) in n.pairs() {
    if key.value.to_lower() == "include" || key.value.to_lower() == "exclude" {
      continue
    }
    let ty = if value.kind == 1 {
      self
      .expr_string(
        value,
        "jobs.<job_id>.strategy",
        contexts,
        variables,
        expected=ArrayValue,
        expected_at="matrix row",
      )
      .unwrap_or(AnyTy)
    } else {
      self.raw_type(value, contexts, variables)
    }
    props[key.value.to_lower()] = match ty {
      ArrayTy(elem, _) => elem
      _ => AnyTy
    }
  }
  let result = @expression.ObjectTy(props, None)
  if n.get_ci("include") is Some(included) {
    let ty = self.matrix_combinations(included, "include", contexts, variables)
    if ty is ObjectTy(_, _) {
      return result.merge(ty)
    }
    return ObjectTy(props, Some(AnyTy))
  }
  result
}

///|
fn output_type(
  job : @model.Node,
  workflows~ : Map[String, @model.Node] = {},
) -> @expression.ExprType {
  if job.get("uses") is Some(uses) {
    if workflows.get(uses.value) is Some(metadata) {
      let props : Map[String, @expression.ExprType] = Map([])
      if metadata.get("outputs") is Some(outputs) {
        for (k, _) in outputs.pairs() {
          props[k.value.to_lower()] = StringTy
        }
      }
      return ObjectTy(props, None)
    }
    return @expression.object_type(mapped=AnyTy)
  }
  let props : Map[String, @expression.ExprType] = Map([])
  if job.get("outputs") is Some(outputs) {
    for (k, _) in outputs.pairs() {
      props[k.value.to_lower()] = StringTy
    }
  }
  ObjectTy(props, None)
}

///|
fn action_output_type(
  spec : String,
  actions~ : Map[String, @model.Node] = {},
) -> @expression.ExprType {
  if spec.has_prefix("actions/github-script@") {
    return @expression.object_type(mapped=AnyTy)
  }
  let metadata = match actions.get(spec) {
    Some(root) => local_action_json(root)
    None =>
      @jsonutil.data_get(
        @jsonutil.data_get(@data.builtin_data, "actions"),
        spec,
      )
  }
  if metadata is Null {
    return @expression.object_type(mapped=StringTy)
  }
  if @jsonutil.data_get(metadata, "skip_outputs") == Json::boolean(true) {
    return @expression.object_type(mapped=AnyTy)
  }
  let props : Map[String, @expression.ExprType] = Map([])
  for output in @jsonutil.json_strings(@jsonutil.data_get(metadata, "outputs")) {
    props[output.to_lower()] = StringTy
  }
  ObjectTy(props, None)
}

///|
fn @model.Check::check_expressions(
  self : @model.Check,
  workflow : @model.Node,
  variables : Array[String]?,
  actions~ : Map[String, @model.Node] = {},
  workflows~ : Map[String, @model.Node] = {},
) -> Unit {
  let global = @expression.initial_contexts()
  let input_props : Map[String, @expression.ExprType] = Map([])
  global["inputs"] = ObjectTy(input_props, None)
  if workflow.get("on") is Some(on) && on.kind == 3 {
    for (event, config) in on.pairs() {
      if event.value == "workflow_call" || event.value == "workflow_dispatch" {
        if config.get("inputs") is Some(inputs) {
          for (id, definition) in inputs.pairs() {
            let ty = match definition.text("type") {
              "boolean" => @expression.BoolTy
              "number" => NumberTy
              "string" | "choice" | "environment" => StringTy
              _ => AnyTy
            }
            for (k, v) in definition.pairs() {
              if !k.retained ||
                k.value == "type" ||
                (k.value == "options" && event.value == "workflow_call") {
                continue
              }
              let key = if k.value == "default" &&
                event.value == "workflow_call" {
                "on.workflow_call.inputs.<inputs_id>.default"
              } else {
                ""
              }
              if k.value == "default" && event.value == "workflow_call" {
                let actual = self.expr_string(v, key, global, variables)
                if v.is_expression() &&
                  actual is Some(actual) &&
                  ty is (BoolTy | NumberTy) &&
                  actual != AnyTy &&
                  actual != ty {
                  self.report(
                    v,
                    "expression",
                    "type of input \{@model.quote(id.value)} must be \{ty.name()} but found type \{actual.name()}",
                  )
                }
              } else if k.value == "required" {
                ignore(
                  self.expr_string(v, "", global, variables, expected=BoolValue),
                )
              } else {
                self.expr_walk(v, key, global, variables)
              }
            }
            let name = id.value.to_lower()
            input_props[name] = match input_props.get(name) {
              Some(previous) => previous.merge(ty)
              None => ty
            }
          }
          if event.value == "workflow_dispatch" &&
            global.get("github") is Some(ObjectTy(github_props, _)) {
            let string_props : Map[String, @expression.ExprType] = Map([])
            for (id, _) in inputs.pairs() {
              string_props[id.value.to_lower()] = StringTy
            }
            if github_props.get("event") is Some(ObjectTy(event_props, _)) {
              event_props["inputs"] = ObjectTy(string_props, None)
            }
          }
        }
        if event.value == "workflow_call" &&
          config.get("secrets") is Some(secrets) {
          let props : Map[String, @expression.ExprType] = {
            "github_token": StringTy,
            "actions_step_debug": StringTy,
            "actions_runner_debug": StringTy,
          }
          for (name, definition) in secrets.pairs() {
            props[name.value.to_lower()] = StringTy
            for (field, value) in definition.pairs() {
              if field.value == "required" {
                ignore(
                  self.expr_string(
                    value,
                    "",
                    global,
                    variables,
                    expected=BoolValue,
                  ),
                )
              } else if field.value == "description" {
                ignore(self.expr_string(value, "", global, variables))
              }
            }
          }
          global["secrets"] = ObjectTy(props, None)
        }
        if config.get("outputs") is Some(outputs) {
          for (_, definition) in outputs.pairs() {
            if definition.get("description") is Some(description) {
              ignore(self.expr_string(description, "", global, variables))
            }
          }
        }
      } else {
        self.expr_walk(config, "", global, variables)
      }
    }
  }
  for (k, v) in workflow.pairs() {
    if !k.retained ||
      k.value == "permissions" ||
      k.value == "jobs" ||
      k.value == "on" {
      continue
    }
    if k.value == "concurrency" {
      self.expr_concurrency(v, "concurrency", global, variables)
    } else if k.value == "env" {
      self.expr_env(v, "env", global, variables)
    } else {
      self.expr_walk(
        v,
        if k.value == "name" || k.value == "defaults" {
          ""
        } else {
          k.value
        },
        global,
        variables,
      )
    }
  }
  guard workflow.get("jobs") is Some(jobs) else { return }
  for (_, job) in jobs.pairs() {
    let contexts = global.copy()
    let needs_props : Map[String, @expression.ExprType] = Map([])
    if job.get("needs") is Some(needs) {
      for dependency in needs.items() {
        for (id, target) in jobs.pairs() {
          if id.value.to_lower() == dependency.value.to_lower() {
            needs_props[id.value.to_lower()] = @expression.object_type(props={
              "result": StringTy,
              "outputs": output_type(target, workflows~),
            })
          }
        }
      }
    }
    contexts["needs"] = ObjectTy(needs_props, None)
    contexts["matrix"] = @expression.object_type()
    if job.get("strategy") is Some(strategy) &&
      strategy.get("matrix") is Some(matrix) {
      contexts["matrix"] = self.matrix_type(matrix, contexts, variables)
    }
    let step_props : Map[String, @expression.ExprType] = Map([])
    contexts["steps"] = ObjectTy(step_props, None)
    for (k, v) in job.pairs() {
      if !k.retained {
        continue
      }
      let prefix = "jobs.<job_id>." + k.value
      match k.value {
        "steps" | "outputs" | "environment" => ()
        "continue-on-error" =>
          ignore(
            self.expr_string(v, prefix, contexts, variables, expected=BoolValue),
          )
        "concurrency" => self.expr_concurrency(v, prefix, contexts, variables)
        "if" =>
          ignore(
            self.expr_string(v, prefix, contexts, variables, condition=true),
          )
        "env" => self.expr_env(v, prefix, contexts, variables)
        "container" => self.expr_container(v, prefix, contexts, variables)
        "services" =>
          if v.kind == 1 {
            ignore(
              self.expr_string(
                v,
                prefix,
                contexts,
                variables,
                expected=ObjectValue,
              ),
            )
          } else {
            for (_, service) in v.pairs() {
              self.expr_container(
                service,
                prefix + ".<service_id>",
                contexts,
                variables,
              )
            }
          }
        "runs-on" =>
          if v.kind == 3 {
            for (rkey, r) in v.pairs() {
              if !rkey.retained {
                continue
              }
              for label in r.items() {
                ignore(
                  self.expr_string(
                    label,
                    prefix,
                    contexts,
                    variables,
                    expected=RunnerValue,
                  ),
                )
              }
            }
          } else {
            for label in v.items() {
              ignore(
                self.expr_string(
                  label,
                  prefix,
                  contexts,
                  variables,
                  expected=RunnerValue,
                ),
              )
            }
          }
        "strategy" =>
          for (s, value) in v.pairs() {
            if !s.retained {
              continue
            }
            if s.value != "matrix" {
              ignore(
                self.expr_string(
                  value,
                  "jobs.<job_id>.strategy",
                  contexts,
                  variables,
                  expected=if s.value == "max-parallel" {
                    NumberValue
                  } else {
                    BoolValue
                  },
                ),
              )
            }
          }
        "timeout-minutes" =>
          ignore(
            self.expr_string(
              v,
              prefix,
              contexts,
              variables,
              expected=NumberValue,
            ),
          )
        "defaults" =>
          self.expr_walk(v, "jobs.<job_id>.defaults.run", contexts, variables)
        "needs" => self.expr_walk(v, "", contexts, variables)
        "uses" =>
          if v.retained {
            ignore(self.expr_string(v, "", contexts, variables))
          }
        "with" | "secrets" =>
          for (input, value) in v.pairs() {
            let ty = self.expr_string(
              value,
              prefix +
              (if k.value == "with" { ".<with_id>" } else { ".<secrets_id>" }),
              contexts,
              variables,
            )
            if k.value == "with" &&
              workflows.get(job.text("uses")) is Some(metadata) &&
              metadata.get("inputs") is Some(inputs) &&
              inputs.get_ci(input.value) is Some(definition) {
              let expected = match definition.text("type") {
                "number" => @expression.NumberTy
                "boolean" => BoolTy
                "string" => StringTy
                _ => AnyTy
              }
              let ty = if value.is_expression() {
                ty.unwrap_or(AnyTy)
              } else if value.value.trim() is ("true" | "false") {
                BoolTy
              } else if value.value.trim() == "null" {
                NullTy
              } else if (try @string.parse_double(value.value.trim()) catch {
                  _ => None
                } noraise {
                  n => Some(n)
                })
                is Some(_) {
                NumberTy
              } else {
                StringTy
              }
              if !expected.assignable(ty) {
                self.report(
                  value,
                  "expression",
                  "input \{@model.quote(input.value)} is typed as \{expected.name()} by reusable workflow \{@model.quote(job.text("uses"))}. \{ty.name()} value cannot be assigned",
                )
              }
            }
          }
        "snapshot" =>
          if v.get("if") is Some(condition) {
            ignore(
              self.expr_string(
                condition,
                "jobs.<job_id>.snapshot.if",
                contexts,
                variables,
                condition=true,
              ),
            )
          }
        "permissions" => ()
        _ => self.expr_walk(v, prefix, contexts, variables)
      }
    }
    if job.get("steps") is Some(steps) && steps.kind == 2 {
      for step in steps.children {
        for (k, v) in step.pairs() {
          if !k.retained || (k.value == "id" && !v.contains_expression()) {
            continue
          }
          let prefix = "jobs.<job_id>.steps." + k.value
          match k.value {
            "id" | "uses" | "shell" =>
              ignore(self.expr_string(v, "", contexts, variables))
            "if" =>
              ignore(
                self.expr_string(v, prefix, contexts, variables, condition=true),
              )
            "run" =>
              ignore(
                self.expr_string(v, prefix, contexts, variables, script=true),
              )
            "with" =>
              for (input, value) in v.pairs() {
                ignore(
                  self.expr_string(
                    value,
                    prefix,
                    contexts,
                    variables,
                    script=input.value == "script" &&
                      step.text("uses").has_prefix("actions/github-script@"),
                  ),
                )
              }
            "env" => self.expr_env(v, prefix, contexts, variables)
            "continue-on-error" =>
              ignore(
                self.expr_string(
                  v,
                  prefix,
                  contexts,
                  variables,
                  expected=BoolValue,
                ),
              )
            "timeout-minutes" =>
              ignore(
                self.expr_string(
                  v,
                  prefix,
                  contexts,
                  variables,
                  expected=NumberValue,
                ),
              )
            _ => self.expr_walk(v, prefix, contexts, variables)
          }
        }
        if step.get("id") is Some(id) {
          step_props[id.value.to_lower()] = @expression.object_type(props={
            "outputs": action_output_type(step.text("uses"), actions~),
            "conclusion": StringTy,
            "outcome": StringTy,
          })
          if id.contains_expression() {
            contexts["steps"] = ObjectTy(step_props, Some(AnyTy))
          }
        }
      }
    }
    if job.get("environment") is Some(environment) {
      if environment.kind == 1 {
        ignore(
          self.expr_string(
            environment, "jobs.<job_id>.environment", contexts, variables,
          ),
        )
      } else {
        for (key, value) in environment.pairs() {
          if !key.retained {
            continue
          }
          ignore(
            self.expr_string(
              value,
              if key.value == "url" {
                "jobs.<job_id>.environment.url"
              } else {
                "jobs.<job_id>.environment"
              },
              contexts,
              variables,
              expected=if key.value == "deployment" {
                BoolValue
              } else {
                Interpolation
              },
            ),
          )
        }
      }
    }
    if job.get("outputs") is Some(outputs) {
      for (_, value) in outputs.pairs() {
        ignore(
          self.expr_string(
            value, "jobs.<job_id>.outputs.<output_id>", contexts, variables,
          ),
        )
      }
    }
  }
  if workflow.get("on") is Some(on) &&
    on.get("workflow_call") is Some(call) &&
    call.get("outputs") is Some(outputs) {
    let job_props : Map[String, @expression.ExprType] = Map([])
    for (id, job) in jobs.pairs() {
      job_props[id.value.to_lower()] = @expression.object_type(props={
        "outputs": output_type(job, workflows~),
      })
    }
    global["jobs"] = ObjectTy(job_props, None)
    for (_, definition) in outputs.pairs() {
      if definition.get("value") is Some(value) {
        ignore(
          self.expr_string(
            value, "on.workflow_call.outputs.<output_id>.value", global, variables,
          ),
        )
      }
    }
  }
}

///|
fn @model.Check::expr_concurrency(
  self : @model.Check,
  n : @model.Node,
  key : String,
  contexts : Map[String, @expression.ExprType],
  variables : Array[String]?,
) -> Unit {
  if n.kind == 1 {
    ignore(self.expr_string(n, key, contexts, variables))
    return
  }
  for (field, value) in n.pairs() {
    if !field.retained {
      continue
    }
    ignore(
      self.expr_string(
        value,
        key,
        contexts,
        variables,
        expected=if field.value == "cancel-in-progress" {
          BoolValue
        } else {
          Interpolation
        },
      ),
    )
  }
}
