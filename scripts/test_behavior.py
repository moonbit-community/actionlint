#!/usr/bin/env python3
"""Check permanent baseline results, optionally also checking a reference binary.

Only the temporary project directory is normalized. Upstream expectations are
captured from baseline; intentional product differences keep separate expectations.
"""
import argparse
import concurrent.futures
import hashlib
import json
import os
from pathlib import Path
import resource
import re
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]


def decode_output(data, project):
    data = data.replace(str(project).encode(), b'$PROJECT')
    try:
        return data.decode('utf-8')
    except UnicodeDecodeError:
        # Go templates operate on bytes and can produce invalid UTF-8.
        return {'hex': data.hex()}


def run(command, argv, project, source):
    result = subprocess.run(
        [*command, *argv], cwd=project,
        env={**os.environ, 'NO_COLOR': '1', 'LC_ALL': 'C'},
        input=source, capture_output=True, timeout=30,
    )
    return {
        'code': result.returncode,
        'stdout': decode_output(result.stdout, project),
        'stderr': decode_output(result.stderr, project),
    }


def matches_expected(actual, expected):
    if 'stderr_events' not in expected:
        return actual == expected
    return (actual.get('code') == expected['code']
            and actual.get('stdout') == expected['stdout']
            and all(re.search(event, actual.get('stderr', ''))
                    for event in expected['stderr_events'])
            and all(not re.search(event, actual.get('stderr', ''))
                    for event in expected.get('stderr_absent', [])))


def run_case(case, commands):
    with tempfile.TemporaryDirectory(prefix='actionlint-behavior-') as tmp:
        project = Path(tmp)
        (project / '.git').mkdir()
        (project / '.github/workflows').mkdir(parents=True)
        workflow = '.github/workflows/main.yml'
        if case.get('write_workflow', True):
            (project / workflow).write_text(case['source'])
        for name, content in case['files'].items():
            path = project / name
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(content)
            if name.endswith('.py'):
                path.chmod(0o755)
        stdin = case.get('stdin', not case['files'])
        argv = ['-shellcheck=', '-oneline',
                *[s.replace('{project}', tmp) for s in case['flags']],
                *case.get('arguments', ['-' if stdin else workflow])]
        row = {'id': case['id'], 'expected': case['expected']}
        if 'baseline_expected' in case:
            row.update({k: case[k] for k in ['baseline_expected', 'difference_reason']})
        for target, command in commands.items():
            try:
                target_argv = ['-pyflakes=', *argv] if target == 'reference' else argv
                actual = run(command, target_argv, project,
                             case['source'].encode() if stdin else None)
            except subprocess.TimeoutExpired:
                actual = {'timeout': True}
            row[target] = actual
        if 'baseline_expected' in case and not case.get('difference_reason'):
            raise ValueError('Intentional differences require difference_reason: ' + case['id'])
        row['different'] = {
            t: not matches_expected(row[t], case.get('baseline_expected', case['expected'])
                                    if t == 'reference' else case['expected'])
            for t in commands}

        return row


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--target', choices=['native', 'wasm', 'all'], default='all')
    parser.add_argument('--reference', type=Path)
    parser.add_argument('--case', help='Run cases containing this substring')
    args = parser.parse_args()
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    cases = json.loads((ROOT / 'scripts/behavior_cases.json').read_text())
    cases += json.loads((ROOT / 'scripts/audit_cases.json').read_text())
    cases += json.loads((ROOT / 'scripts/boundary_cases.json').read_text())
    cases += json.loads((ROOT / 'scripts/review_cases.json').read_text())
    cases += json.loads((ROOT / 'scripts/review_boundary_cases.json').read_text())
    cases += json.loads((ROOT / 'scripts/pyflakes_removal_cases.json').read_text())
    if len({c['id'] for c in cases}) != len(cases):
        raise ValueError('Behavior case IDs must be unique')
    commands = {}
    if args.target in ['native', 'all']:
        commands['native'] = [str(ROOT / 'bin/actionlint')]
    if args.target in ['wasm', 'all']:
        commands['wasm'] = ['moonrun', str(ROOT / 'bin/actionlint.wasm')]
    if args.reference:
        commands['reference'] = [str(args.reference.resolve())]
    cases = [c for c in cases if not args.case or args.case in c['id']]
    with concurrent.futures.ThreadPoolExecutor(max_workers=4) as executor:
        results = list(executor.map(lambda c: run_case(c, commands), cases))
    summary = {t: {'total': len(results),
                   'different': sum(r['different'][t] for r in results)}
               for t in commands}
    report = {'summary': summary, 'commands': commands,
              'native_wasm_differences': (sum(r['native'] != r['wasm'] for r in results)
                                           if 'native' in commands and 'wasm' in commands else None),
              'sha256': {t: hashlib.sha256(Path(c[-1]).read_bytes()).hexdigest()
                         for t, c in commands.items()}, 'results': results}
    destination = ROOT / '_build/behavior-report.json'
    destination.write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps(summary))
    for row in results:
        for target, different in row['different'].items():
            if different:
                print('FAIL', row['id'], target,
                      json.dumps(row[target], ensure_ascii=False))
    print('Report:', destination)
    return int(any(any(r['different'].values()) for r in results))


if __name__ == '__main__':
    raise SystemExit(main())
