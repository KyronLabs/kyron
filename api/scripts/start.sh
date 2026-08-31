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

set -u

BASELINE="20251214230650_add_did_kyron_points_and_events"

if npx prisma migrate deploy; then
  echo "[start] database schema is up to date"
elif npx prisma migrate resolve --applied "$BASELINE" && npx prisma migrate deploy; then
  echo "[start] database baselined at $BASELINE and migrations applied"
else
  echo "[start] could not apply migrations; starting anyway -- GET /health reports the database state" >&2
fi

exec node dist/src/main.js
