# Supabase schema

The Kyron Supabase project is `zgzvclssemsyctstwgod` ("kyron-dev"). `GET /health`
on the API reports the issuer it is actually talking to, which is the
authoritative answer if this file ever drifts again.

There is one project. Any other reference you find in a config, a dashboard
bookmark or a connector is stale and should be removed rather than kept "just
in case" -- a second URL in circulation is how tokens end up signed by one
project and verified against another.

## One database, not two

This file used to say Kyron ran two Postgres instances: this one, and a
separate database at `DATABASE_URL` holding the API's own tables. That is not
true, and was checked rather than assumed -- `zgzvclssemsyctstwgod`'s `public`
schema holds all of it:

  * the API's Prisma tables (`User`, `Post`, `Comment`, `Conversation`,
    `Community`, ...), created by `prisma migrate deploy`; and
  * the three the client reads directly (`user_profiles`, `interests`,
    `user_interests`), which are the ones with RLS policies.

So `DATABASE_URL` points at this project. Changing the schema in either place
changes it for everybody.

## Migrations

There are two sets, applied by different things, and neither knows about the
other:

  * `api/prisma/migrations/` is applied by `api/scripts/start.sh`, which runs
    `prisma migrate deploy` on every boot. This is what creates and alters the
    API's tables.
  * `migrations/` here is applied with the Supabase CLI, by hand. It holds
    what Prisma does not own: policies, grants, and the client-facing tables.

`migrations/` is not a complete history -- it starts on 2026-08-30, and earlier
migrations live only in `supabase_migrations.schema_migrations`. Run
`supabase db pull` before trusting it to describe the live project.

## Grants

Supabase grants `anon` and `authenticated` full access to every new table in
`public`, and Prisma creates its tables there. Left alone, that publishes the
API's entire schema over PostgREST and pg_graphql to anybody holding the anon
key -- which is public by design and is compiled into the app.

`20260907090000_lock_down_api_tables.sql` revokes those grants and turns off
the default privilege that keeps handing them out. **A new Prisma model still
needs checking**: the default privilege is fixed, but it is worth running the
security advisor after a migration adds a table.
