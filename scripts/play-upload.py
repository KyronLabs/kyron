#!/usr/bin/env python3
"""Send an app bundle to a Google Play testing track.

Only the first bundle of an app has to go through Play Console by hand.
After that, Play's Developer API takes them from anywhere with a service
account Play Console has given release permission -- which is what this
does, for every bundle CI has already checked (scripts/check-aab.sh).

    scripts/play-upload.py --package so.kyron.app --track internal \\
        --notes-file notes.txt kyron-0.1.3+655.aab

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

Release notes are cut to Play's limit of 500 characters, at a line break
where there is one, rather than refused at the commit.

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


class Session(Protocol):
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


def _answer(response: Any, doing: str) -> dict:
    if response.status_code >= 400:
        try:
            message = response.json()["error"]["message"]
        except (ValueError, KeyError, TypeError):
            message = response.text[:500]
        raise PlayError(f"{doing}: HTTP {response.status_code}: {message}")
    return response.json() if response.content else {}


class Play:
    """The four calls an upload takes, over an authorised HTTP session."""

    def __init__(self, session: Session, package: str) -> None:
        self.session = session
        self.package = package

    def open_edit(self) -> str:
        r = self.session.post(f"{API}/{self.package}/edits", json={}, timeout=60)
        return _answer(r, "opening an edit")["id"]

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
        self, edit: str, track: str, code: int, name: str, notes: str, status: str
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
            release["releaseNotes"] = [{"language": "en-US", "text": text}]
        r = self.session.put(
            f"{API}/{self.package}/edits/{edit}/tracks/{track}",
            json={"track": track, "releases": [release]},
            timeout=60,
        )
        _answer(r, f"putting {code} on the {track} track")

    def commit(self, edit: str) -> None:
        r = self.session.post(f"{API}/{self.package}/edits/{edit}:commit", timeout=120)
        _answer(r, "committing the edit")


def send(
    play: Play, bundle: Path, track: str, name: str, notes: str, status: str
) -> int:
    """Upload, release and commit. Returns the version code Play recorded."""
    edit = play.open_edit()
    code = play.upload_bundle(edit, bundle)
    play.release(edit, track, code, name, notes, status)
    play.commit(edit)
    return code


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
    parser.add_argument("--track", default="internal")
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
        code = send(play, args.bundle, args.track, name, notes, args.status)
    except PlayError as error:
        print(error, file=sys.stderr)
        return 1
    except GoogleAuthError as error:
        # A key Google no longer honours -- deleted, disabled, or from another
        # project. Said in one line rather than a traceback.
        print(f"Google would not authorise the service account: {error}", file=sys.stderr)
        return 1
    print(f"{args.bundle.name}: versionCode {code} is on the {args.track} track ({args.status}).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
