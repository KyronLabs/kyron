#!/usr/bin/env python3
"""Read and stamp CHANGELOG.md.

The release workflow takes a GitHub release's notes from this file rather than
from GitHub's own generated notes. Generated notes are computed against the
previous tag, and the previous tag is almost always a `debug-*` build -- so the
notes for a versioned release would have covered whatever happened since the
last debug build, which is usually nothing.

    changelog.py show <version>   print one version's section, for release notes
    changelog.py unreleased       print the Unreleased section
    changelog.py release <version> stamp Unreleased as <version>, dated today
"""

from __future__ import annotations

import re
import sys
from datetime import date
from pathlib import Path

CHANGELOG = Path(__file__).resolve().parents[1] / "CHANGELOG.md"

# "## [1.2.3] - 2026-08-31" or "## [Unreleased]".
HEADING = re.compile(r"^## \[([^\]]+)\](?:\s*-\s*(\d{4}-\d{2}-\d{2}))?\s*$", re.MULTILINE)

REPO = "https://github.com/KyronLabs/kyron"


def sections(content: str) -> list[tuple[str, int, int]]:
    """Every section as (name, body start, body end)."""
    found = []
    matches = list(HEADING.finditer(content))
    for index, match in enumerate(matches):
        end = matches[index + 1].start() if index + 1 < len(matches) else len(content)
        found.append((match.group(1), match.end(), end))
    return found


def body_of(content: str, name: str) -> str | None:
    for section, start, end in sections(content):
        if section.lower() == name.lower():
            return content[start:end].strip()
    return None


def is_empty(body: str | None) -> bool:
    """True when a section holds only headings, with nothing listed under them."""
    if body is None:
        return True
    return not any(line.lstrip().startswith("-") for line in body.splitlines())


def show(version: str) -> int:
    content = CHANGELOG.read_text(encoding="utf-8")
    # Accept both "1.2.3" and "v1.2.3"; tags carry the v, headings do not.
    body = body_of(content, version.lstrip("v"))
    if body is None:
        print(f"CHANGELOG.md has no section for {version}", file=sys.stderr)
        return 1
    print(body)
    return 0


def unreleased() -> int:
    content = CHANGELOG.read_text(encoding="utf-8")
    body = body_of(content, "Unreleased")
    if is_empty(body):
        print("CHANGELOG.md has nothing under Unreleased.", file=sys.stderr)
        return 1
    print(body)
    return 0


def release(version: str) -> int:
    version = version.lstrip("v")
    content = CHANGELOG.read_text(encoding="utf-8")

    match = next(
        (m for m in HEADING.finditer(content) if m.group(1).lower() == "unreleased"),
        None,
    )
    if match is None:
        print("CHANGELOG.md has no Unreleased section to stamp.", file=sys.stderr)
        return 1

    end = len(content)
    for other in HEADING.finditer(content):
        if other.start() > match.start():
            end = other.start()
            break

    if is_empty(content[match.end() : end]):
        # Cutting a release with no notes is how a changelog stops being read.
        print("CHANGELOG.md has nothing under Unreleased.", file=sys.stderr)
        return 1

    previous = next(
        (name for name, _, _ in sections(content) if name.lower() != "unreleased"),
        None,
    )

    stamped = (
        f"## [Unreleased]\n\n"
        f"## [{version}] - {date.today().isoformat()}"
    )
    content = content[: match.start()] + stamped + content[match.end() :]

    # Keep the compare links at the foot pointing somewhere real.
    content = re.sub(
        r"^\[Unreleased\]: .*$",
        f"[Unreleased]: {REPO}/compare/v{version}...HEAD\n"
        + (
            f"[{version}]: {REPO}/compare/v{previous}...v{version}"
            if previous
            else f"[{version}]: {REPO}/releases/tag/v{version}"
        ),
        content,
        count=1,
        flags=re.MULTILINE,
    )

    CHANGELOG.write_text(content, encoding="utf-8")
    print(version)
    return 0


def main() -> int:
    args = sys.argv[1:]
    if len(args) == 1 and args[0] == "unreleased":
        return unreleased()
    if len(args) == 2 and args[0] == "show":
        return show(args[1])
    if len(args) == 2 and args[0] == "release":
        return release(args[1])

    print(__doc__, file=sys.stderr)
    return 2


if __name__ == "__main__":
    raise SystemExit(main())
