#!/usr/bin/env python3
"""Export fixed upstream tables to MoonBit, without requiring Go or a network."""
from pathlib import Path
import json
import re

ROOT = Path(__file__).resolve().parents[1]
BASE = ROOT / 'baseline'

def strings(text):
    return [json.loads(s) for s in re.findall(r'"(?:\\.|[^"\\])*"', text)]

def balanced(text, start):
    depth = 0
    quoted = False
    escaped = False
    for i in range(start, len(text)):
        ch = text[i]
        if quoted:
            if escaped:
                escaped = False
            elif ch == '\\':
                escaped = True
            elif ch == '"':
                quoted = False
        elif ch == '"':
            quoted = True
        elif ch == '{':
            depth += 1
        elif ch == '}':
            depth -= 1
            if depth == 0:
                return text[start+1:i]
    raise ValueError('unbalanced Go table')

def table(file, name):
    src = (BASE / file).read_text()
    offset = src.index('var ' + name + ' ')
    offset = src.index('{', offset)
    if src[offset:offset+3] == '{}{':
        offset += 2
    return balanced(src, offset)

data = {}
for file, name, target in [
    ('all_webhooks.go', 'AllWebhookTypes', 'webhooks'),
    ('rule_permissions.go', 'allPermissionScopes', 'permissions'),
]:
    src = (BASE/file).read_text()
    if 'var ' + name + ' ' not in src:
        if target == 'availability':
            name = re.search(r'var (\w+) = map\[string\]\[2\]\[\]string', src).group(1)
        else:
            raise ValueError(name)
    body = table(file, name)
    if target == 'availability':
        entries = {}
        for match in re.finditer(r'^\s*"([^"\n]+)":\s*\{', body, re.M):
            chunk = balanced(body, body.index('{', match.start()))
            groups = re.findall(r'\[\]string\{([^}]+)\}|\{([^{}]*)\}', chunk)
            entries[match.group(1)] = [strings(a or b) for a,b in groups]
        data[target] = entries
    else:
        data[target] = {m.group(1): strings(m.group(2) or '') for m in re.finditer(r'"([^"]+)":\s*(?:\{([^}]*)\}|nil)', body)}

data['availability'] = {}
for match in re.finditer(r'case ([^:]+):\s*return \[\]string\{([^}]*)\}, \[\]string\{([^}]*)\}', (BASE/'availability.go').read_text()):
    for key in strings(match.group(1)):
        data['availability'][key] = [strings(match.group(2)), strings(match.group(3))]

def split_top(text):
    parts, start, depth = [], 0, 0
    quoted = escaped = False
    for i, ch in enumerate(text):
        if quoted:
            if escaped: escaped = False
            elif ch == '\\': escaped = True
            elif ch == '"': quoted = False
        elif ch == '"': quoted = True
        elif ch in '{[(': depth += 1
        elif ch in '}])': depth -= 1
        elif ch == ',' and depth == 0:
            if text[start:i].strip(): parts.append(text[start:i].strip())
            start = i + 1
    if text[start:].strip(): parts.append(text[start:].strip())
    return parts

def go_type(text):
    text = text.strip()
    for go, mb in [('StringType{}', 'string'), ('NumberType{}', 'number'), ('BoolType{}', 'bool'), ('AnyType{}', 'any'), ('NullType{}', 'null')]:
        if text == go: return mb
    if text in ['NewEmptyStrictObjectType()', 'NewEmptyObjectType()']:
        return {'props': {}, 'mapped': None if 'Strict' in text else 'any'}
    if text.startswith('NewMapObjectType('):
        return {'props': {}, 'mapped': go_type(text[len('NewMapObjectType('):-1])}
    if text.startswith('NewStrictObjectType(') or text.startswith('NewObjectType('):
        inner = balanced(text, text.index('{'))
        return {'props': go_type_map(inner), 'mapped': None if 'Strict' in text[:25] else 'any'}
    raise ValueError('unsupported Go type: ' + text)

def go_type_map(text):
    return {json.loads(k): go_type(v) for k,v in (entry.split(':', 1) for entry in split_top(text))}

type_source = re.sub(r'//[^\n]*', '', table('expr_sema.go', 'BuiltinGlobalVariableTypes'))
data['context_types'] = go_type_map(type_source)
data['rule_descriptions'] = {'syntax-check': 'Checks for GitHub Actions workflow syntax'}
for rule in BASE.glob('rule_*.go'):
    # Pyflakes integration is intentionally excluded from this port.
    if rule.name.endswith('_test.go') or rule.name == 'rule_pyflakes.go': continue
    match = re.search(r'name:\s*("(?:\\.|[^"\\])*"),\s*desc:\s*("(?:\\.|[^"\\])*")', rule.read_text())
    if match: data['rule_descriptions'][json.loads(match.group(1))] = json.loads(match.group(2))
data['runners'] = strings(table('rule_runner_label.go', 'allGitHubHostedRunnerLabels'))
data['runner_compat'] = {m.group(1): m.group(2).strip() for m in re.finditer(r'"([^"\n]+)":\s*([^,\n]+)', table('rule_runner_label.go', 'defaultRunnerOSCompats'))}
data['actions'] = {}
body = table('popular_actions.go', 'PopularActions')
for match in re.finditer(r'^\t"([^"\n]+)": \{', body, re.M):
    action = balanced(body, body.index('{', match.start()))
    inputs = {}
    if re.search(r'\bInputs:\s*ActionMetadataInputs\{', action):
        text = balanced(action, action.index('{', action.index('Inputs:')))
        for im in re.finditer(r'"([^"\n]+)":\s*\{("(?:\\.|[^"\\])*")\s*,\s*(true|false),\s*(true|false),\s*("(?:\\.|[^"\\])*")\}', text):
            inputs[im.group(1)] = [json.loads(im.group(2)), im.group(3) == 'true', im.group(4) == 'true', json.loads(im.group(5))]
    outputs = []
    if re.search(r'\bOutputs:\s*ActionMetadataOutputs\{', action):
        outputs = re.findall(r'"([^"\n]+)":', balanced(action, action.index('{', action.index('Outputs:'))))
    data['actions'][match.group(1)] = {'inputs': inputs, 'outputs': outputs, 'skip_inputs': bool(re.search(r'SkipInputs:\s*true', action)), 'skip_outputs': bool(re.search(r'SkipOutputs:\s*true', action))}

data['outdated_actions'] = re.findall(r'"([^"\n]+)":', table('popular_actions.go', 'OutdatedPopularActionSpecs'))

src = (BASE/'rule_action.go').read_text()
for name in re.findall(r'var (\w+) = map\[string\]', src):
    data[name] = table('rule_action.go', name)

# Frozen zone names exported from Go 1.25's bundled zoneinfo.zip.
data['timezones'] = json.loads((ROOT/'scripts/timezones.json').read_text())

encoded = json.dumps(data, ensure_ascii=True, indent=0)
out = '// Generated by scripts/generate_baseline_data.py from baseline.\n// Upstream actionlint copyright rhysd, MIT license; see THIRD_PARTY_NOTICES.\n\n///|\npub let builtin_data : Json = @json.parse((\n'
packed, line = [], ''
for token in encoded.splitlines():
    if len(line) + len(token) > 180:
        packed.append(line)
        line = ''
    line += token
if line:
    packed.append(line)
out += '\n'.join('  #|' + line for line in packed)
out += '\n)) catch { _ => abort("invalid generated actionlint data") }\n'
(ROOT/'internal/data/builtin_data.mbt').write_text(out)
print('Exported', len(data['actions']), 'actions,', len(data['timezones']), 'timezones')
