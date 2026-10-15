#!/usr/bin/env python3
"""Print the package, version code and version name an Android App Bundle carries.

Play refuses an upload whose version code is not above every one uploaded
before, and says so only after the upload. So the bundle is read back before
it is published, and its version code compared with the build number it was
built from (scripts/check-aab.sh).

`aapt2 dump badging`, which the APK check uses, does not read a bundle: the
manifest in one is aapt2's protobuf encoding, not Android's binary XML. The
tool that reads it is bundletool, which is not on the runners. The encoding
is short enough to read here instead -- three message types out of aapt2's
Resources.proto:

    https://android.googlesource.com/platform/frameworks/base/+/refs/heads/main/tools/aapt2/Resources.proto

    message XmlNode      { XmlElement element = 1; ... }
    message XmlElement   { string name = 3; repeated XmlAttribute attribute = 4; ... }
    message XmlAttribute { string name = 2; string value = 3; Item compiled_item = 6; ... }

aapt2 keeps an attribute's source text in `value` alongside its compiled
form, so that is what is printed. Output is one line per bundle:

    so.kyron.app 100646 0.1.1

A bundle with no manifest, or a manifest with no version code, exits
non-zero with a reason. An empty answer read as a good one is how the APK
certificate check failed the first time.

Standard library only.
"""

from __future__ import annotations

import argparse
import sys
import zipfile
from pathlib import Path

MANIFEST = "base/manifest/AndroidManifest.xml"


def varint(data: bytes, i: int) -> tuple[int, int]:
    result = shift = 0
    while True:
        if i >= len(data):
            raise ValueError("truncated varint")
        byte = data[i]
        i += 1
        result |= (byte & 0x7F) << shift
        if not byte & 0x80:
            return result, i
        shift += 7


def fields(data: bytes) -> list[tuple[int, int | bytes]]:
    """Every top-level field of one message, as (number, value)."""
    out: list[tuple[int, int | bytes]] = []
    i = 0
    while i < len(data):
        key, i = varint(data, i)
        number, wire = key >> 3, key & 7
        if wire == 0:
            value, i = varint(data, i)
        elif wire == 1:
            value, i = int.from_bytes(data[i : i + 8], "little"), i + 8
        elif wire == 2:
            length, i = varint(data, i)
            value, i = data[i : i + length], i + length
        elif wire == 5:
            value, i = int.from_bytes(data[i : i + 4], "little"), i + 4
        else:
            raise ValueError(f"wire type {wire} is not one aapt2 writes")
        if i > len(data):
            raise ValueError("truncated field")
        out.append((number, value))
    return out


def text(value: int | bytes) -> str:
    if not isinstance(value, bytes):
        raise ValueError("expected a string field")
    return value.decode("utf-8")


def manifest_attributes(node: bytes) -> dict[str, str]:
    """The attributes of the <manifest> element, by name, from an XmlNode."""
    elements = [v for n, v in fields(node) if n == 1]
    if not elements or not isinstance(elements[0], bytes):
        raise ValueError("the manifest has no root element")
    element = fields(elements[0])
    name = next((text(v) for n, v in element if n == 3), "")
    if name != "manifest":
        raise ValueError(f"the root element is <{name}>, not <manifest>")
    attributes: dict[str, str] = {}
    for number, value in element:
        if number != 4 or not isinstance(value, bytes):
            continue
        attribute = fields(value)
        key = next((text(v) for n, v in attribute if n == 2), "")
        attributes[key] = next((text(v) for n, v in attribute if n == 3), "")
    return attributes


def read(path: Path) -> tuple[str, int, str]:
    with zipfile.ZipFile(path) as bundle:
        try:
            node = bundle.read(MANIFEST)
        except KeyError:
            raise ValueError(f"no {MANIFEST}: not an app bundle") from None
    attributes = manifest_attributes(node)
    package = attributes.get("package", "")
    code = attributes.get("versionCode", "")
    if not package:
        raise ValueError("the manifest names no package")
    if not code.isdigit():
        raise ValueError(f"the manifest's versionCode is {code or 'missing'!r}")
    return package, int(code), attributes.get("versionName", "")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("aab", nargs="+", type=Path)
    failed = False
    for path in parser.parse_args().aab:
        try:
            package, code, name = read(path)
        except (OSError, ValueError, zipfile.BadZipFile) as error:
            print(f"{path}: {error}", file=sys.stderr)
            failed = True
            continue
        print(package, code, name)
    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
