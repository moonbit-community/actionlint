///|
pub(all) struct ExprScope {
  check : @model.Check
  contexts : Map[String, ExprType]
  variables : Array[String]?
  node : @model.Node
  source : String
  base : Int32
  untrusted : UntrustedChecker?
  workflow_key : String
}

///|
pub fn ExprScope::report(
  self : ExprScope,
  offset : Int32,
  message : String,
) -> Unit {
  let prefix = self.source[:offset.min(self.source.length())]
  let lines = prefix.split("\n").to_array()
  let mut column = self.node.column + self.base
  for _ in lines[lines.length() - 1] {
    column += 1
  }
  self.check.errors.push({
    message,
    line: self.node.line + lines.length() - 1,
    column,
    kind: "expression",
  })
}

///|
fn ExprScope::property(
  self : ExprScope,
  expr : Expr,
  receiver : ExprType,
  property : String,
) -> ExprType {
  match receiver {
    AnyTy => AnyTy
    ObjectTy(props, mapped) =>
      if props.get(property) is Some(ty) {
        ty
      } else if mapped is Some(ty) {
        ty
      } else {
        self.report(
          expr.offset,
          "property \{@model.quote(property)} is not defined in object type \{receiver.name()}",
        )
        AnyTy
      }
    ArrayTy(elem, true) =>
      match elem {
        AnyTy => receiver
        ObjectTy(props, mapped) => {
          let ty = match props.get(property) {
            Some(ty) => ty
            None =>
              match mapped {
                Some(ty) => ty
                None => {
                  self.report(
                    expr.offset,
                    "property \{@model.quote(property)} is not defined in object type \{elem.name()} as element of filtered array",
                  )
                  AnyTy
                }
              }
          }
          ArrayTy(ty, true)
        }
        _ => {
          self.report(
            expr.offset,
            "property filtered by \{@model.quote(property)} at object filtering must be type of object but got \{@model.quote(elem.name())}",
          )
          AnyTy
        }
      }
    _ => {
      self.report(
        expr.offset,
        "receiver of object dereference \{@model.quote(property)} must be type of object but got \{@model.quote(receiver.name())}",
      )
      AnyTy
    }
  }
}

///|
pub fn ExprScope::infer(self : ExprScope, expr : Expr) -> ExprType {
  if self.untrusted is Some(state) && untrusted_safe(expr) {
    state.safe_calls += 1
  }
  let ty = self.infer_inner(expr)
  if self.untrusted is Some(state) {
    self.untrusted_leave(state, expr)
  }
  ty
}

///|
fn ExprScope::infer_inner(self : ExprScope, expr : Expr) -> ExprType {
  match expr.kind {
    "null" => NullTy
    "bool" => BoolTy
    "number" => NumberTy
    "string" => StringTy
    "variable" => {
      let name = expr.value.to_lower()
      guard self.contexts.get(name) is Some(ty) else {
        self.report(
          expr.offset,
          "undefined variable \{@model.quote(expr.value)}. available variables are \{@model.quotes(self.contexts.keys().to_array())}",
        )
        return AnyTy
      }
      let availability = @jsonutil.data_get(
        @jsonutil.data_get(@data.builtin_data, "availability"),
        self.workflow_key,
      )
      let allowed = match availability {
        Array(xs) =>
          if xs.length() > 0 {
            @jsonutil.json_strings(xs[0])
          } else {
            []
          }
        _ => []
      }
      if !allowed.contains(name) {
        let note = if allowed.is_empty() {
          "no context is available here"
        } else {
          "available contexts are " + allowed.map(@model.quote).join(", ")
        }
        self.report(
          expr.offset,
          "context \{@model.quote(expr.value.to_lower())} is not allowed here. \{note}. see https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability for more details",
        )
      }
      ty
    }
    "property" => {
      let receiver = self.infer(expr.children[0])
      if expr.children[0].kind == "variable" &&
        expr.children[0].value.to_lower() == "vars" {
        self.check_variable(expr)
      }
      self.property(expr, receiver, expr.value)
    }
    "index" => {
      let index = self.infer(expr.children[1])
      let operand = self.infer(expr.children[0])
      match operand {
        AnyTy => AnyTy
        ArrayTy(elem, _) =>
          if index is (AnyTy | NumberTy) {
            elem
          } else {
            self.report(
              expr.children[1].offset,
              "index access of array must be type of number but got \{@model.quote(index.name())}",
            )
            AnyTy
          }
        ObjectTy(props, mapped) =>
          if index is AnyTy {
            AnyTy
          } else if index is StringTy {
            let property = expr.children[1]
            if property.kind == "string" {
              if props.get(property.value) is Some(ty) {
                ty
              } else if mapped is Some(ty) {
                ty
              } else {
                self.report(
                  expr.offset,
                  "property \{@model.quote(property.value)} is not defined in object type \{operand.name()}",
                )
                AnyTy
              }
            } else {
              mapped.unwrap_or(AnyTy)
            }
          } else {
            self.report(
              expr.children[1].offset,
              "property access of object must be type of string but got \{@model.quote(index.name())}",
            )
            AnyTy
          }
        _ => {
          self.report(
            expr.offset,
            "index access operand must be type of object or array but got \{@model.quote(operand.name())}",
          )
          AnyTy
        }
      }
    }
    "filter" => {
      let ty = self.infer(expr.children[0])
      match ty {
        AnyTy => ArrayTy(AnyTy, true)
        ArrayTy(elem, _) => ArrayTy(elem, true)
        ObjectTy(props, mapped) =>
          match mapped {
            Some(AnyTy) => ArrayTy(AnyTy, true)
            Some(ObjectTy(_, _) as elem) => ArrayTy(elem, true)
            Some(elem) => {
              self.report(
                expr.offset,
                "elements of object at receiver of object filtering `.*` must be type of object but got \{@model.quote(elem.name())}. the type of receiver was \{@model.quote(ty.name())}",
              )
              AnyTy
            }
            None =>
              if props.values().any(ty => ty is ObjectTy(_, _)) {
                ArrayTy(AnyTy, true)
              } else {
                self.report(
                  expr.offset,
                  "object type \{@model.quote(ty.name())} cannot be filtered by object filtering `.*` since it has no object element",
                )
                AnyTy
              }
          }
        _ => {
          self.report(
            expr.offset,
            "receiver of object filtering `.*` must be type of array or object but got \{@model.quote(ty.name())}",
          )
          AnyTy
        }
      }
    }
    "call" => self.call(expr)
    "not" => {
      ignore(self.infer(expr.children[0]))
      BoolTy
    }
    "binary" => {
      let op = expr.value
      let left = self.infer_narrow(expr.children[0], op == "||")
      let right = self.infer(expr.children[1])
      if op == "||" || op == "&&" {
        left.merge(right)
      } else {
        if !comparable(left, right, op) {
          self.report(
            expr.offset,
            "\{@model.quote(left.name())} value cannot be compared to \{@model.quote(right.name())} value with \{@model.quote(op)} operator",
          )
        }
        BoolTy
      }
    }
    _ => AnyTy
  }
}

///|
fn ExprScope::infer_narrow(
  self : ExprScope,
  expr : Expr,
  truthy : Bool,
) -> ExprType {
  if expr.kind == "binary" &&
    ((truthy && expr.value == "&&") || (!truthy && expr.value == "||")) {
    ignore(self.infer(expr.children[0]))
    self.infer(expr.children[1])
  } else {
    self.infer(expr)
  }
}

///|
fn comparable(a : ExprType, b : ExprType, op : String) -> Bool {
  if op == "==" || op == "!=" {
    match (a, b) {
      (AnyTy | NullTy, _) | (_, AnyTy | NullTy) => true
      (ArrayTy(x, _), ArrayTy(y, _)) => comparable(x, y, op)
      (ObjectTy(_, _), ObjectTy(_, _)) => true
      (ArrayTy(_, _) | ObjectTy(_, _), _)
      | (_, ArrayTy(_, _) | ObjectTy(_, _)) => false
      _ => true
    }
  } else {
    a is (AnyTy | StringTy | NumberTy) && b is (AnyTy | StringTy | NumberTy)
  }
}

///|
fn ExprScope::check_variable(self : ExprScope, expr : Expr) -> Unit {
  let name = expr.value
  let note = ". note: see the convention at https://docs.github.com/en/actions/learn-github-actions/variables#naming-conventions-for-configuration-variables"
  if name.has_prefix("github_") {
    self.report(
      expr.offset,
      "configuration variable name \{@model.quote(name)} must not start with the GITHUB_ prefix (case insensitive)" +
      note,
    )
    return
  }
  if !name.iter().all(c => c is ('a'..<='z' | '0'..<='9' | '_')) {
    self.report(
      expr.offset,
      "configuration variable name \{@model.quote(name)} can only contain alphabets, decimal numbers, and '_'" +
      note,
    )
    return
  }
  if self.variables is Some(variables) &&
    !variables.iter().any(v => v.to_lower() == name) {
    if variables.is_empty() {
      self.report(
        expr.offset,
        "no configuration variable is allowed since the variables list is empty in actionlint.yaml. you may forget adding the variable \{@model.quote(name)} to the list",
      )
    } else {
      self.report(
        expr.offset,
        "undefined configuration variable \{@model.quote(name)}. defined configuration variables in actionlint.yaml are \{@model.quotes(variables)}",
      )
    }
  }
}

///|
priv struct FuncSignature {
  name : String
  params : Array[ExprType]
  variadic : Bool
  result : ExprType
}

///|
fn FuncSignature::name(self : FuncSignature) -> String {
  self.name +
  "(" +
  self.params
  .mapi((i, ty) => {
    ty.name() +
    (if self.variadic && i == self.params.length() - 1 { "..." } else { "" })
  })
  .join(", ") +
  ") -> " +
  self.result.name()
}

///|
fn signature(
  name : String,
  params : Array[ExprType],
  result : ExprType,
  variadic~ : Bool = false,
) -> FuncSignature {
  { name, params, result, variadic, }
}

///|
fn function_signatures(name : String) -> Array[FuncSignature] {
  match name {
    "contains" =>
      [
        signature("contains", [StringTy, StringTy], BoolTy),
        signature("contains", [ArrayTy(AnyTy, false), AnyTy], BoolTy),
      ]
    "startswith" => [signature("startsWith", [StringTy, StringTy], BoolTy)]
    "endswith" => [signature("endsWith", [StringTy, StringTy], BoolTy)]
    "format" =>
      [signature("format", [StringTy, AnyTy], StringTy, variadic=true)]
    "join" =>
      [
        signature("join", [ArrayTy(StringTy, false), StringTy], StringTy),
        signature("join", [ArrayTy(StringTy, false)], StringTy),
      ]
    "tojson" => [signature("toJSON", [AnyTy], StringTy)]
    "fromjson" => [signature("fromJSON", [StringTy], AnyTy)]
    "hashfiles" => [signature("hashFiles", [StringTy], StringTy, variadic=true)]
    "success" | "always" | "cancelled" | "failure" =>
      [signature(name, [], BoolTy)]
    "case" => [signature("case", [BoolTy, AnyTy, AnyTy], AnyTy, variadic=true)]
    _ => []
  }
}

///|
fn ordinal(i : Int32) -> String {
  "\{i}" +
  (match i {
    1 => "st"
    2 => "nd"
    3 => "rd"
    _ => "th"
  })
}

///|
fn ExprScope::call(self : ExprScope, expr : Expr) -> ExprType {
  let callee = expr.value.to_lower()
  let functions = [
    "contains", "startswith", "endswith", "format", "join", "tojson", "fromjson",
    "hashfiles", "success", "always", "cancelled", "failure", "case",
  ]
  let signatures = function_signatures(callee)
  if signatures.is_empty() {
    self.report(
      expr.offset,
      "undefined function \{@model.quote(expr.value)}. available functions are \{@model.quotes(functions)}",
    )
    return AnyTy
  }
  let types = expr.children.map(child => self.infer(child))
  let failures : Array[(Int32, String)] = []
  let mut selected : FuncSignature? = None
  for signature in signatures {
    let size = signature.params.length()
    if (signature.variadic && types.length() < size) ||
      (!signature.variadic && types.length() != size) {
      let at_least = if signature.variadic { "at least " } else { "" }
      failures.push(
        (
          expr.offset,
          "number of arguments is wrong. function \{@model.quote(signature.name())} takes \{at_least}\{size} parameters but \{types.length()} arguments are given",
        ),
      )
      continue
    }
    let mut failed = false
    for i in 0..<types.length() {
      let param = signature.params[i.min(size - 1)]
      if !param.assignable(types[i]) {
        failures.push(
          (
            expr.children[i].offset,
            "\{ordinal(i + 1)} argument of function call is not assignable. \{@model.quote(types[i].name())} cannot be assigned to \{@model.quote(param.name())}. called function type is \{@model.quote(signature.name())}",
          ),
        )
        failed = true
        break
      }
    }
    if !failed {
      selected = Some(signature)
      break
    }
  }
  guard selected is Some(signature) else {
    for (offset, message) in failures {
      self.report(offset, message)
    }
    return AnyTy
  }
  if ["success", "always", "cancelled", "failure", "hashfiles"].contains(callee) {
    let available = @jsonutil.data_get(
      @jsonutil.data_get(@data.builtin_data, "availability"),
      self.workflow_key,
    )
    let allowed = match available {
      Array(xs) =>
        if xs.length() > 1 {
          @jsonutil.json_strings(xs[1])
        } else {
          []
        }
      _ => []
    }
    if !allowed.contains(callee) {
      let locations = if callee == "hashfiles" {
        [
          "jobs.<job_id>.steps.continue-on-error", "jobs.<job_id>.steps.env", "jobs.<job_id>.steps.if",
          "jobs.<job_id>.steps.name", "jobs.<job_id>.steps.run", "jobs.<job_id>.steps.timeout-minutes",
          "jobs.<job_id>.steps.with", "jobs.<job_id>.steps.working-directory",
        ]
      } else {
        ["jobs.<job_id>.if", "jobs.<job_id>.steps.if"]
      }
      self.report(
        expr.offset,
        "calling function \{@model.quote(expr.value)} is not allowed here. \{@model.quote(expr.value)} is only available in \{locations.map(@model.quote).join(", ")}. see https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability for more details",
      )
    }
  }
  if callee == "case" && expr.children.length() % 2 == 0 {
    self.report(
      expr.offset,
      "case() requires an odd number of arguments (pred/value pairs + default) but got \{expr.children.length()}",
    )
  }
  if callee == "fromjson" && expr.children[0].kind == "string" {
    if (try @json.parse(expr.children[0].value) catch {
        _ => None
      } noraise {
        data => Some(data)
      })
      is Some(data) {
      return type_from_json(data)
    }
    let (offset, message) = @jsonutil.json_syntax_error(expr.children[0].value)
    self.report(
      expr.children[0].offset,
      "broken JSON string is passed to fromJSON() at offset \{offset}: \{message}",
    )
  }
  if callee == "format" && expr.children[0].kind == "string" {
    let format = expr.children[0].value
    let used = format_placeholders(format)
    let count = expr.children.length() - 1
    for i in 0..<count {
      if used.get(i.to_int64()) != Some(true) {
        self.report(
          expr.offset,
          "format string \{@model.quote(format)} does not contain placeholder {\{i}}. remove argument which is unused in the format string",
        )
      }
    }
    for i, _ in used {
      if i >= count.to_int64() {
        self.report(
          expr.offset,
          "format string \{@model.quote(format)} contains placeholder {\{i}} but only \{count} arguments are given to format",
        )
      }
    }
  }
  signature.result
}
