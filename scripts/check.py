#!/usr/bin/env python3
"""Compact compiler diagnostics during development; preserves moon's exit code."""
import json
import subprocess
import sys
from pathlib import Path

result = subprocess.run(['moon', 'check', '--frozen', '--output-json', *sys.argv[1:]], text=True, capture_output=True)
log = result.stdout + result.stderr
Path('_build').mkdir(exist_ok=True)
Path('_build/check.log').write_text(log)
counts = {}
for line in log.splitlines():
    try:
        diagnostic = json.loads(line)
    except ValueError:
        if 'Error:' in line or 'Finished.' in line:
            print(line[:500])
        continue
    level = diagnostic.get('level', '')
    counts[level] = counts.get(level, 0) + 1
    if level == 'error':
        print(diagnostic.get('loc', diagnostic.get('location', '')), diagnostic.get('message', ''))
print(counts)
sys.exit(result.returncode)
