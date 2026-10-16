///|
async test "upstream JSON JSONL Markdown and SARIF formats" {
  let source = @fs.read_file("baseline/testdata/format/test.yaml").text()
  let config = @config.Config::{ labels: [], variables: None, paths: [], }
  let errors = lint_source(
    source,
    config,
    metadata_cache(),
    Some("baseline/testdata/format"),
    None,
  )
  let fields = Json::array(
    errors.map(e => {
      @output.diagnostic_json(e, "testdata/format/test.yaml", source)
    }),
  )
  let formats = [
    ("json", "{{json .}}"),
    ("jsonl", "{{range $err := .}}{{json $err}}{{end}}"),
    (
      "md", "{{range $ := .}}### Error at line {{$.Line}}, col {{$.Column}} of `{{$.Filepath}}`\\n\\n{{$.Message}}\\n\\n```\\n{{$.Snippet}}\\n```\\n\\n{{end}}",
    ),
  ]
  for (extension, format) in formats {
    let want = @fs.read_file("baseline/testdata/format/test." + extension).text()
    let actual = format_errors(format, fields) catch {
      CliError(message) => fail(message)
    }
    assert_eq(actual, want, msg="upstream .\{extension} output")
  }
  let template = @fs.read_file("baseline/testdata/format/sarif_template.txt").text()
  let rendered = format_errors(template, fields) catch {
    CliError(message) => fail(message)
  }
  let actual = @json.parse(rendered)
  let want = @json.parse(
    @fs.read_file("baseline/testdata/format/test.sarif").text(),
  )
  if @jsonutil.data_get(want, "runs") is Array(runs) && runs.length() > 0 {
    if @jsonutil.data_get(@jsonutil.data_get(runs[0], "tool"), "driver")
      is Object(driver) {
      driver["version"] = Json::string("0.0.1")
    }
  }
  assert_eq(actual, want, msg="upstream SARIF output")
}
