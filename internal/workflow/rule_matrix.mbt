///|
fn yaml_subset(value : @model.Node, subset : @model.Node) -> Bool {
  if (value.kind == 1 && value.contains_expression()) ||
    (subset.kind == 1 && subset.contains_expression()) {
    return true
  }
  if value.kind != subset.kind {
    return false
  }
  match value.kind {
    1 => value.value == subset.value
    2 =>
      value.children.length() == subset.children.length() &&
      value.children
      .mapi((i, v) => yaml_subset(v, subset.children[i]))
      .iter()
      .all(x => x)
    3 =>
      subset
      .pairs()
      .iter()
      .all(pair => {
        value
        .get_ci(pair.0.value)
        .map(v => yaml_subset(v, pair.1))
        .unwrap_or(false)
      })
    _ => false
  }
}

///|
fn @model.Check::check_matrix(
  self : @model.Check,
  workflow : @model.Node,
) -> Unit {
  guard workflow.get("jobs") is Some(jobs) else { return }
  for (_, job) in jobs.pairs() {
    guard job.get("strategy") is Some(strategy) &&
      strategy.get("matrix") is Some(matrix) &&
      matrix.kind == 3 else {
      continue
    }
    let rows : Map[String, Array[@model.Node]] = Map([])
    let ignored : Map[String, Bool] = Map([])
    for (key, row) in matrix.pairs() {
      let name = key.value.to_lower()
      if name == "include" || name == "exclude" {
        continue
      }
      if row.kind == 1 {
        ignored[name] = true
        continue
      }
      if row.kind != 2 {
        continue
      }
      let seen : Array[@model.Node] = []
      for value in row.children {
        let mut found = false
        for previous in seen {
          if previous.raw_repr() == value.raw_repr() {
            self.report(
              value,
              "matrix",
              "duplicate value \{value.raw_repr()} is found in matrix \{@model.quote(key.value)}. the same value is at line:\{previous.line},col:\{previous.column}",
            )
            found = true
            break
          }
        }
        if !found {
          seen.push(value)
        }
      }
      rows[name] = row.children.copy()
    }
    if matrix.get_ci("include") is Some(included) {
      if included.kind == 1 ||
        included.children.iter().any(n => n.kind == 1 && n.is_expression()) {
        continue
      }
      for combination in included.children {
        for (key, value) in combination.pairs() {
          let name = key.value.to_lower()
          if ignored.get(name) == Some(true) {
            continue
          }
          let row = rows.get(name).unwrap_or([])
          if !row
            .iter()
            .any(v => yaml_subset(v, value) && yaml_subset(value, v)) {
            row.push(value)
          }
          rows[name] = row
        }
      }
    }
    if matrix.get_ci("exclude") is Some(excluded) &&
      excluded.kind == 2 &&
      !excluded.children.is_empty() {
      if rows.is_empty() &&
        ignored.is_empty() &&
        matrix.get_ci("include") is None {
        self.report(
          strategy.key("matrix").unwrap_or(matrix),
          "matrix",
          "\"exclude\" section exists but no matrix variation exists",
        )
        continue
      }
      for combination in excluded.children {
        for (key, value) in combination.pairs() {
          let name = key.value.to_lower()
          if ignored.get(name) == Some(true) {
            continue
          }
          if rows.get(name) is Some(row) {
            if !row.iter().any(v => yaml_subset(v, value)) {
              self.report(
                value,
                "matrix",
                "value \{value.raw_repr()} in \"exclude\" does not match in matrix \{@model.quote(name)} combinations. possible values are \{row.map(@model.Node::raw_repr).join(", ")}",
              )
            }
          } else {
            self.report(
              key,
              "matrix",
              "\{@model.quote(name)} in \"exclude\" section does not exist in matrix. available matrix configurations are \{@model.quotes(rows.keys().to_array())}",
            )
          }
        }
      }
    }
  }
}
