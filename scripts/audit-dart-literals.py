#!/usr/bin/env python3
"""List likely user-facing string literals in Flutter Dart source."""
from __future__ import annotations
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1] / "app" / "lib"
STRING = re.compile(r"(?P<quote>['\"])(?P<value>(?:\\.|(?! (?P=quote)).)*) (?P=quote)", re.X)
SKIP_PARTS = ("/l10n/generated/",)
SKIP_VALUES = {
    "", "en", "es", "zh", "utf8", "UTF-8", "GET", "POST", "PUT", "PATCH", "DELETE",
    "android", "ios", "web", "linux", "macos", "windows", "debug", "release",
}

def candidate(value: str) -> bool:
    raw = value.replace("\\n", " ").replace("\\'", "'").replace('\\"', '"').strip()
    if raw in SKIP_VALUES or len(raw) < 2:
        return False
    if raw.startswith(("http://", "https://", "package:", "dart:", "assets/", "lib/", "data:")):
        return False
    if any(ch in raw for ch in ("/", "\\", "=>", "::")):
        return False
    if not re.search(r"[A-Za-z]", raw):
        return False
    # Names, enum values, keys, and format strings are rarely UI copy.
    if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_.-]*", raw) and (" " not in raw):
        return False
    return True

for path in sorted(ROOT.rglob("*.dart")):
    if any(part in str(path) for part in SKIP_PARTS):
        continue
    for number, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        for match in STRING.finditer(line):
            value = match.group("value")
            if candidate(value):
                print(f"{path.relative_to(ROOT.parent.parent)}:{number}: {value}")
