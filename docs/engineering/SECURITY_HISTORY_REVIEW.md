# Security History Review

**Review date:** 23 November 2026  
**Repository:** `KyronLabs/kyron`  
**Scope:** Read-only review of repository files, selected historical file revisions, commit metadata and the existing security issue.  
**Environment access:** No Render, Supabase, production database, mail-provider or Claude account was accessed. No production data or secret values were retrieved into this report.

## Executive findings

The repository history confirms three classes of historical artifacts:

1. A legacy seed could create a fixed administrator account using a written-down password.
2. Tracked environment-file revisions contained credential-shaped values, including a remote Render PostgreSQL URL with embedded credentials and a retired mail-provider credential.
3. Commit messages contain Claude Code session URLs in `Claude-Session` trailers.

These findings establish that the material entered Git history. They do **not** establish that a seeded administrator existed in production, that a historical credential remained valid or was reused, or that an AI session was accessible to an unintended viewer.

## 1. Historical administrator seed

### Evidence

- Historical `api/prisma/seed.ts` at commit `45177806691e2019b43c66670cfb8e578627ca0a` (26 November 2025) contains conditional creation of `admin@kyron.app`, hashes a literal password, and sets the new row's role to `ADMIN`.
- Compiled `api/dist/prisma/seed.js` was committed at `011c227772f3fafff55a13e72ec2fa49b8e2031c` (27 November 2025).
- The compiled seed output was removed in cleanup commit `3d1944d9cbb805a2fbaaf5ae1438af18721dd754` (30 August 2026).
- Security-remediation PR [#196](https://github.com/KyronLabs/kyron/pull/196), merged as `f9cb5ab234377ae92a39548305d7bb82ae56349c`, changed the seed so it no longer creates an administrator. Current `api/prisma/seed.ts` explicitly records that there is no default admin account.
- The manual `prisma:seed` package script remains. The Windows setup script invokes the seed after configuring a local `host.docker.internal` PostgreSQL database. The current Docker startup script runs migrations; no automatic production seed invocation was found in the current Docker/Render/CI path.

### Assessment

The historical seed was executable and could create a privileged row if it was run against a database. The local setup path is evidence of intended developer use, not proof that it was exclusively used locally. A manually invoked production seed cannot be ruled out from repository evidence.

The current API verifies Supabase tokens and resolves application users by the Supabase subject ID; it does not attach an account solely because its email matches. That is a meaningful current control, but it does not prove that an old row is absent from the production database or that it never had access under the legacy authentication path.

### Required operational evidence

- Read-only inspection of the production application-user table for the historical seed email and all privileged-role rows.
- For any matching row, compare its ID with the corresponding Supabase Auth user ID and inspect account status and role history.
- Review authentication and administrative audit logs for sign-ins and privileged activity.
- Preserve evidence before disabling, demoting or deleting any row. Do not infer that absence from current seed code proves absence from production.

## 2. Tracked environment credentials

### Evidence

- `api/.env` was added in commit `496c07bc4c392292540109b77e9e76eefb045abc` (24 November 2025) and changed in later November 2025 commits.
- A tracked revision at `b30cffd2e271c14dce48894123e38044b1b06887` (25 November 2025) contained a non-loopback Render PostgreSQL URL with embedded credentials, a placeholder-like `JWT_SECRET`, and a credential-shaped value for a retired mail provider. None of these values is reproduced or tested here.
- The same historical revision added `api/kyron-api_OLD.env`, which contained local development database credentials and a placeholder-like JWT value.
- Cleanup commit `3d1944d9cbb805a2fbaaf5ae1438af18721dd754` removed `api/kyron-api_OLD.env` and generated build output. Current `main` contains neither historical environment file.
- The root `.gitignore` now ignores `.env`, `.env.*` and `*.env`, while allowing example files. This prevents routine re-addition but does not remove the old blobs from Git history.

### Current-code context

- The API's legacy sign-in and mail-provider integration have been retired. Authentication mail is handled by Supabase Auth, including `resetPasswordForEmail`. No active integration or dependency for the former provider was found; its unused test-environment settings and example comments are removed.
- The current API's shared-secret JWT fallback is a different setting, `SUPABASE_JWT_SECRET`, used only when the Supabase project still signs with its legacy shared secret. The API also supports JWKS-based signing keys. Do not confuse this with the historical app-level `JWT_SECRET`.
- `render.yaml` still lists a `JWT_SECRET` environment slot marked `sync: false`, although the current API source and `api/.env.example` no longer use the old app-level setting. Treat this as stale configuration to review, not as evidence that the old secret is currently consumed.
- The current `SUPABASE_SERVICE_ROLE_KEY` remains a sensitive runtime setting. Its issue date and rotation history cannot be established from repository source.

### Required operational evidence

- The owner reconfirmed on 25 November 2026 that the historical database credentials have been rotated and invalidated. The earlier live audit observed successful startup and migration checks after rotation. No authentication attempt with the historical credentials was made.
- The owner confirmed on 25 November 2026 that the former mail-provider account was closed and had not been used for over a year. Treat the account retirement as owner-confirmed; provider-side credential invalidation has not been independently tested. Do not reactivate the account or attempt to use the historical key. The historical blob remains subject to the publication audit.
- Remove the stale app-level `JWT_SECRET` from Render after confirming no old deployment or other service consumes it. Do not generate a replacement merely to satisfy the obsolete variable.
- Verify the issue/rotation date of `SUPABASE_SERVICE_ROLE_KEY` and determine from the project's current signing mode whether `SUPABASE_JWT_SECRET` is still needed. Rotate only with a coordinated auth-key migration plan.
- Review provider access logs for suspicious use where retention permits.

The existing [issue #169](https://github.com/KyronLabs/kyron/issues/169) remains open as of this review and has no recorded comments or closure evidence. The owner has confirmed the historical database credential is retired and the former mail integration is unused. The old app-level `JWT_SECRET` remains obsolete. Track current Supabase service credentials, other runtime settings and remaining publication-audit evidence in that issue.

## 3. AI coding-session references in commit metadata

### Evidence

- Commit messages contain `Claude-Session: https://claude.ai/code/session_…` trailers.
- GitHub commit search returned 100 results in an ascending date window and 100 in a descending date window. These windows contained 200 distinct commit records, five distinct session URLs, and covered 30 August through 11 November 2026.
- This is a verified minimum from the inspected search windows, not a proof that every matching commit or every type of AI-session reference has been enumerated.
- The current repository is private. This review does not establish whether the repository was public at an earlier time, whether any historical viewer retained a clone, or whether the referenced sessions can be opened by anyone other than the owning account.

### Required operational evidence

- The owner confirmed on 25 November 2026 that the referenced session URLs do not provide access. This records the owner's assurance, not an independently authenticated provider-side access test.
- Revoke or invalidate any session that is shared more broadly than intended, using the provider's supported controls.
- Preserve the findings and decide whether commit-history rewriting is warranted only after session access is addressed. Rewriting Git history does not revoke an AI session, and existing clones/forks may retain old commit metadata.
- Do not copy full session URLs or opaque session identifiers into issues, reports, logs or new commit messages.

## 4. Existing Supabase privilege finding

The separate live-privilege finding remains unresolved. Repository files cannot establish the current production grants/default privileges or effective PostgREST access. A privileged, read-only Supabase audit must compare:

- Grants and default privileges for `postgres`, `supabase_admin`, `anon` and `authenticated`.
- RLS status and policies on exposed tables and views.
- Storage bucket policies.
- Checked-in migration history against the live `supabase_migrations.schema_migrations` table.
- Supabase security-advisor findings and any explicit exceptions.

No live Supabase query was run for this report.

## 5. Triage order

1. **Credential verification and rotation:** historical database credential retirement is owner-confirmed; former mail-provider account closure is owner-confirmed; verify current Supabase service-key/signing-key rotation.
2. **Administrator account verification:** check the production application-user and Supabase Auth records and review historical auth/admin activity.
3. **AI-session access:** owner confirms the five known references do not provide access; retain the metadata review in the full-history publication scan.
4. **Supabase privilege audit:** complete the live grant/RLS/storage/migration review.
5. **Evidence-based closure:** record dates, provider-side confirmation and test results against the existing security issues. Do not mark a finding resolved merely because a file or code path was removed.

## 6. Limitations

This was a repository and Git-metadata review. It did not test credentials, attempt to authenticate as the historical administrator, query the production database, inspect Render environment values, inspect Supabase Auth users or logs, contact the former mail provider, open Claude sessions, or modify any provider setting. The next operational stage requires authorized provider-side access and explicit change approval.
