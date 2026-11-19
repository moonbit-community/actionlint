#!/usr/bin/env node
import { isUtf8 } from 'node:buffer';
import { createHash } from 'node:crypto';
import { chmodSync, mkdirSync, mkdtempSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join, resolve } from 'node:path';
import { isDeepStrictEqual as equal } from 'node:util';
import { options, root, run } from './cli_utils.mjs';

const args = options(['native', 'wasm', 'all'], 'all', { case: { type: 'string' } });
const env = { ...process.env, NO_COLOR: '1', LC_ALL: 'C' };
const commands = {};
if (args.target !== 'wasm') commands.native = [join(root, 'bin/actionlint')];
if (args.target !== 'native') commands.wasm = ['moonrun', join(root, 'bin/actionlint.wasm')];
if (args.reference) commands.reference = [resolve(args.reference)];

function decode(bytes, project) {
  // Normalize the path before decoding. Templates can emit invalid UTF-8.
  const pathBytes = Buffer.from(project).toString('latin1');
  const normalized = Buffer.from(bytes.toString('latin1').replaceAll(pathBytes, '$PROJECT'), 'latin1');
  return isUtf8(normalized) ? normalized.toString('utf8') : { hex: normalized.toString('hex') };
}

function matches(actual, expected) {
  if (!expected.stderr_events) return equal(actual, expected);
  const hasEvent = pattern => {
    const ignoreCase = pattern.startsWith('(?i)');
    return new RegExp(ignoreCase ? pattern.slice(4) : pattern, ignoreCase ? 'i' : '').test(actual.stderr);
  };
  return actual.code === expected.code && actual.stdout === expected.stdout &&
    typeof actual.stderr === 'string' && expected.stderr_events.every(hasEvent) &&
    !(expected.stderr_absent ?? []).some(hasEvent);
}

async function runCase(test) {
  const project = mkdtempSync(join(tmpdir(), 'actionlint-behavior-'));
  try {
    mkdirSync(join(project, '.git'));
    mkdirSync(join(project, '.github/workflows'), { recursive: true });
    const workflow = '.github/workflows/main.yml';
    if (test.write_workflow !== false) writeFileSync(join(project, workflow), test.source);
    for (const [name, content] of Object.entries(test.files)) {
      const path = join(project, name);
      mkdirSync(dirname(path), { recursive: true });
      writeFileSync(path, content);
      if (name.endsWith('.mjs')) chmodSync(path, 0o755);
    }
    const stdin = test.stdin ?? (Object.keys(test.files).length === 0);
    const flags = ['-shellcheck=', '-oneline', ...test.flags.map(s => s.replaceAll('{project}', () => project)),
      ...(test.arguments ?? [stdin ? '-' : workflow])];
    const row = { id: test.id, expected: test.expected };
    if (test.baseline_expected) {
      if (!test.difference_reason) throw new Error(`Intentional differences require difference_reason: ${test.id}`);
      row.baseline_expected = test.baseline_expected;
      row.difference_reason = test.difference_reason;
    }
    const different = {};
    for (const [target, command] of Object.entries(commands)) {
      const argv = target === 'reference' ? ['-pyflakes=', ...flags] : flags;
      // Suppress core files from crash cases. Pass input paths and flags as separate arguments.
      const result = await run(['sh', '-c', 'ulimit -c 0 && exec "$@"', 'sh', ...command],
        argv, project, stdin ? test.source : undefined, env, 30_000);
      row[target] = result.timeout ? result : {
        code: result.code, stdout: decode(result.stdout, project), stderr: decode(result.stderr, project),
      };
      const expected = target === 'reference' ? (test.baseline_expected ?? test.expected) : test.expected;
      different[target] = !matches(row[target], expected);
    }
    return { ...row, different };
  } finally {
    rmSync(project, { recursive: true, force: true });
  }
}

const suites = ['behavior', 'audit', 'boundary', 'review', 'review_boundary', 'pyflakes_removal'];
const all = suites.flatMap(suite => JSON.parse(readFileSync(join(root, 'scripts', suite + '_cases.json'), 'utf8')));
if (new Set(all.map(test => test.id)).size !== all.length) throw new Error('Behavior case IDs must be unique');
const cases = all.filter(test => !args.case || test.id.includes(args.case));
const results = new Array(cases.length);
const pending = cases.entries();
async function worker() {
  for (const [index, test] of pending) results[index] = await runCase(test);
}
await Promise.all(Array.from({ length: 4 }, worker));

const summary = {};
const sha256 = {};
for (const [target, command] of Object.entries(commands)) {
  summary[target] = { total: results.length, different: results.filter(row => row.different[target]).length };
  sha256[target] = createHash('sha256').update(readFileSync(command.at(-1))).digest('hex');
}
const report = { summary, commands,
  native_wasm_differences: commands.native && commands.wasm ? results.filter(row => !equal(row.native, row.wasm)).length : null,
  sha256, results };
const destination = join(root, '_build/behavior-report.json');
writeFileSync(destination, JSON.stringify(report, null, 2) + '\n');
console.log(JSON.stringify(summary));
for (const row of results) {
  for (const [target, different] of Object.entries(row.different)) {
    if (different) console.log('FAIL', row.id, target, JSON.stringify(row[target]));
  }
}
console.log('Report:', destination);
process.exitCode = Object.values(summary).some(count => count.different) ? 1 : 0;
