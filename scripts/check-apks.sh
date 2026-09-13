#!/usr/bin/env bash
# Check that APKs about to be published are ones a phone will install.
#
# Three different faults produce the same six words on a handset -- "App not
# installed as package appears to be invalid" -- and all three build, upload
# and publish without complaint:
#
#   debuggable   ColorOS, MIUI, Funtouch and others refuse a debuggable APK
#                from an unknown source outright.
#   truncated    a download long enough to cut off fails the same way, and so
#                does anything that alters the file after it was signed.
#   a new key    Android refuses an update whose signing certificate is not
#                the one already installed. That is
#                INSTALL_FAILED_UPDATE_INCOMPATIBLE, and it strikes on the
#                second install rather than the first, which is why it reads
#                as intermittent.
#
# Four development builds shipped with the third of those before anything
# looked. So both workflows call this before they upload anything, and it is
# the same script for both, because a check that exists on development builds
# and not on releases is a check that will be missing the day it matters.
#
# Usage:
#   scripts/check-apks.sh [--pin SHA256] APK...
#
# --pin requires the signing certificate to be one particular one, by its
# SHA-256. Development builds pin to the key committed at
# app/android/dev-signing; a release has no fingerprint in the repository to
# pin to, so it gets everything else.
#
# Whether or not it is pinned, every APK in one run has to carry the same
# certificate as the others -- four APKs out of one build signed two
# different ways is a signing config that stopped taking effect halfway.
#
# Runs anywhere, not only in CI: point ANDROID_HOME at an SDK and give it a
# directory of downloaded artifacts.

set -euo pipefail

here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

usage() {
  echo "usage: scripts/check-apks.sh [--pin SHA256] APK..."
}

pin=
apks=()
while [ $# -gt 0 ]; do
  case "$1" in
    --pin)   pin=$(tr -d '[:space:]' <<<"${2:-}"); shift 2 ;;
    --pin=*) pin=$(tr -d '[:space:]' <<<"${1#--pin=}"); shift ;;
    -h|--help) usage; exit 0 ;;
    --) shift; break ;;
    -*) echo "check-apks.sh: unknown option $1" >&2; usage >&2; exit 2 ;;
    *)  apks+=("$1"); shift ;;
  esac
done
while [ $# -gt 0 ]; do apks+=("$1"); shift; done

if [ "${#apks[@]}" -eq 0 ]; then
  echo "check-apks.sh: no APKs given." >&2
  usage >&2
  exit 2
fi

# aapt2 and apksigner come with the Android SDK. Looked up rather than
# assumed, and a missing one fails: a guard that silently does not run is
# worse than no guard.
sdk="${ANDROID_HOME:-${ANDROID_SDK_ROOT:-}}"
aapt2=$(command -v aapt2 || true)
apksigner=$(command -v apksigner || true)
if [ -n "$sdk" ]; then
  aapt2=$(ls -d "$sdk"/build-tools/*/aapt2 2>/dev/null | sort -V | tail -1 || true)
  apksigner=$(ls -d "$sdk"/build-tools/*/apksigner 2>/dev/null | sort -V | tail -1 || true)
fi
test -n "$aapt2" || { echo "No aapt2: set ANDROID_HOME to an Android SDK." >&2; exit 1; }
test -n "$apksigner" || { echo "No apksigner: set ANDROID_HOME to an SDK." >&2; exit 1; }

log=$(mktemp)
trap 'rm -f "$log"' EXIT

agreed=
agreed_on=

for apk in "${apks[@]}"; do
  name=$(basename "$apk")
  test -f "$apk" || { echo "$name: no such file."; exit 1; }

  badging=$("$aapt2" dump badging "$apk")
  if grep -q 'application-debuggable' <<<"$badging"; then
    echo "$name is debuggable. Android will refuse to install it."
    exit 1
  fi

  # That the signature covers the file, which is what catches a truncated or
  # altered APK. Exit status only: what apksigner prints is prose, and its
  # wording changes between build-tools versions.
  if ! "$apksigner" verify "$apk" >"$log" 2>&1; then
    echo "$name has a signature that does not verify:"
    sed 's/^/  /' "$log"
    exit 1
  fi

  # Which key signed it, read out of the APK Signing Block rather than out of
  # a tool's output. scripts/apk-certificate.py says why.
  #
  # Unsigned, or a signing block it cannot read, is a failure and it says so.
  # An empty answer treated as a pass is the one outcome this must not have.
  certificates=$(python3 "$here/apk-certificate.py" "$apk")
  test -n "$certificates" || { echo "$name: could not read a certificate."; exit 1; }

  # Every scheme the APK carries, not just the first. An APK whose v2 and v3
  # certificates differ installs differently depending on the Android
  # version, which is not a thing to find out later.
  while read -r scheme digest subject; do
    case "$subject" in
      *"CN=Android Debug"*)
        echo "$name is signed with a debug key ($scheme):"
        echo "  $subject"
        echo "key.properties did not take, so this APK carries a certificate"
        echo "minted during this build and will not install over any"
        echo "previously installed Kyron."
        exit 1
        ;;
    esac

    if [ -n "$pin" ] && [ "$digest" != "$pin" ]; then
      echo "$name is not signed with the expected key."
      echo "  scheme   $scheme"
      echo "  expected $pin"
      echo "  got      $digest"
      echo "  subject  $subject"
      echo "If the keystore was replaced on purpose, update the fingerprint"
      echo "it is pinned to -- and note that everybody who has this build"
      echo "installed has to uninstall it once."
      exit 1
    fi

    if [ -z "$agreed" ]; then
      agreed=$digest
      agreed_on=$name
    elif [ "$digest" != "$agreed" ]; then
      echo "$name is signed with a different key from $agreed_on."
      echo "  $agreed_on  $agreed"
      echo "  $name  $digest ($scheme)"
      echo "One build has to sign every APK the same way, or half of them"
      echo "will not install over the other half."
      exit 1
    fi

    printf '%-46s %-4s %s\n' "$name" "$scheme" "$subject"
    printf '%-46s %-4s %s\n' '' '' "$digest"
  done <<<"$certificates"

  # A release APK for one architecture is 30-45 MB here; the debug one this
  # replaced was 114 MB. Anything past 70 MB per split is either debug again
  # or something very large has been added without anyone noticing.
  size=$(stat -c%s "$apk")
  case "$apk" in
    *universal*) limit=$((160 * 1024 * 1024)) ;;
    *)           limit=$(( 70 * 1024 * 1024)) ;;
  esac
  if [ "$size" -gt "$limit" ]; then
    echo "$name is $((size / 1024 / 1024)) MB, over its $((limit / 1024 / 1024)) MB limit."
    exit 1
  fi
  printf '%-46s %5s MB  ok\n' "$name" "$((size / 1024 / 1024))"
done

echo
echo "${#apks[@]} APKs, all installable, all signed with $agreed."
