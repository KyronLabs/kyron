#!/usr/bin/env python3
from __future__ import annotations
import json
from pathlib import Path

root = Path(__file__).resolve().parents[1] / 'app/lib/l10n'
for locale in ('en', 'es', 'zh'):
    arb = json.loads((root / f'app_{locale}.arb').read_text())
    path = root / 'generated' / f'messages_{locale}.dart'
    text = path.read_text()
    additions = []
    for key, value in arb.items():
        if not (key.startswith('ui_') or key.startswith('audit_')):
            continue
        if f"'{key}':" in text:
            continue
        encoded = json.dumps(value, ensure_ascii=False)
        additions.append(f"      '{key}': MessageLookupByLibrary.simpleMessage({encoded}),")
    if additions:
        marker = '\n    };' if '\n    };' in text else '\n  };'
        if marker not in text:
            raise SystemExit(f'Could not find message map end in {path}')
        indent = '      ' if marker == '\n    };' else '      '
        additions = [entry.replace('      ', indent, 1) for entry in additions]
        separator = '\n' if text[: text.index(marker)].rstrip().endswith(',') else ',\n'
        text = text.replace(marker, separator + '\n'.join(additions) + marker, 1)
        path.write_text(text)
    if 'final messageLookup = MessageLookup();' not in text and 'final messageLookup = messages;' not in text:
        text = text.rstrip() + '\n\nfinal messageLookup = messages;\n'
        path.write_text(text)
    print(f'{path.name}: added {len(additions)} entries')
