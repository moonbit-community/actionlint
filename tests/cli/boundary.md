# Boundary regressions

135 migrated cases. Inputs are in [fixtures/boundary.json](fixtures/boundary.json).
Each case asserts stdout, stderr, and exit status; only elapsed milliseconds vary.

## boundary:bool-valid:step:true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 0 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:step:false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 1 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:step:fromJSON(vars.FLAG)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 2 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:job:true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 3 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:job:false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 4 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:job:fromJSON(vars.FLAG)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 5 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:strategy:true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 6 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:strategy:false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 7 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:strategy:fromJSON(vars.FLAG)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 8 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:concurrency:true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 9 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:concurrency:false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 10 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:concurrency:fromJSON(vars.FLAG)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 11 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:environment:true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 12 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:environment:false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 13 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:environment:fromJSON(vars.FLAG)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 14 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:dispatch-required:true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 15 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:dispatch-required:false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 16 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:call-required:true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 17 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:bool-valid:call-required:false

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 18 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:if-truthiness:1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 19 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: constant expression "1" in condition. remove the if: section [if-cond]
@STDERR (empty)
[1]
```

## boundary:if-truthiness:'false'

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 20 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: constant expression "'false'" in condition. remove the if: section [if-cond]
@STDERR (empty)
[1]
```

## boundary:if-truthiness:fromJSON('{}')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 21 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type {} [expression]
@STDERR (empty)
[1]
```

## boundary:if-truthiness:fromJSON('[]')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 22 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type array<any> [expression]
@STDERR (empty)
[1]
```

## boundary:if-truthiness:null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 23 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:13: constant expression "null" in condition. remove the if: section [if-cond]
<stdin>:7:13: object, array, and null values should not be evaluated in template with ${{ }} but evaluating the value of type null [expression]
@STDERR (empty)
[1]
```

## boundary:matrix-types:24

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 24 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:matrix-types:25

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 25 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:matrix-types:26

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 26 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:event-description:workflow_call:outputs

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 27 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:26: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## boundary:event-description:workflow_call:secrets

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 28 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:26: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## boundary:event-description:workflow_call:inputs

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 29 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:26: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## boundary:event-description:workflow_dispatch:inputs

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 30 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:5:26: undefined variable "no_such". available variables are "env", "github", "inputs", "job", "matrix", "needs", "runner", "secrets", "steps", "strategy", "vars" [expression]
@STDERR (empty)
[1]
```

## boundary:security:github.event.*.title[0]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 31 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:23: object filter extracts potentially untrusted properties "github.event.discussion.title", "github.event.issue.title", "github.event.pull_request.title". avoid using the value directly in inline scripts. instead, pass the value through an environment variable. see https://docs.github.com/en/actions/reference/security/secure-use#good-practices-for-mitigating-script-injection-attacks for more details [expression]
@STDERR (empty)
[1]
```

## boundary:security:github.event.commits.*.message

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 32 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:23: "github.event.commits.*.message" is potentially untrusted. avoid using it directly in inline scripts. instead, pass it through an environment variable. see https://docs.github.com/en/actions/reference/security/secure-use#good-practices-for-mitigating-script-injection-attacks for more details [expression]
@STDERR (empty)
[1]
```

## boundary:security:github.event.issue.*[0]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 33 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:23: object filter extracts potentially untrusted properties "github.event.issue.body", "github.event.issue.title". avoid using the value directly in inline scripts. instead, pass the value through an environment variable. see https://docs.github.com/en/actions/reference/security/secure-use#good-practices-for-mitigating-script-injection-attacks for more details [expression]
@STDERR (empty)
[1]
```

## boundary:security:toJSON(github.event.issue.title)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 34 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:30: "github.event.issue.title" is potentially untrusted. avoid using it directly in inline scripts. instead, pass it through an environment variable. see https://docs.github.com/en/actions/reference/security/secure-use#good-practices-for-mitigating-script-injection-attacks for more details [expression]
@STDERR (empty)
[1]
```

## boundary:security:contains(github.event.issue.title, '')

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 35 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:security:github.event.issue[github.event.issue.title]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 36 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:6:42: "github.event.issue.title" is potentially untrusted. avoid using it directly in inline scripts. instead, pass it through an environment variable. see https://docs.github.com/en/actions/reference/security/secure-use#good-practices-for-mitigating-script-injection-attacks for more details [expression]
@STDERR (empty)
[1]
```

## boundary:security:github.event.issue.title.bar.baz

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 37 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:security:github['event']['Issue']['title']

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 38 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:runner-pattern:foo[!x]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 39
@STDOUT (empty)
@STDERR (empty)
```

## boundary:runner-pattern:foo[^x]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 40
@STDOUT (empty)
@STDERR (empty)
```

## boundary:runner-pattern:{foo,bar}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 41
@STDOUT
<stdin>:4:14: label "foo!" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows", "{foo,bar}". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## boundary:runner-pattern:foo/**/bar

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 42
@STDOUT
<stdin>:4:14: label "foo!" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows", "foo/**/bar". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## boundary:runner-pattern:a**b

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 43
@STDOUT
<stdin>:4:14: label "foo!" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows", "a**b". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## boundary:runner-pattern:foo/**

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 44
@STDOUT
<stdin>:4:14: label "foo!" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows", "foo/**". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## boundary:runner-pattern:[a-]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 45
@STDOUT
<stdin>:4:14: label pattern "[a-]" is an invalid glob. kindly check list of labels in actionlint.yaml config file: syntax error in pattern [runner-label]
@STDERR (empty)
[1]
```

## boundary:runner-pattern:[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 46
@STDOUT
<stdin>:4:14: label pattern "[]" is an invalid glob. kindly check list of labels in actionlint.yaml config file: syntax error in pattern [runner-label]
@STDERR (empty)
[1]
```

## boundary:runner-pattern:[!]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 47
@STDOUT
<stdin>:4:14: label "foo!" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows", "[!]". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## boundary:runner-pattern:[z-a]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 48
@STDOUT
<stdin>:4:14: label "foo!" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows", "[z-a]". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## boundary:runner-pattern:[é-中]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 49
@STDOUT
<stdin>:4:14: label "foo!" is unknown. available labels are "windows-latest", "windows-latest-8-cores", "windows-2025", "windows-2025-vs2026", "windows-2022", "windows-11-arm", "ubuntu-slim", "ubuntu-latest", "ubuntu-latest-4-cores", "ubuntu-latest-8-cores", "ubuntu-latest-16-cores", "ubuntu-24.04", "ubuntu-24.04-arm", "ubuntu-22.04", "ubuntu-22.04-arm", "macos-latest", "macos-latest-xlarge", "macos-latest-large", "macos-26-intel", "macos-26-xlarge", "macos-26-large", "macos-26", "macos-15-intel", "macos-15-xlarge", "macos-15-large", "macos-15", "macos-14-xlarge", "macos-14-large", "macos-14", "self-hosted", "x64", "arm", "arm64", "linux", "macos", "windows", "[é-中]". if it is a custom label for self-hosted runner, set list of labels in actionlint.yaml config file [runner-label]
@STDERR (empty)
[1]
```

## boundary:config-pattern:[!]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 50
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": invalid glob pattern "[!]" in "paths"
[3]
```

## boundary:config-pattern:[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 51
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": invalid glob pattern "[]" in "paths"
[3]
```

## boundary:config-pattern:{foo,bar

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 52
@STDOUT (empty)
@STDERR
could not parse config file "custom.yml": invalid glob pattern "{foo,bar" in "paths"
[3]
```

## boundary:config-pattern:foo/**/bar

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 53
@STDOUT (empty)
@STDERR (empty)
```

## boundary:config-pattern:**/*.yml

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 54
@STDOUT (empty)
@STDERR (empty)
```

## boundary:config-pattern:{.github,other}/**/*.yml

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 55
@STDOUT (empty)
@STDERR (empty)
```

## boundary:config-pattern:[z-a]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 56
@STDOUT (empty)
@STDERR (empty)
```

## boundary:config-pattern:foo[!x]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 57
@STDOUT (empty)
@STDERR (empty)
```

## boundary:regex:[[:^alpha:]]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 58 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '[[:^alpha:]]' -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:regex:\P{Greek}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 59 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '\P{Greek}' -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:regex:(?i:a)(?-i:b)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 60 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '(?i:a)(?-i:b)' -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:regex:(?U:a+?)

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 61 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '(?U:a+?)' -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:regex:\Afoo\z

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 62 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '\Afoo\z' -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:regex:a{01}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 63 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore 'a{01}' -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:regex:(a)\1

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '(a)\1' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "(a)\\1": error parsing regexp: invalid escape sequence: `\1`
[3]
```

## boundary:regex:\8

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '\8' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "\\8": error parsing regexp: invalid escape sequence: `\8`
[3]
```

## boundary:regex:\u0041

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '\u0041' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "\\u0041": error parsing regexp: invalid escape sequence: `\u`
[3]
```

## boundary:regex:[abc

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '[abc' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "[abc": error parsing regexp: missing closing ]: `[abc`
[3]
```

## boundary:regex:(

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '(' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "(": error parsing regexp: missing closing ): `(`
[3]
```

## boundary:regex:a{1001}

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore 'a{1001}' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "a{1001}": error parsing regexp: invalid repeat count: `{1001}`
[3]
```

## boundary:regex:a{2,1}

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore 'a{2,1}' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "a{2,1}": error parsing regexp: invalid repeat count: `{2,1}`
[3]
```

## boundary:regex:[z-a]

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '[z-a]' -
@STDOUT (empty)
@STDERR
invalid regular expression for ignore pattern "[z-a]": error parsing regexp: invalid character class range: `z-a`
[3]
```

## boundary:regex:\123

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 72 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '\123' -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:regex:\x{41}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 73 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '\x{41}' -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:regex:\Q[]{}\E

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 74 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '\Q[]{}\E' -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:regex:(?i)\Qab\E+

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 75 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -ignore '(?i)\Qab\E+' -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:cron:*/9223372036854775807 * * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 76 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:cron:*/9223372036854775808 * * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 77 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: invalid CRON format "*/9223372036854775808 * * * *" in schedule event: failed to parse int from 9223372036854775808: strconv.Atoi: parsing "9223372036854775808": value out of range [events]
@STDERR (empty)
[1]
```

## boundary:cron:*/-1 * * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 78 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: invalid CRON format "*/-1 * * * *" in schedule event: negative number (-1) not allowed: -1 [events]
@STDERR (empty)
[1]
```

## boundary:cron:*/0 * * * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 79 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: invalid CRON format "*/0 * * * *" in schedule event: step of range should be a positive number: */0 [events]
@STDERR (empty)
[1]
```

## boundary:cron:0 0 */2 * 1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 80 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:cron:0 0 */1 * 1

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 81 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:cron:0 0 *-2 * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 82 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:cron:0 0 1-2-3 * *

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 83 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: invalid CRON format "0 0 1-2-3 * *" in schedule event: too many hyphens: 1-2-3 [events]
@STDERR (empty)
[1]
```

## boundary:cron:0 0 * * MON-FRI

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 84 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:cron:@hourly

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 85 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:3:13: invalid CRON format "@hourly" in schedule event: parser does not accept descriptors: @hourly [events]
@STDERR (empty)
[1]
```

## boundary:workflow-reference:owner/repo/path@ref

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 86 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:workflow-reference:owner/repo/path@@ref

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 87 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:workflow-reference:owner/repo/@a@b

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 88 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:11: reusable workflow call "owner/repo/@a@b" at "uses" is not following the format "owner/repo/path/to/workflow.yml@ref" nor "./path/to/workflow.yml". see https://docs.github.com/en/actions/learn-github-actions/reusing-workflows for more details [workflow-call]
@STDERR (empty)
[1]
```

## boundary:workflow-reference:owner/repo/path@

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 89 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:11: reusable workflow call "owner/repo/path@" at "uses" is not following the format "owner/repo/path/to/workflow.yml@ref" nor "./path/to/workflow.yml". see https://docs.github.com/en/actions/learn-github-actions/reusing-workflows for more details [workflow-call]
@STDERR (empty)
[1]
```

## boundary:workflow-reference:./workflows/build.yml

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 90 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT (empty)
@STDERR (empty)
```

## boundary:workflow-reference:./@a

Local reusable workflow paths must not contain @ref; the same validation rule applies as for ./@foo.

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 91 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:4:11: reusable workflow call "./@a" at "uses" is not following the format "owner/repo/path/to/workflow.yml@ref" nor "./path/to/workflow.yml". see https://docs.github.com/en/actions/learn-github-actions/reusing-workflows for more details [workflow-call]
@STDERR (empty)
[1]
```

## boundary:template:{{$x := "outer"}}{{if true}}{{$x := "inner"}}{{$x}}{{end}}{{$x}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 92 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{$x := "outer"}}{{if true}}{{$x := "inner"}}{{$x}}{{end}}{{$x}}' -
@STDOUT
innerouter (no-eol)
@STDERR (empty)
[1]
```

## boundary:template:{{$x := "outer"}}{{if true}}{{$x = "inner"}}{{end}}{{$x}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 93 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{$x := "outer"}}{{if true}}{{$x = "inner"}}{{end}}{{$x}}' -
@STDOUT
inner (no-eol)
@STDERR (empty)
[1]
```

## boundary:template:{{$x := "outer"}}{{range .}}{{$x := "inner"}}{{end}}{{$x}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 94 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{$x := "outer"}}{{range .}}{{$x := "inner"}}{{end}}{{$x}}' -
@STDOUT
outer (no-eol)
@STDERR (empty)
[1]
```

## boundary:template:{{$x := "outer"}}{{range .}}{{$x = "inner"}}{{end}}{{$x}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 95 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{$x := "outer"}}{{range .}}{{$x = "inner"}}{{end}}{{$x}}' -
@STDOUT
inner (no-eol)
@STDERR (empty)
[1]
```

## boundary:template:{{if $x := true}}{{$x}}{{else}}{{$x}}{{end}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 96 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{if $x := true}}{{$x}}{{else}}{{$x}}{{end}}' -
@STDOUT
true (no-eol)
@STDERR (empty)
[1]
```

## boundary:template:{{$x := "outer"}}{{define "t"}}{{$x}}{{end}}{{template "t" .}}

```mooncram moonbit-community/actionlint
$ NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{$x := "outer"}}{{define "t"}}{{$x}}{{end}}{{template "t" .}}' -
@STDOUT (empty)
@STDERR
template "{{$x := \"outer\"}}{{define \"t\"}}{{$x}}{{end}}{{template \"t\" .}}" to format error messages could not be parsed: template: error formatter:1: undefined variable "$x"
[3]
```

## boundary:template:{{define "t"}}{{$}}{{end}}{{template "t" "inner"}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 98 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{define "t"}}{{$}}{{end}}{{template "t" "inner"}}' -
@STDOUT
inner (no-eol)
@STDERR (empty)
[1]
```

## boundary:template:{{and false (index . 99)}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 99 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{and false (index . 99)}}' -
@STDOUT
false (no-eol)
@STDERR (empty)
[1]
```

## boundary:template:{{or true (index . 99)}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 100 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{or true (index . 99)}}' -
@STDOUT
true (no-eol)
@STDERR (empty)
[1]
```

## boundary:template:{{and true (index . 99)}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 101 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{and true (index . 99)}}' -
@STDOUT (empty)
@STDERR (empty)
[1]
```

## boundary:template:{{or false (index . 99)}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 102 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{or false (index . 99)}}' -
@STDOUT (empty)
@STDERR (empty)
[1]
```

## boundary:template:{{eq 1 1.0}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 103 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{eq 1 1.0}}' -
@STDOUT (empty)
@STDERR (empty)
[1]
```

## boundary:template:{{lt 1 "2"}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 104 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{lt 1 "2"}}' -
@STDOUT (empty)
@STDERR (empty)
[1]
```

## boundary:template:{{printf "%T %T %T %T %T" 1 1.0 true nil "x"}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 105 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%T %T %T %T %T" 1 1.0 true nil "x"}}' -
@STDOUT
int float64 bool <nil> string (no-eol)
@STDERR (empty)
[1]
```

## boundary:template:{{printf "%#b %#o %#x %#X" 12 12 12 12}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 106 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%#b %#o %#x %#X" 12 12 12 12}}' -
@STDOUT
0b1100 014 0xc 0XC (no-eol)
@STDERR (empty)
[1]
```

## boundary:template:{{printf "%d" "x"}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 107 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%d" "x"}}' -
@STDOUT
%!d(string=x) (no-eol)
@STDERR (empty)
[1]
```

## boundary:template:{{printf "%s"}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 108 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%s"}}' -
@STDOUT
%!s(MISSING) (no-eol)
@STDERR (empty)
[1]
```

## boundary:template:{{printf "%s" "a" "b"}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 109 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%s" "a" "b"}}' -
@STDOUT
a%!(EXTRA string=b) (no-eol)
@STDERR (empty)
[1]
```

## boundary:template:{{printf "%d %T" 9223372036854775807 9223372036854775807}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 110 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%d %T" 9223372036854775807 9223372036854775807}}' -
@STDOUT
9223372036854775807 int (no-eol)
@STDERR (empty)
[1]
```

## boundary:template:{{printf "%c %q %U" 65 65 65}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 111 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%c %q %U" 65 65 65}}' -
@STDOUT
A 'A' U+0041 (no-eol)
@STDERR (empty)
[1]
```

## boundary:template:{{printf "%.2f" 1.25}}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 112 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -format '{{printf "%.2f" 1.25}}' -
@STDOUT
1.25 (no-eol)
@STDERR (empty)
[1]
```

## boundary:shellcheck:null

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 113
@STDOUT (empty)
@STDERR (empty)
```

## boundary:shellcheck:[]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 114
@STDOUT (empty)
@STDERR (empty)
```

## boundary:shellcheck:[{}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 115
@STDOUT
<stdin>:6:9: shellcheck reported issue in this script: SC0::-1:0:  [shellcheck]
@STDERR (empty)
[1]
```

## boundary:shellcheck:[null]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 116
@STDOUT
<stdin>:6:9: shellcheck reported issue in this script: SC0::-1:0:  [shellcheck]
@STDERR (empty)
[1]
```

## boundary:shellcheck:{}

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 117
@STDOUT (empty)
@STDERR
could not parse JSON output from shellcheck: json: cannot unmarshal object into Go value of type []actionlint.shellcheckError: stdout="{}\n"
[3]
```

## boundary:shellcheck:true

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 118
@STDOUT (empty)
@STDERR
could not parse JSON output from shellcheck: json: cannot unmarshal bool into Go value of type []actionlint.shellcheckError: stdout="true\n"
[3]
```

## boundary:shellcheck:42

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 119
@STDOUT (empty)
@STDERR
could not parse JSON output from shellcheck: json: cannot unmarshal number into Go value of type []actionlint.shellcheckError: stdout="42\n"
[3]
```

## boundary:shellcheck:"x"

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 120
@STDOUT (empty)
@STDERR
could not parse JSON output from shellcheck: json: cannot unmarshal string into Go value of type []actionlint.shellcheckError: stdout="\"x\"\n"
[3]
```

## boundary:shellcheck:[1]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 121
@STDOUT (empty)
@STDERR
could not parse JSON output from shellcheck: json: cannot unmarshal number into Go value of type actionlint.shellcheckError: stdout="[1]\n"
[3]
```

## boundary:shellcheck:[{"line":"1"}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 122
@STDOUT (empty)
@STDERR
could not parse JSON output from shellcheck: json: cannot unmarshal string into Go struct field shellcheckError.line of type int: stdout="[{\"line\":\"1\"}]\n"
[3]
```

## boundary:shellcheck:[{"line":1.0}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 123
@STDOUT (empty)
@STDERR
could not parse JSON output from shellcheck: json: cannot unmarshal number 1.0 into Go struct field shellcheckError.line of type int: stdout="[{\"line\":1.0}]\n"
[3]
```

## boundary:shellcheck:[{"code":2147483648}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 124
@STDOUT
<stdin>:6:9: shellcheck reported issue in this script: SC2147483648::-1:0:  [shellcheck]
@STDERR (empty)
[1]
```

## boundary:shellcheck:[{"message":null,"level":null}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 125
@STDOUT
<stdin>:6:9: shellcheck reported issue in this script: SC0::-1:0:  [shellcheck]
@STDERR (empty)
[1]
```

## boundary:shellcheck:[{"file":{},"endLine":[],"code":0}]

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx run boundary 126
@STDOUT
<stdin>:6:9: shellcheck reported issue in this script: SC0::-1:0:  [shellcheck]
@STDERR (empty)
[1]
```

## boundary:yaml-timeout:.nan

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 127 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: invalid float value: ".nan": strconv.ParseFloat: parsing ".nan": invalid syntax [syntax-check]
@STDERR (empty)
[1]
```

## boundary:yaml-timeout:.inf

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 128 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: invalid float value: ".inf": strconv.ParseFloat: parsing ".inf": invalid syntax [syntax-check]
@STDERR (empty)
[1]
```

## boundary:yaml-timeout:2026-01-01

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 129 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: expected scalar node for float value but found scalar node with "!!timestamp" tag [syntax-check]
@STDERR (empty)
[1]
```

## boundary:yaml-timeout:2026-02-30

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 130 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: expecting a single ${{...}} expression or float number literal, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## boundary:yaml-timeout:1e-999

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 131 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: value at "timeout-minutes" must be greater than zero: 0 [syntax-check]
@STDERR (empty)
[1]
```

## boundary:yaml-timeout:1e999

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 132 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: expecting a single ${{...}} expression or float number literal, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## boundary:yaml-timeout:NaN

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 133 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: expecting a single ${{...}} expression or float number literal, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

## boundary:yaml-timeout:Inf

```mooncram moonbit-community/actionlint
$ moonx ./support/driver.mbtx input fixtures/boundary.json 134 | NO_COLOR=1 moonx moonbit-community/actionlint -shellcheck= -oneline -
@STDOUT
<stdin>:7:26: expecting a single ${{...}} expression or float number literal, but found plain text node [syntax-check]
@STDERR (empty)
[1]
```

