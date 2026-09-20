from __future__ import annotations
import json
import os
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

# Get all locales from the l10n directory
l10n_dir = ROOT
arb_files = [f for f in os.listdir(l10n_dir) if f.startswith('app_') and f.endswith('.arb')]
locales = []
for f in arb_files:
    # Extract locale from filename app_XX.arb
    locale = f[4:-4]  # Remove 'app_' and '.arb'
    locales.append(locale)

print(f"Found {len(locales)} ARB catalogs")

# Generate lookup files for all locales
for locale in sorted(locales):
    if locale == 'en':
        continue  # Skip English, it's handled separately
    
    catalog_path = ROOT / f'app_{locale}.arb'
    if not catalog_path.exists():
        print(f"  WARNING: {catalog_path} not found, skipping")
        continue
    
    catalog = json.loads(catalog_path.read_text(encoding='utf-8'))
    
    # Create generated directory if it doesn't exist
    gen_dir = ROOT / 'generated'
    if not gen_dir.exists():
        gen_dir.mkdir(parents=True, exist_ok=True)
    
    lookup_content = make_lookup(locale, catalog)
    output_path = gen_dir / f'messages_{locale}.dart'
    output_path.write_text(lookup_content, encoding='utf-8')
    
    num_messages = len([k for k in catalog if not k.startswith('@')])
    print(f'  Generated messages_{locale}.dart: {num_messages} messages')

print(f"\nDone! Generated lookup files for {len(locales) - 1} locales (excluding en)")
