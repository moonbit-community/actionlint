// Learn more about moon.mod configuration:
// https://docs.moonbitlang.com/en/latest/toolchain/moon/module.html
//
// To add a dependency, run this command in your terminal:
//   moon add moonbitlang/x
//
// Or manually declare it in `import`, for example:
// import {
//   "moonbitlang/x@0.4.6",
// }

name = "moonbit-community/actionlint"

version = "0.0.1"

readme = "README.md"

repository = ""

license = "Apache-2.0"

keywords = [ "actionlint", "github-actions", "linter", "cli" ]

preferred_target = "wasm"

description = "A MoonBit CLI port of actionlint 1.7.12 for native and wasm"

import {
  "moonbitlang/async@0.22.5",
  "moonbit-community/yaml@0.0.7",
  "moonbitlang/regexp@0.3.6",
}
