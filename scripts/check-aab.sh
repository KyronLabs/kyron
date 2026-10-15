#!/usr/bin/env bash
# Check that an app bundle about to be published is one Play will accept.
#
# Play refuses a bundle for either of two things, and says so only once it
# has been uploaded:
#
#   the wrong key   Play App Signing knows the upload key, and refuses a
#                   bundle signed with any other -- the development key
#                   included, which is what signs every APK in the same job
#                   until key.properties is rewritten for the bundle.
#   a used number   every upload needs a version code above every one
#                   uploaded before it. The code is 100000 plus the build
#                   number (scripts/build-number.sh), and a bundle that did
#                   not get the number it was meant to would carry 100000
#                   plus whatever pubspec.yaml says.
#
# Usage:
#   scripts/check-aab.sh --keystore FILE [--build N] AAB...
#
# The keystore is the upload key's, opened with ANDROID_KEYSTORE_PASSWORD and
# ANDROID_KEY_ALIAS from the environment -- the names of the repository
# secrets. Its certificate is what every bundle has to be signed with. With
# --build, every bundle has to carry versionCode 100000 + N.
#
# Prints the package, version code, version name and signing certificate of
# each bundle; nothing secret.

set -euo pipefail

here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PACKAGE=so.kyron.app

usage() {
  echo "usage: scripts/check-aab.sh --keystore FILE [--build N] AAB..."
}

keystore=
build=
bundles=()
while [ $# -gt 0 ]; do
  case "$1" in
    --keystore) keystore=${2:-}; shift; [ $# -eq 0 ] || shift ;;
    --build) build=${2:-}; shift; [ $# -eq 0 ] || shift ;;
    -h|--help) usage; exit 0 ;;
    *) bundles+=("$1"); shift ;;
  esac
done
if [ -z "$keystore" ] || [ ${#bundles[@]} -eq 0 ]; then
  usage >&2
  exit 2
fi
if [ -n "$build" ] && ! [[ "$build" =~ ^[0-9]+$ ]]; then
  echo "--build takes a number, and was given '$build'." >&2
  exit 2
fi

# The certificate itself, as DER, hashed here. Not read out of keytool's
# printed fingerprints: that output is for people, and a check that parses
# it is a check that breaks when the wording does. Written to a file and
# judged by keytool's exit status, because keytool prints its errors to
# standard output -- piped into sha256sum, a wrong password hashes as
# though it were a certificate.
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
if ! keytool -exportcert -keystore "$keystore" -alias "$ANDROID_KEY_ALIAS" \
  -storepass:env ANDROID_KEYSTORE_PASSWORD -file "$work/upload.der" > /dev/null 2>&1; then
  echo "Could not read the certificate of $ANDROID_KEY_ALIAS out of $keystore" >&2
  echo "with ANDROID_KEYSTORE_PASSWORD." >&2
  exit 1
fi
expected=$(sha256sum "$work/upload.der" | cut -d' ' -f1)
development=$(tr -d '[:space:]' < "$here/../app/android/dev-signing/fingerprint.txt")

for bundle in "${bundles[@]}"; do
  name=$(basename "$bundle")

  read -r package code version < <("$here/aab-manifest.py" "$bundle") || {
    echo "$name: could not read its manifest."
    exit 1
  }
  if [ "$package" != "$PACKAGE" ]; then
    echo "$name: package $package, not $PACKAGE."
    exit 1
  fi
  if [ -n "$build" ] && [ "$code" != $((100000 + build)) ]; then
    echo "$name: versionCode $code, and build $build should be $((100000 + build))."
    echo "Was --build-number passed to flutter build appbundle?"
    exit 1
  fi

  # A bundle is signed the JAR way, so the reader reports it as v1. Every
  # signature in it has to be the upload key's.
  signers=$("$here/apk-certificate.py" "$bundle") || {
    echo "$name: not signed. Play takes only a bundle signed with the upload key."
    exit 1
  }
  while read -r scheme digest subject; do
    if [ "$digest" = "$development" ]; then
      echo "$name: signed with the development key, not the upload key."
      echo "key.properties was not rewritten before the bundle was built."
      exit 1
    fi
    if [ "$digest" != "$expected" ]; then
      echo "$name: signed ($scheme) by $subject, SHA-256 $digest."
      echo "The upload key's certificate is $expected. Play would refuse it."
      exit 1
    fi
  done <<< "$signers"

  subject=$(head -n1 <<< "$signers" | cut -d' ' -f3-)
  echo "$name: $package versionCode $code versionName $version, signed by $subject."
done
