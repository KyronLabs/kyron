#!/usr/bin/env python3
from __future__ import annotations
import hashlib, json, re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARB = ROOT / 'app/lib/l10n/app_en.arb'
CANDIDATES = Path('/tmp/kyron_candidates.txt')
# Values that are implementation details, examples, protocol strings, or code.
SKIP = ('AppLocalizations', 'describeApiError', 'formatCount', 'Theme.of', 'widget.', 'profile.', 'community.', 'story.', 'uri.', 'DateTime', 'PlatformSupport', 'ComposerState', 'PostDetailState', 'months[', 'stories.', 'text.split', 'at.day', 'index +', 'firstYear', 'minutes:', 'seconds', 'error', 'e', 'url', 'width', 'height')

def clean(raw: str) -> str:
    return raw.replace('\\n', ' ').replace('\\\'', "'").replace('\\"', '"').strip()

def useful(value: str) -> bool:
    if not value or value.startswith(('$', '@', '#', '[')):
        return False
    if '$' in value or value.startswith(('^', 'http', 'mailto:')):
        return False
    if any(token in value for token in SKIP):
        return False
    if re.fullmatch(r'[A-Za-z0-9_./:-]+', value):
        return False
    if not re.search(r'[A-Za-z]', value):
        return False
    return len(value) >= 3

def key_for(path: str, value: str) -> str:
    stem = re.sub(r'[^a-z0-9]+', '_', Path(path).stem.lower()).strip('_')
    slug = re.sub(r'[^a-z0-9]+', '_', value.lower()).strip('_')[:42].strip('_')
    digest = hashlib.sha1(f'{path}:{value}'.encode()).hexdigest()[:8]
    return f'audit_{stem}_{slug}_{digest}'

catalog = json.loads(ARB.read_text())
added = {}
for line in CANDIDATES.read_text().splitlines():
    if '/screens/' not in line and '/widgets/' not in line:
        continue
    match = re.match(r'(app/lib/(?:screens|widgets)/[^:]+):\d+: (.*)$', line)
    if not match:
        continue
    path, raw = match.groups()
    value = clean(raw)
    if not useful(value):
        continue
    key = key_for(path, value)
    added.setdefault(key, value)
for key, value in added.items():
    catalog.setdefault(key, value)
catalog['@@last_modified'] = '2026-09-17T23:15:00Z'
ARB.write_text(json.dumps(catalog, ensure_ascii=False, indent=2) + '\n')
print(f'Added {len(added)} audit catalog entries; total={sum(not k.startswith("@") for k in catalog)}')
