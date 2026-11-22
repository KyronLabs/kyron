# KyronLabs Engineering Governance

**Document status:** Proposed organisation-wide engineering standard  
**Applies to:** All KyronLabs repositories and contributors  
**Initial baseline:** 22 November 2026  
**Approval owner:** KyronLabs repository owner / engineering lead

## 1. Purpose

KyronLabs maintains several connected repositories with different audiences and risk profiles. This policy establishes how code, documentation, infrastructure, data schemas, secrets, releases and cross-repository contracts are changed and reviewed.

The objectives are:

- Protect users, production systems, intellectual property and internal operational information.
- Keep documentation aligned with implemented behavior.
- Make every production change traceable, reviewable and recoverable.
- Avoid unnecessary service/repository fragmentation.
- Make public contributions possible without exposing private implementation or sensitive operations.
- Ensure regulatory and financial decisions are not silently converted into code assumptions.

This document is an engineering policy proposal. It becomes binding when adopted by the organisation owner and reflected in repository settings and workflows.

## 2. Repository ownership and purpose

| Repository | Primary owner/domain | Visibility target | Change authority |
|---|---|---|---|
| `kyron` | Core product: Flutter, API, database and release workflows | Private | Core maintainers |
| `kyron-lenses` | Public lens catalogue/specification/test vectors | Public | Lens maintainers; format changes require app/studio compatibility |
| `kyron-lens-studio` | Desktop lens-authoring application | Private | Studio maintainers |
| `kyron-artwork` | Artwork catalogue, assets and provenance | Private or public only for explicitly cleared assets | Asset/catalogue maintainers |
| `design-system` | Design tokens and Flutter package | Private | Design-system maintainers; consuming app compatibility required |
| `kyron-links` | Read-only public sharing pages | Public | Links maintainers; API contract compatibility required |
| `kyron-live` | Live-streaming architecture and future implementation | Private | Core architecture + Trust & Safety + finance review |
| `Kyron-Incentives` | Gifts and future creator economy specifications | Private | Product, engineering, finance and compliance approval |
| `Kyron_Terms_and_Privacy` | Published legal pages | Public | Legal/policy owner; engineering handles publishing |
| `Global-Compliance` | Country/jurisdiction research and internal compliance decisions | Private | Compliance owner and qualified legal reviewers |
| `.github` | Organisation profile and shared GitHub configuration | Public | Organisation maintainers |

The owner may change visibility, but must update this table and review the repository's complete content/history before making private material public. A repository being private does not make it an appropriate place for plaintext credentials.

## 3. Architecture and service boundaries

### 3.1 Default architecture

Kyron's default architecture is a modular monolith:

- Flutter client(s).
- One NestJS/Fastify API.
- One PostgreSQL database.
- Supabase Auth and Storage.
- External integrations only where the product needs them.

A module is not a microservice. A directory named `media`, `identity`, `gateway` or `push` does not imply independent deployment.

### 3.2 When to split a service

A service extraction requires a written decision record covering:

1. The specific problem the split solves.
2. Independent deployment or scaling requirements.
3. Data ownership and consistency model.
4. Authentication and service-to-service authorization.
5. Network failure and retry behavior.
6. Observability, on-call ownership and incident response.
7. Hosting, bandwidth, storage and operational cost.
8. Migration and rollback strategy.
9. Security and privacy boundaries.
10. Why a module in the existing API is insufficient.

No service extraction is approved solely for repository tidiness or speculative future scale.

## 4. Branching and change management

### 4.1 Protected branches

For production repositories, `main` is the protected integration branch. Configure GitHub branch protection/rulesets to require:

- Pull requests for normal changes.
- Required CI checks.
- At least one independent review where more than one maintainer is available.
- Resolved review conversations.
- No force pushes or branch deletion.
- No direct commits containing secrets or production credentials.

For a solo-maintained repository, use a pull request even if the owner is the only reviewer; document the reason when an independent review is not possible.

### 4.2 Pull requests

Every non-trivial PR must include:

- What changed and why.
- User/system impact.
- Repositories and contracts affected.
- Database migration implications.
- Security/privacy implications.
- Tests executed and results.
- Deployment/configuration steps.
- Rollback or mitigation plan.
- Documentation updates.

A PR must not claim a test passed unless it actually ran and the run is available.

### 4.3 Commit messages

Use concise, descriptive commit messages. Do not put AI-session identifiers, private conversation links, customer/user data, credentials, internal incident details or sensitive legal context in commit subjects/bodies.

Suggested pattern:

```text
area: imperative summary

Why the change is needed.
Important compatibility or operational notes.
```

Examples:

```text
api: enforce staff second-factor requirement
app: preserve composer draft state on background
docs: reconcile current media pipeline architecture
```

### 4.4 Release tags

Use signed or otherwise authenticated release tags where practical. Main app release tags use the documented `vMAJOR.MINOR.PATCH` pattern. Do not rewrite or force-push release history. Release artifacts must be traceable to a commit and CI run.

## 5. Testing and quality gates

### 5.1 Main application

The main repository's documented local checks include:

```bash
cd app
flutter analyze
flutter test

cd ../api
npx tsc --noEmit
npx eslint src
npx jest
```

The actual required GitHub Actions checks must be read from the current workflow configuration and kept in sync with this list. Test totals in README/roadmap must come from the same source and must not be manually guessed.

### 5.2 Test layers

Changes should use the appropriate layers:

- Unit tests for deterministic business rules and pure functions.
- API/service tests for authorization, validation, idempotency and failure paths.
- Database integration tests for transactions, constraints, locking and migrations.
- Contract tests for cross-repository formats and API consumers.
- Widget/UI tests for client behavior and accessibility.
- End-to-end tests on representative devices for authentication, messaging, media, push, purchases and release-critical flows.
- Load tests for capacity-sensitive endpoints and media paths.

Financial ledger, payment, refund, payout and entitlement logic must have database-backed integration tests. Mock-only tests are not sufficient to prove transaction safety or idempotency.

### 5.3 Cross-repository contracts

- `kyron-lenses` format changes must update canonical format vectors and prove parity with the Flutter app and Lens Studio.
- `kyron-artwork` catalogue changes must pass asset, licence, dimensions and provenance checks.
- `design-system` changes must be tested by the package and consuming app; pin a known-good immutable ref for release reproducibility.
- `kyron-links` must remain compatible with the main API `/public/*` contract.
- `Kyron_Terms_and_Privacy` filenames and URLs consumed by the app are compatibility contracts.
- Incentives specifications must match the implementation in `kyron`.
- Compliance conclusions must map to server-enforced feature eligibility and published policy changes where applicable.

## 6. Database and migration governance

### 6.1 Ownership

- Prisma schema and migrations own API-managed relational schema.
- `supabase/migrations/` owns Supabase-specific SQL such as grants, RLS policies, functions and client-facing tables.
- A change spanning both systems must include both migration sets and an explicit execution order.
- No production schema change through an undocumented dashboard edit.

### 6.2 Migration requirements

Every migration must be:

- Version controlled.
- Reviewed for destructive operations and lock duration.
- Reproducible in a clean test database.
- Tested against a representative upgrade path.
- Compatible with the deployed application during rolling/redeploy transitions, or accompanied by a coordinated deployment plan.
- Accompanied by rollback/forward-repair instructions.

Prefer expand-and-contract changes: add compatible schema, deploy code that supports both forms, backfill, then remove obsolete schema in a later release.

Never run `prisma migrate reset`, `DROP SCHEMA`, destructive seed logic or equivalent against production as a routine deployment action.

### 6.3 Migration authority and deployment

The startup script now runs Prisma migrations with a bounded timeout and exits non-zero on migration failure; it never auto-baselines or starts the API after a failed migration. PrismaService also refuses application startup after its bounded database connection retries are exhausted. These controls are implemented on the startup-hardening branch and must be confirmed by CI and a staging deployment before being treated as deployed production behavior.

Until replaced with a fail-closed release process:

- Treat migration logs as a mandatory release verification.
- Do not declare a deployment healthy solely because the process starts or `/health` answers.
- Never run baseline resolution automatically during API startup. Do not run it manually unless the existing schema is proven to match the exact migration being marked applied, a verified backup exists, and the change has explicit operator approval.
- Require explicit approval for migration repairs.
- Preserve database backups and recovery instructions before risky schema changes.

### 6.4 Supabase security

- Enable and verify RLS on client-accessible tables.
- Review `anon` and `authenticated` grants after schema changes.
- Review default privileges for both `postgres` and `supabase_admin`.
- Run the Supabase security advisor after schema changes.
- Keep service-role credentials server-side only.
- Treat the anon key as public and rely on RLS/grants, not obscurity.
- Reconcile checked-in migrations with the live migration history before provisioning or resetting an environment.

## 7. Secrets and identity controls

### 7.1 Never commit

Do not commit:

- Production database URLs/passwords.
- Supabase service-role keys or JWT signing secrets.
- Firebase service-account private keys.
- Play service-account JSON.
- Android/iOS production signing private keys.
- OAuth client secrets.
- Webhook signing secrets.
- TOTP recovery material, user credentials or private keys.
- Private legal advice or confidential user information.

Use Render secret/environment configuration and GitHub Actions secrets or a dedicated secret manager. `.env.example` files must contain placeholders only.

### 7.2 Secret response

If a secret may have been exposed:

1. Treat it as compromised until proven otherwise.
2. Identify its owner, scope, privileges and last use.
3. Revoke/rotate it at the source.
4. Inspect relevant logs and access history.
5. Remove it from current files.
6. Decide whether history rewriting is warranted; do not confuse history rewriting with credential rotation.
7. Record the incident and evidence without copying the secret into the incident report.

### 7.3 Staff access

Staff privileges must be explicitly granted to real accounts, not created through a predictable default administrator seed. Privileged accounts must use mandatory second-factor authentication. Owner reports that Kyron staff 2FA is mandatory and has been personally tested for two weeks as of 22 November 2026.

Use least privilege for GitHub, Render, Supabase, Firebase and Play Console. Review access when a contributor's role changes or ends.

### 7.4 Signing keys

Development and production/private signing keys must remain isolated. Owner confirms this separation. Production release workflows must fail if required production signing secrets are absent and must never fall back to a development signing identity.

## 8. Security engineering

Every change must consider:

- Authentication and authorization.
- Input validation and output encoding.
- Rate limits and abuse controls.
- Data exposure and privacy.
- File upload and media decoder attack surface.
- Cryptographic key lifecycle and recovery.
- Logging of sensitive data.
- Dependency and supply-chain risk.
- Administrative access and auditability.
- Deletion, retention and backup behavior.

Security controls must be tested at the boundary where they are enforced. A hidden button is not authorization. A client-side country check is not jurisdiction enforcement. A documented 2FA feature is not proof of production enforcement unless the live setting and staff enrollment are verified.

## 9. Privacy, legal and compliance governance

- Public legal pages live in `Kyron_Terms_and_Privacy`.
- Internal country research and readiness decisions live in private `Global-Compliance`.
- Product implementation remains in `kyron`.
- Financial design and creator-economy specifications live in private `Kyron-Incentives`.

A regulatory matrix entry must record the jurisdiction, law/instrument, primary official source, relevant obligations, research confidence, product impact, implementation owner, unresolved questions, review date and legal sign-off status.

`researched` does not mean lawyer-approved. Engineering must not interpret an unverified matrix row as permission to activate a regulated feature.

No country-specific financial capability should be enabled solely because the app is distributed there. The server must enforce feature eligibility based on approved jurisdiction configuration.

## 10. API and client contracts

- API routes, DTOs, error shapes and auth requirements must be documented or discoverable from code.
- Breaking changes require compatibility planning for already-installed clients.
- Use additive changes where possible.
- Keep client and API release compatibility explicit.
- Do not silently change public link payloads, lens formats, legal URLs or financial event semantics.
- Version formats where independent consumers exist.

## 11. Observability and operations

Production services must provide:

- Structured logs with request/correlation IDs.
- Health checks that distinguish process availability from dependency/schema readiness.
- Metrics protected from public access.
- Error aggregation and alerting appropriate to service criticality.
- Deployment logs retained long enough for investigation.
- Backup and restore procedures tested on a schedule.
- Documented incident escalation and rollback.

Current API observability documentation describes request IDs, structured logs and a guarded `/metrics` endpoint, but also records that there are no traces, external error reporting, alerts or database/query metrics. These gaps must be addressed according to production criticality.

Never log access tokens, passwords, service-account JSON, recovery codes, message plaintext or unnecessary personal data.

## 12. Dependency and supply-chain management

- Commit lockfiles and use deterministic install commands in CI.
- Review major dependency upgrades and transitive/native build changes.
- Enable Dependabot or equivalent dependency update monitoring where appropriate.
- Run dependency vulnerability scanning.
- Pin production builds to known commits/tags and immutable package refs.
- Review third-party SDK permissions and data handling.
- Preserve software licences and attribution for fonts, artwork, SDKs and other assets.

## 13. Documentation standards

Every repository README must state:

- What the repository owns.
- What it does not own.
- Current implementation status.
- Runtime/deployment status.
- External dependencies and contracts.
- How to test and release.
- Security reporting route.
- Links to authoritative architecture/specification documents.

Every status claim must be dated or tied to a version/commit. Avoid permanent statements such as “fully secure”, “production-ready” or “complete”.

Architecture and roadmap documents must be checked against code and CI before release. Where documentation conflicts, the implementation and observed deployment are investigated; no document automatically outranks another.

## 14. Public repository publication checklist

Before making a repository public or publishing new material:

- Review current files and complete Git history for secrets.
- Review workflow logs, artifacts and release assets.
- Review issue/PR content for confidential details.
- Remove private AI-session references and internal identifiers.
- Check legal rights and licences for all assets.
- Check for internal hostnames, operational plans and unresolved compliance work.
- Confirm no private package or dependency references are unintentionally exposed.
- Rotate any credential that may have been present; deleting it is not enough.
- Obtain owner approval and record the publication decision.

The public/private boundary is intentional. Public source code and catalogues are not inherently unsafe, but every publication must be approved.

## 15. Release governance

A production release requires:

1. Approved scope and release owner.
2. Green required CI checks.
3. Database migration plan and successful migration evidence.
4. Security/privacy review for affected features.
5. Compatibility review for installed clients.
6. Required environment and signing secrets present.
7. Smoke tests on target platforms.
8. Monitoring and rollback/mitigation plan.
9. Store metadata, legal URLs and age/content declarations checked.
10. Release notes and traceable artifact/commit.

For financial features, add:
- Payment-provider approval and live-mode configuration review.
- Jurisdiction eligibility approval.
- Tax, refunds, chargebacks and dispute behavior.
- Ledger reconciliation and finance sign-off.
- KYC/AML/sanctions controls where required.
- Payout testing and operational support.
- Consumer disclosures and legal review.

## 16. Incident management

For a suspected security, privacy, financial or safety incident:

1. Protect users and contain ongoing harm.
2. Preserve logs and evidence.
3. Restrict access or disable the affected feature when necessary.
4. Rotate compromised credentials.
5. Identify scope, timeline and affected data.
6. Involve legal/compliance and relevant providers where required.
7. Meet applicable notification deadlines.
8. Document root cause and corrective actions.
9. Verify remediation before re-enabling the feature.

Do not delete evidence or rewrite Git history before the incident owner has decided what must be preserved.

## 17. Decision records

Material architectural or operational decisions should be recorded in an ADR:

```text
docs/decisions/NNNN-short-title.md
```

Each ADR should include:

- Status: proposed, accepted, rejected, superseded.
- Context and problem.
- Options considered.
- Decision and rationale.
- Consequences and trade-offs.
- Security, privacy, compliance and cost impact.
- Date and approver.
- Revisit trigger, if any.

Use ADRs for service extraction, database ownership, cryptography, payments, live streaming, data residency, major vendors and irreversible migrations.

## 18. Adoption plan

1. Confirm this policy with the organisation owner.
2. Configure branch protections and required checks on production-critical repositories.
3. Add consistent PR templates and security reporting instructions.
4. Reconcile CI workflow names and test totals with the current main branch.
5. Establish migration review and Supabase privilege checks.
6. Add secret scanning, dependency scanning and artifact provenance checks.
7. Record repository owners and maintainers.
8. Add release checklists to the main repository.
9. Review this policy quarterly and after material incidents or architecture changes.

## 19. Change history

| Date | Change |
|---|---|
| 22 November 2026 | Initial organisation-wide governance proposal based on repository review and owner-provided operational confirmations |
