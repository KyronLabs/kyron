#!/usr/bin/env bash
# Install the Android NDK the build uses, before the build needs it.
#
# Left to Gradle, the NDK is downloaded in the middle of `flutter build`, by
# the Android Gradle Plugin, the first time a module with native code is
# configured -- once per NDK version any module names, on every run, because
# a fresh runner has neither. Release 19 failed that way twelve minutes in:
# the download arrived corrupt, "Archive is not a ZIP archive", and Gradle
# does not try twice.
#
# Here it is one version (kyron.ndkVersion in app/android/gradle.properties,
# which build.gradle.kts holds every plugin to), installed in its own step,
# and tried again when a download fails. A corrupt archive costs one retry a
# few seconds in, not a release.
#
# Usage: scripts/install-ndk.sh
set -euo pipefail

# The paths below are the repository's, wherever this is started from.
cd "$(dirname "$0")/.."

properties="app/android/gradle.properties"
version=$(sed -n 's/^kyron\.ndkVersion=//p' "$properties" | tr -d '[:space:]')
if [ -z "$version" ]; then
  echo "No kyron.ndkVersion in $properties." >&2
  exit 1
fi

sdk="${ANDROID_HOME:-${ANDROID_SDK_ROOT:-}}"
if [ -z "$sdk" ]; then
  echo "Neither ANDROID_HOME nor ANDROID_SDK_ROOT is set." >&2
  exit 1
fi

sdkmanager="$sdk/cmdline-tools/latest/bin/sdkmanager"
if [ ! -x "$sdkmanager" ]; then
  sdkmanager=$(command -v sdkmanager || true)
fi
if [ -z "$sdkmanager" ]; then
  echo "No sdkmanager under $sdk/cmdline-tools/latest or on PATH." >&2
  exit 1
fi

ndk="$sdk/ndk/$version"

# source.properties is the last thing an install writes, so its presence is
# what "installed" means -- a directory alone can be what a failed unzip left.
installed() {
  [ -f "$ndk/source.properties" ] &&
    grep -q "^Pkg.Revision *= *$version" "$ndk/source.properties"
}

if installed; then
  echo "NDK $version is already installed."
  exit 0
fi

for attempt in 1 2 3; do
  echo "Installing NDK $version (attempt $attempt of 3)."
  # What is on disk decides, not sdkmanager's exit status. The licence
  # prompt is answered with `yes`, which ends in SIGPIPE once sdkmanager
  # stops reading -- hence the `|| true` around the pipe.
  (yes 2>/dev/null | "$sdkmanager" --sdk_root="$sdk" --install "ndk;$version" >/dev/null) || true
  if installed; then
    echo "NDK $version installed."
    exit 0
  fi
  # Whatever a failed attempt left would be taken as installed next time.
  rm -rf "$ndk"
  sleep $((attempt * ${KYRON_NDK_BACKOFF:-10}))
done

echo "Could not install NDK $version after 3 attempts." >&2
exit 1
