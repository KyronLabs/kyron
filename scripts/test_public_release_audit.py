#!/usr/bin/env python3
import base64
import importlib.util
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

SCRIPT = Path(__file__).with_name("audit-public-release.py")
spec = importlib.util.spec_from_file_location("publication_audit", SCRIPT)
audit = importlib.util.module_from_spec(spec)
spec.loader.exec_module(audit)


class AuditTests(unittest.TestCase):
    def test_classifies_anonymous_and_privileged_jwt(self):
        def token(role):
            enc = lambda value: base64.urlsafe_b64encode(
                json.dumps(value).encode()
            ).rstrip(b"=")
            return enc({"alg": "HS256"}) + b"." + enc({"role": role}) + b"." + b"f" * 32

        result = audit.scan_blob(token("anon") + b"\n" + token("service_role"))
        self.assertEqual(result["supabase-anon-jwt-review"], 1)
        self.assertEqual(result["supabase-service-role-jwt"], 1)

    def test_history_includes_deleted_blob_without_printing_secret(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            repo = root / "repo"
            repo.mkdir()

            def git(*args):
                subprocess.run(
                    ["git", "-C", str(repo), *args],
                    check=True,
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.DEVNULL,
                )

            git("init", "-q")
            git("config", "user.name", "Synthetic Test")
            git("config", "user.email", "synthetic@example.invalid")
            synthetic = "SG." + "A" * 22 + "." + "B" * 43
            (repo / ".env").write_text(synthetic)
            git("add", ".env")
            git("commit", "-qm", "fixture")
            git("rm", "-q", ".env")
            git("commit", "-qm", "remove fixture")
            report = root / "private.json"
            result = subprocess.run(
                [sys.executable, str(SCRIPT), str(repo), "--report", str(report)],
                capture_output=True,
                text=True,
                check=False,
            )
            self.assertEqual(result.returncode, 1, result.stderr)
            raw = report.read_text()
            self.assertNotIn(synthetic, raw + result.stdout + result.stderr)
            data = json.loads(raw)
            self.assertEqual(data["rule_counts"]["sendgrid-key"], 1)
            self.assertIn(".env", data["sensitive_paths_for_review"])

    def test_path_with_token_is_redacted(self):
        synthetic = "SG." + "A" * 22 + "." + "B" * 43
        self.assertEqual(
            audit.safe_path("archive/" + synthetic + ".env"),
            "[credential-shaped filename redacted]",
        )

    def test_java_keystore_is_flagged(self):
        self.assertEqual(audit.scan_blob(b"\xfe\xed\xfe\xed" + b"\x00" * 20),
                         {"java-keystore-binary": 1})


if __name__ == "__main__":
    unittest.main()
