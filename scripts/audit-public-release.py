#!/usr/bin/env python3
"""Read-only, redacted audit of every reachable Git blob.

Run in a trusted private environment against a full mirror/checkout, not in
public CI. Reports only rule names, object IDs, line counts/locations, and
selected file paths, never matching secret bytes. This is a heuristic audit,
not a replacement for Gitleaks or provider-side revocation evidence.
"""
from __future__ import annotations

import argparse
import base64
import collections
import json
import os
from pathlib import Path
import re
import subprocess
import sys
from urllib.parse import urlsplit

MAX_BLOB = 64 * 1024 * 1024
OID = re.compile(rb"^[a-f0-9]{40,64}$")
RULES = {
    "private-key-block": rb"-----BEGIN (?:RSA |EC |OPENSSH |ENCRYPTED |DSA )?PRIVATE KEY-----[\s\S]{32,32000}?-----END (?:RSA |EC |OPENSSH |ENCRYPTED |DSA )?PRIVATE KEY-----",
    "github-token": rb"(?:gh[pousr]_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{40,})",
    "sendgrid-key": rb"SG\.[A-Za-z0-9_-]{15,}\.[A-Za-z0-9_-]{20,}",
    "supabase-secret-key": rb"sb_secret_[A-Za-z0-9_-]{20,}",
    "google-api-key-review": rb"AIza[A-Za-z0-9_-]{35}",
    "aws-access-key-id-review": rb"(?:AKIA|ASIA)[A-Z0-9]{16}",
    "slack-token": rb"xox[baprs]-[A-Za-z0-9-]{15,}",
    "ai-session-reference": rb"https://claude\.ai/code/session_[A-Za-z0-9_-]+",
}
PATTERNS = {name: re.compile(pattern) for name, pattern in RULES.items()}
JWT = re.compile(rb"eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{15,}")
DATABASE = re.compile(rb"(?:postgres(?:ql)?|mysql|mongodb(?:\+srv)?|redis(?:s)?)://[^:\s\"'<>/]+:[^@\s\"'<>]+@[^/\s\"'<>]+")
LOCAL_HOSTS = {"localhost", "127.0.0.1", "::1", "host.docker.internal", "postgres", "db", "redis", "mysql", "mongo"}
SENSITIVE_PATH = re.compile(
    r"(?i)(?:^|/)(?:\.env(?:\.[^/]*)?|[^/]+\.env|key\.properties|google-services\.json|GoogleService-Info\.plist|[^/]*firebase-adminsdk[^/]*\.json|[^/]+\.(?:jks|keystore|p12|pfx|pem|key|tfstate|zip|apk|aab|tar|tgz|gz|7z|rar|bak|dump|log))$"
)


def git(repo: Path, *args: str) -> bytes:
    result = subprocess.run(
        ["git", "-C", str(repo), *args],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )
    if result.returncode:
        # Git's stderr can contain sensitive remote URLs or object paths.
        raise RuntimeError(f"git {args[0]} failed (exit {result.returncode})")
    return result.stdout


def scan_blob(data: bytes) -> dict[str, int]:
    counts = {
        name: sum(1 for _ in pattern.finditer(data))
        for name, pattern in PATTERNS.items()
    }
    for match in JWT.finditer(data):
        try:
            part = match.group().split(b".")[1]
            payload = json.loads(base64.urlsafe_b64decode(part + b"=" * (-len(part) % 4)))
        except (ValueError, UnicodeError):
            counts["jwt-shaped-review"] = counts.get("jwt-shaped-review", 0) + 1
            continue
        role = payload.get("role") if isinstance(payload, dict) else None
        rule = "supabase-service-role-jwt" if role == "service_role" else (
            "supabase-anon-jwt-review" if role == "anon" else "jwt-shaped-review"
        )
        counts[rule] = counts.get(rule, 0) + 1
    for match in DATABASE.finditer(data):
        try:
            host = urlsplit(match.group().decode("ascii")).hostname
        except (ValueError, UnicodeError):
            host = None
        rule = "local-database-uri-review" if host in LOCAL_HOSTS else "embedded-database-credentials-review"
        counts[rule] = counts.get(rule, 0) + 1
    if data.startswith((b"\xfe\xed\xfe\xed", b"\xce\xce\xce\xce")):
        counts["java-keystore-binary"] = 1
    return {name: count for name, count in counts.items() if count}


def read_exact(stream, size: int) -> bytes:
    chunks = bytearray()
    while len(chunks) < size:
        piece = stream.read(size - len(chunks))
        if not piece:
            raise RuntimeError("incomplete Git object stream")
        chunks.extend(piece)
    return bytes(chunks)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("repository", type=Path, help="full clone or mirror")
    parser.add_argument("--report", type=Path, required=True, help="new private JSON file outside the repository")
    args = parser.parse_args()
    repo = args.repository.resolve(strict=True)
    report = args.report.resolve()
    if report == repo or repo in report.parents:
        parser.error("report must be outside the checkout")
    os.umask(0o077)
    if git(repo, "rev-parse", "--is-shallow-repository").strip() != b"false":
        raise RuntimeError("shallow checkout: fetch complete history first")
    # Disable lazy promisor fetches; a partial clone cannot be a clean result.
    os.environ["GIT_NO_LAZY_FETCH"] = "1"
    # A mirror must include all branches/tags and any accessible pull refs.
    refs = git(repo, "for-each-ref", "--format=%(refname)").splitlines()
    objects = git(repo, "rev-list", "--objects", "--all", "--missing=print").splitlines()
    paths = {}
    for line in objects:
        oid, _, path = line.partition(b" ")
        if not OID.fullmatch(oid):
            raise RuntimeError("missing or malformed reachable Git object")
        paths.setdefault(oid, os.fsdecode(path))
    if not refs or not paths:
        raise RuntimeError("no reachable Git history")

    # Scan every reachable blob directly, not just added lines in patches.
    findings = []
    totals = collections.Counter()
    skipped = []
    path_reviews = set()
    metadata_findings = []
    inventory = collections.Counter()
    process = subprocess.Popen(
        ["git", "-C", str(repo), "cat-file", "--batch"],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
    )
    try:
        for oid, path in paths.items():
            process.stdin.write(oid + b"\n")
            process.stdin.flush()
            header = process.stdout.readline().split()
            if len(header) != 3 or header[0] != oid:
                raise RuntimeError("Git object unavailable")
            kind = header[1].decode("ascii")
            size = int(header[2])
            inventory[kind] += 1
            if size > MAX_BLOB:
                remaining = size
                while remaining:
                    amount = min(remaining, 1024 * 1024)
                    read_exact(process.stdout, amount)
                    remaining -= amount
                skipped.append({"oid": oid.decode(), "type": kind, "bytes": size})
            else:
                data = read_exact(process.stdout, size)
                if kind in ("blob", "commit", "tag"):
                    matches = scan_blob(data)
                    if matches:
                        totals.update(matches)
                        item = {"oid": oid.decode(), "rules": matches}
                        if kind == "blob":
                            # Git supplies one representative path per object.
                            item["path"] = path
                            findings.append(item)
                        else:
                            item["type"] = kind
                            metadata_findings.append(item)
            if read_exact(process.stdout, 1) != b"\n":
                raise RuntimeError("invalid Git object framing")
        process.stdin.close()
        if process.wait():
            raise RuntimeError("Git object scan failed")
    finally:
        if process.poll() is None:
            process.kill()
            process.wait()

    # Inspect historical filenames separately because one blob can appear
    # under multiple paths. Generated/test examples are not auto-exempted.
    names = git(repo, "log", "--all", "--full-history", "--format=", "--name-only", "-z")
    for value in names.split(b"\0"):
        path = os.fsdecode(value.strip(b"\n"))
        if path and SENSITIVE_PATH.search(path):
            path_reviews.add(path)
    result = {
        "scope": "all objects reachable from local refs; not remote-only or unreachable objects",
        "refs": len(refs),
        "inventory": dict(inventory),
        "rule_counts": dict(sorted(totals.items())),
        "blob_findings": findings,
        "metadata_findings": metadata_findings,
        "sensitive_paths_for_review": sorted(path_reviews),
        "skipped_objects": skipped,
        "limitations": [
            "Pattern matches are candidates, not verified live credentials.",
            "No binary/archive extraction, entropy analysis, LFS object scan, or external artifact/log inspection.",
            "Local refs must be fetched from every relevant remote branch, tag, and accessible PR ref.",
            "Use a current Gitleaks release for an independent scan; neither scanner proves absence of secrets.",
        ],
    }
    # Exclusive creation avoids replacing evidence or following an existing
    # symlink. No raw content, remote URL, or secret match is printed.
    fd = os.open(report, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
    with os.fdopen(fd, "w", encoding="utf-8") as out:
        json.dump(result, out, indent=2, ensure_ascii=True)
        out.write("\n")
    print(f"Audited {inventory['blob']} reachable blobs; {len(findings)} candidate blobs; "
          f"{len(metadata_findings)} metadata candidates; {len(path_reviews)} sensitive paths; "
          f"{len(skipped)} skipped objects. Review private report.")
    return 2 if skipped else (1 if findings or metadata_findings or path_reviews else 0)


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (OSError, RuntimeError, ValueError):
        # Exceptions may include untrusted file/remote names; no traceback.
        print("Audit failed; no clean result. Check checkout and report location.", file=sys.stderr)
        raise SystemExit(2)
