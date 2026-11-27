# Behavior regressions

160 migrated cases. Inputs are in [fixtures/behavior.json](fixtures/behavior.json).
Each case asserts stdout, stderr, and exit status; only elapsed milliseconds vary.

## control-valid

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 0 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## control-invalid-runner

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 1 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:14: label "does-not-exist" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## format-placeholder-overflow

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 2 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: format string "{2147483648}" contains placeholder {2147483648} but only 1 arguments are given to format [expression]
<stdin>:7:19: format string "{2147483648}" does not contain placeholder {0}. remove argument which is unused in the format string [expression]
@STDERR (empty)
[1]
```

## comment-only-workflow

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 3 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:1: workflow is empty [syntax-check]
@STDERR (empty)
[1]
```

## explicit-yaml-int-tag

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 4 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## timeout-hex-literal

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 5 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:22: invalid float value: "0x10": strconv.ParseFloat: parsing "0x10": invalid syntax [syntax-check]
@STDERR (empty)
[1]
```

## fromjson-key-uppercase-index

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 6 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## fromjson-key-lowercase-index

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 7 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: property "foo" is not defined in object type {Foo: number} [expression]
@STDERR (empty)
[1]
```

## format-escaped-braces

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 8 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: format string "{{0}}" does not contain placeholder {0}. remove argument which is unused in the format string [expression]
@STDERR (empty)
[1]
```

## docker-invalid-url

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 9 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:15: URI for Docker container "docker://a%xx" is invalid: parse "docker://a%xx": invalid URL escape "%xx" (tag=) [action]
@STDERR (empty)
[1]
```

## docker-nonempty-tag-ending-colon

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 10 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## deprecated-command-false-positive

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 11 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## deprecated-command-tab-separator

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 12 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:14: workflow command "set-output" was deprecated. use `echo "{name}={value}" >> $GITHUB_OUTPUT` instead: https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions [deprecated-commands]
@STDERR (empty)
[1]
```

## cron-unsatisfiable-date

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 13 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: scheduled job runs too frequently. it runs once per 0 seconds. the shortest interval is once every 5 minutes [events]
@STDERR (empty)
[1]
```

## cron-invalid-timezone-prefix

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 14 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: invalid CRON format "TZ=Bad/Zone 0 0 * * *" in schedule event: provided bad location Bad/Zone: unknown time zone Bad/Zone [events]
@STDERR (empty)
[1]
```

## composite-empty-steps

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 15
@STDOUT (empty)
@STDERR (empty)
```

## action-steps-scalar

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 16
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/action": line 5: cannot unmarshal !!int `1` into []interface {} [action]
@STDERR (empty)
[1]
```

## action-required-yaml-yes

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 17
@STDOUT
.github/workflows/main.yml:6:15: missing input "foo" which is required by action "Test" defined at "./action". all required inputs are "foo" [action]
@STDERR (empty)
[1]
```

## action-required-invalid-string

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 18
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/action": line 10: cannot unmarshal !!str `garbage` into bool [action]
@STDERR (empty)
[1]
```

## action-required-null-default

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 19
@STDOUT
.github/workflows/main.yml:6:15: missing input "foo" which is required by action "Test" defined at "./action". all required inputs are "foo" [action]
@STDERR (empty)
[1]
```

## action-empty-disallowed-args

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 20
@STDOUT
.github/workflows/main.yml:6:15: "args" is not allowed in "runs" section because "Test" is a Composite action. the action is defined at "$PROJECT/action" [action]
@STDERR (empty)
[1]
```

## action-input-name-diagnostic-case

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 21
@STDOUT
.github/workflows/main.yml:6:15: missing input "CamelCase" which is required by action "Test" defined at "./action". all required inputs are "CamelCase" [action]
@STDERR (empty)
[1]
```

## workflow-required-uppercase-true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 22
@STDOUT
.github/workflows/main.yml:4:11: input "foo" is required by "./.github/workflows/callee.yml" reusable workflow [workflow-call]
@STDERR (empty)
[1]
```

## workflow-required-invalid-string

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 23
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/callee.yml": yaml: unmarshal errors:   line 6: cannot unmarshal !!str `garbage` into bool [workflow-call]
@STDERR (empty)
[1]
```

## workflow-required-null-default

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 24
@STDOUT
.github/workflows/main.yml:4:11: input "foo" is required by "./.github/workflows/callee.yml" reusable workflow [workflow-call]
@STDERR (empty)
[1]
```

## ignore-re2-quoted-literal

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 25 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '\Qunknown\E' -
@STDOUT (empty)
@STDERR (empty)
```

## ignore-re2-repeat-limit

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore 'unknown{1001}' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "unknown{1001}": error parsing regexp: invalid repeat count: `{1001}`
[3]
```

## printf-zero-padding

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 27 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%04d" 3}}' -
@STDOUT
0003 (no-eol)
@STDERR (empty)
[1]
```

## template-parenthesized-field

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 28 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%s" (index . 0).Kind}}' -
@STDOUT
events (no-eol)
@STDERR (empty)
[1]
```

## template-break

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 29 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{range .}}{{break}}{{end}}' -
@STDOUT (empty)
@STDERR (empty)
[1]
```

## template-unknown-field

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 30 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{range .}}{{.Unknown}}{{end}}' -
@STDOUT (empty)
@STDERR (empty)
[1]
```

## variadic-signature-diagnostic

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 31 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: number of arguments is wrong. function "format(string, any...) -> string" takes at least 2 parameters but 1 arguments are given [expression]
@STDERR (empty)
[1]
```

## explicit-document-start-position

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 32 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:1: "jobs" section is missing in workflow [syntax-check]
<stdin>:1:1: "on" section is missing in workflow [syntax-check]
<stdin>:2:1: "workflow" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## invalid-yaml-parser-diagnostic

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 33 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:4: could not parse as YAML: did not find expected ',' or ']' [syntax-check]
@STDERR (empty)
[1]
```

## template-error-suppression

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 34 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:47: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## pyflakes-missing-final-newline

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 35
@STDOUT (empty)
@STDERR
flag provided but not defined: -pyflakes
Usage: actionlint [FLAGS] [FILES...] [-]
"" (escaped)
"  actionlint is a linter for GitHub Actions workflow files." (escaped)
"" (escaped)
"  To check all YAML files in current repository, just run actionlint without" (escaped)
"  arguments. It automatically finds the nearest '.github/workflows' directory:" (escaped)
"" (escaped)
"    $ actionlint" (escaped)
"" (escaped)
"  To check specific files, pass the file paths as arguments:" (escaped)
"" (escaped)
"    $ actionlint file1.yaml file2.yaml" (escaped)
"" (escaped)
"  To check content which is not saved in file yet (e.g. output from some" (escaped)
"  command), pass - argument. It reads stdin and checks it as workflow file:" (escaped)
"" (escaped)
"    $ actionlint -" (escaped)
"" (escaped)
"  To serialize errors into JSON, use -format option. It allows to format error" (escaped)
"  messages flexibly with Go template syntax." (escaped)
"" (escaped)
"    $ actionlint -format '{{json .}}'" (escaped)
"" (escaped)
Documents:
"" (escaped)
"  - List of checks: https://github.com/rhysd/actionlint/tree/main/docs/checks.md" (escaped)
"  - Usage:          https://github.com/rhysd/actionlint/tree/main/docs/usage.md" (escaped)
"  - Configuration:  https://github.com/rhysd/actionlint/tree/main/docs/config.md" (escaped)
"" (escaped)
Flags:
"  -color" (escaped)
"    \tAlways enable colorful output. This is useful to force colorful outputs" (escaped)
"  -config-file string" (escaped)
"    \tFile path to config file" (escaped)
"  -debug" (escaped)
"    \tEnable debug output (for development)" (escaped)
"  -format string" (escaped)
"    \tCustom template to format error messages in Go template syntax. See the usage documentation for more details" (escaped)
"  -ignore value" (escaped)
"    \tRegular expression matching to error messages you want to ignore. This flag is repeatable" (escaped)
"  -init-config" (escaped)
"    \tGenerate default config file at .github/actionlint.yaml in current project" (escaped)
"  -no-color" (escaped)
"    \tDisable colorful output" (escaped)
"  -oneline" (escaped)
"    \tUse one line per one error. Useful for reading error messages from programs" (escaped)
"  -shellcheck string" (escaped)
"    \tCommand name or file path of \"shellcheck\" external command. If empty, shellcheck integration will be disabled (default \"shellcheck\")" (escaped)
"  -stdin-filename string" (escaped)
"    \tFile name when reading input from stdin (default \"<stdin>\")" (escaped)
"  -verbose" (escaped)
"    \tEnable verbose output" (escaped)
"  -version" (escaped)
"    \tShow version and how this binary was installed" (escaped)
[2]
```

## boundary-format-int64-max

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 36 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: format string "{9223372036854775807}" contains placeholder {9223372036854775807} but only 1 arguments are given to format [expression]
<stdin>:7:19: format string "{9223372036854775807}" does not contain placeholder {0}. remove argument which is unused in the format string [expression]
@STDERR (empty)
[1]
```

## boundary-format-int64-overflow

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 37 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: format string "{9223372036854775808}" contains placeholder {9223372036854775807} but only 1 arguments are given to format [expression]
<stdin>:7:19: format string "{9223372036854775808}" does not contain placeholder {0}. remove argument which is unused in the format string [expression]
@STDERR (empty)
[1]
```

## boundary-format-huge-overflow

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 38 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: format string "{99999999999999999999999999999999999999999999999999999999999999999999999999999999}" contains placeholder {9223372036854775807} but only 1 arguments are given to format [expression]
<stdin>:7:19: format string "{99999999999999999999999999999999999999999999999999999999999999999999999999999999}" does not contain placeholder {0}. remove argument which is unused in the format string [expression]
@STDERR (empty)
[1]
```

## boundary-format-int32-max

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 39 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: format string "{2147483647}" contains placeholder {2147483647} but only 1 arguments are given to format [expression]
<stdin>:7:19: format string "{2147483647}" does not contain placeholder {0}. remove argument which is unused in the format string [expression]
@STDERR (empty)
[1]
```

## boundary-format-even-close

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 40 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: format string "{0}}" does not contain placeholder {0}. remove argument which is unused in the format string [expression]
<stdin>:7:19: format string "{0}}" does not contain placeholder {1}. remove argument which is unused in the format string [expression]
@STDERR (empty)
[1]
```

## boundary-format-odd-close

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 41 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: format string "{0}}}" does not contain placeholder {1}. remove argument which is unused in the format string [expression]
@STDERR (empty)
[1]
```

## boundary-format-escaped-opening

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 42 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: format string "{{{0}}}" does not contain placeholder {1}. remove argument which is unused in the format string [expression]
@STDERR (empty)
[1]
```

## boundary-format-empty

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 43 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: format string "{}" does not contain placeholder {0}. remove argument which is unused in the format string [expression]
<stdin>:7:19: format string "{}" does not contain placeholder {1}. remove argument which is unused in the format string [expression]
@STDERR (empty)
[1]
```

## boundary-format-restart

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 44 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: format string "{x{0}" does not contain placeholder {1}. remove argument which is unused in the format string [expression]
@STDERR (empty)
[1]
```

## boundary-format-consecutive

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 45 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-format-mixed

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 46 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: format string "{{0}} {1}" does not contain placeholder {0}. remove argument which is unused in the format string [expression]
@STDERR (empty)
[1]
```

## boundary-format-trailing

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 47 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: format string "{0" does not contain placeholder {0}. remove argument which is unused in the format string [expression]
<stdin>:7:19: format string "{0" does not contain placeholder {1}. remove argument which is unused in the format string [expression]
@STDERR (empty)
[1]
```

## boundary-format-leading-zeros

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 48 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: format string "{0000}" does not contain placeholder {1}. remove argument which is unused in the format string [expression]
@STDERR (empty)
[1]
```

## boundary-fromjson-distinct-keys

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 49 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-context-case-insensitive

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 50 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-interpolation-null-valid

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 51 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:16: object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type null [expression]
@STDERR (empty)
[1]
```

## boundary-interpolation-error-before-null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 52 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:20: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## boundary-yaml-empty

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 53 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:1: workflow is empty [syntax-check]
@STDERR (empty)
[1]
```

## boundary-yaml-blank

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 54 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:2:0: could not parse as YAML: found character that cannot start any token [syntax-check]
@STDERR (empty)
[1]
```

## boundary-yaml-comments

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 55 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:1: workflow is empty [syntax-check]
@STDERR (empty)
[1]
```

## boundary-yaml-document-comment

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 56 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:2:1: "jobs" section is missing in workflow [syntax-check]
<stdin>:2:1: "on" section is missing in workflow [syntax-check]
<stdin>:3:1: "workflow" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## boundary-yaml-document-null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 57 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:1: "jobs" section is missing in workflow [syntax-check]
<stdin>:1:1: "on" section is missing in workflow [syntax-check]
<stdin>:2:1: "workflow" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## boundary-yaml-document-content

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 58 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:1: "jobs" section is missing in workflow [syntax-check]
@STDERR (empty)
[1]
```

## boundary-yaml-flow-map

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 59 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:4: could not parse as YAML: did not find expected ',' or '}' [syntax-check]
@STDERR (empty)
[1]
```

## boundary-yaml-flow-nested

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 60 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:8: could not parse as YAML: did not find expected ',' or ']' [syntax-check]
@STDERR (empty)
[1]
```

## boundary-yaml-flow-multiline

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 61 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:2:4: could not parse as YAML: did not find expected ',' or ']' [syntax-check]
@STDERR (empty)
[1]
```

## boundary-yaml-flow-mismatch

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 62 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:0:4: could not parse as YAML: did not find expected ',' or ']' [syntax-check]
@STDERR (empty)
[1]
```

## boundary-number-explicit-negative

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 63 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:22: value at "timeout-minutes" must be greater than zero: -1 [syntax-check]
@STDERR (empty)
[1]
```

## boundary-number-verbatim-tag

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 64 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-number-explicit-invalid

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 65 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:22: invalid float value: "garbage": strconv.ParseFloat: parsing "garbage": invalid syntax [syntax-check]
@STDERR (empty)
[1]
```

## boundary-number-octal

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 66 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:22: invalid float value: "0o10": strconv.ParseFloat: parsing "0o10": invalid syntax [syntax-check]
@STDERR (empty)
[1]
```

## boundary-number-underscores

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 67 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-number-overflow

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 68 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:22: expecting a single ${{...}} expression or float number literal, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## boundary-number-negative

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 69 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:22: value at "timeout-minutes" must be greater than zero: -1 [syntax-check]
@STDERR (empty)
[1]
```

## boundary-number-float-tag

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 70 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-integer-hex

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 71 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:21: invalid integer value: "0x10": strconv.Atoi: parsing "0x10": invalid syntax [syntax-check]
@STDERR (empty)
[1]
```

## boundary-integer-int64-max

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 72 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-integer-int64-overflow

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 73 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:21: invalid integer value: "9223372036854775808": strconv.Atoi: parsing "9223372036854775808": value out of range [syntax-check]
@STDERR (empty)
[1]
```

## boundary-integer-negative

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 74 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:21: value at "max-parallel" must be greater than zero: -1 [syntax-check]
@STDERR (empty)
[1]
```

## boundary-action-required-quoted-yes

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 75
@STDOUT
.github/workflows/main.yml:6:15: missing input "CamelCase" which is required by action "Test" defined at "./action". all required inputs are "CamelCase" [action]
@STDERR (empty)
[1]
```

## boundary-action-required-on

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 76
@STDOUT
.github/workflows/main.yml:6:15: missing input "CamelCase" which is required by action "Test" defined at "./action". all required inputs are "CamelCase" [action]
@STDERR (empty)
[1]
```

## boundary-action-required-no

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 77
@STDOUT (empty)
@STDERR (empty)
```

## boundary-action-required-quoted-false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 78
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/action": line 8: cannot unmarshal !!str `false` into bool [action]
@STDERR (empty)
[1]
```

## boundary-action-required-null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 79
@STDOUT (empty)
@STDERR (empty)
```

## boundary-action-required-numeric

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 80
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/action": line 8: cannot unmarshal !!int `1` into bool [action]
@STDERR (empty)
[1]
```

## boundary-action-required-sequence

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 81
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/action": line 8: cannot unmarshal !!seq into bool [action]
@STDERR (empty)
[1]
```

## boundary-action-required-empty-default

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 82
@STDOUT (empty)
@STDERR (empty)
```

## boundary-action-required-false-default

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 83
@STDOUT (empty)
@STDERR (empty)
```

## boundary-action-required-map-default

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 84
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/action": line 9: cannot unmarshal !!map into string [action]
@STDERR (empty)
[1]
```

## boundary-action-required-null-default

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 85
@STDOUT
.github/workflows/main.yml:6:15: missing input "CamelCase" which is required by action "Test" defined at "./action". all required inputs are "CamelCase" [action]
@STDERR (empty)
[1]
```

## boundary-action-missing-steps

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 86
@STDOUT
.github/workflows/main.yml:6:15: "steps" is required in "runs" section because "Test" is a Composite action. the action is defined at "$PROJECT/action" [action]
@STDERR (empty)
[1]
```

## boundary-action-null-steps

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 87
@STDOUT
.github/workflows/main.yml:6:15: "steps" is required in "runs" section because "Test" is a Composite action. the action is defined at "$PROJECT/action" [action]
@STDERR (empty)
[1]
```

## boundary-action-map-steps

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 88
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/action": line 5: cannot unmarshal !!map into []interface {} [action]
@STDERR (empty)
[1]
```

## boundary-action-empty-env

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 89
@STDOUT
.github/workflows/main.yml:6:15: "env" is not allowed in "runs" section because "Test" is a Composite action. the action is defined at "$PROJECT/action" [action]
@STDERR (empty)
[1]
```

## boundary-action-null-env

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 90
@STDOUT (empty)
@STDERR (empty)
```

## boundary-action-null-args

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 91
@STDOUT (empty)
@STDERR (empty)
```

## boundary-action-scalar-args

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 92
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/action": line 6: cannot unmarshal !!str `x` into []interface {} [action]
@STDERR (empty)
[1]
```

## boundary-action-empty-main

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 93
@STDOUT (empty)
@STDERR (empty)
```

## boundary-action-sequence-name

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 94
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/action": line 1: cannot unmarshal !!seq into string [action]
@STDERR (empty)
[1]
```

## boundary-action-scalar-runs

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 95
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/action": line 3: cannot unmarshal !!int `1` into actionlint.ActionMetadataRuns [action]
@STDERR (empty)
[1]
```

## boundary-action-scalar-input

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 96
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/action": line 7: cannot unmarshal !!int `1` into actionlint.actionInputMetadata [action]
@STDERR (empty)
[1]
```

## boundary-workflow-required-quoted-yes

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 97
@STDOUT
.github/workflows/main.yml:4:11: input "CamelCase" is required by "./.github/workflows/callee.yml" reusable workflow [workflow-call]
@STDERR (empty)
[1]
```

## boundary-workflow-required-false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 98
@STDOUT (empty)
@STDERR (empty)
```

## boundary-workflow-required-null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 99
@STDOUT (empty)
@STDERR (empty)
```

## boundary-workflow-required-numeric

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 100
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/callee.yml": yaml: unmarshal errors:   line 5: cannot unmarshal !!int `1` into bool [workflow-call]
@STDERR (empty)
[1]
```

## boundary-workflow-required-empty-default

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 101
@STDOUT (empty)
@STDERR (empty)
```

## boundary-workflow-required-map-default

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 102
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/callee.yml": yaml: unmarshal errors:   line 6: cannot unmarshal !!map into string [workflow-call]
@STDERR (empty)
[1]
```

## boundary-workflow-required-secret-default

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 103
@STDOUT
.github/workflows/main.yml:4:11: secret "CamelCase" is required by "./.github/workflows/callee.yml" reusable workflow [workflow-call]
@STDERR (empty)
[1]
```

## boundary-workflow-required-secret-yes

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 104
@STDOUT
.github/workflows/main.yml:4:11: secret "CamelCase" is required by "./.github/workflows/callee.yml" reusable workflow [workflow-call]
@STDERR (empty)
[1]
```

## boundary-docker-empty-tag

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 105 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:15: tag of Docker action should not be empty: "docker://a" [action]
@STDERR (empty)
[1]
```

## boundary-docker-host-space

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 106 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:15: URI for Docker container "docker://a b" is invalid: parse "docker://a b": invalid character " " in host name (tag=) [action]
@STDERR (empty)
[1]
```

## boundary-docker-host-ascii-escape

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 107 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:15: URI for Docker container "docker://a%41" is invalid: parse "docker://a%41": invalid URL escape "%41" (tag=) [action]
@STDERR (empty)
[1]
```

## boundary-docker-host-utf8-escape

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 108 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-docker-path-escape

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 109 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:15: URI for Docker container "docker://a/x%zz" is invalid: parse "docker://a/x%zz": invalid URL escape "%zz" (tag=) [action]
@STDERR (empty)
[1]
```

## boundary-docker-query-escape

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 110 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-docker-fragment-escape

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 111 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:15: URI for Docker container "docker://a#%zz" is invalid: parse "docker://a#%zz": invalid URL escape "%zz" (tag=) [action]
@STDERR (empty)
[1]
```

## boundary-docker-missing-bracket

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 112 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:15: URI for Docker container "docker://[abc" is invalid: parse "docker://[abc": missing ']' in host (tag=) [action]
@STDERR (empty)
[1]
```

## boundary-docker-tag-escape

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 113 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-docker-empty

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 114 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-command-empty-value

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 115 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:14: workflow command "set-output" was deprecated. use `echo "{name}={value}" >> $GITHUB_OUTPUT` instead: https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions [deprecated-commands]
@STDERR (empty)
[1]
```

## boundary-command-digit-name

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 116 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-command-bad-name

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 117 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-command-path

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 118 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:14: workflow command "add-path" was deprecated. use `echo "{path}" >> $GITHUB_PATH` instead: https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions [deprecated-commands]
@STDERR (empty)
[1]
```

## boundary-command-path-empty

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 119 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:14: workflow command "add-path" was deprecated. use `echo "{path}" >> $GITHUB_PATH` instead: https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions [deprecated-commands]
@STDERR (empty)
[1]
```

## boundary-command-spaces

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 120 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:14: workflow command "save-state" was deprecated. use `echo "{name}={value}" >> $GITHUB_STATE` instead: https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions [deprecated-commands]
@STDERR (empty)
[1]
```

## boundary-cron-bad-cron-tz

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 121 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: invalid CRON format "CRON_TZ=No/Such 0 0 * * *" in schedule event: provided bad location No/Such: unknown time zone No/Such [events]
@STDERR (empty)
[1]
```

## boundary-cron-valid-tz

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 122 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-cron-empty-tz

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 123 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-cron-invalid-location

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 124 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: invalid CRON format "TZ=../UTC 0 0 * * *" in schedule event: provided bad location ../UTC: time: invalid location name [events]
@STDERR (empty)
[1]
```

## boundary-cron-feb-leap

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 125 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-cron-feb-sunday

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 126 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-ignore-quoted-metachar

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 127 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '\Qunknown Webhook\E' -
@STDOUT
<stdin>:4:14: label "unknown-runner" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## boundary-ignore-unclosed-quote

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 128 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '\Qunknown' -
@STDOUT (empty)
@STDERR (empty)
```

## boundary-ignore-quoted-repeat

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 129 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '\Qunknown{1001}\E' -
@STDOUT
<stdin>:1:5: unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
<stdin>:4:14: label "unknown-runner" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## boundary-ignore-max-repeat

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 130 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore 'x{1000}' -
@STDOUT
<stdin>:1:5: unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
<stdin>:4:14: label "unknown-runner" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## boundary-ignore-open-repeat

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 131 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore 'x{1000,}' -
@STDOUT
<stdin>:1:5: unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
<stdin>:4:14: label "unknown-runner" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## boundary-ignore-range-max

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 132 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore 'x{1,1000}' -
@STDOUT
<stdin>:1:5: unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
@STDERR (empty)
[1]
```

## boundary-ignore-range-overflow

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore 'x{1,1001}' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "x{1,1001}": error parsing regexp: invalid repeat count: `{1,1001}`
[3]
```

## boundary-ignore-nested-max

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 134 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '(x{100}){10}' -
@STDOUT
<stdin>:1:5: unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
<stdin>:4:14: label "unknown-runner" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## boundary-ignore-nested-overflow

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '(x{100}){11}' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "(x{100}){11}": error parsing regexp: invalid repeat count: `{11}`
[3]
```

## boundary-ignore-reversed

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore 'x{2,1}' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "x{2,1}": error parsing regexp: invalid repeat count: `{2,1}`
[3]
```

## boundary-config-ignore-quoted

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 137
@STDOUT (empty)
@STDERR (empty)
```

## boundary-config-ignore-overflow

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 138
@STDOUT (empty)
@STDERR
could not parse config file "$PROJECT/.github/actionlint.yaml": could not parse config file "$PROJECT/.github/actionlint.yaml": yaml: unmarshal errors:   line 3: invalid regular expression "unknown{1001}" in "ignore" at line3,col:13: error parsing regexp: invalid repeat count: `{1001}`
[3]
```

## boundary-template-printf-width

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 139 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%04d|%6.2f|%-5s|%.2s" 3 1.234 "x" "hello"}}' -
@STDOUT
0003|  1.23|x    |he (no-eol)
@STDERR (empty)
[1]
```

## boundary-template-printf-sign

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 140 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%05d|%+05d|%5.3d" -3 3 3}}' -
@STDOUT
-0003|+0003|  003 (no-eol)
@STDERR (empty)
[1]
```

## boundary-template-printf-hex

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 141 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%04x|%.3d|%8q" 15 3 "x"}}' -
@STDOUT
000f|003|     "x" (no-eol)
@STDERR (empty)
[1]
```

## boundary-template-parenthesis-pipeline

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 142 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%s" ((index . 0).Kind)}}' -
@STDOUT
events (no-eol)
@STDERR (empty)
[1]
```

## boundary-template-continue

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 143 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{range .}}A{{continue}}B{{end}}' -
@STDOUT
AA (no-eol)
@STDERR (empty)
[1]
```

## boundary-template-nested-break

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 144 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{range .}}A{{range $x := $}}{{break}}B{{end}}C{{end}}' -
@STDOUT
ACAC (no-eol)
@STDERR (empty)
[1]
```

## boundary-template-conditional-break

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 145 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{range .}}{{if .Kind}}X{{break}}{{end}}Y{{end}}' -
@STDOUT
X (no-eol)
@STDERR (empty)
[1]
```

## boundary-template-partial-field

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 146 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{range .}}X{{.Unknown}}Y{{end}}after' -
@STDOUT
beforeX (no-eol)
@STDERR (empty)
[1]
```

## boundary-template-multi-partial-field

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 147
@STDOUT
beforeX (no-eol)
@STDERR
could not format error messages: template: error formatter:1:20: executing "error formatter" at <.Unknown>: can't evaluate field Unknown in type *actionlint.ErrorTemplateFields
[3]
```

## boundary-template-index-error

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 148 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{index . 99}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## boundary-template-multi-index-error

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 149
@STDOUT
before (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <index . 99>: error calling index: index out of range: 99
[3]
```

## boundary-template-nil

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 150 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{nil}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## boundary-template-multi-nil

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 151
@STDOUT
before (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <nil>: nil is not a command
[3]
```

## boundary-template-field-case

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 152 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{range .}}{{.kind}}{{end}}' -
@STDOUT (empty)
@STDERR (empty)
[1]
```

## boundary-template-multi-field-case

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 153
@STDOUT (empty)
@STDERR
could not format error messages: template: error formatter:1:13: executing "error formatter" at <.kind>: can't evaluate field kind in type *actionlint.ErrorTemplateFields
[3]
```

## boundary-template-break-outside

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{break}}' -
@STDOUT (empty)
@STDERR
template "{{break}}" to format error messages could not be parsed: template: error formatter:1: {{break}} outside {{range}}
[3]
```

## boundary-empty-snippet

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/behavior.json 155 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{range .}}[{{.Snippet}}]{{end}}' -
@STDOUT
[] (no-eol)
@STDERR (empty)
[1]
```

## boundary-pyflakes-lf

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 156
@STDOUT (empty)
@STDERR
flag provided but not defined: -pyflakes
Usage: actionlint [FLAGS] [FILES...] [-]
"" (escaped)
"  actionlint is a linter for GitHub Actions workflow files." (escaped)
"" (escaped)
"  To check all YAML files in current repository, just run actionlint without" (escaped)
"  arguments. It automatically finds the nearest '.github/workflows' directory:" (escaped)
"" (escaped)
"    $ actionlint" (escaped)
"" (escaped)
"  To check specific files, pass the file paths as arguments:" (escaped)
"" (escaped)
"    $ actionlint file1.yaml file2.yaml" (escaped)
"" (escaped)
"  To check content which is not saved in file yet (e.g. output from some" (escaped)
"  command), pass - argument. It reads stdin and checks it as workflow file:" (escaped)
"" (escaped)
"    $ actionlint -" (escaped)
"" (escaped)
"  To serialize errors into JSON, use -format option. It allows to format error" (escaped)
"  messages flexibly with Go template syntax." (escaped)
"" (escaped)
"    $ actionlint -format '{{json .}}'" (escaped)
"" (escaped)
Documents:
"" (escaped)
"  - List of checks: https://github.com/rhysd/actionlint/tree/main/docs/checks.md" (escaped)
"  - Usage:          https://github.com/rhysd/actionlint/tree/main/docs/usage.md" (escaped)
"  - Configuration:  https://github.com/rhysd/actionlint/tree/main/docs/config.md" (escaped)
"" (escaped)
Flags:
"  -color" (escaped)
"    \tAlways enable colorful output. This is useful to force colorful outputs" (escaped)
"  -config-file string" (escaped)
"    \tFile path to config file" (escaped)
"  -debug" (escaped)
"    \tEnable debug output (for development)" (escaped)
"  -format string" (escaped)
"    \tCustom template to format error messages in Go template syntax. See the usage documentation for more details" (escaped)
"  -ignore value" (escaped)
"    \tRegular expression matching to error messages you want to ignore. This flag is repeatable" (escaped)
"  -init-config" (escaped)
"    \tGenerate default config file at .github/actionlint.yaml in current project" (escaped)
"  -no-color" (escaped)
"    \tDisable colorful output" (escaped)
"  -oneline" (escaped)
"    \tUse one line per one error. Useful for reading error messages from programs" (escaped)
"  -shellcheck string" (escaped)
"    \tCommand name or file path of \"shellcheck\" external command. If empty, shellcheck integration will be disabled (default \"shellcheck\")" (escaped)
"  -stdin-filename string" (escaped)
"    \tFile name when reading input from stdin (default \"<stdin>\")" (escaped)
"  -verbose" (escaped)
"    \tEnable verbose output" (escaped)
"  -version" (escaped)
"    \tShow version and how this binary was installed" (escaped)
[2]
```

## boundary-pyflakes-crlf

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 157
@STDOUT (empty)
@STDERR
flag provided but not defined: -pyflakes
Usage: actionlint [FLAGS] [FILES...] [-]
"" (escaped)
"  actionlint is a linter for GitHub Actions workflow files." (escaped)
"" (escaped)
"  To check all YAML files in current repository, just run actionlint without" (escaped)
"  arguments. It automatically finds the nearest '.github/workflows' directory:" (escaped)
"" (escaped)
"    $ actionlint" (escaped)
"" (escaped)
"  To check specific files, pass the file paths as arguments:" (escaped)
"" (escaped)
"    $ actionlint file1.yaml file2.yaml" (escaped)
"" (escaped)
"  To check content which is not saved in file yet (e.g. output from some" (escaped)
"  command), pass - argument. It reads stdin and checks it as workflow file:" (escaped)
"" (escaped)
"    $ actionlint -" (escaped)
"" (escaped)
"  To serialize errors into JSON, use -format option. It allows to format error" (escaped)
"  messages flexibly with Go template syntax." (escaped)
"" (escaped)
"    $ actionlint -format '{{json .}}'" (escaped)
"" (escaped)
Documents:
"" (escaped)
"  - List of checks: https://github.com/rhysd/actionlint/tree/main/docs/checks.md" (escaped)
"  - Usage:          https://github.com/rhysd/actionlint/tree/main/docs/usage.md" (escaped)
"  - Configuration:  https://github.com/rhysd/actionlint/tree/main/docs/config.md" (escaped)
"" (escaped)
Flags:
"  -color" (escaped)
"    \tAlways enable colorful output. This is useful to force colorful outputs" (escaped)
"  -config-file string" (escaped)
"    \tFile path to config file" (escaped)
"  -debug" (escaped)
"    \tEnable debug output (for development)" (escaped)
"  -format string" (escaped)
"    \tCustom template to format error messages in Go template syntax. See the usage documentation for more details" (escaped)
"  -ignore value" (escaped)
"    \tRegular expression matching to error messages you want to ignore. This flag is repeatable" (escaped)
"  -init-config" (escaped)
"    \tGenerate default config file at .github/actionlint.yaml in current project" (escaped)
"  -no-color" (escaped)
"    \tDisable colorful output" (escaped)
"  -oneline" (escaped)
"    \tUse one line per one error. Useful for reading error messages from programs" (escaped)
"  -shellcheck string" (escaped)
"    \tCommand name or file path of \"shellcheck\" external command. If empty, shellcheck integration will be disabled (default \"shellcheck\")" (escaped)
"  -stdin-filename string" (escaped)
"    \tFile name when reading input from stdin (default \"<stdin>\")" (escaped)
"  -verbose" (escaped)
"    \tEnable verbose output" (escaped)
"  -version" (escaped)
"    \tShow version and how this binary was installed" (escaped)
[2]
```

## boundary-pyflakes-irrelevant

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 158
@STDOUT (empty)
@STDERR
flag provided but not defined: -pyflakes
Usage: actionlint [FLAGS] [FILES...] [-]
"" (escaped)
"  actionlint is a linter for GitHub Actions workflow files." (escaped)
"" (escaped)
"  To check all YAML files in current repository, just run actionlint without" (escaped)
"  arguments. It automatically finds the nearest '.github/workflows' directory:" (escaped)
"" (escaped)
"    $ actionlint" (escaped)
"" (escaped)
"  To check specific files, pass the file paths as arguments:" (escaped)
"" (escaped)
"    $ actionlint file1.yaml file2.yaml" (escaped)
"" (escaped)
"  To check content which is not saved in file yet (e.g. output from some" (escaped)
"  command), pass - argument. It reads stdin and checks it as workflow file:" (escaped)
"" (escaped)
"    $ actionlint -" (escaped)
"" (escaped)
"  To serialize errors into JSON, use -format option. It allows to format error" (escaped)
"  messages flexibly with Go template syntax." (escaped)
"" (escaped)
"    $ actionlint -format '{{json .}}'" (escaped)
"" (escaped)
Documents:
"" (escaped)
"  - List of checks: https://github.com/rhysd/actionlint/tree/main/docs/checks.md" (escaped)
"  - Usage:          https://github.com/rhysd/actionlint/tree/main/docs/usage.md" (escaped)
"  - Configuration:  https://github.com/rhysd/actionlint/tree/main/docs/config.md" (escaped)
"" (escaped)
Flags:
"  -color" (escaped)
"    \tAlways enable colorful output. This is useful to force colorful outputs" (escaped)
"  -config-file string" (escaped)
"    \tFile path to config file" (escaped)
"  -debug" (escaped)
"    \tEnable debug output (for development)" (escaped)
"  -format string" (escaped)
"    \tCustom template to format error messages in Go template syntax. See the usage documentation for more details" (escaped)
"  -ignore value" (escaped)
"    \tRegular expression matching to error messages you want to ignore. This flag is repeatable" (escaped)
"  -init-config" (escaped)
"    \tGenerate default config file at .github/actionlint.yaml in current project" (escaped)
"  -no-color" (escaped)
"    \tDisable colorful output" (escaped)
"  -oneline" (escaped)
"    \tUse one line per one error. Useful for reading error messages from programs" (escaped)
"  -shellcheck string" (escaped)
"    \tCommand name or file path of \"shellcheck\" external command. If empty, shellcheck integration will be disabled (default \"shellcheck\")" (escaped)
"  -stdin-filename string" (escaped)
"    \tFile name when reading input from stdin (default \"<stdin>\")" (escaped)
"  -verbose" (escaped)
"    \tEnable verbose output" (escaped)
"  -version" (escaped)
"    \tShow version and how this binary was installed" (escaped)
[2]
```

## boundary-pyflakes-syntax-tail

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run behavior 159
@STDOUT (empty)
@STDERR
flag provided but not defined: -pyflakes
Usage: actionlint [FLAGS] [FILES...] [-]
"" (escaped)
"  actionlint is a linter for GitHub Actions workflow files." (escaped)
"" (escaped)
"  To check all YAML files in current repository, just run actionlint without" (escaped)
"  arguments. It automatically finds the nearest '.github/workflows' directory:" (escaped)
"" (escaped)
"    $ actionlint" (escaped)
"" (escaped)
"  To check specific files, pass the file paths as arguments:" (escaped)
"" (escaped)
"    $ actionlint file1.yaml file2.yaml" (escaped)
"" (escaped)
"  To check content which is not saved in file yet (e.g. output from some" (escaped)
"  command), pass - argument. It reads stdin and checks it as workflow file:" (escaped)
"" (escaped)
"    $ actionlint -" (escaped)
"" (escaped)
"  To serialize errors into JSON, use -format option. It allows to format error" (escaped)
"  messages flexibly with Go template syntax." (escaped)
"" (escaped)
"    $ actionlint -format '{{json .}}'" (escaped)
"" (escaped)
Documents:
"" (escaped)
"  - List of checks: https://github.com/rhysd/actionlint/tree/main/docs/checks.md" (escaped)
"  - Usage:          https://github.com/rhysd/actionlint/tree/main/docs/usage.md" (escaped)
"  - Configuration:  https://github.com/rhysd/actionlint/tree/main/docs/config.md" (escaped)
"" (escaped)
Flags:
"  -color" (escaped)
"    \tAlways enable colorful output. This is useful to force colorful outputs" (escaped)
"  -config-file string" (escaped)
"    \tFile path to config file" (escaped)
"  -debug" (escaped)
"    \tEnable debug output (for development)" (escaped)
"  -format string" (escaped)
"    \tCustom template to format error messages in Go template syntax. See the usage documentation for more details" (escaped)
"  -ignore value" (escaped)
"    \tRegular expression matching to error messages you want to ignore. This flag is repeatable" (escaped)
"  -init-config" (escaped)
"    \tGenerate default config file at .github/actionlint.yaml in current project" (escaped)
"  -no-color" (escaped)
"    \tDisable colorful output" (escaped)
"  -oneline" (escaped)
"    \tUse one line per one error. Useful for reading error messages from programs" (escaped)
"  -shellcheck string" (escaped)
"    \tCommand name or file path of \"shellcheck\" external command. If empty, shellcheck integration will be disabled (default \"shellcheck\")" (escaped)
"  -stdin-filename string" (escaped)
"    \tFile name when reading input from stdin (default \"<stdin>\")" (escaped)
"  -verbose" (escaped)
"    \tEnable verbose output" (escaped)
"  -version" (escaped)
"    \tShow version and how this binary was installed" (escaped)
[2]
```

