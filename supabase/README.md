# Supabase schema

The Kyron Supabase project (`iyajzmgnykgkivabxiuw`) holds auth, storage buckets,
the news tables, notifications, and the profile/interest tables the API
dual-writes to.

## Migrations

`migrations/` is **not** a complete history. It starts on 2026-08-30; seven
earlier migrations were applied before this directory existed and live only in
the project's `supabase_migrations.schema_migrations` table:

    20260708093936  news_posts_and_replies
    20260708165400  news_threading_images_and_reply_ownership
    20260727075510  news_reactions
    20260727075736  news_reactions_tuning
    20260729102044  profile_avatars
    20260729102623  reply_notifications
    20260729103215  push_delivery

`supabase db pull` will reconstruct the current schema in full if you want the
gap closed.

## Note on the two databases

Kyron runs two Postgres instances. The API's own tables (User, RefreshToken,
UserProfile, ...) are managed by Prisma in `api/prisma/schema.prisma` against
`DATABASE_URL` -- a different database from this one. The tables here are the
Supabase-side mirror the API dual-writes into, plus everything the client reads
directly. Changing one does not change the other; `user_profiles` exists in both
and the shapes are kept aligned by hand.
