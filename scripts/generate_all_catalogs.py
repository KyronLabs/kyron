#!/usr/bin/env python3
"""Generate ARB catalogs for all missing locales.

This creates catalogs that copy English values initially, which will be
flagged by the checker for human translation. All placeholders are preserved.
"""
from __future__ import annotations

import json
import re
from pathlib import Path

# Root directory
ROOT = Path(__file__).resolve().parents[1]
L10N_DIR = ROOT / 'app' / 'lib' / 'l10n'

# Load English catalog
SOURCE_PATH = L10N_DIR / 'app_en.arb'
with open(SOURCE_PATH, 'r', encoding='utf-8') as f:
    SOURCE = json.load(f)

# Get all keys (excluding metadata)
KEYS = sorted([k for k in SOURCE.keys() if not k.startswith('@')])

# Placeholder pattern to preserve
PLACEHOLDER = re.compile(
    r'\$\{[^}]+\}|\${[^}]+\}|\$[A-Za-z_][A-Za-z0-9_]*|%[sdif]|\\n|<[^>]+>|#[A-Za-z_][A-Za-z0-9_]*'
)

def extract_placeholders(value: str) -> list[str]:
    """Extract all placeholders from a string value."""
    return PLACEHOLDER.findall(value)

def main():
    """Generate all missing catalogs."""
    # All locales from Languages.all
    all_locales = ['en', 'af', 'am', 'ar', 'hy', 'az', 'eu', 'bn', 'bg', 'my', 'ca', 'zh', 'hr', 'cs', 'da', 'nl', 'et', 'tl', 'fi', 'fr', 'gl', 'ka', 'de', 'el', 'gu', 'ha', 'he', 'hi', 'hu', 'ig', 'id', 'it', 'ja', 'kn', 'kk', 'km', 'ko', 'lv', 'lt', 'ms', 'ml', 'mr', 'ne', 'nb', 'fa', 'pl', 'pt', 'pa', 'ro', 'ru', 'sr', 'si', 'sk', 'sl', 'so', 'es', 'sw', 'sv', 'ta', 'te', 'th', 'tr', 'uk', 'ur', 'uz', 'vi', 'xh', 'yo', 'zu']
    
    # Existing locales (don't regenerate)
    existing = []
    for loc in all_locales:
        path = L10N_DIR / f'app_{loc}.arb'
        if path.exists():
            existing.append(loc)
    
    # Locales to generate
    to_generate = [loc for loc in all_locales if loc not in existing]
    
    print(f"Existing locales: {len(existing)}")
    print(f"Generating {len(to_generate)} new catalogs...")
    
    for locale in to_generate:
        try:
            # Create catalog by copying English values
            # This ensures all keys and placeholders match exactly
            catalog = {key: SOURCE[key] for key in KEYS}
            
            # Create output
            output = {
                '@@locale': locale,
                '@@last_modified': '2026-09-19T21:00:00Z',
            }
            output.update(catalog)
            
            # Write file
            path = L10N_DIR / f'app_{locale}.arb'
            with open(path, 'w', encoding='utf-8') as f:
                json.dump(output, f, ensure_ascii=False, indent=2)
                f.write('\n')
            
            print(f"  Created app_{locale}.arb with {len(catalog)} strings")
        except Exception as e:
            print(f"  ERROR creating app_{locale}.arb: {e}")
    
    print(f"\nDone! Generated {len(to_generate)} catalogs.")
    print(f"These catalogs copy English values and will need translation.")

if __name__ == '__main__':
    main()
