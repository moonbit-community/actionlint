# actionlint baseline behavior fixes and validation report

The reference implementation is the read-only `baseline/` (actionlint 1.7.12).
For this validation, the cached Go 1.25.0 toolchain was used to build
`/tmp/actionlint-implementation-reference` separately from that directory, solely
for verification. The runtime remains implemented in MoonBit, with native and
wasm support; the root entry point, `run_cli` signature, and diagnostic output
fields are unchanged. Removing Pyflakes is an intentional incompatibility with
actionlint 1.7.12: legacy arguments return exit code `2`, related content is
removed from help text, logs, and rule lists, and the version information
explicitly notes the removal. ShellCheck, support for Python shells, and Actions
expression checks are retained.

## Fix results

The 717-case audit originally found 124 differences: 120 now match the baseline,
while four retain separate expectations under the established stricter-validation
policy. Both backends previously had the same 124 differences; after the fixes,
both pass validation against the port's expectations. An additional 259 boundary
cases cover positive and negative examples for the root causes below, with regular
expectations captured from the independently built baseline.

| Root cause | Fixes and related boundary cases |
| --- | --- |
| Matrix casing | Uses consistent case rules for include/exclude in parsing, type inference, runner checks, and matching. Nested object keys match case-insensitively, while diagnostics preserve the original spelling. Covers mixed casing, invalid collections, object mismatches, and expressions. |
| Array type merging | Preserves the baseline's short-circuit result for unknown elements; clears the filtered state when merging arrays with known element types. Covers unknown elements on either side, ordinary/filtered arrays, and logical AND/OR. |
| Event inputs | Merges types of inputs with the same name in workflow_dispatch/workflow_call regardless of event declaration order; github.event.inputs retains string types. Covers event order and matching/differing types. |
| Expressions and structure | Detects expressions using the baseline's first opener/closer rule; IDs with unclosed expressions cannot bypass validation. Records keys and values actually retained by parsing and traverses them according to field access rules; checks only if for snapshots. Covers rejected fields, non-scalar if values, empty outputs, type wording, and Unicode/control-character quoting. |
| Metadata/configuration | Checks duplicate keys at the actual decoding level, including pairwise diagnostics and original positions for keys repeated three times; distinguishes duplicate YAML keys from input/output name collisions. Reusable workflow name mappings use the last declaration. Values of unknown configuration fields are not decoded further. |
| CRON | Splits fields using Go's Unicode whitespace set. Covers TAB, CR, vertical tab, NEL, NBSP, Unicode spaces, and non-whitespace counterexamples. |
| Multi-file CLI | Collects all lint results before emitting diagnostics; fatal read, configuration, or lint failures suppress earlier diagnostics. Template execution failures preserve partial output. Single-file processing retains the diagnostic exit code; multi-file processing reports the execution error and returns 3. |
| Template formatting | Covers argument indexes, dynamic width/precision, BADINDEX/BADWIDTH/BADPREC, hexadecimal strings, character/raw-string quoting, base prefixes, known diagnostic structs, and reference equality. |
| Floating-point formatting | Constructs exact decimal values from the binary mantissa/exponent, rounds to even, and formats f/F/e/E/g/G; the default shortest form reuses the core Ryu digits. Covers halfway values, negative zero, carries, subnormals, the largest finite value, high precision, and the # form. Porting notes and BSD license notices are retained in the source and THIRD_PARTY_NOTICES. |
| Template functions | Aligns index/slice type and execution errors, byte semantics for replace with an empty search string, and multi-argument formatting and escaping for html/js/urlquery. Template output preserves raw bytes; slices that split UTF-8 characters and empty-string replacement in Chinese text are also compared byte for byte. |
| Related YAML boundaries | Rejects invalid raw control characters within the project and supports Unicode line breaks in plain nodes; these cases are not attributed to upstream limitations. |

## Permanent regression coverage

| Case collection | Count | Validation method |
| --- | ---: | --- |
| behavior_cases.json | 160 | Complete output and exit codes |
| audit_cases.json | 320 | Complete output for 318 cases; log events, filenames, and statistics for two cases |
| boundary_cases.json | 135 | Complete output and exit codes |
| review_cases.json | 717 | Complete output and exit codes; all audit inputs preserved |
| review_boundary_cases.json | 259 | Complete output and exit codes; added root-cause boundary cases |
| pyflakes_removal_cases.json | 11 | Single/double dashes, empty values, assigned values, standalone arguments, and help text; both expectation sets checked separately |
| Total | 1602 | Upstream expectations checked against the independently built baseline |

`scripts/test_behavior.py` runs all scenarios, checking isolated temporary projects
concurrently while preserving case order in the results. Only temporary project
paths are normalized to `$PROJECT`; non-UTF-8 output is stored losslessly as bytes
in `{"hex": "..."}` form. Boundary cases involving Go pointer addresses observe
results through len/reference comparisons, avoiding random addresses in fixed
expectations.

## Intentional differences

The existing 24 stricter-validation differences (23 behavior regressions and one
fixture) and their original reasons remain valid:

- workflow_call input/secret required fields: the port checks expression semantics
  and Bool/Any types; the baseline does not traverse these fields.
- Expressions for an entire matrix include value or individual entries: the port
  validates array and object element types, applying the same rules to all casing
  variants.
- Local reusable workflow references: @ref is prohibited, including the boundary
  case where @ is the first character of the path.

An additional 29 scenarios record Pyflakes removal:

- Ten existing Pyflakes behavior inputs and upstream expectations are preserved;
  the port's expectations now require unknown-argument errors.
- Two existing help scenarios and two verbose/debug scenarios retain upstream
  expectations. The port removes the argument help and Pyflakes logs, with added
  assertions requiring Pyflakes to be absent from logs.
- Eleven new argument and help scenarios cover standalone, empty-value,
  assigned-value, and separate-argument forms of `-pyflakes` / `--pyflakes`,
  comparing complete output and exit codes.
- Four upstream workflow fixtures that originally produced Pyflakes diagnostics
  retain both empty diagnostic expectations for the port and the upstream
  diagnostics.

There are 53 recorded scenarios in total: 48 behavior regressions and five
fixtures. Each stores the port's `expected`, the upstream `baseline_expected`,
and a specific `difference_reason`. Both expectation sets for fixtures are stored
in fixture_differences.json; all upstream inputs and .out files remain unchanged.

## Dependency limitations

No unresolved dependency limitations remain from this round. Compatibility fixes
for all identified reproducible differences were implemented within the project.
No dependency-limitation cases or silent skips were added, and regular expectations
for the port were not updated merely to eliminate failures.

## Validation and reproduction

```sh
(cd baseline && go build -o /tmp/actionlint-implementation-reference ./cmd/actionlint)
make check test cli-test
python3 scripts/test_behavior.py --target all --reference /tmp/actionlint-implementation-reference
python3 scripts/test_cli.py --release --reference /tmp/actionlint-implementation-reference
python3 scripts/test_cli.py --target wasm --release --reference /tmp/actionlint-implementation-reference
moon info && moon fmt
```

Targeted tests cover exact rounding, byte output, struct reference equality, and
array merging. CLI regressions retain ShellCheck commands with arguments,
diagnostics, and 150 KB standard input. Existing Pyflakes command scenarios now
expect argument errors; the reference program still executes the legacy commands
and checks the original diagnostics.
A mock Pyflakes executable on PATH writes an invocation marker. After verifying
that the marker works, tests check `python` and `python {0}` shells at the step,
job, and workflow levels in normal, verbose, and debug modes, with and without
Actions expression errors: 36 scenarios in total. None invoke Pyflakes, and
expression errors are still detected. `allKinds` and SARIF exclude Pyflakes with
ShellCheck both enabled and disabled; version output identifies the difference.
All five original Python workflow fixtures run, without skipping or requiring
installation when Pyflakes is missing. Fixtures that depend on ShellCheck retain
their existing availability checks.

| Validation | native | wasm |
| --- | ---: | ---: |
| moon check | Pass | Pass |
| MoonBit unit and fixture tests | 38 / 38 | 38 / 38 |
| Workflow fixtures | 230 / 230, none skipped | 230 / 230, none skipped |
| Project fixtures | 30 / 30 | 30 / 30 |
| 1602 behavior regressions | 1602 / 1602 | 1602 / 1602 |
| 136 CLI comparisons | 136 / 136 | 136 / 136 |
| Release builds | Pass | Pass |

Machine-readable reports: _build/behavior-report.json,
_build/cli-{native,wasm}.json, _build/compatibility-{native,wasm}.json,
and _build/projects-{native,wasm}.json.
Deliverables: bin/actionlint and bin/actionlint.wasm.
The generated interfaces for the root package and CLI are unchanged. In the
internal workflow package, `lint_source` no longer takes a Pyflakes argument,
and the `checker_names` tuple is replaced by the `shellcheck_name` string;
other generated interfaces are unchanged.

Compatibility is limited to verified syntax and related scenarios; no equivalence
is claimed for full Go reflection, arbitrary fmt behavior, or timezone schedulers.
Actual verbose/debug timings, implementation details, and Go pointer addresses
are not emulated.

The independently built baseline passed 1602 / 1602 checks. All 1600 scenarios
that compare complete output match the port's expectations on both backends;
the upstream binary matches the independent upstream expectations. Intentional
differences match their respective expectations.
The two original verbose/debug scenarios differ in actual timings and
implementation logs, but pass checks for events, filenames, statistics, and exit
codes. The port's output is additionally checked for the absence of Pyflakes
logs. Machine-readable reports retain raw logs without additional normalization.

| Release artifact / reference implementation | SHA-256 |
| --- | --- |
| native | `6cb1b7f91000c6bdfb9bcd08cf9b64aa57ab071805f551ed67f0cb144032864e` |
| wasm | `e0852220e86d9d55b3209d42d8fd68bd5eb093c2a1944d292aca01bf4be470fb` |
| reference | `f3522e80fbb7b54c9a09b08a52b6ad604fdc5f0f0c79d179c6be84612c4e16f7` |
