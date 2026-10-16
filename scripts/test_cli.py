#!/usr/bin/env python3
"""Exercise the built CLI; optionally compare stdout/stderr with upstream Go.

Build first with `moon build --target native` or `moon build --target wasm`.
The reference executable is optional and is never used by the shipped CLI.
"""
import argparse
import json
import os
from pathlib import Path
import shlex
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser()
parser.add_argument('--target', choices=['native', 'wasm'], default='native')
parser.add_argument('--release', action='store_true')
parser.add_argument('--reference', type=Path)
args = parser.parse_args()
mode = 'release' if args.release else 'debug'
artifact = ROOT / '_build' / args.target / mode / 'build'
command = [str(artifact / 'actionlint.exe')] if args.target == 'native' else ['moonrun', str(artifact / 'actionlint.wasm')]
env = os.environ.copy()
env['NO_COLOR'] = '1'
env['LC_ALL'] = 'C'
valid = 'on: push\njobs:\n  test:\n    runs-on: ubuntu-latest\n    steps:\n      - run: echo hello\n'
invalid = 'on: [typo]\njobs:\n  test:\n    runs-on: no-such-runner\n    steps:\n      - run: echo hello\n        if: true\n'
removal_cases = json.loads((ROOT / 'scripts/pyflakes_removal_cases.json').read_text())
help_case = next(case for case in removal_cases if case['id'] == 'pyflakes-removal-help')
product_help = help_case['expected']['stderr']
upstream_help = help_case['baseline_expected']['stderr']
differences = {name: {key: help_case[key] for key in ('expected', 'baseline_expected', 'difference_reason')}
               for name in ('help', 'long-help')}
for name, message in [
    ('unknown-flag', 'flag provided but not defined: -not-a-flag'),
    ('unknown-valued-flag', 'flag provided but not defined: -not-a-flag'),
    ('missing-flag-value', 'flag needs an argument: -format'),
    ('invalid-bool', 'invalid boolean value "maybe" for -oneline: parse error'),
]:
    differences[name] = {
        'expected': {'code': 2, 'stdout': '', 'stderr': message + '\n' + product_help},
        'baseline_expected': {'code': 2, 'stdout': '', 'stderr': message + '\n' + upstream_help},
        'difference_reason': help_case['difference_reason'],
    }


def output(result):
    return {'code': result.returncode, 'stdout': result.stdout, 'stderr': result.stderr}


with tempfile.TemporaryDirectory(prefix='actionlint-cli-') as tmp:
    directory = Path(tmp)
    (directory / '.git').mkdir()
    workflows = directory / '.github/workflows'
    workflows.mkdir(parents=True)
    (workflows / 'ok.yaml').write_text(valid)
    (workflows / 'bad.yml').write_text(invalid)
    (workflows / 'nested').mkdir()
    (workflows / 'nested/ok.yml').write_text(valid)
    (directory / 'empty').mkdir()
    outside = directory / 'outside'
    outside.mkdir()
    cases = [
        ('help', ['-h'], None, 0, True),
        ('long-help', ['--help'], None, 0, True),
        ('unknown-flag', ['-not-a-flag'], None, 2, True),
        ('unknown-valued-flag', ['-not-a-flag=x'], None, 2, True),
        ('missing-flag-value', ['-format'], None, 2, True),
        ('invalid-bool', ['-oneline=maybe'], None, 2, True),
        ('valid-stdin', ['-'], valid, 0, True),
        ('invalid-stdin', ['-'], invalid, 1, True),
        ('empty-stdin', ['-'], '', 1, True),
        ('stdin-filename', ['-stdin-filename', 'editor.yml', '-'], invalid, 1, True),
        ('empty-stdin-filename', ['-stdin-filename=', '-'], invalid, 1, True),
        ('oneline', ['-oneline', '-'], invalid, 1, True),
        ('forced-color', ['-color', '-'], invalid, 1, True),
        ('ansi-color', ['-color', '-'], invalid, 1, True),
        ('color-precedence', ['-color', '-no-color', '-'], invalid, 1, True),
        ('json', ['-format', '{{json .}}', '-'], invalid, 1, True),
        ('jsonl', ['-format', '{{range .}}{{json .}}{{end}}', '-'], invalid, 1, True),
        ('empty-json', ['-format', '{{json .}}', '-'], valid, 0, True),
        ('template-fields', ['-format', '{{range .}}{{.Filepath}}:{{.Line}}:{{.Column}}: {{.Message}} [{{.Kind}}]\\n{{end}}', '-'], invalid, 1, True),
        ('template-printf', ['-format', '{{range $e := .}}{{printf "%s:%d:%s" $e.Filepath $e.Line $e.Message}}\\n{{end}}', '-'], invalid, 1, True),
        ('template-conditional', ['-format', '{{if .}}bad{{else}}good{{end}}', '-'], valid, 0, True),
        ('ignore', ['-ignore', 'unknown|constant expression', '-'], invalid, 0, True),
        ('ignore-all', ['-ignore', '.', '-'], invalid, 0, True),
        ('repeat-ignore', ['-ignore', 'unknown', '-ignore', 'constant', '-ignore', 'unknown Webhook', '-'], invalid, 0, True),
        ('invalid-ignore', ['-ignore', '[', '-'], valid, 3, False),
        ('invalid-template', ['-format', '{{', '-'], valid, 3, False),
        ('unknown-template-function', ['-format', '{{nonexistent}}', '-'], valid, 3, False),
        ('file', ['.github/workflows/bad.yml'], None, 1, True),
        ('multiple-files', ['.github/workflows/bad.yml', '.github/workflows/ok.yaml'], None, 1, True),
        ('multiple-json', ['-format', '{{json .}}', '.github/workflows/bad.yml', '.github/workflows/ok.yaml'], None, 1, True),
        ('repository-discovery', [], None, 1, True),
        ('end-flags', ['--', '.github/workflows/ok.yaml'], None, 0, True),
        ('flags-after-file', ['.github/workflows/ok.yaml', '-oneline'], None, 3, False),
        ('missing-file', ['missing.yaml'], None, 3, False),
        ('directory-as-file', ['empty'], None, 3, False),
    ]
    for label, prefix in [('chinese', '中文'), ('emoji', '😀'), ('combining', 'é'), ('mixed', 'a😀b')]:
        content = valid + '        name: ' + prefix + ' ${{ no_such.name }}\n'
        cases.append(('unicode-' + label, ['-format', '{{json .}}', '-'], content, 1, True))
    cases.append(('crlf', ['-format', '{{json .}}', '-'], invalid.replace('\n', '\r\n'), 1, True))
    for literal in ['2147483648', '-2147483649', '0x80000000', '1e999', '01', '0x', '0x00', '1.', '1e+2', '1e', '-x', '12a', '42 foo bar', "'unclosed", '1 = 2', 'true & false', 'true | false', '1 }']:
        content = valid + '        name: ${{ ' + literal + ' }}\n'
        cases.append(('expression-' + literal, ['-format', '{{json .}}', '-'], content, 1, True))
    for index, template in enumerate([
        '{{html "<a & \\"b\\" >"}}',
        '{{urlquery "a b/中文"}}',
        '{{js "<script>\\\"x\\\"</script>"}}',
        '{{len "中文😀"}}',
        '{{json (slice . 0 1)}}',
        '{{toPascalCase "foo_bar-baz /QUX42"}}',
        '{{replace "ab" "a" "b" "b" "c"}}',
        '{{template "footer" .}}{{define "footer"}}count={{len .}}{{end}}',
        '{{block "main" .}}{{len .}}{{end}}',
        '{{printf "}}"}}',
        '{{range .}}\n\t{{.Kind}}\n{{end}}',
    ]):
        cases.append((f'template-builtins-{index}', ['-format', template, '-'], invalid, 1, True))
    checker = directory / 'checker script.py'
    checker.write_text('import json, sys\nassert sys.argv[1] == "shell argument"\nassert sys.argv[-1] == "-"\nassert "echo" in sys.stdin.read()\nprint(json.dumps([dict(code=2086, level="info", line=2, column=6, message="Double quote to prevent globbing and word splitting.")]))\nsys.exit(1)\n')
    shell_command = f'{shlex.quote(sys.executable)} {shlex.quote(str(checker))} "shell argument"'
    cases.append(('shellcheck-command-arguments', ['-shellcheck=' + shell_command, '-'], valid, 1, True))
    cases.append(('shellcheck-large-stdin', ['-shellcheck=' + shell_command, '-'], valid.replace('echo hello', 'echo ' + 'x' * 150_000), 1, True))
    pychecker = directory / 'pychecker.py'
    pychecker.write_text("""import sys
assert sys.argv[1] == "python argument"
sys.stdin.read()
print("<stdin>:1:1: undefined name 'missing'", file=sys.stderr)
sys.exit(1)
""")
    py_command = f'{shlex.quote(sys.executable)} {shlex.quote(str(pychecker))} "python argument"'
    cases.append(('pyflakes-command-arguments', ['-pyflakes=' + py_command, '-'], valid + '        shell: python\n', 2, True))
    differences['pyflakes-command-arguments'] = {
        'expected': {'code': 2, 'stdout': '', 'stderr': 'flag provided but not defined: -pyflakes\n' + product_help},
        'baseline_expected': {
            'code': 1,
            'stdout': "<stdin>:6:9: pyflakes reported issue in this script: 1:1: undefined name 'missing' [pyflakes]\n  |\n6 |       - run: echo hello\n  |         ^~~~\n",
            'stderr': '',
        },
        'difference_reason': 'This port intentionally removes Pyflakes integration and rejects legacy arguments; upstream still executes the command with additional arguments.',
    }
    for case in removal_cases:
        if case['id'] == 'pyflakes-removal-help':
            continue
        name = case['id']
        cases.append((name, [*case['flags'], *case['arguments']], case['source'], 2, True))
        differences[name] = {key: case[key] for key in ('expected', 'baseline_expected', 'difference_reason')}
    results = []
    for name, flags, content, status, exact in cases:
        env['NO_COLOR'] = '' if name == 'ansi-color' else '1'
        flags = ['-shellcheck=', *flags]
        actual = subprocess.run([*command, *flags], input=content, text=True, capture_output=True, cwd=directory, env=env)
        success = actual.returncode == status
        detail = ''
        difference = differences.get(name)
        if difference:
            success = success and output(actual) == difference['expected']
        if args.reference:
            expected = subprocess.run([str(args.reference.resolve()), '-pyflakes=', *flags], input=content, text=True, capture_output=True, cwd=directory, env=env)
            if difference:
                success = success and output(expected) == difference['baseline_expected']
            else:
                success = success and actual.returncode == expected.returncode
                if exact:
                    success = success and actual.stdout == expected.stdout and actual.stderr == expected.stderr
            if not success:
                detail = {'expected': {'code': expected.returncode, 'stdout': expected.stdout, 'stderr': expected.stderr}, 'actual': {'code': actual.returncode, 'stdout': actual.stdout, 'stderr': actual.stderr}}
        if not success and not detail:
            detail = {'actual': {'code': actual.returncode, 'stdout': actual.stdout, 'stderr': actual.stderr}}
        results.append({'case': name, 'pass': success, 'detail': detail, **(difference or {})})
    # A discoverable Pyflakes executable must never run, including inherited shells.
    mock_bin = directory / 'mock-bin'
    mock_bin.mkdir()
    marker = directory / 'pyflakes-called'
    pyflakes = mock_bin / 'pyflakes'
    pyflakes.write_text(f'#!{sys.executable}\nfrom pathlib import Path\nPath({str(marker)!r}).write_text("called")\nprint("<stdin>:1:1: unexpected Pyflakes invocation")\nraise SystemExit(1)\n')
    pyflakes.chmod(0o755)
    probe = subprocess.run([str(pyflakes)], text=True, capture_output=True, cwd=directory, env=env)
    assert probe.returncode == 1 and marker.read_text() == 'called', 'Pyflakes invocation marker must work'
    marker.unlink()
    env['PATH'] = str(mock_bin) + os.pathsep + env['PATH']
    env['NO_COLOR'] = '1'
    for scope in ('step', 'job', 'workflow'):
        for shell in ('python', 'python {0}'):
            for log in ('', '-verbose', '-debug'):
                for expression in (False, True):
                    source = valid.replace('echo hello', 'print("${{ no_such.name }}")' if expression else 'print(missing)')
                    if scope == 'step':
                        source += '        shell: ' + shell + '\n'
                    elif scope == 'job':
                        source = source.replace('    steps:', '    defaults:\n      run:\n        shell: ' + shell + '\n    steps:')
                    else:
                        source = 'defaults:\n  run:\n    shell: ' + shell + '\n' + source
                    marker.unlink(missing_ok=True)
                    flags = ['-shellcheck=', '-oneline', *([log] if log else []), '-']
                    actual = subprocess.run([*command, *flags], input=source, text=True, capture_output=True, cwd=directory, env=env)
                    success = (actual.returncode == int(expression) and not marker.exists()
                               and 'pyflakes' not in actual.stdout.lower() + actual.stderr.lower()
                               and ('[expression]' in actual.stdout if expression else actual.stdout == ''))
                    if args.reference:
                        baseline = subprocess.run([str(args.reference.resolve()), '-pyflakes=', *flags], input=source, text=True, capture_output=True, cwd=directory, env=env)
                        success = success and actual.returncode == baseline.returncode and actual.stdout == baseline.stdout
                    results.append({'case': f'python-shell-{scope}-{shell}-{log or "quiet"}-expression-{expression}',
                                    'pass': success, 'actual': output(actual), 'pyflakes_called': marker.exists()})
    python_source = valid + '        shell: python\n'
    for enabled in (False, True):
        for format_name, template in [
            ('allKinds', '{{json (allKinds)}}'),
            # Hold the version constant while comparing registered rules.
            ('sarif', (ROOT / 'baseline/testdata/format/sarif_template.txt').read_text()
             .replace('{{ getVersion | json }}', '{{ json "rule-list-test" }}')),
        ]:
            marker.unlink(missing_ok=True)
            flags = ['-shellcheck=' + (shell_command if enabled else ''), '-format', template, '-']
            actual = subprocess.run([*command, *flags], input=python_source, text=True, capture_output=True, cwd=directory, env=env)
            rendered = json.loads(actual.stdout)
            rules = rendered if format_name == 'allKinds' else rendered['runs'][0]['tool']['driver']['rules']
            names = [rule['Name' if format_name == 'allKinds' else 'id'] for rule in rules]
            success = (actual.returncode == 0 and actual.stderr == '' and not marker.exists()
                       and 'pyflakes' not in names and ('shellcheck' in names) == enabled)
            if args.reference:
                baseline = subprocess.run([str(args.reference.resolve()), '-pyflakes=', *flags], input=python_source, text=True, capture_output=True, cwd=directory, env=env)
                success = success and output(actual) == output(baseline)
            results.append({'case': f'{format_name}-rules-shellcheck-{enabled}', 'pass': success, 'rules': names})
    actual = subprocess.run([*command, '-version'], text=True, capture_output=True, cwd=directory, env=env)
    results.append({'case': 'version-compatibility-difference', 'pass': output(actual) == {
        'code': 0, 'stdout': '0.0.1\nMoonBit port based on actionlint 1.7.12 (Pyflakes integration removed)\nbuilt with MoonBit for native/wasm\n', 'stderr': ''}})
    # Configuration generation is an actual write and must preserve existing files.
    actual = subprocess.run([*command, '-init-config'], text=True, capture_output=True, cwd=directory, env=env)
    config = directory / '.github/actionlint.yaml'
    success = actual.returncode == 0 and config.exists()
    before = config.read_text() if config.exists() else ''
    again = subprocess.run([*command, '-init-config'], text=True, capture_output=True, cwd=directory, env=env)
    success = success and again.returncode == 3 and config.read_text() == before
    results.append({'case': 'generate-config-preserves-existing-file', 'pass': success})
    config.write_text('self-hosted-runner:\n  labels: [no-such-runner]\npaths:\n  .github/workflows/**:\n    ignore: ["unknown Webhook", "constant expression"]\n')
    actual = subprocess.run([*command], text=True, capture_output=True, cwd=directory, env=env)
    results.append({'case': 'repository-config', 'pass': actual.returncode == 0 and actual.stdout == ''})
    (directory / 'override.yaml').write_text('self-hosted-runner:\n  labels: [no-such-runner]\n')
    actual = subprocess.run([*command, '-config-file', 'override.yaml'], text=True, capture_output=True, cwd=directory, env=env)
    results.append({'case': 'explicit-config-precedence', 'pass': actual.returncode == 1 and 'unknown Webhook' in actual.stdout})
    for index, content in enumerate(['true', '[]', 'self-hosted-runner: 42', 'self-hosted-runner:\n  labels: foo', 'config-variables: abc', 'config-variables: [true, 2, {}]', 'paths: []', 'paths:\n  foo: bar', 'paths:\n  foo:\n    ignore: abc', 'config-variables: []\nconfig-variables: []']):
        override = directory / 'invalid-config.yml'
        override.write_text(content)
        flags = ['-config-file', str(override), '-']
        actual = subprocess.run([*command, *flags], input=valid, text=True, capture_output=True, cwd=directory, env=env)
        success = actual.returncode == 3
        detail = ''
        if args.reference:
            expected = subprocess.run([str(args.reference.resolve()), '-pyflakes=', *flags], input=valid, text=True, capture_output=True, cwd=directory, env=env)
            success = success and actual.stderr == expected.stderr
            if not success:
                detail = {'expected': expected.stderr, 'actual': actual.stderr}
        results.append({'case': f'config-types-{index}', 'pass': success, 'detail': detail})
    report = ROOT / '_build' / f'cli-{args.target}.json'
    report.write_text(json.dumps(results, ensure_ascii=False, indent=2))
    failed = [r['case'] for r in results if not r['pass']]
    print(f'{len(results)-len(failed)}/{len(results)} CLI scenarios passed ({args.target}); report: {report}')
    for case in failed:
        print('FAIL:', case)
    raise SystemExit(bool(failed))
