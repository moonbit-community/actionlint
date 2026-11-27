# Review regressions

717 migrated cases. Inputs are in [fixtures/review.json](fixtures/review.json).
Each case asserts stdout, stderr, and exit status; only elapsed milliseconds vary.

## review:matrix-type/True/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 0 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/True/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 1 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/True/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 2 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "string" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/True/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 3 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/TRUE/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 4 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/TRUE/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 5 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/TRUE/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 6 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "string" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/TRUE/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 7 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/False/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 8 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/False/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 9 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/False/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 10 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "string" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/False/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 11 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/FALSE/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 12 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/FALSE/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 13 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/FALSE/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 14 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "string" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/FALSE/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 15 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/Null/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 16 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/Null/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 17 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/Null/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 18 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "string" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/Null/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 19 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/NULL/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 20 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/NULL/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 21 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/NULL/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 22 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "string" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/NULL/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 23 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/~/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 24 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/~/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 25 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/~/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 26 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "string" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/~/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 27 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/0x10/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 28 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/0x10/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 29 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/0x10/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 30 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "string" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/0x10/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 31 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/0o10/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 32 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/0o10/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 33 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/0o10/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 34 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "string" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/0o10/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 35 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/0b10/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 36 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/0b10/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 37 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/0b10/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 38 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "string" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/0b10/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 39 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/1_000/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 40 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/1_000/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 41 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/1_000/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 42 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "number" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/1_000/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 43 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "number" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/' true '/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 44 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:35: 1st argument of function call is not assignable. "bool" cannot be assigned to "string". called function type is "startsWith(string, string) -> bool" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/' true '/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 45 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:33: 1st argument of function call is not assignable. "bool" cannot be assigned to "array<any>". called function type is "contains(array<any>, any) -> bool" [expression]
<stdin>:9:33: 1st argument of function call is not assignable. "bool" cannot be assigned to "string". called function type is "contains(string, string) -> bool" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/' true '/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 46 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "bool" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/' true '/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 47 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "bool" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/'123 '/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 48 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/'123 '/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 49 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/'123 '/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 50 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "number" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/'123 '/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 51 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "number" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/' null '/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 52 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:35: 1st argument of function call is not assignable. "null" cannot be assigned to "string". called function type is "startsWith(string, string) -> bool" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/' null '/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 53 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:33: 1st argument of function call is not assignable. "null" cannot be assigned to "array<any>". called function type is "contains(array<any>, any) -> bool" [expression]
<stdin>:9:33: 1st argument of function call is not assignable. "null" cannot be assigned to "string". called function type is "contains(string, string) -> bool" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/' null '/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 54 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "null" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/' null '/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 55 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "null" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/'1e3'/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 56 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/'1e3'/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 57 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/'1e3'/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 58 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "number" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/'1e3'/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 59 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "number" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/yes/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 60 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/yes/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 61 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/yes/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 62 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "string" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/yes/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 63 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/on/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 64 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/on/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 65 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/on/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 66 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "string" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/on/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 67 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/1.0/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 68 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/1.0/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 69 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/1.0/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 70 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "number" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/1.0/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 71 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "number" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/-0.0/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 72 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/-0.0/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 73 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/-0.0/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 74 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "number" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/-0.0/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 75 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "number" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/1e100/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 76 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/1e100/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 77 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/1e100/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 78 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "number" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/1e100/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 79 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "number" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/012/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 80 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/012/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 81 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/012/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 82 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "number" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/012/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 83 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "number" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/09/startsWith(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 84 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/09/contains(matrix.x, 'a')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 85 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-type/09/join(matrix.x)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 86 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: number of arguments is wrong. function "join(array<string>, string) -> string" takes 2 parameters but 1 arguments are given [expression]
<stdin>:9:29: 1st argument of function call is not assignable. "number" cannot be assigned to "array<string>". called function type is "join(array<string>) -> string" [expression]
@STDERR (empty)
[1]
```

## review:matrix-type/09/matrix.x.foo

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 87 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:24: receiver of object dereference "foo" must be type of object but got "number" [expression]
@STDERR (empty)
[1]
```

## review:matrix-subset/{Foo: a}/{foo: a}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 88 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-subset/{foo: a}/{Foo: a}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 89 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-subset/{Foo: {Bar: a}}/{foo: {bar: a}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 90 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-subset/{Foo: [a]}/{foo: [a]}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 91 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-key/INCLUDE

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 92 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-key/Include

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 93 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-key/EXCLUDE

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 94 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:16: value "b" in "exclude" does not match in matrix "x" combinations. possible values are "a" [matrix]
@STDERR (empty)
[1]
```

## review:matrix-key/Exclude

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 95 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:9:16: value "b" in "exclude" does not match in matrix "x" combinations. possible values are "a" [matrix]
@STDERR (empty)
[1]
```

## review:job-field/runs-on/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 96 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:14: label "null" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## review:job-field/runs-on/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 97 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:14: label "true" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## review:job-field/runs-on/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 98 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:14: label "123" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## review:job-field/runs-on/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 99 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:14: "runs-on" section should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/runs-on/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 100 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:14: "runs-on" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/runs-on/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 101 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:15: label "foo" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## review:job-field/runs-on/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 102 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:15: unexpected key "foo" for "runs-on" section. expected one of "group", "labels" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/runs-on/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 103 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:14: label "" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
<stdin>:4:14: string should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/runs-on/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 104 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:14: type of expression at "runs-on" must be string or array but found type "bool" [expression]
@STDERR (empty)
[1]
```

## review:job-field/runs-on/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 105 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:14: type of expression at "runs-on" must be string or array but found type "{action: string; action_path: string; action_ref: string; action_repository: string; action_status: string; actor: string; actor_id: string; api_url: string; artifact_cache_size_limit: number; base_ref: string; env: string; event: object; event_name: string; event_path: string; graphql_url: string; head_ref: string; job: string; output: string; path: string; ref: string; ref_name: string; ref_protected: bool; ref_type: string; repository: string; repository_id: string; repository_owner: string; repository_owner_id: string; repository_visibility: string; repositoryurl: string; retention_days: number; run_attempt: string; run_id: string; run_number: string; secret_source: string; server_url: string; sha: string; state: string; step_summary: string; token: string; triggering_actor: string; workflow: string; workflow_ref: string; workflow_sha: string; workspace: string}" [expression]
@STDERR (empty)
[1]
```

## review:job-field/needs/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 106 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: job "test" needs job "null" which does not exist in this workflow [job-needs]
@STDERR (empty)
[1]
```

## review:job-field/needs/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 107 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: job "test" needs job "true" which does not exist in this workflow [job-needs]
@STDERR (empty)
[1]
```

## review:job-field/needs/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 108 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: job "test" needs job "123" which does not exist in this workflow [job-needs]
<stdin>:5:12: invalid job ID "123". job ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review:job-field/needs/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 109 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:12: "needs" section should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/needs/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 110 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:12: "needs" section must be sequence node but got mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/needs/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 111 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: job "test" needs job "foo" which does not exist in this workflow [job-needs]
@STDERR (empty)
[1]
```

## review:job-field/needs/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 112 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:12: "needs" section must be sequence node but got mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/needs/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 113 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:12: string should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/needs/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 114 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: job "test" needs job "${{ true }}" which does not exist in this workflow [job-needs]
@STDERR (empty)
[1]
```

## review:job-field/needs/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 115 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: job "test" needs job "${{ github }}" which does not exist in this workflow [job-needs]
<stdin>:5:17: context "github" is not allowed here. no context is available here. see https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability for more details [expression]
@STDERR (empty)
[1]
```

## review:job-field/if/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 116 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:9: constant expression "null" in condition. remove the if: section [if-cond]
@STDERR (empty)
[1]
```

## review:job-field/if/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 117 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:9: constant expression "true" in condition. remove the if: section [if-cond]
@STDERR (empty)
[1]
```

## review:job-field/if/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 118 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:9: constant expression "123" in condition. remove the if: section [if-cond]
@STDERR (empty)
[1]
```

## review:job-field/if/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 119 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:9: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
<stdin>:5:9: unexpected end of input while parsing variable access, function call, null, bool, int, float or string. expecting "IDENT", "(", "INTEGER", "FLOAT", "STRING" [expression]
@STDERR (empty)
[1]
```

## review:job-field/if/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 120 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:9: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
<stdin>:5:9: unexpected end of input while parsing variable access, function call, null, bool, int, float or string. expecting "IDENT", "(", "INTEGER", "FLOAT", "STRING" [expression]
@STDERR (empty)
[1]
```

## review:job-field/if/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 121 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:9: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
<stdin>:5:9: unexpected end of input while parsing variable access, function call, null, bool, int, float or string. expecting "IDENT", "(", "INTEGER", "FLOAT", "STRING" [expression]
@STDERR (empty)
[1]
```

## review:job-field/if/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 122 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:9: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
<stdin>:5:9: unexpected end of input while parsing variable access, function call, null, bool, int, float or string. expecting "IDENT", "(", "INTEGER", "FLOAT", "STRING" [expression]
@STDERR (empty)
[1]
```

## review:job-field/if/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 123 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:9: string should not be empty [syntax-check]
<stdin>:5:9: unexpected end of input while parsing variable access, function call, null, bool, int, float or string. expecting "IDENT", "(", "INTEGER", "FLOAT", "STRING" [expression]
@STDERR (empty)
[1]
```

## review:job-field/if/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 124 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:9: constant expression "true" in condition. remove the if: section [if-cond]
@STDERR (empty)
[1]
```

## review:job-field/if/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 125 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:10: object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type {action: string; action_path: string; action_ref: string; action_repository: string; action_status: string; actor: string; actor_id: string; api_url: string; artifact_cache_size_limit: number; base_ref: string; env: string; event: object; event_name: string; event_path: string; graphql_url: string; head_ref: string; job: string; output: string; path: string; ref: string; ref_name: string; ref_protected: bool; ref_type: string; repository: string; repository_id: string; repository_owner: string; repository_owner_id: string; repository_visibility: string; repositoryurl: string; retention_days: number; run_attempt: string; run_id: string; run_number: string; secret_source: string; server_url: string; sha: string; state: string; step_summary: string; token: string; triggering_actor: string; workflow: string; workflow_ref: string; workflow_sha: string; workspace: string} [expression]
@STDERR (empty)
[1]
```

## review:job-field/permissions/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 126 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:18: "null" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
@STDERR (empty)
[1]
```

## review:job-field/permissions/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 127 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:18: "true" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
@STDERR (empty)
[1]
```

## review:job-field/permissions/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 128 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:18: "123" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
@STDERR (empty)
[1]
```

## review:job-field/permissions/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 129 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:18: "permissions" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/permissions/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 130 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/permissions/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 131 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:18: "permissions" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/permissions/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 132 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: unknown permission scope "foo". all available permission scopes are "actions", "artifact-metadata", "attestations", "checks", "contents", "deployments", "discussions", "id-token", "issues", "models", "packages", "pages", "pull-requests", "repository-projects", "security-events", "statuses" [permissions]
@STDERR (empty)
[1]
```

## review:job-field/permissions/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 133 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:18: "" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
<stdin>:5:18: string should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/permissions/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 134 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:18: "${{ true }}" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
@STDERR (empty)
[1]
```

## review:job-field/permissions/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 135 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:18: "${{ github }}" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
@STDERR (empty)
[1]
```

## review:job-field/env/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 136 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:10: expecting a single ${{...}} expression or mapping value for "env" section, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/env/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 137 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:10: expecting a single ${{...}} expression or mapping value for "env" section, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/env/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 138 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:10: expecting a single ${{...}} expression or mapping value for "env" section, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/env/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 139 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:10: "env" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/env/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 140 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:10: "env" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/env/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 141 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:10: "env" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/env/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 142 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/env/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 143 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:10: expecting a single ${{...}} expression or mapping value for "env" section, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/env/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 144 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:10: type of expression at "env" must be object but found type bool [expression]
@STDERR (empty)
[1]
```

## review:job-field/env/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 145 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/defaults/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 146 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "defaults" section should have "run" section [syntax-check]
<stdin>:5:15: "defaults" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/defaults/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 147 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "defaults" section is scalar node but mapping node is expected [syntax-check]
<stdin>:5:15: "defaults" section should have "run" section [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/defaults/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 148 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "defaults" section is scalar node but mapping node is expected [syntax-check]
<stdin>:5:15: "defaults" section should have "run" section [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/defaults/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 149 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "defaults" section is sequence node but mapping node is expected [syntax-check]
<stdin>:5:15: "defaults" section should have "run" section [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/defaults/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 150 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "defaults" section should have "run" section [syntax-check]
<stdin>:5:15: "defaults" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/defaults/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 151 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "defaults" section is sequence node but mapping node is expected [syntax-check]
<stdin>:5:15: "defaults" section should have "run" section [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/defaults/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 152 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "defaults" section should have "run" section [syntax-check]
<stdin>:5:16: expected "run" key for "defaults" section but got "foo" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/defaults/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 153 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "defaults" section is scalar node but mapping node is expected [syntax-check]
<stdin>:5:15: "defaults" section should have "run" section [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/defaults/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 154 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "defaults" section is scalar node but mapping node is expected [syntax-check]
<stdin>:5:15: "defaults" section should have "run" section [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/defaults/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 155 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "defaults" section is scalar node but mapping node is expected [syntax-check]
<stdin>:5:15: "defaults" section should have "run" section [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/concurrency/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 156 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/concurrency/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 157 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/concurrency/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 158 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/concurrency/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 159 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: group name is missing in "concurrency" section [syntax-check]
<stdin>:5:18: "concurrency" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/concurrency/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 160 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: group name is missing in "concurrency" section [syntax-check]
<stdin>:5:18: "concurrency" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/concurrency/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 161 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: group name is missing in "concurrency" section [syntax-check]
<stdin>:5:18: "concurrency" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/concurrency/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 162 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: group name is missing in "concurrency" section [syntax-check]
<stdin>:5:19: unexpected key "foo" for "concurrency" section. expected one of "cancel-in-progress", "group" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/concurrency/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 163 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:18: string should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/concurrency/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 164 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/concurrency/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 165 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type {action: string; action_path: string; action_ref: string; action_repository: string; action_status: string; actor: string; actor_id: string; api_url: string; artifact_cache_size_limit: number; base_ref: string; env: string; event: object; event_name: string; event_path: string; graphql_url: string; head_ref: string; job: string; output: string; path: string; ref: string; ref_name: string; ref_protected: bool; ref_type: string; repository: string; repository_id: string; repository_owner: string; repository_owner_id: string; repository_visibility: string; repositoryurl: string; retention_days: number; run_attempt: string; run_id: string; run_number: string; secret_source: string; server_url: string; sha: string; state: string; step_summary: string; token: string; triggering_actor: string; workflow: string; workflow_ref: string; workflow_sha: string; workspace: string} [expression]
@STDERR (empty)
[1]
```

## review:job-field/environment/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 166 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/environment/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 167 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/environment/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 168 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/environment/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 169 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: name is missing in "environment" section [syntax-check]
<stdin>:5:18: "environment" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/environment/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 170 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: name is missing in "environment" section [syntax-check]
<stdin>:5:18: "environment" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/environment/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 171 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: name is missing in "environment" section [syntax-check]
<stdin>:5:18: "environment" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/environment/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 172 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: name is missing in "environment" section [syntax-check]
<stdin>:5:19: unexpected key "foo" for "environment" section. expected one of "deployment", "name", "url" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/environment/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 173 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:18: string should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/environment/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 174 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/environment/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 175 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type {action: string; action_path: string; action_ref: string; action_repository: string; action_status: string; actor: string; actor_id: string; api_url: string; artifact_cache_size_limit: number; base_ref: string; env: string; event: object; event_name: string; event_path: string; graphql_url: string; head_ref: string; job: string; output: string; path: string; ref: string; ref_name: string; ref_protected: bool; ref_type: string; repository: string; repository_id: string; repository_owner: string; repository_owner_id: string; repository_visibility: string; repositoryurl: string; retention_days: number; run_attempt: string; run_id: string; run_number: string; secret_source: string; server_url: string; sha: string; state: string; step_summary: string; token: string; triggering_actor: string; workflow: string; workflow_ref: string; workflow_sha: string; workspace: string} [expression]
@STDERR (empty)
[1]
```

## review:job-field/container/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 176 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/container/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 177 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/container/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 178 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/container/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 179 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "image" is missing in "container" section [syntax-check]
<stdin>:5:16: "container" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/container/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 180 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "image" is missing in "container" section [syntax-check]
<stdin>:5:16: "container" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/container/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 181 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "image" is missing in "container" section [syntax-check]
<stdin>:5:16: "container" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/container/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 182 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "image" is missing in "container" section [syntax-check]
<stdin>:5:17: unexpected key "foo" for "container" section. expected one of "credentials", "env", "image", "options", "ports", "volumes" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/container/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 183 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:16: string should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/container/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 184 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/container/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 185 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:17: object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type {action: string; action_path: string; action_ref: string; action_repository: string; action_status: string; actor: string; actor_id: string; api_url: string; artifact_cache_size_limit: number; base_ref: string; env: string; event: object; event_name: string; event_path: string; graphql_url: string; head_ref: string; job: string; output: string; path: string; ref: string; ref_name: string; ref_protected: bool; ref_type: string; repository: string; repository_id: string; repository_owner: string; repository_owner_id: string; repository_visibility: string; repositoryurl: string; retention_days: number; run_attempt: string; run_id: string; run_number: string; secret_source: string; server_url: string; sha: string; state: string; step_summary: string; token: string; triggering_actor: string; workflow: string; workflow_ref: string; workflow_sha: string; workspace: string} [expression]
@STDERR (empty)
[1]
```

## review:job-field/services/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 186 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "services" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/services/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 187 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "services" section is scalar node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/services/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 188 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "services" section is scalar node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/services/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 189 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "services" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/services/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 190 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "services" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/services/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 191 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "services" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/services/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 192 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/services/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 193 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "services" section is scalar node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/services/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 194 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: type of expression at "services" must be object but found type bool [expression]
@STDERR (empty)
[1]
```

## review:job-field/services/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 195 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/strategy/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 196 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "strategy" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/strategy/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 197 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "strategy" section is scalar node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/strategy/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 198 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "strategy" section is scalar node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/strategy/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 199 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "strategy" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/strategy/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 200 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "strategy" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/strategy/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 201 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "strategy" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/strategy/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 202 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:16: unexpected key "foo" for "strategy" section. expected one of "fail-fast", "matrix", "max-parallel" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/strategy/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 203 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "strategy" section is scalar node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/strategy/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 204 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "strategy" section is scalar node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/strategy/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 205 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "strategy" section is scalar node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/snapshot/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 206 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/snapshot/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 207 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/snapshot/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 208 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/snapshot/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 209 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "snapshot" section value must be string or mapping but found sequence node [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/snapshot/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 210 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "snapshot" section must have "image-name" configuration [syntax-check]
<stdin>:5:15: "on" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/snapshot/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 211 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: "snapshot" section value must be string or mapping but found sequence node [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/snapshot/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 212 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "snapshot" section must have "image-name" configuration [syntax-check]
<stdin>:5:16: unexpected key "foo" for "snapshot" section. expected one of "if", "image-name", "version" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/snapshot/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 213 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: string should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/snapshot/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 214 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/snapshot/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 215 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/outputs/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 216 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:14: "outputs" section should not be empty [syntax-check]
<stdin>:5:14: "outputs" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/outputs/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 217 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:14: "outputs" section is scalar node but mapping node is expected [syntax-check]
<stdin>:5:14: "outputs" section should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/outputs/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 218 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:14: "outputs" section is scalar node but mapping node is expected [syntax-check]
<stdin>:5:14: "outputs" section should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/outputs/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 219 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:14: "outputs" section is sequence node but mapping node is expected [syntax-check]
<stdin>:5:14: "outputs" section should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/outputs/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 220 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:14: "outputs" section should not be empty [syntax-check]
<stdin>:5:14: "outputs" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/outputs/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 221 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:14: "outputs" section is sequence node but mapping node is expected [syntax-check]
<stdin>:5:14: "outputs" section should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/outputs/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 222 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/outputs/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 223 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:14: "outputs" section is scalar node but mapping node is expected [syntax-check]
<stdin>:5:14: "outputs" section should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/outputs/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 224 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:14: "outputs" section is scalar node but mapping node is expected [syntax-check]
<stdin>:5:14: "outputs" section should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/outputs/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 225 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:14: "outputs" section is scalar node but mapping node is expected [syntax-check]
<stdin>:5:14: "outputs" section should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/with/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 226 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "with" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:11: "with" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/with/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 227 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "with" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:11: "with" section is scalar node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/with/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 228 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "with" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:11: "with" section is scalar node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/with/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 229 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "with" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:11: "with" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/with/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 230 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "with" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:11: "with" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/with/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 231 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "with" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:11: "with" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/with/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 232 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "with" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/with/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 233 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "with" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:11: "with" section is scalar node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/with/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 234 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "with" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:11: "with" section is scalar node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/with/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 235 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "with" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:11: "with" section is scalar node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/secrets/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 236 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "secrets" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:14: expected mapping node for secrets or "inherit" string node but found "null" node [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/secrets/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 237 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "secrets" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:14: expected mapping node for secrets or "inherit" string node but found "true" node [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/secrets/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 238 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "secrets" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:14: expected mapping node for secrets or "inherit" string node but found "123" node [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/secrets/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 239 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "secrets" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:14: "secrets" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/secrets/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 240 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "secrets" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:14: "secrets" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/secrets/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 241 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "secrets" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:14: "secrets" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/secrets/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 242 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "secrets" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/secrets/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 243 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "secrets" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:14: expected mapping node for secrets or "inherit" string node but found "" node [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/secrets/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 244 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "secrets" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:14: expected mapping node for secrets or "inherit" string node but found "${{ true }}" node [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/secrets/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 245 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:5: "secrets" is only available for a reusable workflow call with "uses" but "uses" is not found in job "test" [syntax-check]
<stdin>:5:14: expected mapping node for secrets or "inherit" string node but found "${{ github }}" node [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/uses/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 246 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:5: when a reusable workflow is called with "uses", "steps" is not available. only following keys are allowed: "name", "uses", "with", "secrets", "needs", "if", and "permissions" in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/uses/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 247 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:5: when a reusable workflow is called with "uses", "steps" is not available. only following keys are allowed: "name", "uses", "with", "secrets", "needs", "if", and "permissions" in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/uses/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 248 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:5: when a reusable workflow is called with "uses", "steps" is not available. only following keys are allowed: "name", "uses", "with", "secrets", "needs", "if", and "permissions" in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/uses/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 249 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:11: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
<stdin>:6:5: when a reusable workflow is called with "uses", "steps" is not available. only following keys are allowed: "name", "uses", "with", "secrets", "needs", "if", and "permissions" in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/uses/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 250 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:11: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
<stdin>:6:5: when a reusable workflow is called with "uses", "steps" is not available. only following keys are allowed: "name", "uses", "with", "secrets", "needs", "if", and "permissions" in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/uses/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 251 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:11: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
<stdin>:6:5: when a reusable workflow is called with "uses", "steps" is not available. only following keys are allowed: "name", "uses", "with", "secrets", "needs", "if", and "permissions" in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/uses/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 252 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:11: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
<stdin>:6:5: when a reusable workflow is called with "uses", "steps" is not available. only following keys are allowed: "name", "uses", "with", "secrets", "needs", "if", and "permissions" in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/uses/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 253 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:11: string should not be empty [syntax-check]
<stdin>:6:5: when a reusable workflow is called with "uses", "steps" is not available. only following keys are allowed: "name", "uses", "with", "secrets", "needs", "if", and "permissions" in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/uses/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 254 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:5: when a reusable workflow is called with "uses", "steps" is not available. only following keys are allowed: "name", "uses", "with", "secrets", "needs", "if", and "permissions" in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/uses/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 255 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:5: when a reusable workflow is called with "uses", "steps" is not available. only following keys are allowed: "name", "uses", "with", "secrets", "needs", "if", and "permissions" in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/timeout-minutes/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 256 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:22: expected scalar node for float value but found scalar node with "!!null" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/timeout-minutes/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 257 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:22: expected scalar node for float value but found scalar node with "!!bool" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/timeout-minutes/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 258 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/timeout-minutes/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 259 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:22: expected scalar node for float value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/timeout-minutes/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 260 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:22: expected scalar node for float value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/timeout-minutes/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 261 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:22: expected scalar node for float value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/timeout-minutes/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 262 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:22: expected scalar node for float value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/timeout-minutes/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 263 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:22: expecting a single ${{...}} expression or float number literal, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/timeout-minutes/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 264 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:22: type of expression at "float number value" must be number but found type bool [expression]
@STDERR (empty)
[1]
```

## review:job-field/timeout-minutes/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 265 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:22: type of expression at "float number value" must be number but found type {action: string; action_path: string; action_ref: string; action_repository: string; action_status: string; actor: string; actor_id: string; api_url: string; artifact_cache_size_limit: number; base_ref: string; env: string; event: object; event_name: string; event_path: string; graphql_url: string; head_ref: string; job: string; output: string; path: string; ref: string; ref_name: string; ref_protected: bool; ref_type: string; repository: string; repository_id: string; repository_owner: string; repository_owner_id: string; repository_visibility: string; repositoryurl: string; retention_days: number; run_attempt: string; run_id: string; run_number: string; secret_source: string; server_url: string; sha: string; state: string; step_summary: string; token: string; triggering_actor: string; workflow: string; workflow_ref: string; workflow_sha: string; workspace: string} [expression]
@STDERR (empty)
[1]
```

## review:job-field/continue-on-error/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 266 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:24: expected bool value but found scalar node with "!!null" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/continue-on-error/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 267 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/continue-on-error/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 268 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:24: expected bool value but found scalar node with "!!int" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/continue-on-error/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 269 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:24: expected bool value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/continue-on-error/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 270 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:24: expected bool value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/continue-on-error/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 271 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:24: expected bool value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/continue-on-error/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 272 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:24: expected bool value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/continue-on-error/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 273 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:24: expecting a single ${{...}} expression or boolean literal "true" or "false", but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:job-field/continue-on-error/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 274 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:job-field/continue-on-error/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 275 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:24: type of expression must be bool but found type {action: string; action_path: string; action_ref: string; action_repository: string; action_status: string; actor: string; actor_id: string; api_url: string; artifact_cache_size_limit: number; base_ref: string; env: string; event: object; event_name: string; event_path: string; graphql_url: string; head_ref: string; job: string; output: string; path: string; ref: string; ref_name: string; ref_protected: bool; ref_type: string; repository: string; repository_id: string; repository_owner: string; repository_owner_id: string; repository_visibility: string; repositoryurl: string; retention_days: number; run_attempt: string; run_id: string; run_number: string; secret_source: string; server_url: string; sha: string; state: string; step_summary: string; token: string; triggering_actor: string; workflow: string; workflow_ref: string; workflow_sha: string; workspace: string} [expression]
@STDERR (empty)
[1]
```

## review:step-field/run/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 276 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/run/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 277 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/run/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 278 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/run/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 279 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:14: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/run/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 280 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:14: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/run/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 281 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:14: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/run/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 282 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:14: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/run/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 283 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:14: string should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/run/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 284 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/run/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 285 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:15: object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type {action: string; action_path: string; action_ref: string; action_repository: string; action_status: string; actor: string; actor_id: string; api_url: string; artifact_cache_size_limit: number; base_ref: string; env: string; event: object; event_name: string; event_path: string; graphql_url: string; head_ref: string; job: string; output: string; path: string; ref: string; ref_name: string; ref_protected: bool; ref_type: string; repository: string; repository_id: string; repository_owner: string; repository_owner_id: string; repository_visibility: string; repositoryurl: string; retention_days: number; run_attempt: string; run_id: string; run_number: string; secret_source: string; server_url: string; sha: string; state: string; step_summary: string; token: string; triggering_actor: string; workflow: string; workflow_ref: string; workflow_sha: string; workspace: string} [expression]
@STDERR (empty)
[1]
```

## review:step-field/uses/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 286 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:15: specifying action "null" in invalid format because ref is missing. available formats are "{owner}/{repo}@{ref}" or "{owner}/{repo}/{path}@{ref}" [action]
@STDERR (empty)
[1]
```

## review:step-field/uses/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 287 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:15: specifying action "true" in invalid format because ref is missing. available formats are "{owner}/{repo}@{ref}" or "{owner}/{repo}/{path}@{ref}" [action]
@STDERR (empty)
[1]
```

## review:step-field/uses/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 288 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:15: specifying action "123" in invalid format because ref is missing. available formats are "{owner}/{repo}@{ref}" or "{owner}/{repo}/{path}@{ref}" [action]
@STDERR (empty)
[1]
```

## review:step-field/uses/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 289 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:15: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
<stdin>:6:15: specifying action "" in invalid format because ref is missing. available formats are "{owner}/{repo}@{ref}" or "{owner}/{repo}/{path}@{ref}" [action]
@STDERR (empty)
[1]
```

## review:step-field/uses/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 290 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:15: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
<stdin>:6:15: specifying action "" in invalid format because ref is missing. available formats are "{owner}/{repo}@{ref}" or "{owner}/{repo}/{path}@{ref}" [action]
@STDERR (empty)
[1]
```

## review:step-field/uses/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 291 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:15: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
<stdin>:6:15: specifying action "" in invalid format because ref is missing. available formats are "{owner}/{repo}@{ref}" or "{owner}/{repo}/{path}@{ref}" [action]
@STDERR (empty)
[1]
```

## review:step-field/uses/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 292 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:15: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
<stdin>:6:15: specifying action "" in invalid format because ref is missing. available formats are "{owner}/{repo}@{ref}" or "{owner}/{repo}/{path}@{ref}" [action]
@STDERR (empty)
[1]
```

## review:step-field/uses/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 293 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:15: specifying action "" in invalid format because ref is missing. available formats are "{owner}/{repo}@{ref}" or "{owner}/{repo}/{path}@{ref}" [action]
<stdin>:6:15: string should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/uses/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 294 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/uses/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 295 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:20: context "github" is not allowed here. no context is available here. see https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability for more details [expression]
@STDERR (empty)
[1]
```

## review:step-field/if/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 296 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: constant expression "null" in condition. remove the if: section [if-cond]
@STDERR (empty)
[1]
```

## review:step-field/if/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 297 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: constant expression "true" in condition. remove the if: section [if-cond]
@STDERR (empty)
[1]
```

## review:step-field/if/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 298 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: constant expression "123" in condition. remove the if: section [if-cond]
@STDERR (empty)
[1]
```

## review:step-field/if/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 299 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
<stdin>:7:13: unexpected end of input while parsing variable access, function call, null, bool, int, float or string. expecting "IDENT", "(", "INTEGER", "FLOAT", "STRING" [expression]
@STDERR (empty)
[1]
```

## review:step-field/if/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 300 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
<stdin>:7:13: unexpected end of input while parsing variable access, function call, null, bool, int, float or string. expecting "IDENT", "(", "INTEGER", "FLOAT", "STRING" [expression]
@STDERR (empty)
[1]
```

## review:step-field/if/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 301 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
<stdin>:7:13: unexpected end of input while parsing variable access, function call, null, bool, int, float or string. expecting "IDENT", "(", "INTEGER", "FLOAT", "STRING" [expression]
@STDERR (empty)
[1]
```

## review:step-field/if/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 302 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
<stdin>:7:13: unexpected end of input while parsing variable access, function call, null, bool, int, float or string. expecting "IDENT", "(", "INTEGER", "FLOAT", "STRING" [expression]
@STDERR (empty)
[1]
```

## review:step-field/if/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 303 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: string should not be empty [syntax-check]
<stdin>:7:13: unexpected end of input while parsing variable access, function call, null, bool, int, float or string. expecting "IDENT", "(", "INTEGER", "FLOAT", "STRING" [expression]
@STDERR (empty)
[1]
```

## review:step-field/if/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 304 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: constant expression "true" in condition. remove the if: section [if-cond]
@STDERR (empty)
[1]
```

## review:step-field/if/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 305 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:14: object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type {action: string; action_path: string; action_ref: string; action_repository: string; action_status: string; actor: string; actor_id: string; api_url: string; artifact_cache_size_limit: number; base_ref: string; env: string; event: object; event_name: string; event_path: string; graphql_url: string; head_ref: string; job: string; output: string; path: string; ref: string; ref_name: string; ref_protected: bool; ref_type: string; repository: string; repository_id: string; repository_owner: string; repository_owner_id: string; repository_visibility: string; repositoryurl: string; retention_days: number; run_attempt: string; run_id: string; run_number: string; secret_source: string; server_url: string; sha: string; state: string; step_summary: string; token: string; triggering_actor: string; workflow: string; workflow_ref: string; workflow_sha: string; workspace: string} [expression]
@STDERR (empty)
[1]
```

## review:step-field/shell/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 306 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:16: shell name "null" is invalid. available names are "bash", "pwsh", "python", "sh" [shell-name]
@STDERR (empty)
[1]
```

## review:step-field/shell/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 307 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:16: shell name "true" is invalid. available names are "bash", "pwsh", "python", "sh" [shell-name]
@STDERR (empty)
[1]
```

## review:step-field/shell/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 308 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:16: shell name "123" is invalid. available names are "bash", "pwsh", "python", "sh" [shell-name]
@STDERR (empty)
[1]
```

## review:step-field/shell/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 309 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:16: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
<stdin>:7:16: shell name "" is invalid. available names are "bash", "pwsh", "python", "sh" [shell-name]
@STDERR (empty)
[1]
```

## review:step-field/shell/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 310 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:16: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
<stdin>:7:16: shell name "" is invalid. available names are "bash", "pwsh", "python", "sh" [shell-name]
@STDERR (empty)
[1]
```

## review:step-field/shell/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 311 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:16: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
<stdin>:7:16: shell name "" is invalid. available names are "bash", "pwsh", "python", "sh" [shell-name]
@STDERR (empty)
[1]
```

## review:step-field/shell/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 312 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:16: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
<stdin>:7:16: shell name "" is invalid. available names are "bash", "pwsh", "python", "sh" [shell-name]
@STDERR (empty)
[1]
```

## review:step-field/shell/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 313 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:16: shell name "" is invalid. available names are "bash", "pwsh", "python", "sh" [shell-name]
<stdin>:7:16: string should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/shell/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 314 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/shell/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 315 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:21: context "github" is not allowed here. no context is available here. see https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability for more details [expression]
@STDERR (empty)
[1]
```

## review:step-field/env/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 316 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:14: expecting a single ${{...}} expression or mapping value for "env" section, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/env/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 317 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:14: expecting a single ${{...}} expression or mapping value for "env" section, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/env/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 318 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:14: expecting a single ${{...}} expression or mapping value for "env" section, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/env/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 319 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:14: "env" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/env/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 320 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:14: "env" section should not be empty. please remove this section if it's unnecessary [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/env/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 321 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:14: "env" section is sequence node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/env/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 322 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/env/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 323 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:14: expecting a single ${{...}} expression or mapping value for "env" section, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/env/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 324 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:14: type of expression at "env" must be object but found type bool [expression]
@STDERR (empty)
[1]
```

## review:step-field/env/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 325 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/with/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 326 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:9: unexpected key "with" for step to run shell command. expected one of "continue-on-error", "env", "id", "if", "name", "run", "shell", "timeout-minutes", "working-directory" [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/with/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 327 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:9: unexpected key "with" for step to run shell command. expected one of "continue-on-error", "env", "id", "if", "name", "run", "shell", "timeout-minutes", "working-directory" [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/with/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 328 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:9: unexpected key "with" for step to run shell command. expected one of "continue-on-error", "env", "id", "if", "name", "run", "shell", "timeout-minutes", "working-directory" [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/with/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 329 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:9: unexpected key "with" for step to run shell command. expected one of "continue-on-error", "env", "id", "if", "name", "run", "shell", "timeout-minutes", "working-directory" [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/with/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 330 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:9: unexpected key "with" for step to run shell command. expected one of "continue-on-error", "env", "id", "if", "name", "run", "shell", "timeout-minutes", "working-directory" [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/with/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 331 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:9: unexpected key "with" for step to run shell command. expected one of "continue-on-error", "env", "id", "if", "name", "run", "shell", "timeout-minutes", "working-directory" [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/with/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 332 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:9: unexpected key "with" for step to run shell command. expected one of "continue-on-error", "env", "id", "if", "name", "run", "shell", "timeout-minutes", "working-directory" [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/with/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 333 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:9: unexpected key "with" for step to run shell command. expected one of "continue-on-error", "env", "id", "if", "name", "run", "shell", "timeout-minutes", "working-directory" [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/with/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 334 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:9: unexpected key "with" for step to run shell command. expected one of "continue-on-error", "env", "id", "if", "name", "run", "shell", "timeout-minutes", "working-directory" [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/with/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 335 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:9: unexpected key "with" for step to run shell command. expected one of "continue-on-error", "env", "id", "if", "name", "run", "shell", "timeout-minutes", "working-directory" [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/id/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 336 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/id/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 337 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/id/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 338 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: invalid step ID "123". step ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review:step-field/id/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 339 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/id/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 340 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/id/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 341 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/id/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 342 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/id/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 343 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: string should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/id/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 344 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/id/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 345 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:18: context "github" is not allowed here. no context is available here. see https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability for more details [expression]
@STDERR (empty)
[1]
```

## review:step-field/name/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 346 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/name/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 347 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/name/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 348 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/name/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 349 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:15: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/name/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 350 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:15: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/name/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 351 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:15: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/name/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 352 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:15: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/name/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 353 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/name/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 354 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/name/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 355 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:16: object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type {action: string; action_path: string; action_ref: string; action_repository: string; action_status: string; actor: string; actor_id: string; api_url: string; artifact_cache_size_limit: number; base_ref: string; env: string; event: object; event_name: string; event_path: string; graphql_url: string; head_ref: string; job: string; output: string; path: string; ref: string; ref_name: string; ref_protected: bool; ref_type: string; repository: string; repository_id: string; repository_owner: string; repository_owner_id: string; repository_visibility: string; repositoryurl: string; retention_days: number; run_attempt: string; run_id: string; run_number: string; secret_source: string; server_url: string; sha: string; state: string; step_summary: string; token: string; triggering_actor: string; workflow: string; workflow_ref: string; workflow_sha: string; workspace: string} [expression]
@STDERR (empty)
[1]
```

## review:step-field/timeout-minutes/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 356 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: expected scalar node for float value but found scalar node with "!!null" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/timeout-minutes/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 357 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: expected scalar node for float value but found scalar node with "!!bool" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/timeout-minutes/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 358 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/timeout-minutes/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 359 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: expected scalar node for float value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/timeout-minutes/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 360 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: expected scalar node for float value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/timeout-minutes/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 361 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: expected scalar node for float value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/timeout-minutes/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 362 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: expected scalar node for float value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/timeout-minutes/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 363 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: expecting a single ${{...}} expression or float number literal, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/timeout-minutes/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 364 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: type of expression at "float number value" must be number but found type bool [expression]
@STDERR (empty)
[1]
```

## review:step-field/timeout-minutes/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 365 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: type of expression at "float number value" must be number but found type {action: string; action_path: string; action_ref: string; action_repository: string; action_status: string; actor: string; actor_id: string; api_url: string; artifact_cache_size_limit: number; base_ref: string; env: string; event: object; event_name: string; event_path: string; graphql_url: string; head_ref: string; job: string; output: string; path: string; ref: string; ref_name: string; ref_protected: bool; ref_type: string; repository: string; repository_id: string; repository_owner: string; repository_owner_id: string; repository_visibility: string; repositoryurl: string; retention_days: number; run_attempt: string; run_id: string; run_number: string; secret_source: string; server_url: string; sha: string; state: string; step_summary: string; token: string; triggering_actor: string; workflow: string; workflow_ref: string; workflow_sha: string; workspace: string} [expression]
@STDERR (empty)
[1]
```

## review:step-field/continue-on-error/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 366 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: expected bool value but found scalar node with "!!null" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/continue-on-error/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 367 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/continue-on-error/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 368 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: expected bool value but found scalar node with "!!int" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/continue-on-error/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 369 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: expected bool value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/continue-on-error/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 370 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: expected bool value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/continue-on-error/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 371 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: expected bool value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/continue-on-error/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 372 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: expected bool value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/continue-on-error/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 373 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: expecting a single ${{...}} expression or boolean literal "true" or "false", but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/continue-on-error/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 374 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/continue-on-error/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 375 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: type of expression must be bool but found type {action: string; action_path: string; action_ref: string; action_repository: string; action_status: string; actor: string; actor_id: string; api_url: string; artifact_cache_size_limit: number; base_ref: string; env: string; event: object; event_name: string; event_path: string; graphql_url: string; head_ref: string; job: string; output: string; path: string; ref: string; ref_name: string; ref_protected: bool; ref_type: string; repository: string; repository_id: string; repository_owner: string; repository_owner_id: string; repository_visibility: string; repositoryurl: string; retention_days: number; run_attempt: string; run_id: string; run_number: string; secret_source: string; server_url: string; sha: string; state: string; step_summary: string; token: string; triggering_actor: string; workflow: string; workflow_ref: string; workflow_sha: string; workspace: string} [expression]
@STDERR (empty)
[1]
```

## review:step-field/working-directory/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 376 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/working-directory/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 377 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/working-directory/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 378 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/working-directory/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 379 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/working-directory/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 380 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/working-directory/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 381 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/working-directory/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 382 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/working-directory/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 383 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:28: string should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:step-field/working-directory/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 384 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-field/working-directory/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 385 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:29: object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type {action: string; action_path: string; action_ref: string; action_repository: string; action_status: string; actor: string; actor_id: string; api_url: string; artifact_cache_size_limit: number; base_ref: string; env: string; event: object; event_name: string; event_path: string; graphql_url: string; head_ref: string; job: string; output: string; path: string; ref: string; ref_name: string; ref_protected: bool; ref_type: string; repository: string; repository_id: string; repository_owner: string; repository_owner_id: string; repository_visibility: string; repositoryurl: string; retention_days: number; run_attempt: string; run_id: string; run_number: string; secret_source: string; server_url: string; sha: string; state: string; step_summary: string; token: string; triggering_actor: string; workflow: string; workflow_ref: string; workflow_sha: string; workspace: string} [expression]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/type/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 386 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: invalid value "null" for input type of workflow_call event. it must be one of "boolean", "number", or "string" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/type/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 387 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: invalid value "true" for input type of workflow_call event. it must be one of "boolean", "number", or "string" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/type/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 388 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: invalid value "123" for input type of workflow_call event. it must be one of "boolean", "number", or "string" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/type/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 389 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/type/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 390 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/type/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 391 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/type/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 392 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/type/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 393 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: string should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/type/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 394 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: invalid value "${{ true }}" for input type of workflow_call event. it must be one of "boolean", "number", or "string" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/type/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 395 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: invalid value "${{ github }}" for input type of workflow_call event. it must be one of "boolean", "number", or "string" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/type/boolean

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 396 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/type/number

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 397 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/type/string

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 398 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/type/choice

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 399 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: invalid value "choice" for input type of workflow_call event. it must be one of "boolean", "number", or "string" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/required/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 400 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expected bool value but found scalar node with "!!null" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/required/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 401 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/required/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 402 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expected bool value but found scalar node with "!!int" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/required/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 403 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expected bool value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/required/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 404 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expected bool value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/required/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 405 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expected bool value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/required/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 406 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expected bool value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/required/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 407 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expecting a single ${{...}} expression or boolean literal "true" or "false", but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/required/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 408 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/required/"${{ github }}"

workflow_call.required retains the expression and boolean type checks in this port; the baseline does not traverse this field.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 409 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:24: context "github" is not allowed here. no context is available here. see https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability for more details [expression]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/required/boolean

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 410 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expecting a single ${{...}} expression or boolean literal "true" or "false", but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/required/number

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 411 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expecting a single ${{...}} expression or boolean literal "true" or "false", but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/required/string

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 412 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expecting a single ${{...}} expression or boolean literal "true" or "false", but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/required/choice

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 413 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expecting a single ${{...}} expression or boolean literal "true" or "false", but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/default/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 414 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/default/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 415 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/default/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 416 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/default/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 417 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/default/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 418 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/default/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 419 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/default/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 420 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/default/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 421 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/default/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 422 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/default/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 423 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type {action: string; action_path: string; action_ref: string; action_repository: string; action_status: string; actor: string; actor_id: string; api_url: string; artifact_cache_size_limit: number; base_ref: string; env: string; event: object; event_name: string; event_path: string; graphql_url: string; head_ref: string; job: string; output: string; path: string; ref: string; ref_name: string; ref_protected: bool; ref_type: string; repository: string; repository_id: string; repository_owner: string; repository_owner_id: string; repository_visibility: string; repositoryurl: string; retention_days: number; run_attempt: string; run_id: string; run_number: string; secret_source: string; server_url: string; sha: string; state: string; step_summary: string; token: string; triggering_actor: string; workflow: string; workflow_ref: string; workflow_sha: string; workspace: string} [expression]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/default/boolean

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 424 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/default/number

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 425 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/default/string

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 426 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/default/choice

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 427 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/description/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 428 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/description/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 429 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/description/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 430 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/description/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 431 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:22: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/description/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 432 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:22: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/description/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 433 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:22: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/description/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 434 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:22: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/description/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 435 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/description/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 436 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/description/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 437 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:27: context "github" is not allowed here. no context is available here. see https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability for more details [expression]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/description/boolean

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 438 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/description/number

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 439 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/description/string

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 440 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/description/choice

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 441 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_call/options/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 442 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:9: unexpected key "options" for inputs at workflow_call event. expected one of "default", "description", "required", "type" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/options/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 443 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:9: unexpected key "options" for inputs at workflow_call event. expected one of "default", "description", "required", "type" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/options/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 444 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:9: unexpected key "options" for inputs at workflow_call event. expected one of "default", "description", "required", "type" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/options/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 445 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:9: unexpected key "options" for inputs at workflow_call event. expected one of "default", "description", "required", "type" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/options/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 446 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:9: unexpected key "options" for inputs at workflow_call event. expected one of "default", "description", "required", "type" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/options/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 447 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:9: unexpected key "options" for inputs at workflow_call event. expected one of "default", "description", "required", "type" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/options/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 448 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:9: unexpected key "options" for inputs at workflow_call event. expected one of "default", "description", "required", "type" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/options/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 449 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:9: unexpected key "options" for inputs at workflow_call event. expected one of "default", "description", "required", "type" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/options/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 450 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:9: unexpected key "options" for inputs at workflow_call event. expected one of "default", "description", "required", "type" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/options/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 451 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:9: unexpected key "options" for inputs at workflow_call event. expected one of "default", "description", "required", "type" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/options/boolean

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 452 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:9: unexpected key "options" for inputs at workflow_call event. expected one of "default", "description", "required", "type" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/options/number

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 453 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:9: unexpected key "options" for inputs at workflow_call event. expected one of "default", "description", "required", "type" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/options/string

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 454 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:9: unexpected key "options" for inputs at workflow_call event. expected one of "default", "description", "required", "type" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_call/options/choice

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 455 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:9: unexpected key "options" for inputs at workflow_call event. expected one of "default", "description", "required", "type" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/type/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 456 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: input type of workflow_dispatch event must be one of "string", "number", "boolean", "choice", "environment" but got "null" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/type/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 457 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: input type of workflow_dispatch event must be one of "string", "number", "boolean", "choice", "environment" but got "true" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/type/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 458 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: input type of workflow_dispatch event must be one of "string", "number", "boolean", "choice", "environment" but got "123" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/type/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 459 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/type/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 460 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/type/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 461 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/type/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 462 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/type/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 463 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: string should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/type/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 464 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: input type of workflow_dispatch event must be one of "string", "number", "boolean", "choice", "environment" but got "${{ true }}" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/type/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 465 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:15: input type of workflow_dispatch event must be one of "string", "number", "boolean", "choice", "environment" but got "${{ github }}" [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/type/boolean

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 466 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/type/number

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 467 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/type/string

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 468 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/type/choice

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 469 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:7: input type of "x" is "choice" but "options" is not set [events]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/required/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 470 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expected bool value but found scalar node with "!!null" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/required/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 471 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/required/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 472 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expected bool value but found scalar node with "!!int" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/required/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 473 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expected bool value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/required/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 474 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expected bool value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/required/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 475 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expected bool value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/required/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 476 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expected bool value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/required/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 477 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expecting a single ${{...}} expression or boolean literal "true" or "false", but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/required/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 478 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/required/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 479 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:24: context "github" is not allowed here. no context is available here. see https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability for more details [expression]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/required/boolean

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 480 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expecting a single ${{...}} expression or boolean literal "true" or "false", but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/required/number

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 481 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expecting a single ${{...}} expression or boolean literal "true" or "false", but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/required/string

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 482 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expecting a single ${{...}} expression or boolean literal "true" or "false", but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/required/choice

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 483 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:19: expecting a single ${{...}} expression or boolean literal "true" or "false", but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/default/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 484 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/default/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 485 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/default/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 486 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/default/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 487 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/default/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 488 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/default/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 489 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/default/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 490 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/default/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 491 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/default/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 492 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/default/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 493 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:23: context "github" is not allowed here. no context is available here. see https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability for more details [expression]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/default/boolean

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 494 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/default/number

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 495 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/default/string

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 496 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/default/choice

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 497 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/description/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 498 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/description/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 499 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/description/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 500 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/description/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 501 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:22: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/description/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 502 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:22: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/description/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 503 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:22: expected scalar node for string value but found sequence node with "!!seq" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/description/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 504 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:22: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/description/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 505 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/description/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 506 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/description/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 507 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:27: context "github" is not allowed here. no context is available here. see https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability for more details [expression]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/description/boolean

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 508 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/description/number

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 509 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/description/string

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 510 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/description/choice

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 511 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:event-field/workflow_dispatch/options/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 512 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: "options" section must be sequence node but got scalar node with "!!null" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/options/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 513 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: "options" section must be sequence node but got scalar node with "!!bool" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/options/123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 514 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: "options" section must be sequence node but got scalar node with "!!int" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/options/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 515 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: "options" section should not be empty [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/options/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 516 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: "options" section must be sequence node but got mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/options/[foo]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 517 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:7: "options" can not be set to "x" input because its input type is not "choice" [events]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/options/{foo: bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 518 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: "options" section must be sequence node but got mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/options/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 519 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: "options" section must be sequence node but got scalar node with "!!str" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/options/"${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 520 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: "options" section must be sequence node but got scalar node with "!!str" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/options/"${{ github }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 521 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: "options" section must be sequence node but got scalar node with "!!str" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/options/boolean

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 522 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: "options" section must be sequence node but got scalar node with "!!str" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/options/number

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 523 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: "options" section must be sequence node but got scalar node with "!!str" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/options/string

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 524 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: "options" section must be sequence node but got scalar node with "!!str" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:event-field/workflow_dispatch/options/choice

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 525 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:18: "options" section must be sequence node but got scalar node with "!!str" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:template/printf "%e" 1.25

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 526 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ printf "%e" 1.25 }}' -
@STDOUT
1.250000e+00 (no-eol)
@STDERR (empty)
[1]
```

## review:template/printf "%g" 1.25

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 527 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ printf "%g" 1.25 }}' -
@STDOUT
1.25 (no-eol)
@STDERR (empty)
[1]
```

## review:template/printf "%F" 1.25

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 528 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ printf "%F" 1.25 }}' -
@STDOUT
1.250000 (no-eol)
@STDERR (empty)
[1]
```

## review:template/printf "%x" "abc"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 529 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ printf "%x" "abc" }}' -
@STDOUT
616263 (no-eol)
@STDERR (empty)
[1]
```

## review:template/printf "%[2]s %[1]s" "a" "b"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 530 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ printf "%[2]s %[1]s" "a" "b" }}' -
@STDOUT
b a (no-eol)
@STDERR (empty)
[1]
```

## review:template/printf "%*s" 3 "a"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 531 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ printf "%*s" 3 "a" }}' -
@STDOUT
"  a" (escaped) (no-eol)
@STDERR (empty)
[1]
```

## review:template/printf "%q" 10

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 532 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ printf "%q" 10 }}' -
@STDOUT
'\n' (no-eol)
@STDERR (empty)
[1]
```

## review:template/printf "%.0f" 2.5

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 533 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ printf "%.0f" 2.5 }}' -
@STDOUT
2 (no-eol)
@STDERR (empty)
[1]
```

## review:template/printf "%#08x" 1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 534 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ printf "%#08x" 1 }}' -
@STDOUT
0x00000001 (no-eol)
@STDERR (empty)
[1]
```

## review:template/len "中文"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 535 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ len "中文" }}' -
@STDOUT
6 (no-eol)
@STDERR (empty)
[1]
```

## review:template/slice "中文" 0 3

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 536 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ slice "中文" 0 3 }}' -
@STDOUT
中 (no-eol)
@STDERR (empty)
[1]
```

## review:template/index "中文" 0

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 537 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ index "中文" 0 }}' -
@STDOUT
228 (no-eol)
@STDERR (empty)
[1]
```

## review:template/html "a'b"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 538 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ html "a'\''b" }}' -
@STDOUT
a&#39;b (no-eol)
@STDERR (empty)
[1]
```

## review:template/urlquery "a b~"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 539 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ urlquery "a b~" }}' -
@STDOUT
a+b~ (no-eol)
@STDERR (empty)
[1]
```

## review:template/printf "%+v" (index . 0)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 540 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ printf "%+v" (index . 0) }}' -
@STDOUT
&{Message:undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" Filepath:<stdin> Line:6 Column:24 Kind:expression Snippet:      - run: echo "${{ missing }}"
"                       ^~~~~~~ EndColumn:30}" (escaped) (no-eol)
@STDERR (empty)
[1]
```

## review:cron/TZ=Asia/Shanghai */5 * * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 541 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:cron/TZ=UTC * * * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 542 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: scheduled job runs too frequently. it runs once per 60 seconds. the shortest interval is once every 5 minutes [events]
@STDERR (empty)
[1]
```

## review:cron/TZ=America/New_York */5 * * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 543 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:cron/TZ=Asia/Kathmandu */5 * * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 544 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:cron/* * * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 545 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: scheduled job runs too frequently. it runs once per 60 seconds. the shortest interval is once every 5 minutes [events]
@STDERR (empty)
[1]
```

## review:cron/*/5* * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 546 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:cron/*/5\r* * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 547 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:cron/*/5 * * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 548 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:cron/  */5 * * * *  

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 549 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:config/paths: {true: {ignore: ["unknown"]}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 550
@STDOUT
<stdin>:6:24: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:config/paths: {"**": {ignore: [null]}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 551
@STDOUT
<stdin>:6:24: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:config/paths: {"**": {ignore: [[]]}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 552
@STDOUT (empty)
@STDERR (empty)
```

## review:config/paths: {"**": {ignore: [true]}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 553
@STDOUT
<stdin>:6:24: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:config/paths: {"**": {ignore: [{foo: bar}]}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 554
@STDOUT (empty)
@STDERR (empty)
```

## review:config/self-hosted-runner: {labels: [yes, on, null, true]}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 555
@STDOUT
<stdin>:6:24: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:config/config-variables: [true, 10, null]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 556
@STDOUT
<stdin>:6:24: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:config/unknown: {x: 1, x: 2}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 557
@STDOUT
<stdin>:6:24: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:permissions-case/Contents

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 558 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: unknown permission scope "Contents". all available permission scopes are "actions", "artifact-metadata", "attestations", "checks", "contents", "deployments", "discussions", "id-token", "issues", "models", "packages", "pages", "pull-requests", "repository-projects", "security-events", "statuses" [permissions]
@STDERR (empty)
[1]
```

## review:permissions-case/CONTENTS

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 559 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: unknown permission scope "CONTENTS". all available permission scopes are "actions", "artifact-metadata", "attestations", "checks", "contents", "deployments", "discussions", "id-token", "issues", "models", "packages", "pages", "pull-requests", "repository-projects", "security-events", "statuses" [permissions]
@STDERR (empty)
[1]
```

## review:permissions-case/Issues

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 560 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: unknown permission scope "Issues". all available permission scopes are "actions", "artifact-metadata", "attestations", "checks", "contents", "deployments", "discussions", "id-token", "issues", "models", "packages", "pages", "pull-requests", "repository-projects", "security-events", "statuses" [permissions]
@STDERR (empty)
[1]
```

## review:permissions-case/ID-token

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 561 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: unknown permission scope "ID-token". all available permission scopes are "actions", "artifact-metadata", "attestations", "checks", "contents", "deployments", "discussions", "id-token", "issues", "models", "packages", "pages", "pull-requests", "repository-projects", "security-events", "statuses" [permissions]
@STDERR (empty)
[1]
```

## review:permissions-case/Actions

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 562 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:19: unknown permission scope "Actions". all available permission scopes are "actions", "artifact-metadata", "attestations", "checks", "contents", "deployments", "discussions", "id-token", "issues", "models", "packages", "pages", "pull-requests", "repository-projects", "security-events", "statuses" [permissions]
@STDERR (empty)
[1]
```

## review:matrix-case/include/[{os: bad-runner}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 563 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:10:24: property "name" is not defined in object type {os: string; x: string} [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/include/"${{ fromJSON('[1]') }}"

Elements of an include expression must be objects; the port retains this stricter validation for all casing variants, while the baseline misses non-object elements.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 564 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression at "include" must be object but found type number [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/include/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 565 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:23: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/include/[{name: a}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 566 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-case/INCLUDE/[{os: bad-runner}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 567 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:10:24: property "name" is not defined in object type {os: string; x: string} [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/INCLUDE/"${{ fromJSON('[1]') }}"

Elements of an include expression must be objects; the port retains this stricter validation for all casing variants, while the baseline misses non-object elements.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 568 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression at "include" must be object but found type number [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/INCLUDE/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 569 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:23: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/INCLUDE/[{name: a}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 570 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-case/Include/[{os: bad-runner}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 571 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:10:24: property "name" is not defined in object type {os: string; x: string} [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/Include/"${{ fromJSON('[1]') }}"

Elements of an include expression must be objects; the port retains this stricter validation for all casing variants, while the baseline misses non-object elements.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 572 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression at "include" must be object but found type number [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/Include/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 573 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:23: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/Include/[{name: a}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 574 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:matrix-case/exclude/[{os: bad-runner}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 575 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:20: "os" in "exclude" section does not exist in matrix. available matrix configurations are "x" [matrix]
<stdin>:10:24: property "name" is not defined in object type {x: string} [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/exclude/"${{ fromJSON('[1]') }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 576 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression at "exclude" must be object but found type number [expression]
<stdin>:10:24: property "name" is not defined in object type {x: string} [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/exclude/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 577 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:23: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
<stdin>:10:24: property "name" is not defined in object type {x: string} [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/exclude/[{name: a}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 578 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:20: "name" in "exclude" section does not exist in matrix. available matrix configurations are "x" [matrix]
<stdin>:10:24: property "name" is not defined in object type {x: string} [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/EXCLUDE/[{os: bad-runner}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 579 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:20: "os" in "exclude" section does not exist in matrix. available matrix configurations are "x" [matrix]
<stdin>:10:24: property "name" is not defined in object type {x: string} [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/EXCLUDE/"${{ fromJSON('[1]') }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 580 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression at "exclude" must be object but found type number [expression]
<stdin>:10:24: property "name" is not defined in object type {x: string} [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/EXCLUDE/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 581 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:23: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
<stdin>:10:24: property "name" is not defined in object type {x: string} [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/EXCLUDE/[{name: a}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 582 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:20: "name" in "exclude" section does not exist in matrix. available matrix configurations are "x" [matrix]
<stdin>:10:24: property "name" is not defined in object type {x: string} [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/Exclude/[{os: bad-runner}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 583 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:20: "os" in "exclude" section does not exist in matrix. available matrix configurations are "x" [matrix]
<stdin>:10:24: property "name" is not defined in object type {x: string} [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/Exclude/"${{ fromJSON('[1]') }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 584 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:18: type of expression at "exclude" must be object but found type number [expression]
<stdin>:10:24: property "name" is not defined in object type {x: string} [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/Exclude/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 585 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:23: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
<stdin>:10:24: property "name" is not defined in object type {x: string} [expression]
@STDERR (empty)
[1]
```

## review:matrix-case/Exclude/[{name: a}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 586 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:8:20: "name" in "exclude" section does not exist in matrix. available matrix configurations are "x" [matrix]
<stdin>:10:24: property "name" is not defined in object type {x: string} [expression]
@STDERR (empty)
[1]
```

## review:combined-inputs/workflow_call

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 587 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:combined-inputs/workflow_dispatch

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 588 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:expr-traversal/permissions/missing

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 589 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:18: "${{ missing }}" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
@STDERR (empty)
[1]
```

## review:expr-traversal/permissions/github.ref

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 590 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:18: "${{ github.ref }}" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
@STDERR (empty)
[1]
```

## review:expr-traversal/permissions/1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 591 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:18: "${{ 1 }}" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
@STDERR (empty)
[1]
```

## review:expr-traversal/permissions/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 592 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:18: "${{ true }}" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
@STDERR (empty)
[1]
```

## review:expr-traversal/permissions/fromJSON('{}')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 593 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:18: "${{ fromJSON('{}') }}" is invalid for permission for all the scopes. available values are "read-all", "write-all" or {} [permissions]
@STDERR (empty)
[1]
```

## review:expr-traversal/needs/missing

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 594 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: job "test" needs job "${{ missing }}" which does not exist in this workflow [job-needs]
<stdin>:5:17: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:expr-traversal/needs/github.ref

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 595 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: job "test" needs job "${{ github.ref }}" which does not exist in this workflow [job-needs]
<stdin>:5:17: context "github" is not allowed here. no context is available here. see https://docs.github.com/en/actions/learn-github-actions/contexts#context-availability for more details [expression]
@STDERR (empty)
[1]
```

## review:expr-traversal/needs/1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 596 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: job "test" needs job "${{ 1 }}" which does not exist in this workflow [job-needs]
@STDERR (empty)
[1]
```

## review:expr-traversal/needs/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 597 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: job "test" needs job "${{ true }}" which does not exist in this workflow [job-needs]
@STDERR (empty)
[1]
```

## review:expr-traversal/needs/fromJSON('{}')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 598 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: job "test" needs job "${{ fromjson('{}') }}" which does not exist in this workflow [job-needs]
<stdin>:5:13: object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type {} [expression]
@STDERR (empty)
[1]
```

## review:expr-traversal/uses/missing

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 599 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:5: when a reusable workflow is called with "uses", "steps" is not available. only following keys are allowed: "name", "uses", "with", "secrets", "needs", "if", and "permissions" in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:expr-traversal/uses/github.ref

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 600 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:5: when a reusable workflow is called with "uses", "steps" is not available. only following keys are allowed: "name", "uses", "with", "secrets", "needs", "if", and "permissions" in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:expr-traversal/uses/1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 601 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:5: when a reusable workflow is called with "uses", "steps" is not available. only following keys are allowed: "name", "uses", "with", "secrets", "needs", "if", and "permissions" in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:expr-traversal/uses/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 602 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:5: when a reusable workflow is called with "uses", "steps" is not available. only following keys are allowed: "name", "uses", "with", "secrets", "needs", "if", and "permissions" in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:expr-traversal/uses/fromJSON('{}')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 603 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:5: when a reusable workflow is called with "uses", "steps" is not available. only following keys are allowed: "name", "uses", "with", "secrets", "needs", "if", and "permissions" in job "test" [syntax-check]
@STDERR (empty)
[1]
```

## review:expr-traversal/snapshot/missing

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 604 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:expr-traversal/snapshot/github.ref

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 605 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:expr-traversal/snapshot/1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 606 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:expr-traversal/snapshot/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 607 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:expr-traversal/snapshot/fromJSON('{}')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 608 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:top/name/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 609 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:2:12: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:top/name/{foo: "${{ missing }}"}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 610 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:2:7: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:top/env/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 611 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:2:11: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:top/env/{foo: "${{ missing }}"}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 612 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:2:17: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:top/on/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 613 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:5: unknown Webhook event "${{ missing }}". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
@STDERR (empty)
[1]
```

## review:top/on/{foo: "${{ missing }}"}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 614 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:1:6: unknown Webhook event "foo". see https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#webhook-events for list of all Webhook event names [events]
<stdin>:1:11: "foo" section is scalar node but mapping node is expected [syntax-check]
@STDERR (empty)
[1]
```

## review:top/run-name/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 615 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:2:16: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:top/run-name/{foo: "${{ missing }}"}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 616 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:2:11: expected scalar node for string value but found mapping node with "!!map" tag [syntax-check]
@STDERR (empty)
[1]
```

## review:top/defaults/"${{ missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 617 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:2:11: "defaults" section is scalar node but mapping node is expected [syntax-check]
<stdin>:2:11: "defaults" section should have "run" section [syntax-check]
@STDERR (empty)
[1]
```

## review:top/defaults/{foo: "${{ missing }}"}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 618 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:2:11: "defaults" section should have "run" section [syntax-check]
<stdin>:2:12: expected "run" key for "defaults" section but got "foo" [syntax-check]
@STDERR (empty)
[1]
```

## review:required-case/true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 619 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:18: input "x" of workflow_call event has the default value "a", but it is also required. if an input is marked as required, its default value will never be used [events]
@STDERR (empty)
[1]
```

## review:required-case/True

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 620 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:required-case/TRUE

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 621 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:required-case/false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 622 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:required-case/False

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 623 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:required-case/FALSE

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 624 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:template-helper/replace "abc" "" "-"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 625 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ replace "abc" "" "-" }}' -
@STDOUT
-a-b-c- (no-eol)
@STDERR (empty)
[1]
```

## review:template-helper/toPascalCase "hello_world"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 626 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ toPascalCase "hello_world" }}' -
@STDOUT
HelloWorld (no-eol)
@STDERR (empty)
[1]
```

## review:template-helper/toPascalCase "héllo-world"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 627 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ toPascalCase "héllo-world" }}' -
@STDOUT
HLloWorld (no-eol)
@STDERR (empty)
[1]
```

## review:template-helper/toPascalCase "FOO-bar"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 628 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ toPascalCase "FOO-bar" }}' -
@STDOUT
FOOBar (no-eol)
@STDERR (empty)
[1]
```

## review:template-helper/html 1 2

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 629 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ html 1 2 }}' -
@STDOUT
1 2 (no-eol)
@STDERR (empty)
[1]
```

## review:template-helper/js 1 2

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 630 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ js 1 2 }}' -
@STDOUT
1 2 (no-eol)
@STDERR (empty)
[1]
```

## review:template-helper/urlquery 1 2

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 631 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ urlquery 1 2 }}' -
@STDOUT
1+2 (no-eol)
@STDERR (empty)
[1]
```

## review:template-helper/js "a&<b>"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 632 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ js "a&<b>" }}' -
@STDOUT
a\u0026\u003Cb\u003E (no-eol)
@STDERR (empty)
[1]
```

## review:template-helper/js "a=b"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 633 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ js "a=b" }}' -
@STDOUT
a\u003Db (no-eol)
@STDERR (empty)
[1]
```

## review:template-helper/slice "abc" 0 2 2

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 634 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ slice "abc" 0 2 2 }}' -
@STDOUT (empty)
@STDERR (empty)
[1]
```

## review:template-helper/eq . .

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 635 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ eq . . }}' -
@STDOUT (empty)
@STDERR (empty)
[1]
```

## review:template-helper/eq (index . 0) (index . 0)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 636 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ eq (index . 0) (index . 0) }}' -
@STDOUT
true (no-eol)
@STDERR (empty)
[1]
```

## review:template-helper/index (index . 0) "Message"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 637 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{ index (index . 0) "Message" }}' -
@STDOUT (empty)
@STDERR (empty)
[1]
```

## review:unicode-expression/echo "${{ '中文' && missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 638 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:33: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:unicode-expression/echo "${{ '😀' && missing }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 639 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:32: undefined variable "missing". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:unicode-expression/echo "${{ '中文'.a }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 640 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:25: receiver of object dereference "a" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review:unicode-expression/echo "${{ '😀'.a }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 641 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:25: receiver of object dereference "a" must be type of object but got "string" [expression]
@STDERR (empty)
[1]
```

## review:unicode-expression/echo "${{ true }}"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 642 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:29: got unexpected character '\u00a0' while lexing expression, expecting 'a'..'z', 'A'..'Z', '_', '0'..'9', ''', '}', '(', ')', '[', ']', '.', '!', '<', '>', '=', '&', '|', '*', ',', ' ' [expression]
@STDERR (empty)
[1]
```

## review:metadata-required/true/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 643
@STDOUT
.github/workflows/main.yml:4:11: input "x" is required by "./.github/workflows/call.yml" reusable workflow [workflow-call]
@STDERR (empty)
[1]
```

## review:metadata-required/true/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 644
@STDOUT (empty)
@STDERR (empty)
```

## review:metadata-required/true/false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 645
@STDOUT (empty)
@STDERR (empty)
```

## review:metadata-required/true/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 646
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/call.yml": yaml: unmarshal errors:   line 7: cannot unmarshal !!seq into string [workflow-call]
@STDERR (empty)
[1]
```

## review:metadata-required/true/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 647
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/call.yml": yaml: unmarshal errors:   line 7: cannot unmarshal !!map into string [workflow-call]
@STDERR (empty)
[1]
```

## review:metadata-required/True/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 648
@STDOUT
.github/workflows/main.yml:4:11: input "x" is required by "./.github/workflows/call.yml" reusable workflow [workflow-call]
@STDERR (empty)
[1]
```

## review:metadata-required/True/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 649
@STDOUT (empty)
@STDERR (empty)
```

## review:metadata-required/True/false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 650
@STDOUT (empty)
@STDERR (empty)
```

## review:metadata-required/True/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 651
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/call.yml": yaml: unmarshal errors:   line 7: cannot unmarshal !!seq into string [workflow-call]
@STDERR (empty)
[1]
```

## review:metadata-required/True/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 652
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/call.yml": yaml: unmarshal errors:   line 7: cannot unmarshal !!map into string [workflow-call]
@STDERR (empty)
[1]
```

## review:metadata-required/TRUE/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 653
@STDOUT
.github/workflows/main.yml:4:11: input "x" is required by "./.github/workflows/call.yml" reusable workflow [workflow-call]
@STDERR (empty)
[1]
```

## review:metadata-required/TRUE/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 654
@STDOUT (empty)
@STDERR (empty)
```

## review:metadata-required/TRUE/false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 655
@STDOUT (empty)
@STDERR (empty)
```

## review:metadata-required/TRUE/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 656
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/call.yml": yaml: unmarshal errors:   line 7: cannot unmarshal !!seq into string [workflow-call]
@STDERR (empty)
[1]
```

## review:metadata-required/TRUE/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 657
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/call.yml": yaml: unmarshal errors:   line 7: cannot unmarshal !!map into string [workflow-call]
@STDERR (empty)
[1]
```

## review:metadata-required/yes/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 658
@STDOUT
.github/workflows/main.yml:4:11: input "x" is required by "./.github/workflows/call.yml" reusable workflow [workflow-call]
@STDERR (empty)
[1]
```

## review:metadata-required/yes/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 659
@STDOUT (empty)
@STDERR (empty)
```

## review:metadata-required/yes/false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 660
@STDOUT (empty)
@STDERR (empty)
```

## review:metadata-required/yes/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 661
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/call.yml": yaml: unmarshal errors:   line 7: cannot unmarshal !!seq into string [workflow-call]
@STDERR (empty)
[1]
```

## review:metadata-required/yes/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 662
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/call.yml": yaml: unmarshal errors:   line 7: cannot unmarshal !!map into string [workflow-call]
@STDERR (empty)
[1]
```

## review:metadata-required/on/null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 663
@STDOUT
.github/workflows/main.yml:4:11: input "x" is required by "./.github/workflows/call.yml" reusable workflow [workflow-call]
@STDERR (empty)
[1]
```

## review:metadata-required/on/''

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 664
@STDOUT (empty)
@STDERR (empty)
```

## review:metadata-required/on/false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 665
@STDOUT (empty)
@STDERR (empty)
```

## review:metadata-required/on/[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 666
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/call.yml": yaml: unmarshal errors:   line 7: cannot unmarshal !!seq into string [workflow-call]
@STDERR (empty)
[1]
```

## review:metadata-required/on/{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 667
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/call.yml": yaml: unmarshal errors:   line 7: cannot unmarshal !!map into string [workflow-call]
@STDERR (empty)
[1]
```

## review:action-metadata/node20/inputs: {x: {required: true, default: null}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 668
@STDOUT
.github/workflows/main.yml:6:15: "image" is not allowed in "runs" section because "local" is a JavaScript action. the action is defined at "$PROJECT/local" [action]
.github/workflows/main.yml:6:15: file "main.js" does not exist in "$PROJECT/local". it is specified at "main" key in "runs" section in "local" action [action]
.github/workflows/main.yml:6:15: missing input "x" which is required by action "local" defined at "./local". all required inputs are "x" [action]
@STDERR (empty)
[1]
```

## review:action-metadata/node20/inputs: {x: {required: true, default: ""}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 669
@STDOUT
.github/workflows/main.yml:6:15: "image" is not allowed in "runs" section because "local" is a JavaScript action. the action is defined at "$PROJECT/local" [action]
.github/workflows/main.yml:6:15: file "main.js" does not exist in "$PROJECT/local". it is specified at "main" key in "runs" section in "local" action [action]
@STDERR (empty)
[1]
```

## review:action-metadata/node20/inputs: {x: {required: true, default: false}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 670
@STDOUT
.github/workflows/main.yml:6:15: "image" is not allowed in "runs" section because "local" is a JavaScript action. the action is defined at "$PROJECT/local" [action]
.github/workflows/main.yml:6:15: file "main.js" does not exist in "$PROJECT/local". it is specified at "main" key in "runs" section in "local" action [action]
@STDERR (empty)
[1]
```

## review:action-metadata/node20/name: null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 671
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 8: mapping key "name" already defined at line 1 [action]
@STDERR (empty)
[1]
```

## review:action-metadata/node20/runs: null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 672
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 8: mapping key "runs" already defined at line 3 [action]
@STDERR (empty)
[1]
```

## review:action-metadata/node20/unknown: {x: 1, x: 2}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 673
@STDOUT
.github/workflows/main.yml:6:15: "image" is not allowed in "runs" section because "local" is a JavaScript action. the action is defined at "$PROJECT/local" [action]
.github/workflows/main.yml:6:15: file "main.js" does not exist in "$PROJECT/local". it is specified at "main" key in "runs" section in "local" action [action]
@STDERR (empty)
[1]
```

## review:action-metadata/composite/inputs: {x: {required: true, default: null}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 674
@STDOUT
.github/workflows/main.yml:6:15: "image" is not allowed in "runs" section because "local" is a Composite action. the action is defined at "$PROJECT/local" [action]
.github/workflows/main.yml:6:15: "main" is not allowed in "runs" section because "local" is a Composite action. the action is defined at "$PROJECT/local" [action]
.github/workflows/main.yml:6:15: missing input "x" which is required by action "local" defined at "./local". all required inputs are "x" [action]
@STDERR (empty)
[1]
```

## review:action-metadata/composite/inputs: {x: {required: true, default: ""}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 675
@STDOUT
.github/workflows/main.yml:6:15: "image" is not allowed in "runs" section because "local" is a Composite action. the action is defined at "$PROJECT/local" [action]
.github/workflows/main.yml:6:15: "main" is not allowed in "runs" section because "local" is a Composite action. the action is defined at "$PROJECT/local" [action]
@STDERR (empty)
[1]
```

## review:action-metadata/composite/inputs: {x: {required: true, default: false}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 676
@STDOUT
.github/workflows/main.yml:6:15: "image" is not allowed in "runs" section because "local" is a Composite action. the action is defined at "$PROJECT/local" [action]
.github/workflows/main.yml:6:15: "main" is not allowed in "runs" section because "local" is a Composite action. the action is defined at "$PROJECT/local" [action]
@STDERR (empty)
[1]
```

## review:action-metadata/composite/name: null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 677
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 8: mapping key "name" already defined at line 1 [action]
@STDERR (empty)
[1]
```

## review:action-metadata/composite/runs: null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 678
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 8: mapping key "runs" already defined at line 3 [action]
@STDERR (empty)
[1]
```

## review:action-metadata/composite/unknown: {x: 1, x: 2}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 679
@STDOUT
.github/workflows/main.yml:6:15: "image" is not allowed in "runs" section because "local" is a Composite action. the action is defined at "$PROJECT/local" [action]
.github/workflows/main.yml:6:15: "main" is not allowed in "runs" section because "local" is a Composite action. the action is defined at "$PROJECT/local" [action]
@STDERR (empty)
[1]
```

## review:action-metadata/docker/inputs: {x: {required: true, default: null}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 680
@STDOUT
.github/workflows/main.yml:6:15: "main" is not allowed in "runs" section because "local" is a Docker action. the action is defined at "$PROJECT/local" [action]
.github/workflows/main.yml:6:15: file "Dockerfile" does not exist in "$PROJECT/local". it is specified at "image" key in "runs" section in "local" action [action]
.github/workflows/main.yml:6:15: missing input "x" which is required by action "local" defined at "./local". all required inputs are "x" [action]
@STDERR (empty)
[1]
```

## review:action-metadata/docker/inputs: {x: {required: true, default: ""}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 681
@STDOUT
.github/workflows/main.yml:6:15: "main" is not allowed in "runs" section because "local" is a Docker action. the action is defined at "$PROJECT/local" [action]
.github/workflows/main.yml:6:15: file "Dockerfile" does not exist in "$PROJECT/local". it is specified at "image" key in "runs" section in "local" action [action]
@STDERR (empty)
[1]
```

## review:action-metadata/docker/inputs: {x: {required: true, default: false}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 682
@STDOUT
.github/workflows/main.yml:6:15: "main" is not allowed in "runs" section because "local" is a Docker action. the action is defined at "$PROJECT/local" [action]
.github/workflows/main.yml:6:15: file "Dockerfile" does not exist in "$PROJECT/local". it is specified at "image" key in "runs" section in "local" action [action]
@STDERR (empty)
[1]
```

## review:action-metadata/docker/name: null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 683
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 8: mapping key "name" already defined at line 1 [action]
@STDERR (empty)
[1]
```

## review:action-metadata/docker/runs: null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 684
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 8: mapping key "runs" already defined at line 3 [action]
@STDERR (empty)
[1]
```

## review:action-metadata/docker/unknown: {x: 1, x: 2}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 685
@STDOUT
.github/workflows/main.yml:6:15: "main" is not allowed in "runs" section because "local" is a Docker action. the action is defined at "$PROJECT/local" [action]
.github/workflows/main.yml:6:15: file "Dockerfile" does not exist in "$PROJECT/local". it is specified at "image" key in "runs" section in "local" action [action]
@STDERR (empty)
[1]
```

## review:alias/128

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 686 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:1: unexpected key "foo" for "workflow" section. expected one of "concurrency", "defaults", "env", "jobs", "name", "on", "permissions", "run-name" [syntax-check]
@STDERR (empty)
[1]
```

## review:alias/129

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 687 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:2:67: unexpected key "x" for "job" section. expected one of "concurrency", "container", "continue-on-error", "defaults", "env", "environment", "if", "name", "needs", "outputs", "permissions", "runs-on", "secrets", "services", "snapshot", "steps", "strategy", "timeout-minutes", "uses", "with" [syntax-check]
<stdin>:2:70: recursive alias "a" is found. anchor was declared at line:2, column:14 [syntax-check]
@STDERR (empty)
[1]
```

## review:filter-merge/(fromJSON('[{"x":1}]').* || fromJSON('[{"x":2}]').*).x

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 688 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:30: receiver of object dereference "x" must be type of object but got "array<{x: number}>" [expression]
@STDERR (empty)
[1]
```

## review:filter-merge/(fromJSON('[{"x":1}]').* || fromJSON('[{"x":2}]')).x

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 689 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:30: receiver of object dereference "x" must be type of object but got "array<{x: number}>" [expression]
@STDERR (empty)
[1]
```

## review:filter-merge/(fromJSON('[{"x":1}]').* && fromJSON('[{"x":2}]').*).x

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 690 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:30: receiver of object dereference "x" must be type of object but got "array<{x: number}>" [expression]
@STDERR (empty)
[1]
```

## review:filter-merge/(fromJSON('[{"x":1}]').* && fromJSON('[{"x":2}]')).x

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 691 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:30: receiver of object dereference "x" must be type of object but got "array<{x: number}>" [expression]
@STDERR (empty)
[1]
```

## review:job-id-expression/${{ bad

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 692 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: invalid job ID "${{ bad". job ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review:step-id-expression/${{ bad

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 693 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: invalid step ID "${{ bad". step ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review:job-id-expression/abc${{

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 694 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: invalid job ID "abc${{". job ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review:step-id-expression/abc${{

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 695 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: invalid step ID "abc${{". step ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review:job-id-expression/foo}}${{bar

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 696 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: invalid job ID "foo}}${{bar". job ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review:step-id-expression/foo}}${{bar

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 697 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: invalid step ID "foo}}${{bar". step ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review:job-id-expression/${{

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 698 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:3: invalid job ID "${{". job ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review:step-id-expression/${{

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 699 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: invalid step ID "${{". step ID must start with a letter or _ and contain only alphanumeric characters, -, or _ [id]
@STDERR (empty)
[1]
```

## review:job-id-expression/${{ }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 700 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-id-expression/${{ }}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 701 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:18: unexpected end of input while parsing variable access, function call, null, bool, int, float or string. expecting "IDENT", "(", "INTEGER", "FLOAT", "STRING" [expression]
@STDERR (empty)
[1]
```

## review:job-id-expression/${{bad}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 702 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:step-id-expression/${{bad}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 703 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:17: undefined variable "bad". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## review:metadata-duplicate/description

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 704
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 6: mapping key "description" already defined at line 2 [action]
@STDERR (empty)
[1]
```

## review:metadata-duplicate/name

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 705
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 6: mapping key "name" already defined at line 1 [action]
@STDERR (empty)
[1]
```

## review:metadata-duplicate/runs

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 706
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 6: mapping key "runs" already defined at line 3 [action]
@STDERR (empty)
[1]
```

## review:metadata-duplicate-nested/inputs

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 707
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 7: mapping key "required" already defined at line 6 [action]
@STDERR (empty)
[1]
```

## review:metadata-duplicate-nested/runs

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 708
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 5: mapping key "using" already defined at line 4 [action]
@STDERR (empty)
[1]
```

## review:metadata-duplicate-nested/outputs

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 709
@STDOUT
.github/workflows/main.yml:6:15: could not parse action metadata in "$PROJECT/local": line 5: output "x" is duplicated [action]
@STDERR (empty)
[1]
```

## review:reusable-duplicate/inputs

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 710
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/call.yml": yaml: unmarshal errors:   line 7: mapping key "required" already defined at line 6 [workflow-call]
@STDERR (empty)
[1]
```

## review:reusable-duplicate/secrets

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 711
@STDOUT
.github/workflows/main.yml:4:11: error while parsing reusable workflow "./.github/workflows/call.yml": yaml: unmarshal errors:   line 6: mapping key "required" already defined at line 5 [workflow-call]
@STDERR (empty)
[1]
```

## review:snapshot-scalar/snapshot

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 712 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:snapshot-scalar/snapshot-image

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 713 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## review:snapshot-scalar/snapshot-version

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/review.json 714 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:44: character ' ' is invalid for branch and tag names. ref name cannot contain spaces, ~, ^, :, [, ?, *. see `man git-check-ref-format` for more details. note that regular expression is unavailable. note: filter pattern syntax is explained at https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#filter-pattern-cheat-sheet [glob]
<stdin>:5:55: character ' ' is invalid for branch and tag names. ref name cannot contain spaces, ~, ^, :, [, ?, *. see `man git-check-ref-format` for more details. note that regular expression is unavailable. note: filter pattern syntax is explained at https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#filter-pattern-cheat-sheet [glob]
@STDERR (empty)
[1]
```

## review:multi-file-missing-last

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 715
@STDOUT (empty)
@STDERR
could not read "b.yml": open b.yml: no such file or directory
[3]
```

## review:multi-file-missing-first

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run review 716
@STDOUT (empty)
@STDERR
could not read "b.yml": open b.yml: no such file or directory
[3]
```

