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

    said += check_build_number(name, workflow, [*PLATFORMS, publish_job])

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


# Where the build number comes from, in every workflow that publishes.
COUNTER = "scripts/build-number.sh"


def check_build_number(name: str, workflow: dict, readers: list[str]) -> list[str]:
    """One build number for the whole run, and the same kind in both workflows.

    Per-job, the two platforms out of one tag would carry different ones. And
    it is the commit count, worked out once by scripts/build-number.sh, not
    the run number: each workflow has its own run number, so the development
    builds were at 119 when Release ran for the first time as 1, and one
    development bundle uploaded to Play would have put every release after it
    below the number Play requires. A workflow-level `github.run_number` is
    exactly what this file used to require; it is now what it refuses.
    """
    jobs = workflow["jobs"]
    said: list[str] = []

    if "KYRON_BUILD_NUMBER" in (workflow.get("env") or {}):
        said.append(
            f"{name}: KYRON_BUILD_NUMBER is set at workflow level, where nothing "
            f"but the run number is available -- a counter of its own, which "
            f"the other workflow's builds overtake. Count it with {COUNTER} "
            f"in the first job and pass it on"
        )

    counters = [
        job
        for job, spec in jobs.items()
        if any(COUNTER in str(step.get("run", "")) for step in spec.get("steps", []))
    ]
    if len(counters) != 1:
        return said + [
            f"{name}: {len(counters)} jobs run {COUNTER}; the build number is "
            f"worked out once, by one job, so every job reads the same answer"
        ]
    counter = counters[0]
    spec = jobs[counter]

    # A shallow checkout has one commit, and the script refuses it -- but on
    # the pull request rather than the release, please.
    checkouts = [
        step
        for step in spec.get("steps", [])
        if str(step.get("uses", "")).startswith("actions/checkout")
    ]
    if not checkouts or (checkouts[0].get("with") or {}).get("fetch-depth") != 0:
        said.append(
            f"{name}: {counter!r} counts commits without checking out with "
            f"fetch-depth: 0, so it has one commit to count"
        )

    step_ids = [
        step.get("id")
        for step in spec.get("steps", [])
        if COUNTER in str(step.get("run", ""))
    ]
    outputs = [
        output
        for output, expression in (spec.get("outputs") or {}).items()
        if any(f"steps.{step}.outputs" in str(expression) for step in step_ids if step)
    ]
    if not outputs:
        return said + [
            f"{name}: {counter!r} runs {COUNTER} but has no output carrying "
            f"its answer to the jobs that build"
        ]
    expected = "${{ needs.%s.outputs.%s }}" % (counter, outputs[0])

    for reader in readers:
        job = jobs.get(reader)
        if job is None:
            continue
        value = (job.get("env") or {}).get("KYRON_BUILD_NUMBER")
        if value != expected:
            said.append(
                f"{name}: {reader!r} sets KYRON_BUILD_NUMBER to {value!r} rather "
                f"than {expected}, so it can disagree about which build this is"
            )
        needs = job.get("needs") or []
        if isinstance(needs, str):
            needs = [needs]
        if counter not in needs:
            said.append(
                f"{name}: {reader!r} reads {counter!r}'s build number without "
                f"needing {counter!r}, so it reads as empty"
            )

    return said


# What stands between a build and an APK nobody can install.
INSTALL_CHECK = "scripts/check-apks.sh"


def check_install_guard(name: str) -> list[str]:
    """That the Android job checks its APKs, before it uploads them.

    Every part of this has already failed once. The check was missing while
    four development builds shipped signed with a key minted during their own
    build. The first version of it took the certificate out of
    `apksigner verify --print-certs` with a sed pattern, which build-tools
    37.0.0 renamed out from under it -- the digest came out empty and a
    correctly signed APK failed with "got" followed by nothing. And it
    guarded the development builds while the release workflow, which ships
    the APK people actually keep, had no such check at all.
    """
    jobs = yaml.safe_load((WORKFLOWS / name).read_text(encoding="utf-8"))["jobs"]
    steps = (jobs.get("android") or {}).get("steps") or []
    said: list[str] = []

    checks = [i for i, step in enumerate(steps) if INSTALL_CHECK in str(step.get("run", ""))]
    if not checks:
        return [
            f"{name}: the 'android' job never runs {INSTALL_CHECK}, so an APK "
            f"nobody can install would be published without anything looking"
        ]

    uploads = [
        i
        for i, step in enumerate(steps)
        if str(step.get("uses", "")).startswith("actions/upload-artifact")
    ]
    if uploads and min(checks) > min(uploads):
        said.append(
            f"{name}: {INSTALL_CHECK} runs after the upload, which is after "
            f"the point where it could stop anything"
        )

    for step in steps:
        # Each split gets versionCode `abi * 1000 + build` and the universal
        # APK the plain build number, so one build ships four files the phone
        # will not install over each other. The Gradle build refuses the flag
        # too; this catches it on the pull request instead of eight minutes
        # into a build.
        if "--split-per-abi" in str(step.get("run", "")):
            said.append(
                f"{name}: {step.get('name')!r} builds with --split-per-abi, "
                f"which gives every APK in the build a different versionCode "
                f"-- the second file a reader tries is then refused as a "
                f"downgrade. Build one --target-platform at a time"
            )

        if "--print-certs" in str(step.get("run", "")):
            said.append(
                f"{name}: {step.get('name')!r} reads apksigner's printed "
                f"certificates, whose wording changes between build-tools "
                f"versions -- that is the bug scripts/apk-certificate.py "
                f"exists to have fixed"
            )

    return said


# What installs the NDK, so the build does not have to.
NDK_INSTALL = "scripts/install-ndk.sh"


def check_ndk(name: str) -> list[str]:
    """That the Android job installs the NDK before anything builds.

    Left to Gradle, the NDK is downloaded inside `flutter build`, one per
    version any module names, and a corrupt download fails the build with no
    second try. Release 19 failed exactly so, twelve minutes in. The install
    has to come first to be any use: after the first build, Gradle has already
    fetched it the fragile way.
    """
    jobs = yaml.safe_load((WORKFLOWS / name).read_text(encoding="utf-8"))["jobs"]
    steps = (jobs.get("android") or {}).get("steps") or []

    installs = [i for i, step in enumerate(steps) if NDK_INSTALL in str(step.get("run", ""))]
    builds = [i for i, step in enumerate(steps) if "flutter build" in str(step.get("run", ""))]
    if not installs:
        return [
            f"{name}: the 'android' job never runs {NDK_INSTALL}, so Gradle "
            f"downloads the NDK in the middle of the build and a corrupt "
            f"download fails the release"
        ]
    if builds and min(installs) > min(builds):
        return [
            f"{name}: {NDK_INSTALL} runs after the first `flutter build`, by "
            f"which point Gradle has already downloaded the NDK itself"
        ]
    return []


# What stands between a bundle and Play refusing it.
BUNDLE_CHECK = "scripts/check-aab.sh"


def check_bundle(name: str) -> list[str]:
    """That the Android job builds a bundle for Play, and checks it first.

    Only releases used to build one, so the newest code could not go to
    Play's testers without cutting a version. And nothing read back the one
    a release built: a bundle signed with the development key, or carrying a
    version code Play had already seen, uploads and is then refused.
    """
    jobs = yaml.safe_load((WORKFLOWS / name).read_text(encoding="utf-8"))["jobs"]
    steps = (jobs.get("android") or {}).get("steps") or []
    runs = [str(step.get("run", "")) for step in steps]

    builds = [i for i, run in enumerate(runs) if "flutter build appbundle" in run]
    if not builds:
        return [f"{name}: the 'android' job builds no app bundle, so it has nothing for Play"]

    checks = [i for i, run in enumerate(runs) if BUNDLE_CHECK in run and "--build" in run]
    if not checks or max(checks) < min(builds):
        return [
            f"{name}: the 'android' job never runs {BUNDLE_CHECK} --build on its "
            f"bundle, so a wrong key or a used version code is found by Play"
        ]

    uploads = [
        i
        for i, step in enumerate(steps)
        if str(step.get("uses", "")).startswith("actions/upload-artifact")
    ]
    if uploads and max(checks) > min(uploads):
        return [f"{name}: {BUNDLE_CHECK} runs after the upload, when it can stop nothing"]
    return []


# What sends a bundle to Play, and the one workflow allowed to.
PLAY_UPLOAD = "scripts/play-upload.py"
PLAY_SENDER = "flutter-release.yml"


def check_play_upload(name: str) -> list[str]:
    """That only releases go to Play, as the bundle the android job checked.

    Play keeps every version code it is sent, and a bad bundle on a testing
    track is in front of testers within minutes. So the job that sends one
    waits for the android job -- whose bundle has been through
    scripts/check-aab.sh by then -- and takes its artifact rather than
    building the commit a second time.
    """
    jobs = yaml.safe_load((WORKFLOWS / name).read_text(encoding="utf-8"))["jobs"]
    said: list[str] = []
    for job, spec in jobs.items():
        runs = "\n".join(str(step.get("run", "")) for step in spec.get("steps", []))
        if PLAY_UPLOAD not in runs:
            continue
        # Versioned releases only. A development bundle carries the last
        # release's version name, and sending each one would put every merge
        # to main in front of testers. They can be uploaded by hand.
        if name != PLAY_SENDER:
            said.append(
                f"{name}: {job!r} sends a bundle to Play. Only {PLAY_SENDER} "
                f"does -- testers get what was cut as a version, not every build"
            )
        needs = spec.get("needs") or []
        if isinstance(needs, str):
            needs = [needs]
        if "android" not in needs:
            said.append(
                f"{name}: {job!r} sends a bundle to Play without waiting for the "
                f"'android' job, which is what checks it"
            )
        if "flutter build" in runs:
            said.append(
                f"{name}: {job!r} builds its own bundle for Play instead of "
                f"sending the one the 'android' job checked"
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


def check_release_trigger() -> list[str]:
    """That cutting a release starts the build of it.

    "Create Versioned Release" bumps the version, tags it and pushes the tag
    with the workflow's own GITHUB_TOKEN -- and GitHub starts no workflow for
    an event that token caused. So the Release workflow's `on: push: tags`
    never fires for a tag pushed there: the version is bumped, the tag is
    up, and nothing builds it. Dispatch is the documented exception, so the
    release has to be asked for by name.
    """
    said: list[str] = []
    cut = yaml.safe_load((WORKFLOWS / "create-release.yml").read_text(encoding="utf-8"))
    release = yaml.safe_load((WORKFLOWS / "flutter-release.yml").read_text(encoding="utf-8"))

    # PyYAML reads the key `on` as the boolean True.
    triggers = release.get("on", release.get(True)) or {}
    if "workflow_dispatch" not in triggers:
        said.append(
            "flutter-release.yml: no workflow_dispatch trigger, so "
            "create-release.yml has no way to start it -- a tag pushed with "
            "GITHUB_TOKEN does not"
        )

    runs = "\n".join(
        str(step.get("run", ""))
        for job in (cut.get("jobs") or {}).values()
        for step in job.get("steps", [])
    )
    if "git push" in runs and "gh workflow run flutter-release.yml" not in runs:
        said.append(
            "create-release.yml: pushes the tag and stops there. A push made "
            "with GITHUB_TOKEN starts no workflow, so the release is never "
            "built; dispatch flutter-release.yml on the tag"
        )
    elif (cut.get("permissions") or {}).get("actions") != "write":
        said.append(
            "create-release.yml: dispatching a workflow needs "
            "`permissions: actions: write`"
        )

    return said


def main() -> int:
    problems: list[str] = []
    for name, publish_job in PUBLISHING.items():
        problems += check(name, publish_job)

    for path in sorted(WORKFLOWS.glob("*.yml")):
        problems += check_wiring(path.name)

    for name in PUBLISHING:
        problems += check_install_guard(name)
        problems += check_ndk(name)
        problems += check_bundle(name)
        problems += check_play_upload(name)

    problems += check_release_trigger()

    if problems:
        for problem in problems:
            print(f"error: {problem}", file=sys.stderr)
        return 1

    names = ", ".join(sorted(PUBLISHING))
    print(f"{names}: both platforms, one counted build number, a checked bundle, one release.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
