///|
#cfg(target="native")
fn test_backend() -> String {
  "native"
}

///|
#cfg(target="wasm")
fn test_backend() -> String {
  "wasm"
}

///|
async test "upstream workflow fixtures" {
  let differences = @json.parse(
    @fs.read_file("scripts/fixture_differences.json").text(),
  )
  let results : Array[Json] = []
  let mut failed = 0
  let mut total = 0
  for directory in ["ok", "err", "examples"] {
    let root = "baseline/testdata/" + directory
    for filename in @fs.readdir(root, sort=true) {
      if !filename.has_suffix(".yaml") && !filename.has_suffix(".yml") {
        continue
      }
      let path = root + "/" + filename
      let source = @fs.read_file(path).text()
      let config = @config.Config::{ labels: [], variables: None, paths: [], }
      let shellcheck = if filename.contains("shellcheck") {
        find_executable("shellcheck")
      } else {
        None
      }
      let missing = if filename.contains("shellcheck") && shellcheck is None {
        "shellcheck"
      } else {
        ""
      }
      if missing != "" {
        assert_false(
          @env.get_env_var("ACTIONLINT_REQUIRE_CHECKERS").unwrap_or("") == "1",
          msg=missing + " is required by the full compatibility suite",
        )
        results.push(
          Json::object({
            "file": Json::string(path),
            "skipped": Json::string(missing + " executable not found"),
          }),
        )
        continue
      }
      let actual = lint_source(
        source,
        config,
        metadata_cache(),
        Some(root),
        shellcheck,
      ).map(e => e.oneline("test.yaml"))
      let golden = path[:path.length() -
        (if filename.has_suffix(".yaml") { 5 } else { 4 })].to_owned() +
        ".out"
      let expected = if @fs.exists(golden) {
        @fs.read_file(golden)
        .text()
        .split("\n")
        .filter(s => s != "")
        .map(s => s.to_owned())
        .to_array()
      } else {
        []
      }
      let baseline_expected = expected.copy()
      let difference = @jsonutil.data_get(differences, path)
      let expected = if difference is Object(_) {
        assert_true(
          @jsonutil.template_string(
            @jsonutil.data_get(difference, "difference_reason"),
          ) !=
          "",
        )
        assert_eq(
          baseline_expected,
          @jsonutil.json_strings(
            @jsonutil.data_get(difference, "baseline_expected"),
          ),
        )
        @jsonutil.json_strings(@jsonutil.data_get(difference, "expected"))
      } else {
        expected
      }
      if directory != "ok" && !@fs.exists(golden) {
        continue
      }
      total += 1
      let pass = actual.length() == expected.length() &&
        expected
        .mapi((i, want) => {
          if want.has_prefix("/") && want.has_suffix("/") {
            @matching.regex_match(
              want[1:want.length() - 1].to_owned(),
              actual[i],
            )
          } else {
            actual[i] == want
          }
        })
        .iter()
        .all(x => x)
      if !pass {
        failed += 1
      }
      results.push(
        Json::object({
          "file": Json::string(path),
          "pass": Json::boolean(pass),
          "expected": Json::array(expected.map(Json::string)),
          "baseline_expected": Json::array(baseline_expected.map(Json::string)),
          "difference_reason": @jsonutil.data_get(
            difference, "difference_reason",
          ),
          "actual": Json::array(actual.map(Json::string)),
        }),
      )
    }
  }
  @fs.write_file(
    "_build/compatibility-" + test_backend() + ".json",
    Json::array(results).stringify(),
  )
  assert_eq(
    failed,
    0,
    msg="\{failed}/\{total} upstream cases differ; see _build/compatibility-\{test_backend()}.json",
  )
}

///|
async test "upstream project fixtures" {
  let root = "baseline/testdata/projects"
  let results : Array[Json] = []
  let mut failures = 0
  for name in @fs.readdir(root, sort=true) {
    let project = root + "/" + name
    if @fs.kind(project, follow_symlink=false) != Directory {
      continue
    }
    let config_file = project + "/actionlint.yaml"
    let config = if @fs.exists(config_file) {
      @config.parse_config(@fs.read_file(config_file).text())
    } else {
      { labels: [], variables: None, paths: [], }
    }
    let files = []
    @project.collect_workflows(project + "/workflows", files)
    files.sort_by(String::lexical_compare)
    let actual = []
    let cache = metadata_cache()
    for file in files {
      let errors = lint_source(
        @fs.read_file(file).text(),
        config,
        cache,
        Some(project),
        None,
      )
      for error in errors {
        // The upstream module is nested under baseline/ in this repository.
        if !config.ignored(file, error.message, Some(project)) {
          actual.push(
            error
            .oneline(@project.path_relative(file, project))
            .replace_all(old="baseline/testdata", new="testdata"),
          )
        }
      }
    }
    let expected = @fs.read_file(project + ".out")
      .text()
      .split("\n")
      .filter(s => s != "")
      .map(s => s.to_owned())
      .to_array()
    let pass = expected.length() == actual.length() &&
      expected
      .mapi((i, want) => {
        if want.has_prefix("/") && want.has_suffix("/") {
          @matching.regex_match(want[1:want.length() - 1].to_owned(), actual[i])
        } else {
          actual[i] == want
        }
      })
      .iter()
      .all(x => x)
    if !pass {
      failures += 1
    }
    results.push(
      Json::object({
        "file": Json::string(project),
        "pass": Json::boolean(pass),
        "expected": Json::array(expected.map(Json::string)),
        "actual": Json::array(actual.map(Json::string)),
      }),
    )
  }
  @fs.write_file(
    "_build/projects-" + test_backend() + ".json",
    Json::array(results).stringify(),
  )
  assert_eq(
    failures,
    0,
    msg="\{failures} upstream projects differ; see _build/projects-\{test_backend()}.json",
  )
}
