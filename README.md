# actionlint for MoonBit

A GitHub Actions workflow linter implemented in MoonBit, using this repository's
`baseline/` (actionlint 1.7.12) as its compatibility reference. Supports native and
wasm targets without invoking the original actionlint or depending on Go at runtime.
The native C code is used only for process exit and terminal detection.

## Build and run

The MoonBit toolchain is required. Download dependencies before the first build:

```sh
moon update
make build

# native
./bin/actionlint -help
./bin/actionlint .github/workflows/ci.yml
./bin/actionlint                 # Discover workflows in the current Git repository

# wasm: run with MoonBit's moonrun, with file and subprocess access
moonrun bin/actionlint.wasm .github/workflows/ci.yml
```

You can also run directly from source:

```sh
moon run --target native . -- -oneline .github/workflows/ci.yml
moon run --target wasm . -- -help
cat workflow.yml | ./bin/actionlint -stdin-filename workflow.yml -
./bin/actionlint -format '{{json .}}' workflow.yml
./bin/actionlint -init-config
```

Use `make native` / `make wasm` to build the corresponding release artifact
separately. The wasm artifact uses the host interfaces provided by
`moonbitlang/async` and requires `moonrun`; it cannot run directly in a browser.

## Features

- Supports CLI arguments, standard input, multiple input files, repository
  discovery, configuration loading, and exit code behavior.
- Validates workflows, jobs, steps, events, cron schedules, runner labels,
  permissions, matrices, job dependencies and cycles, environment variables,
  credentials, and deprecated commands.
- Parses Actions expressions and checks context availability, types, built-in
  functions, properties and indexes, inputs, secrets, needs and steps outputs,
  and untrusted expressions in scripts.
- Checks action and reusable workflow references, inputs, and outputs; reads
  local action metadata and reusable workflows. Includes the baseline version's
  records for 218 popular actions.
- Supports `.github/actionlint.yaml` / `.yml`, custom runner labels,
  configuration variables, path globs, and regular expression ignore rules.
- Provides diagnostics with source indicators, single-line and colored output,
  and `-format` templates. Supports JSON, JSONL, Markdown, SARIF,
  range / if / with / define / template, variables, pipelines, and common template
  functions. Handles UTF-8 column positions, Chinese text, emoji, and CRLF.
- Optionally invokes ShellCheck, including commands with quoted arguments and
  additional arguments. Automatically disables it when not installed; it can also
  be disabled with `-shellcheck=`.

Exit codes: `0` for no issues, `1` for detected issues, `2` for CLI argument errors,
and `3` for file, configuration, or runtime errors. `-version` displays the port's
version and compatibility baseline.

Removing Pyflakes is an intentional incompatibility with actionlint 1.7.12.
`-pyflakes`, `--pyflakes`, and their empty-value, assigned-value, and standalone
forms are treated as unknown arguments and return exit code `2`. `shell: python`
remains valid, including job and workflow default shells, and Actions expressions
in Python steps are still checked. Pyflakes is no longer invoked and its
diagnostics are no longer reported. Help text, verbose/debug logs, `allKinds`,
and the SARIF rule list no longer include this integration.

## Validation

```sh
make check test cli-test
moon info && moon fmt
```

Tests cover the original **230 workflow fixtures and 30 project fixtures** on
native and wasm, comparing diagnostic content, ordering, and positions. Additional
tests cover JSON / JSONL / Markdown / SARIF output, configuration, and Unicode
regressions. The CLI script includes **136 end-to-end scenarios** covering exit
codes, stdout / stderr, configuration generation, templates, external command
arguments, and large scripts piped through standard input.
`scripts/behavior_cases.json` preserves the original 160 behavior scenarios;
`scripts/audit_cases.json` contains all 320 inputs from the audit, and
`scripts/boundary_cases.json` adds 135 related boundary scenarios.
`scripts/review_cases.json` preserves all 717 inputs from the subsequent audit,
and `scripts/review_boundary_cases.json` adds 259 boundary cases for the identified
root causes. `scripts/pyflakes_removal_cases.json` adds 11 scenarios for legacy
arguments and help text.
Of the 1602 cases, 1600 compare complete stdout, stderr, and exit codes, replacing
only the temporary project directory. Two verbose/debug scenarios check log events,
filenames, and statistics. When templates produce non-UTF-8 bytes, expectations
preserve all bytes in hexadecimal without lossy decoding.
Regular regressions use stored expectations and do not require Go. Intentional
differences store `expected`, `baseline_expected`, and `difference_reason`, with
the reference binary checking the upstream expectations. Legacy Pyflakes inputs
and upstream expectations are preserved; this project's expectations now require
argument errors. CLI tests put a mock Pyflakes executable that records invocations
on `PATH`, verifying that Python shells at all three levels never invoke it and
that expression errors are still detected. Tests for the port do not automatically
pass legacy arguments; the reference program still receives `-pyflakes=` to
disable the default integration, while explicit test arguments are preserved.

All five upstream Python workflow fixtures are executed. For the four that
originally produced Pyflakes diagnostics, `scripts/fixture_differences.json`
stores empty diagnostic expectations, upstream expectations, and the reasons for
the differences. Fixtures that depend on ShellCheck require its command on `PATH`;
if it is missing, the JSON report marks them as skipped. To require these
ShellCheck fixtures to run:

```sh
ACTIONLINT_REQUIRE_CHECKERS=1 moon test --target native
ACTIONLINT_REQUIRE_CHECKERS=1 moon test --target wasm
```

Optionally compare CLI behavior with a separately built upstream binary, used
only for testing:

```sh
python3 scripts/test_cli.py --release --reference /path/to/original/actionlint
python3 scripts/test_cli.py --target wasm --release --reference /path/to/original/actionlint
python3 scripts/test_behavior.py --target all --reference /path/to/original/actionlint

# Check a single release artifact against stored expectations
python3 scripts/test_behavior.py --target native
python3 scripts/test_behavior.py --target wasm
```

Results are written to `_build/compatibility-{native,wasm}.json`,
`_build/projects-{native,wasm}.json`, `_build/cli-{native,wasm}.json`, and
`_build/behavior-report.json`. See
[scripts/behavior_report.md](scripts/behavior_report.md) for before-and-after
statistics and reproduction commands.

## Compatibility scope

The fixtures and CLI comparisons described above pass; this does not prove full
equivalence for every possible input. Covered audit boundaries include 64-bit
index overflow in `format()`, brace escaping, key casing in `fromJSON()`,
interpolation diagnostic suppression, YAML document/tag positions, numeric
decoding, booleans/null/collections in local metadata, Docker URIs, deprecated
commands, CRON timezone names, and impossible dates.
For composite actions, `runs.steps: []` is accepted as in the baseline.
Special matrix keys and nested object matching follow the baseline's case rules.
Input types from the two workflow events are merged while `github.event.inputs`
retains string types. After structural parsing, only fields actually retained are
traversed, and only `if` is checked for snapshots. Duplicate metadata keys are
reported at the actual decoding level, and unknown configuration values are not
decoded recursively. CRON accepts Go's Unicode whitespace. Fatal errors while
reading, configuring, or checking multiple files suppress earlier diagnostics.
The established stricter checks still apply to all inputs of the same kind:
`workflow_call.required`, matrix include types, and the prohibition on refs in
local reusable workflow references. The existing 24 stricter-validation
differences retain both sets of expectations and their reasons; Pyflakes removal
differences are recorded separately.

Regular expressions are validated and translated from Go/RE2 syntax before being
passed to MoonBit regexp. Support includes POSIX classes, pinned Unicode 15.0.0
category/script data, flag scopes, anchors, quoting, and repetition count checks.
The generated data can be reproduced with
`go run scripts/generate_regex_unicode.go`, which requires Go's Unicode 15.0.0 data.
Templates implement a compatible subset of Go text/template in MoonBit, including
lazy short-circuit evaluation, block and loop scopes, separate named-template
environments, distinctions between Int64/floating-point/missing values, type
comparisons, and common printf argument diagnostics. Full Go reflection,
arbitrary function calls, and the complete fmt formatting system remain out of
scope.
Supported printf features include argument indexes, dynamic width/precision,
hexadecimal strings, character quoting, base prefixes, known diagnostic structs,
and reference comparisons. The `f/F/e/E/g/G` formats use exact decimal conversion
and round-to-even, covering subnormal numbers, the largest finite floating-point
value, and high-precision output.
`index` / `slice` and `replace` with an empty search string preserve byte
semantics, including non-UTF-8 output. Field access after parentheses,
break/continue for the innermost range, and partial output before execution errors
are supported. If template execution fails, single-file processing preserves the
diagnostic exit code and suppresses the execution error, matching the baseline;
multi-file processing writes the error to stderr and returns `3`.
Low-level parsing errors for malformed YAML, rare Unicode display widths,
timezone transition boundaries, and exact timings and implementation details in
verbose/debug output may also differ from upstream. Regression tests cover
reading, parsing, ShellCheck disabling, and diagnostic statistics events, and
require Pyflakes logs to be absent.

## Code organization

The root package is the CLI executable entry point, containing `main.mbt` and
native / wasm process exit adapters. All application logic lives under
`internal/`, organized by responsibility:

| Subpackage | Responsibility |
| --- | --- |
| `cli` | Arguments, command execution, help text, and terminal detection |
| `model` | YAML nodes, diagnostics, error collectors, shared errors, and quoting |
| `yaml` | YAML parsing, tag / numeric compatibility, and position corrections |
| `json` | JSON access, numeric value preservation, syntax diagnostics, and encoding |
| `matching` | RE2 regex compatibility, Unicode data, and path globs |
| `project` | Path handling, repository discovery, and workflow file collection |
| `config` | Configuration parsing, loading, and ignore rules |
| `data` | Automatically generated built-in baseline data |
| `expression` | Actions expression parsing, type inference, and untrusted input checks |
| `workflow` | Structural parsing, lint rules, metadata, external checkers, and linting orchestration |
| `template` | Output template parsing, validation, and execution |
| `output` | Diagnostic text, source indicators, and JSON field generation |

Dependencies flow from the root entry point to `cli`, then to the linting,
configuration, and output packages. Lower-level packages do not depend on the CLI.
`model` and `data` form the foundation; `workflow` combines parsing, expressions,
configuration, and rules. There are no circular package dependencies. Unit tests
live alongside each package's implementation, while upstream fixtures and output
format integration tests live in `internal/workflow/`. Each package exports only
the interfaces needed by other packages; the root package no longer exposes a
library API.

`scripts/generate_baseline_data.py` extracts built-in tables from the read-only
`baseline/` into `internal/data/builtin_data.mbt`, explicitly excluding Pyflakes
rules. Timezone names are pinned in `scripts/timezones.json`.
`scripts/generate_regex_unicode.go` generates
`internal/matching/regex_unicode.mbt`. Run `moon fmt` after regenerating the data.

The repository's original license is Apache-2.0. Ported actionlint logic, data,
help text, and test fixtures retain the upstream MIT notices; see
[THIRD_PARTY_NOTICES](THIRD_PARTY_NOTICES).
