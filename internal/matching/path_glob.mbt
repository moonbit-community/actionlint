///|
priv enum PathGlobToken {
  Literal(Char)
  One
  Star
  Tree
  TreePrefix
  TreeTail
  Class(Bool, Array[(Char, Char)])
}

///|
fn glob_alternatives(pattern : String) -> Array[String]? {
  let chars = pattern.to_array()
  let mut escaped = false
  let mut in_class = false
  let mut start = -1
  let mut depth = 0
  let mut previous = 0
  let parts : Array[String] = []
  for i, c in chars {
    if escaped {
      escaped = false
      continue
    }
    if c == '\\' {
      escaped = true
      continue
    }
    if c == '[' {
      in_class = true
    }
    if c == ']' {
      in_class = false
    }
    if in_class {
      continue
    }
    if c == '{' {
      if depth == 0 {
        start = i
        previous = i + 1
      }
      depth += 1
    } else if c == ',' && depth == 1 {
      parts.push(String::from_array(chars[previous:i].to_owned()))
      previous = i + 1
    } else if c == '}' {
      depth -= 1
      if depth < 0 {
        return None
      }
      if depth == 0 {
        parts.push(String::from_array(chars[previous:i].to_owned()))
        let prefix = String::from_array(chars[:start].to_owned())
        let suffix = String::from_array(chars[i + 1:].to_owned())
        let result = []
        for part in parts {
          guard glob_alternatives(prefix + part + suffix) is Some(expanded) else {
            return None
          }
          result.append(expanded)
        }
        return Some(result)
      }
    }
  }
  if depth != 0 {
    None
  } else {
    Some([pattern])
  }
}

///|
fn parse_path_glob(
  pattern : String,
  doublestar : Bool,
) -> Array[Array[PathGlobToken]]? {
  let variants = if doublestar {
    glob_alternatives(pattern)
  } else {
    Some([pattern])
  }
  guard variants is Some(variants) else { return None }
  let result = []
  for variant in variants {
    let p = variant.to_array()
    let tokens = []
    let mut i = 0
    while i < p.length() {
      let c = p[i]
      i += 1
      match c {
        '\\' => {
          if i >= p.length() {
            return None
          }
          tokens.push(Literal(p[i]))
          i += 1
        }
        '?' => tokens.push(One)
        '*' => {
          let start = i - 1
          while i < p.length() && p[i] == '*' {
            i += 1
          }
          if doublestar && i - start == 2 && (start == 0 || p[start - 1] == '/') {
            if i == p.length() {
              tokens.push(Tree)
            } else if p[i] == '/' {
              tokens.push(TreePrefix)
              i += 1
            } else {
              tokens.push(Star)
            }
          } else {
            tokens.push(Star)
          }
        }
        '/' =>
          if doublestar && i + 2 == p.length() && p[i] == '*' && p[i + 1] == '*' {
            tokens.push(TreeTail)
            i += 2
          } else {
            tokens.push(Literal('/'))
          }
        '[' => {
          let negated = i < p.length() &&
            (p[i] == '^' || (doublestar && p[i] == '!'))
          if negated {
            i += 1
          }
          let ranges : Array[(Char, Char)] = []
          while i < p.length() && p[i] != ']' {
            let mut low = p[i]
            if low == '\\' {
              i += 1
              if i >= p.length() {
                return None
              }
              low = p[i]
            } else if !doublestar && low == '-' {
              return None
            }
            i += 1
            let mut high = low
            if i < p.length() &&
              p[i] == '-' &&
              (!doublestar || (i + 1 < p.length() && p[i + 1] != ']')) {
              i += 1
              if i >= p.length() ||
                (!doublestar && (p[i] == ']' || p[i] == '-')) {
                return None
              }
              high = p[i]
              if high == '\\' {
                i += 1
                if i >= p.length() {
                  return None
                }
                high = p[i]
              }
              i += 1
            }
            ranges.push(
              (low, if doublestar && high < low { low } else { high }),
            )
          }
          if ranges.is_empty() || i >= p.length() {
            return None
          }
          i += 1
          tokens.push(Class(negated, ranges))
        }
        _ => tokens.push(Literal(c))
      }
    }
    result.push(tokens)
  }
  Some(result)
}

///|
pub fn glob_valid(pattern : String, doublestar~ : Bool = true) -> Bool {
  parse_path_glob(pattern, doublestar) is Some(_)
}

///|
fn path_glob_match(tokens : Array[PathGlobToken], text : Array[Char]) -> Bool {
  let memo : Map[(Int32, Int32), Bool] = Map([])
  fn matches(i : Int32, j : Int32) -> Bool {
    if memo.get((i, j)) is Some(result) {
      return result
    }
    let result = if i == tokens.length() {
      j == text.length()
    } else {
      match tokens[i] {
        Literal(c) => j < text.length() && c == text[j] && matches(i + 1, j + 1)
        One => j < text.length() && text[j] != '/' && matches(i + 1, j + 1)
        Class(negated, ranges) =>
          j < text.length() &&
          ranges.iter().any(r => r.0 <= text[j] && text[j] <= r.1) != negated &&
          matches(i + 1, j + 1)
        Star =>
          matches(i + 1, j) ||
          (j < text.length() && text[j] != '/' && matches(i, j + 1))
        Tree => matches(i + 1, j) || (j < text.length() && matches(i, j + 1))
        TreeTail =>
          j == text.length() ||
          (text[j] == '/' && matches(i + 1, text.length()))
        TreePrefix => {
          let mut found = matches(i + 1, j)
          for k = j; k < text.length() && !found; k = k + 1 {
            if text[k] == '/' {
              found = matches(i + 1, k + 1)
            }
          }
          found
        }
      }
    }
    memo[(i, j)] = result
    result
  }
  matches(0, 0)
}

///|
pub fn glob_match(pattern : String, text : String, doublestar : Bool) -> Bool {
  guard parse_path_glob(pattern, doublestar) is Some(variants) else {
    return false
  }
  variants.iter().any(tokens => path_glob_match(tokens, text.to_array()))
}
