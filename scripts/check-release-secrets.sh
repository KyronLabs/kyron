#!/usr/bin/env bash
# Check, before a version is cut, that the Release workflow will be able to
# sign the Android build and give it push notifications.
#
# Release reads these secrets only once the tag exists. Missing or mistyped,
# it fails there -- after "Create Versioned Release" has already bumped the
# version, committed it to main and pushed the tag -- and leaves a version
# with nothing built under it. Run first, the same mistake costs nothing.
#
# Reads the secrets from the environment, under their secret names:
#
#   GOOGLE_SERVICES_JSON        app/android/app/google-services.json
#   ANDROID_KEYSTORE_BASE64     the upload keystore, base64-encoded
#   ANDROID_KEYSTORE_PASSWORD   its store password
#   ANDROID_KEY_ALIAS           the key in it that signs
#   ANDROID_KEY_PASSWORD        that key's password
#
# Prints nothing secret. On success it prints the upload key's SHA-1 and
# SHA-256, which are public -- they are what Play Console shows under
# App integrity -> Upload key certificate, and what to compare with it.
set -euo pipefail

PACKAGE=so.kyron.app

missing=()
for name in GOOGLE_SERVICES_JSON ANDROID_KEYSTORE_BASE64 ANDROID_KEYSTORE_PASSWORD \
  ANDROID_KEY_ALIAS ANDROID_KEY_PASSWORD; do
  [ -n "${!name:-}" ] || missing+=("$name")
done
if [ ${#missing[@]} -gt 0 ]; then
  echo "Missing repository secrets: ${missing[*]}" >&2
  echo "Settings -> Secrets and variables -> Actions. README.md, Builds and releases." >&2
  exit 1
fi

# The right file, for the right app. Any valid JSON would get past Gradle's
# own check and then build an app that cannot register for push.
python3 - "$PACKAGE" <<'PY' || exit 1
import json, os, sys
package = sys.argv[1]
try:
    config = json.loads(os.environ["GOOGLE_SERVICES_JSON"])
    names = [c["client_info"]["android_client_info"]["package_name"] for c in config["client"]]
except (ValueError, KeyError, TypeError):
    sys.exit("GOOGLE_SERVICES_JSON is not a google-services.json.")
if package not in names:
    sys.exit(f"GOOGLE_SERVICES_JSON has no Android app for {package}; it has {names or 'none'}.")
PY

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
keystore=$work/upload.keystore
printf '%s' "$ANDROID_KEYSTORE_BASE64" | base64 --decode > "$keystore" 2>/dev/null || {
  echo "ANDROID_KEYSTORE_BASE64 is not base64. Encode the file with: base64 -w0 upload-keystore.jks" >&2
  exit 1
}

if ! keytool -list -keystore "$keystore" -storepass:env ANDROID_KEYSTORE_PASSWORD \
  -alias "$ANDROID_KEY_ALIAS" > /dev/null 2>&1; then
  echo "The keystore does not open with ANDROID_KEYSTORE_PASSWORD, or holds no key" >&2
  echo "called ANDROID_KEY_ALIAS. List what it holds with:" >&2
  echo "  keytool -list -keystore upload-keystore.jks" >&2
  exit 1
fi

# The key password, read the way the signer reads it. keytool cannot be asked:
# given a PKCS12 keystore -- the default for years -- it ignores a separate
# key password and uses the store's, so a wrong one passes here and fails in
# Gradle. KeyStore.getKey is what the Android signer calls.
cat > "$work/KeyCheck.java" <<'JAVA'
import java.io.File;
import java.security.KeyStore;

public class KeyCheck {
  public static void main(String[] args) throws Exception {
    KeyStore store = KeyStore.getInstance(
        new File(args[0]), System.getenv("ANDROID_KEYSTORE_PASSWORD").toCharArray());
    if (store.getKey(System.getenv("ANDROID_KEY_ALIAS"),
        System.getenv("ANDROID_KEY_PASSWORD").toCharArray()) == null) {
      System.exit(1);
    }
  }
}
JAVA
if ! java "$work/KeyCheck.java" "$keystore" > /dev/null 2>&1; then
  echo "ANDROID_KEY_PASSWORD does not unlock the key ANDROID_KEY_ALIAS." >&2
  echo "(In a PKCS12 keystore it is the same as the store password.)" >&2
  exit 1
fi

keytool -list -v -keystore "$keystore" -storepass:env ANDROID_KEYSTORE_PASSWORD \
  -alias "$ANDROID_KEY_ALIAS" 2> /dev/null |
  sed -nE 's/^[[:space:]]*(SHA1|SHA256):[[:space:]]*/\1 /p'
