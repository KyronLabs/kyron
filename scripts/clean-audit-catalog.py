#!/usr/bin/env python3
from __future__ import annotations
import json
from pathlib import Path
root = Path(__file__).resolve().parents[1] / 'app/lib/l10n'
for name in ('app_en.arb', 'app_es.arb', 'app_zh.arb'):
    path = root / name
    data = json.loads(path.read_text())
    for key in list(data):
        value = data[key]
        if key.startswith('audit_') and isinstance(value, str) and ('$' in value or value.startswith(('^', 'http', 'mailto:'))):
            del data[key]
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n')
    print(name, sum(not k.startswith('@') for k in data))
