# Pyflakes Removal regressions

11 migrated cases. Inputs are in [fixtures/pyflakes_removal.json](fixtures/pyflakes_removal.json).
Each case asserts stdout, stderr, and exit status; only elapsed milliseconds vary.

## pyflakes-removal-flag-short-bare

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -pyflakes
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
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -pyflakes= -
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
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -pyflakes=actionlint-missing-pyflakes-checker -
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
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -pyflakes actionlint-missing-pyflakes-checker -
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
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -pyflakes '' -
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
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline --pyflakes
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
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline --pyflakes= -
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
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline --pyflakes=actionlint-missing-pyflakes-checker -
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
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline --pyflakes actionlint-missing-pyflakes-checker -
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
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline --pyflakes '' -
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

## pyflakes-removal-help

This port intentionally removes Pyflakes integration; the help text no longer lists the -pyflakes argument.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -help
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

