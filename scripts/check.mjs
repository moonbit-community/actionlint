#!/usr/bin/env node
// Compact compiler diagnostics for development and propagate moon's exit code.
import { mkdirSync, writeFileSync } from 'node:fs';
import { run } from './cli_utils.mjs';

const args = ['check', '--frozen', '--output-json', ...process.argv.slice(2)];
const { code, stdout, stderr } = await run(['moon'], args, process.cwd(), undefined, process.env);
const log = stdout.toString('utf8') + stderr.toString('utf8');
mkdirSync('_build', { recursive: true });
writeFileSync('_build/check.log', log);
const counts = new Map();
for (const line of log.split(/\r?\n/)) {
  let diagnostic;
  try {
    diagnostic = JSON.parse(line);
  } catch {
    if (line.includes('Error:') || line.includes('Finished.')) console.log(line.slice(0, 500));
    continue;
  }
  const level = diagnostic.level ?? '';
  counts.set(level, (counts.get(level) ?? 0) + 1);
  if (level === 'error') console.log(diagnostic.loc ?? diagnostic.location ?? '', diagnostic.message ?? '');
}
const summary = [...counts].map(([level, count]) => `'${level}': ${count}`).join(', ');
console.log(`{${summary}}`);
process.exitCode = code;
