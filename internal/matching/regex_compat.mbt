///|
pub fn compile_re2(source : String) -> @regexp.Regexp raise @model.CliError {
  if re2_cache.get(source) is Some(compiled) {
    return compiled
  }
  let pattern = re2_translate(source)
  let groups : Array[Int64] = []
  let mut largest = 0L
  let mut atom = 0L
  let mut in_class = false
  let mut i = 0
  while i < pattern.length() {
    let c = pattern[i]
    i += 1
    if in_class {
      if c == '\\' {
        i += 1
      } else if c == ']' {
        in_class = false
      }
      continue
    }
    if c == '\\' {
      largest = largest.max(atom)
      atom = 1L
      if i < pattern.length() &&
        pattern[i] == 'u' &&
        i + 1 < pattern.length() &&
        pattern[i + 1] == '{' {
        if pattern[i + 2:].find("}") is Some(end) {
          i += end + 3
        }
      } else {
        i += 1
      }
      continue
    }
    if c == '[' {
      largest = largest.max(atom)
      atom = 1L
      in_class = true
      continue
    }
    if c == '(' {
      groups.push(largest.max(atom))
      largest = 0L
      atom = 0L
      continue
    }
    if c == ')' {
      atom = largest.max(atom)
      largest = groups.pop().unwrap_or(0L)
      continue
    }
    if c == '|' {
      largest = largest.max(atom)
      atom = 0L
      continue
    }
    if c is ('*' | '+' | '?') {
      continue
    }
    if c != '{' {
      largest = largest.max(atom)
      atom = 1L
      continue
    }
    let start = i - 1
    guard pattern[start:].find("}") is Some(relative) else { continue }
    let end = start + relative
    let counts = pattern[i:end].split(",").to_array()
    if counts.is_empty() ||
      counts.length() > 2 ||
      counts[0] == "" ||
      !counts.iter().all(s => s.iter().all(c => c is ('0'..<='9'))) {
      continue
    }
    let minimum = @string.parse_int64(counts[0], base=10) catch { _ => 1001L }
    let maximum = if counts.length() == 1 {
      minimum
    } else if counts[1] == "" {
      -1L
    } else {
      @string.parse_int64(counts[1], base=10) catch {
        _ => 1001L
      }
    }
    let copies = if maximum < 0L { minimum } else { maximum }
    if minimum > 1000L ||
      maximum > 1000L ||
      (maximum >= 0L && minimum > maximum) ||
      copies * atom > 1000L {
      raise CliError(
        "error parsing regexp: invalid repeat count: `\{pattern[start:end + 1]}`",
      )
    }
    atom *= copies
    i = end + 1
  }
  let compiled = @regexp.compile(pattern) catch {
    error => raise CliError(error.to_string())
  }
  re2_cache[source] = compiled
  compiled
}

///|
let re2_cache : Map[String, @regexp.Regexp] = Map([])
