///|
fn behavior_node(source : String) -> @model.Node raise {
  let check = @model.Check::{ errors: [], }
  let root = parse_yaml(source, check)
  assert_eq(check.errors.length(), 0)
  guard root is Some(root) else { fail("expected YAML document") }
  root
}
