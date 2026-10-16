///|
pub fn regex_match(pattern : String, text : String) -> Bool {
  let re = compile_re2(pattern) catch { _ => return false }
  re.execute(text).matched()
}
