# Database privilege hardening

The Prisma migration `20261125123000_financial_database_privilege_hardening`
sets a fixed search path on nine API-owned financial trigger functions,
revokes their direct client execution privileges, revokes obsolete client
access to the feedback sequence, and tightens defaults for objects created
by the migration owner. It does not change existing legitimate client
table policies or financial posting rules. The default privileges are
owner-specific; do not attempt to alter the managed supabase_admin role.

The function search path is `pg_catalog, public, pg_temp`, with temporary
objects last. Trigger functions remain SECURITY INVOKER, and their
existing attached triggers continue to enforce ledger invariants. The
migration includes catalog assertions and rolls back on failure.

Run the API PostgreSQL CI job against a disposable database before merging.
Existing ledger balance, immutability, reservation and payout tests must
pass after the migration. In the deployed environment, verify with
read-only catalog queries, re-run the Supabase security advisor, and
confirm that API health and ordinary feedback submission are unaffected.
Do not execute the migration directly against a live database outside the
normal deployment/migration process.

Future intentionally exposed RPCs must receive explicit least-privilege
EXECUTE grants and appropriate authorization checks. Default PUBLIC
function EXECUTE must be revoked at global scope for the migration owner;
a schema-specific revoke cannot subtract the global default.

This migration does not enable leaked-password protection, change public
profile visibility, rotate credentials, change Supabase-managed default
privileges or certify repository publication readiness.

References:
- https://supabase.com/docs/guides/api/securing-your-api
- https://supabase.com/docs/guides/database/functions
- https://www.postgresql.org/docs/current/sql-alterdefaultprivileges.html
