#!/usr/bin/env node
// Audit production functions using compiler-resolved references on each CLI target.
import { execFile } from 'node:child_process';
import { mkdtempSync, readFileSync, rmSync } from 'node:fs';
import { join, relative, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { promisify } from 'node:util';

const root = fileURLToPath(new URL('../', import.meta.url));
const exec = promisify(execFile);

async function moon(args, cwd = root) {
  const { stdout, stderr } = await exec('moon', args, { cwd, maxBuffer: 64 * 1024 * 1024 });
  process.stderr.write(stderr);
  return stdout;
}

async function ide(target, ...args) {
  return JSON.parse(await moon(['ide', ...args, '--json', '--no-check', '--target', target]));
}

async function productionFunctions(target) {
  // gen-symbols writes into its working directory. Keep each audit's output private.
  const directory = mkdtempSync(join(root, '_build', 'audit-'));
  let symbols;
  try {
    await moon(['ide', 'gen-symbols', '--no-check', '--target', target], directory);
    symbols = readFileSync(join(directory, 'symbols.jsonl'), 'utf8');
  } finally {
    rmSync(directory, { recursive: true, force: true });
  }

  const files = new Map();
  const sources = new Map();
  for (const row of symbols.trimEnd().split('\n')) {
    const symbol = JSON.parse(row);
    if (symbol.pkg !== 'moonbit-community/actionlint' && !symbol.pkg.startsWith('moonbit-community/actionlint/')) continue;
    if (/(?:_test\.mbt|_wbtest\.mbt|\.mbt\.md)$/.test(symbol.path)) continue;
    if (!['0x1000', '0x1001'].includes(symbol.tag)) continue;
    const path = resolve(root, symbol.path);
    const [start, , end] = symbol.range;
    const [line, column] = symbol.name_range;
    if (!sources.has(path)) sources.set(path, readFileSync(path, 'utf8').split('\n'));
    // Generated derive and extend methods have no source function declaration.
    if (!/\bfn\b/.test(sources.get(path).slice(start - 1, line).join('\n'))) continue;
    const name = symbol.kind.slice(1).join('::');
    const key = JSON.stringify([symbol.path, line, column, name]);
    if (!files.has(path)) files.set(path, []);
    files.get(path).push({ key, path, start, end, name, position: `${line}:${column}`, public: symbol.tag === '0x1001' });
  }
  return files;
}

async function forEachConcurrent(items, operation) {
  const iterator = items[Symbol.iterator]();
  async function worker() {
    for (const item of iterator) await operation(item);
  }
  await Promise.all(Array.from({ length: 4 }, worker));
}

async function audit(target) {
  await moon(['check', '--target', target]);
  const files = await productionFunctions(target);
  const main = files.get(join(root, 'main.mbt'))?.find(fn => fn.name === 'main');
  if (!main) throw new Error(`MoonBit did not report the ${target} CLI entry point`);
  const roots = new Set([main]);
  const active = new Set([main]);
  const callees = new Map();

  function record(fn, refs) {
    for (const ref of refs) {
      if (ref.is_test) continue;
      const line = parseInt(ref.range, 10);
      const caller = files.get(resolve(root, ref.path))?.find(f => f.start <= line && line <= f.end);
      if (caller) {
        if (!callees.has(caller)) callees.set(caller, new Set());
        callees.get(caller).add(fn);
      } else {
        // Initializers and trait implementations can run without a direct caller.
        roots.add(fn);
      }
    }
  }

  await forEachConcurrent(files, async ([path, functions]) => {
    const locations = new Map(functions.map(fn => [fn.position, fn]));
    for (const { command } of await ide(target, 'codelens', path)) {
      if (command.command !== 'moonbit.action.goToLocations') continue;
      const [, position, refs] = command.arguments;
      const fn = locations.get(position.split('-')[0]);
      if (fn) {
        // CodeLens reports only declarations active on this target.
        active.add(fn);
        record(fn, refs);
      }
    }
  });
  await forEachConcurrent([...active].filter(fn => fn.public), async fn => {
    const refs = await ide(target, 'find-references', '--loc', `${fn.path}:${fn.position}`);
    record(fn, refs ?? []);
  });

  const live = new Set(roots);
  for (const fn of live) {
    for (const callee of callees.get(fn) ?? []) live.add(callee);
  }
  return { active, live };
}

const declared = new Map();
const reachable = new Set();
for (const target of ['wasm', 'native']) {
  const { active, live } = await audit(target);
  for (const fn of active) declared.set(fn.key, fn);
  for (const fn of live) reachable.add(fn.key);
}
const dead = [...declared.values()].filter(fn => !reachable.has(fn.key));
dead.sort((a, b) => a.path.localeCompare(b.path) || a.start - b.start || a.name.localeCompare(b.name));
for (const fn of dead) console.log(`${relative(root, fn.path)}:${fn.start}: unreachable ${fn.name}`);
console.log(`${dead.length} unreachable production functions`);
process.exitCode = dead.length ? 1 : 0;
