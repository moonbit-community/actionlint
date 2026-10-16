///|
pub struct UntrustedChecker {
  priv mut candidates : Array[String]
  priv mut start : Int32
  priv mut filtering : Bool
  priv mut safe_calls : Int32
}

///|
pub fn untrusted_checker() -> UntrustedChecker {
  { candidates: [], start: 0, filtering: false, safe_calls: 0, }
}

///|
let untrusted_paths : Array[String] = [
  "github.head_ref", "github.event.issue.title", "github.event.issue.body", "github.event.pull_request.title",
  "github.event.pull_request.body", "github.event.pull_request.head.ref", "github.event.pull_request.head.label",
  "github.event.pull_request.head.repo.default_branch", "github.event.comment.body",
  "github.event.review.body", "github.event.review_comment.body", "github.event.pages.*.page_name",
  "github.event.commits.*.message", "github.event.commits.*.author.email", "github.event.commits.*.author.name",
  "github.event.head_commit.message", "github.event.head_commit.author.email", "github.event.head_commit.author.name",
  "github.event.discussion.title", "github.event.discussion.body",
]

///|
pub fn ExprScope::untrusted_end(
  self : ExprScope,
  state : UntrustedChecker,
) -> Unit {
  let matches = state.candidates.filter(path => untrusted_paths.contains(path))
  if matches.length() == 1 {
    self.report(
      state.start,
      "\{@model.quote(matches[0])} is potentially untrusted. avoid using it directly in inline scripts. instead, pass it through an environment variable. see https://docs.github.com/en/actions/reference/security/secure-use#good-practices-for-mitigating-script-injection-attacks for more details",
    )
  } else if matches.length() > 1 {
    self.report(
      state.start,
      "object filter extracts potentially untrusted properties \{@model.quotes(matches)}. avoid using the value directly in inline scripts. instead, pass the value through an environment variable. see https://docs.github.com/en/actions/reference/security/secure-use#good-practices-for-mitigating-script-injection-attacks for more details",
    )
  }
  state.candidates = []
  state.filtering = false
}

///|
fn untrusted_safe(expr : Expr) -> Bool {
  expr.kind == "call" &&
  ["contains", "startswith", "endswith"].contains(expr.value.to_lower())
}

///|
fn ExprScope::untrusted_leave(
  self : ExprScope,
  state : UntrustedChecker,
  expr : Expr,
) -> Unit {
  if state.safe_calls > 0 {
    if untrusted_safe(expr) {
      state.safe_calls -= 1
    }
    return
  }
  match expr.kind {
    "variable" => {
      self.untrusted_end(state)
      if expr.value.to_lower() == "github" {
        state.start = expr.offset
        state.candidates = ["github"]
      }
    }
    "property" =>
      state.candidates = state.candidates.map(p => p + "." + expr.value)
    "index" =>
      if expr.children[1].kind == "string" {
        state.candidates = state.candidates.map(p => {
          p + "." + expr.children[1].value
        })
      } else if state.filtering {
        state.filtering = false
      } else {
        state.candidates = state.candidates.map(p => p + ".*")
      }
    "filter" => {
      let next : Array[String] = []
      for prefix in state.candidates {
        let array_prefix = prefix + ".*"
        if untrusted_paths.iter().any(p => p.has_prefix(array_prefix + ".")) {
          next.push(array_prefix)
        } else {
          for path in untrusted_paths {
            if path.has_prefix(prefix + ".") {
              let part = path[prefix.length() + 1:]
                .split(".")
                .next()
                .unwrap_or("")
              let child = prefix + "." + part.to_owned()
              if !next.contains(child) {
                next.push(child)
              }
            }
          }
        }
      }
      state.candidates = next
      state.filtering = true
    }
    _ => self.untrusted_end(state)
  }
  state.candidates = state.candidates.filter(prefix => {
    untrusted_paths.iter().any(p => p == prefix || p.has_prefix(prefix + "."))
  })
}
