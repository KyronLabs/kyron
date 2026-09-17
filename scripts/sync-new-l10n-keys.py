#!/usr/bin/env python3
from __future__ import annotations
import json
from pathlib import Path

root = Path(__file__).resolve().parents[1] / 'app' / 'lib' / 'l10n'
en = json.loads((root / 'app_en.arb').read_text())
for name in ('app_es.arb', 'app_zh.arb'):
    path = root / name
    target = json.loads(path.read_text())
    for key, value in en.items():
        if key.startswith('@'):
            continue
        target.setdefault(key, value)
    target['@@last_modified'] = '2026-09-17T23:10:00Z'
    path.write_text(json.dumps(target, ensure_ascii=False, indent=2) + '\n')
    print(f'{name}: {sum(not k.startswith("@") for k in target)} strings')
