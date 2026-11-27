# CLI regressions

120 migrated cases. Inputs are in [fixtures/cli.json](fixtures/cli.json).
Each case asserts stdout, stderr, and exit status; only elapsed milliseconds vary.

## help

This port intentionally removes Pyflakes integration; the help text no longer lists the -pyflakes argument.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -h
@STDOUT (empty)
@STDERR
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
```

## long-help

This port intentionally removes Pyflakes integration; the help text no longer lists the -pyflakes argument.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= --help
@STDOUT (empty)
@STDERR
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
```

## unknown-flag

This port intentionally removes Pyflakes integration; the help text no longer lists the -pyflakes argument.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -not-a-flag
@STDOUT (empty)
@STDERR
flag provided but not defined: -not-a-flag
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

## unknown-valued-flag

This port intentionally removes Pyflakes integration; the help text no longer lists the -pyflakes argument.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -not-a-flag=x
@STDOUT (empty)
@STDERR
flag provided but not defined: -not-a-flag
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

## missing-flag-value

This port intentionally removes Pyflakes integration; the help text no longer lists the -pyflakes argument.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format
@STDOUT (empty)
@STDERR
flag needs an argument: -format
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

## invalid-bool

This port intentionally removes Pyflakes integration; the help text no longer lists the -pyflakes argument.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline=maybe
@STDOUT (empty)
@STDERR
invalid boolean value "maybe" for -oneline: parse error
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

## forced-color

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 6 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -color -
@STDOUT
<stdin>:1:6: unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
"  |" (escaped)
1 | on: [typo]
"  |      ^~~~~" (escaped)
<stdin>:4:14: label "no-such-runner" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
"  |" (escaped)
4 |     runs-on: no-such-runner
"  |              ^~~~~~~~~~~~~~" (escaped)
<stdin>:7:13: constant expression "true" in condition. remove the if: section [if-cond]
"  |" (escaped)
7 |         if: true
"  |             ^~~~" (escaped)
@STDERR (empty)
[1]
```

## ansi-color

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 7 | NO_COLOR='' moonx moonbit-community/actionlint -shellcheck= -color -
@STDOUT
"\u001b[33m<stdin>\u001b[0m\u001b[90m:\u001b[0m1\u001b[90m:\u001b[0m6\u001b[90m: \u001b[0m\u001b[1munknown Webhook event \"typo\". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names\u001b[0m\u001b[90m [events]" (escaped)
"\u001b[0m\u001b[90m  |" (escaped)
"\u001b[0m\u001b[90m1 | \u001b[0mon: [typo]" (escaped)
"\u001b[90m  | \u001b[0m\u001b[32m     ^~~~~\u001b[0m" (escaped)
"\u001b[33m<stdin>\u001b[0m\u001b[90m:\u001b[0m4\u001b[90m:\u001b[0m14\u001b[90m: \u001b[0m\u001b[1mlabel \"no-such-runner\" is unknown. available labels are \"windows-latest\", \"windows-latest-8-cores\", \"windows-2025\", \"windows-2025-vs2026\", \"windows-2022\", \"windows-11-arm\", \"ubuntu-slim\", \"ubuntu-latest\", \"ubuntu-latest-4-cores\", \"ubuntu-latest-8-cores\", \"ubuntu-latest-16-cores\", \"ubuntu-24.04\", \"ubuntu-24.04-arm\", \"ubuntu-22.04\", \"ubuntu-22.04-arm\", \"macos-latest\", \"macos-latest-xlarge\", \"macos-latest-large\", \"macos-26-intel\", \"macos-26-xlarge\", \"macos-26-large\", \"macos-26\", \"macos-15-intel\", \"macos-15-xlarge\", \"macos-15-large\", \"macos-15\", \"macos-14-xlarge\", \"macos-14-large\", \"macos-14\", \"self-hosted\", \"x64\", \"arm\", \"arm64\", \"linux\", \"macos\", \"windows\". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file\u001b[0m\u001b[90m [runner-label]" (escaped)
"\u001b[0m\u001b[90m  |" (escaped)
"\u001b[0m\u001b[90m4 | \u001b[0m    runs-on: no-such-runner" (escaped)
"\u001b[90m  | \u001b[0m\u001b[32m             ^~~~~~~~~~~~~~\u001b[0m" (escaped)
"\u001b[33m<stdin>\u001b[0m\u001b[90m:\u001b[0m7\u001b[90m:\u001b[0m13\u001b[90m: \u001b[0m\u001b[1mconstant expression \"true\" in condition. remove the if: section\u001b[0m\u001b[90m [if-cond]" (escaped)
"\u001b[0m\u001b[90m  |" (escaped)
"\u001b[0m\u001b[90m7 | \u001b[0m        if: true" (escaped)
"\u001b[90m  | \u001b[0m\u001b[32m            ^~~~\u001b[0m" (escaped)
@STDERR (empty)
[1]
```

## color-precedence

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 8 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -color -no-color -
@STDOUT
<stdin>:1:6: unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
"  |" (escaped)
1 | on: [typo]
"  |      ^~~~~" (escaped)
<stdin>:4:14: label "no-such-runner" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
"  |" (escaped)
4 |     runs-on: no-such-runner
"  |              ^~~~~~~~~~~~~~" (escaped)
<stdin>:7:13: constant expression "true" in condition. remove the if: section [if-cond]
"  |" (escaped)
7 |         if: true
"  |             ^~~~" (escaped)
@STDERR (empty)
[1]
```

## template-fields

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 9 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{range .}}{{.Filepath}}:{{.Line}}:{{.Column}}: {{.Message}} [{{.Kind}}]\n{{end}}' -
@STDOUT
<stdin>:1:6: unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
<stdin>:4:14: label "no-such-runner" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
<stdin>:7:13: constant expression "true" in condition. remove the if: section [if-cond]
@STDERR (empty)
[1]
```

## template-printf

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 10 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{range $e := .}}{{printf "%s:%d:%s" $e.Filepath $e.Line $e.Message}}\n{{end}}' -
@STDOUT
<stdin>:1:unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names
<stdin>:4:label "no-such-runner" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file
<stdin>:7:constant expression "true" in condition. remove the if: section
@STDERR (empty)
[1]
```

## file

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 11
@STDOUT
.github/workflows/bad.yml:1:6: unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
"  |" (escaped)
1 | on: [typo]
"  |      ^~~~~" (escaped)
.github/workflows/bad.yml:4:14: label "no-such-runner" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
"  |" (escaped)
4 |     runs-on: no-such-runner
"  |              ^~~~~~~~~~~~~~" (escaped)
.github/workflows/bad.yml:7:13: constant expression "true" in condition. remove the if: section [if-cond]
"  |" (escaped)
7 |         if: true
"  |             ^~~~" (escaped)
@STDERR (empty)
[1]
```

## multiple-files

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 12
@STDOUT
.github/workflows/bad.yml:1:6: unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
"  |" (escaped)
1 | on: [typo]
"  |      ^~~~~" (escaped)
.github/workflows/bad.yml:4:14: label "no-such-runner" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
"  |" (escaped)
4 |     runs-on: no-such-runner
"  |              ^~~~~~~~~~~~~~" (escaped)
.github/workflows/bad.yml:7:13: constant expression "true" in condition. remove the if: section [if-cond]
"  |" (escaped)
7 |         if: true
"  |             ^~~~" (escaped)
@STDERR (empty)
[1]
```

## multiple-json

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 13
@STDOUT
[{"message":"unknown Webhook event \"typo\". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names","filepath":".github/workflows/bad.yml","line":1,"column":6,"kind":"events","snippet":"on: [typo]\n     ^~~~~","end_column":10},{"message":"label \"no-such-runner\" is unknown. available labels are \"windows-latest\", \"windows-latest-8-cores\", \"windows-2025\", \"windows-2025-vs2026\", \"windows-2022\", \"windows-11-arm\", \"ubuntu-slim\", \"ubuntu-latest\", \"ubuntu-latest-4-cores\", \"ubuntu-latest-8-cores\", \"ubuntu-latest-16-cores\", \"ubuntu-24.04\", \"ubuntu-24.04-arm\", \"ubuntu-22.04\", \"ubuntu-22.04-arm\", \"macos-latest\", \"macos-latest-xlarge\", \"macos-latest-large\", \"macos-26-intel\", \"macos-26-xlarge\", \"macos-26-large\", \"macos-26\", \"macos-15-intel\", \"macos-15-xlarge\", \"macos-15-large\", \"macos-15\", \"macos-14-xlarge\", \"macos-14-large\", \"macos-14\", \"self-hosted\", \"x64\", \"arm\", \"arm64\", \"linux\", \"macos\", \"windows\". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file","filepath":".github/workflows/bad.yml","line":4,"column":14,"kind":"runner-label","snippet":"    runs-on: no-such-runner\n             ^~~~~~~~~~~~~~","end_column":27},{"message":"constant expression \"true\" in condition. remove the if: section","filepath":".github/workflows/bad.yml","line":7,"column":13,"kind":"if-cond","snippet":"        if: true\n            ^~~~","end_column":16}]
@STDERR (empty)
[1]
```

## repository-discovery

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 14
@STDOUT
.github/workflows/bad.yml:1:6: unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
"  |" (escaped)
1 | on: [typo]
"  |      ^~~~~" (escaped)
.github/workflows/bad.yml:4:14: label "no-such-runner" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
"  |" (escaped)
4 |     runs-on: no-such-runner
"  |              ^~~~~~~~~~~~~~" (escaped)
.github/workflows/bad.yml:7:13: constant expression "true" in condition. remove the if: section [if-cond]
"  |" (escaped)
7 |         if: true
"  |             ^~~~" (escaped)
@STDERR (empty)
[1]
```

## end-flags

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 15
@STDOUT (empty)
@STDERR (empty)
```

## flags-after-file

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 16
@STDOUT (empty)
@STDERR
could not read "-oneline": open -oneline: no such file or directory
[3]
```

## missing-file

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 17
@STDOUT (empty)
@STDERR
could not read "missing.yaml": open missing.yaml: no such file or directory
[3]
```

## directory-as-file

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 18
@STDOUT (empty)
@STDERR
could not read "empty": read empty: is a directory
[3]
```

## unicode-chinese

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 19 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"undefined variable \"no_such\". available variables are \"env\", \"github\", \"inputs\", \"job\", \"matrix\", \"needs\", \"runner\", \"secrets\", \"steps\", \"strategy\", \"vars\"","filepath":"\u003cstdin\u003e","line":7,"column":26,"kind":"expression","snippet":"        name: 中文 ${{ no_such.name }}\n                       ^~~~~~~~~~~~","end_column":35}]
@STDERR (empty)
[1]
```

## unicode-emoji

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 20 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"undefined variable \"no_such\". available variables are \"env\", \"github\", \"inputs\", \"job\", \"matrix\", \"needs\", \"runner\", \"secrets\", \"steps\", \"strategy\", \"vars\"","filepath":"\u003cstdin\u003e","line":7,"column":24,"kind":"expression","snippet":"        name: 😀 ${{ no_such.name }}\n                     ^~~~~~~~~~~~","end_column":33}]
@STDERR (empty)
[1]
```

## unicode-combining

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 21 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"undefined variable \"no_such\". available variables are \"env\", \"github\", \"inputs\", \"job\", \"matrix\", \"needs\", \"runner\", \"secrets\", \"steps\", \"strategy\", \"vars\"","filepath":"\u003cstdin\u003e","line":7,"column":23,"kind":"expression","snippet":"        name: é ${{ no_such.name }}\n                    ^~~~~~~~~~~~","end_column":32}]
@STDERR (empty)
[1]
```

## unicode-mixed

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 22 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"undefined variable \"no_such\". available variables are \"env\", \"github\", \"inputs\", \"job\", \"matrix\", \"needs\", \"runner\", \"secrets\", \"steps\", \"strategy\", \"vars\"","filepath":"\u003cstdin\u003e","line":7,"column":26,"kind":"expression","snippet":"        name: a😀b ${{ no_such.name }}\n                       ^~~~~~~~~~~~","end_column":35}]
@STDERR (empty)
[1]
```

## crlf

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 23 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"unknown Webhook event \"typo\". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names","filepath":"\u003cstdin\u003e","line":1,"column":6,"kind":"events","snippet":"on: [typo]\n     ^~~~~","end_column":10},{"message":"label \"no-such-runner\" is unknown. available labels are \"windows-latest\", \"windows-latest-8-cores\", \"windows-2025\", \"windows-2025-vs2026\", \"windows-2022\", \"windows-11-arm\", \"ubuntu-slim\", \"ubuntu-latest\", \"ubuntu-latest-4-cores\", \"ubuntu-latest-8-cores\", \"ubuntu-latest-16-cores\", \"ubuntu-24.04\", \"ubuntu-24.04-arm\", \"ubuntu-22.04\", \"ubuntu-22.04-arm\", \"macos-latest\", \"macos-latest-xlarge\", \"macos-latest-large\", \"macos-26-intel\", \"macos-26-xlarge\", \"macos-26-large\", \"macos-26\", \"macos-15-intel\", \"macos-15-xlarge\", \"macos-15-large\", \"macos-15\", \"macos-14-xlarge\", \"macos-14-large\", \"macos-14\", \"self-hosted\", \"x64\", \"arm\", \"arm64\", \"linux\", \"macos\", \"windows\". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file","filepath":"\u003cstdin\u003e","line":4,"column":14,"kind":"runner-label","snippet":"    runs-on: no-such-runner\n             ^~~~~~~~~~~~~~","end_column":27},{"message":"constant expression \"true\" in condition. remove the if: section","filepath":"\u003cstdin\u003e","line":7,"column":13,"kind":"if-cond","snippet":"        if: true\n            ^~~~","end_column":16}]
@STDERR (empty)
[1]
```

## expression-2147483648

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 24 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"parsing invalid integer literal \"2147483648\": strconv.ParseInt: parsing \"2147483648\": value out of range","filepath":"\u003cstdin\u003e","line":7,"column":19,"kind":"expression","snippet":"        name: ${{ 2147483648 }}\n                  ^~~~~~~~~~","end_column":28}]
@STDERR (empty)
[1]
```

## expression--2147483649

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 25 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"parsing invalid integer literal \"-2147483649\": strconv.ParseInt: parsing \"-2147483649\": value out of range","filepath":"\u003cstdin\u003e","line":7,"column":19,"kind":"expression","snippet":"        name: ${{ -2147483649 }}\n                  ^~~~~~~~~~~","end_column":29}]
@STDERR (empty)
[1]
```

## expression-0x80000000

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 26 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"parsing invalid integer literal \"0x80000000\": strconv.ParseInt: parsing \"0x80000000\": value out of range","filepath":"\u003cstdin\u003e","line":7,"column":19,"kind":"expression","snippet":"        name: ${{ 0x80000000 }}\n                  ^~~~~~~~~~","end_column":28}]
@STDERR (empty)
[1]
```

## expression-1e999

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 27 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"parsing invalid float literal \"1e999\": strconv.ParseFloat: parsing \"1e999\": value out of range","filepath":"\u003cstdin\u003e","line":7,"column":19,"kind":"expression","snippet":"        name: ${{ 1e999 }}\n                  ^~~~~","end_column":23}]
@STDERR (empty)
[1]
```

## expression-01

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 28 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"got unexpected character '1' while lexing character following number 0, expecting ''', '}', '(', ')', '[', ']', '.', '!', '\u003c', '\u003e', '=', '\u0026', '|', '*', ',', ' '","filepath":"\u003cstdin\u003e","line":7,"column":20,"kind":"expression","snippet":"        name: ${{ 01 }}\n                   ^","end_column":20}]
@STDERR (empty)
[1]
```

## expression-0x

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 29 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"got unexpected character ' ' while lexing hex integer, expecting '0'..'9', 'a'..'f', 'A'..'F'","filepath":"\u003cstdin\u003e","line":7,"column":21,"kind":"expression","snippet":"        name: ${{ 0x }}\n                    ^","end_column":21}]
@STDERR (empty)
[1]
```

## expression-0x00

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 30 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"got unexpected character '0' while lexing character following hex integer 0x0, expecting ''', '}', '(', ')', '[', ']', '.', '!', '\u003c', '\u003e', '=', '\u0026', '|', '*', ',', ' '","filepath":"\u003cstdin\u003e","line":7,"column":22,"kind":"expression","snippet":"        name: ${{ 0x00 }}\n                     ^","end_column":22}]
@STDERR (empty)
[1]
```

## expression-1.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 31 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"got unexpected character ' ' while lexing fraction part of float number, expecting '0'..'9'","filepath":"\u003cstdin\u003e","line":7,"column":21,"kind":"expression","snippet":"        name: ${{ 1. }}\n                    ^","end_column":21}]
@STDERR (empty)
[1]
```

## expression-1e+2

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 32 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"got unexpected character '+' while lexing exponent part of float number, expecting '0'..'9'","filepath":"\u003cstdin\u003e","line":7,"column":21,"kind":"expression","snippet":"        name: ${{ 1e+2 }}\n                    ^~","end_column":22}]
@STDERR (empty)
[1]
```

## expression-1e

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 33 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"got unexpected character ' ' while lexing exponent part of float number, expecting '0'..'9'","filepath":"\u003cstdin\u003e","line":7,"column":21,"kind":"expression","snippet":"        name: ${{ 1e }}\n                    ^","end_column":21}]
@STDERR (empty)
[1]
```

## expression--x

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 34 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"got unexpected character 'x' while lexing integer part of number, expecting '0'..'9'","filepath":"\u003cstdin\u003e","line":7,"column":20,"kind":"expression","snippet":"        name: ${{ -x }}\n                   ^","end_column":20}]
@STDERR (empty)
[1]
```

## expression-12a

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 35 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"got unexpected character 'a' while lexing character following number 12, expecting ''', '}', '(', ')', '[', ']', '.', '!', '\u003c', '\u003e', '=', '\u0026', '|', '*', ',', ' '","filepath":"\u003cstdin\u003e","line":7,"column":21,"kind":"expression","snippet":"        name: ${{ 12a }}\n                    ^","end_column":21}]
@STDERR (empty)
[1]
```

## expression-42 foo bar

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 36 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"parser did not reach end of input after parsing the expression. 2 remaining token(s) in the input: \"IDENT\", \"IDENT\"","filepath":"\u003cstdin\u003e","line":7,"column":22,"kind":"expression","snippet":"        name: ${{ 42 foo bar }}\n                     ^~~","end_column":24}]
@STDERR (empty)
[1]
```

## expression-'unclosed

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 37 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"got unexpected EOF while lexing end of string literal, expecting '''","filepath":"\u003cstdin\u003e","line":7,"column":31,"kind":"expression","snippet":"        name: ${{ 'unclosed }}\n                              ^","end_column":31}]
@STDERR (empty)
[1]
```

## expression-1 = 2

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 38 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"got unexpected character ' ' while lexing == operator, expecting '='","filepath":"\u003cstdin\u003e","line":7,"column":22,"kind":"expression","snippet":"        name: ${{ 1 = 2 }}\n                     ^","end_column":22}]
@STDERR (empty)
[1]
```

## expression-true & false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 39 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"got unexpected character ' ' while lexing \u0026\u0026 operator, expecting '\u0026'","filepath":"\u003cstdin\u003e","line":7,"column":25,"kind":"expression","snippet":"        name: ${{ true \u0026 false }}\n                        ^","end_column":25}]
@STDERR (empty)
[1]
```

## expression-true | false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 40 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"got unexpected character ' ' while lexing || operator, expecting '|'","filepath":"\u003cstdin\u003e","line":7,"column":25,"kind":"expression","snippet":"        name: ${{ true | false }}\n                        ^","end_column":25}]
@STDERR (empty)
[1]
```

## expression-1 }

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 41 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"got unexpected character ' ' while lexing end marker }}, expecting '}'","filepath":"\u003cstdin\u003e","line":7,"column":22,"kind":"expression","snippet":"        name: ${{ 1 } }}\n                     ^","end_column":22}]
@STDERR (empty)
[1]
```

## template-builtins-0

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 42 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{html "<a & \"b\" >"}}' -
@STDOUT
&lt;a &amp; &#34;b&#34; &gt; (no-eol)
@STDERR (empty)
[1]
```

## template-builtins-1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 43 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{urlquery "a b/中文"}}' -
@STDOUT
a+b%2F%E4%B8%AD%E6%96%87 (no-eol)
@STDERR (empty)
[1]
```

## template-builtins-2

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 44 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{js "<script>\"x\"</script>"}}' -
@STDOUT
\u003Cscript\u003E\"x\"\u003C/script\u003E (no-eol)
@STDERR (empty)
[1]
```

## template-builtins-3

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 45 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{len "中文😀"}}' -
@STDOUT
10 (no-eol)
@STDERR (empty)
[1]
```

## template-builtins-4

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 46 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json (slice . 0 1)}}' -
@STDOUT
[{"message":"unknown Webhook event \"typo\". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names","filepath":"\u003cstdin\u003e","line":1,"column":6,"kind":"events","snippet":"on: [typo]\n     ^~~~~","end_column":10}]
@STDERR (empty)
[1]
```

## template-builtins-5

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 47 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{toPascalCase "foo_bar-baz /QUX42"}}' -
@STDOUT
FooBarBazQUX42 (no-eol)
@STDERR (empty)
[1]
```

## template-builtins-6

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 48 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{replace "ab" "a" "b" "b" "c"}}' -
@STDOUT
bc (no-eol)
@STDERR (empty)
[1]
```

## template-builtins-7

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 49 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{template "footer" .}}{{define "footer"}}count={{len .}}{{end}}' -
@STDOUT
count=3 (no-eol)
@STDERR (empty)
[1]
```

## template-builtins-8

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 50 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{block "main" .}}{{len .}}{{end}}' -
@STDOUT
3 (no-eol)
@STDERR (empty)
[1]
```

## template-builtins-9

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/cli.json 51 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{printf "}}"}}' -
@STDOUT
}} (no-eol)
@STDERR (empty)
[1]
```

## template-builtins-10

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 52
@STDOUT
"" (escaped)
"\tevents" (escaped)
"" (escaped)
"\trunner-label" (escaped)
"" (escaped)
"\tif-cond" (escaped)
@STDERR (empty)
[1]
```

## shellcheck-command-arguments

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 53
@STDOUT
<stdin>:6:9: shellcheck reported issue in this script: SC2086:info:1:6: Double quote to prevent globbing and word splitting [shellcheck]
"  |" (escaped)
6 |       - run: echo hello
"  |         ^~~~" (escaped)
@STDERR (empty)
[1]
```

## shellcheck-large-stdin

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 54
@STDOUT
<stdin>:6:9: shellcheck reported issue in this script: SC2086:info:1:6: Double quote to prevent globbing and word splitting [shellcheck]
@STDERR (empty)
[1]
```

## pyflakes-command-arguments

This port intentionally removes Pyflakes integration and rejects legacy arguments; upstream still executes the command with additional arguments.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 55
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

## pyflakes-removal-flag-short-bare

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -pyflakes
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

## pyflakes-removal-flag-short-empty

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -pyflakes= -
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

## pyflakes-removal-flag-short-value

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -pyflakes=actionlint-missing-pyflakes-checker -
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

## pyflakes-removal-flag-short-separate

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -pyflakes actionlint-missing-pyflakes-checker -
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

## pyflakes-removal-flag-short-separate-empty

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -pyflakes '' -
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

## pyflakes-removal-flag-long-bare

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= --pyflakes
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

## pyflakes-removal-flag-long-empty

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= --pyflakes= -
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

## pyflakes-removal-flag-long-value

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= --pyflakes=actionlint-missing-pyflakes-checker -
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

## pyflakes-removal-flag-long-separate

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= --pyflakes actionlint-missing-pyflakes-checker -
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

## pyflakes-removal-flag-long-separate-empty

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= --pyflakes '' -
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

## python-shell-step-python-quiet-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 66
@STDOUT
pyflakes invoked: false
@STDERR (empty)
```

## python-shell-step-python-quiet-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 67
@STDOUT
<stdin>:6:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR (empty)
[1]
```

## python-shell-step-python--verbose-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 68
@STDOUT
pyflakes invoked: false
@STDERR
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
verbose: Found total 0 errors in [0-9]+ ms for <stdin> (regex)
```

## python-shell-step-python--verbose-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 69
@STDOUT
<stdin>:6:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
verbose: Found total 1 errors in [0-9]+ ms for <stdin> (regex)
[1]
```

## python-shell-step-python--debug-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 70
@STDOUT
pyflakes invoked: false
@STDERR
[Linter] Create a Linter instance (MoonBit)
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
[Linter] matrix found 0 errors
[Linter] credentials found 0 errors
[Linter] shell-name found 0 errors
[Linter] runner-label found 0 errors
[Linter] events found 0 errors
[Linter] job-needs found 0 errors
[Linter] action found 0 errors
[Linter] env-var found 0 errors
[Linter] id found 0 errors
[Linter] glob found 0 errors
[Linter] permissions found 0 errors
[Linter] workflow-call found 0 errors
[Linter] expression found 0 errors
[Linter] deprecated-commands found 0 errors
[Linter] if-cond found 0 errors
verbose: Found total 0 errors in [0-9]+ ms for <stdin> (regex)
```

## python-shell-step-python--debug-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 71
@STDOUT
<stdin>:6:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR
[Linter] Create a Linter instance (MoonBit)
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
[Linter] matrix found 0 errors
[Linter] credentials found 0 errors
[Linter] shell-name found 0 errors
[Linter] runner-label found 0 errors
[Linter] events found 0 errors
[Linter] job-needs found 0 errors
[Linter] action found 0 errors
[Linter] env-var found 0 errors
[Linter] id found 0 errors
[Linter] glob found 0 errors
[Linter] permissions found 0 errors
[Linter] workflow-call found 0 errors
[Linter] expression found 1 errors
[Linter] deprecated-commands found 0 errors
[Linter] if-cond found 0 errors
verbose: Found total 1 errors in [0-9]+ ms for <stdin> (regex)
[1]
```

## python-shell-step-python {0}-quiet-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 72
@STDOUT
pyflakes invoked: false
@STDERR (empty)
```

## python-shell-step-python {0}-quiet-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 73
@STDOUT
<stdin>:6:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR (empty)
[1]
```

## python-shell-step-python {0}--verbose-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 74
@STDOUT
pyflakes invoked: false
@STDERR
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
verbose: Found total 0 errors in [0-9]+ ms for <stdin> (regex)
```

## python-shell-step-python {0}--verbose-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 75
@STDOUT
<stdin>:6:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
verbose: Found total 1 errors in [0-9]+ ms for <stdin> (regex)
[1]
```

## python-shell-step-python {0}--debug-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 76
@STDOUT
pyflakes invoked: false
@STDERR
[Linter] Create a Linter instance (MoonBit)
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
[Linter] matrix found 0 errors
[Linter] credentials found 0 errors
[Linter] shell-name found 0 errors
[Linter] runner-label found 0 errors
[Linter] events found 0 errors
[Linter] job-needs found 0 errors
[Linter] action found 0 errors
[Linter] env-var found 0 errors
[Linter] id found 0 errors
[Linter] glob found 0 errors
[Linter] permissions found 0 errors
[Linter] workflow-call found 0 errors
[Linter] expression found 0 errors
[Linter] deprecated-commands found 0 errors
[Linter] if-cond found 0 errors
verbose: Found total 0 errors in [0-9]+ ms for <stdin> (regex)
```

## python-shell-step-python {0}--debug-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 77
@STDOUT
<stdin>:6:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR
[Linter] Create a Linter instance (MoonBit)
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
[Linter] matrix found 0 errors
[Linter] credentials found 0 errors
[Linter] shell-name found 0 errors
[Linter] runner-label found 0 errors
[Linter] events found 0 errors
[Linter] job-needs found 0 errors
[Linter] action found 0 errors
[Linter] env-var found 0 errors
[Linter] id found 0 errors
[Linter] glob found 0 errors
[Linter] permissions found 0 errors
[Linter] workflow-call found 0 errors
[Linter] expression found 1 errors
[Linter] deprecated-commands found 0 errors
[Linter] if-cond found 0 errors
verbose: Found total 1 errors in [0-9]+ ms for <stdin> (regex)
[1]
```

## python-shell-job-python-quiet-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 78
@STDOUT
pyflakes invoked: false
@STDERR (empty)
```

## python-shell-job-python-quiet-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 79
@STDOUT
<stdin>:9:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR (empty)
[1]
```

## python-shell-job-python--verbose-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 80
@STDOUT
pyflakes invoked: false
@STDERR
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
verbose: Found total 0 errors in [0-9]+ ms for <stdin> (regex)
```

## python-shell-job-python--verbose-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 81
@STDOUT
<stdin>:9:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
verbose: Found total 1 errors in [0-9]+ ms for <stdin> (regex)
[1]
```

## python-shell-job-python--debug-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 82
@STDOUT
pyflakes invoked: false
@STDERR
[Linter] Create a Linter instance (MoonBit)
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
[Linter] matrix found 0 errors
[Linter] credentials found 0 errors
[Linter] shell-name found 0 errors
[Linter] runner-label found 0 errors
[Linter] events found 0 errors
[Linter] job-needs found 0 errors
[Linter] action found 0 errors
[Linter] env-var found 0 errors
[Linter] id found 0 errors
[Linter] glob found 0 errors
[Linter] permissions found 0 errors
[Linter] workflow-call found 0 errors
[Linter] expression found 0 errors
[Linter] deprecated-commands found 0 errors
[Linter] if-cond found 0 errors
verbose: Found total 0 errors in [0-9]+ ms for <stdin> (regex)
```

## python-shell-job-python--debug-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 83
@STDOUT
<stdin>:9:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR
[Linter] Create a Linter instance (MoonBit)
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
[Linter] matrix found 0 errors
[Linter] credentials found 0 errors
[Linter] shell-name found 0 errors
[Linter] runner-label found 0 errors
[Linter] events found 0 errors
[Linter] job-needs found 0 errors
[Linter] action found 0 errors
[Linter] env-var found 0 errors
[Linter] id found 0 errors
[Linter] glob found 0 errors
[Linter] permissions found 0 errors
[Linter] workflow-call found 0 errors
[Linter] expression found 1 errors
[Linter] deprecated-commands found 0 errors
[Linter] if-cond found 0 errors
verbose: Found total 1 errors in [0-9]+ ms for <stdin> (regex)
[1]
```

## python-shell-job-python {0}-quiet-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 84
@STDOUT
pyflakes invoked: false
@STDERR (empty)
```

## python-shell-job-python {0}-quiet-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 85
@STDOUT
<stdin>:9:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR (empty)
[1]
```

## python-shell-job-python {0}--verbose-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 86
@STDOUT
pyflakes invoked: false
@STDERR
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
verbose: Found total 0 errors in [0-9]+ ms for <stdin> (regex)
```

## python-shell-job-python {0}--verbose-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 87
@STDOUT
<stdin>:9:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
verbose: Found total 1 errors in [0-9]+ ms for <stdin> (regex)
[1]
```

## python-shell-job-python {0}--debug-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 88
@STDOUT
pyflakes invoked: false
@STDERR
[Linter] Create a Linter instance (MoonBit)
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
[Linter] matrix found 0 errors
[Linter] credentials found 0 errors
[Linter] shell-name found 0 errors
[Linter] runner-label found 0 errors
[Linter] events found 0 errors
[Linter] job-needs found 0 errors
[Linter] action found 0 errors
[Linter] env-var found 0 errors
[Linter] id found 0 errors
[Linter] glob found 0 errors
[Linter] permissions found 0 errors
[Linter] workflow-call found 0 errors
[Linter] expression found 0 errors
[Linter] deprecated-commands found 0 errors
[Linter] if-cond found 0 errors
verbose: Found total 0 errors in [0-9]+ ms for <stdin> (regex)
```

## python-shell-job-python {0}--debug-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 89
@STDOUT
<stdin>:9:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR
[Linter] Create a Linter instance (MoonBit)
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
[Linter] matrix found 0 errors
[Linter] credentials found 0 errors
[Linter] shell-name found 0 errors
[Linter] runner-label found 0 errors
[Linter] events found 0 errors
[Linter] job-needs found 0 errors
[Linter] action found 0 errors
[Linter] env-var found 0 errors
[Linter] id found 0 errors
[Linter] glob found 0 errors
[Linter] permissions found 0 errors
[Linter] workflow-call found 0 errors
[Linter] expression found 1 errors
[Linter] deprecated-commands found 0 errors
[Linter] if-cond found 0 errors
verbose: Found total 1 errors in [0-9]+ ms for <stdin> (regex)
[1]
```

## python-shell-workflow-python-quiet-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 90
@STDOUT
pyflakes invoked: false
@STDERR (empty)
```

## python-shell-workflow-python-quiet-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 91
@STDOUT
<stdin>:9:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR (empty)
[1]
```

## python-shell-workflow-python--verbose-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 92
@STDOUT
pyflakes invoked: false
@STDERR
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
verbose: Found total 0 errors in [0-9]+ ms for <stdin> (regex)
```

## python-shell-workflow-python--verbose-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 93
@STDOUT
<stdin>:9:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
verbose: Found total 1 errors in [0-9]+ ms for <stdin> (regex)
[1]
```

## python-shell-workflow-python--debug-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 94
@STDOUT
pyflakes invoked: false
@STDERR
[Linter] Create a Linter instance (MoonBit)
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
[Linter] matrix found 0 errors
[Linter] credentials found 0 errors
[Linter] shell-name found 0 errors
[Linter] runner-label found 0 errors
[Linter] events found 0 errors
[Linter] job-needs found 0 errors
[Linter] action found 0 errors
[Linter] env-var found 0 errors
[Linter] id found 0 errors
[Linter] glob found 0 errors
[Linter] permissions found 0 errors
[Linter] workflow-call found 0 errors
[Linter] expression found 0 errors
[Linter] deprecated-commands found 0 errors
[Linter] if-cond found 0 errors
verbose: Found total 0 errors in [0-9]+ ms for <stdin> (regex)
```

## python-shell-workflow-python--debug-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 95
@STDOUT
<stdin>:9:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR
[Linter] Create a Linter instance (MoonBit)
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
[Linter] matrix found 0 errors
[Linter] credentials found 0 errors
[Linter] shell-name found 0 errors
[Linter] runner-label found 0 errors
[Linter] events found 0 errors
[Linter] job-needs found 0 errors
[Linter] action found 0 errors
[Linter] env-var found 0 errors
[Linter] id found 0 errors
[Linter] glob found 0 errors
[Linter] permissions found 0 errors
[Linter] workflow-call found 0 errors
[Linter] expression found 1 errors
[Linter] deprecated-commands found 0 errors
[Linter] if-cond found 0 errors
verbose: Found total 1 errors in [0-9]+ ms for <stdin> (regex)
[1]
```

## python-shell-workflow-python {0}-quiet-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 96
@STDOUT
pyflakes invoked: false
@STDERR (empty)
```

## python-shell-workflow-python {0}-quiet-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 97
@STDOUT
<stdin>:9:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR (empty)
[1]
```

## python-shell-workflow-python {0}--verbose-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 98
@STDOUT
pyflakes invoked: false
@STDERR
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
verbose: Found total 0 errors in [0-9]+ ms for <stdin> (regex)
```

## python-shell-workflow-python {0}--verbose-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 99
@STDOUT
<stdin>:9:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
verbose: Found total 1 errors in [0-9]+ ms for <stdin> (regex)
[1]
```

## python-shell-workflow-python {0}--debug-expression-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 100
@STDOUT
pyflakes invoked: false
@STDERR
[Linter] Create a Linter instance (MoonBit)
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
[Linter] matrix found 0 errors
[Linter] credentials found 0 errors
[Linter] shell-name found 0 errors
[Linter] runner-label found 0 errors
[Linter] events found 0 errors
[Linter] job-needs found 0 errors
[Linter] action found 0 errors
[Linter] env-var found 0 errors
[Linter] id found 0 errors
[Linter] glob found 0 errors
[Linter] permissions found 0 errors
[Linter] workflow-call found 0 errors
[Linter] expression found 0 errors
[Linter] deprecated-commands found 0 errors
[Linter] if-cond found 0 errors
verbose: Found total 0 errors in [0-9]+ ms for <stdin> (regex)
```

## python-shell-workflow-python {0}--debug-expression-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 101
@STDOUT
<stdin>:9:25: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
pyflakes invoked: false
@STDERR
[Linter] Create a Linter instance (MoonBit)
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
[Linter] matrix found 0 errors
[Linter] credentials found 0 errors
[Linter] shell-name found 0 errors
[Linter] runner-label found 0 errors
[Linter] events found 0 errors
[Linter] job-needs found 0 errors
[Linter] action found 0 errors
[Linter] env-var found 0 errors
[Linter] id found 0 errors
[Linter] glob found 0 errors
[Linter] permissions found 0 errors
[Linter] workflow-call found 0 errors
[Linter] expression found 1 errors
[Linter] deprecated-commands found 0 errors
[Linter] if-cond found 0 errors
verbose: Found total 1 errors in [0-9]+ ms for <stdin> (regex)
[1]
```

## allKinds-rules-shellcheck-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 102
@STDOUT
[{"Name":"action","Description":"Checks for popular actions released on GitHub, local actions, and action calls at \"uses:\""},{"Name":"credentials","Description":"Checks for credentials in \"services:\" configuration"},{"Name":"deprecated-commands","Description":"Checks for deprecated \"set-output\", \"save-state\", \"set-env\", and \"add-path\" commands at \"run:\""},{"Name":"env-var","Description":"Checks for environment variables configuration at \"env:\""},{"Name":"events","Description":"Checks for workflow trigger events at \"on:\""},{"Name":"expression","Description":"Syntax and semantics checks for expressions embedded with ${{ }} syntax"},{"Name":"glob","Description":"Checks for glob syntax used in branch names, tags, and paths"},{"Name":"id","Description":"Checks for duplication and naming convention of job/step IDs"},{"Name":"if-cond","Description":"Checks for if: conditions which are always true/false"},{"Name":"job-needs","Description":"Checks for job IDs in \"needs:\". Undefined IDs and cyclic dependencies are checked"},{"Name":"matrix","Description":"Checks for matrix combinations in \"matrix:\""},{"Name":"permissions","Description":"Checks for permissions configuration in \"permissions:\". Permission names and permission scopes are checked"},{"Name":"runner-label","Description":"Checks for GitHub-hosted and preset self-hosted runner labels in \"runs-on:\""},{"Name":"shell-name","Description":"Checks for shell names used for scripts in \"run:\""},{"Name":"syntax-check","Description":"Checks for GitHub Actions workflow syntax"},{"Name":"workflow-call","Description":"Checks for reusable workflow calls. Inputs and outputs of called reusable workflow are checked"}]
pyflakes invoked: false
@STDERR (empty)
```

## sarif-rules-shellcheck-False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 103
@STDOUT
{
"    \"$schema\": \"https://raw.githubusercontent.com/oasis-tcs/sarif-spec/master/Schemata/sarif-schema-2.1.0.json\"," (escaped)
"    \"version\": \"2.1.0\"," (escaped)
"    \"runs\": [" (escaped)
"        {" (escaped)
"            \"tool\": {" (escaped)
"                \"driver\": {" (escaped)
"                    \"name\": \"GitHub Actions lint\"," (escaped)
"                    \"version\": \"rule-list-test\"" (escaped)
,
"                    \"informationUri\": \"https://github.com/rhysd/actionlint\"," (escaped)
"                    \"rules\": [" (escaped)
"                        " (escaped)
"                        " (escaped)
"                            " (escaped)
"                            {" (escaped)
"                                \"id\": \"action\"" (escaped)
,
"                                \"name\": \"Action\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for popular actions released on GitHub, local actions, and action calls at \\\"uses:\\\"\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for popular actions released on GitHub, local actions, and action calls at \\\"uses:\\\"\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"credentials\"" (escaped)
,
"                                \"name\": \"Credentials\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for credentials in \\\"services:\\\" configuration\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for credentials in \\\"services:\\\" configuration\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"deprecated-commands\"" (escaped)
,
"                                \"name\": \"DeprecatedCommands\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for deprecated \\\"set-output\\\", \\\"save-state\\\", \\\"set-env\\\", and \\\"add-path\\\" commands at \\\"run:\\\"\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for deprecated \\\"set-output\\\", \\\"save-state\\\", \\\"set-env\\\", and \\\"add-path\\\" commands at \\\"run:\\\"\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"env-var\"" (escaped)
,
"                                \"name\": \"EnvVar\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for environment variables configuration at \\\"env:\\\"\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for environment variables configuration at \\\"env:\\\"\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"events\"" (escaped)
,
"                                \"name\": \"Events\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for workflow trigger events at \\\"on:\\\"\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for workflow trigger events at \\\"on:\\\"\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"expression\"" (escaped)
,
"                                \"name\": \"Expression\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Syntax and semantics checks for expressions embedded with ${{ }} syntax\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Syntax and semantics checks for expressions embedded with ${{ }} syntax\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"glob\"" (escaped)
,
"                                \"name\": \"Glob\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for glob syntax used in branch names, tags, and paths\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for glob syntax used in branch names, tags, and paths\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"id\"" (escaped)
,
"                                \"name\": \"Id\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for duplication and naming convention of job/step IDs\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for duplication and naming convention of job/step IDs\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"if-cond\"" (escaped)
,
"                                \"name\": \"IfCond\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for if: conditions which are always true/false\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for if: conditions which are always true/false\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"job-needs\"" (escaped)
,
"                                \"name\": \"JobNeeds\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for job IDs in \\\"needs:\\\". Undefined IDs and cyclic dependencies are checked\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for job IDs in \\\"needs:\\\". Undefined IDs and cyclic dependencies are checked\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"matrix\"" (escaped)
,
"                                \"name\": \"Matrix\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for matrix combinations in \\\"matrix:\\\"\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for matrix combinations in \\\"matrix:\\\"\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"permissions\"" (escaped)
,
"                                \"name\": \"Permissions\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for permissions configuration in \\\"permissions:\\\". Permission names and permission scopes are checked\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for permissions configuration in \\\"permissions:\\\". Permission names and permission scopes are checked\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"runner-label\"" (escaped)
,
"                                \"name\": \"RunnerLabel\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for GitHub-hosted and preset self-hosted runner labels in \\\"runs-on:\\\"\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for GitHub-hosted and preset self-hosted runner labels in \\\"runs-on:\\\"\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"shell-name\"" (escaped)
,
"                                \"name\": \"ShellName\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for shell names used for scripts in \\\"run:\\\"\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for shell names used for scripts in \\\"run:\\\"\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"syntax-check\"" (escaped)
,
"                                \"name\": \"SyntaxCheck\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for GitHub Actions workflow syntax\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for GitHub Actions workflow syntax\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"workflow-call\"" (escaped)
,
"                                \"name\": \"WorkflowCall\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for reusable workflow calls. Inputs and outputs of called reusable workflow are checked\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for reusable workflow calls. Inputs and outputs of called reusable workflow are checked\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                    ]" (escaped)
"                }" (escaped)
"            }," (escaped)
"            \"results\": [" (escaped)
"                " (escaped)
"                " (escaped)
"            ]" (escaped)
"        }" (escaped)
"    ]" (escaped)
}
pyflakes invoked: false
@STDERR (empty)
```

## allKinds-rules-shellcheck-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 104
@STDOUT
[{"Name":"action","Description":"Checks for popular actions released on GitHub, local actions, and action calls at \"uses:\""},{"Name":"credentials","Description":"Checks for credentials in \"services:\" configuration"},{"Name":"deprecated-commands","Description":"Checks for deprecated \"set-output\", \"save-state\", \"set-env\", and \"add-path\" commands at \"run:\""},{"Name":"env-var","Description":"Checks for environment variables configuration at \"env:\""},{"Name":"events","Description":"Checks for workflow trigger events at \"on:\""},{"Name":"expression","Description":"Syntax and semantics checks for expressions embedded with ${{ }} syntax"},{"Name":"glob","Description":"Checks for glob syntax used in branch names, tags, and paths"},{"Name":"id","Description":"Checks for duplication and naming convention of job/step IDs"},{"Name":"if-cond","Description":"Checks for if: conditions which are always true/false"},{"Name":"job-needs","Description":"Checks for job IDs in \"needs:\". Undefined IDs and cyclic dependencies are checked"},{"Name":"matrix","Description":"Checks for matrix combinations in \"matrix:\""},{"Name":"permissions","Description":"Checks for permissions configuration in \"permissions:\". Permission names and permission scopes are checked"},{"Name":"runner-label","Description":"Checks for GitHub-hosted and preset self-hosted runner labels in \"runs-on:\""},{"Name":"shell-name","Description":"Checks for shell names used for scripts in \"run:\""},{"Name":"shellcheck","Description":"Checks for shell script sources in \"run:\" using shellcheck"},{"Name":"syntax-check","Description":"Checks for GitHub Actions workflow syntax"},{"Name":"workflow-call","Description":"Checks for reusable workflow calls. Inputs and outputs of called reusable workflow are checked"}]
pyflakes invoked: false
@STDERR (empty)
```

## sarif-rules-shellcheck-True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 105
@STDOUT
{
"    \"$schema\": \"https://raw.githubusercontent.com/oasis-tcs/sarif-spec/master/Schemata/sarif-schema-2.1.0.json\"," (escaped)
"    \"version\": \"2.1.0\"," (escaped)
"    \"runs\": [" (escaped)
"        {" (escaped)
"            \"tool\": {" (escaped)
"                \"driver\": {" (escaped)
"                    \"name\": \"GitHub Actions lint\"," (escaped)
"                    \"version\": \"rule-list-test\"" (escaped)
,
"                    \"informationUri\": \"https://github.com/rhysd/actionlint\"," (escaped)
"                    \"rules\": [" (escaped)
"                        " (escaped)
"                        " (escaped)
"                            " (escaped)
"                            {" (escaped)
"                                \"id\": \"action\"" (escaped)
,
"                                \"name\": \"Action\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for popular actions released on GitHub, local actions, and action calls at \\\"uses:\\\"\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for popular actions released on GitHub, local actions, and action calls at \\\"uses:\\\"\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"credentials\"" (escaped)
,
"                                \"name\": \"Credentials\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for credentials in \\\"services:\\\" configuration\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for credentials in \\\"services:\\\" configuration\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"deprecated-commands\"" (escaped)
,
"                                \"name\": \"DeprecatedCommands\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for deprecated \\\"set-output\\\", \\\"save-state\\\", \\\"set-env\\\", and \\\"add-path\\\" commands at \\\"run:\\\"\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for deprecated \\\"set-output\\\", \\\"save-state\\\", \\\"set-env\\\", and \\\"add-path\\\" commands at \\\"run:\\\"\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"env-var\"" (escaped)
,
"                                \"name\": \"EnvVar\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for environment variables configuration at \\\"env:\\\"\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for environment variables configuration at \\\"env:\\\"\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"events\"" (escaped)
,
"                                \"name\": \"Events\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for workflow trigger events at \\\"on:\\\"\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for workflow trigger events at \\\"on:\\\"\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"expression\"" (escaped)
,
"                                \"name\": \"Expression\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Syntax and semantics checks for expressions embedded with ${{ }} syntax\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Syntax and semantics checks for expressions embedded with ${{ }} syntax\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"glob\"" (escaped)
,
"                                \"name\": \"Glob\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for glob syntax used in branch names, tags, and paths\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for glob syntax used in branch names, tags, and paths\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"id\"" (escaped)
,
"                                \"name\": \"Id\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for duplication and naming convention of job/step IDs\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for duplication and naming convention of job/step IDs\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"if-cond\"" (escaped)
,
"                                \"name\": \"IfCond\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for if: conditions which are always true/false\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for if: conditions which are always true/false\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"job-needs\"" (escaped)
,
"                                \"name\": \"JobNeeds\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for job IDs in \\\"needs:\\\". Undefined IDs and cyclic dependencies are checked\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for job IDs in \\\"needs:\\\". Undefined IDs and cyclic dependencies are checked\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"matrix\"" (escaped)
,
"                                \"name\": \"Matrix\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for matrix combinations in \\\"matrix:\\\"\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for matrix combinations in \\\"matrix:\\\"\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"permissions\"" (escaped)
,
"                                \"name\": \"Permissions\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for permissions configuration in \\\"permissions:\\\". Permission names and permission scopes are checked\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for permissions configuration in \\\"permissions:\\\". Permission names and permission scopes are checked\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"runner-label\"" (escaped)
,
"                                \"name\": \"RunnerLabel\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for GitHub-hosted and preset self-hosted runner labels in \\\"runs-on:\\\"\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for GitHub-hosted and preset self-hosted runner labels in \\\"runs-on:\\\"\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"shell-name\"" (escaped)
,
"                                \"name\": \"ShellName\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for shell names used for scripts in \\\"run:\\\"\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for shell names used for scripts in \\\"run:\\\"\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"shellcheck\"" (escaped)
,
"                                \"name\": \"Shellcheck\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for shell script sources in \\\"run:\\\" using shellcheck\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for shell script sources in \\\"run:\\\" using shellcheck\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"syntax-check\"" (escaped)
,
"                                \"name\": \"SyntaxCheck\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for GitHub Actions workflow syntax\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for GitHub Actions workflow syntax\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                            ," (escaped)
"                            {" (escaped)
"                                \"id\": \"workflow-call\"" (escaped)
,
"                                \"name\": \"WorkflowCall\"" (escaped)
,
"                                \"defaultConfiguration\": {" (escaped)
"                                    \"level\": \"error\"" (escaped)
"                                }," (escaped)
"                                \"properties\": {" (escaped)
"                                    \"description\": \"Checks for reusable workflow calls. Inputs and outputs of called reusable workflow are checked\"" (escaped)
,
"                                    \"queryURI\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                                }," (escaped)
"                                \"fullDescription\": {" (escaped)
"                                    \"text\": \"Checks for reusable workflow calls. Inputs and outputs of called reusable workflow are checked\"" (escaped)
"" (escaped)
"                                }," (escaped)
"                                \"helpUri\": \"https://github.com/rhysd/actionlint/blob/main/docs/checks.md\"" (escaped)
"                            }" (escaped)
"                        " (escaped)
"                    ]" (escaped)
"                }" (escaped)
"            }," (escaped)
"            \"results\": [" (escaped)
"                " (escaped)
"                " (escaped)
"            ]" (escaped)
"        }" (escaped)
"    ]" (escaped)
}
pyflakes invoked: false
@STDERR (empty)
```

## version-compatibility-difference

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -version
@STDOUT
0.0.1
MoonBit port based on actionlint 1.7.12 (Pyflakes integration removed)
built with MoonBit for native/wasm
@STDERR (empty)
```

## generate-config-preserves-existing-file

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 107
@STDOUT
first exit: 0
Config file was generated at "$PROJECT/.github/actionlint.yaml"
config:
self-hosted-runner:
"  # Labels of self-hosted runner in array of strings." (escaped)
"  labels: []" (escaped)
"" (escaped)
# Configuration variables in array of strings defined in your repository or
# organization. `null` means disabling configuration variables check.
# Empty array means no configuration variable is allowed.
config-variables: null
"" (escaped)
# Configuration for file paths. The keys are glob patterns to match to file
# paths relative to the repository root. The values are the configurations for
# the file paths. Note that the path separator is always '/'.
# The following configurations are available.
#
# "ignore" is an array of regular expression patterns. Matched error messages
# are ignored. This is similar to the "-ignore" command line option.
paths:
#  .github/workflows/**/*.yml:
#    ignore: []
second exit: 3
preserved: true
@STDERR
config file already exists at "$PROJECT/.github/actionlint.yaml"
```

## repository-config

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 108
@STDOUT (empty)
@STDERR (empty)
```

## explicit-config-precedence

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 109
@STDOUT
.github/workflows/bad.yml:1:6: unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
"  |" (escaped)
1 | on: [typo]
"  |      ^~~~~" (escaped)
.github/workflows/bad.yml:7:13: constant expression "true" in condition. remove the if: section [if-cond]
"  |" (escaped)
7 |         if: true
"  |             ^~~~" (escaped)
@STDERR (empty)
[1]
```

## config-types-0

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 110
@STDOUT (empty)
@STDERR
could not parse config file "$PROJECT/invalid-config.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!bool `true` into actionlint.Config
[3]
```

## config-types-1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 111
@STDOUT (empty)
@STDERR
could not parse config file "$PROJECT/invalid-config.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!seq into actionlint.Config
[3]
```

## config-types-2

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 112
@STDOUT (empty)
@STDERR
could not parse config file "$PROJECT/invalid-config.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!int `42` into struct { Labels []string "yaml:\"labels\"" }
[3]
```

## config-types-3

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 113
@STDOUT (empty)
@STDERR
could not parse config file "$PROJECT/invalid-config.yml": yaml: unmarshal errors:   line 2: cannot unmarshal !!str `foo` into []string
[3]
```

## config-types-4

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 114
@STDOUT (empty)
@STDERR
could not parse config file "$PROJECT/invalid-config.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!str `abc` into []string
[3]
```

## config-types-5

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 115
@STDOUT (empty)
@STDERR
could not parse config file "$PROJECT/invalid-config.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!map into string
[3]
```

## config-types-6

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 116
@STDOUT (empty)
@STDERR
could not parse config file "$PROJECT/invalid-config.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!seq into map[string]actionlint.PathConfig
[3]
```

## config-types-7

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 117
@STDOUT (empty)
@STDERR
could not parse config file "$PROJECT/invalid-config.yml": yaml: unmarshal errors:   line 2: cannot unmarshal !!str `bar` into actionlint.PathConfig
[3]
```

## config-types-8

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 118
@STDOUT (empty)
@STDERR
could not parse config file "$PROJECT/invalid-config.yml": yaml: unmarshal errors:   line 3: yaml: "ignore" must be a sequence node at line:3,col:13
[3]
```

## config-types-9

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run cli 119
@STDOUT (empty)
@STDERR
could not parse config file "$PROJECT/invalid-config.yml": yaml: unmarshal errors:   line 2: mapping key "config-variables" already defined at line 1
[3]
```

