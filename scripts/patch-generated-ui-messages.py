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
        if not (key.startswith('ui_') or key.startswith('audit_') or key in {
            'authorPostsHidden', 'authorBlocked', 'nothingMatchesQuery', 'repliesPolicy', 'feedTagDetail',
        }):
            continue
        if f"'{key}':" in text:
            continue
        encoded = json.dumps(value, ensure_ascii=False)
        if key == 'authorPostsHidden':
            additions.append("      'authorPostsHidden': (Object author) => 'You will not see posts from $author',")
        elif key == 'authorBlocked':
            additions.append("      'authorBlocked': (Object author) => '$author blocked',")
        elif key == 'nothingMatchesQuery':
            additions.append("      'nothingMatchesQuery': (Object what) => 'Nothing on Kyron matches \"$what\"',")
        elif key == 'repliesPolicy':
            additions.append("      'repliesPolicy': (Object policy) => 'Replies: $policy',")
        elif key == 'feedTagDetail':
            additions.append("      'feedTagDetail': (Object tab) => 'Nothing has been posted under #$tab yet.',")
        else:
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
