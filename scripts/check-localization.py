#!/usr/bin/env python3
"""Validate Flutter ARB catalogs against the English source catalog.

The checker deliberately fails on missing/extra keys and placeholder drift. It
also reports values that are still identical to English, while allowing the
English catalog itself and known literal/brand values to remain unchanged.
"""
from __future__ import annotations

import argparse
import json
import os
import re
import sys
from collections import Counter
from pathlib import Path

PLACEHOLDER = re.compile(
    r"\$\{[^}]+\}|(?<!\\)\$[A-Za-z_][A-Za-z0-9_]*|%[0-9$]*[sdif]|\\n|<[^>]+>|#[^\W_]\w*"
)


def placeholders(value: str) -> Counter[str]:
    normalized = []
    for token in PLACEHOLDER.findall(value):
        if token.startswith("#"):
            # Hashtag examples are user-facing copy; the label may be
            # localized while the hashtag marker must remain present.
            normalized.append("#tag")
        elif token.startswith("<"):
            # The catalogs use angle-bracket examples such as <name>, not
            # markup. Their descriptive word may be localized.
            normalized.append("<tag>")
        else:
            normalized.append(token)
    return Counter(normalized)


def load_catalog(path: Path) -> dict[str, str]:
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        raise ValueError(f"{path}: {exc}") from exc
    if not isinstance(data, dict):
        raise ValueError(f"{path}: catalog root must be a JSON object")
    return {key: value for key, value in data.items() if not key.startswith("@")}


def github_summary(lines: list[str]) -> None:
    summary = os.environ.get("GITHUB_STEP_SUMMARY")
    if summary:
        Path(summary).write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--l10n-dir", type=Path, default=Path("app/lib/l10n"))
    args = parser.parse_args()

    source_path = args.l10n_dir / "app_en.arb"
    try:
        source = load_catalog(source_path)
    except ValueError as exc:
        print(f"::error::{exc}")
        return 1

    catalogs = sorted(args.l10n_dir.glob("app_*.arb"))
    targets = [path for path in catalogs if path != source_path]
    if not targets:
        print("::error::No translated ARB catalogs found")
        return 1

    failures: list[str] = []
    report = ["## Localization check", "", f"English source strings: **{len(source)}**", ""]
    report.append("| Catalog | Missing | Extra | Placeholder errors | Same as English | Status |")
    report.append("| --- | ---: | ---: | ---: | ---: | --- |")

    for path in targets:
        try:
            catalog = load_catalog(path)
        except ValueError as exc:
            failures.append(str(exc))
            report.append(f"| `{path.name}` | — | — | — | — | **invalid** |")
            continue

        missing = sorted(set(source) - set(catalog))
        extra = sorted(set(catalog) - set(source))
        placeholder_errors = []
        same_as_english = []
        for key in sorted(set(source) & set(catalog)):
            if placeholders(source[key]) != placeholders(catalog[key]):
                placeholder_errors.append(key)
            if source[key] == catalog[key] and source[key].strip():
                same_as_english.append(key)

        if missing:
            failures.append(f"{path.name}: missing keys: {', '.join(missing)}")
        if extra:
            failures.append(f"{path.name}: unknown keys: {', '.join(extra)}")
        if placeholder_errors:
            failures.append(
                f"{path.name}: placeholder mismatch: {', '.join(placeholder_errors)}"
            )

        status = "**fail**" if missing or extra or placeholder_errors else "pass"
        report.append(
            f"| `{path.name}` | {len(missing)} | {len(extra)} | "
            f"{len(placeholder_errors)} | {len(same_as_english)} | {status} |"
        )
        if missing:
            report.extend(["", f"### Missing in `{path.name}`"])
            report.extend(f"- `{key}` — {source[key]}" for key in missing)
        if placeholder_errors:
            report.extend(["", f"### Placeholder mismatches in `{path.name}`"])
            report.extend(f"- `{key}`" for key in placeholder_errors)
        if same_as_english:
            report.extend(
                [
                    "",
                    f"<details><summary>Values identical to English in `{path.name}` ({len(same_as_english)})</summary>",
                    "",
                ]
            )
            report.extend(f"- `{key}` — {catalog[key]}" for key in same_as_english)
            report.extend(["", "</details>"])

    report.extend(
        [
            "",
            "**Policy:** missing/extra keys and placeholder changes fail this check. "
            "Values identical to English are reported for human review because brand names, "
            "technical labels, and short symbols may legitimately remain unchanged.",
        ]
    )
    github_summary(report)

    if failures:
        for failure in failures:
            print(f"::error::{failure}")
        print("Localization check failed. See the job summary for details.")
        return 1

    print(f"Localization check passed for {len(targets)} translated catalog(s).")
    print("See the job summary for identical-to-English values requiring review.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
