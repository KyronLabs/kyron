# Kyron Architecture

What the system is today. An earlier version of this file described a
micro-service topology with a GraphQL gateway, gRPC between services, a Rust
media transcoder, a Pinecone vector store and an AT Protocol identity node.
None of that exists. This describes what does.

---

## Shape

One client, one API, one database.

```
┌─────────────────────────────────────────────┐
│   Flutter client · Android / Windows apps  │
│   Riverpod state  ·  Dio HTTP  ·  REST      │
└───────────────────────┬─────────────────────┘
                        │  HTTPS / JSON
┌───────────────────────┴─────────────────────┐
│   NestJS on Fastify                         │
│   REST controllers + WebSocket gateway     │
│   Supabase JWT verified against JWKS        │
└───────┬─────────────────────────┬───────────┘
        │  Prisma                 │
┌───────┴───────────┐   ┌─────────┴───────────┐
│  Postgres         │   │  Supabase Storage   │
│  (Supabase)       │   │  photos · video     │
└───────────────────┘   └─────────────────────┘
```

---

## Components

| Part | Tech | Responsibility |
|:--|:--|:--|
| Client | Flutter, Riverpod, Dio | Android and Windows app release targets; REST API client |
| API | NestJS on Fastify, Prisma | Auth, feed ranking, posts, comments, messages, communities, moderation, financial operations and media processing |
| Database | Postgres, hosted by Supabase | Prisma-managed application schema plus Supabase-specific migrations for grants, RLS and client-facing objects |
| Storage | Supabase Storage | Public post media and private chat/view-once attachments |
| Auth | Supabase Auth | Issues the JWT; the API verifies it using the configured Supabase token-verification path |

### Directories that are not services

The top-level `media/` directory is not a separately deployed
service. The active upload, validation, poster and re-encode queue/worker
implementation lives inside the API at `api/src/modules/media/`. Likewise,
identity is an API module at `api/src/modules/identity/`, not an independent
identity service; the product stops at a verifiable account identifier and
does not provide portable/federated identity (`docs/IDENTITY.md`). The
committed `web/build/web/` output is a static download/marketing site. The
interactive Flutter web app is withdrawn and is not a current release target.

---

## Authentication

1. The client signs in through Supabase Auth and receives a JWT.
2. Every API request carries it as a bearer token.
3. `AuthGuard` verifies the signature against Supabase's JWKS endpoint, checks
   the issuer and expiry, and resolves the token's subject to a row in `User`.

There is no session table and no refresh handled by the API; Supabase owns both.

---

## The feed

`RankingService` scores the newest 400 posts the reader may see, with no age
limit, rather than ordering by time. The signals are:

- topics the reader has said they are interested in
- authors the reader follows, likes, reads, or asked to see more or less of
- recency, as a decay whose half-life follows how fast the network posts
- what the reader has opened, and what has been on their screen in For You

Paging is a cursor of the form `r<seed>-<offset>-<session start>`, and every
page is ranked as the world stood when the session began, so the ranking a
reader is part-way through stays stable while they page rather than
reshuffling under them. The whole of it is in [docs/FEED.md](docs/FEED.md).

It is not a vector or embedding model. There is no ANN index and no Pinecone.

---

## Comments

Comments are stored flat, each carrying a `parentId`, and assembled into a tree
on the client by `buildThreadLayout`. A reply keeps the parent it was written
under, bounded by `maxThreadDepth` (8); past that it attaches to the deepest
ancestor still inside the limit.

The connector rails are computed as pure geometry in `thread_layout.dart` and
`thread.dart`, separately from the widgets that draw them, because a connector
that runs to the wrong place still paints without complaint.

---

## Notifications

Derived, not fanned out. The notifications screen reads the likes, comments,
reposts and follows themselves rather than a table written at event time — a
fan-out table has to be kept in step with every write path that could produce a
notification and drifts the moment one forgets.

Per-row read state is traded away for one watermark on the account: the last
time the screen was opened. Anything newer is unread.

---

## Media

The API's media module owns upload validation and Storage handoff.
It checks file signatures and per-kind size limits, measures supported image
dimensions from the bytes, and probes video on upload. For public post videos,
the request also attempts to create a poster and records duration/dimensions;
clips longer than five minutes are rejected when ffprobe can measure them.

Eligible public videos (height over 1280 pixels or bitrate over 2.5 Mbps) are
queued in the Postgres `MediaJob` table. The in-process `MediaWorker` claims
jobs with `FOR UPDATE SKIP LOCKED`, processes one clip at a time with ffmpeg,
and writes a smaller H.264/AAC file back over the same Storage path. The
original upload remains available when ffmpeg is absent, refuses the clip, or
cannot produce a smaller file. Queue failures are retried up to the configured
attempt limit and are exposed through media queue metrics.

Private chat and view-once attachments use private Storage references and
bypass public poster generation and re-encoding. This pipeline is part of the
API process; it is not a separately deployed media service. See
[`docs/MEDIA_JOBS.md`](docs/MEDIA_JOBS.md) and
[`api/src/modules/media/`](api/src/modules/media/).

---

## Deployment

| Target | What runs there |
|:--|:--|
| Render (`render.yaml`) | The API as one Docker service (`api/Dockerfile`), plus a static download/marketing site from the committed `web/build/web/` output. The interactive web app is withdrawn. |
| Supabase | Postgres, Auth and Storage |

Redis appears in `docker-compose.yml` and in the API's config, and nothing in
`api/src` reads it.

---

## Data

Prisma owns the API-managed schema; migrations live in
`api/prisma/migrations`. The container entrypoint runs
`prisma migrate deploy` before starting the compiled API and exits non-zero
when migration execution fails or times out. It does not resolve baselines
automatically. A separate set of migrations in `supabase/migrations/` covers
Supabase-specific objects such as client-facing tables, RLS and grants. Changes
that span both migration owners need an explicit order and a verified upgrade
path.
