#!/usr/bin/env bash
# CI-only resource limits and lightweight diagnostics for signed Android builds.
# Never print command-line arguments, environment variables or Gradle logs:
# build commands can contain credentials and dart-defines.
set -euo pipefail

snapshot() {
  echo "::group::Android runner resources ($(date -u +%FT%TZ))"
  printf 'CPU count: '
  nproc || true
  free -m || true
  df -h . || true
  uptime || true
  # Command names only, not args or env.
  ps -eo pid,comm,rss,pcpu --sort=-rss | sed -n '1,9p' || true
  if [ -r /sys/fs/cgroup/memory.events ]; then
    echo "cgroup memory events:"
    cat /sys/fs/cgroup/memory.events || true
  fi
  if [ -r /sys/fs/cgroup/memory.max ]; then
    printf 'cgroup memory max: '
    cat /sys/fs/cgroup/memory.max || true
  fi
  echo "::endgroup::"
}

case "${1:-}" in
  configure)
    # Standard private-repo Linux runners have two CPUs and 8 GB RAM.
    # Gradle user-home properties override the project's much larger JVM
    # defaults without changing local builds.
    home="${GRADLE_USER_HOME:-$HOME/.gradle}"
    mkdir -p "$home"
    umask 077
    cat >> "$home/gradle.properties" <<'PROPERTIES'

# Kyron hosted Android CI resource budget
org.gradle.jvmargs=-Xmx4g -XX:MaxMetaspaceSize=1g -XX:ReservedCodeCacheSize=256m
org.gradle.workers.max=2
org.gradle.parallel=false
org.gradle.vfs.watch=false
kotlin.daemon.jvmargs=-Xmx1g
PROPERTIES
    echo "Configured bounded Gradle/Kotlin memory and disabled VFS watching."
    snapshot
    ;;
  run)
    shift
    workdir="${1:?missing build directory}"
    shift
    [ "$#" -gt 0 ] || exit 2
    cd "$workdir"
    snapshot
    (
      delay=
      trap 'if [ -n "$delay" ]; then kill "$delay" 2>/dev/null || true; fi; exit 0' TERM INT
      while :; do
        sleep 60 &
        delay=$!
        wait "$delay" || exit 0
        delay=
        snapshot
      done
    ) &
    sampler=$!
    cleanup() {
      local status=$?
      trap - EXIT
      kill "$sampler" 2>/dev/null || true
      wait "$sampler" 2>/dev/null || true
      snapshot
      exit "$status"
    }
    trap cleanup EXIT
    # Preserve the actual compiler exit status. No silent retry or success.
    "$@"
    ;;
  *)
    echo "Usage: scripts/android-ci.sh configure | run DIRECTORY COMMAND..." >&2
    exit 2
    ;;
esac
