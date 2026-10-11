-- The two roles Supabase's Postgres has and a plain one does not.
--
-- Two migrations shut the anon key out of the tables they create:
--
--   REVOKE ALL ON TABLE "DeviceToken" FROM anon, authenticated;
--
-- That is right for the deployed database, which is Supabase's, where `anon`
-- and `authenticated` are the roles a browser holding the public key acts as.
-- On a plain Postgres -- the one docker-compose.yml starts for the quickstart
-- -- neither role exists, so `prisma migrate deploy` stopped at
-- 20260907200000_device_tokens with `role "anon" does not exist`, and the
-- quickstart never got past its third step.
--
-- Here they are created empty: no login, no privileges, nothing granted to
-- them, so revoking from them is meaningful nowhere and harmless everywhere.
-- Guarded, so running this against a database that already has them changes
-- nothing.
--
-- The official postgres image runs this once, when it initialises an empty
-- data directory. A volume from an earlier attempt that stopped at that
-- migration will not re-run it: `docker compose down -v` starts clean. On any
-- other plain Postgres, run it once with psql before migrating.

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'anon') THEN
    CREATE ROLE anon NOLOGIN;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'authenticated') THEN
    CREATE ROLE authenticated NOLOGIN;
  END IF;
END
$$;
