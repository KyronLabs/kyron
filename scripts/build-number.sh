#!/usr/bin/env bash
# Print the build number for the commit checked out: how many commits it has.
#
# Every Android build carries versionCode 100000 + this number
# (app/android/app/build.gradle.kts), and both of the places that number goes
# refuse to go backwards. A phone will not install a lower versionCode over a
# higher one, and Play will not accept an upload whose versionCode is not
# above every one uploaded before it.
#
# It used to be each workflow's own run number. That was two counters: the
# development builds had reached 119 by the time Release ran for the first
# time, as run 1. Harmless while only releases made a bundle -- and a trap
# the moment anything else did. Upload one development bundle, 100119, and
# Play would have refused the next 118 releases as lower.
#
# A commit has more commits behind it than any of its ancestors, so the
# count only rises along main, whichever workflow does the counting. Both
# of them call this; a release is numbered from its tag's commit and the
# development builds after it from theirs. It also survives what a run number
# does not: a workflow renamed or recreated starts its run number at 1 again.
#
# What it does not survive is main's history being rewritten. Do not
# force-push main.
#
# Needs the full history. A shallow clone -- actions/checkout's default --
# has one commit, and would number every build 1.
set -euo pipefail

if [ "$(git rev-parse --is-shallow-repository)" = true ]; then
  echo "This checkout is shallow, so it cannot count the commits behind HEAD." >&2
  echo "Check out with fetch-depth: 0." >&2
  exit 1
fi

count=$(git rev-list --count HEAD)

# The highest number published before the switch: development build 119.
# Phones carry 100119, and anything at or below it would not install over it.
# Main had 645 commits at the switch, so only a rewritten history reaches this.
floor=119
if [ "$count" -le "$floor" ]; then
  echo "HEAD has $count commits, which is not above $floor -- the highest build" >&2
  echo "number already published. Builds numbered this low would not install" >&2
  echo "over ones already on phones, or upload to Play. Has history been rewritten?" >&2
  exit 1
fi

echo "$count"
