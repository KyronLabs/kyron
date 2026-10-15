#!/usr/bin/env python3
"""Tests for scripts/aab-manifest.py.

scripts/check-aab.sh compares the version code this reads with the build
number a bundle was meant to carry, before Play sees it. A reader that
answered with nothing, or with the wrong attribute, would pass a bundle Play
then refuses -- so it is tested against manifests encoded here the way aapt2
encodes them, including the parts it has to step over.

    python3 scripts/test_aab_manifest.py

Standard library only, like the reader.
"""

from __future__ import annotations

import importlib.util
import io
import tempfile
import unittest
import zipfile
from pathlib import Path

SCRIPT = Path(__file__).resolve().parent / "aab-manifest.py"
_spec = importlib.util.spec_from_file_location("aab_manifest", SCRIPT)
aab_manifest = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(aab_manifest)

ANDROID = "http://schemas.android.com/apk/res/android"


def varint(value: int) -> bytes:
    out = bytearray()
    while True:
        byte = value & 0x7F
        value >>= 7
        if value:
            out.append(byte | 0x80)
        else:
            out.append(byte)
            return bytes(out)


def number(field: int, value: int) -> bytes:
    return varint(field << 3) + varint(value)


def message(field: int, payload: bytes | str) -> bytes:
    if isinstance(payload, str):
        payload = payload.encode()
    return varint(field << 3 | 2) + varint(len(payload)) + payload


def attribute(name: str, value: str, android: bool = True, compiled: int | None = None) -> bytes:
    """An XmlAttribute as aapt2 writes one: source text, position, resource
    id and, for numbers, the compiled value too."""
    out = b""
    if android:
        out += message(1, ANDROID)
    out += message(2, name) + message(3, value)
    out += message(4, number(1, 2))  # SourcePosition { line_number }
    if android:
        out += number(5, 0x0101021B)
    if compiled is not None:
        # Item { prim = Primitive { int_decimal_value } }
        out += message(6, message(7, number(6, compiled)))
    return out


def manifest(attributes: list[bytes], root: str = "manifest") -> bytes:
    element = message(1, message(1, "android") + message(2, ANDROID))  # namespace
    element += message(3, root)
    for item in attributes:
        element += message(4, item)
    element += message(5, message(1, message(3, "application")))  # a child
    return message(1, element) + message(3, number(1, 1))


def bundle(node: bytes | None) -> Path:
    path = Path(tempfile.mkstemp(suffix=".aab")[1])
    with zipfile.ZipFile(path, "w") as out:
        out.writestr("BundleConfig.pb", b"")
        if node is not None:
            out.writestr(aab_manifest.MANIFEST, node)
    return path


KYRON = [
    attribute("versionCode", "100646", compiled=100646),
    attribute("versionName", "0.1.1"),
    attribute("compileSdkVersion", "36", compiled=36),
    attribute("package", "so.kyron.app", android=False),
]


class ManifestTest(unittest.TestCase):
    def test_reads_package_code_and_name(self) -> None:
        self.assertEqual(
            aab_manifest.read(bundle(manifest(KYRON))),
            ("so.kyron.app", 100646, "0.1.1"),
        )

    def test_takes_the_version_code_not_another_number(self) -> None:
        # compileSdkVersion comes after it here and is a number too.
        _, code, _ = aab_manifest.read(bundle(manifest(KYRON)))
        self.assertEqual(code, 100646)

    def test_no_version_code_is_an_error_not_an_empty_answer(self) -> None:
        with self.assertRaisesRegex(ValueError, "versionCode"):
            aab_manifest.read(bundle(manifest(KYRON[1:])))

    def test_no_package_is_an_error(self) -> None:
        with self.assertRaisesRegex(ValueError, "package"):
            aab_manifest.read(bundle(manifest(KYRON[:3])))

    def test_a_root_that_is_not_the_manifest(self) -> None:
        with self.assertRaisesRegex(ValueError, "<application>"):
            aab_manifest.read(bundle(manifest(KYRON, root="application")))

    def test_no_manifest_is_not_a_bundle(self) -> None:
        with self.assertRaisesRegex(ValueError, "not an app bundle"):
            aab_manifest.read(bundle(None))

    def test_a_truncated_manifest(self) -> None:
        node = manifest(KYRON)
        with self.assertRaises(ValueError):
            aab_manifest.read(bundle(node[: len(node) // 2]))

    def test_not_a_zip(self) -> None:
        path = Path(tempfile.mkstemp(suffix=".aab")[1])
        path.write_bytes(b"not a bundle")
        with self.assertRaises(zipfile.BadZipFile):
            aab_manifest.read(path)

    def test_command_line_prints_one_line_and_fails_on_a_bad_one(self) -> None:
        import contextlib
        import sys

        good, bad = bundle(manifest(KYRON)), bundle(None)
        out, err = io.StringIO(), io.StringIO()
        argv = sys.argv
        sys.argv = ["aab-manifest.py", str(good), str(bad)]
        try:
            with contextlib.redirect_stdout(out), contextlib.redirect_stderr(err):
                status = aab_manifest.main()
        finally:
            sys.argv = argv
        self.assertEqual(status, 1)
        self.assertEqual(out.getvalue(), "so.kyron.app 100646 0.1.1\n")
        self.assertIn("not an app bundle", err.getvalue())


if __name__ == "__main__":
    unittest.main()
