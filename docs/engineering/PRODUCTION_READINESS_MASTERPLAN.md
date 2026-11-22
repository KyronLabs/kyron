# Kyron Production Readiness Masterplan

**Programme status:** Planning baseline — not a declaration of production readiness  
**Baseline date:** 22 November 2026  
**Product:** Kyron social platform  
**Organisation:** KyronLabs, a division of Spidroid Technologies  
**Primary implementation repository:** `KyronLabs/kyron`

## 1. Executive objective

Move Kyron from its current Google Play testing / pre-production state into a dependable, legally supportable, observable and commercially sustainable production platform.

Production readiness is not a single release toggle. It is the coordinated completion of:

- Product and platform readiness.
- Security and privacy controls.
- Reliable data/schema management.
- Trust and safety operations.
- Global legal and regulatory readiness.
- Production financial architecture, if and when monetisation is enabled.
- Support, incident response and business operations.
- Capacity, reliability and release discipline.

**Core principle:** Kyron may be distributed in a jurisdiction while a particular regulated feature remains disabled there. Platform availability, coin purchases, gifts, creator earnings, withdrawals and other financial capabilities must be independently eligible and server-enforced.

## 2. Current baseline

### 2.1 Product architecture

The main repository describes a Flutter client and a single NestJS/Fastify API backed by one Supabase PostgreSQL database, Supabase Auth and Supabase Storage. The API is deployed as a single Render instance. The system is a modular monolith, not a microservice architecture.

The current design includes:
- Accounts and onboarding through Supabase Auth/JWT.
- Ranked feed, posts, comments, profiles and search.
- Direct/group messaging and communities.
- Moderation/report/block/mute capabilities.
- Notifications, realtime and FCM push.
- Media upload and documented asynchronous video processing.
- AR lens support and external lens catalogue.
- Insights and account verification.
- A test gifts/coins economy.

### 2.2 Features not to represent as complete

Repository documentation identifies the following as not built or not production-complete:

- Live streaming: no live system deployed; architecture/vendor decision remains separate.
- Creator equity pool: not started and requires legal review.
- Production coin purchases and creator withdrawals: not implemented in the current test economy.
- Portable/federated identity: deliberately stopped at a verifiable account identifier; no portability/federation.
- Full E2EE guarantees: direct-message encryption exists but documented limitations remain, including no forward secrecy and attachments not encrypted end-to-end.
- Multi-instance API scaling: current realtime, rate-limit and metrics behavior is process-local.
- Full distributed tracing, external error reporting and alerting: observability documentation lists these as gaps.
- Web app: described as withdrawn; static routes redirect to download information.
- iOS push: Apple-side APNs/capability configuration remains documented as outstanding.

These statuses must be revalidated before each public release; this baseline is not a substitute for a fresh code audit.

### 2.3 Owner-confirmed controls

As of 22 November 2026, the owner reports:
- `Global-Compliance` has been made private.
- Staff second-factor authentication has been mandatory for two weeks and personally tested.
- Development and production/private signing keys are isolated.

These are accepted as owner-provided confirmations for planning. The 2FA setting should remain monitored in deployment configuration and tested after auth changes. Signing separation should remain a release gate.

### 2.4 Security findings still requiring closure

The recent read-only review reported:

- Historical hardcoded administrator credentials in an old seed script and compiled output. It remains unverified whether the account was created or used in production.
- Historical tracked environment file with a local database password and placeholder JWT secret. Reuse outside local development and credential rotation remain to be confirmed.
- Public Git history containing AI-session references. Accessibility and revocation status remain unverified.
- Supabase `supabase_admin` default privileges documented as broad for `anon` on newly created public-schema tables.
- The prior startup implementation could continue after migration failure or timeout. A fail-closed correction is now proposed on a dedicated branch; CI and staging deployment evidence are still required before closure.
- Development signing key intentionally present in source; owner confirms production/private key isolation.

Do not mark the historical administrator, database credential or AI-session findings closed without evidence. The owner-confirmed 2FA and key separation should not be unnecessarily reopened unless new evidence contradicts them.

## 3. Programme governance

### 3.1 Workstreams

| Workstream | Accountable function | Main repository/source |
|---|---|---|
| Core product and release engineering | Engineering | `kyron` |
| Security and infrastructure | Engineering/security | `kyron`, Render/Supabase configuration |
| Trust and Safety | Product, safety and legal | `kyron`, `Kyron_Terms_and_Privacy`, private compliance research |
| Global compliance | Compliance/legal | `Global-Compliance` |
| Creator economy and accounting | Product, finance, engineering, legal | `Kyron-Incentives`, `kyron` |
| Design and client experience | Product/design | `design-system`, `kyron` |
| AR ecosystem | Client/creative engineering | `kyron-lenses`, `kyron-lens-studio`, `kyron-artwork` |
| Sharing and acquisition | Product/web engineering | `kyron-links` |
| Live streaming | Product, safety, engineering, finance | `kyron-live` |

Each workstream needs a named owner before implementation starts. Where no qualified legal or finance owner exists, the relevant work remains a dependency rather than being treated as approved.

### 3.2 Status language

Use these statuses consistently:

- **Implemented:** present in code and covered by relevant tests.
- **Operationally verified:** tested in the actual target environment.
- **Partially implemented:** some code exists, but end-to-end requirements are incomplete.
- **Planned:** approved or proposed work not yet implemented.
- **Blocked:** cannot proceed until a named dependency is resolved.
- **Not applicable:** explicitly excluded, with rationale.

“Documented”, “researched” and “implemented” are not synonyms. A researched legal row is not legal approval; a passing unit test is not production verification.

## 4. Phase 0 — Close security and architecture baseline

**Objective:** Remove unresolved high-risk uncertainty and make the production system's actual state reproducible.

### 0.1 Historical administrator investigation — P0

- Determine whether the historical seeded administrator account exists in production or ever existed.
- Preserve relevant authentication and administrative audit logs.
- Determine last authentication and privileged actions.
- If the account exists, disable access during investigation, revoke sessions, rotate credentials and inspect activity.
- Record evidence and closure decision.

**Exit evidence:** A documented finding backed by production database/authentication/audit evidence. No unverified assumption that code removal means account removal.

### 0.2 Historical database credential investigation — P1

- Recover the historical file securely in a controlled environment.
- Identify the exact credential scope without copying the secret into reports.
- Determine whether it was reused in Render, Supabase, local environments or other systems.
- Rotate any credential that was reused or cannot be confidently ruled out.
- Review access logs where available.

**Exit evidence:** Credential ownership, reuse assessment, rotation evidence and access-log review.

### 0.3 AI-session reference review — P1

- Enumerate all public historical references.
- Determine what each identifier resolves to and its access model.
- Revoke/invalidate where supported.
- Remove references from current public-facing material.
- Decide whether history rewrite is warranted after evidence preservation.

**Exit evidence:** Each reference classified as inaccessible, revoked or mitigated; no unsupported claim that a reference exposed a session.

### 0.4 Supabase privileges — P1/P2

- Pull the live schema and migration history.
- Reconcile `supabase/migrations/` with `supabase_migrations.schema_migrations`.
- Inspect grants/default privileges for `postgres`, `supabase_admin`, `anon` and `authenticated`.
- Test PostgREST access for all tables and views.
- Verify RLS policies and storage bucket policies.
- Restrict dashboard-created schema changes; make migrations the standard path.

**Exit evidence:** A tested privilege matrix and clean security-advisor review, with documented exceptions.

### 0.5 Deployment migration safety — P0

- Review `api/scripts/start.sh` and the Render deploy model.
- Remove unverified automatic baseline resolution from the normal deployment path. (Implemented on the startup-hardening branch; verify CI and staging.)
- Ensure migration failure or timeout fails the release/deployment gate. (Implemented on the startup-hardening branch; verify CI and staging.)
- Make API startup fail when Postgres remains unreachable after bounded retries. (Implemented on the startup-hardening branch; verify CI and staging.)
- Add a schema-version/readiness check that distinguishes DB reachability from migration currency.
- Prove baseline correctness before any migration is marked applied.
- Test backup and restore before risky migrations.

**Exit evidence:** Passing CI tests for migration success/failure/timeout and database-connectivity failure; a staging deploy with successful migration; a deliberate migration-failure deployment that never serves traffic; clear platform failure status; and a documented, rehearsed recovery. The branch changes alone do not close this gate.

### 0.6 Architecture/documentation reconciliation

- Replace stale `ARCHITECTURE.md` claims, particularly media transcoding and module/controller counts.
- Reconcile README, ROADMAP and folder guide test totals against current CI.
- Update cross-repository inventory and dependency ownership.
- Record platform status (Android, Windows, iOS, web) without inferring readiness from folders.

**Exit evidence:** The three engineering documents in this directory plus updated links/status references in the main README.

## 5. Phase 1 — Production engineering foundation

**Objective:** Make routine changes safe and releases reproducible.

### 1.1 CI and repository governance

- Establish protected `main` branches and required checks.
- Require PR descriptions with testing, migration, security and rollback details.
- Ensure lockfiles and deterministic dependency installation.
- Add secret scanning and dependency vulnerability scanning.
- Add static analysis and build checks for each supported platform.
- Generate authoritative test counts from CI; remove contradictory manual counts.
- Add code-owner/reviewer requirements for financial, auth, schema and security-sensitive paths.
- Ensure release artifacts map to commit SHA, tag and workflow run.

### 1.2 Database governance

- Declare Prisma and Supabase migration ownership.
- Add clean-database migration tests.
- Add upgrade-path tests for representative existing schema versions.
- Add migration linting/review for destructive statements and lock risks.
- Use expand-and-contract migrations.
- Add post-migration grant/RLS checks.
- Maintain a tested backup/restore procedure.

### 1.3 Deployment and configuration

- Confirm Render service identity/runtime before applying `render.yaml`.
- Inventory required and optional environment variables without exporting their values into docs.
- Add environment validation and fail-closed behavior for production-critical configuration.
- Ensure staging and production use separate databases, auth projects, storage and credentials.
- Verify CORS, trusted proxy configuration, rate limits, metrics access and health checks.
- Add explicit release approval and rollback instructions.

### 1.4 Observability and operations

Current docs describe structured request logs, request IDs and protected `/metrics`, but also list no traces, no external error reporting, no alerting and limited database/query metrics.

Deliver:
- External error aggregation with privacy-safe payload filtering.
- Alerts for API availability, elevated 5xx/429 rates, migration failure, database availability, push failures, media-job backlog and storage failures.
- Database connection/pool and query latency visibility.
- Client crash/error reporting with appropriate consent/privacy controls.
- Deployment and incident dashboards.
- On-call/contact and escalation runbook.
- Tested restore and recovery drills.

### 1.5 Scaling gate

Do not add API instances until:
- Realtime delivery is shared across instances.
- Rate limiting uses a shared store or a documented edge-level equivalent.
- Metrics are aggregated or scraped per instance correctly.
- Media job claiming and retries are safe across workers.
- Database pool limits and connection behavior are load-tested.
- Session/auth behavior is consistent across instances.

Redis is not an active shared layer today merely because it appears in configuration/dependencies.

## 6. Phase 2 — Trust, safety and platform compliance

**Objective:** Ensure Kyron can safely operate as a 13+ social platform across the jurisdictions it chooses to serve.

This phase runs in parallel with engineering foundations, but feature launch decisions must be blocked on required legal/safety approvals.

### 2.1 Platform safety baseline

- Maintain clear community standards and prohibited-content rules.
- Provide accessible report, block and mute flows.
- Establish moderation queues, escalation, evidence handling and response SLAs.
- Define repeat-offender, account suspension, ban and appeal processes.
- Establish procedures for imminent threats, exploitation and child-safety reports.
- Document content preservation, lawful disclosure and data-retention controls.
- Train and authorize staff; require 2FA for privileged tools.
- Test safety flows end-to-end, including signed-out reporting where promised.

### 2.2 Age and child safety

Kyron is a 13+ platform, but a 13+ store rating does not by itself satisfy every age-assurance or child-safety obligation.

Assess:
- Minimum-age requirements by jurisdiction.
- Age assurance and age estimation/verification requirements.
- Parental consent where applicable.
- Child-directed service definitions and mixed-audience treatment.
- Data minimisation and profiling restrictions for minors.
- Default privacy/safety settings for younger users.
- Direct messaging, discovery, location and recommendation protections.
- Advertising/monetisation restrictions for minors.
- Reporting, escalation and regulator/law-enforcement obligations.

Do not introduce age verification that collects more sensitive data than necessary. The method and vendor require privacy, security and legal review.

### 2.3 Global compliance repository

`Global-Compliance` is now private according to the owner. Keep it as the internal source for jurisdiction research; keep user-facing legal pages in `Kyron_Terms_and_Privacy`.

For every jurisdiction, track:
- Official jurisdiction and country/region identifiers.
- Applicable laws and effective dates.
- Primary regulator/official source links and exact citations.
- Applicability rationale for Kyron's actual model.
- Required notices, processes, registrations, representatives or licences.
- Age assurance, privacy, content, consumer, payments and tax implications.
- Product/API changes required.
- Feature-specific go/no-go status.
- Legal reviewer, review date and next review trigger.
- Unresolved questions and evidence required.

The repository README reports a Google Play target set of 177 named countries/regions plus the Rest of World bucket. That is a distribution fact, not proof that every feature may lawfully operate in every market.

### 2.4 Feature-level jurisdiction controls

The API must enforce eligibility server-side. Maintain a versioned policy/configuration model capable of distinguishing at least:

- App distribution/platform access.
- Account creation and age-related access.
- Coin purchase.
- Gift sending.
- Creator earnings accrual.
- Creator withdrawal/payout.
- KYC/identity verification.
- Tax collection/reporting.
- Live streaming.
- Other regulated or restricted capabilities.

A feature should be disabled by default in a jurisdiction until required review and operational controls are complete. Store the policy version and decision reason for auditability. Client-side hiding is supplementary only.

## 7. Phase 3 — Production financial and creator economy architecture

**Objective:** Replace the experimental coin economy with a legally reviewed, auditable, reconcilable financial system before enabling real-money features.

### 3.1 Current test-economy boundary

The coin system has moved beyond the original test-economy assumptions:
- The former 100-coin Monday wallet top-up is retired. Existing unspent weekly
  grants remain as grandfathered `legacyComplimentary` balances and are never
  automatically replenished.
- New promotional coin grants are issued only through staff-approved post
  excellence reward programmes.
- Creator proceeds funded by approved reward coins are withdrawable on the
  same terms as purchased-coin proceeds. `REWARD_EARN` and `PURCHASE_EARN`
  both contribute to `withdrawableEarned`; the separate kinds retain source
  attribution for reconciliation, not different creator treatment.
- Proceeds funded by the grandfathered weekly complimentary balance remain
  separately classified as `PROMOTIONAL_EARN` and are not withdrawable.
- Historic `EARN` rows have unknown test-era provenance and must never be
  treated as payout-eligible.
- No coin-purchase or payout path is enabled by this rewards change.
- Gifts remain implemented in the main app/API.

This is still not a complete production financial ledger. Do not simply turn
on purchases or payouts: first settle the coin's legal/commercial meaning,
purchase evidence, liabilities, reconciliation, consumer disclosures and
jurisdiction-specific requirements.

### 3.2 Financial design decisions required

Before implementation, settle and document:

- What a coin represents legally and commercially.
- Whether coins are purchased, promotional, earned, non-transferable or redeemable.
- Whether creator balances are monetary claims, contractual receivables, rewards or another structure.
- Whether gifts are digital goods, tips, donations or another legal category.
- Who is merchant of record and who contracts with creators.
- How platform fees, app-store fees, taxes, payment fees and payout costs are calculated.
- Refund, cancellation, chargeback, fraud and negative-balance handling.
- Country-specific restrictions and consumer disclosures.
- Expiration, dormant balances, account closure and unclaimed funds.
- Minor eligibility and restrictions on monetisation.
- Currency conversion and exchange-rate source/time.
- Reconciliation and dispute resolution.

Do not assume a Google Play service fee is automatically deducted from every creator gift or that a proposed split is approved. Validate the exact Play billing policy, product classification, payment flow and commercial agreements for each relevant transaction type.

### 3.3 Target financial architecture

The production design should include:

1. **Payment orchestration:** provider/store purchase verification, idempotency, refunds and chargebacks.
2. **Immutable double-entry ledger:** balanced postings, account types, currencies, source references and reversal entries.
3. **Wallet/read model:** derived or materialized balance with reconciliation against the ledger.
4. **Creator payable ledger:** clear distinction between pending, available, reserved, paid, reversed and disputed amounts.
5. **Payout orchestration:** provider integration, eligibility, KYC, tax information, payout status and failure handling.
6. **Reconciliation:** compare store/provider reports, internal ledger and bank/payout records.
7. **Fraud/risk controls:** velocity, device/account signals, collusion, self-gifting, refund abuse and suspicious payout patterns.
8. **Jurisdiction engine:** feature eligibility and policy version.
9. **Audit trail:** immutable actor/action/time/source history with appropriate retention.
10. **Admin controls:** dual control for high-risk adjustments, limits, payout holds and emergency disablement.

A ledger must never be “fixed” by editing old entries. Correct errors through explicit compensating/reversal entries, with actor, reason and reference.

### 3.4 Financial test and release gates

Before a real-money pilot:
- Independent accounting and legal review.
- Provider/store sandbox integration tests.
- Duplicate webhook and replay tests.
- Concurrent purchase/gift/payout tests.
- Refund and chargeback simulations.
- Negative-balance and reversal tests.
- Ledger invariant and reconciliation tests.
- KYC/payout failure and retry tests.
- Currency precision and rounding tests.
- Tax calculations and reporting validation.
- Security review and fraud tabletop.
- Jurisdiction allow-list approval.
- Customer support and dispute runbooks.

Launch one approved jurisdiction/provider combination first. Expand only after reconciliation and operational metrics remain within defined thresholds.

## 8. Phase 4 — Feature completion and production experience

Prioritise existing features and reliability before adding expensive new systems.

### 4.1 Media

- Verify ffmpeg availability and actual production job completion.
- Monitor queue age, retries, failed jobs and storage usage.
- Validate file type, dimensions, pixel count, duration and upload limits.
- Add cleanup/retention behavior for orphaned media and failed uploads.
- Test abusive/hostile media and decoder limits.

### 4.2 Messaging and cryptography

- Document exact encryption scope and threat model.
- Address forward secrecy and key rotation design.
- Encrypt attachments end-to-end or clearly disclose their different protection model.
- Review multi-device recovery and device revocation.
- Conduct independent cryptographic design/code review before claiming stronger guarantees.
- Test block/report, deletion, backups and notification metadata for privacy leakage.

### 4.3 AR and creator tooling

- Keep the public lens format and canonical test vectors synchronized with the app and studio.
- Validate downloaded assets, size limits, HTTPS and provenance.
- Test performance and thermal behavior on representative lower-end Android devices.
- Do not execute remote lens code; preserve the data-only format boundary.

### 4.4 Live streaming

Live remains a separate decision programme. Before implementation:
- Decide broadcast vs interactive model.
- Select vendor based on real usage/cost assumptions.
- Model bandwidth, concurrent viewers, recording and egress.
- Design live moderation, abuse reporting, stream interruption and evidence preservation.
- Define age restrictions, consent, safety staffing and emergency controls.
- Obtain legal and finance approval.
- Run a limited technical pilot before general availability.

No live-streaming launch should precede a workable real-time safety operation.

## 9. Phase 5 — Production validation and launch

### 5.1 Release candidate

A release candidate must have:
- A fixed commit and version.
- All required CI green.
- No unresolved P0 security issues.
- P1 issues either closed or formally risk-accepted with owner and expiry.
- Verified production migration and rollback plan.
- Verified staff 2FA and privileged access.
- Production signing path verified.
- Store metadata, age rating, data safety and legal URLs reviewed.
- Crash/error/availability monitoring active.
- Moderation and support staffing ready.
- Backup/restore evidence.
- Load and soak tests representative of expected launch traffic.

### 5.2 Staged rollout

Recommended rollout sequence:
1. Internal production smoke test.
2. Small controlled production cohort.
3. Limited country/market rollout for the approved feature set.
4. Monitor crash-free sessions, API errors, latency, signup, media, push, moderation load and support tickets.
5. Expand rollout only when thresholds remain healthy.
6. Keep regulated financial features disabled until their separate approvals are complete.

Do not use “global launch” to mean “all features active in all countries”.

### 5.3 Rollback and emergency controls

Maintain:
- Ability to halt rollout.
- Ability to disable individual features server-side.
- Ability to disable purchases, gifts, payouts or live streaming independently.
- A safe API/client compatibility rollback.
- Database forward-repair instructions.
- Provider/store escalation contacts.
- Incident communications templates.

A database rollback is not always safe after writes have occurred. Prefer tested forward fixes and compatible application rollbacks.

## 10. Programme milestone table

| Milestone | Deliverable | Exit condition |
|---|---|---|
| M0 — Security closure | Historical admin, database credential, AI-session and Supabase findings resolved or formally risk-accepted | Evidence recorded; no unresolved critical exposure |
| M1 — Engineering baseline | Architecture, governance and masterplan adopted; CI/repo rules established | Documents match code; required checks enforced |
| M2 — Data/deployment safety | Migration and backup/restore process hardened | Failed migration cannot masquerade as healthy release |
| M3 — Trust and safety readiness | Moderation, child safety, incident and privacy processes tested | Operational owner, SLAs and escalation path exist |
| M4 — Jurisdiction readiness | Country matrix and feature-level approval system | Launch jurisdictions approved for each enabled feature |
| M5 — Financial architecture | Ledger, payments, payout and reconciliation design approved | Legal, finance, engineering and security sign-off |
| M6 — Financial pilot | One controlled provider/jurisdiction integration | End-to-end sandbox and pilot reconciliation pass |
| M7 — Release candidate | Platform, reliability, security, store and support gates pass | Formal release approval |
| M8 — Controlled launch | Staged production rollout | Monitoring and support thresholds stable |
| M9 — Expansion | Additional markets/features | Separate approvals and measured readiness |

## 11. Priority order

### Immediate blockers

1. Verify whether the historical administrator account ever existed or was used in production.
2. Determine whether historical database credentials were reused and rotate where needed.
3. Resolve the public AI-session reference findings.
4. Correct Supabase default privileges and reconcile live migration history.
5. Harden deployment so failed migrations cannot silently proceed as a healthy release.
6. Reconcile stale architecture and test-count documentation.

### Next engineering work

7. Establish branch protections, required CI, secret/dependency scanning and release provenance.
8. Add external error reporting and actionable alerts.
9. Test backups/restores and production incident procedures.
10. Establish API scaling gates and capacity thresholds.

### Parallel business/compliance work

11. Build the country-by-country legal research and approval register.
12. Complete child safety, age assurance, content moderation and privacy reviews.
13. Define feature-level jurisdiction controls.
14. Obtain qualified legal/accounting advice on the proposed creator economy.
15. Design and test the production ledger before payment integration.

## 12. Key performance and reliability measures

Set numerical SLOs only after collecting representative production measurements. Track at minimum:

- API availability and error rate.
- p50/p95/p99 latency by critical route.
- Authentication and signup success rate.
- Feed load and post creation success.
- Media upload completion, processing backlog and failure rate.
- Realtime connection and delivery success.
- Push delivery failure rate.
- Database availability, pool saturation and query latency.
- App crash-free users/sessions and startup time.
- Moderation report age, time to first action and urgent escalation time.
- Payment verification, ledger posting, reconciliation variance and payout success once enabled.
- Cost per active user and media/storage/egress cost.

The existing load-test numbers are lower-bound measurements from a colocated API/database test environment and must not be treated as production SLOs. Re-run from a realistic network and production-like data profile.

## 13. Risks and dependencies

| Risk | Consequence | Mitigation |
|---|---|---|
| Historical admin credential was used | Unauthorized administrative access | Production DB/auth/audit investigation and session revocation |
| Old DB credential reused | Unauthorized database access | Credential reuse assessment, rotation and log review |
| Supabase default privileges remain broad | New tables may be exposed through public roles | Restrict defaults, test grants/RLS, migration-only schema changes |
| Migration failure starts old-schema API | Partial outage or inconsistent behavior | Fail-closed release gate and schema readiness |
| Process-local realtime/rate limit | Incorrect behavior under multiple instances | Shared coordination before horizontal scaling |
| Incomplete compliance research | Regulatory enforcement, fines or forced withdrawal | Primary-source research and qualified counsel |
| Creator economy misclassified | Payment, stored-value, tax or licensing exposure | Legal/accounting classification before money flow |
| Weak moderation operation | User harm and regulatory exposure | Staffing, tooling, SLAs and tested escalation |
| Encryption claims exceed actual scope | User trust and security risk | Accurate threat model and independent review |
| Documentation drift | Incorrect release decisions | Dated evidence and code/CI review |

## 14. Decisions required from leadership

These decisions should be recorded explicitly rather than buried in implementation:

- Initial production launch countries and excluded markets.
- Which features are enabled at launch in each market.
- Whether purchases/gifts/payouts launch later than the core social platform.
- Creator compensation model and platform fee basis.
- Payment provider and merchant-of-record model.
- Payout provider and eligible creator countries.
- Age assurance approach and data minimisation.
- Moderation staffing and operating hours.
- Live-streaming product model and whether it is in launch scope.
- Production support and incident ownership.
- Acceptable capacity, availability and cost thresholds.

## 15. Review cadence

- Weekly during active release preparation: security, blockers, migrations, deployment and CI.
- Monthly: compliance changes, platform policies, moderation trends, dependency risk and cost.
- Quarterly: architecture, access permissions, backups/restores, incident tabletop and this masterplan.
- After every major incident or regulatory change: immediate targeted review.

## 16. Definition of production-ready

Kyron is production-ready only when:

1. The deployed system matches the documented architecture.
2. No unresolved critical security exposure remains.
3. Database migrations are controlled, observable and recoverable.
4. Auth, privileged access and signing controls are verified.
5. Core user journeys work on every platform actually being launched.
6. Trust and safety operations are staffed and tested.
7. Legal pages and store disclosures match actual product behavior.
8. Every enabled jurisdiction/feature combination has documented approval.
9. Financial features, if enabled, have approved accounting, legal, provider and reconciliation controls.
10. Monitoring, incident response, support and recovery procedures are operational.
11. Rollout and independent feature-disable controls have been tested.
12. Production performance and cost are measured against agreed thresholds.

A successful Play Store production-access approval is an important distribution milestone. It is not, by itself, evidence that all of these production-readiness conditions have been met.
