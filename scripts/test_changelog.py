#!/usr/bin/env python3
"""Tests for scripts/changelog.py's store notes. Standard library only.

    python3 scripts/test_changelog.py
"""

import importlib.util
import unittest
from pathlib import Path

_spec = importlib.util.spec_from_file_location(
    "changelog", Path(__file__).with_name("changelog.py"))
changelog = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(changelog)

SECTION = """### Added

- **The welcome picture has company.** After the rooster, every rounded
  tile turns over like a card -- a wave out from the next one's eye.

### Fixed

- **A long link no longer fills the post.** It is shown without
  `https://`, and see [the docs](https://example.com) for more.
"""


class StoreNotes(unittest.TestCase):
    def test_no_markdown_reaches_the_store(self):
        notes = changelog.store_notes(SECTION)
        for mark in ("#", "**", "`", "](", "--"):
            self.assertNotIn(mark, notes)

    def test_headings_say_what_a_reader_gets(self):
        lines = changelog.store_notes(SECTION).splitlines()
        self.assertEqual(lines[0], "New")
        self.assertIn("Fixed", lines)

    def test_wrapped_entries_are_one_line_each(self):
        notes = changelog.store_notes(SECTION)
        self.assertIn(
            "• The welcome picture has company. After the rooster, every "
            "rounded tile turns over like a card — a wave out from the "
            "next one's eye.",
            notes.splitlines(),
        )
        self.assertIn("see the docs for more", notes)

    def test_fits_by_keeping_less_of_each_entry(self):
        long = "### Changed\n\n" + "".join(
            f"- **Thing {i} is better.** {'It is much better now. ' * 12}\n"
            for i in range(4)
        )
        notes = changelog.store_notes(long)
        self.assertLessEqual(len(notes), changelog.STORE_LIMIT)
        self.assertIn("• Thing 3 is better.", notes)

    def test_too_many_headlines_end_with_and_more(self):
        many = "### Fixed\n\n" + "".join(
            f"- **Fixed a thing in the corner of screen number {i}.** Yes.\n"
            for i in range(40)
        )
        notes = changelog.store_notes(many)
        self.assertLessEqual(len(notes), changelog.STORE_LIMIT)
        self.assertTrue(notes.endswith("And more."))
        self.assertIn("screen number 0.", notes)

    def test_a_written_note_is_used_as_written(self):
        body = SECTION + """
<!-- What's new
The rooster has company on the welcome screen,
and a long link now fits on one line.

Thanks for testing.
-->
"""
        self.assertEqual(
            changelog.store_notes(body),
            "The rooster has company on the welcome screen, and a long link "
            "now fits on one line.\n\nThanks for testing.",
        )

    def test_a_written_note_over_the_limit_is_refused_not_cut(self):
        body = "<!-- What's new\n" + "word " * 200 + "\n-->\n" + SECTION
        with self.assertRaises(ValueError):
            changelog.store_notes(body)

    def test_a_written_note_does_not_count_as_an_entry(self):
        body = "<!-- What's new\n- not an entry\n-->\n" + SECTION
        names = [name for name, _ in changelog.entries(body)]
        self.assertEqual(names, ["New", "Fixed"])

    def test_every_release_in_the_changelog_fits(self):
        content = changelog.CHANGELOG.read_text(encoding="utf-8")
        for name, start, end in changelog.sections(content):
            body = content[start:end]
            if changelog.is_empty(body):
                continue
            notes = changelog.store_notes(body)
            self.assertLessEqual(len(notes), changelog.STORE_LIMIT, name)
            self.assertNotIn("**", notes, name)


if __name__ == "__main__":
    unittest.main()
