#!/usr/bin/env node
// Export the vendored Go tables to MoonBit using the bundled baseline and zone names.
import { opendirSync, readFileSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = fileURLToPath(new URL('../', import.meta.url));
const base = join(root, 'baseline');
const read = name => readFileSync(join(base, name), 'utf8');
const strings = text => [...text.matchAll(/"(?:\\.|[^"\\])*"/g)].map(match => JSON.parse(match[0]));

// Skip string literals while finding Go braces, argument lists and top-level commas.
function* punctuation(text, start = 0) {
  let quoted = false;
  for (let i = start; i < text.length; i++) {
    const ch = text[i];
    if (quoted && ch === '\\') i++;
    else if (ch === '"') quoted = !quoted;
    else if (!quoted) yield [i, ch];
  }
}

function balanced(text, start) {
  if (text[start] !== '{') throw new Error('Missing opening brace in Go table');
  let depth = 0;
  for (const [i, ch] of punctuation(text, start)) {
    if (ch === '{') depth++;
    if (ch === '}') {
      depth--;
      if (depth === 0) return text.slice(start + 1, i);
    }
  }
  throw new Error('Unbalanced Go table');
}

function table(file, name) {
  const src = read(file);
  const offset = src.indexOf('var ' + name + ' ');
  if (offset < 0) throw new Error(`Missing ${name} in ${file}`);
  const start = src.indexOf('{', offset);
  return balanced(src, src.startsWith('{}{', start) ? start + 2 : start);
}

function splitTop(text) {
  const parts = [];
  let start = 0;
  let depth = 0;
  for (const [i, ch] of punctuation(text)) {
    if ('{[('.includes(ch)) depth++;
    if ('}])'.includes(ch)) depth--;
    if (ch === ',' && depth === 0) {
      const part = text.slice(start, i).trim();
      if (part) parts.push(part);
      start = i + 1;
    }
  }
  const last = text.slice(start).trim();
  if (last) parts.push(last);
  return parts;
}

function goType(value) {
  const text = value.trim();
  const scalar = /^(String|Number|Bool|Any|Null)Type\{\}$/.exec(text);
  if (scalar) return scalar[1].toLowerCase();
  const object = /^New(Empty)?(Strict)?ObjectType\(/.exec(text);
  if (object) {
    const props = object[1] ? {} : goTypeMap(balanced(text, text.indexOf('{')));
    return { props, mapped: object[2] ? null : 'any' };
  }
  if (text.startsWith('NewMapObjectType(')) {
    return { props: {}, mapped: goType(text.slice('NewMapObjectType('.length, -1)) };
  }
  throw new Error('Unsupported Go type: ' + text);
}

function goTypeMap(body) {
  return Object.fromEntries(splitTop(body).map(entry => {
    const colon = entry.indexOf(':');
    return [JSON.parse(entry.slice(0, colon)), goType(entry.slice(colon + 1))];
  }));
}

const data = {};
for (const [file, name, target] of [
  ['all_webhooks.go', 'AllWebhookTypes', 'webhooks'],
  ['rule_permissions.go', 'allPermissionScopes', 'permissions'],
]) {
  const entries = table(file, name).matchAll(/"([^"]+)":\s*(?:\{([^}]*)\}|nil)/g);
  data[target] = Object.fromEntries([...entries].map(([, key, values]) => [key, strings(values ?? '')]));
}
data.availability = {};
for (const [, cases, first, second] of read('availability.go')
  .matchAll(/case ([^:]+):\s*return \[\]string\{([^}]*)\}, \[\]string\{([^}]*)\}/g)) {
  for (const key of strings(cases)) data.availability[key] = [strings(first), strings(second)];
}
data.context_types = goTypeMap(table('expr_sema.go', 'BuiltinGlobalVariableTypes').replace(/\/\/[^\n]*/g, ''));
data.rule_descriptions = { 'syntax-check': 'Checks for GitHub Actions workflow syntax' };
const dir = opendirSync(base);
try {
  for (let entry; (entry = dir.readSync()) !== null;) {
    if (!/^rule_.*\.go$/.test(entry.name) || entry.name.endsWith('_test.go') || entry.name === 'rule_pyflakes.go') continue;
    const match = /name:\s*("(?:\\.|[^"\\])*"),\s*desc:\s*("(?:\\.|[^"\\])*")/.exec(read(entry.name));
    if (match) data.rule_descriptions[JSON.parse(match[1])] = JSON.parse(match[2]);
  }
} finally {
  dir.closeSync();
}
data.runners = strings(table('rule_runner_label.go', 'allGitHubHostedRunnerLabels'));
const compats = table('rule_runner_label.go', 'defaultRunnerOSCompats').matchAll(/"([^"\n]+)":\s*([^,\n]+)/g);
data.runner_compat = Object.fromEntries([...compats].map(([, key, value]) => [key, value.trim()]));
data.actions = {};
const actions = table('popular_actions.go', 'PopularActions');
for (const match of actions.matchAll(/^\t"([^"\n]+)": \{/gm)) {
  const action = balanced(actions, actions.indexOf('{', match.index));
  const inputs = {};
  if (/\bInputs:\s*ActionMetadataInputs\{/.test(action)) {
    const body = balanced(action, action.indexOf('{', action.indexOf('Inputs:')));
    const entries = body.matchAll(/"([^"\n]+)":\s*\{("(?:\\.|[^"\\])*")\s*,\s*(true|false),\s*(true|false),\s*("(?:\\.|[^"\\])*")\}/g);
    for (const [, key, name, required, deprecated, description] of entries) {
      inputs[key] = [JSON.parse(name), required === 'true', deprecated === 'true', JSON.parse(description)];
    }
  }
  let outputs = [];
  if (/\bOutputs:\s*ActionMetadataOutputs\{/.test(action)) {
    const body = balanced(action, action.indexOf('{', action.indexOf('Outputs:')));
    outputs = [...body.matchAll(/"([^"\n]+)":/g)].map(m => m[1]);
  }
  data.actions[match[1]] = { inputs, outputs, skip_inputs: /SkipInputs:\s*true/.test(action), skip_outputs: /SkipOutputs:\s*true/.test(action) };
}
data.outdated_actions = [...table('popular_actions.go', 'OutdatedPopularActionSpecs').matchAll(/"([^"\n]+)":/g)].map(m => m[1]);
for (const key of ['BrandingColors', 'BrandingIcons']) {
  data[key] = Object.fromEntries(strings(table('rule_action.go', key)).map(name => [name, true]));
}
data.timezones = JSON.parse(readFileSync(join(root, 'scripts/timezones.json'), 'utf8'));

// JSON literals construct MoonBit Json values directly. Keep the source ASCII-only
// and translate form feed escapes, which MoonBit spells as \u000c rather than \f.
// Match existing escapes as a unit so literal backslashes remain unchanged.
function jsonLiteral(value) {
  return JSON.stringify(value, null, 2).replace(/\\.|[^\u0000-\u007e]/gu, token => {
    if (token === '\\f') return '\\u000c';
    if (token.startsWith('\\')) return token;
    return '\\u{' + token.codePointAt(0).toString(16) + '}';
  });
}

// Keep each table in a separate function: inlining all of them into module
// initialization can exceed Wasm engines' limit on locals in a single function.
const tables = Object.entries(data).map(([key, value]) => ({
  key, value, name: 'builtin_' + key.replace(/([a-z])([A-Z])/g, '$1_$2').toLowerCase(),
}));
const fields = tables.map(({ key, name }) => `  ${jsonLiteral(key)}: ${name}(),`).join('\n');
const definitions = tables.map(({ name, value }) =>
  `///|\n#inline(never)\nfn ${name}() -> Json {\n  ${jsonLiteral(value).replaceAll('\n', '\n  ')}\n}`);
const output = '// Generated by scripts/generate_baseline_data.mjs from baseline.\n' +
  '// Upstream actionlint copyright rhysd, MIT license; see THIRD_PARTY_NOTICES.\n\n///|\n' +
  'pub let builtin_data : Json = {\n' + fields + '\n}\n\n' + definitions.join('\n\n') + '\n';
writeFileSync(join(root, 'internal/data/builtin_data.mbt'), output);
console.log('Exported', Object.keys(data.actions).length, 'actions,', data.timezones.length, 'timezones');
