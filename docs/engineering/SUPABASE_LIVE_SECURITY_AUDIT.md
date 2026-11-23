# Supabase Live Security Audit

**Review date:** 23 November 2026  
**Scope:** Read-only review of the Supabase project currently configured in the Render Kyron API, its live PostgreSQL roles/grants/RLS/migrations, Supabase security advisors, current repository migrations, and the active Render API deployment.  
**Project:** `kyron-dev` (`zgzvclssemsyctstwgod`, `us-west-2`)  
**Limitations:** No database privileges, Auth settings, Storage settings, secrets, environment variables, production rows, migrations or deploy configuration were changed. No secret values were retrieved or reproduced.

## Executive summary

The current application data boundary is substantially better than the historical baseline: API-owned public tables are not directly granted to `anon` or `authenticated`, and RLS is enabled on 89 of 90 public tables. The remaining client-readable tables are the public profile and interests tables, with explicit policies. The current Render API successfully connected to this Supabase project and completed its Prisma migration check on 23 November.

This is not a clean security-advisor report. The live project has:
- Nine financial trigger functions with mutable `search_path`.
- A leftover client grant on `Feedback_number_seq`.
- Broad default privileges for future objects created by `postgres`; these can be tightened.
- Broad owner-specific defaults for objects created by `supabase_admin`. Supabase's current documentation says these defaults cannot be changed by `postgres`; do not attempt to change them with `ALTER DEFAULT PRIVILEGES`.
- Leaked-password protection disabled.
- Public GraphQL visibility for the interests catalogue and public profiles; these match the current application policies but need an explicit privacy decision for the profile fields exposed.

## 1. Environment and deployment identity

The connected Supabase account exposed one project, named `kyron-dev`, in `us-west-2`, with Postgres 17.6.1.054 and status `ACTIVE_HEALTHY`.

The Render Kyron API web service is connected to this project. Its current startup log records the Supabase issuer for this project and successful database startup. The name `kyron-dev` should not be assumed to mean the service is a development environment: it is the only Supabase project visible in this connected account and is the one used by the active Render Kyron API. Confirm whether this is the intended environment assignment and whether production and staging are meant to share this project.

Render reports no managed Postgres instance for this workspace; the API database is Supabase Postgres.

## 2. Migration alignment and startup evidence

### Prisma

- The repository has 56 directories under `api/prisma/migrations/`.
- Live `public."_prisma_migrations"` reports 56 total, 56 succeeded, and zero unfinished.
- The latest applied migration is `20261123100000_dual_control_payout_approval`.
- Render startup on 23 November reported “56 migrations found”, “No pending migrations to apply”, then “[start] database migrations are up to date” and “[start] starting the API”.

This is direct evidence that the current Render startup path successfully connected to the configured database and completed its migration check. It is not evidence of the deliberate failure/timeout deployment drill, or backup/restore rehearsal.

### Supabase-native migrations

The four checked-in migrations match the live Supabase migration list exactly:

1. `20260830105505_revoke_rest_execute_on_trigger_functions`
2. `20260830131743_create_profile_and_interest_tables`
3. `20260906160237_lock_down_api_tables`
4. `20261110170000_harden_storage_grants_and_buckets`

No missing or extra Supabase-native migration was observed.

## 3. Roles, ownership and existing public-schema grants

### Role posture

- `anon` and `authenticated` are not superusers and do not have `BYPASSRLS`, role creation, database creation or replication attributes.
- `service_role` has `BYPASSRLS`, as expected for a server-only Supabase service role. Its key must remain server-side.
- The managed `supabase_admin` role is a superuser; this is a platform-owned role.
- The observed public application tables/sequences/views are owned by `postgres`, not `supabase_admin`.
- Neither `anon` nor `authenticated` has `CREATE` on the `public` or `storage` schema.

### Existing table grants

The current direct grants to client roles in `public` are limited to:

| Table | `anon` | `authenticated` | Policy |
|---|---|---|---|
| `interests` | SELECT | SELECT | Public read |
| `user_profiles` | SELECT | SELECT, INSERT, UPDATE, DELETE | Public read; writes scoped to `auth.uid() = user_id` |
| `user_interests` | none | SELECT, INSERT, DELETE | Each operation scoped to `auth.uid() = user_id` |

No direct `anon`/`authenticated` grants were found on the Prisma-managed application tables, including messages, users, refresh/password-reset records, moderation, or financial tables. Those remain API-mediated.

The profile table's public-read policy includes `display_name`, `avatar_url`, `cover_url`, `bio`, `location` and `website`. The product/privacy owner should confirm that all these fields are intended to be public. The interests catalogue is public reference data; `user_interests` is owner-scoped.

### RLS

- 89 of 90 public tables have RLS enabled.
- The only public table without RLS is the internal `_prisma_migrations` table; it has no `anon`/`authenticated` grants.
- 86 RLS-enabled tables have no policies. For API-owned tables with no client grants this is an intentional deny-by-default backstop, not a reason to add broad policies.
- The eight active public-table policies correspond to the profile/interests/user-interests model described above.

## 4. Default privileges and the Supabase-managed role caveat

This is the most important schema-governance distinction.

### Defaults for objects created by `postgres`

The live `pg_default_acl` for `postgres` in `public` gives:
- Future tables: `postgres` and `service_role`; no explicit `anon`/`authenticated` table privileges.
- Future sequences: `anon` and `authenticated` receive `SELECT`, `UPDATE`, and `USAGE`.
- Future functions: the schema-specific default ACL includes `EXECUTE` for `anon` and `authenticated`. PostgreSQL's global default function-EXECUTE grant to `PUBLIC` also needs to be handled when designing the default-privilege migration; a schema-local revoke cannot subtract a global default grant.

The current `Feedback_number_seq` is owned by `postgres` and still grants `anon` and `authenticated` `SELECT`, `UPDATE`, and `USAGE`. The two other inspected public sequences do not grant these privileges.

### Defaults for objects created by `supabase_admin`

The live `pg_default_acl` shows `anon` and `authenticated` receive broad table, sequence and function defaults for objects created by `supabase_admin`. However, all currently observed application objects in `public` are owned by `postgres`; this is a future-object risk, not evidence that the current Prisma tables are exposed.

**Important platform limitation:** Supabase's current knowledge-base guidance says `postgres` cannot change `supabase_admin`'s default privileges, because it is not a member of that managed role and cannot be made one. Do not attempt a migration containing `ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin ...`; it will fail. The documented controls are to manage the defaults for objects created by `postgres` and keep extensions/managed objects out of `public` where possible. See [Supabase's explanation of supabase_admin default privileges](https://supabase.com/kb/troubleshooting/cant-change-the-default-privileges-of-supabase_admin-in-the-public-schema-448af9).

### Recommended repository migration scope

Once the Supabase CLI is available in the build environment, create a migration using `supabase migration new <name>` and review at least:

- Revoke `anon` and `authenticated` defaults on future tables and sequences created by `postgres` in `public`.
- Revoke the existing `Feedback_number_seq` grants from `anon` and `authenticated`.
- Revoke default function execution for `PUBLIC` on functions created by `postgres` at the appropriate global scope, and revoke client execution on the nine existing trigger functions. Explicitly grant any RPC/helper functions that product code genuinely needs.
- Add a fixed safe function search path to the nine financial trigger functions.
- Keep `service_role` and API-owner access needed by the service; do not globally revoke table grants without checking the API's use of the service role.
- Do not attempt to modify `supabase_admin`'s managed defaults.

This is a migration plan only; no migration has been created or applied during this live audit.

## 5. Financial trigger functions

The security advisor reports nine `function_search_path_mutable` warnings:

- `kyron_assert_creator_earning_reservation_total`
- `kyron_assert_ledger_transaction_balanced`
- `kyron_protect_creator_earning_hold`
- `kyron_protect_creator_earning_reservation`
- `kyron_protect_fx_quote`
- `kyron_protect_ledger_account_identity`
- `kyron_protect_payout_provider_event`
- `kyron_reject_financial_evidence_mutation`
- `kyron_require_same_xact_for_ledger_posting`

All nine are `RETURNS trigger`, are `SECURITY INVOKER` (not `SECURITY DEFINER`), have no fixed `search_path`, and are attached to database triggers. Their current execute privilege is inherited from broad function defaults; they are not ordinary RPC endpoints. PostgreSQL checks trigger-function execute privilege when the trigger is created, so revoking direct invocation from client roles does not disable the already-attached triggers.

Set a fixed `search_path` such as `pg_catalog, public` (and confirm all referenced objects resolve correctly) rather than relying on a mutable session path. Keep financial invariants and trigger definitions unchanged.

## 6. GraphQL, Storage and Auth advisors

### GraphQL

- Anonymous exposure warnings: `public.interests` and `public.user_profiles`.
- Authenticated exposure warnings: `public.interests`, `public.user_interests`, and `public.user_profiles`.

These reflect current grants and RLS policies. `user_interests` is owner-scoped by `auth.uid()`; its presence in the GraphQL schema alone does not mean one user can read another user's rows. Public profile and interest visibility are product decisions and must be retained only if intentional.

### Storage

- All ten inspected tables in the `storage` schema have RLS enabled.
- No `storage.objects` policies were present in the live policy catalog.
- `kyron-media` is configured as a public bucket; `kyron-private` is non-public. Both have a 25 MiB upload limit and the configured image/video/audio MIME allow-list.
- The absence of Storage object policies means the client cannot perform direct Storage table operations through those policies; the service-side API uses its privileged server path. Public object retrieval from `kyron-media` is still public by bucket configuration. Ensure private messages/view-once content uses `kyron-private` and never leaks into the public bucket.

### Auth

Supabase's security advisor reports `auth_leaked_password_protection` as WARN: leaked-password protection is disabled. Enabling this should be a deliberate Auth policy change with sign-up/password-reset flow review, not an unreviewed schema migration.

## 7. Credential and administrator follow-up

- The owner confirmed the historical Render PostgreSQL password was rotated on 23 November 2026. The Render API subsequently connected and completed its migration check. The broader historical credential item remains open until the historical SendGrid key is revoked or its other use is established, and the current Supabase service-role key/JWT-secret issuance/rotation history is confirmed.
- Current database state has no row for the historical seeded administrator email. Two current `ADMIN` rows both match Supabase Auth identities and have no local password. This does not prove whether the legacy seed account was created or used before it was removed.
- Claude Code session URLs still require an owner-side/provider-side access and revocation review; private repository visibility does not revoke a session link.

See [issue #169](https://github.com/KyronLabs/kyron/issues/169) for credential tasks.

## 8. Limitations and actions not taken

This review used read-only SQL, Supabase project/table/migration/advisor tools, current repository files and Render deployment/log tools. It did not read secret values, authenticate as an admin, access mail-provider credentials, open Claude sessions, modify database grants, toggle Auth settings, apply a migration, create a staging resource, or run a deliberate failed deployment. No changes were made to the live Supabase or Render environment.
