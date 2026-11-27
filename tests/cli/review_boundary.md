# Review Boundary regressions

259 migrated cases. Inputs are in [fixtures/review_boundary.json](fixtures/review_boundary.json).
Each case asserts stdout, stderr, and exit status; only elapsed milliseconds vary.

## review-boundary:matrix-key/include/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 0 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: "include" section should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/include/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 1 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: "include" section must be sequence node but got mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/include/[{X: b}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 2 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:matrix-key/include/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 3 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:23: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/include/"${{ fromJSON('[1]') }}"

Elements of include must be objects; the port retains stricter validation for all casing variants.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 4 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression at "include" must be object but found type number [expression]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/INCLUDE/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 5 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: "include" section should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/INCLUDE/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 6 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: "include" section must be sequence node but got mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/INCLUDE/[{X: b}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 7 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:matrix-key/INCLUDE/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 8 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:23: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/INCLUDE/"${{ fromJSON('[1]') }}"

Elements of include must be objects; the port retains stricter validation for all casing variants.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 9 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression at "include" must be object but found type number [expression]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/InClUdE/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 10 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: "include" section should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/InClUdE/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 11 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: "include" section must be sequence node but got mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/InClUdE/[{X: b}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 12 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:matrix-key/InClUdE/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 13 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:23: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/InClUdE/"${{ fromJSON('[1]') }}"

Elements of include must be objects; the port retains stricter validation for all casing variants.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 14 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression at "include" must be object but found type number [expression]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/exclude/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 15 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: "exclude" section should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/exclude/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 16 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: "exclude" section must be sequence node but got mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/exclude/[{X: b}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 17 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:23: value "b" in "exclude" does not match in matrix "x" combinations. possible values are "a" [matrix]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/exclude/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 18 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:23: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/exclude/"${{ fromJSON('[1]') }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 19 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression at "exclude" must be object but found type number [expression]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/EXCLUDE/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 20 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: "exclude" section should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/EXCLUDE/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 21 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: "exclude" section must be sequence node but got mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/EXCLUDE/[{X: b}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 22 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:23: value "b" in "exclude" does not match in matrix "x" combinations. possible values are "a" [matrix]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/EXCLUDE/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 23 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:23: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/EXCLUDE/"${{ fromJSON('[1]') }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 24 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression at "exclude" must be object but found type number [expression]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/ExClUdE/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 25 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: "exclude" section should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/ExClUdE/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 26 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: "exclude" section must be sequence node but got mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/ExClUdE/[{X: b}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 27 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:23: value "b" in "exclude" does not match in matrix "x" combinations. possible values are "a" [matrix]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/ExClUdE/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 28 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:23: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review-boundary:matrix-key/ExClUdE/"${{ fromJSON('[1]') }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 29 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression at "exclude" must be object but found type number [expression]
@STDERR (empty)
[1]
```

## review-boundary:array/fromJSON('[]').*||fromJSON('[{"x":1}]').*

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 30 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:15: object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type array<any> [expression]
@STDERR (empty)
[1]
```

## review-boundary:array/fromJSON('[{"x":1}]').*||fromJSON('[]')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 31 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:20: receiver of object dereference "x" must be type of object but got "array<any>" [expression]
@STDERR (empty)
[1]
```

## review-boundary:array/fromJSON('[1]').*||fromJSON('[2]').*

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 32 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:20: receiver of object dereference "x" must be type of object but got "array<number>" [expression]
@STDERR (empty)
[1]
```

## review-boundary:array/fromJSON('[{"x":1}]').*||fromJSON('[{"x":2}]').*

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 33 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:20: receiver of object dereference "x" must be type of object but got "array<{x: number}>" [expression]
@STDERR (empty)
[1]
```

## review-boundary:array/fromJSON('[]').*&&fromJSON('[{"x":1}]').*

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 34 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:15: object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type array<any> [expression]
@STDERR (empty)
[1]
```

## review-boundary:array/fromJSON('[{"x":1}]').*&&fromJSON('[]')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 35 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:20: receiver of object dereference "x" must be type of object but got "array<any>" [expression]
@STDERR (empty)
[1]
```

## review-boundary:array/fromJSON('[1]').*&&fromJSON('[2]').*

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 36 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:20: receiver of object dereference "x" must be type of object but got "array<number>" [expression]
@STDERR (empty)
[1]
```

## review-boundary:array/fromJSON('[{"x":1}]').*&&fromJSON('[{"x":2}]').*

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 37 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:20: receiver of object dereference "x" must be type of object but got "array<{x: number}>" [expression]
@STDERR (empty)
[1]
```

## review-boundary:inputs/workflow_callnumberbooleaninputs.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 38 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:inputs/workflow_callnumberbooleangithub.event.inputs.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 39 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:13:19: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review-boundary:inputs/workflow_callstringnumberinputs.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 40 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:13:19: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review-boundary:inputs/workflow_callstringnumbergithub.event.inputs.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 41 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:13:19: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review-boundary:inputs/workflow_callbooleanbooleaninputs.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 42 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:13:19: receiver of object dereference "foo" must be type of object but got "bool" [expression]
@STDERR (empty)
[1]
```

## review-boundary:inputs/workflow_callbooleanbooleangithub.event.inputs.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 43 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:13:19: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review-boundary:inputs/workflow_dispatchnumberbooleaninputs.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 44 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:inputs/workflow_dispatchnumberbooleangithub.event.inputs.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 45 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:13:19: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review-boundary:inputs/workflow_dispatchstringnumberinputs.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 46 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:13:19: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review-boundary:inputs/workflow_dispatchstringnumbergithub.event.inputs.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 47 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:13:19: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review-boundary:inputs/workflow_dispatchbooleanbooleaninputs.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 48 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:13:19: receiver of object dereference "foo" must be type of object but got "bool" [expression]
@STDERR (empty)
[1]
```

## review-boundary:inputs/workflow_dispatchbooleanbooleangithub.event.inputs.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 49 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:13:19: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review-boundary:job-id/abc${{

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 50 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: invalid job ID "abc${{". job ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review-boundary:step-id/abc${{

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 51 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: invalid step ID "abc${{". step ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review-boundary:job-id/foo}}${{bar

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 52 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: invalid job ID "foo}}${{bar". job ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review-boundary:step-id/foo}}${{bar

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 53 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: invalid step ID "foo}}${{bar". step ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review-boundary:job-id/${{

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 54 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: invalid job ID "${{". job ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review-boundary:step-id/${{

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 55 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: invalid step ID "${{". step ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review-boundary:job-id/${{ x }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 56 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:step-id/${{ x }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 57 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:18: undefined variable "x". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review-boundary:job-id/foo${{ x }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 58 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:step-id/foo${{ x }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 59 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:21: undefined variable "x". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review-boundary:job-id/foo}}${{x}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 60 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: invalid job ID "foo}}${{x}}". job ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review-boundary:step-id/foo}}${{x}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 61 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: invalid step ID "foo}}${{x}}". step ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review-boundary:root-rejected/name

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 62 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:7: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:root-rejected/run-name

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 63 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:11: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:root-rejected/permissions

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 64 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:15: unknown permission scope "unknown". all available permission scopes are "actions", "artifact-metadata", "attestations", "checks", "contents", "deployments", "discussions", "id-token", "issues", "models", "packages", "pages", "pull-requests", "repository-projects", "security-events", "statuses" [permissions]
@STDERR (empty)
[1]
```

## review-boundary:root-rejected/defaults

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 65 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:11: "defaults" section should have "run" section [syntax-check]
<stdin>:7:12: expected "run" key for "defaults" section but got "unknown" [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:root-rejected/concurrency

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 66 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:1: group name is missing in "concurrency" section [syntax-check]
<stdin>:7:15: unexpected key "unknown" for "concurrency" section. expected one of "cancel-in-progress", "group" [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:root-rejected/unknown

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 67 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:1: unexpected key "unknown" for "workflow" section. expected one of "concurrency", "defaults", "env", "jobs", "name", "on", "permissions", "run-name" [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:job-rejected/container

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 68 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:5: "image" is missing in "container" section [syntax-check]
<stdin>:7:17: unexpected key "unknown" for "container" section. expected one of "credentials", "env", "image", "options", "ports", "volumes" [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:job-rejected/environment

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 69 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:5: name is missing in "environment" section [syntax-check]
<stdin>:7:19: unexpected key "unknown" for "environment" section. expected one of "deployment", "name", "url" [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:job-rejected/concurrency

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 70 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:5: group name is missing in "concurrency" section [syntax-check]
<stdin>:7:19: unexpected key "unknown" for "concurrency" section. expected one of "cancel-in-progress", "group" [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:job-rejected/runs-on

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 71 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:5: key "runs-on" is duplicated in "test" job. previously defined at line:4,col:5 [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:job-rejected/strategy

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 72 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:16: unexpected key "unknown" for "strategy" section. expected one of "fail-fast", "matrix", "max-parallel" [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:job-rejected/defaults

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 73 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:15: "defaults" section should have "run" section [syntax-check]
<stdin>:7:16: expected "run" key for "defaults" section but got "unknown" [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:job-rejected/snapshot

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 74 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:5: "snapshot" section must have "image-name" configuration [syntax-check]
<stdin>:7:16: unexpected key "unknown" for "snapshot" section. expected one of "if", "image-name", "version" [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:job-rejected/unknown

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 75 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:5: unexpected key "unknown" for "job" section. expected one of "concurrency", "container", "continue-on-error", "defaults", "env", "environment", "if", "name", "needs", "outputs", "permissions", "runs-on", "secrets", "services", "snapshot", "steps", "strategy", "timeout-minutes", "uses", "with" [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:step-rejected/name

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 76 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:15: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:step-rejected/uses

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 77 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:9: unexpected key "run" for step to execute action. expected one of "continue-on-error", "env", "id", "if", "name", "timeout-minutes", "uses", "with" [syntax-check]
<stdin>:7:15: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
<stdin>:7:15: specifying action "" in invalid format because ref is missing. available formats are "{owner}/{repo}@{ref}" or "{owner}/{repo}/{path}@{ref}" [action]
@STDERR (empty)
[1]
```

## review-boundary:step-rejected/run

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 78 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:9: key "run" is duplicated in element of "steps" section. previously defined at line:6,col:9 [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:step-rejected/if

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 79 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
<stdin>:7:13: unexpected end of input while parsing variable access, function call, null, bool, int, float or string. expecting "IDENT", "(", "INTEGER", "FLOAT", "STRING" [expression]
@STDERR (empty)
[1]
```

## review-boundary:step-rejected/env

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 80 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:29: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review-boundary:step-rejected/with

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 81 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:9: unexpected key "with" for step to run shell command. expected one of "continue-on-error", "env", "id", "if", "name", "run", "shell", "timeout-minutes", "working-directory" [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:step-rejected/unknown

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 82 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:9: unexpected key "unknown" for step to run shell command. expected one of "continue-on-error", "env", "id", "if", "name", "run", "shell", "timeout-minutes", "working-directory" [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:condition/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 83 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
<stdin>:7:13: unexpected end of input while parsing variable access, function call, null, bool, int, float or string. expecting "IDENT", "(", "INTEGER", "FLOAT", "STRING" [expression]
@STDERR (empty)
[1]
```

## review-boundary:condition/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 84 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
<stdin>:7:13: unexpected end of input while parsing variable access, function call, null, bool, int, float or string. expecting "IDENT", "(", "INTEGER", "FLOAT", "STRING" [expression]
@STDERR (empty)
[1]
```

## review-boundary:condition/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 85 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: constant expression "null" in condition. remove the if: section [if-cond]
@STDERR (empty)
[1]
```

## review-boundary:condition/false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 86 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: constant expression "false" in condition. remove the if: section [if-cond]
@STDERR (empty)
[1]
```

## review-boundary:condition/'hello'

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 87 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: undefined variable "hello". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review-boundary:condition/"${{ false }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 88 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: constant expression "false" in condition. remove the if: section [if-cond]
@STDERR (empty)
[1]
```

## review-boundary:cron-space/0x9

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 89 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:cron-space/0xb

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 90 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:cron-space/0xd

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 91 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:cron-space/0x85

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 92 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:cron-space/0xa0

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 93 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:cron-space/0x1680

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 94 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:cron-space/0x2007

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 95 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:cron-space/0x202f

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 96 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:cron-space/0x3000

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 97 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:cron-space/0x200b

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 98 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: invalid CRON format "*/5\u200b* * * *" in schedule event: expected exactly 5 fields, found 4: [*/5​* * * *] [events]
@STDERR (empty)
[1]
```

## review-boundary:char-escape/0x1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 99 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:0:0: could not parse as YAML: control characters are not allowed [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:char-escape/0x7

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 100 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:0:0: could not parse as YAML: control characters are not allowed [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:char-escape/0xb

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 101 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:0:0: could not parse as YAML: control characters are not allowed [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:char-escape/0x7f

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 102 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:0:0: could not parse as YAML: control characters are not allowed [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:char-escape/0x85

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 103 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:0: could not parse as YAML: did not find expected key [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:char-escape/0xa0

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 104 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:27: got unexpected character '\u00a0' while lexing expression, expecting 'a'..'z', 'A'..'Z', '_', '0'..'9', ''', '}', '(', ')', '[', ']', '.', '!', '<', '>', '=', '&', '|', '*', ',', ' ' [expression]
@STDERR (empty)
[1]
```

## review-boundary:char-escape/0x2028

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 105 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:0: could not parse as YAML: did not find expected key [syntax-check]
@STDERR (empty)
[1]
```

## review-boundary:char-escape/0x200d

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 106 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:27: got unexpected character '\u200d' while lexing expression, expecting 'a'..'z', 'A'..'Z', '_', '0'..'9', ''', '}', '(', ')', '[', ']', '.', '!', '<', '>', '=', '&', '|', '*', ',', ' ' [expression]
@STDERR (empty)
[1]
```

## review-boundary:char-escape/0xe000

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 107 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:27: got unexpected character '\ue000' while lexing expression, expecting 'a'..'z', 'A'..'Z', '_', '0'..'9', ''', '}', '(', ')', '[', ']', '.', '!', '<', '>', '=', '&', '|', '*', ',', ' ' [expression]
@STDERR (empty)
[1]
```

## review-boundary:char-escape/0xe0001

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 108 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:27: got unexpected character '\U000e0001' while lexing expression, expecting 'a'..'z', 'A'..'Z', '_', '0'..'9', ''', '}', '(', ')', '[', ']', '.', '!', '<', '>', '=', '&', '|', '*', ',', ' ' [expression]
@STDERR (empty)
[1]
```

## review-boundary:char-escape/0x4e2d

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 109 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:27: got unexpected character '中' while lexing expression, expecting 'a'..'z', 'A'..'Z', '_', '0'..'9', ''', '}', '(', ')', '[', ']', '.', '!', '<', '>', '=', '&', '|', '*', ',', ' ' [expression]
@STDERR (empty)
[1]
```

## review-boundary:char-escape/0x1f600

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 110 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:27: got unexpected character '😀' while lexing expression, expecting 'a'..'z', 'A'..'Z', '_', '0'..'9', ''', '}', '(', ')', '[', ']', '.', '!', '<', '>', '=', '&', '|', '*', ',', ' ' [expression]
@STDERR (empty)
[1]
```

## review-boundary:config/unknown: {x: 1, x: 2}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 111
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:config/unknown: {x: {a: 1, a: 2}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 112
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:config/self-hosted-runner: {unknown: {x: 1, x: 2}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 113
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:config/self-hosted-runner: {labels: [], labels: []}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 114
@STDOUT (empty)
@STDERR
could not parse config file "config.yml": yaml: unmarshal errors:   line 1: mapping key "labels" already defined at line 1
[3]
```

## review-boundary:config/paths: {"*": {unknown: {x: 1, x: 2}}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 115
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:config/paths: {"*": {ignore: [], ignore: []}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 116
@STDOUT (empty)
@STDERR
could not parse config file "config.yml": yaml: unmarshal errors:   line 1: mapping key "ignore" already defined at line 1
[3]
```

## review-boundary:metadata/name: x\nname: y\n

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 117
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": yaml: unmarshal errors:  line 4: mapping key "name" already defined at line 1  line 5: mapping key "name" already defined at line 1  line 5: mapping key "name" already defined at line 4 [action]
@STDERR (empty)
[1]
```

## review-boundary:metadata/unknown: {x: 1, x: 2}\n

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 118
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:metadata/branding: {icon: x, icon: y}\n

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 119
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 4: mapping key "icon" already defined at line 4 [action]
@STDERR (empty)
[1]
```

## review-boundary:metadata/inputs: {x: {required: true, required: false}}\n

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 120
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 4: mapping key "required" already defined at line 4 [action]
@STDERR (empty)
[1]
```

## review-boundary:metadata/inputs: {X: {}, x: {}}\n

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 121
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 4: input "x" is duplicated [action]
@STDERR (empty)
[1]
```

## review-boundary:metadata/inputs: {x: {}, x: {}}\n

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 122
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 4: input "x" is duplicated [action]
@STDERR (empty)
[1]
```

## review-boundary:metadata/outputs: {X: {}, x: {}}\n

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 123
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 4: output "x" is duplicated [action]
@STDERR (empty)
[1]
```

## review-boundary:metadata/outputs: {x: {}, x: {}}\n

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 124
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 4: output "x" is duplicated [action]
@STDERR (empty)
[1]
```

## review-boundary:metadata/outputs: {x: {value: a, value: b}}\n

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 125
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:metadata/inputs: {x: {unknown: {x: 1, x: 2}}}\n

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 126
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 4: unexpected key "unknown" for definition of input "x" [action]
@STDERR (empty)
[1]
```

## review-boundary:reusable/inputs{X: {}, x: {}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 127
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:reusable/inputs{x: {}, x: {}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 128
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:reusable/inputs{x: {required: true, required: false}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 129
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/call.yml": yaml: unmarshal errors:   line 3: mapping key "required" already defined at line 3 [workflow-call]
@STDERR (empty)
[1]
```

## review-boundary:reusable/inputs{x: {unknown: {x: 1, x: 2}}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 130
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:reusable/outputs{X: {}, x: {}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 131
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:reusable/outputs{x: {}, x: {}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 132
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:reusable/outputs{x: {required: true, required: false}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 133
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:reusable/outputs{x: {unknown: {x: 1, x: 2}}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 134
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:reusable/secrets{X: {}, x: {}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 135
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:reusable/secrets{x: {}, x: {}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 136
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:reusable/secrets{x: {required: true, required: false}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 137
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/call.yml": yaml: unmarshal errors:   line 3: mapping key "required" already defined at line 3 [workflow-call]
@STDERR (empty)
[1]
```

## review-boundary:reusable/secrets{x: {unknown: {x: 1, x: 2}}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 138
@STDOUT (empty)
@STDERR (empty)
```

## review-boundary:template/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 2.5 2.5 2.5 2.5 2.5 2.5

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 139 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 2.5 2.5 2.5 2.5 2.5 2.5}}after' -
@STDOUT
before2|2.50|2.5|2.500e+00|2.500000|2.5after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 2.5 2.5 2.5 2.5 2.5 2.5

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 140
@STDOUT
before2|2.50|2.5|2.500e+00|2.500000|2.5after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 3.5 3.5 3.5 3.5 3.5 3.5

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 141 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 3.5 3.5 3.5 3.5 3.5 3.5}}after' -
@STDOUT
before4|3.50|3.5|3.500e+00|3.500000|3.5after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 3.5 3.5 3.5 3.5 3.5 3.5

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 142
@STDOUT
before4|3.50|3.5|3.500e+00|3.500000|3.5after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" -2.5 -2.5 -2.5 -2.5 -2.5 -2.5

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 143 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%.0f|%.2f|%.17g|%.3e|%F|%G" -2.5 -2.5 -2.5 -2.5 -2.5 -2.5}}after' -
@STDOUT
before-2|-2.50|-2.5|-2.500e+00|-2.500000|-2.5after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" -2.5 -2.5 -2.5 -2.5 -2.5 -2.5

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 144
@STDOUT
before-2|-2.50|-2.5|-2.500e+00|-2.500000|-2.5after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 0.125 0.125 0.125 0.125 0.125 0.125

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 145 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 0.125 0.125 0.125 0.125 0.125 0.125}}after' -
@STDOUT
before0|0.12|0.125|1.250e-01|0.125000|0.125after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 0.125 0.125 0.125 0.125 0.125 0.125

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 146
@STDOUT
before0|0.12|0.125|1.250e-01|0.125000|0.125after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 0.375 0.375 0.375 0.375 0.375 0.375

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 147 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 0.375 0.375 0.375 0.375 0.375 0.375}}after' -
@STDOUT
before0|0.38|0.375|3.750e-01|0.375000|0.375after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 0.375 0.375 0.375 0.375 0.375 0.375

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 148
@STDOUT
before0|0.38|0.375|3.750e-01|0.375000|0.375after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 2.675 2.675 2.675 2.675 2.675 2.675

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 149 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 2.675 2.675 2.675 2.675 2.675 2.675}}after' -
@STDOUT
before3|2.67|2.6749999999999998|2.675e+00|2.675000|2.675after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 2.675 2.675 2.675 2.675 2.675 2.675

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 150
@STDOUT
before3|2.67|2.6749999999999998|2.675e+00|2.675000|2.675after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 1.005 1.005 1.005 1.005 1.005 1.005

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 151 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 1.005 1.005 1.005 1.005 1.005 1.005}}after' -
@STDOUT
before1|1.00|1.0049999999999999|1.005e+00|1.005000|1.005after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 1.005 1.005 1.005 1.005 1.005 1.005

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 152
@STDOUT
before1|1.00|1.0049999999999999|1.005e+00|1.005000|1.005after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 9.999 9.999 9.999 9.999 9.999 9.999

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 153 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 9.999 9.999 9.999 9.999 9.999 9.999}}after' -
@STDOUT
before10|10.00|9.9990000000000006|9.999e+00|9.999000|9.999after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 9.999 9.999 9.999 9.999 9.999 9.999

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 154
@STDOUT
before10|10.00|9.9990000000000006|9.999e+00|9.999000|9.999after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 0.00009999 0.00009999 0.00009999 0.00009999 0.00009999 0.00009999

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 155 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 0.00009999 0.00009999 0.00009999 0.00009999 0.00009999 0.00009999}}after' -
@STDOUT
before0|0.00|9.9989999999999996e-05|9.999e-05|0.000100|9.999E-05after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 0.00009999 0.00009999 0.00009999 0.00009999 0.00009999 0.00009999

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 156
@STDOUT
before0|0.00|9.9989999999999996e-05|9.999e-05|0.000100|9.999E-05after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 1e30 1e30 1e30 1e30 1e30 1e30

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 157 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 1e30 1e30 1e30 1e30 1e30 1e30}}after' -
@STDOUT
before1000000000000000019884624838656|1000000000000000019884624838656.00|1e+30|1.000e+30|1000000000000000019884624838656.000000|1E+30after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 1e30 1e30 1e30 1e30 1e30 1e30

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 158
@STDOUT
before1000000000000000019884624838656|1000000000000000019884624838656.00|1e+30|1.000e+30|1000000000000000019884624838656.000000|1E+30after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 1e-300 1e-300 1e-300 1e-300 1e-300 1e-300

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 159 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 1e-300 1e-300 1e-300 1e-300 1e-300 1e-300}}after' -
@STDOUT
before0|0.00|1e-300|1.000e-300|0.000000|1E-300after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 1e-300 1e-300 1e-300 1e-300 1e-300 1e-300

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 160
@STDOUT
before0|0.00|1e-300|1.000e-300|0.000000|1E-300after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 5e-324 5e-324 5e-324 5e-324 5e-324 5e-324

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 161 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 5e-324 5e-324 5e-324 5e-324 5e-324 5e-324}}after' -
@STDOUT
before0|0.00|4.9406564584124654e-324|4.941e-324|0.000000|5E-324after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 5e-324 5e-324 5e-324 5e-324 5e-324 5e-324

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 162
@STDOUT
before0|0.00|4.9406564584124654e-324|4.941e-324|0.000000|5E-324after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 1.7976931348623157e308 1.7976931348623157e308 1.7976931348623157e308 1.7976931348623157e308 1.7976931348623157e308 1.7976931348623157e308

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 163 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 1.7976931348623157e308 1.7976931348623157e308 1.7976931348623157e308 1.7976931348623157e308 1.7976931348623157e308 1.7976931348623157e308}}after' -
@STDOUT
before179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368|179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368.00|1.7976931348623157e+308|1.798e+308|179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368.000000|1.7976931348623157E+308after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" 1.7976931348623157e308 1.7976931348623157e308 1.7976931348623157e308 1.7976931348623157e308 1.7976931348623157e308 1.7976931348623157e308

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 164
@STDOUT
before179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368|179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368.00|1.7976931348623157e+308|1.798e+308|179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368.000000|1.7976931348623157E+308after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" -0.0 -0.0 -0.0 -0.0 -0.0 -0.0

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 165 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%.0f|%.2f|%.17g|%.3e|%F|%G" -0.0 -0.0 -0.0 -0.0 -0.0 -0.0}}after' -
@STDOUT
before-0|-0.00|-0|-0.000e+00|-0.000000|-0after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%.0f|%.2f|%.17g|%.3e|%F|%G" -0.0 -0.0 -0.0 -0.0 -0.0 -0.0

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 166
@STDOUT
before-0|-0.00|-0|-0.000e+00|-0.000000|-0after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%[2]s %[1]s" "a" "b"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 167 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%[2]s %[1]s" "a" "b"}}after' -
@STDOUT
beforeb aafter (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%[2]s %[1]s" "a" "b"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 168
@STDOUT
beforeb aafter (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%[2]*[1]s" "a" 3

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 169 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%[2]*[1]s" "a" 3}}after' -
@STDOUT
before  aafter (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%[2]*[1]s" "a" 3

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 170
@STDOUT
before  aafter (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%*.*f" 8 2 1.125

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 171 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%*.*f" 8 2 1.125}}after' -
@STDOUT
before    1.12after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%*.*f" 8 2 1.125

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 172
@STDOUT
before    1.12after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%*s" -4 "a"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 173 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%*s" -4 "a"}}after' -
@STDOUT
beforea   after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%*s" -4 "a"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 174
@STDOUT
beforea   after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%*s" "x" "a"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 175 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%*s" "x" "a"}}after' -
@STDOUT
before%!(BADWIDTH)aafter (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%*s" "x" "a"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 176
@STDOUT
before%!(BADWIDTH)aafter (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%.*f" -1 1.25

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 177 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%.*f" -1 1.25}}after' -
@STDOUT
before%!(BADPREC)1.250000after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%.*f" -1 1.25

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 178
@STDOUT
before%!(BADPREC)1.250000after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%[0]s" "a"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 179 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%[0]s" "a"}}after' -
@STDOUT
before%!s(BADINDEX)after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%[0]s" "a"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 180
@STDOUT
before%!s(BADINDEX)after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%[9]s" "a"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 181 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%[9]s" "a"}}after' -
@STDOUT
before%!s(BADINDEX)after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%[9]s" "a"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 182
@STDOUT
before%!s(BADINDEX)after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%[x]s" "a"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 183 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%[x]s" "a"}}after' -
@STDOUT
before%!s(BADINDEX)after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%[x]s" "a"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 184
@STDOUT
before%!s(BADINDEX)after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%#08x" -1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 185 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%#08x" -1}}after' -
@STDOUT
before-0x0000001after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%#08x" -1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 186
@STDOUT
before-0x0000001after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%#08X" 1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 187 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%#08X" 1}}after' -
@STDOUT
before0X00000001after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%#08X" 1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 188
@STDOUT
before0X00000001after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%#08b" 1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 189 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%#08b" 1}}after' -
@STDOUT
before0b00000001after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%#08b" 1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 190
@STDOUT
before0b00000001after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%#o|%#O|%O" 0 1 1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 191 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%#o|%#O|%O" 0 1 1}}after' -
@STDOUT
before0|0o01|0o1after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%#o|%#O|%O" 0 1 1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 192
@STDOUT
before0|0o01|0o1after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%#v|%+v" (index . 0) (index . 0)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 193 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%#v|%+v" (index . 0) (index . 0)}}after' -
@STDOUT
before&actionlint.ErrorTemplateFields{Message:"undefined variable \"missing\". available variables are \"env\", \"github\", \"inputs\", \"job\", \"matrix\", \"needs\", \"runner\", \"secrets\", \"steps\", \"strategy\", \"vars\"", Filepath:"<stdin>", Line:6, Column:23, Kind:"expression", Snippet:"      - run: echo ${{ missing }}\n                      ^~~~~~~", EndColumn:29}|&{Message:undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" Filepath:<stdin> Line:6 Column:23 Kind:expression Snippet:      - run: echo ${{ missing }}
"                      ^~~~~~~ EndColumn:29}after" (escaped) (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%#v|%+v" (index . 0) (index . 0)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 194
@STDOUT
before&actionlint.ErrorTemplateFields{Message:"undefined variable \"missing\". available variables are \"env\", \"github\", \"inputs\", \"job\", \"matrix\", \"needs\", \"runner\", \"secrets\", \"steps\", \"strategy\", \"vars\"", Filepath:"a.yml", Line:6, Column:23, Kind:"expression", Snippet:"      - run: echo ${{ missing }}\n                      ^~~~~~~", EndColumn:29}|&{Message:undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" Filepath:a.yml Line:6 Column:23 Kind:expression Snippet:      - run: echo ${{ missing }}
"                      ^~~~~~~ EndColumn:29}after" (escaped) (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%x|% X|%#x|%# X|%.2x" "中" "ab" "ab" "ab" "中"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 195 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%x|% X|%#x|%# X|%.2x" "中" "ab" "ab" "ab" "中"}}after' -
@STDOUT
beforee4b8ad|61 62|0x6162|0X61 0X62|e4b8after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%x|% X|%#x|%# X|%.2x" "中" "ab" "ab" "ab" "中"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 196
@STDOUT
beforee4b8ad|61 62|0x6162|0X61 0X62|e4b8after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/printf "%q|%+q|%#q|%#q" 10 233 "abc" "a\nb"

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%q|%+q|%#q|%#q" 10 233 "abc" "a\nb"}}after' -
@STDOUT (empty)
@STDERR
template "before{{printf \"%q|%+q|%#q|%#q\" 10 233 \"abc\" \"a\\nb\"}}after" to format error messages could not be parsed: template: error formatter:1: unterminated quoted string
[3]
```

## review-boundary:template-multi/printf "%q|%+q|%#q|%#q" 10 233 "abc" "a\nb"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 198
@STDOUT (empty)
@STDERR
template "before{{printf \"%q|%+q|%#q|%#q\" 10 233 \"abc\" \"a\\nb\"}}after" to format error messages could not be parsed: template: error formatter:1: unterminated quoted string
[3]
```

## review-boundary:template/printf "%#g|%#.0f|%#.0e|%#.4g" 1.25 1.5 1.5 1.25

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 199 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%#g|%#.0f|%#.0e|%#.4g" 1.25 1.5 1.5 1.25}}after' -
@STDOUT
before1.25000|2.|2.e+00|1.250after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/printf "%#g|%#.0f|%#.0e|%#.4g" 1.25 1.5 1.5 1.25

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 200
@STDOUT
before1.25000|2.|2.e+00|1.250after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/html 1 2 "a" 3 4

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 201 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{html 1 2 "a" 3 4}}after' -
@STDOUT
before1 2a3 4after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/html 1 2 "a" 3 4

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 202
@STDOUT
before1 2a3 4after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/js 1 2 "<a=b>&c'"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 203 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{js 1 2 "<a=b>&c'\''"}}after' -
@STDOUT
before1 2\u003Ca\u003Db\u003E\u0026c\'after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/js 1 2 "<a=b>&c'"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 204
@STDOUT
before1 2\u003Ca\u003Db\u003E\u0026c\'after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/urlquery 1 2 "a b"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 205 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{urlquery 1 2 "a b"}}after' -
@STDOUT
before1+2a+bafter (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/urlquery 1 2 "a b"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 206
@STDOUT
before1+2a+bafter (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/replace "中文" "" "-"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 207
@STDOUT
hex: 6265666f72652de42db82dad2de62d962d872d6166746572
@STDERR (empty)
[1]
```

## review-boundary:template-multi/replace "中文" "" "-"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 208
@STDOUT
hex: 6265666f72652de42db82dad2de62d962d872d6166746572
@STDERR (empty)
[1]
```

## review-boundary:template/replace "a" "" "-" "a" "b"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 209 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{replace "a" "" "-" "a" "b"}}after' -
@STDOUT
before-b-after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/replace "a" "" "-" "a" "b"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 210
@STDOUT
before-b-after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/replace "abc" "a" "x" "" "-"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 211 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{replace "abc" "a" "x" "" "-"}}after' -
@STDOUT
beforex-b-c-after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/replace "abc" "a" "x" "" "-"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 212
@STDOUT
beforex-b-c-after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/replace "" "" "-"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 213 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{replace "" "" "-"}}after' -
@STDOUT
before-after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/replace "" "" "-"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 214
@STDOUT
before-after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/eq (index . 0) (index . 0)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 215 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{eq (index . 0) (index . 0)}}after' -
@STDOUT
beforetrueafter (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/eq (index . 0) (index . 0)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 216
@STDOUT
beforetrueafter (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/eq (index . 0) (index . 1)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 217 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{eq (index . 0) (index . 1)}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/eq (index . 0) (index . 1)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 218
@STDOUT
beforefalseafter (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/index (index . 0) "Message"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 219 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{index (index . 0) "Message"}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/index (index . 0) "Message"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 220
@STDOUT
before (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <index (index . 0) "Message">: error calling index: can't index item of type actionlint.ErrorTemplateFields
[3]
```

## review-boundary:template/index "abc" 4

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 221 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{index "abc" 4}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/index "abc" 4

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 222
@STDOUT
before (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <index "abc" 4>: error calling index: index out of range: 4
[3]
```

## review-boundary:template/index "abc" 3

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 223 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{index "abc" 3}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/index "abc" 3

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 224
@STDOUT
before (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <index "abc" 3>: error calling index: reflect: string index out of range
[3]
```

## review-boundary:template/index "abc" -1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 225 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{index "abc" -1}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/index "abc" -1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 226
@STDOUT
before (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <index "abc" -1>: error calling index: index out of range: -1
[3]
```

## review-boundary:template/index "abc" "1"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 227 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{index "abc" "1"}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/index "abc" "1"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 228
@STDOUT
before (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <index "abc" "1">: error calling index: cannot index slice/array with type string
[3]
```

## review-boundary:template/index nil 0

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 229 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{index nil 0}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/index nil 0

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 230
@STDOUT
before (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <index nil 0>: error calling index: index of untyped nil
[3]
```

## review-boundary:template/slice nil

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 231 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{slice nil}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/slice nil

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 232
@STDOUT
before (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <slice nil>: error calling slice: slice of untyped nil
[3]
```

## review-boundary:template/slice "abc" 0 2 2

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 233 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{slice "abc" 0 2 2}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/slice "abc" 0 2 2

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 234
@STDOUT
before (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <slice "abc" 0 2 2>: error calling slice: cannot 3-index slice a string
[3]
```

## review-boundary:template/slice "abc" 2 1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 235 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{slice "abc" 2 1}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/slice "abc" 2 1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 236
@STDOUT
before (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <slice "abc" 2 1>: error calling slice: invalid slice index: 2 > 1
[3]
```

## review-boundary:template/slice "abc" -1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 237 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{slice "abc" -1}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/slice "abc" -1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 238
@STDOUT
before (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <slice "abc" -1>: error calling slice: index out of range: -1
[3]
```

## review-boundary:template/slice "abc" "x"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 239 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{slice "abc" "x"}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/slice "abc" "x"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 240
@STDOUT
before (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <slice "abc" "x">: error calling slice: cannot index slice/array with type string
[3]
```

## review-boundary:template/slice "abc" 0 4

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 241 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{slice "abc" 0 4}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/slice "abc" 0 4

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 242
@STDOUT
before (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <slice "abc" 0 4>: error calling slice: index out of range: 4
[3]
```

## review-boundary:template/slice . 0 1 0

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 243 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{slice . 0 1 0}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/slice . 0 1 0

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 244
@STDOUT
before (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <slice . 0 1 0>: error calling slice: invalid slice index: 1 > 0
[3]
```

## review-boundary:template/len (slice . 0 1 1)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 245 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{len (slice . 0 1 1)}}after' -
@STDOUT
before1after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/len (slice . 0 1 1)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 246
@STDOUT
before1after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template/slice "abc" 0 1 2 3

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 247 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{slice "abc" 0 1 2 3}}after' -
@STDOUT
before (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:template-multi/slice "abc" 0 1 2 3

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 248
@STDOUT
before (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <slice "abc" 0 1 2 3>: error calling slice: too many slice indexes: 4
[3]
```

## review-boundary:multi-fatal/249

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 249
@STDOUT (empty)
@STDERR
could not read "b.yml": open b.yml: no such file or directory
[3]
```

## review-boundary:multi-fatal/250

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 250
@STDOUT (empty)
@STDERR
could not parse config file "$PROJECT/.github/actionlint.yml": could not parse config file "$PROJECT/.github/actionlint.yml": yaml: unmarshal errors:   line 1: cannot unmarshal !!str `broken` into map[string]actionlint.PathConfig
[3]
```

## review-boundary:multi-fatal/251

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review_boundary 251
@STDOUT
prefix (no-eol)
@STDERR
could not format error messages: template: error formatter:1:8: executing "error formatter" at <index . 99>: error calling index: index out of range: 99
[3]
```

## review-boundary:extra-template/printf "%#g|%#g|%#g" 1.234567890123 10000000.0 1e30

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 252 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%#g|%#g|%#g" 1.234567890123 10000000.0 1e30}}after' -
@STDOUT
before1.234567890123|1.00000e+07|1.00000e+30after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:extra-template/printf "%g|%G|%#.15G" 10000000.0 1e-8 1.2345678901234567

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 253 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%g|%G|%#.15G" 10000000.0 1e-8 1.2345678901234567}}after' -
@STDOUT
before1e+07|1E-08|1.23456789012346after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:extra-template/printf "%#q|%+q|%q|%#U|%c" "abc" "é" 10 65 55296

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 254 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%#q|%+q|%q|%#U|%c" "abc" "é" 10 65 55296}}after' -
@STDOUT
before`abc`|"\u00e9"|'\n'|U+0041 'A'|�after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:extra-template/printf "%[2]*.[1]*[3]f" 2 8 1.125

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 255 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%[2]*.[1]*[3]f" 2 8 1.125}}after' -
@STDOUT
before    1.12after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:extra-template/printf "%[1]2d|%.[2]3f|%[2]*.[1]*[3]f" 2 8 1.125

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 256 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{printf "%[1]2d|%.[2]3f|%[2]*.[1]*[3]f" 2 8 1.125}}after' -
@STDOUT
before%!d(BADINDEX)|%!f(int=008)|    1.12after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:extra-template/len (slice . 0 1 1)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 257 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{len (slice . 0 1 1)}}after' -
@STDOUT
before1after (no-eol)
@STDERR (empty)
[1]
```

## review-boundary:extra-template/eq (index . 0) (index $ 0)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review_boundary.json 258 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format 'before{{eq (index . 0) (index $ 0)}}after' -
@STDOUT
beforetrueafter (no-eol)
@STDERR (empty)
[1]
```

