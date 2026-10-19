#!/usr/bin/env python3
"""Send an app bundle to a Google Play testing track.

Only the first bundle of an app has to go through Play Console by hand.
After that, Play's Developer API takes them from anywhere with a service
account Play Console has given release permission -- which is what this
does, for every bundle CI has already checked (scripts/check-aab.sh).

    scripts/play-upload.py --package so.kyron.app --track alpha \\
        --notes-file notes.txt kyron-0.1.3+655.aab

The track is Play's name for it: `internal` for internal testing, `alpha`
for the closed testing track Play Console calls "Closed testing - Alpha",
`beta` for open testing. Never `production`: that is a decision for a
person in Play Console, and the service account is not allowed it anyway.

Reads the service account's JSON key from PLAY_SERVICE_ACCOUNT_JSON. It is a
repository secret; it is never printed, and nothing here writes it to disk.

What it does is one Play "edit", the API's unit of change:

  1. open an edit
  2. upload the bundle into it
  3. set the track's release to that bundle's version code, with notes
  4. commit the edit

Nothing is visible to anybody until step 4, and an edit that is never
committed simply expires -- so a run that fails or is cancelled part-way
changes nothing in Play.

Committing sends the change for review where the track needs one -- closed
and open testing do, internal testing does not -- and testers get it once
Google has passed it. When Play will not send it for review on its own
(after a rejection, say), it is committed unsent and somebody has to press
"Send for review" in Play Console; the run says so.

Release notes are written in the listing's default language, which is the
one Play shows to anybody whose own language has no notes, and cut to Play's
limit of 500 characters, at a line break where there is one, rather than
refused at the commit.

Needs `google-auth` and `requests` (pip install google-auth requests); the
tests in scripts/test_play_upload.py need neither.
"""

from __future__ import annotations

import argparse
import json
import os
import sys
from pathlib import Path
from typing import Any, Protocol

API = "https://androidpublisher.googleapis.com/androidpublisher/v3/applications"
UPLOAD = "https://androidpublisher.googleapis.com/upload/androidpublisher/v3/applications"
SCOPE = "https://www.googleapis.com/auth/androidpublisher"

# Play's own limit on a release note, per language.
NOTES_LIMIT = 500

# A 100 MB bundle over a runner's connection, with room to spare.
UPLOAD_TIMEOUT = 600


class PlayError(RuntimeError):
    """Play said no. The message is Play's, with what was being asked."""


# Tracks this will not send to. Production is somebody's decision in Play
# Console, with a rollout they can watch -- not a side effect of tagging.
REFUSED_TRACKS = frozenset({"production"})

# What Play says when a commit cannot be sent for review by the API, and has
# to be committed unsent for somebody to send from Play Console.
NOT_SENT_FOR_REVIEW = "changesNotSentForReview"


class Session(Protocol):
    def get(self, url: str, **kwargs: Any) -> Any: ...
    def post(self, url: str, **kwargs: Any) -> Any: ...
    def put(self, url: str, **kwargs: Any) -> Any: ...


def fit_notes(text: str, limit: int = NOTES_LIMIT) -> str:
    """The notes, cut to Play's limit at a line break where there is one."""
    text = text.strip()
    if len(text) <= limit:
        return text
    room = limit - 1  # for the ellipsis
    cut = text.rfind("\n", 0, room)
    if cut < room // 2:
        cut = room
    return text[:cut].rstrip() + "…"


def _message(response: Any) -> str:
    try:
        return str(response.json()["error"]["message"])
    except (ValueError, KeyError, TypeError):
        return response.text[:500]


def _answer(response: Any, doing: str) -> dict:
    if response.status_code >= 400:
        raise PlayError(f"{doing}: HTTP {response.status_code}: {_message(response)}")
    return response.json() if response.content else {}


class Play:
    """The four calls an upload takes, over an authorised HTTP session."""

    def __init__(self, session: Session, package: str) -> None:
        self.session = session
        self.package = package

    def open_edit(self) -> str:
        r = self.session.post(f"{API}/{self.package}/edits", json={}, timeout=60)
        return _answer(r, "opening an edit")["id"]

    def default_language(self, edit: str) -> str:
        """The store listing's default language, which release notes have to
        be in for everybody to see them."""
        r = self.session.get(f"{API}/{self.package}/edits/{edit}/details", timeout=60)
        return _answer(r, "reading the app's details").get("defaultLanguage") or "en-US"

    def upload_bundle(self, edit: str, bundle: Path) -> int:
        with bundle.open("rb") as body:
            r = self.session.post(
                f"{UPLOAD}/{self.package}/edits/{edit}/bundles",
                params={"uploadType": "media"},
                headers={"Content-Type": "application/octet-stream"},
                data=body,
                timeout=UPLOAD_TIMEOUT,
            )
        return int(_answer(r, f"uploading {bundle.name}")["versionCode"])

    def release(
        self,
        edit: str,
        track: str,
        code: int,
        name: str,
        notes: str,
        status: str,
        language: str = "en-US",
    ) -> None:
        release: dict[str, Any] = {
            "name": name,
            "versionCodes": [str(code)],
            "status": status,
        }
        # Fitted first: notes that are only whitespace are no notes, and an
        # empty one is something Play refuses.
        text = fit_notes(notes)
        if text:
            release["releaseNotes"] = [{"language": language, "text": text}]
        r = self.session.put(
            f"{API}/{self.package}/edits/{edit}/tracks/{track}",
            json={"track": track, "releases": [release]},
            timeout=60,
        )
        _answer(r, f"putting {code} on the {track} track")

    def commit(self, edit: str) -> bool:
        """Commits the edit. True when Play sent it for review (or it needed
        none), False when Play would only take it unsent and it waits in
        Play Console for somebody to send."""
        url = f"{API}/{self.package}/edits/{edit}:commit"
        r = self.session.post(url, timeout=120)
        if r.status_code == 400 and NOT_SENT_FOR_REVIEW in _message(r):
            r = self.session.post(
                url, params={NOT_SENT_FOR_REVIEW: "true"}, timeout=120
            )
            _answer(r, "committing the edit, unsent")
            return False
        _answer(r, "committing the edit")
        return True


def send(
    play: Play, bundle: Path, track: str, name: str, notes: str, status: str
) -> tuple[int, bool]:
    """Upload, release and commit. Returns the version code Play recorded,
    and whether the change went for review rather than waiting unsent."""
    if track in REFUSED_TRACKS:
        raise PlayError(f"Not sending to {track}: that is for Play Console.")
    edit = play.open_edit()
    try:
        language = play.default_language(edit)
    except PlayError as error:
        # Reading the listing is not what the service account was given
        # permission for, and Play may refuse it. Notes in US English beat
        # no release at all.
        print(f"Writing the notes in en-US: {error}", file=sys.stderr)
        language = "en-US"
    code = play.upload_bundle(edit, bundle)
    play.release(edit, track, code, name, notes, status, language)
    return code, play.commit(edit)


def authorised_session(key_json: str) -> Session:
    """A requests session carrying the service account's token."""
    # Imported here so the tests, which bring their own session, need neither.
    from google.auth.transport.requests import AuthorizedSession
    from google.oauth2 import service_account

    try:
        info = json.loads(key_json)
    except ValueError:
        raise PlayError("PLAY_SERVICE_ACCOUNT_JSON is not JSON.") from None
    if info.get("type") != "service_account":
        raise PlayError("PLAY_SERVICE_ACCOUNT_JSON is not a service account key.")
    creds = service_account.Credentials.from_service_account_info(info, scopes=[SCOPE])
    return AuthorizedSession(creds)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("bundle", type=Path)
    parser.add_argument("--package", required=True)
    parser.add_argument(
        "--track",
        default="alpha",
        help="Play's name for the track: internal, alpha (closed testing), beta",
    )
    parser.add_argument("--name", help="release name shown in Play Console")
    parser.add_argument("--notes-file", type=Path)
    parser.add_argument(
        "--status",
        default="completed",
        help="'completed' rolls it out to the track's testers; 'draft' leaves "
        "it for somebody to roll out in Play Console",
    )
    args = parser.parse_args(argv)

    key = os.environ.get("PLAY_SERVICE_ACCOUNT_JSON", "")
    if not key.strip():
        print("PLAY_SERVICE_ACCOUNT_JSON is not set.", file=sys.stderr)
        return 1
    if not args.bundle.is_file():
        print(f"No bundle at {args.bundle}.", file=sys.stderr)
        return 1

    notes = args.notes_file.read_text(encoding="utf-8") if args.notes_file else ""
    name = args.name or args.bundle.stem
    from google.auth.exceptions import GoogleAuthError

    try:
        play = Play(authorised_session(key), args.package)
        code, sent = send(play, args.bundle, args.track, name, notes, args.status)
    except PlayError as error:
        print(error, file=sys.stderr)
        return 1
    except GoogleAuthError as error:
        # A key Google no longer honours -- deleted, disabled, or from another
        # project. Said in one line rather than a traceback.
        print(f"Google would not authorise the service account: {error}", file=sys.stderr)
        return 1
    print(f"{args.bundle.name}: versionCode {code} committed to the {args.track} track ({args.status}).")
    if not sent:
        print(
            "Play would not send it for review by itself. Play Console -> "
            "Publishing overview -> Send for review, or testers never get it."
        )
    elif args.track != "internal":
        print(
            "Google reviews this track's releases before testers get them: "
            "Play Console -> Publishing overview shows where it is."
        )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
