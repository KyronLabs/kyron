-- Let an account exist without a local password.
--
-- schema.prisma has said `password String?` since sign-in moved to Supabase:
-- Supabase holds the credential, and the row the auth guard writes for a new
-- account only mirrors the identity, with `password: null`. No migration ever
-- said so. The baseline created the column NOT NULL and nothing relaxed it, so
-- a database built from these migrations -- which is every fresh install, and
-- what the README's quickstart does -- refused that row, and every sign-up
-- answered "Your sign-in is valid, but Kyron could not set up your account on
-- this server."
--
-- The deployed database never noticed, because it was created with
-- `db push` from the schema rather than from these files (see
-- scripts/start.sh). There this is a no-op: dropping NOT NULL from a column
-- that already allows null succeeds and changes nothing. Where the column is
-- still NOT NULL it is a catalogue change only; no row is rewritten.

ALTER TABLE "User" ALTER COLUMN "password" DROP NOT NULL;
