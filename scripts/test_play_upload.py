#!/usr/bin/env python3
"""Tests for scripts/play-upload.py.

The upload runs only where the Play service account's key is, so CI on a
pull request never exercises it for real. These drive it through a fake HTTP
session instead: the calls it makes, in order, what it sends, and what it
does when Play says no.

    python3 scripts/test_play_upload.py

Standard library only.
"""

from __future__ import annotations

import importlib.util
import json
import os
import tempfile
import unittest
from pathlib import Path

SCRIPT = Path(__file__).resolve().parent / "play-upload.py"
_spec = importlib.util.spec_from_file_location("play_upload", SCRIPT)
play_upload = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(play_upload)

PACKAGE = "so.kyron.app"


class _Response:
    def __init__(self, status: int, body: object = None) -> None:
        self.status_code = status
        self._body = body
        self.content = b"" if body is None else json.dumps(body).encode()
        self.text = self.content.decode()

    def json(self) -> object:
        if self._body is None:
            raise ValueError("no body")
        return self._body


class _Play:
    """Answers the calls the way Play does, and remembers them."""

    def __init__(
        self,
        fail_at: str | None = None,
        language: str = "en-GB",
        review_refused: bool = False,
    ) -> None:
        self.calls: list[tuple[str, str, dict]] = []
        self.fail_at = fail_at
        self.language = language
        # Play after a rejection: it will not send a change for review by
        # itself, and takes the commit only unsent.
        self.review_refused = review_refused

    def _call(self, method: str, url: str, kwargs: dict) -> _Response:
        if "data" in kwargs:
            kwargs = {**kwargs, "data": kwargs["data"].read()}
        self.calls.append((method, url, kwargs))
        step = (
            "commit" if url.endswith(":commit")
            else "upload" if "/upload/" in url
            else "track" if "/tracks/" in url
            else "details" if url.endswith("/details")
            else "edit"
        )
        if step == self.fail_at:
            return _Response(403, {"error": {"message": "The caller does not have permission"}})
        if (
            step == "commit"
            and self.review_refused
            and "changesNotSentForReview" not in (kwargs.get("params") or {})
        ):
            return _Response(400, {"error": {"message": (
                "Changes cannot be sent for review automatically. Please set "
                "the query parameter changesNotSentForReview to true."
            )}})
        return {
            "edit": _Response(200, {"id": "edit-1"}),
            "details": _Response(200, {"defaultLanguage": self.language}),
            "upload": _Response(200, {"versionCode": 100655, "sha256": "ab"}),
            "track": _Response(200, {"track": "alpha"}),
            "commit": _Response(200, {"id": "edit-1"}),
        }[step]

    def get(self, url: str, **kwargs: object) -> _Response:
        return self._call("GET", url, kwargs)

    def post(self, url: str, **kwargs: object) -> _Response:
        return self._call("POST", url, kwargs)

    def put(self, url: str, **kwargs: object) -> _Response:
        return self._call("PUT", url, kwargs)


def _bundle() -> Path:
    path = Path(tempfile.mkdtemp()) / "kyron-0.1.3+655.aab"
    path.write_bytes(b"PK bundle bytes")
    return path


class SendTest(unittest.TestCase):
    def test_opens_uploads_releases_and_commits_in_that_order(self) -> None:
        fake = _Play()
        play = play_upload.Play(fake, PACKAGE)
        code, sent = play_upload.send(
            play, _bundle(), "alpha", "0.1.3 (100655)", "Fixes.", "completed"
        )

        self.assertEqual(code, 100655)
        self.assertTrue(sent)
        base = f"{play_upload.API}/{PACKAGE}"
        self.assertEqual(
            [(m, u) for m, u, _ in fake.calls],
            [
                ("POST", f"{base}/edits"),
                ("GET", f"{base}/edits/edit-1/details"),
                ("POST", f"{play_upload.UPLOAD}/{PACKAGE}/edits/edit-1/bundles"),
                ("PUT", f"{base}/edits/edit-1/tracks/alpha"),
                ("POST", f"{base}/edits/edit-1:commit"),
            ],
        )

    def test_uploads_the_bundle_itself(self) -> None:
        fake = _Play()
        play_upload.send(
            play_upload.Play(fake, PACKAGE), _bundle(), "internal", "n", "", "completed"
        )
        _, _, upload = fake.calls[2]
        self.assertEqual(upload["data"], b"PK bundle bytes")
        self.assertEqual(upload["params"], {"uploadType": "media"})
        self.assertEqual(upload["headers"]["Content-Type"], "application/octet-stream")

    def test_releases_the_version_code_play_recorded(self) -> None:
        fake = _Play()
        play_upload.send(
            play_upload.Play(fake, PACKAGE),
            _bundle(),
            "alpha",
            "0.1.3 (100655)",
            "Google on the log-in screen.",
            "completed",
        )
        _, _, track = fake.calls[3]
        self.assertEqual(
            track["json"],
            {
                "track": "alpha",
                "releases": [
                    {
                        "name": "0.1.3 (100655)",
                        "versionCodes": ["100655"],
                        "status": "completed",
                        "releaseNotes": [
                            {"language": "en-GB", "text": "Google on the log-in screen."}
                        ],
                    }
                ],
            },
        )

    def test_notes_are_in_the_listings_own_language(self) -> None:
        # Hard-coded en-US notes on a listing whose default is another
        # language are notes most testers are never shown.
        for language in ("en-GB", "fr-FR", "en-US"):
            fake = _Play(language=language)
            play_upload.send(
                play_upload.Play(fake, PACKAGE), _bundle(), "alpha", "n", "Fixes.", "completed"
            )
            notes = fake.calls[3][2]["json"]["releases"][0]["releaseNotes"]
            self.assertEqual(notes, [{"language": language, "text": "Fixes."}])

    def test_a_listing_it_may_not_read_still_gets_its_release(self) -> None:
        # The service account may release to testing tracks; reading the
        # store listing is a different permission. Refused, the notes go out
        # in en-US rather than the release not going out at all.
        fake = _Play(fail_at="details")
        code, sent = play_upload.send(
            play_upload.Play(fake, PACKAGE), _bundle(), "alpha", "n", "Fixes.", "completed"
        )
        self.assertEqual((code, sent), (100655, True))
        notes = fake.calls[3][2]["json"]["releases"][0]["releaseNotes"]
        self.assertEqual(notes, [{"language": "en-US", "text": "Fixes."}])

    def test_a_change_play_will_not_send_for_review_is_committed_unsent(self) -> None:
        # After a rejection Play refuses to send a change for review by
        # itself. It is committed unsent, and the caller is told, so the run
        # can say "press Send for review" rather than pretend testers have it.
        fake = _Play(review_refused=True)
        code, sent = play_upload.send(
            play_upload.Play(fake, PACKAGE), _bundle(), "alpha", "n", "", "completed"
        )
        self.assertEqual(code, 100655)
        self.assertFalse(sent)
        commits = [kw for _, u, kw in fake.calls if u.endswith(":commit")]
        self.assertEqual(len(commits), 2)
        self.assertEqual(commits[1]["params"], {"changesNotSentForReview": "true"})

    def test_never_sends_to_production(self) -> None:
        fake = _Play()
        with self.assertRaisesRegex(play_upload.PlayError, "production"):
            play_upload.send(
                play_upload.Play(fake, PACKAGE), _bundle(), "production", "n", "", "completed"
            )
        self.assertEqual(fake.calls, [], "nothing opened, nothing uploaded")

    def test_no_notes_sends_no_notes(self) -> None:
        fake = _Play()
        play_upload.send(
            play_upload.Play(fake, PACKAGE), _bundle(), "alpha", "n", "  ", "draft"
        )
        release = fake.calls[3][2]["json"]["releases"][0]
        self.assertNotIn("releaseNotes", release)
        self.assertEqual(release["status"], "draft")

    def test_a_refusal_stops_before_anything_is_committed(self) -> None:
        # The service account without release permission: Play refuses the
        # track change, and the edit -- never committed -- expires on its own.
        fake = _Play(fail_at="track")
        with self.assertRaisesRegex(play_upload.PlayError, "does not have permission"):
            play_upload.send(
                play_upload.Play(fake, PACKAGE), _bundle(), "alpha", "n", "", "completed"
            )
        self.assertFalse(any(u.endswith(":commit") for _, u, _ in fake.calls))

    def test_says_which_step_failed(self) -> None:
        fake = _Play(fail_at="upload")
        with self.assertRaisesRegex(play_upload.PlayError, r"uploading kyron-0\.1\.3\+655\.aab: HTTP 403"):
            play_upload.send(
                play_upload.Play(fake, PACKAGE), _bundle(), "alpha", "n", "", "completed"
            )


class NotesTest(unittest.TestCase):
    def test_short_notes_are_untouched(self) -> None:
        self.assertEqual(play_upload.fit_notes("  One fix.\n"), "One fix.")

    def test_long_notes_fit_and_end_at_a_line(self) -> None:
        lines = [f"- change number {i} with a description" for i in range(40)]
        fitted = play_upload.fit_notes("\n".join(lines))
        self.assertLessEqual(len(fitted), play_upload.NOTES_LIMIT)
        self.assertTrue(fitted.endswith("…"))
        self.assertIn(fitted[:-1].rstrip().splitlines()[-1], lines)

    def test_one_long_line_is_cut_at_the_limit(self) -> None:
        fitted = play_upload.fit_notes("x" * 2000)
        self.assertEqual(len(fitted), play_upload.NOTES_LIMIT)


class MainTest(unittest.TestCase):
    def test_refuses_without_a_key_before_touching_anything(self) -> None:
        env = os.environ.pop("PLAY_SERVICE_ACCOUNT_JSON", None)
        try:
            self.assertEqual(
                play_upload.main([str(_bundle()), "--package", PACKAGE]), 1
            )
        finally:
            if env is not None:
                os.environ["PLAY_SERVICE_ACCOUNT_JSON"] = env


if __name__ == "__main__":
    unittest.main()
