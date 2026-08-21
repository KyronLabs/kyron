#!/usr/bin/env python3
"""Update the Flutter pubspec version using semantic versioning."""

from __future__ import annotations

import re
import sys
from pathlib import Path

PUBSPEC = Path(__file__).resolve().parents[1] / "app" / "pubspec.yaml"
VERSION_RE = re.compile(r"^(version:\s*)(\d+)\.(\d+)\.(\d+)(?:\+\d+)?\s*$", re.MULTILINE)


def main() -> int:
    if len(sys.argv) != 2 or sys.argv[1] not in {"major", "minor", "patch"}:
        print("Usage: scripts/bump-version.py major|minor|patch", file=sys.stderr)
        return 2

    bump = sys.argv[1]
    content = PUBSPEC.read_text(encoding="utf-8")
    match = VERSION_RE.search(content)
    if not match:
        print(f"No semantic version found in {PUBSPEC}", file=sys.stderr)
        return 1

    major, minor, patch = map(int, match.group(2, 3, 4))
    if bump == "major":
        major, minor, patch = major + 1, 0, 0
    elif bump == "minor":
        minor, patch = minor + 1, 0
    else:
        patch += 1

    version = f"{major}.{minor}.{patch}"
    updated = VERSION_RE.sub(lambda m: f"{m.group(1)}{version}+1", content, count=1)
    PUBSPEC.write_text(updated, encoding="utf-8")
    print(version)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
