#!/usr/bin/env python3
"""Read and stamp CHANGELOG.md.

The release workflow takes a GitHub release's notes from this file rather than
from GitHub's own generated notes. Generated notes are computed against the
previous tag, and the previous tag is almost always a `debug-*` build -- so the
notes for a versioned release would have covered whatever happened since the
last debug build, which is usually nothing.

    changelog.py show <version>   print one version's section, for release notes
    changelog.py show <version> --max <n>
                                  the same, cut to at most n characters
    changelog.py unreleased       print the Unreleased section
    changelog.py store <version>  the same section as plain text for an app
                                  store's "What's new", within 500 characters
    changelog.py release <version> stamp Unreleased as <version>, dated today

## What's new, in a store

A store shows its notes as they are written, so the Markdown that reads well
on GitHub -- `### Added`, `**bold**`, lines wrapped at 76 -- arrives in Google
Play as hashes, asterisks and broken lines. `store` writes the same notes as a
store wants them:

    New
    • The welcome picture has company.
    Fixed
    • A long link in a post no longer fills the post.

It keeps as much of each entry as fits in Play's 500 characters, trying in
turn: every entry whole; each entry's bold headline and the sentence after
it; the headlines alone; and as many headlines as fit, then "And more."

Or write the store's words yourself. Anywhere in a version's section:

    <!-- What's new
    The rooster has company on the welcome screen, and a long link in a
    post now fits on one line.
    -->

An HTML comment, so GitHub's release page does not show it. When a section
has one, `store` prints exactly that (lines rejoined into paragraphs), and
refuses one over the limit rather than cut a sentence somebody wrote.
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

# Google Play's limit for a release's notes, per language.
STORE_LIMIT = 500

# A hand-written store note: <!-- What's new ... -->.
STORE_NOTE = re.compile(r"<!--\s*What's new\s*\n(.*?)-->", re.DOTALL | re.IGNORECASE)

# What each Keep a Changelog heading is called in a store, where "Changed"
# reads as a warning rather than as something better.
STORE_HEADINGS = {
    "added": "New",
    "changed": "Improved",
    "fixed": "Fixed",
    "removed": "Removed",
    "security": "Security",
    "deprecated": "On the way out",
}


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


def fit(body: str, version: str, limit: int) -> str:
    """The section, cut between entries to fit in `limit` characters.

    GitHub refuses a release body over 125,000 characters, and refuses it at
    the very end -- after every platform has been built. The first versioned
    release carries everything since the project began, which is most of
    that already. So a long section is cut at the last whole entry that fits,
    and ends with where to read the rest.
    """
    if len(body) <= limit:
        return body
    version = version.lstrip("v")
    rest = (
        f"\n\n*Cut short to fit on this page. The full notes are in "
        f"[CHANGELOG.md]({REPO}/blob/v{version}/CHANGELOG.md).*"
    )
    room = max(0, limit - len(rest))
    # The start of the first entry that would not fit, so no entry is cut
    # through the middle.
    cut = body.rfind("\n- ", 0, room)
    kept = body[: cut if cut > 0 else room].rstrip().splitlines()
    # A heading left with nothing under it reads as an empty section.
    while kept and (not kept[-1].strip() or kept[-1].startswith("#")):
        kept.pop()
    return "\n".join(kept) + rest


def plain(markdown: str) -> str:
    """Markdown as the plain words it renders to."""
    text = re.sub(r"\[([^\]]+)\]\([^)]*\)", r"\1", markdown)  # [text](url)
    text = re.sub(r"\*\*(.+?)\*\*", r"\1", text)
    text = re.sub(r"(?<![\w*])\*(?!\s)(.+?)(?<!\s)\*(?![\w*])", r"\1", text)
    text = re.sub(r"`([^`]*)`", r"\1", text)
    text = text.replace(" -- ", " \u2014 ").replace("--", "\u2014")
    return re.sub(r"\s+", " ", text).strip()


def entries(body: str) -> list[tuple[str, list[str]]]:
    """The section's entries, under their headings: [(heading, [entry])].

    An entry is a "- " line and the lines indented under it, joined back
    into one: the file is wrapped for reading in an editor, not a store.
    """
    groups: list[tuple[str, list[str]]] = []
    open_entry = False
    for line in STORE_NOTE.sub("", body).splitlines():
        heading = re.match(r"^#{2,4}\s+(.+?)\s*$", line)
        if heading:
            name = heading.group(1).strip()
            groups.append((STORE_HEADINGS.get(name.lower(), name), []))
            open_entry = False
        elif line.startswith("- "):
            if not groups:
                groups.append(("", []))
            groups[-1][1].append(line[2:])
            open_entry = True
        elif open_entry and line.startswith(" ") and line.strip():
            groups[-1][1][-1] += " " + line.strip()
        elif not line.strip():
            open_entry = False
    return [(name, items) for name, items in groups if items]


def _headline(entry: str) -> tuple[str, str]:
    """An entry's bold headline and the rest, as plain text."""
    match = re.match(r"\*\*(.+?)\*\*\s*(.*)", entry)
    if match:
        head, rest = plain(match.group(1)), plain(match.group(2))
    else:
        # No headline: its first sentence stands in for one.
        words = plain(entry)
        cut = re.search(r"(?<=[.!?])\s", words)
        head, rest = (words[: cut.start()], words[cut.end():]) if cut else (words, "")
    # "Soft haptics where they mean something:" heads a list that follows.
    if head.endswith(":") and rest:
        return head[:-1] + ".", rest
    return head, rest


def _first_sentence(text: str) -> str:
    cut = re.search(r"(?<=[.!?])\s", text)
    return text[: cut.start()] if cut else text


def _render(groups: list[tuple[str, list[str]]]) -> str:
    out: list[str] = []
    for name, items in groups:
        if not items:
            continue
        if name:
            out.append(name)
        out.extend(f"\u2022 {item}" for item in items)
    return "\n".join(out)


def store_notes(body: str, limit: int = STORE_LIMIT) -> str:
    """A version's notes as plain text for a store, within [limit]."""
    written = STORE_NOTE.search(body)
    if written:
        paragraphs = [
            re.sub(r"\s+", " ", block).strip()
            for block in re.split(r"\n\s*\n", written.group(1))
        ]
        note = "\n\n".join(p for p in paragraphs if p)
        if len(note) > limit:
            raise ValueError(
                f"The What's new note is {len(note)} characters; the store "
                f"takes {limit}."
            )
        return note

    groups = entries(body)
    split = [(name, [_headline(e) for e in items]) for name, items in groups]

    def whole(head: str, rest: str) -> str:
        return f"{head} {rest}".strip()

    def short(head: str, rest: str) -> str:
        return whole(head, _first_sentence(rest))

    for shape in (whole, short, lambda head, rest: head):
        text = _render([(n, [shape(h, r) for h, r in items]) for n, items in split])
        if len(text) <= limit:
            return text

    # Not even every headline fits: as many as do, in order, then a word to
    # say there was more.
    more = "And more."
    kept: list[tuple[str, list[str]]] = []
    for name, items in split:
        kept.append((name, []))
        for head, _ in items:
            kept[-1][1].append(head)
            if len(_render(kept)) + 1 + len(more) > limit:
                kept[-1][1].pop()
                return (_render(kept) + "\n" + more).strip()
    return _render(kept)


def store(version: str) -> int:
    content = CHANGELOG.read_text(encoding="utf-8")
    body = body_of(content, version.lstrip("v"))
    if body is None:
        print(f"CHANGELOG.md has no section for {version}", file=sys.stderr)
        return 1
    try:
        print(store_notes(body))
    except ValueError as error:
        print(error, file=sys.stderr)
        return 1
    return 0


def show(version: str, limit: int | None = None) -> int:
    content = CHANGELOG.read_text(encoding="utf-8")
    # Accept both "1.2.3" and "v1.2.3"; tags carry the v, headings do not.
    body = body_of(content, version.lstrip("v"))
    if body is None:
        print(f"CHANGELOG.md has no section for {version}", file=sys.stderr)
        return 1
    print(body if limit is None else fit(body, version, limit))
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
    if len(args) == 2 and args[0] == "store":
        return store(args[1])
    if len(args) == 4 and args[0] == "show" and args[2] == "--max" and args[3].isdigit():
        return show(args[1], int(args[3]))
    if len(args) == 2 and args[0] == "release":
        return release(args[1])

    print(__doc__, file=sys.stderr)
    return 2


if __name__ == "__main__":
    raise SystemExit(main())
