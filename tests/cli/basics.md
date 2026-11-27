# CLI input and output

Run from the repository root with `moon testcli test tests/cli --target native`
or `--target wasm`. These cases assert both output streams and the exit code.
The Mooncakes `cli/cat` tool pipes fixture files into actionlint.
Each actionlint command uses `-shellcheck=` to disable ShellCheck and
`NO_COLOR=1` to disable ANSI color. Fixtures are read relative to this document.

## Standard input

A valid workflow produces no diagnostics (`valid-stdin`).

```mooncram moonbit-community/actionlint
$ moonx cli/cat@0.2.4 fixtures/valid.yaml | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -
@STDOUT (empty)
@STDERR (empty)
```

An invalid workflow reports the event, runner label, and constant condition in
source order (`invalid-stdin`).

```mooncram moonbit-community/actionlint
$ moonx cli/cat@0.2.4 fixtures/invalid.yaml | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -
@STDOUT
<stdin>:1:6: unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
  |
1 | on: [typo]
  |      ^~~~~
<stdin>:4:14: label "no-such-runner" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
  |
4 |     runs-on: no-such-runner
  |              ^~~~~~~~~~~~~~
<stdin>:7:13: constant expression "true" in condition. remove the if: section [if-cond]
  |
7 |         if: true
  |             ^~~~
@STDERR (empty)
[1]
```

Without a producer, mooncram closes stdin immediately (`empty-stdin`).

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -
@STDOUT
<stdin>:1:1: workflow is empty [syntax-check]
@STDERR (empty)
[1]
```

A supplied filename appears in every diagnostic (`stdin-filename`); an empty
filename falls back to `<stdin>` (`empty-stdin-filename`).

```mooncram moonbit-community/actionlint
$ moonx cli/cat@0.2.4 fixtures/invalid.yaml | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -stdin-filename editor.yml -
@STDOUT
editor.yml:1:6: unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
  |
1 | on: [typo]
  |      ^~~~~
editor.yml:4:14: label "no-such-runner" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
  |
4 |     runs-on: no-such-runner
  |              ^~~~~~~~~~~~~~
editor.yml:7:13: constant expression "true" in condition. remove the if: section [if-cond]
  |
7 |         if: true
  |             ^~~~
@STDERR (empty)
[1]

$ moonx cli/cat@0.2.4 fixtures/invalid.yaml | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -stdin-filename= -
@STDOUT
<stdin>:1:6: unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
  |
1 | on: [typo]
  |      ^~~~~
<stdin>:4:14: label "no-such-runner" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
  |
4 |     runs-on: no-such-runner
  |              ^~~~~~~~~~~~~~
<stdin>:7:13: constant expression "true" in condition. remove the if: section [if-cond]
  |
7 |         if: true
  |             ^~~~
@STDERR (empty)
[1]
```

## Output formats

Single-line output omits source excerpts (`oneline`).

```mooncram moonbit-community/actionlint
$ moonx cli/cat@0.2.4 fixtures/invalid.yaml | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:6: unknown Webhook event "typo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
<stdin>:4:14: label "no-such-runner" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
<stdin>:7:13: constant expression "true" in condition. remove the if: section [if-cond]
@STDERR (empty)
[1]
```

JSON preserves all diagnostic fields (`json`), while JSONL writes one object
per line (`jsonl`). Valid input renders an empty JSON array (`empty-json`).

```mooncram moonbit-community/actionlint
$ moonx cli/cat@0.2.4 fixtures/invalid.yaml | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[{"message":"unknown Webhook event \"typo\". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names","filepath":"\u003cstdin\u003e","line":1,"column":6,"kind":"events","snippet":"on: [typo]\n     ^~~~~","end_column":10},{"message":"label \"no-such-runner\" is unknown. available labels are \"windows-latest\", \"windows-latest-8-cores\", \"windows-2025\", \"windows-2025-vs2026\", \"windows-2022\", \"windows-11-arm\", \"ubuntu-slim\", \"ubuntu-latest\", \"ubuntu-latest-4-cores\", \"ubuntu-latest-8-cores\", \"ubuntu-latest-16-cores\", \"ubuntu-24.04\", \"ubuntu-24.04-arm\", \"ubuntu-22.04\", \"ubuntu-22.04-arm\", \"macos-latest\", \"macos-latest-xlarge\", \"macos-latest-large\", \"macos-26-intel\", \"macos-26-xlarge\", \"macos-26-large\", \"macos-26\", \"macos-15-intel\", \"macos-15-xlarge\", \"macos-15-large\", \"macos-15\", \"macos-14-xlarge\", \"macos-14-large\", \"macos-14\", \"self-hosted\", \"x64\", \"arm\", \"arm64\", \"linux\", \"macos\", \"windows\". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file","filepath":"\u003cstdin\u003e","line":4,"column":14,"kind":"runner-label","snippet":"    runs-on: no-such-runner\n             ^~~~~~~~~~~~~~","end_column":27},{"message":"constant expression \"true\" in condition. remove the if: section","filepath":"\u003cstdin\u003e","line":7,"column":13,"kind":"if-cond","snippet":"        if: true\n            ^~~~","end_column":16}]
@STDERR (empty)
[1]

$ moonx cli/cat@0.2.4 fixtures/invalid.yaml | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{range .}}{{json .}}{{end}}' -
@STDOUT
{"message":"unknown Webhook event \"typo\". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names","filepath":"\u003cstdin\u003e","line":1,"column":6,"kind":"events","snippet":"on: [typo]\n     ^~~~~","end_column":10}
{"message":"label \"no-such-runner\" is unknown. available labels are \"windows-latest\", \"windows-latest-8-cores\", \"windows-2025\", \"windows-2025-vs2026\", \"windows-2022\", \"windows-11-arm\", \"ubuntu-slim\", \"ubuntu-latest\", \"ubuntu-latest-4-cores\", \"ubuntu-latest-8-cores\", \"ubuntu-latest-16-cores\", \"ubuntu-24.04\", \"ubuntu-24.04-arm\", \"ubuntu-22.04\", \"ubuntu-22.04-arm\", \"macos-latest\", \"macos-latest-xlarge\", \"macos-latest-large\", \"macos-26-intel\", \"macos-26-xlarge\", \"macos-26-large\", \"macos-26\", \"macos-15-intel\", \"macos-15-xlarge\", \"macos-15-large\", \"macos-15\", \"macos-14-xlarge\", \"macos-14-large\", \"macos-14\", \"self-hosted\", \"x64\", \"arm\", \"arm64\", \"linux\", \"macos\", \"windows\". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file","filepath":"\u003cstdin\u003e","line":4,"column":14,"kind":"runner-label","snippet":"    runs-on: no-such-runner\n             ^~~~~~~~~~~~~~","end_column":27}
{"message":"constant expression \"true\" in condition. remove the if: section","filepath":"\u003cstdin\u003e","line":7,"column":13,"kind":"if-cond","snippet":"        if: true\n            ^~~~","end_column":16}
@STDERR (empty)
[1]

$ moonx cli/cat@0.2.4 fixtures/valid.yaml | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{json .}}' -
@STDOUT
[]
@STDERR (empty)
```

Conditional templates select the empty-result branch (`template-conditional`).

```mooncram moonbit-community/actionlint
$ moonx cli/cat@0.2.4 fixtures/valid.yaml | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{if .}}bad{{else}}good{{end}}' -
@STDOUT
good (no-eol)
@STDERR (empty)
```

## Ignore rules

Alternation, matching every message, and repeated flags each suppress all
diagnostics and return success (`ignore`, `ignore-all`, `repeat-ignore`).

```mooncram moonbit-community/actionlint
$ moonx cli/cat@0.2.4 fixtures/invalid.yaml | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -ignore 'unknown|constant expression' -
@STDOUT (empty)
@STDERR (empty)

$ moonx cli/cat@0.2.4 fixtures/invalid.yaml | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -ignore . -
@STDOUT (empty)
@STDERR (empty)

$ moonx cli/cat@0.2.4 fixtures/invalid.yaml | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -ignore unknown -ignore constant -ignore 'unknown Webhook' -
@STDOUT (empty)
@STDERR (empty)
```

## Invalid options

Invalid regular expressions and templates fail on stderr with exit code 3
(`invalid-ignore`, `invalid-template`, `unknown-template-function`). These checks
run before stdin is read, so they omit the producer to avoid broken-pipe errors
from `cat` when actionlint exits early.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -ignore '[' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "[": error parsing regexp: missing closing ]: `[`
[3]

$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{' -
@STDOUT (empty)
@STDERR
template to format error messages could not be parsed: unclosed action
[3]

$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -format '{{nonexistent}}' -
@STDOUT (empty)
@STDERR
template to format error messages could not be parsed: function "nonexistent" not defined
[3]
```
