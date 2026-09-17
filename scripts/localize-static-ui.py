#!/usr/bin/env python3
from __future__ import annotations
import hashlib, json, re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LIB = ROOT / 'app' / 'lib'
ARB = LIB / 'l10n' / 'app_en.arb'
TARGETS = [LIB / 'screens', LIB / 'widgets']
# Deliberately conservative: only standalone Text(...) and common input copy.
TEXT = re.compile(r"(?<![A-Za-z0-9_])Text\(\s*(['\"])(?P<value>[A-Za-z][^'\"\\]{1,240})\1\s*\)", re.S)
INPUT = re.compile(r"(?P<name>labelText|hintText|helperText|tooltip)\s*:\s*(['\"])(?P<value>[A-Za-z][^'\"$\\\n]{1,160})\2")
EXCLUDE = {'Kyron', 'GIFs', 'Home', 'Explore', 'Communities', 'Messages', 'Settings'}

def key_for(path: Path, value: str) -> str:
    stem = re.sub(r'[^a-z0-9]+', '_', path.stem.lower()).strip('_')
    slug = re.sub(r'[^a-z0-9]+', '_', value.lower()).strip('_')[:48].strip('_')
    digest = hashlib.sha1(f'{path}:{value}'.encode()).hexdigest()[:6]
    return f'ui_{stem}_{slug}_{digest}'

catalog = json.loads(ARB.read_text())
added = {}
replacements = []
for base in TARGETS:
    for path in sorted(base.rglob('*.dart')):
        if 'generated' in path.parts:
            continue
        original = path.read_text()
        def replace_text(match: re.Match[str]) -> str:
            value = match.group('value').strip()
            before = original[max(0, match.start() - 10):match.start()]
            if 'const' in before or value in EXCLUDE or '$' in value:
                return match.group(0)
            key = key_for(path, value)
            added.setdefault(key, value)
            replacements.append((path, key, value))
            escaped = value.replace('\\', '\\\\').replace("'", "\\'")
            return f"Text(AppLocalizations.of(context).ui('{key}', '{escaped}'))"
        updated = TEXT.sub(replace_text, original)
        def replace_input(match: re.Match[str]) -> str:
            value = match.group('value').strip()
            if value in EXCLUDE or not re.search(r'\s', value):
                return match.group(0)
            key = key_for(path, value)
            added.setdefault(key, value)
            replacements.append((path, key, value))
            q = match.group(2)
            escaped = value.replace('\\', '\\\\').replace(q, '\\' + q)
            return f"{match.group('name')}: AppLocalizations.of(context).ui('{key}', '{escaped}')"
        updated = INPUT.sub(replace_input, updated)
        if updated != original:
            path.write_text(updated)

if not added:
    print('No static UI literals matched.')
    raise SystemExit(0)
# Preserve existing ordering and append a clearly marked generated-candidate block.
for key, value in added.items():
    catalog[key] = value
catalog['@@last_modified'] = '2026-09-17T23:10:00Z'
ARB.write_text(json.dumps(catalog, ensure_ascii=False, indent=2) + '\n')
print(f'Added {len(added)} catalog entries and replaced {len(replacements)} literals.')
for key, value in added.items():
    print(f'{key}\t{value}')
