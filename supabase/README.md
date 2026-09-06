# Supabase schema

The Kyron Supabase project is `zgzvclssemsyctstwgod`. It holds auth, storage
buckets, the news tables, notifications, and the profile/interest tables the
API dual-writes to. `GET /health` on the API reports the issuer it is actually
talking to, which is the authoritative answer if this file ever drifts again.

There is one project. Any other project reference you find in a config, a
dashboard bookmark or a connector is stale and should be removed rather than
kept "just in case" -- a second URL in circulation is how tokens end up signed
by one project and verified against another.

## Migrations

`migrations/` is **not** a complete history. It starts on 2026-08-30; earlier
migrations were applied before this directory existed and live only in the
project's `supabase_migrations.schema_migrations` table.

`supabase db pull` will reconstruct the current schema in full if you want the
gap closed. Do that before trusting this directory to describe the live
project: the files here have not been replayed from scratch against
`zgzvclssemsyctstwgod`, so treat them as a record of what was applied rather
than as a schema you could rebuild from.

## Note on the two databases

Kyron runs two Postgres instances. The API's own tables (User, RefreshToken,
UserProfile, ...) are managed by Prisma in `api/prisma/schema.prisma` against
`DATABASE_URL` -- a different database from this one. The tables here are the
Supabase-side mirror the API dual-writes into, plus everything the client reads
directly. Changing one does not change the other; `user_profiles` exists in both
and the shapes are kept aligned by hand.

Prisma migrations are applied by `api/scripts/start.sh`, which runs
`prisma migrate deploy` on every boot. Nothing applies the files in this
directory automatically.
