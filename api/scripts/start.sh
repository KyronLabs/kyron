#!/bin/sh
# Apply pending Prisma migrations before the API accepts traffic.
# Any migration error is a failed container start. Baseline resolution is
# an explicit operator action after schema comparison and backup verification.

set -eu

MIGRATE_TIMEOUT="${MIGRATE_TIMEOUT:-180}"
PRISMA="${PRISMA_BIN:-node_modules/.bin/prisma}"

case "$MIGRATE_TIMEOUT" in
  ''|*[!0-9]*|0)
    echo "[start] MIGRATE_TIMEOUT must be a positive integer number of seconds" >&2
    exit 2
    ;;
esac

if ! command -v timeout >/dev/null 2>&1; then
  echo "[start] required command 'timeout' is not installed; refusing to start" >&2
  exit 127
fi

if [ ! -x "$PRISMA" ]; then
  echo "[start] Prisma CLI is missing or not executable at $PRISMA; refusing to start" >&2
  exit 127
fi

echo "[start] applying pending database migrations (timeout: ${MIGRATE_TIMEOUT}s)"
if timeout "${MIGRATE_TIMEOUT}s" "$PRISMA" migrate deploy; then
  echo "[start] database migrations are up to date"
else
  status=$?
  if [ "$status" -eq 124 ] || [ "$status" -eq 137 ]; then
    echo "[start] migration command exceeded ${MIGRATE_TIMEOUT}s; refusing to start the API" >&2
  else
    echo "[start] prisma migrate deploy failed with exit code $status; refusing to start the API" >&2
  fi
  exit "$status"
fi

echo "[start] starting the API"
exec node dist/src/main.js
