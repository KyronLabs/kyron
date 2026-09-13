#!/usr/bin/env python3
"""Print the signing certificate of an APK, read out of the APK itself.

Android decides whether an update may install by comparing the signing
certificate of the new package with the one already on the device. A
different certificate is INSTALL_FAILED_UPDATE_INCOMPATIBLE, which OEM
package installers report as "App not installed as package appears to be
invalid" -- six words that point at the file and not at the cause. So CI
checks the certificate of every APK it is about to publish, and that check
needs an answer it can trust.

Asking `apksigner verify --print-certs` and reading its output is how this
was done first, and it broke. Build-tools 37.0.0 renamed the lines:

    build-tools 35.0.0   Signer #1 certificate SHA-256 digest: 1203...
    build-tools 37.0.0   V2 Signer: certificate SHA-256 digest: 1203...

`ls build-tools/*/apksigner | sort -V | tail -1` picks the newest the runner
image happens to ship, so the day that image gained 37.0.0 the pattern
stopped matching, the digest came out empty, and a correctly signed APK
failed the check with "got" followed by nothing. Human-readable output is
not an interface. The signing block is.

What this reads is the APK Signing Block, which sits between the last file
and the central directory and is specified by Android, not by a tool, and
the PKCS#7 block of a JAR signature where there is one:

    https://source.android.com/docs/security/features/apksigning/v2
    https://source.android.com/docs/security/features/apksigning/v3

Every scheme the APK carries is reported, newest first, one per line:

    v3 120352358ddc...0b34 CN=Kyron Development Build, OU=Development, ...
    v2 120352358ddc...0b34 CN=Kyron Development Build, OU=Development, ...

so a caller can require that all of them agree rather than trusting
whichever one a given reader happens to prefer. An APK with no certificate
at all exits non-zero with a reason: the one failure this must never have
is a quiet empty answer, because that is the failure it was written to
replace.
"""

from __future__ import annotations

import argparse
import hashlib
import sys
import zipfile
from pathlib import Path

# The 16 bytes that sit immediately before the central directory when an APK
# carries a signing block.
MAGIC = b"APK Sig Block 42"

# Block ids, from the Android source. v3.1 is v3 with a minimum SDK, used to
# rotate a key on newer releases only.
SCHEMES = [("v3.1", 0x1B93AD61), ("v3", 0xF05368C0), ("v2", 0x7109871A)]

# The attribute types worth naming. Anything else is printed as its OID,
# which is still a true description of the certificate.
OIDS = {
    "2.5.4.3": "CN",
    "2.5.4.4": "SN",
    "2.5.4.5": "SERIALNUMBER",
    "2.5.4.6": "C",
    "2.5.4.7": "L",
    "2.5.4.8": "ST",
    "2.5.4.9": "STREET",
    "2.5.4.10": "O",
    "2.5.4.11": "OU",
    "2.5.4.12": "T",
    "2.5.4.42": "GIVENNAME",
    "0.9.2342.19200300.100.1.1": "UID",
    "0.9.2342.19200300.100.1.25": "DC",
    "1.2.840.113549.1.9.1": "EMAILADDRESS",
}

# DER string types, and how to turn each into text.
TEXT_TAGS = {
    0x0C: "utf-8",  # UTF8String
    0x13: "ascii",  # PrintableString
    0x16: "ascii",  # IA5String
    0x14: "latin-1",  # TeletexString, close enough to read
    0x1A: "ascii",  # VisibleString
    0x1E: "utf-16-be",  # BMPString
}


class Unreadable(Exception):
    """The APK does not have a certificate that can be read out of it."""


# --- DER ---------------------------------------------------------------


def tlv(data: bytes, i: int) -> tuple[int, bytes, int]:
    """One tag-length-value at `i`. Returns the tag, the value, and where
    the next one starts."""
    if i + 2 > len(data):
        raise Unreadable("truncated certificate")
    tag = data[i]
    length = data[i + 1]
    i += 2
    if length & 0x80:
        count = length & 0x7F
        if count == 0 or i + count > len(data):
            raise Unreadable("certificate uses a length this cannot read")
        length = int.from_bytes(data[i : i + count], "big")
        i += count
    if i + length > len(data):
        raise Unreadable("truncated certificate")
    return tag, data[i : i + length], i + length


def oid(value: bytes) -> str:
    parts = [str(value[0] // 40), str(value[0] % 40)]
    accumulator = 0
    for byte in value[1:]:
        accumulator = (accumulator << 7) | (byte & 0x7F)
        if not byte & 0x80:
            parts.append(str(accumulator))
            accumulator = 0
    return ".".join(parts)


def text(tag: int, value: bytes) -> str:
    encoding = TEXT_TAGS.get(tag)
    if encoding is None:
        return "#" + value.hex()
    return value.decode(encoding, "replace")


def escape(value: str) -> str:
    """RFC 4514, so a comma inside a name cannot read as the separator
    between two of them."""
    out = "".join("\\" + c if c in ',+"\\<>;' else c for c in value)
    if out.startswith(("#", " ")):
        out = "\\" + out
    if out.endswith(" ") and not out.endswith("\\ "):
        out = out[:-1] + "\\ "
    return out


def name(rdns: bytes) -> str:
    """A Name, printed the way a reader expects it: most specific first."""
    out = []
    i = 0
    while i < len(rdns):
        _, rdn, i = tlv(rdns, i)  # SET OF AttributeTypeAndValue
        pairs = []
        j = 0
        while j < len(rdn):
            _, attribute, j = tlv(rdn, j)  # SEQUENCE { type, value }
            _, kind, k = tlv(attribute, 0)
            tag, value, _ = tlv(attribute, k)
            pairs.append(f"{OIDS.get(oid(kind), oid(kind))}={escape(text(tag, value))}")
        out.append("+".join(pairs))
    return ", ".join(reversed(out))


def subject_of(certificate: bytes) -> str:
    """The subject of an X.509 certificate. The fields before it are fixed
    in number, so this counts past them rather than guessing."""
    _, body, _ = tlv(certificate, 0)  # Certificate
    _, tbs, _ = tlv(body, 0)  # tbsCertificate
    i = 0
    tag, _, after = tlv(tbs, i)
    if tag == 0xA0:  # [0] version, absent in a v1 certificate
        i = after
    for _ in range(4):  # serialNumber, signature, issuer, validity
        _, _, i = tlv(tbs, i)
    _, subject, _ = tlv(tbs, i)
    return name(subject)


# --- the APK -----------------------------------------------------------


def central_directory(data: bytes) -> int:
    """Where the zip central directory starts. The signing block, if there
    is one, ends there."""
    # The end-of-central-directory record is last, after a comment of at
    # most 65535 bytes.
    at = data.rfind(b"PK\x05\x06", max(0, len(data) - 65557))
    if at < 0:
        raise Unreadable("not a zip file: no end-of-central-directory record")
    offset = int.from_bytes(data[at + 16 : at + 20], "little")
    if offset == 0xFFFFFFFF:
        raise Unreadable("zip64 APK, which this does not read")
    return offset


def length_prefixed(buffer: bytes, i: int) -> tuple[bytes, int]:
    """One uint32-length-prefixed field, the unit the signing block is
    built out of."""
    if i + 4 > len(buffer):
        raise Unreadable("truncated signing block")
    length = int.from_bytes(buffer[i : i + 4], "little")
    if i + 4 + length > len(buffer):
        raise Unreadable("truncated signing block")
    return buffer[i + 4 : i + 4 + length], i + 4 + length


def signing_block(data: bytes) -> dict[int, bytes]:
    """The id-to-value pairs of the APK Signing Block, or nothing if the
    APK carries no such block (a v1-only APK does not)."""
    end = central_directory(data)
    if end < 24 or data[end - 16 : end] != MAGIC:
        return {}
    size = int.from_bytes(data[end - 24 : end - 16], "little")
    start = end - size - 8
    if start < 0 or int.from_bytes(data[start : start + 8], "little") != size:
        raise Unreadable("signing block disagrees with itself about its size")
    body = data[start + 8 : end - 24]

    pairs: dict[int, bytes] = {}
    i = 0
    while i + 12 <= len(body):
        length = int.from_bytes(body[i : i + 8], "little")
        if length < 4 or i + 8 + length > len(body):
            raise Unreadable("signing block has a pair that runs off the end")
        identifier = int.from_bytes(body[i + 8 : i + 12], "little")
        pairs[identifier] = body[i + 12 : i + 8 + length]
        i += 8 + length
    return pairs


def certificates_in(value: bytes) -> list[bytes]:
    """The signers' certificates in a v2 or v3 block. Both start their
    signed data with the digests and then the certificates, and a signer's
    own certificate is the first of its chain."""
    signers, _ = length_prefixed(value, 0)
    out = []
    i = 0
    while i < len(signers):
        signer, i = length_prefixed(signers, i)
        signed_data, _ = length_prefixed(signer, 0)
        _, after_digests = length_prefixed(signed_data, 0)
        chain, _ = length_prefixed(signed_data, after_digests)
        if chain:
            certificate, _ = length_prefixed(chain, 0)
            out.append(certificate)
    return out


def v1_certificates(path: Path) -> list[bytes]:
    """The certificate in a JAR signature, which sits in the PKCS#7 block
    beside the manifest."""
    out = []
    with zipfile.ZipFile(path) as archive:
        blocks = sorted(
            entry
            for entry in archive.namelist()
            if entry.upper().startswith("META-INF/")
            and entry.upper().endswith((".RSA", ".DSA", ".EC"))
        )
        for block in blocks:
            _, content_info, _ = tlv(archive.read(block), 0)
            _, kind, i = tlv(content_info, 0)  # contentType
            tag, content, _ = tlv(content_info, i)  # [0] EXPLICIT
            if tag != 0xA0:
                continue
            _, signed_data, _ = tlv(content, 0)
            j = 0
            for _ in range(3):  # version, digestAlgorithms, contentInfo
                _, _, j = tlv(signed_data, j)
            tag, chain, _ = tlv(signed_data, j)
            if tag != 0xA0:  # certificates [0] IMPLICIT, optional
                continue
            k = 0
            while k < len(chain):
                start = k
                _, _, k = tlv(chain, k)
                out.append(chain[start:k])
                break  # the signer's own certificate is the first
    return out


def certificates(path: Path) -> list[tuple[str, bytes]]:
    """Every signing certificate in the APK, newest scheme first."""
    data = path.read_bytes()
    blocks = signing_block(data)
    out = []
    for label, identifier in SCHEMES:
        if identifier in blocks:
            for certificate in certificates_in(blocks[identifier]):
                out.append((label, certificate))
    # As well as, not instead of. An APK can carry a JAR signature and a
    # signing block at once, and a reader that stopped at the first scheme it
    # found could not tell whether the two agree.
    out += [("v1", certificate) for certificate in v1_certificates(path)]
    return out


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("apk", nargs="+", type=Path)
    arguments = parser.parse_args()

    status = 0
    for path in arguments.apk:
        try:
            found = certificates(path)
        except (Unreadable, OSError, zipfile.BadZipFile) as error:
            print(f"{path}: {error}", file=sys.stderr)
            status = 1
            continue
        if not found:
            print(f"{path}: is not signed", file=sys.stderr)
            status = 1
            continue
        for scheme, certificate in found:
            digest = hashlib.sha256(certificate).hexdigest()
            print(f"{scheme} {digest} {subject_of(certificate)}")
    return status


if __name__ == "__main__":
    sys.exit(main())
