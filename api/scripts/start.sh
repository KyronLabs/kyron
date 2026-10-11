#!/bin/sh
# Start the API, bringing the database schema up to date first.
#
# Render has no release phase on this plan, so nothing else applies migrations:
# a new table would simply never exist, and every route touching it answers 500.
# That is exactly what happened to Post --
#
#   PrismaClientKnownRequestError: The table `public.Post` does not exist
#   code: 'P2021'
#
# -- on every call to GET /feed/recent.
#
# `migrate deploy` alone was not enough, because this database was originally
# created with `db push`. That writes the schema without recording anything in
# _prisma_migrations, so migrate deploy sees an unbaselined database, refuses,
# and the Post migration never runs.
#
# Baselining is the documented fix and is not destructive: `migrate resolve
# --applied` only writes a row saying a migration is already present, and never
# touches a table. So: deploy; if that fails, baseline the migration this
# database already has and deploy again.
#
# Whatever happens, the server starts. Refusing to boot over a database problem
# is what took the API down for an afternoon, and GET /health reports the
# database state either way.
#
# "Whatever happens" includes migrations that never finish. On 11 October a
# deploy printed nothing after this script began and was killed by Render
# eighteen minutes later; the database logs show the new instance never
# connected at all. Nothing bounded the wait, so the server never started and
# the log could not say which step was stuck. Each step now says it is
# starting, and the migrations get MIGRATE_TIMEOUT seconds (default 180;
# they take under a second here) before the server starts without them.
#
# Prisma is run from node_modules rather than through npx, which on a missing
# or mismatched binary goes to the network to fetch one -- the kind of wait
# that prints nothing.

set -u

BASELINE="20251214230650_add_did_kyron_points_and_events"
MIGRATE_TIMEOUT="${MIGRATE_TIMEOUT:-180}"
PRISMA="node_modules/.bin/prisma"

# Runs a Prisma command, killed if it outlasts MIGRATE_TIMEOUT. `timeout`
# exits 124 when it had to stop it.
prisma() {
  timeout "$MIGRATE_TIMEOUT" "$PRISMA" "$@"
}

echo "[start] applying migrations (giving up after ${MIGRATE_TIMEOUT}s)"
prisma migrate deploy
status=$?

if [ "$status" -eq 0 ]; then
  echo "[start] database schema is up to date"
elif [ "$status" -eq 124 ]; then
  # Not retried: the baseline path below talks to the same database and would
  # wait just as long.
  echo "[start] migrations did not finish in ${MIGRATE_TIMEOUT}s -- the database is probably unreachable; starting anyway" >&2
else
  echo "[start] migrate deploy failed; baselining at $BASELINE and trying again"
  if prisma migrate resolve --applied "$BASELINE" && prisma migrate deploy; then
    echo "[start] database baselined at $BASELINE and migrations applied"
  else
    echo "[start] could not apply migrations; starting anyway -- GET /health reports the database state" >&2
  fi
fi

echo "[start] starting the server"
exec node dist/src/main.js
