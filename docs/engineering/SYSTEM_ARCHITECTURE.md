# Kyron System Architecture

**Document status:** Engineering baseline — implementation-oriented, not a target-state proposal  
**Repository:** `KyronLabs/kyron`  
**Baseline reviewed:** 22 November 2026  
**Review method:** Read-only inspection of the default branch, repository documentation, application/API configuration, deployment files and selected cross-repository READMEs.

> **Accuracy rule:** This document distinguishes what repository evidence says is implemented from what is planned, partially implemented, externally configured or still unverified. It does not certify the live production environment. Where the code, documentation and deployment dashboard may differ, the discrepancy is recorded rather than guessed away.

## 1. Executive summary

Kyron is currently structured as a **modular monolith**, not a microservice system:

- A Flutter application is the primary user-facing client.
- A single NestJS API runs on Fastify.
- Prisma is the API's principal database access layer.
- One PostgreSQL database is hosted by Supabase.
- Supabase Auth issues user access tokens; the API verifies JWTs against the Supabase JWKS endpoint.
- Supabase Storage holds uploaded media.
- The API also owns realtime WebSocket connections, push orchestration, media processing jobs and request-level observability.
- The API is deployed as a single Render service. The marketing/download site is a separate static Render service described by `render.yaml`.
- `kyron-links` is a separate read-only link-rendering service that consumes public API endpoints and does not connect directly to the database.

The system's current scaling model is deliberately simple: one API process and one database. Redis is present in configuration/dependencies but is not currently used by application source. Several capabilities are process-local and therefore prevent safe horizontal scaling without additional coordination.

## 2. System context

```text
                       ┌───────────────────────────────┐
                       │         Kyron users            │
                       │       Android / Windows        │
                       │       iOS: build status         │
                       └───────────────┬───────────────┘
                                       │
                            HTTPS / JSON / WebSocket
                                       │
                         ┌─────────────▼─────────────┐
                         │       Kyron API           │
                         │   NestJS + Fastify        │
                         │   One Render instance     │
                         └──────┬───────────┬────────┘
                                │           │
                         Prisma │           │ Supabase SDK / Storage
                                │           │
                    ┌───────────▼───┐   ┌───▼─────────────────┐
                    │ Supabase      │   │ Supabase Storage    │
                    │ PostgreSQL    │   │ public/private media│
                    │ one database  │   └─────────────────────┘
                    └───────────────┘
                                ▲
                                │ Auth JWT / JWKS verification
                         ┌──────┴──────────┐
                         │ Supabase Auth   │
                         └─────────────────┘

  External/supporting systems:
  - Firebase Cloud Messaging: push delivery
  - kyron-links: read-only public pages; calls API /public/* routes
  - kyron-lenses: public lens catalogue via GitHub Pages
  - kyron-artwork: public artwork catalogue via GitHub Pages
  - design-system: Flutter package consumed from Git ref
  - Kyron_Terms_and_Privacy: published legal pages
  - Render: API and static web/download hosting
  - GitHub Actions: CI, builds, versioned release workflows
```

The diagram describes repository-documented integration points. Exact production hostnames, active environment values, service health and third-party account configuration must be confirmed in their respective dashboards.

## 3. Client application

### 3.1 Technology and responsibilities

The client lives in `app/` and is a Flutter application. The inspected `app/pubspec.yaml` declares:

- Flutter/Dart SDK constraint `>=3.0.0 <4.0.0`.
- Riverpod for application state.
- Dio and `http` for network communication.
- Supabase Flutter SDK for Supabase-facing client functionality.
- `web_socket_channel` for WebSocket communication.
- `flutter_secure_storage` for protected local storage.
- Firebase Core and Firebase Messaging for push registration/delivery.
- Google Sign-In.
- `cryptography` for client-side cryptographic functionality.
- Camera and MediaPipe face mesh dependencies for AR.
- `video_player`, `record`, `just_audio`, image and media-related packages.
- The `kyron_design_system` Flutter package, consumed from the `main` Git ref of `KyronLabs/design-system`.

The client contains screens, Riverpod providers, repositories, models, services, widgets and route definitions. The current folder guide is `FOLDER_STRUCTURE.md`; it should be treated as a guide, not as a substitute for inspecting the current tree.

### 3.2 Platform status

The repository README describes Android and Windows as the platforms currently being shipped. It also describes a web client as withdrawn pending further notice. The push documentation says Android and iOS support paths exist, but iOS still requires Apple-side APNs and capability configuration. Do not infer that iOS or web is production-ready merely because platform folders or dependencies exist.

Before each release, record the exact platform, build mode, signing identity, store track and smoke-test evidence.

### 3.3 Release versioning and signing

The README documents a version in `app/pubspec.yaml` using `MAJOR.MINOR.PATCH+BUILD`, with GitHub Actions deriving build numbers from repository history. Versioned release workflows use tags of the form `vX.Y.Z`.

Repository documentation describes separate development and release signing paths. The owner has separately confirmed that development and production/private signing keys are isolated. The production release process must continue to require dedicated GitHub Actions secrets and must never fall back to a development key.

The release workflow's exact current YAML and its latest successful run should be rechecked before changing release procedures.

## 4. API application

### 4.1 Runtime and framework

The API lives in `api/` and uses:

- NestJS 11.
- Fastify 5 through `@nestjs/platform-fastify`.
- Prisma 6 with PostgreSQL.
- Supabase JS SDK.
- WebSocket support through Nest's platform WebSocket adapter.
- Fastify Helmet, multipart and rate-limit plugins.
- class-validator/class-transformer through a global `ValidationPipe`.
- Jest, TypeScript, ESLint and Supertest in the development/test toolchain.

`api/src/main.ts` configures Fastify, security headers, multipart limits, rate limiting, CORS, request logging, metrics, DTO validation and the WebSocket adapter. The server binds to `0.0.0.0` and the configured port.

### 4.2 Module composition

`api/src/app.module.ts` imports the following modules:

- Configuration and observability
- Prisma infrastructure
- Common shared functionality
- Identity
- Media
- Feed
- Messages
- Notifications
- Communities
- Moderation
- Gateway
- Realtime
- Push
- Keys
- Profile
- Links
- Feedback
- Insights
- Account
- Verification
- Gifts
- Public

These are modules within one API process. They are not independently deployed services. Names such as `media`, `identity` or `gateway` must not be represented as separate services unless an actual independently deployed runtime is introduced.

### 4.3 Authentication and authorization

Repository architecture documentation describes this flow:

1. The client signs in through Supabase Auth.
2. Supabase issues a JWT.
3. The client sends the JWT as a bearer token to the API.
4. The API's authentication guard verifies the JWT signature against Supabase JWKS, including issuer and expiry checks.
5. The token subject is resolved to the corresponding Kyron `User` record.
6. API guards and application-level authorization determine access to protected operations.

The Prisma `User` model is an application-side identity/profile record; Supabase Auth remains the credential issuer. Do not treat a local password field or legacy authentication code as the authoritative credential store without checking the current implementation.

Staff TOTP/second-factor enforcement is mandatory in the production environment according to the owner, who reports that it has been enabled and personally tested for two weeks. The code logs the setting at startup. This is an owner-confirmed operational control, not a claim independently verified through Render in this review.

### 4.4 HTTP and request controls

The inspected bootstrap configures:

- Helmet security headers.
- Multipart upload limits, with the file-size limit sourced from `MediaService.maxBytes`.
- Rate limiting with validated configuration and account-aware/address fallback buckets.
- CORS from `CORS_ORIGIN`.
- A global validation pipe with `whitelist` and transformation enabled.
- Request IDs, structured request logs and a guarded metrics endpoint.
- WebSocket support on the API's HTTP server.

Production CORS must be explicitly configured and tested against the real client/service origins. The development fallback must not be mistaken for a production allow-list.

## 5. Data and persistence

### 5.1 PostgreSQL and Prisma

The primary relational database is PostgreSQL hosted by Supabase. The API's Prisma schema is at `api/prisma/schema.prisma`; Prisma migrations are in `api/prisma/migrations/`.

Prisma is the schema owner for API-managed tables. The repository documentation describes one shared database, not one database per module or service.

The Prisma schema currently contains the main social product's user, profile, content, messaging, community, moderation, gift and related records. The exact model/table count should be generated from the checked-out schema when this document is revised; older repository documents cite different counts and should not be repeated without a fresh count.

### 5.2 Supabase-managed SQL

`supabase/migrations/` contains SQL for Supabase-specific concerns and tables read directly by the client, including profile/interests-related tables, RLS policies and grants.

The inspected `supabase/README.md` explicitly warns that the checked-in migration directory is **not a complete historical migration record**: earlier migrations exist only in `supabase_migrations.schema_migrations`, and it recommends pulling the live schema before treating the directory as complete.

It also documents a residual default-privilege caveat: `supabase_admin` has broad default privileges for `anon` on new public-schema tables, while Prisma-created tables use a different owner/default-privilege path. The operational rule is therefore:

- Do not create production tables ad hoc through the Supabase dashboard.
- Make schema changes through reviewed, version-controlled migrations.
- Audit grants, RLS and PostgREST exposure after every schema change.
- Reconcile the checked-in SQL history with the live project's migration history before a fresh environment or migration reset is attempted.

This is a production-readiness issue, not a theoretical documentation note.

### 5.3 Account deletion and retention

The API package exposes an account deletion script. The exact deletion behavior, retention exceptions, audit-log handling, backup expiry and financial-record retention requirements must be specified and tested before production monetisation. Financial records, if introduced, must not inherit test-wallet cascade-deletion behavior without legal/accounting review.

## 6. Media and storage

### 6.1 Upload path

The repository architecture and media documentation describe the API as the upload boundary:

1. The client selects/captures media.
2. The client uploads to the API.
3. The API validates the file using content/type and size checks.
4. The API stores the object in Supabase Storage.
5. The API returns a URL/reference that is stored with the post or message.

Supabase Storage contains media buckets documented as `kyron-media` and `kyron-private`. Bucket limits and accepted types must remain aligned with API-side validation.

### 6.2 Video processing

The current roadmap and media-job documentation describe video processing as implemented in the API: video can be probed, re-encoded to H.264 when it exceeds specified quality/bitrate conditions, given a poster image, and processed asynchronously through a database-backed job record. The roadmap describes a five-minute duration refusal and an optional ffmpeg capability; if ffmpeg is unavailable, the original file is retained and the API reports that state.

The older `ARCHITECTURE.md` says there is no transcoding or server-side thumbnail generation. That statement is stale relative to the later roadmap and README and must be corrected. The live production deployment must still be checked for ffmpeg availability and successful job completion.

The `media/` directory is documented as a placeholder, not a separate deployed media microservice.

## 7. Realtime and notifications

### 7.1 Realtime

The API hosts an authenticated WebSocket endpoint in the same process as HTTP. The roadmap and observability documentation describe realtime connections as process-local.

This is sufficient only under the current one-instance deployment assumption. A multi-instance deployment would need shared pub/sub or another routing mechanism so an event produced on one instance reaches clients connected to another.

### 7.2 Push

The documented push path uses Firebase Cloud Messaging (FCM):

- Client registers device tokens with the API.
- API stores device tokens.
- Delivery logic emits realtime events when applicable and sends push notifications through FCM.
- The API uses a Firebase service-account credential supplied through Render configuration or a secret file.
- The repository documents `GET /health` as reporting whether push is configured.

The service-account key must remain a deployment secret and must never be committed. Android and iOS support are not equivalent: the push documentation identifies additional Apple-side APNs/capability work before iOS push is fully active.

### 7.3 Notifications

The architecture documentation describes notifications as derived from underlying activity rather than maintained in a separate fan-out table. Read state uses a per-account watermark. Verify current query behavior and privacy filtering whenever notification types are added.

## 8. Messaging and cryptography

The roadmap and messaging documentation describe one-to-one and group messaging features, including attachments, read state, mute, block, report and deletion. The repository claims direct-message encryption and reports testing between two phones in closed testing.

The current cryptographic design must be described with its limitations. The roadmap identifies X25519 per-install keys and XChaCha20-Poly1305 message encryption, but also records limitations including no forward secrecy and attachments that are not encrypted end-to-end. New-device history recovery and key-vault work must be treated according to implementation status, not design prose alone.

No production security claim should imply that all message metadata, attachments, backups or server-side routing are end-to-end encrypted unless that scope is independently verified.

## 9. Feed and discovery

The feed is ranked by application logic in the API, not by a vector database or an external recommendation service. The architecture documentation describes a bounded candidate set and stable cursor/session ranking. The roadmap describes signals including interests, follows, likes, reading/dwell behavior, negative feedback and recency.

The feed is not documented as using Pinecone, ANN search or an embedding-based retrieval system. Those technologies appeared in an older aspirational architecture and are not part of the verified current architecture.

Search, hashtags, topics, suggested people and insights are API modules. The exact ranking and privacy behavior should be maintained in their specialist documentation and tests.

## 10. Gifts and creator economy

The `GiftsModule` is part of the current API. The separate `Kyron-Incentives` repository documents the current system as a **test economy**:

- Users receive a weekly top-up to 100 coins at Monday 00:00 UTC.
- Earned coins are separate from spendable coins.
- Coins cannot currently be purchased.
- Earnings cannot currently be withdrawn.
- The test system does not currently represent money.
- Gift/coin ledger behavior exists in the main API, while the incentives repository contains design and implementation documentation.

This must not be represented as a production payment, stored-value, investment, equity or cash-payout product. Purchases, refunds, chargebacks, tax handling, creator payouts, KYC/AML and jurisdiction eligibility require a separate approved financial architecture and compliance sign-off.

## 11. Deployment topology

### 11.1 Render

`render.yaml` describes:

- A static `kyron-web` service publishing the committed `web/build/web` output. Its `/app` routes redirect to the download page; the web application is described as withdrawn pending further notice.
- A Docker-based `kyron` API service using `api/Dockerfile`, with `/health` as its health-check path.
- Sensitive configuration such as database URLs, Supabase credentials, CORS, FCM service account data and the shared public-pages key configured as unsynchronised Render environment values.

The `render.yaml` itself warns that the live API service was originally created in the dashboard and that the service name/runtime must be confirmed before applying the blueprint. Do not apply the blueprint blindly: a name mismatch could create a second service.

### 11.2 Startup and migrations — release-blocking concern

`api/scripts/start.sh` runs `prisma migrate deploy` with a bounded timeout before starting the API. A missing Prisma CLI, invalid timeout, migration failure or timeout exits the container with a non-zero status. The script does not attempt automatic baseline resolution. The NestJS Prisma provider also refuses to complete application startup when Postgres remains unreachable after its bounded connection retries.

This behavior may preserve service availability, but it can also allow an application version to run against an outdated schema. The README likewise warns that `/health` indicates database reachability, not schema currency.

**Production requirement:** Before relying on this behavior for a production release, replace the implicit “start anyway” posture with a deliberate, observable release gate. A release must not be declared healthy when required migrations failed. The migration baseline must be proven against the actual database before any baseline resolution is performed. Use a controlled migration/release step, explicit failure status, and a compatibility/rollback plan.

### 11.3 One-instance assumption

The observability and roadmap documents identify the current API as a single Render instance. Three known behaviors are process-local:

- Rate-limit buckets.
- Realtime connection/socket tracking.
- In-memory metrics.

A second API instance would cause inconsistent rate limiting, incomplete cross-instance realtime delivery and per-instance metrics. Do not horizontally scale the API until these concerns are addressed or the single-instance constraint is explicitly accepted with capacity evidence.

Redis appears in dependencies/configuration but is not read by the current API source according to the repository roadmap. It must not be described as an active cache, broker or shared realtime layer.

## 12. Supporting repositories and boundaries

| Repository | Responsibility | Integration/boundary |
|---|---|---|
| `KyronLabs/kyron` | Main Flutter app, API, Prisma schema/migrations, app web build and core product docs | System of record for product implementation |
| `KyronLabs/kyron-lenses` | Public AR lens catalogue, format specification, validation vectors and GitHub Pages publication | App fetches lens data; downloaded lens is data, not executable code |
| `KyronLabs/kyron-lens-studio` | Windows Electron lens-authoring tool | Produces catalogue contributions; shares format vectors |
| `KyronLabs/kyron-artwork` | Public artwork catalogue and source assets for lens authors/studio | Studio reads catalogue and hosted assets |
| `KyronLabs/design-system` | Design tokens, guidance and Flutter package | Main app consumes package through Git dependency |
| `KyronLabs/kyron-links` | Read-only public post/profile/community pages and social link previews | Calls main API `/public/*`; does not access database |
| `KyronLabs/kyron-live` | Live-streaming vendor/architecture decision research | No live-streaming system is currently implemented |
| `KyronLabs/Kyron-Incentives` | Incentive/gifting economy specifications and roadmap | Current implementation lives in main API/client |
| `KyronLabs/Kyron_Terms_and_Privacy` | Published terms, privacy, account-deletion and child-safety pages | App links to separately hosted static pages |
| `KyronLabs/Global-Compliance` | Country-by-country regulatory research and distribution readiness | Internal compliance source; owner reports repository is now private |
| `KyronLabs/.github` | Organisation profile/shared GitHub configuration | Organisation-level presentation and reusable defaults |

Visibility is an access-control choice, not an architectural boundary. A public repository must contain only material approved for public release; a private repository still requires least-privilege access and secret hygiene.

## 13. Known discrepancies and verification register

| Item | Evidence / discrepancy | Required treatment |
|---|---|---|
| `ARCHITECTURE.md` | Older text says video transcoding is absent and contains stale module/controller counts | Rewrite against current code and roadmap; avoid static counts unless generated |
| `FOLDER_STRUCTURE.md` | Historical test counts and tree descriptions differ from newer README/roadmap | Reconcile from the checked-out tree and CI |
| README vs ROADMAP test counts | README and roadmap report different Flutter/API test totals | Capture latest successful CI totals and define one source of truth |
| Supabase migration history | Checked-in migration folder is not complete; historical records exist in live metadata | Pull and reconcile live schema/history before fresh provisioning |
| Supabase default privileges | `supabase_admin` defaults are documented as broad for `anon` on new tables | Restrict defaults and test grants/RLS in a non-production clone |
| Startup migration fallback | API can start after failed/timed-out migrations | Release gate and schema-version health check required |
| Render blueprint | Service name/runtime adoption assumptions are called out in comments | Confirm dashboard service identity before blueprint changes |
| iOS push | Apple-side APNs/capability work remains documented | Treat iOS push as not fully operational until tested |
| Web client | Withdrawn; static service currently redirects `/app` to download | Do not describe web app as active |
| Live streaming | Decision/research only | Not built |
| Creator equity pool | Not started; legal review required | Not a current product capability |
| Redis | Dependency/config only; not used in API source | Do not rely on it for scaling |
| Financial features | Gifts test economy only; no purchases or withdrawals | Separate regulated-finance programme required |

## 14. Architecture principles

1. **Modular monolith first.** Keep domain boundaries clear inside the NestJS API. Split a module into a service only when independent deployment, scaling, isolation or team ownership justifies the operational cost.
2. **One authoritative owner per data domain.** Prisma owns API schema; Supabase SQL migrations own Supabase-specific grants, policies and client-facing tables. Coordinate both deliberately.
3. **No undocumented production mutation.** Production schema changes are reviewed, versioned and reproducible.
4. **Server-side authorization.** Client UI state is never an authorization boundary.
5. **Explicit platform capability.** A dependency or platform folder does not mean a feature is production-enabled on that platform.
6. **No aspirational architecture presented as fact.** GraphQL, gRPC, Pinecone, federation, separate media service and Redis-based coordination are not current architecture unless implemented and verified.
7. **Operational behavior is part of architecture.** Migration failure, health checks, secrets, logging, scaling assumptions and recovery paths must be documented alongside code structure.

## 15. Source files reviewed

Primary evidence in the main repository:

- `README.md`
- `ARCHITECTURE.md`
- `FOLDER_STRUCTURE.md`
- `ROADMAP.md`
- `render.yaml`
- `api/package.json`
- `api/src/main.ts`
- `api/src/app.module.ts`
- `api/prisma/schema.prisma`
- `api/scripts/start.sh`
- `app/pubspec.yaml`
- `supabase/README.md`
- `docs/OBSERVABILITY.md`
- `docs/PERFORMANCE.md`
- `docs/PUSH.md`
- `docs/E2EE.md`

Supporting repository READMEs reviewed:

- `kyron-lenses`
- `kyron-links`
- `design-system`
- `Kyron-Incentives`
- `Global-Compliance`
- `Kyron_Terms_and_Privacy`
- `kyron-live`
- `kyron-lens-studio`
- `kyron-artwork`

This review did not inspect live Render environment values, Supabase production data, production database logs, Firebase account settings, Play Console settings or every source file in every repository. Those require separate operational verification.
