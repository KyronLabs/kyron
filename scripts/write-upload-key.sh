#!/usr/bin/env bash
# Write the Play upload key where the Android build signs with it.
#
# Reads the repository secrets from the environment, under their own names:
#
#   ANDROID_KEYSTORE_BASE64     the upload keystore, base64-encoded
#   ANDROID_KEYSTORE_PASSWORD   its store password
#   ANDROID_KEY_ALIAS           the key in it that signs
#   ANDROID_KEY_PASSWORD        that key's password
#
# and writes app/android/upload-keystore.jks and app/android/key.properties,
# which app/android/app/build.gradle.kts reads for every release-mode build
# after it. Run from the repository root.
#
# Both workflows that build a bundle call this -- Release, and the
# development builds for their Play bundle -- so there is one way the key is
# written rather than two that can drift. scripts/check-release-secrets.sh
# opens the same secrets before a version is cut, to say which one is wrong.
set -euo pipefail

missing=()
for name in ANDROID_KEYSTORE_BASE64 ANDROID_KEYSTORE_PASSWORD ANDROID_KEY_ALIAS \
  ANDROID_KEY_PASSWORD; do
  [ -n "${!name:-}" ] || missing+=("$name")
done
if [ ${#missing[@]} -gt 0 ]; then
  echo "Missing repository secrets: ${missing[*]}" >&2
  echo "Settings -> Secrets and variables -> Actions. README.md, Builds and releases." >&2
  exit 1
fi

printf '%s' "$ANDROID_KEYSTORE_BASE64" | base64 --decode > app/android/upload-keystore.jks || {
  echo "ANDROID_KEYSTORE_BASE64 is not base64." >&2
  exit 1
}

# key.properties is read with java.util.Properties, which takes a backslash
# as the start of an escape. Doubled, a password with one in it reads back
# as itself. Written with printf rather than a heredoc, so nothing in a
# password is ever expanded by the shell.
escape() { printf '%s' "${1//\\/\\\\}"; }
{
  printf 'storePassword=%s\n' "$(escape "$ANDROID_KEYSTORE_PASSWORD")"
  printf 'keyPassword=%s\n' "$(escape "$ANDROID_KEY_PASSWORD")"
  printf 'keyAlias=%s\n' "$(escape "$ANDROID_KEY_ALIAS")"
  printf 'storeFile=%s\n' ../upload-keystore.jks
} > app/android/key.properties

echo "Signing with the upload key."
