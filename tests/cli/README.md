# CLI regression tests

Run from the module root:

```sh
moon testcli check tests/cli
ACTIONLINT_TEST_TARGET=native moon testcli test tests/cli --target native
ACTIONLINT_TEST_TARGET=wasm moon testcli test tests/cli --target wasm
```

`make testcli` runs both targets. `make cli-test` also builds the release binaries.
The suite contains all 136 CLI scenarios and 1602 behavior regressions migrated
from the former Node.js test runners.

The Markdown files are the source of truth for stdout, stderr, and exit codes.
The corresponding JSON files in `fixtures/` hold inputs in case order; the
numeric argument selects the array entry. Keep the case heading and fixture
`id` in sync when adding or reordering cases. `baseline_expected` and
`difference_reason` retain the original upstream expectations for intentional
differences; they are historical comparison data, not the port's assertions.

Most commands call actionlint directly. Plain files are piped in with
`moonx cli/cat@0.2.4`. The `input` command in `support/driver.mbtx` extracts
input from JSON fixtures. Cases that reject options before reading stdin omit
the input producer to avoid broken pipes.

For cases requiring multiple files, checker processes, or file side effects,
the driver's `run` command asks `moon run --build-only` for the current
actionlint artifact, runs it in an isolated temporary Git project, and removes
the project on exit. Mooncram executes the script as Wasm, so the driver reads
`ACTIONLINT_TEST_TARGET` to choose the actionlint backend. It forwards the exit
code and both output streams, replacing temporary project paths with
`$PROJECT` and representing invalid UTF-8 output as `hex: ...`. Log expectations
match elapsed milliseconds with regexes and check all remaining content exactly.

The driver builds `support/checker.mbtx` as a native executable for the mock
checker cases on both targets, so both suites need a native compiler. The
Python-shell cases verify the mock Pyflakes executable before putting it on
`PATH`, then report whether actionlint invoked it. The
config-generation case reports both invocations' exit codes, the generated
contents, and whether the second invocation preserved the existing file. These
observations are asserted in Markdown alongside the CLI diagnostics. The
ShellCheck fixtures cover arguments containing spaces and a 150 KB script
supplied on stdin.

After an intentional output change, preview and review the affected expectations:

```sh
ACTIONLINT_TEST_TARGET=native moon testcli update tests/cli/cli.md --target native --dry-run
ACTIONLINT_TEST_TARGET=native moon testcli update tests/cli/cli.md --target native
make testcli
```

Use the specific affected document when possible. Updates execute the commands;
the filesystem adapter keeps their side effects inside temporary projects.
