#!/usr/bin/env node
import assert from 'node:assert/strict';
import { chmodSync, existsSync, mkdirSync, mkdtempSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { delimiter, join, resolve } from 'node:path';
import { isDeepStrictEqual as equal } from 'node:util';
import { options, root, run } from './cli_utils.mjs';

const args = options(['native', 'wasm'], 'native', { release: { type: 'boolean' } });
const artifact = join(root, '_build', args.target, args.release ? 'release' : 'debug', 'build');
const command = args.target === 'native' ? [join(artifact, 'actionlint.exe')] : ['moonrun', join(artifact, 'actionlint.wasm')];
const reference = args.reference && [resolve(args.reference), '-pyflakes='];
const env = { ...process.env, NO_COLOR: '1', LC_ALL: 'C' };
const valid = 'on: push\njobs:\n  test:\n    runs-on: ubuntu-latest\n    steps:\n      - run: echo hello\n';
const invalid = 'on: [typo]\njobs:\n  test:\n    runs-on: no-such-runner\n    steps:\n      - run: echo hello\n        if: true\n';
const removalCases = JSON.parse(readFileSync(join(root, 'scripts/pyflakes_removal_cases.json'), 'utf8'));
const helpCase = removalCases.find(test => test.id === 'pyflakes-removal-help');
function expectation({ expected, baseline_expected, difference_reason }) {
  return { expected, baseline_expected, difference_reason };
}
const differences = { help: expectation(helpCase), 'long-help': expectation(helpCase) };
for (const [name, message] of [
  ['unknown-flag', 'flag provided but not defined: -not-a-flag'],
  ['unknown-valued-flag', 'flag provided but not defined: -not-a-flag'],
  ['missing-flag-value', 'flag needs an argument: -format'],
  ['invalid-bool', 'invalid boolean value "maybe" for -oneline: parse error'],
]) {
  differences[name] = {
    expected: { code: 2, stdout: '', stderr: message + '\n' + helpCase.expected.stderr },
    baseline_expected: { code: 2, stdout: '', stderr: message + '\n' + helpCase.baseline_expected.stderr },
    difference_reason: helpCase.difference_reason,
  };
}

const directory = mkdtempSync(join(tmpdir(), 'actionlint-cli-'));
const file = name => join(directory, name);
const results = [];

async function invoke(executable, flags, input) {
  const { code, stdout, stderr } = await run(executable, flags, directory, input, env);
  const text = bytes => bytes.toString('utf8').replace(/\r\n?/g, '\n');
  return { code, stdout: text(stdout), stderr: text(stderr) };
}

function quoteArg(s) {
  return "'" + s.replaceAll("'", "'\\''") + "'";
}

function boolLabel(value) {
  return value ? 'True' : 'False';
}

try {
  for (const name of ['.git', '.github/workflows/nested', 'empty', 'outside']) mkdirSync(file(name), { recursive: true });
  writeFileSync(file('.github/workflows/ok.yaml'), valid);
  writeFileSync(file('.github/workflows/bad.yml'), invalid);
  writeFileSync(file('.github/workflows/nested/ok.yml'), valid);
  const cases = [
    ["help", ["-h"], null, 0, true],
    ["long-help", ["--help"], null, 0, true],
    ["unknown-flag", ["-not-a-flag"], null, 2, true],
    ["unknown-valued-flag", ["-not-a-flag=x"], null, 2, true],
    ["missing-flag-value", ["-format"], null, 2, true],
    ["invalid-bool", ["-oneline=maybe"], null, 2, true],
    ["valid-stdin", ["-"], valid, 0, true],
    ["invalid-stdin", ["-"], invalid, 1, true],
    ["empty-stdin", ["-"], "", 1, true],
    ["stdin-filename", ["-stdin-filename", "editor.yml", "-"], invalid, 1, true],
    ["empty-stdin-filename", ["-stdin-filename=", "-"], invalid, 1, true],
    ["oneline", ["-oneline", "-"], invalid, 1, true],
    ["forced-color", ["-color", "-"], invalid, 1, true],
    ["ansi-color", ["-color", "-"], invalid, 1, true],
    ["color-precedence", ["-color", "-no-color", "-"], invalid, 1, true],
    ["json", ["-format", "{{json .}}", "-"], invalid, 1, true],
    ["jsonl", ["-format", "{{range .}}{{json .}}{{end}}", "-"], invalid, 1, true],
    ["empty-json", ["-format", "{{json .}}", "-"], valid, 0, true],
    ["template-fields", ["-format", "{{range .}}{{.Filepath}}:{{.Line}}:{{.Column}}: {{.Message}} [{{.Kind}}]\\n{{end}}", "-"], invalid, 1, true],
    ["template-printf", ["-format", "{{range $e := .}}{{printf \"%s:%d:%s\" $e.Filepath $e.Line $e.Message}}\\n{{end}}", "-"], invalid, 1, true],
    ["template-conditional", ["-format", "{{if .}}bad{{else}}good{{end}}", "-"], valid, 0, true],
    ["ignore", ["-ignore", "unknown|constant expression", "-"], invalid, 0, true],
    ["ignore-all", ["-ignore", ".", "-"], invalid, 0, true],
    ["repeat-ignore", ["-ignore", "unknown", "-ignore", "constant", "-ignore", "unknown Webhook", "-"], invalid, 0, true],
    ["invalid-ignore", ["-ignore", "[", "-"], valid, 3, false],
    ["invalid-template", ["-format", "{{", "-"], valid, 3, false],
    ["unknown-template-function", ["-format", "{{nonexistent}}", "-"], valid, 3, false],
    ["file", [".github/workflows/bad.yml"], null, 1, true],
    ["multiple-files", [".github/workflows/bad.yml", ".github/workflows/ok.yaml"], null, 1, true],
    ["multiple-json", ["-format", "{{json .}}", ".github/workflows/bad.yml", ".github/workflows/ok.yaml"], null, 1, true],
    ["repository-discovery", [], null, 1, true],
    ["end-flags", ["--", ".github/workflows/ok.yaml"], null, 0, true],
    ["flags-after-file", [".github/workflows/ok.yaml", "-oneline"], null, 3, false],
    ["missing-file", ["missing.yaml"], null, 3, false],
    ["directory-as-file", ["empty"], null, 3, false],
  ];
  for (const [label, prefix] of [['chinese', '中文'], ['emoji', '😀'], ['combining', 'é'], ['mixed', 'a😀b']]) {
    cases.push(['unicode-' + label, ['-format', '{{json .}}', '-'], valid + '        name: ' + prefix + ' ${{ no_such.name }}\n', 1, true]);
  }
  cases.push(['crlf', ['-format', '{{json .}}', '-'], invalid.replaceAll('\n', '\r\n'), 1, true]);
  for (const literal of ["2147483648", "-2147483649", "0x80000000", "1e999", "01", "0x", "0x00", "1.", "1e+2", "1e", "-x", "12a", "42 foo bar", "'unclosed", "1 = 2", "true & false", "true | false", "1 }"]) {
    cases.push(['expression-' + literal, ['-format', '{{json .}}', '-'], valid + '        name: ${{ ' + literal + ' }}\n', 1, true]);
  }
  const templates = [
    "{{html \"<a & \\\"b\\\" >\"}}",
    "{{urlquery \"a b/中文\"}}",
    "{{js \"<script>\\\"x\\\"</script>\"}}",
    "{{len \"中文😀\"}}",
    "{{json (slice . 0 1)}}",
    "{{toPascalCase \"foo_bar-baz /QUX42\"}}",
    "{{replace \"ab\" \"a\" \"b\" \"b\" \"c\"}}",
    "{{template \"footer\" .}}{{define \"footer\"}}count={{len .}}{{end}}",
    "{{block \"main\" .}}{{len .}}{{end}}",
    "{{printf \"}}\"}}",
    "{{range .}}\n\t{{.Kind}}\n{{end}}",
  ];
  for (const [index, template] of templates.entries()) {
    cases.push(['template-builtins-' + index, ['-format', template, '-'], invalid, 1, true]);
  }

  const checker = file('checker script.mjs');
  writeFileSync(checker, [
    "import assert from 'node:assert/strict';",
    "import { readFileSync } from 'node:fs';",
    "assert.equal(process.argv[2], 'shell argument');",
    "assert.equal(process.argv.at(-1), '-');",
    "assert.ok(readFileSync(0, 'utf8').includes('echo'));",
    'console.log(JSON.stringify([{code:2086, level:"info", line:2, column:6, message:"Double quote to prevent globbing and word splitting."}]));',
    'process.exitCode = 1;',
  ].join('\n'));
  const shellCommand = [process.execPath, checker, 'shell argument'].map(quoteArg).join(' ');
  cases.push(['shellcheck-command-arguments', ['-shellcheck=' + shellCommand, '-'], valid, 1, true]);
  cases.push(['shellcheck-large-stdin', ['-shellcheck=' + shellCommand, '-'], valid.replace('echo hello', 'echo ' + 'x'.repeat(150_000)), 1, true]);
  const pychecker = file('pychecker.mjs');
  writeFileSync(pychecker, [
    "import assert from 'node:assert/strict';",
    "import { readFileSync } from 'node:fs';",
    "assert.equal(process.argv[2], 'python argument');",
    'readFileSync(0);',
    'console.error("<stdin>:1:1: undefined name \'missing\'");',
    'process.exitCode = 1;',
  ].join('\n'));
  const pyCommand = [process.execPath, pychecker, 'python argument'].map(quoteArg).join(' ');
  cases.push(['pyflakes-command-arguments', ['-pyflakes=' + pyCommand, '-'], valid + '        shell: python\n', 2, true]);
  differences['pyflakes-command-arguments'] = {
    expected: { code: 2, stdout: '', stderr: 'flag provided but not defined: -pyflakes\n' + helpCase.expected.stderr },
    baseline_expected: { code: 1, stdout: "<stdin>:6:9: pyflakes reported issue in this script: 1:1: undefined name 'missing' [pyflakes]\n  |\n6 |       - run: echo hello\n  |         ^~~~\n", stderr: '' },
    difference_reason: 'This port intentionally removes Pyflakes integration and rejects legacy arguments; upstream still executes the command with additional arguments.',
  };
  for (const test of removalCases) {
    if (test === helpCase) continue;
    cases.push([test.id, [...test.flags, ...test.arguments], test.source, 2, true]);
    differences[test.id] = expectation(test);
  }
  for (const [name, flags, input, status, exact] of cases) {
    env.NO_COLOR = name === 'ansi-color' ? '' : '1';
    const argv = ['-shellcheck=', ...flags];
    const actual = await invoke(command, argv, input);
    const difference = differences[name];
    let pass = actual.code === status && (!difference || equal(actual, difference.expected));
    let detail = '';
    if (reference) {
      const expected = await invoke(reference, argv, input);
      pass &&= difference ? equal(expected, difference.baseline_expected) :
        actual.code === expected.code && (!exact || equal(actual, expected));
      if (!pass) detail = { expected, actual };
    }
    if (!pass && !detail) detail = { actual };
    results.push({ case: name, pass, detail, ...difference });
  }

  const mockBin = file('mock-bin');
  const marker = file('pyflakes-called');
  mkdirSync(mockBin);
  const pyflakes = join(mockBin, 'pyflakes');
  writeFileSync(pyflakes, [
    '#!/usr/bin/env node',
    `require('node:fs').writeFileSync(${JSON.stringify(marker)}, 'called');`,
    "console.log('<stdin>:1:1: unexpected Pyflakes invocation');",
    'process.exitCode = 1;',
  ].join('\n'));
  chmodSync(pyflakes, 0o755);
  const probe = await invoke([pyflakes], []);
  assert.ok(probe.code === 1 && readFileSync(marker, 'utf8') === 'called', 'Pyflakes invocation marker must work');
  rmSync(marker);
  env.PATH = mockBin + delimiter + env.PATH;
  env.NO_COLOR = '1';

  for (const scope of ['step', 'job', 'workflow']) {
    for (const shell of ['python', 'python {0}']) {
      for (const log of ['', '-verbose', '-debug']) {
        for (const expression of [false, true]) {
          let source = valid.replace('echo hello', expression ? 'print("${{ no_such.name }}")' : 'print(missing)');
          if (scope === 'step') source += '        shell: ' + shell + '\n';
          if (scope === 'job') source = source.replace('    steps:', '    defaults:\n      run:\n        shell: ' + shell + '\n    steps:');
          if (scope === 'workflow') source = 'defaults:\n  run:\n    shell: ' + shell + '\n' + source;
          rmSync(marker, { force: true });
          const flags = ['-shellcheck=', '-oneline', ...(log ? [log] : []), '-'];
          const actual = await invoke(command, flags, source);
          const called = existsSync(marker);
          let pass = actual.code === Number(expression) && !called && !/pyflakes/i.test(actual.stdout + actual.stderr) &&
            (expression ? actual.stdout.includes('[expression]') : actual.stdout === '');
          if (reference) {
            const baseline = await invoke(reference, flags, source);
            pass &&= actual.code === baseline.code && actual.stdout === baseline.stdout;
          }
          results.push({ case: `python-shell-${scope}-${shell}-${log || 'quiet'}-expression-${boolLabel(expression)}`, pass, actual, pyflakes_called: called });
        }
      }
    }
  }

  const pythonSource = valid + '        shell: python\n';
  const sarif = readFileSync(join(root, 'baseline/testdata/format/sarif_template.txt'), 'utf8')
    .replaceAll('{{ getVersion | json }}', '{{ json "rule-list-test" }}');
  for (const enabled of [false, true]) {
    for (const [format, template] of [['allKinds', '{{json (allKinds)}}'], ['sarif', sarif]]) {
      rmSync(marker, { force: true });
      const flags = ['-shellcheck=' + (enabled ? shellCommand : ''), '-format', template, '-'];
      const actual = await invoke(command, flags, pythonSource);
      const rendered = JSON.parse(actual.stdout);
      const names = format === 'allKinds' ? rendered.map(rule => rule.Name) : rendered.runs[0].tool.driver.rules.map(rule => rule.id);
      let pass = actual.code === 0 && actual.stderr === '' && !existsSync(marker) &&
        !names.includes('pyflakes') && names.includes('shellcheck') === enabled;
      if (reference) pass &&= equal(actual, await invoke(reference, flags, pythonSource));
      results.push({ case: `${format}-rules-shellcheck-${boolLabel(enabled)}`, pass, rules: names });
    }
  }
  const version = await invoke(command, ['-version']);
  results.push({ case: 'version-compatibility-difference', pass: equal(version, {
    code: 0, stdout: '0.0.1\nMoonBit port based on actionlint 1.7.12 (Pyflakes integration removed)\nbuilt with MoonBit for native/wasm\n', stderr: '',
  }) });
  const config = file('.github/actionlint.yaml');
  const init = await invoke(command, ['-init-config']);
  const before = existsSync(config) ? readFileSync(config, 'utf8') : null;
  const again = await invoke(command, ['-init-config']);
  results.push({ case: 'generate-config-preserves-existing-file',
    pass: init.code === 0 && before !== null && again.code === 3 && readFileSync(config, 'utf8') === before });
  writeFileSync(config, 'self-hosted-runner:\n  labels: [no-such-runner]\npaths:\n  .github/workflows/**:\n    ignore: ["unknown Webhook", "constant expression"]\n');
  const discovered = await invoke(command, []);
  results.push({ case: 'repository-config', pass: discovered.code === 0 && discovered.stdout === '' });
  writeFileSync(file('override.yaml'), 'self-hosted-runner:\n  labels: [no-such-runner]\n');
  const override = await invoke(command, ['-config-file', 'override.yaml']);
  results.push({ case: 'explicit-config-precedence', pass: override.code === 1 && override.stdout.includes('unknown Webhook') });
  const invalidConfigs = ['true', '[]', 'self-hosted-runner: 42', 'self-hosted-runner:\n  labels: foo',
    'config-variables: abc', 'config-variables: [true, 2, {}]', 'paths: []', 'paths:\n  foo: bar',
    'paths:\n  foo:\n    ignore: abc', 'config-variables: []\nconfig-variables: []'];
  for (const [index, content] of invalidConfigs.entries()) {
    const path = file('invalid-config.yml');
    writeFileSync(path, content);
    const flags = ['-config-file', path, '-'];
    const actual = await invoke(command, flags, valid);
    let pass = actual.code === 3;
    let detail = '';
    if (reference) {
      const expected = await invoke(reference, flags, valid);
      pass &&= actual.stderr === expected.stderr;
      if (!pass) detail = { expected: expected.stderr, actual: actual.stderr };
    }
    results.push({ case: 'config-types-' + index, pass, detail });
  }
  const report = join(root, '_build', 'cli-' + args.target + '.json');
  writeFileSync(report, JSON.stringify(results, null, 2));
  const failed = results.filter(row => !row.pass);
  console.log(`${results.length - failed.length}/${results.length} CLI scenarios passed (${args.target}); report: ${report}`);
  for (const row of failed) console.log('FAIL:', row.case);
  process.exitCode = failed.length ? 1 : 0;
} finally {
  rmSync(directory, { recursive: true, force: true });
}
