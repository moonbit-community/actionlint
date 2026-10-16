///|
fn path_clean(path : String) -> String {
  let parts : Array[String] = []
  for piece in path.split("/") {
    match piece {
      "" | "." => ()
      ".." =>
        if parts.last() is Some(p) && p != ".." {
          ignore(parts.pop())
        } else if !path.has_prefix("/") {
          parts.push("..")
        }
      _ => parts.push(piece.to_owned())
    }
  }
  let result = (if path.has_prefix("/") { "/" } else { "" }) + parts.join("/")
  if result == "" {
    "."
  } else {
    result
  }
}

///|
pub fn path_join(a : String, b : String) -> String {
  path_clean(a + "/" + b)
}

///|
fn path_dir(path : String) -> String {
  match path.rev_find("/") {
    Some(0) => "/"
    Some(i) => path[:i].to_owned()
    None => "."
  }
}

///|
fn path_abs(path : String) -> String {
  if path.has_prefix("/") {
    path_clean(path)
  } else {
    path_join(@env.current_dir().unwrap_or("."), path)
  }
}

///|
pub fn path_relative(path : String, dir : String) -> String {
  let a = path_abs(path).split("/").to_array()
  let b = path_abs(dir).split("/").to_array()
  let mut common = 0
  while common < a.length() && common < b.length() && a[common] == b[common] {
    common += 1
  }
  let result : Array[String] = []
  for _ in common..<b.length() {
    result.push("..")
  }
  for i in common..<a.length() {
    result.push(a[i].to_owned())
  }
  if result.is_empty() {
    "."
  } else {
    result.join("/")
  }
}

///|
pub async fn find_project(path : String) -> String? {
  let mut dir = path_abs(path)
  if @fs.exists(dir) && @fs.kind(dir) != Directory {
    dir = path_dir(dir)
  }
  while true {
    if @fs.exists(path_join(dir, ".git")) &&
      @fs.exists(path_join(dir, ".github/workflows")) {
      return Some(dir)
    }
    let parent = path_dir(dir)
    if parent == dir {
      return None
    }
    dir = parent
  }
  None
}

///|
pub async fn collect_workflows(dir : String, files : Array[String]) -> Unit {
  for name in @fs.readdir(dir, include_hidden=true, sort=true) {
    let path = path_join(dir, name)
    if @fs.kind(path, follow_symlink=false) == Directory {
      collect_workflows(path, files)
    } else if name.has_suffix(".yaml") || name.has_suffix(".yml") {
      files.push(path)
    }
  }
}

///|
#warnings("-alert_internal")
pub fn file_error(error : Error, path : String) -> String {
  match error {
    @os_error.OSError(code, ..) =>
      (if code == 21 { "read " } else { "open " }) +
      path +
      ": " +
      @os_error.errno_to_string(code).to_lower()
    _ => error.to_string()
  }
}
