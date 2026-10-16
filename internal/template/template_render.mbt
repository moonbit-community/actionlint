///|
fn template_assignment(source : String) -> (Array[String], Bool, String)? {
  let mut quoted : UInt16 = 0
  let mut escaped = false
  let mut depth = 0
  for i in 0..<source.length() {
    let c = source[i]
    if quoted != 0 {
      if escaped {
        escaped = false
      } else if c == '\\' && quoted != '`' {
        escaped = true
      } else if c == quoted {
        quoted = 0
      }
      continue
    }
    if c is ('"' | '\'' | '`') {
      quoted = c
      continue
    }
    if c == '(' {
      depth += 1
    }
    if c == ')' {
      depth -= 1
    }
    if depth == 0 &&
      (
        c == '=' ||
        (c == ':' && i + 1 < source.length() && source[i + 1] == '=')
      ) {
      let names = source[:i].split(",").map(s => s.trim().to_owned()).to_array()
      if !names.iter().all(n => n.has_prefix("$")) {
        return None
      }
      let declaration = c == ':'
      return Some(
        (
          names,
          declaration,
          source[i + (if declaration { 2 } else { 1 }):].trim().to_owned(),
        ),
      )
    }
  }
  None
}

///|
fn template_pipeline(
  source : String,
  dot : TemplateValue,
  env : TemplateEnv,
) -> TemplateValue raise @model.CliError {
  if template_assignment(source) is Some((names, declaration, target)) {
    let value = template_eval(target, dot, env)
    for name in names {
      env.bind(name, value, declaration)
    }
    value
  } else {
    template_eval(source, dot, env)
  }
}

///|
fn template_render(
  nodes : Array[TemplateNode],
  dot : TemplateValue,
  env : TemplateEnv,
  definitions : Map[String, Array[TemplateNode]],
  state : TemplateOutput,
) -> Int32 raise @model.CliError {
  for node in nodes {
    let control = match node {
      Text(s) => {
        state.out.write_string_utf8(s)
        0
      }
      Define(_, _) => 0
      Action(action) => {
        state.action = action
        if action == "break" {
          return 1
        }
        if action == "continue" {
          return 2
        }
        if template_assignment(action) is Some(_) {
          ignore(template_pipeline(action, dot, env))
        } else if action.has_prefix("template ") {
          let tokens = template_split(action[9:].to_owned(), ' ')
          guard tokens.get(0) is Some(name) &&
            definitions.get(name) is Some(body) else {
            raise CliError(
              "could not format error messages: undefined template",
            )
          }
          let root = if tokens.length() > 1 {
            template_eval(tokens[1:].join(" "), dot, env)
          } else {
            Nil
          }
          ignore(
            template_render(
              body,
              root,
              template_env(root, env.get("__allKinds")),
              definitions,
              state,
            ),
          )
        } else {
          state.out.write_bytes(
            template_value_bytes(template_eval(action, dot, env)),
          )
        }
        0
      }
      Conditional(expr, yes, no) | With(expr, yes, no) => {
        state.action = expr
        env.scopes.push(Map([]))
        defer ignore(env.scopes.pop())
        let value = template_pipeline(expr, dot, env)
        let truth = template_truth(value)
        template_render(
          if truth {
            yes
          } else {
            no
          },
          if node is With(_, _, _) && truth {
            value
          } else {
            dot
          },
          env,
          definitions,
          state,
        )
      }
      Range(expr, body, empty) => {
        state.action = expr
        env.scopes.push(Map([]))
        defer ignore(env.scopes.pop())
        let assignment = template_assignment(expr)
        let target = assignment.map(a => a.2).unwrap_or(expr)
        let value = template_eval(target, dot, env)
        let entries : Array[(TemplateValue, TemplateValue)] = match value {
          Sequence(xs, _) => xs.mapi((i, v) => (Integer(i.to_int64()), v))
          Record(m, ty) if !ty.has_prefix("*") => {
            let keys = m.keys().to_array()
            keys.sort_by(String::lexical_compare)
            keys.map(k => (Text(k), m[k]))
          }
          Missing | Nil => []
          _ =>
            raise CliError(
              "range can't iterate over \{template_value_string(value)}",
            )
        }
        if assignment is Some((names, declaration, _)) && declaration {
          for name in names {
            env.bind(name, value, true)
          }
        }
        if entries.is_empty() {
          let result = template_render(empty, dot, env, definitions, state)
          if result != 0 {
            return result
          }
        } else {
          for (key, item) in entries {
            if assignment is Some((names, _, _)) {
              if names.length() == 1 {
                env.bind(names[0], item, false)
              } else if names.length() == 2 {
                env.bind(names[0], key, false)
                env.bind(names[1], item, false)
              }
            }
            env.scopes.push(Map([]))
            let result = {
              defer ignore(env.scopes.pop())
              template_render(body, item, env, definitions, state)
            }
            if result == 1 {
              break
            }
          }
        }
        0
      }
    }
    if control != 0 {
      return control
    }
  }
  0
}
