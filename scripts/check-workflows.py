#!/usr/bin/env python3
"""Check that a release actually ships everything it promises.

Kyron is one app on several platforms, and every build of it -- a tag, or a
push to main -- is supposed to produce Windows and Android together. That is
not one setting: it is two build jobs on two operating systems, a build number
they have to agree on, and a publish job that waits for both. Nothing about
getting one of those wrong fails a build. It just publishes half a release.

So the shape is asserted here and checked in CI. This is not a YAML linter --
GitHub will tell you soon enough if the file will not parse. It checks the
things that parse perfectly and are still wrong.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

import yaml

WORKFLOWS = Path(__file__).resolve().parents[1] / ".github" / "workflows"

# The two workflows that publish something somebody installs, and the job in
# each that does the publishing.
PUBLISHING = {
    "flutter-release.yml": "publish",
    "flutter-debug.yml": "publish",
}

# What a published build has to carry. The key is the job name; the value is
# what its runner has to be, because an Android build on Windows and a Windows
# build on Ubuntu both fail in ways that look like something else.
PLATFORMS = {"android": "ubuntu-latest", "windows": "windows-latest"}


def check(name: str, publish_job: str) -> list[str]:
    text = (WORKFLOWS / name).read_text(encoding="utf-8")
    workflow = yaml.safe_load(text)
    jobs = workflow["jobs"]
    said: list[str] = []

    for platform, runner in PLATFORMS.items():
        job = jobs.get(platform)
        if job is None:
            said.append(f"{name}: no {platform!r} job, so that platform ships nothing")
            continue
        if job.get("runs-on") != runner:
            said.append(
                f"{name}: the {platform!r} job runs on {job.get('runs-on')!r}, "
                f"and needs {runner!r}"
            )

    publish = jobs.get(publish_job)
    if publish is None:
        said.append(f"{name}: no {publish_job!r} job")
        return said

    # The publish job waiting on both is what makes one release rather than a
    # race between two of them.
    needs = publish.get("needs") or []
    if isinstance(needs, str):
        needs = [needs]
    for platform in PLATFORMS:
        if platform in jobs and platform not in needs:
            said.append(
                f"{name}: {publish_job!r} does not wait for {platform!r}, so a "
                f"release can be published without it"
            )

    # One build number for the whole run. Per-job, the two platforms out of one
    # tag would carry different ones.
    if "KYRON_BUILD_NUMBER" not in (workflow.get("env") or {}):
        said.append(
            f"{name}: KYRON_BUILD_NUMBER is not set at workflow level, so the "
            f"platforms can disagree about which build this is"
        )

    # And the publish job checks the files are there. download-artifact
    # answering with nothing is not an error, so without this a Windows build
    # that failed to upload publishes an Android-only release.
    body = "\n".join(
        str(step.get("run", "")) for step in publish.get("steps", [])
    )
    for expected in ("windows-x64.zip", "arm64-v8a.apk"):
        if expected not in body:
            said.append(
                f"{name}: {publish_job!r} does not check for {expected} before "
                f"publishing"
            )

    return said


def check_wiring(name: str) -> list[str]:
    """Every needs., and every output read across jobs, points at something."""
    text = (WORKFLOWS / name).read_text(encoding="utf-8")
    jobs = yaml.safe_load(text)["jobs"]
    said: list[str] = []

    for job, spec in jobs.items():
        needs = spec.get("needs") or []
        if isinstance(needs, str):
            needs = [needs]
        for other in needs:
            if other not in jobs:
                said.append(f"{name}: {job} needs {other!r}, which does not exist")

    for job, output in set(re.findall(r"needs\.([\w-]+)\.outputs\.([\w-]+)", text)):
        declared = (jobs.get(job) or {}).get("outputs") or {}
        if output not in declared:
            said.append(
                f"{name}: something reads needs.{job}.outputs.{output}, which "
                f"{job} does not declare -- it would read as empty"
            )

    for job, spec in jobs.items():
        ids = {step.get("id") for step in spec.get("steps", []) if step.get("id")}
        for output, expression in (spec.get("outputs") or {}).items():
            for step in re.findall(r"steps\.([\w-]+)\.outputs", str(expression)):
                if step not in ids:
                    said.append(
                        f"{name}: {job}.outputs.{output} reads step {step!r}, "
                        f"which {job} has no step with"
                    )

    return said


def main() -> int:
    problems: list[str] = []
    for name, publish_job in PUBLISHING.items():
        problems += check(name, publish_job)

    for path in sorted(WORKFLOWS.glob("*.yml")):
        problems += check_wiring(path.name)

    if problems:
        for problem in problems:
            print(f"error: {problem}", file=sys.stderr)
        return 1

    names = ", ".join(sorted(PUBLISHING))
    print(f"{names}: both platforms, one build number, one release.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
