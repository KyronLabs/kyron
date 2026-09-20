from __future__ import annotations
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1] / 'app' / 'lib' / 'l10n'
TOKEN = re.compile(r'\$\{[^}]+\}|\$[A-Za-z_][A-Za-z0-9_]*')

def dart_string(value: str) -> str:
    return json.dumps(value, ensure_ascii=False)

def make_lookup(locale: str, catalog: dict[str, str]) -> str:
    rows = []
    for key, value in catalog.items():
        if key.startswith('@'):
            continue
        tokens = list(TOKEN.finditer(value))
        if not tokens:
            rows.append(f'      {json.dumps(key)}: MessageLookupByLibrary.simpleMessage({dart_string(value)}),')
            continue
        rendered = []
        end = 0
        for index, token in enumerate(tokens):
            rendered.append(value[end:token.start()])
            rendered.append(f'${{a{index}}}')
            end = token.end()
        rendered.append(value[end:])
        args = ', '.join(f'Object a{i}' for i in range(len(tokens)))
        rows.append(f'      {json.dumps(key)}: ({args}) => {dart_string("".join(rendered))},')
    return """import 'package:intl/message_lookup_by_library.dart';

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => '%s';

  Map<String, dynamic> get messages => _notInlinedMessages(_notInlinedMessages);
}

Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
%s
};

final messageLookup = MessageLookup();
""" % (locale, '\n'.join(rows))

for locale in ('ko', 'ja'):
    catalog = json.loads((ROOT / f'app_{locale}.arb').read_text())
    (ROOT / 'generated' / f'messages_{locale}.dart').write_text(make_lookup(locale, catalog))
    print(f'generated {locale}: {len([k for k in catalog if not k.startswith("@")] )} messages')
