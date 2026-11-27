# Audit regressions

320 migrated cases. Inputs are in [fixtures/audit.json](fixtures/audit.json).
Each case asserts stdout, stderr, and exit status; only elapsed milliseconds vary.

## audit:expr:True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 0 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: undefined variable "True". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:expr:TRUE

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 1 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: undefined variable "TRUE". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:expr:Null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 2 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: undefined variable "Null". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:expr:NULL

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 3 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: undefined variable "NULL". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:expr:False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 4 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: undefined variable "False". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:expr:! github

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 5 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:expr:github[true]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 6 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: property access of object must be type of string but got "bool" [expression]
@STDERR (empty)
[1]
```

## audit:expr:github[no_such]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 7 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:expr:no_such[github.foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 8 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
<stdin>:7:27: property "foo" is not defined in object type {action: string; action_path: string; action_ref: string; action_repository: string; action_status: string; actor: string; actor_id: string; api_url: string; artifact_cache_size_limit: number; base_ref: string; env: string; event: object; event_name: string; event_path: string; graphql_url: string; head_ref: string; job: string; output: string; path: string; ref: string; ref_name: string; ref_protected: bool; ref_type: string; repository: string; repository_id: string; repository_owner: string; repository_owner_id: string; repository_visibility: string; repositoryurl: string; retention_days: number; run_attempt: string; run_id: string; run_number: string; secret_source: string; server_url: string; sha: string; state: string; step_summary: string; token: string; triggering_actor: string; workflow: string; workflow_ref: string; workflow_sha: string; workspace: string} [expression]
@STDERR (empty)
[1]
```

## audit:expr:fromJSON('{"a":1}').*

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 9 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: object type "{a: number}" cannot be filtered by object filtering `.*` since it has no object element [expression]
@STDERR (empty)
[1]
```

## audit:expr:fromJSON('[{}]').*.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 10 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: property "foo" is not defined in object type {} as element of filtered array [expression]
@STDERR (empty)
[1]
```

## audit:expr:fromJSON('[null, 1]')[0].foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 11 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:expr:fromJSON('[{},1]')[0].foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 12 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:expr:fromJSON('[true,1]')[0].foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 13 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:expr:fromJSON('[null,1]') == fromJSON('[1]')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 14 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:expr:foo @

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 15 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:23: got unexpected character '@' while lexing expression, expecting 'a'..'z', 'A'..'Z', '_', '0'..'9', ''', '}', '(', ')', '[', ']', '.', '!', '<', '>', '=', '&', '|', '*', ',', ' ' [expression]
@STDERR (empty)
[1]
```

## audit:expr:github. @

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 16 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:27: got unexpected character '@' while lexing expression, expecting 'a'..'z', 'A'..'Z', '_', '0'..'9', ''', '}', '(', ')', '[', ']', '.', '!', '<', '>', '=', '&', '|', '*', ',', ' ' [expression]
@STDERR (empty)
[1]
```

## audit:expr:contains(, @

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 17 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: unexpected token "," while parsing variable access, function call, null, bool, int, float or string. expecting "IDENT", "(", "INTEGER", "FLOAT", "STRING" [expression]
@STDERR (empty)
[1]
```

## audit:expr:1 2 @

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 18 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:21: parser did not reach end of input after parsing the expression. 1 remaining token(s) in the input: "INTEGER" [expression]
@STDERR (empty)
[1]
```

## audit:expr:1e-999

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 19 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:expr:1e999

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 20 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: parsing invalid float literal "1e999": strconv.ParseFloat: parsing "1e999": value out of range [expression]
@STDERR (empty)
[1]
```

## audit:expr:-0x00

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 21 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:23: got unexpected character '0' while lexing character following hex integer -0x0, expecting ''', '}', '(', ')', '[', ']', '.', '!', '<', '>', '=', '&', '|', '*', ',', ' ' [expression]
@STDERR (empty)
[1]
```

## audit:expr:format('x',1,2)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 22 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: format string "x" does not contain placeholder {0}. remove argument which is unused in the format string [expression]
<stdin>:7:19: format string "x" does not contain placeholder {1}. remove argument which is unused in the format string [expression]
@STDERR (empty)
[1]
```

## audit:expr:case(true, 1, false, 2, null)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 23 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:expr:vars['GITHUB_X']

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 24 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:expr:vars['bad-name']

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 25 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:if:contains()

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 26 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: constant expression "contains()" in condition. remove the if: section [if-cond]
<stdin>:7:13: number of arguments is wrong. function "contains(array<any>, any) -> bool" takes 2 parameters but 0 arguments are given [expression]
<stdin>:7:13: number of arguments is wrong. function "contains(string, string) -> bool" takes 2 parameters but 0 arguments are given [expression]
@STDERR (empty)
[1]
```

## audit:if:fromJSON('bad')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 27 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:22: broken JSON string is passed to fromJSON() at offset 1: invalid character 'b' looking for beginning of value [expression]
@STDERR (empty)
[1]
```

## audit:if:contains('x', null)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 28 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: constant expression "contains('x', null)" in condition. remove the if: section [if-cond]
<stdin>:7:22: 1st argument of function call is not assignable. "string" cannot be assigned to "array<any>". called function type is "contains(array<any>, any) -> bool" [expression]
<stdin>:7:27: 2nd argument of function call is not assignable. "null" cannot be assigned to "string". called function type is "contains(string, string) -> bool" [expression]
@STDERR (empty)
[1]
```

## audit:if:contains('x', true)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 29 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: constant expression "contains('x', true)" in condition. remove the if: section [if-cond]
<stdin>:7:22: 1st argument of function call is not assignable. "string" cannot be assigned to "array<any>". called function type is "contains(array<any>, any) -> bool" [expression]
<stdin>:7:27: 2nd argument of function call is not assignable. "bool" cannot be assigned to "string". called function type is "contains(string, string) -> bool" [expression]
@STDERR (empty)
[1]
```

## audit:if:format('x',1)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 30 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: constant expression "format('x',1)" in condition. remove the if: section [if-cond]
<stdin>:7:13: format string "x" does not contain placeholder {0}. remove argument which is unused in the format string [expression]
@STDERR (empty)
[1]
```

## audit:if:unknown('x')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 31 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: undefined function "unknown". available functions are "always", "cancelled", "case", "contains", "endswith", "failure", "format", "fromjson", "hashfiles", "join", "startswith", "success", "tojson" [expression]
@STDERR (empty)
[1]
```

## audit:matrix:32

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 32 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:matrix:33

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 33 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:matrix:34

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 34 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:11:19: property "foo" is not defined in object type {x: number; y: number} [expression]
@STDERR (empty)
[1]
```

## audit:matrix:35

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 35 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:matrix:36

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 36 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:matrix:37

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 37 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:matrix:38

Expressions in include entries must be checked for semantic errors and object types; the baseline incorrectly refers to the expression for the entire include value and skips entry checks. Invalid entries preserve known rows and allow unknown properties.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 38 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:17: context "matrix" is not allowed here. available contexts are "github", "inputs", "needs", "vars". see https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability for more details [expression]
<stdin>:9:17: property "foo" is not defined in object type {} [expression]
@STDERR (empty)
[1]
```

## audit:matrix:39

Expressions in include entries must be checked for semantic errors and object types; the baseline incorrectly refers to the expression for the entire include value and skips entry checks. Invalid entries preserve known rows and allow unknown properties.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 39 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:17: context "matrix" is not allowed here. available contexts are "github", "inputs", "needs", "vars". see https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability for more details [expression]
<stdin>:9:17: property "foo" is not defined in object type {} [expression]
@STDERR (empty)
[1]
```

## audit:matrix:40

Expressions in include entries must be checked for semantic errors and object types; the baseline incorrectly refers to the expression for the entire include value and skips entry checks. Invalid entries preserve known rows and allow unknown properties.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 40 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:17: context "matrix" is not allowed here. available contexts are "github", "inputs", "needs", "vars". see https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability for more details [expression]
<stdin>:9:17: property "foo" is not defined in object type {} [expression]
@STDERR (empty)
[1]
```

## audit:matrix:41

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 41 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:matrix:42

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 42 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:matrix:43

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 43 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:12:19: property "foo" is not defined in object type {x: number; y: string} [expression]
@STDERR (empty)
[1]
```

## audit:matrix:44

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 44 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: element in "include" section should not be empty. please remove this section if it's unnecessary [syntax-check]
<stdin>:8:20: "x" in "exclude" section does not exist in matrix. available matrix configurations are  [matrix]
<stdin>:11:19: property "x" is not defined in object type {} [expression]
@STDERR (empty)
[1]
```

## audit:matrix:45

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 45 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: element in "include" section should not be empty. please remove this section if it's unnecessary [syntax-check]
<stdin>:8:20: "x" in "exclude" section does not exist in matrix. available matrix configurations are  [matrix]
<stdin>:11:19: property "y" is not defined in object type {} [expression]
@STDERR (empty)
[1]
```

## audit:matrix:46

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 46 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: element in "include" section should not be empty. please remove this section if it's unnecessary [syntax-check]
<stdin>:8:20: "x" in "exclude" section does not exist in matrix. available matrix configurations are  [matrix]
<stdin>:11:19: property "foo" is not defined in object type {} [expression]
@STDERR (empty)
[1]
```

## audit:timeout:.nan

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 47 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: invalid float value: ".nan": strconv.ParseFloat: parsing ".nan": invalid syntax [syntax-check]
@STDERR (empty)
[1]
```

## audit:timeout:.NaN

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 48 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: invalid float value: ".NaN": strconv.ParseFloat: parsing ".NaN": invalid syntax [syntax-check]
@STDERR (empty)
[1]
```

## audit:timeout:.inf

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 49 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: invalid float value: ".inf": strconv.ParseFloat: parsing ".inf": invalid syntax [syntax-check]
@STDERR (empty)
[1]
```

## audit:timeout:-.inf

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 50 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: invalid float value: "-.inf": strconv.ParseFloat: parsing "-.inf": invalid syntax [syntax-check]
@STDERR (empty)
[1]
```

## audit:timeout:+.inf

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 51 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: invalid float value: "+.inf": strconv.ParseFloat: parsing "+.inf": invalid syntax [syntax-check]
@STDERR (empty)
[1]
```

## audit:timeout:012

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 52 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:timeout:0o12

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 53 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: invalid float value: "0o12": strconv.ParseFloat: parsing "0o12": invalid syntax [syntax-check]
@STDERR (empty)
[1]
```

## audit:timeout:0b10

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 54 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: invalid float value: "0b10": strconv.ParseFloat: parsing "0b10": invalid syntax [syntax-check]
@STDERR (empty)
[1]
```

## audit:timeout:1_000

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 55 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:timeout:1e3

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 56 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:timeout:1E+3

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 57 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:timeout:1e-999

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 58 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: value at "timeout-minutes" must be greater than zero: 0 [syntax-check]
@STDERR (empty)
[1]
```

## audit:timeout:1e999

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 59 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: expecting a single ${{...}} expression or float number literal, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## audit:timeout:0x1p2

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 60 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: expecting a single ${{...}} expression or float number literal, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## audit:timeout:0x1.2p3

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 61 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: expecting a single ${{...}} expression or float number literal, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## audit:timeout:2026-01-01

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 62 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: expected scalar node for float value but found scalar node with "!!timestamp" tag [syntax-check]
@STDERR (empty)
[1]
```

## audit:matrixval:[true, false]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 63 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:10:19: receiver of object dereference "foo" must be type of object but got "bool" [expression]
@STDERR (empty)
[1]
```

## audit:matrixval:["true", "false"]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 64 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:10:19: receiver of object dereference "foo" must be type of object but got "bool" [expression]
@STDERR (empty)
[1]
```

## audit:matrixval:[null, ~]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 65 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:matrixval:[1, "1"]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 66 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:16: duplicate value "1" is found in matrix "x". the same value is at line:7,col:13 [matrix]
<stdin>:10:19: receiver of object dereference "foo" must be type of object but got "number" [expression]
@STDERR (empty)
[1]
```

## audit:matrixval:[01, 1]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 67 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:10:19: receiver of object dereference "foo" must be type of object but got "number" [expression]
@STDERR (empty)
[1]
```

## audit:matrixval:[1e3, 1000]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 68 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:10:19: receiver of object dereference "foo" must be type of object but got "number" [expression]
@STDERR (empty)
[1]
```

## audit:matrixval:[.nan, .nan]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 69 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:19: duplicate value ".nan" is found in matrix "x". the same value is at line:7,col:13 [matrix]
<stdin>:10:19: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## audit:matrixval:["", null]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 70 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:matrixval:[0x10]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 71 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:10:19: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## audit:uppercase:on

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 72 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:1: "on" section is missing in workflow [syntax-check]
<stdin>:1:1: unexpected key "ON" for "workflow" section. expected one of "concurrency", "defaults", "env", "jobs", "name", "on", "permissions", "run-name" [syntax-check]
<stdin>:3:3: "runs-on" section is missing in job "test" [syntax-check]
<stdin>:4:5: unexpected key "runs-ON" for "job" section. expected one of "concurrency", "container", "continue-on-error", "defaults", "env", "environment", "if", "name", "needs", "outputs", "permissions", "runs-on", "secrets", "services", "snapshot", "steps", "strategy", "timeout-minutes", "uses", "with" [syntax-check]
@STDERR (empty)
[1]
```

## audit:uppercase:jobs

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 73 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:1: "jobs" section is missing in workflow [syntax-check]
<stdin>:2:1: unexpected key "JOBS" for "workflow" section. expected one of "concurrency", "defaults", "env", "jobs", "name", "on", "permissions", "run-name" [syntax-check]
@STDERR (empty)
[1]
```

## audit:uppercase:name

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 74 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:uppercase:permissions

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 75 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:uppercase:env

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 76 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:uppercase:defaults

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 77 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:uppercase:concurrency

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 78 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:uppercase:run-name

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 79 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:yaml-tail:'---\nfoo: ['

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 80 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:yaml-tail:'---\non: push\n'

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 81 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:yaml-tail:'...\nfoo: bar\n'

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 82 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:yaml-tail:'...\n---\non: push\n'

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 83 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:yaml-tail:'\tbad: thing\n'

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 84 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:13: could not parse as YAML: found a tab character that violates indentation [syntax-check]
@STDERR (empty)
[1]
```

## audit:tag:name:!custom foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 85 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:tag:name:!!int "bad"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 86 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:tag:name:!!bool "bad"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 87 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:tag:name:!!float "bad"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 88 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:tag:name:! foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 89 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:tag:name:!!null x

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 90 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:tag:env:!custom foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 91 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:6: expecting a single ${{...}} expression or mapping value for "env" section, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## audit:tag:env:!!int "bad"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 92 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:6: expecting a single ${{...}} expression or mapping value for "env" section, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## audit:tag:env:!!bool "bad"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 93 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:6: expecting a single ${{...}} expression or mapping value for "env" section, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## audit:tag:env:!!float "bad"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 94 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:6: expecting a single ${{...}} expression or mapping value for "env" section, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## audit:tag:env:! foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 95 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:6: expecting a single ${{...}} expression or mapping value for "env" section, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## audit:tag:env:!!null x

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 96 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:6: expecting a single ${{...}} expression or mapping value for "env" section, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## audit:tag:permissions:!custom foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 97 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:14: "foo" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
@STDERR (empty)
[1]
```

## audit:tag:permissions:!!int "bad"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 98 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:14: "bad" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
@STDERR (empty)
[1]
```

## audit:tag:permissions:!!bool "bad"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 99 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:14: "bad" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
@STDERR (empty)
[1]
```

## audit:tag:permissions:!!float "bad"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 100 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:14: "bad" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
@STDERR (empty)
[1]
```

## audit:tag:permissions:! foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 101 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:14: "foo" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
@STDERR (empty)
[1]
```

## audit:tag:permissions:!!null x

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 102 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:14: "x" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
@STDERR (empty)
[1]
```

## audit:tag:jobs:!custom foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 103 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:6: could not parse as YAML: mapping values are not allowed in this context [syntax-check]
@STDERR (empty)
[1]
```

## audit:tag:jobs:!!int "bad"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 104 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:2:2: could not parse as YAML: did not find expected key [syntax-check]
@STDERR (empty)
[1]
```

## audit:tag:jobs:!!bool "bad"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 105 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:2:2: could not parse as YAML: did not find expected key [syntax-check]
@STDERR (empty)
[1]
```

## audit:tag:jobs:!!float "bad"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 106 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:2:2: could not parse as YAML: did not find expected key [syntax-check]
@STDERR (empty)
[1]
```

## audit:tag:jobs:! foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 107 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:6: could not parse as YAML: mapping values are not allowed in this context [syntax-check]
@STDERR (empty)
[1]
```

## audit:tag:jobs:!!null x

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 108 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:6: could not parse as YAML: mapping values are not allowed in this context [syntax-check]
@STDERR (empty)
[1]
```

## audit:tag:on:!custom foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 109 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:5: unknown Webhook event "foo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
@STDERR (empty)
[1]
```

## audit:tag:on:!!int "bad"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 110 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:5: unknown Webhook event "bad". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
@STDERR (empty)
[1]
```

## audit:tag:on:!!bool "bad"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 111 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:5: unknown Webhook event "bad". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
@STDERR (empty)
[1]
```

## audit:tag:on:!!float "bad"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 112 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:5: unknown Webhook event "bad". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
@STDERR (empty)
[1]
```

## audit:tag:on:! foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 113 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:5: unknown Webhook event "foo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
@STDERR (empty)
[1]
```

## audit:tag:on:!!null x

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 114 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:5: unknown Webhook event "x". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
@STDERR (empty)
[1]
```

## audit:alias:115

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 115 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:alias:116

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 116 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:config:config-variables:[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 117
@STDOUT (empty)
@STDERR (empty)
```

## audit:config:config-variables:{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 118
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!map into []string
[3]
```

## audit:config:config-variables:1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 119
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!int `1` into []string
[3]
```

## audit:config:config-variables:yes

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 120
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!str `yes` into []string
[3]
```

## audit:config:config-variables:null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 121
@STDOUT (empty)
@STDERR (empty)
```

## audit:config:config-variables:{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 122
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!map into []string
[3]
```

## audit:config:config-variables:[{}, null]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 123
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!map into string
[3]
```

## audit:config:self-hosted-runner:[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 124
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!seq into struct { Labels []string "yaml:\"labels\"" }
[3]
```

## audit:config:self-hosted-runner:{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 125
@STDOUT (empty)
@STDERR (empty)
```

## audit:config:self-hosted-runner:1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 126
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!int `1` into struct { Labels []string "yaml:\"labels\"" }
[3]
```

## audit:config:self-hosted-runner:yes

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 127
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!str `yes` into struct { Labels []string "yaml:\"labels\"" }
[3]
```

## audit:config:self-hosted-runner:null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 128
@STDOUT (empty)
@STDERR (empty)
```

## audit:config:self-hosted-runner:{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 129
@STDOUT (empty)
@STDERR (empty)
```

## audit:config:self-hosted-runner:[{}, null]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 130
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!seq into struct { Labels []string "yaml:\"labels\"" }
[3]
```

## audit:config:paths:[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 131
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!seq into map[string]actionlint.PathConfig
[3]
```

## audit:config:paths:{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 132
@STDOUT (empty)
@STDERR (empty)
```

## audit:config:paths:1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 133
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!int `1` into map[string]actionlint.PathConfig
[3]
```

## audit:config:paths:yes

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 134
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!str `yes` into map[string]actionlint.PathConfig
[3]
```

## audit:config:paths:null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 135
@STDOUT (empty)
@STDERR (empty)
```

## audit:config:paths:{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 136
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!str `bar` into actionlint.PathConfig
[3]
```

## audit:config:paths:[{}, null]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 137
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!seq into map[string]actionlint.PathConfig
[3]
```

## audit:configspecial:138

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 138
@STDOUT (empty)
@STDERR (empty)
```

## audit:configspecial:139

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 139
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": invalid glob pattern "[!]" in "paths"
[3]
```

## audit:configspecial:140

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 140
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": invalid glob pattern "[]" in "paths"
[3]
```

## audit:configspecial:141

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 141
@STDOUT (empty)
@STDERR (empty)
```

## audit:configspecial:142

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 142
@STDOUT (empty)
@STDERR (empty)
```

## audit:regex:(?i)label

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 143 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '(?i)label' -
@STDOUT (empty)
@STDERR (empty)
```

## audit:regex:(?s)label

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 144 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '(?s)label' -
@STDOUT (empty)
@STDERR (empty)
```

## audit:regex:(?m)label

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 145 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '(?m)label' -
@STDOUT (empty)
@STDERR (empty)
```

## audit:regex:\p{Greek}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 146 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '\p{Greek}' -
@STDOUT
<stdin>:4:14: label "foobar" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## audit:regex:[[:alpha:]]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 147 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '[[:alpha:]]' -
@STDOUT (empty)
@STDERR (empty)
```

## audit:regex:(?P<word>label)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 148 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '(?P<word>label)' -
@STDOUT (empty)
@STDERR (empty)
```

## audit:regex:(?<word>label)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 149 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '(?<word>label)' -
@STDOUT (empty)
@STDERR (empty)
```

## audit:regex:label(?=x)

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore 'label(?=x)' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "label(?=x)": error parsing regexp: invalid or unsupported Perl syntax: `(?=`
[3]
```

## audit:regex:(label)\1

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '(label)\1' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "(label)\\1": error parsing regexp: invalid escape sequence: `\1`
[3]
```

## audit:regex:a{01}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 152 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore 'a{01}' -
@STDOUT
<stdin>:4:14: label "foobar" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## audit:regex:(?U)a+

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 153 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '(?U)a+' -
@STDOUT (empty)
@STDERR (empty)
```

## audit:regex:[a-z&&b]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 154 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '[a-z&&b]' -
@STDOUT (empty)
@STDERR (empty)
```

## audit:regex:\z

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 155 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '\z' -
@STDOUT (empty)
@STDERR (empty)
```

## audit:regex:[

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '[' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "[": error parsing regexp: missing closing ]: `[`
[3]
```

## audit:regex:\C

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '\C' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "\\C": error parsing regexp: invalid escape sequence: `\C`
[3]
```

## audit:template:{{len "中文"}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 158 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{len "中文"}}' -
@STDOUT
6 (no-eol)
@STDERR (empty)
[1]
```

## audit:template:{{slice "中文" 0 3}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 159 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{slice "中文" 0 3}}' -
@STDOUT
中 (no-eol)
@STDERR (empty)
[1]
```

## audit:template:{{printf "%T" .}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 160 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%T" .}}' -
@STDOUT
[]*actionlint.ErrorTemplateFields (no-eol)
@STDERR (empty)
[1]
```

## audit:template:{{printf "%#x" 12}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 161 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%#x" 12}}' -
@STDOUT
0xc (no-eol)
@STDERR (empty)
[1]
```

## audit:template:{{printf "%d" "x"}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 162 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%d" "x"}}' -
@STDOUT
%!d(string=x) (no-eol)
@STDERR (empty)
[1]
```

## audit:template:{{printf "%s"}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 163 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%s"}}' -
@STDOUT
%!s(MISSING) (no-eol)
@STDERR (empty)
[1]
```

## audit:template:{{printf "%s" "a" "b"}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 164 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%s" "a" "b"}}' -
@STDOUT
a%!(EXTRA string=b) (no-eol)
@STDERR (empty)
[1]
```

## audit:template:{{eq 1 "1"}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 165 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{eq 1 "1"}}' -
@STDOUT (empty)
@STDERR (empty)
[1]
```

## audit:template:{{eq true 1}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 166 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{eq true 1}}' -
@STDOUT (empty)
@STDERR (empty)
[1]
```

## audit:template:{{and false (index . 99)}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 167 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{and false (index . 99)}}' -
@STDOUT
false (no-eol)
@STDERR (empty)
[1]
```

## audit:template:{{or true (index . 99)}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 168 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{or true (index . 99)}}' -
@STDOUT
true (no-eol)
@STDERR (empty)
[1]
```

## audit:template:{{range .}}{{$x := .Message}}{{end}}{{$x}}

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{range .}}{{$x := .Message}}{{end}}{{$x}}' -
@STDOUT (empty)
@STDERR
template "{{range .}}{{$x := .Message}}{{end}}{{$x}}" to format error messages could not be parsed: template: error formatter:1: undefined variable "$x"
[3]
```

## audit:template:{{if false}}{{$x := "a"}}{{end}}{{$x}}

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{if false}}{{$x := "a"}}{{end}}{{$x}}' -
@STDOUT (empty)
@STDERR
template "{{if false}}{{$x := \"a\"}}{{end}}{{$x}}" to format error messages could not be parsed: template: error formatter:1: undefined variable "$x"
[3]
```

## audit:template:{{with .}}{{$.foo}}{{end}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 171 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{with .}}{{$.foo}}{{end}}' -
@STDOUT (empty)
@STDERR (empty)
[1]
```

## audit:template:{{range .}}{{.Unknown}}{{else}}empty{{end}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 172 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{range .}}{{.Unknown}}{{else}}empty{{end}}' -
@STDOUT (empty)
@STDERR (empty)
[1]
```

## audit:template:{{range .}}{{.Message}}{{end}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 173 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{range .}}{{.Message}}{{end}}' -
@STDOUT
undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" (no-eol)
@STDERR (empty)
[1]
```

## audit:bool:step:1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 174 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: type of expression must be bool but found type number [expression]
@STDERR (empty)
[1]
```

## audit:bool:job:1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 175 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:24: type of expression must be bool but found type number [expression]
@STDERR (empty)
[1]
```

## audit:bool:strategy:1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 176 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression must be bool but found type number [expression]
@STDERR (empty)
[1]
```

## audit:bool:job-concurrency:1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 177 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:27: type of expression must be bool but found type number [expression]
@STDERR (empty)
[1]
```

## audit:bool:workflow-concurrency:1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 178 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:23: type of expression must be bool but found type number [expression]
@STDERR (empty)
[1]
```

## audit:bool:environment:1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 179 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:19: type of expression must be bool but found type number [expression]
@STDERR (empty)
[1]
```

## audit:bool:dispatch-required:1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 180 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: type of expression must be bool but found type number [expression]
@STDERR (empty)
[1]
```

## audit:bool:call-required:1

workflow_call.required must be checked for expression semantics and accept only bool/Any; the baseline does not traverse this field.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 181 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: type of expression must be bool but found type number [expression]
@STDERR (empty)
[1]
```

## audit:bool:step:'false'

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 182 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: type of expression must be bool but found type string [expression]
@STDERR (empty)
[1]
```

## audit:bool:job:'false'

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 183 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:24: type of expression must be bool but found type string [expression]
@STDERR (empty)
[1]
```

## audit:bool:strategy:'false'

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 184 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression must be bool but found type string [expression]
@STDERR (empty)
[1]
```

## audit:bool:job-concurrency:'false'

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 185 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:27: type of expression must be bool but found type string [expression]
@STDERR (empty)
[1]
```

## audit:bool:workflow-concurrency:'false'

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 186 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:23: type of expression must be bool but found type string [expression]
@STDERR (empty)
[1]
```

## audit:bool:environment:'false'

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 187 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:19: type of expression must be bool but found type string [expression]
@STDERR (empty)
[1]
```

## audit:bool:dispatch-required:'false'

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 188 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: type of expression must be bool but found type string [expression]
@STDERR (empty)
[1]
```

## audit:bool:call-required:'false'

workflow_call.required must be checked for expression semantics and accept only bool/Any; the baseline does not traverse this field.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 189 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: type of expression must be bool but found type string [expression]
@STDERR (empty)
[1]
```

## audit:bool:step:null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 190 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: type of expression must be bool but found type null [expression]
@STDERR (empty)
[1]
```

## audit:bool:job:null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 191 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:24: type of expression must be bool but found type null [expression]
@STDERR (empty)
[1]
```

## audit:bool:strategy:null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 192 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression must be bool but found type null [expression]
@STDERR (empty)
[1]
```

## audit:bool:job-concurrency:null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 193 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:27: type of expression must be bool but found type null [expression]
@STDERR (empty)
[1]
```

## audit:bool:workflow-concurrency:null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 194 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:23: type of expression must be bool but found type null [expression]
@STDERR (empty)
[1]
```

## audit:bool:environment:null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 195 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:19: type of expression must be bool but found type null [expression]
@STDERR (empty)
[1]
```

## audit:bool:dispatch-required:null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 196 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: type of expression must be bool but found type null [expression]
@STDERR (empty)
[1]
```

## audit:bool:call-required:null

workflow_call.required must be checked for expression semantics and accept only bool/Any; the baseline does not traverse this field.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 197 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: type of expression must be bool but found type null [expression]
@STDERR (empty)
[1]
```

## audit:bool:step:fromJSON('{}')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 198 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: type of expression must be bool but found type {} [expression]
@STDERR (empty)
[1]
```

## audit:bool:job:fromJSON('{}')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 199 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:24: type of expression must be bool but found type {} [expression]
@STDERR (empty)
[1]
```

## audit:bool:strategy:fromJSON('{}')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 200 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression must be bool but found type {} [expression]
@STDERR (empty)
[1]
```

## audit:bool:job-concurrency:fromJSON('{}')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 201 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:27: type of expression must be bool but found type {} [expression]
@STDERR (empty)
[1]
```

## audit:bool:workflow-concurrency:fromJSON('{}')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 202 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:23: type of expression must be bool but found type {} [expression]
@STDERR (empty)
[1]
```

## audit:bool:environment:fromJSON('{}')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 203 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:19: type of expression must be bool but found type {} [expression]
@STDERR (empty)
[1]
```

## audit:bool:dispatch-required:fromJSON('{}')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 204 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: type of expression must be bool but found type {} [expression]
@STDERR (empty)
[1]
```

## audit:bool:call-required:fromJSON('{}')

workflow_call.required must be checked for expression semantics and accept only bool/Any; the baseline does not traverse this field.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 205 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: type of expression must be bool but found type {} [expression]
@STDERR (empty)
[1]
```

## audit:bool:step:fromJSON('[]')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 206 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: type of expression must be bool but found type array<any> [expression]
@STDERR (empty)
[1]
```

## audit:bool:job:fromJSON('[]')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 207 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:24: type of expression must be bool but found type array<any> [expression]
@STDERR (empty)
[1]
```

## audit:bool:strategy:fromJSON('[]')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 208 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression must be bool but found type array<any> [expression]
@STDERR (empty)
[1]
```

## audit:bool:job-concurrency:fromJSON('[]')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 209 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:27: type of expression must be bool but found type array<any> [expression]
@STDERR (empty)
[1]
```

## audit:bool:workflow-concurrency:fromJSON('[]')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 210 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:23: type of expression must be bool but found type array<any> [expression]
@STDERR (empty)
[1]
```

## audit:bool:environment:fromJSON('[]')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 211 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:19: type of expression must be bool but found type array<any> [expression]
@STDERR (empty)
[1]
```

## audit:bool:dispatch-required:fromJSON('[]')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 212 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: type of expression must be bool but found type array<any> [expression]
@STDERR (empty)
[1]
```

## audit:bool:call-required:fromJSON('[]')

workflow_call.required must be checked for expression semantics and accept only bool/Any; the baseline does not traverse this field.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 213 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: type of expression must be bool but found type array<any> [expression]
@STDERR (empty)
[1]
```

## audit:matrix-section:include:${{ github.run_id }}

An expression for the entire include value must produce an array of objects; the baseline misses non-array values and non-object elements.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 214 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:10:18: type of expression at "include" must be array but found type string [expression]
@STDERR (empty)
[1]
```

## audit:matrix-section:exclude:${{ github.run_id }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 215 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:10:18: type of expression at "exclude" must be array but found type string [expression]
@STDERR (empty)
[1]
```

## audit:matrix-section:include:${{ no_such }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 216 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:10:22: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:matrix-section:exclude:${{ no_such }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 217 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:10:22: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:matrix-section:include:${{ fromJSON('[]') }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 218 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:matrix-section:exclude:${{ fromJSON('[]') }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 219 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:matrix-section:include:${{ fromJSON('[1]') }}

An expression for the entire include value must produce an array of objects; the baseline misses non-array values and non-object elements.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 220 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:10:18: type of expression at "include" must be object but found type number [expression]
@STDERR (empty)
[1]
```

## audit:matrix-section:exclude:${{ fromJSON('[1]') }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 221 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:10:18: type of expression at "exclude" must be object but found type number [expression]
@STDERR (empty)
[1]
```

## audit:matrix-section:include:${{ fromJSON('[{}]') }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 222 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:matrix-section:exclude:${{ fromJSON('[{}]') }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 223 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:call-required-default:true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 224 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:18: input "foo" of workflow_call event has the default value "hi", but it is also required. if an input is marked as required, its default value will never be used [events]
@STDERR (empty)
[1]
```

## audit:call-required-default:True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 225 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:call-required-default:TRUE

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 226 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:call-required-default:${{ true }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 227 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:input-number:workflow_call:0x10

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 228 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: input of workflow_call event "foo" is typed as number but its default value "0x10" cannot be parsed as a float number: strconv.ParseFloat: parsing "0x10": invalid syntax [events]
@STDERR (empty)
[1]
```

## audit:input-number:workflow_dispatch:0x10

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 229 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: type of "foo" input is "number" but its default value "0x10" cannot be parsed as a float number: strconv.ParseFloat: parsing "0x10": invalid syntax [events]
@STDERR (empty)
[1]
```

## audit:input-number:workflow_call:1e999

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 230 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: input of workflow_call event "foo" is typed as number but its default value "1e999" cannot be parsed as a float number: strconv.ParseFloat: parsing "1e999": value out of range [events]
@STDERR (empty)
[1]
```

## audit:input-number:workflow_dispatch:1e999

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 231 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: type of "foo" input is "number" but its default value "1e999" cannot be parsed as a float number: strconv.ParseFloat: parsing "1e999": value out of range [events]
@STDERR (empty)
[1]
```

## audit:input-number:workflow_call:1e-999

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 232 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:input-number:workflow_dispatch:1e-999

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 233 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:input-number:workflow_call:NaN

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 234 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:input-number:workflow_dispatch:NaN

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 235 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:input-number:workflow_call:Inf

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 236 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:input-number:workflow_dispatch:Inf

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 237 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:input-number:workflow_call:1_000

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 238 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:input-number:workflow_dispatch:1_000

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 239 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:call-secret-field:description

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 240 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:26: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:call-secret-field:required

workflow_call.required must be checked for expression semantics and accept only bool/Any; the baseline does not traverse this field.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 241 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:23: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:security:github.event.issue.title

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 242 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:23: "github.event.issue.title" is potentially untrusted. avoid using it directly in inline scripts. instead, pass it through an environment variable. see https://docs.github.com/en/actions/reference/security/secure-use#good-practices-for-mitigating-script-injection-attacks for more details [expression]
@STDERR (empty)
[1]
```

## audit:security:github.event.issue.title.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 243 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:security:github.event.issue.title[0]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 244 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:security:github.event.*.title

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 245 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:23: object filter extracts potentially untrusted properties "github.event.discussion.title", "github.event.issue.title", "github.event.pull_request.title". avoid using the value directly in inline scripts. instead, pass the value through an environment variable. see https://docs.github.com/en/actions/reference/security/secure-use#good-practices-for-mitigating-script-injection-attacks for more details [expression]
@STDERR (empty)
[1]
```

## audit:security:github.event.*.*

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 246 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:23: object filter extracts potentially untrusted properties "github.event.comment.body", "github.event.discussion.body", "github.event.discussion.title", "github.event.head_commit.message", "github.event.issue.body", "github.event.issue.title", "github.event.pull_request.body", "github.event.pull_request.title", "github.event.review.body", "github.event.review_comment.body". avoid using the value directly in inline scripts. instead, pass the value through an environment variable. see https://docs.github.com/en/actions/reference/security/secure-use#good-practices-for-mitigating-script-injection-attacks for more details [expression]
@STDERR (empty)
[1]
```

## audit:security:github.event.commits[0].message

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 247 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:23: "github.event.commits.*.message" is potentially untrusted. avoid using it directly in inline scripts. instead, pass it through an environment variable. see https://docs.github.com/en/actions/reference/security/secure-use#good-practices-for-mitigating-script-injection-attacks for more details [expression]
@STDERR (empty)
[1]
```

## audit:security:github['event']['issue']['title']

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 248 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:23: "github.event.issue.title" is potentially untrusted. avoid using it directly in inline scripts. instead, pass it through an environment variable. see https://docs.github.com/en/actions/reference/security/secure-use#good-practices-for-mitigating-script-injection-attacks for more details [expression]
@STDERR (empty)
[1]
```

## audit:security:github['EVENT']['issue']['title']

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 249 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:23: property "EVENT" is not defined in object type {action: string; action_path: string; action_ref: string; action_repository: string; action_status: string; actor: string; actor_id: string; api_url: string; artifact_cache_size_limit: number; base_ref: string; env: string; event: object; event_name: string; event_path: string; graphql_url: string; head_ref: string; job: string; output: string; path: string; ref: string; ref_name: string; ref_protected: bool; ref_type: string; repository: string; repository_id: string; repository_owner: string; repository_owner_id: string; repository_visibility: string; repositoryurl: string; retention_days: number; run_attempt: string; run_id: string; run_number: string; secret_source: string; server_url: string; sha: string; state: string; step_summary: string; token: string; triggering_actor: string; workflow: string; workflow_ref: string; workflow_sha: string; workspace: string} [expression]
@STDERR (empty)
[1]
```

## audit:security:github.event.issue

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 250 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:security:github.event.issue.*

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 251 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:23: object filter extracts potentially untrusted properties "github.event.issue.body", "github.event.issue.title". avoid using the value directly in inline scripts. instead, pass the value through an environment variable. see https://docs.github.com/en/actions/reference/security/secure-use#good-practices-for-mitigating-script-injection-attacks for more details [expression]
@STDERR (empty)
[1]
```

## audit:security:toJSON(github.event.issue)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 252 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:security:foo(github.event.issue.title)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 253 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:23: undefined function "foo". available functions are "always", "cancelled", "case", "contains", "endswith", "failure", "format", "fromjson", "hashfiles", "join", "startswith", "success", "tojson" [expression]
@STDERR (empty)
[1]
```

## audit:security:contains(github.event.issue.title, no_such)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 254 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:58: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:runner-glob:[!]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 255
@STDOUT
<stdin>:4:14: label "foo" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows", "[!]". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## audit:runner-glob:[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 256
@STDOUT
<stdin>:4:14: label pattern "[]" is an invalid glob. kindly check list of labels in actionlint.yaml config file: syntax error in pattern [runner-label]
@STDERR (empty)
[1]
```

## audit:runner-glob:[z-a]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 257
@STDOUT
<stdin>:4:14: label "foo" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows", "[z-a]". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## audit:runner-glob:{a,b}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 258
@STDOUT
<stdin>:4:14: label "foo" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows", "{a,b}". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## audit:runner-glob:foo/**/bar

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 259
@STDOUT
<stdin>:4:14: label "foo" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows", "foo/**/bar". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## audit:runner-glob:foo[!x]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 260
@STDOUT
<stdin>:4:14: label "foo" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows", "foo[!x]". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## audit:runner-glob:foo[^x]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 261
@STDOUT
<stdin>:4:14: label "foo" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows", "foo[^x]". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## audit:runner-glob:*

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 262
@STDOUT (empty)
@STDERR (empty)
```

## audit:runner-glob:**

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 263
@STDOUT (empty)
@STDERR (empty)
```

## audit:workflow-spec:./@foo

Local reusable workflow paths must not contain @ref, including when @ is the first character of the path; the baseline misses this boundary because it checks idx > 0.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 264 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:11: reusable workflow call "./@foo" at "uses" is not following the format "owner/repo/path/to/workflow.yml@ref" nor "./path/to/workflow.yml". see https://docs.github.com/en/actions/learn-github-actions/reusing-workflows for more details [workflow-call]
@STDERR (empty)
[1]
```

## audit:workflow-spec:owner/repo/@x@y

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 265 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:11: reusable workflow call "owner/repo/@x@y" at "uses" is not following the format "owner/repo/path/to/workflow.yml@ref" nor "./path/to/workflow.yml". see https://docs.github.com/en/actions/learn-github-actions/reusing-workflows for more details [workflow-call]
@STDERR (empty)
[1]
```

## audit:workflow-spec:owner/repo/@path@ref

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 266 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:11: reusable workflow call "owner/repo/@path@ref" at "uses" is not following the format "owner/repo/path/to/workflow.yml@ref" nor "./path/to/workflow.yml". see https://docs.github.com/en/actions/learn-github-actions/reusing-workflows for more details [workflow-call]
@STDERR (empty)
[1]
```

## audit:workflow-spec:owner/repo//path@ref

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 267 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:workflow-spec:./x@ref

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 268 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:11: reusable workflow call "./x@ref" at "uses" is not following the format "owner/repo/path/to/workflow.yml@ref" nor "./path/to/workflow.yml". see https://docs.github.com/en/actions/learn-github-actions/reusing-workflows for more details [workflow-call]
@STDERR (empty)
[1]
```

## audit:workflow-spec:owner/repo/path@@ref

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 269 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:cli:['-stdin-filename', 'missing.yml', '-']

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 270 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -stdin-filename missing.yml -
@STDOUT (empty)
@STDERR (empty)
```

## audit:cli:['-h=false']

This port intentionally removes Pyflakes integration; the help text no longer lists the -pyflakes argument.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -h=false
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

## audit:cli:['-help=false']

This port intentionally removes Pyflakes integration; the help text no longer lists the -pyflakes argument.

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -help=false
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

## audit:cli:['-debug', '-']

This port intentionally removes Pyflakes integration; verbose/debug output no longer includes logs about disabling or running Pyflakes.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 273 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -debug -
@STDOUT (empty)
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

## audit:cli:['-verbose', '-']

This port intentionally removes Pyflakes integration; verbose/debug output no longer includes logs about disabling or running Pyflakes.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 274 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -verbose -
@STDOUT (empty)
@STDERR
verbose: Reading the input from stdin
verbose: Linting <stdin>
verbose: Found 0 parse errors in [0-9]+ ms for <stdin> (regex)
verbose: Rule "shellcheck" was disabled since shellcheck command name was empty
verbose: Found total 0 errors in [0-9]+ ms for <stdin> (regex)
```

## audit:metadata-merge:101

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 275
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/action": line 4: unexpected key "<<" for definition of input "x" [action]
@STDERR (empty)
[1]
```

## audit:metadata-merge:102

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 276
@STDOUT
.github/workflows/main.yml:6:15: description is required in metadata of "Test" action at "$PROJECT/action/action.yml" [action]
.github/workflows/main.yml:6:15: file "index.js" does not exist in "$PROJECT/action". it is specified at "main" key in "runs" section in "Test" action [action]
@STDERR (empty)
[1]
```

## audit:cron:0/2147483648 * * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 277 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:cron:1/2147483647 * * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 278 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:cron:0 0 *-2 * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 279 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:cron:0 0 1-2-3 * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 280 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: invalid CRON format "0 0 1-2-3 * *" in schedule event: too many hyphens: 1-2-3 [events]
@STDERR (empty)
[1]
```

## audit:cron:*/+2 * * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 281 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: scheduled job runs too frequently. it runs once per 120 seconds. the shortest interval is once every 5 minutes [events]
@STDERR (empty)
[1]
```

## audit:cron:0 0 * * SUN

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 282 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:cron:0 0 * * 7

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 283 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: invalid CRON format "0 0 * * 7" in schedule event: end of range (7) above maximum (6): 7 [events]
@STDERR (empty)
[1]
```

## audit:cron:0 0 * * 0-7

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 284 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: invalid CRON format "0 0 * * 0-7" in schedule event: end of range (7) above maximum (6): 0-7 [events]
@STDERR (empty)
[1]
```

## audit:cron:0 0 * * MON-FRI

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 285 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:cron:0 0 * * ?

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 286 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:cron:0 0 * * */2

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 287 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:cron:@daily

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 288 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: invalid CRON format "@daily" in schedule event: parser does not accept descriptors: @daily [events]
@STDERR (empty)
[1]
```

## audit:cron:CRON_TZ=UTC * * * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 289 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: scheduled job runs too frequently. it runs once per 60 seconds. the shortest interval is once every 5 minutes [events]
@STDERR (empty)
[1]
```

## audit:cron:TZ= * * * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 290 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: scheduled job runs too frequently. it runs once per 60 seconds. the shortest interval is once every 5 minutes [events]
@STDERR (empty)
[1]
```

## audit:expr-position:é

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 291 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:37: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:expr-position:中

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 292 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:37: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:expr-position:😀

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 293 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:37: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:expr-position:‍

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 294 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:37: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:expr-position:́

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 295 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:37: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:checker-error:shellcheck:19

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 296
@STDOUT (empty)
@STDERR
`./checker --norc -f json -x --shell bash -e SC1091,SC2194,SC2050,SC2153,SC2154,SC2157,SC2043 -` did not run successfully while checking script at line:6,col:9: ./checker exited with status 2 but stdout was empty. stderr: "failure\n"
[3]
```

## audit:checker-error:pyflakes:20

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 297
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

## audit:checker-error:shellcheck:21

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 298
@STDOUT (empty)
@STDERR
could not parse JSON output from shellcheck: invalid character 'o' in literal null (expecting 'u'): stdout="not json\n"
[3]
```

## audit:checker-error:pyflakes:22

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 299
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

## audit:checker-error:shellcheck:23

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 300
@STDOUT (empty)
@STDERR (empty)
```

## audit:checker-error:pyflakes:24

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 301
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

## audit:checker-error:shellcheck:25

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 302
@STDOUT (empty)
@STDERR
could not parse JSON output from shellcheck: json: cannot unmarshal object into Go value of type []actionlint.shellcheckError: stdout="{}\n"
[3]
```

## audit:checker-error:pyflakes:26

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 303
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

## audit:checker-error:shellcheck:27

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 304
@STDOUT
<stdin>:6:9: shellcheck reported issue in this script: SC0::-1:0:  [shellcheck]
@STDERR (empty)
[1]
```

## audit:checker-error:pyflakes:28

This port intentionally removes Pyflakes integration, breaking compatibility with actionlint 1.7.12; all Pyflakes arguments are treated as unknown arguments.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run audit 305
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

## audit:matrix-entire:include:${{ fromJSON('[{"y":1}]') }}

Expressions in include entries must be checked for semantic errors and object types; the baseline incorrectly refers to the expression for the entire include value and skips entry checks. Invalid entries preserve known rows and allow unknown properties.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 306 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:11:13: type of expression at "include" must be object but found type array<{y: number}> [expression]
@STDERR (empty)
[1]
```

## audit:matrix-entire:include:${{ no_such }}

Expressions in include entries must be checked for semantic errors and object types; the baseline incorrectly refers to the expression for the entire include value and skips entry checks. Invalid entries preserve known rows and allow unknown properties.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 307 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:11:17: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:matrix-entire:include:${{ fromJSON('true') }}

Expressions in include entries must be checked for semantic errors and object types; the baseline incorrectly refers to the expression for the entire include value and skips entry checks. Invalid entries preserve known rows and allow unknown properties.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 308 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:11:13: type of expression at "include" must be object but found type bool [expression]
@STDERR (empty)
[1]
```

## audit:matrix-entire:exclude:${{ fromJSON('[{"y":1}]') }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 309 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:11:13: type of expression at "exclude" must be object but found type array<{y: number}> [expression]
@STDERR (empty)
[1]
```

## audit:matrix-entire:exclude:${{ no_such }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 310 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:11:17: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## audit:matrix-entire:exclude:${{ fromJSON('true') }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 311 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:11:13: type of expression at "exclude" must be object but found type bool [expression]
@STDERR (empty)
[1]
```

## audit:matrix-object:fromJSON('{"include":[{"y":1}]}'):matrix.y

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 312 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## audit:matrix-object:fromJSON('{"include":[{"y":1}]}'):matrix.include

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 313 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:15: property "include" is not defined in object type {y: number} [expression]
@STDERR (empty)
[1]
```

## audit:matrix-object:fromJSON('{"include":[{"y":1}]}'):matrix.exclude

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 314 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:15: property "exclude" is not defined in object type {y: number} [expression]
@STDERR (empty)
[1]
```

## audit:matrix-object:fromJSON('{"exclude":[{"y":1}]}'):matrix.y

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 315 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:15: property "y" is not defined in object type {} [expression]
@STDERR (empty)
[1]
```

## audit:matrix-object:fromJSON('{"exclude":[{"y":1}]}'):matrix.include

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 316 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:15: property "include" is not defined in object type {} [expression]
@STDERR (empty)
[1]
```

## audit:matrix-object:fromJSON('{"exclude":[{"y":1}]}'):matrix.exclude

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 317 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:15: property "exclude" is not defined in object type {} [expression]
@STDERR (empty)
[1]
```

## audit:unicode-output:['-format', '{{json .}}']

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 318 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{json .}}' -
@STDOUT
[{"message":"undefined variable \"no_such\". available variables are \"env\", \"github\", \"inputs\", \"job\", \"matrix\", \"needs\", \"runner\", \"secrets\", \"steps\", \"strategy\", \"vars\"","filepath":"\u003cstdin\u003e","line":6,"column":34,"kind":"expression","snippet":"      - run: echo 中文😀 ${{ no_such }}\n                             ^~~~~~~","end_column":36}]
@STDERR (empty)
[1]
```

## audit:unicode-output:['-format', '{{range .}}{{.EndColumn}}{{end}}']

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/audit.json 319 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{range .}}{{.EndColumn}}{{end}}' -
@STDOUT
36 (no-eol)
@STDERR (empty)
[1]
```

