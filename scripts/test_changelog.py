#!/usr/bin/env python3
"""Tests for scripts/changelog.py. Standard library only.

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


class NothingWritten(unittest.TestCase):
    """A release with nothing under Unreleased says the default, not fails."""

    EMPTY = (
        "# Changelog\n\n## [Unreleased]\n\n## [0.1.0] - 2026-01-01\n"
        "### Fixed\n\n- **A thing.** It works.\n\n"
        "[Unreleased]: https://example.com/compare/v0.1.0...HEAD\n"
    )

    def setUp(self):
        import tempfile
        self.dir = tempfile.TemporaryDirectory()
        self.path = Path(self.dir.name) / "CHANGELOG.md"
        self.real = changelog.CHANGELOG
        changelog.CHANGELOG = self.path

    def tearDown(self):
        changelog.CHANGELOG = self.real
        self.dir.cleanup()

    def run_quietly(self, fn, *args):
        import contextlib
        import io
        out = io.StringIO()
        with contextlib.redirect_stdout(out), contextlib.redirect_stderr(io.StringIO()):
            code = fn(*args)
        return code, out.getvalue()

    def test_unreleased_and_the_store_say_the_default(self):
        self.path.write_text(self.EMPTY, encoding="utf-8")
        code, out = self.run_quietly(changelog.unreleased)
        self.assertEqual(code, 0)
        self.assertIn("- Bug fixes and performance improvements.", out)
        code, out = self.run_quietly(changelog.store, "Unreleased")
        self.assertEqual(code, 0)
        self.assertEqual(out.strip(), "Bug fixes and performance improvements.")

    def test_release_stamps_the_default_into_the_file(self):
        self.path.write_text(self.EMPTY, encoding="utf-8")
        code, _ = self.run_quietly(changelog.release, "0.2.0")
        self.assertEqual(code, 0)
        content = self.path.read_text(encoding="utf-8")
        body = changelog.body_of(content, "0.2.0")
        self.assertIn("- Bug fixes and performance improvements.", body)
        # Unreleased is empty again, ready for the next release.
        self.assertTrue(changelog.is_empty(changelog.body_of(content, "Unreleased")))
        # And GitHub's release page shows it too.
        code, out = self.run_quietly(changelog.show, "0.2.0")
        self.assertIn("Bug fixes and performance improvements.", out)

    def test_written_notes_are_kept_as_written(self):
        self.path.write_text(
            self.EMPTY.replace(
                "## [Unreleased]\n",
                "## [Unreleased]\n### Added\n\n- **Gifts.** In analytics.\n",
            ),
            encoding="utf-8",
        )
        self.run_quietly(changelog.release, "0.2.0")
        body = changelog.body_of(self.path.read_text(encoding="utf-8"), "0.2.0")
        self.assertIn("**Gifts.**", body)
        self.assertNotIn("Bug fixes and performance", body)


if __name__ == "__main__":
    unittest.main()
