#!/usr/bin/env python3
"""Tests for scripts/apk-certificate.py.

The check this feeds is the one standing between a development build and
"App not installed as package appears to be invalid", and it has already
failed once by reading an empty answer and believing it. So the parser is
tested against APKs built here, signed each of the three ways Android
defines, and against the certificate committed at app/android/dev-signing.

    python3 scripts/test_apk_certificate.py

Standard library only: this runs on a checkout with no Android SDK, no JDK
and nothing installed from pip.
"""

from __future__ import annotations

import base64
import hashlib
import importlib.util
import io
import shutil
import struct
import subprocess
import sys
import tempfile
import unittest
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "apk-certificate.py"
SIGNING = ROOT / "app" / "android" / "dev-signing"

MAGIC = b"APK Sig Block 42"
V2, V3 = 0x7109871A, 0xF05368C0

_spec = importlib.util.spec_from_file_location("apk_certificate", SCRIPT)
apk_certificate = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(apk_certificate)


def certificate() -> bytes:
    """The development certificate, in DER. Public by definition -- it is in
    every APK that key has ever signed."""
    pem = (SIGNING / "kyron-dev.crt").read_text()
    body = "".join(line for line in pem.splitlines() if "CERTIFICATE" not in line)
    return base64.b64decode(body)


def lp(value: bytes) -> bytes:
    """One uint32-length-prefixed field, the unit the signing block is built
    out of."""
    return struct.pack("<I", len(value)) + value


def signer_block(der: bytes) -> bytes:
    """A v2/v3 block for one signer. Only the digests and the certificates
    are read back, but the shape is the real one."""
    digests = lp(struct.pack("<I", 0x0103) + lp(b"\x00" * 32))
    signed_data = lp(digests) + lp(lp(der)) + lp(b"")
    signer = lp(signed_data) + lp(b"") + lp(b"")
    return lp(lp(signer))


def apk(der: bytes | None, *, schemes: tuple[int, ...] = (V2,), jar: bool = False) -> bytes:
    """A zip shaped like an APK, carrying whichever signatures were asked
    for. `der` of None means nothing signed it."""
    buffer = io.BytesIO()
    with zipfile.ZipFile(buffer, "w") as archive:
        archive.writestr("AndroidManifest.xml", b"\x03\x00\x08\x00")
        archive.writestr("classes.dex", b"dex\n035\x00")
        if jar and der is not None:
            archive.writestr("META-INF/MANIFEST.MF", "Manifest-Version: 1.0\n")
            archive.writestr("META-INF/KYRON.SF", "Signature-Version: 1.0\n")
            archive.writestr("META-INF/KYRON.RSA", pkcs7(der))
    data = bytearray(buffer.getvalue())

    if der is None or not schemes:
        return bytes(data)

    pairs = b"".join(
        struct.pack("<Q", 4 + len(signer_block(der))) + struct.pack("<I", scheme) + signer_block(der)
        for scheme in schemes
    )
    size = len(pairs) + 8 + len(MAGIC)
    block = struct.pack("<Q", size) + pairs + struct.pack("<Q", size) + MAGIC

    # Spliced in where Android puts it: after the last file, immediately
    # before the central directory, whose recorded offset then moves.
    at = data.rfind(b"PK\x05\x06")
    start = struct.unpack("<I", data[at + 16 : at + 20])[0]
    data[start:start] = block
    at = data.rfind(b"PK\x05\x06")
    data[at + 16 : at + 20] = struct.pack("<I", start + len(block))
    return bytes(data)


def pkcs7(der: bytes) -> bytes:
    """A PKCS#7 SignedData carrying one certificate, which is all a JAR
    signature block has to hold for the certificate to be readable."""

    def tlv(tag: int, value: bytes) -> bytes:
        if len(value) < 0x80:
            return bytes([tag, len(value)]) + value
        length = len(value).to_bytes((len(value).bit_length() + 7) // 8, "big")
        return bytes([tag, 0x80 | len(length)]) + length + value

    signed_data = tlv(
        0x30,
        tlv(0x02, b"\x01")  # version
        + tlv(0x31, b"")  # digestAlgorithms
        + tlv(0x30, b"")  # contentInfo
        + tlv(0xA0, der)  # certificates [0] IMPLICIT
        + tlv(0x31, b""),  # signerInfos
    )
    # 1.2.840.113549.1.7.2, signedData
    kind = tlv(0x06, bytes([0x2A, 0x86, 0x48, 0x86, 0xF7, 0x0D, 0x01, 0x07, 0x02]))
    return tlv(0x30, kind + tlv(0xA0, signed_data))


def read(path: Path) -> subprocess.CompletedProcess:
    return subprocess.run(
        [sys.executable, str(SCRIPT), str(path)],
        capture_output=True,
        text=True,
    )


class TheCommittedCertificate(unittest.TestCase):
    """What the check compares against has to be what the key in the
    repository actually is, or every build fails at the last step."""

    def test_the_fingerprint_is_the_certificates_own(self):
        expected = (SIGNING / "fingerprint.txt").read_text().strip()
        self.assertEqual(hashlib.sha256(certificate()).hexdigest(), expected)

    def test_the_subject_reads_most_specific_first(self):
        self.assertEqual(
            apk_certificate.subject_of(certificate()),
            "CN=Kyron Development Build, OU=Development, O=KyronLabs, C=GB",
        )


class Reading(unittest.TestCase):
    def setUp(self):
        self.directory = Path(tempfile.mkdtemp())
        self.addCleanup(shutil.rmtree, self.directory)
        self.digest = hashlib.sha256(certificate()).hexdigest()
        self.subject = "CN=Kyron Development Build, OU=Development, O=KyronLabs, C=GB"

    def write(self, name: str, content: bytes) -> Path:
        path = self.directory / name
        path.write_bytes(content)
        return path

    def test_reads_a_v2_signature(self):
        result = read(self.write("v2.apk", apk(certificate(), schemes=(V2,))))
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout, f"v2 {self.digest} {self.subject}\n")

    def test_reads_a_v3_signature(self):
        result = read(self.write("v3.apk", apk(certificate(), schemes=(V3,))))
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout, f"v3 {self.digest} {self.subject}\n")

    def test_reads_a_jar_signature(self):
        signed = apk(certificate(), schemes=(), jar=True)
        result = read(self.write("v1.apk", signed))
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout, f"v1 {self.digest} {self.subject}\n")

    def test_reports_every_scheme_newest_first(self):
        """So a caller can require that they agree. An APK whose v2 and v3
        certificates differ installs differently depending on the Android
        version, which is not a thing to find out later."""
        both = apk(certificate(), schemes=(V2, V3), jar=True)
        result = read(self.write("both.apk", both))
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(
            result.stdout.splitlines(),
            [
                f"v3 {self.digest} {self.subject}",
                f"v2 {self.digest} {self.subject}",
                f"v1 {self.digest} {self.subject}",
            ],
        )

    def test_an_unsigned_apk_is_a_failure_and_not_an_empty_answer(self):
        """The failure this exists to replace: a check that read nothing,
        printed nothing, and had nothing to say about why."""
        result = read(self.write("bare.apk", apk(None)))
        self.assertEqual(result.returncode, 1)
        self.assertEqual(result.stdout, "")
        self.assertIn("is not signed", result.stderr)

    def test_a_file_that_is_not_a_zip_says_so(self):
        result = read(self.write("junk.apk", b"not a zip, not even close"))
        self.assertEqual(result.returncode, 1)
        self.assertEqual(result.stdout, "")
        self.assertIn("not a zip", result.stderr)

    def test_a_signing_block_that_disagrees_about_its_size_is_a_failure(self):
        signed = bytearray(apk(certificate()))
        at = signed.find(MAGIC)
        signed[at - 8 : at] = struct.pack("<Q", 0xFFFF)
        result = read(self.write("torn.apk", bytes(signed)))
        self.assertEqual(result.returncode, 1)
        self.assertEqual(result.stdout, "")
        self.assertIn("disagrees with itself", result.stderr)

    def test_a_pair_that_runs_off_the_end_is_a_failure(self):
        signed = bytearray(apk(certificate()))
        at = signed.find(MAGIC)
        size = struct.unpack("<Q", signed[at - 8 : at])[0]
        # The block runs from its leading size field to the end of the magic,
        # so the first pair starts eight bytes into it.
        start = (at + len(MAGIC)) - size - 8 + 8
        signed[start : start + 8] = struct.pack("<Q", 0xFFFF)
        result = read(self.write("overrun.apk", bytes(signed)))
        self.assertEqual(result.returncode, 1)
        self.assertEqual(result.stdout, "")
        self.assertIn("runs off the end", result.stderr)


class Names(unittest.TestCase):
    """A distinguished name carries text somebody chose, and printing it
    has to survive what they chose."""

    def name(self, *attributes: tuple[str, str]) -> str:
        def tlv(tag: int, value: bytes) -> bytes:
            return bytes([tag, len(value)]) + value

        oids = {"CN": b"\x55\x04\x03", "O": b"\x55\x04\x0a", "C": b"\x55\x04\x06"}
        rdns = b"".join(
            tlv(0x31, tlv(0x30, tlv(0x06, oids[kind]) + tlv(0x0C, value.encode())))
            for kind, value in attributes
        )
        return apk_certificate.name(rdns)

    def test_prints_in_reverse_order(self):
        self.assertEqual(
            self.name(("C", "GB"), ("O", "KyronLabs"), ("CN", "Kyron")),
            "CN=Kyron, O=KyronLabs, C=GB",
        )

    def test_escapes_a_comma_so_it_cannot_read_as_a_separator(self):
        self.assertEqual(self.name(("CN", "Lastname, Firstname")), "CN=Lastname\\, Firstname")

    def test_an_unknown_attribute_is_printed_as_its_oid(self):
        rdns = bytes([0x31, 0x0A, 0x30, 0x08, 0x06, 0x03, 0x55, 0x04, 0x2D, 0x0C, 0x01, 0x78])
        self.assertEqual(apk_certificate.name(rdns), "2.5.4.45=x")


if __name__ == "__main__":
    unittest.main(verbosity=2)
