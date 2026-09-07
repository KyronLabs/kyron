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
│   Flutter  ·  Android · iOS · Web           │
│   Riverpod state  ·  Dio HTTP  ·  REST      │
└───────────────────────┬─────────────────────┘
                        │  HTTPS / JSON
┌───────────────────────┴─────────────────────┐
│   NestJS on Fastify                         │
│   13 REST controllers  ·  rate limited      │
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
| Client | Flutter, Riverpod, Dio | Every screen; talks REST to the API |
| API | NestJS on Fastify, Prisma | Auth, feed ranking, posts, comments, messages, communities, moderation, media handoff |
| Database | Postgres, hosted by Supabase | One database. All 40 tables |
| Storage | Supabase Storage | Uploaded photos, video and voice recordings |
| Auth | Supabase Auth | Issues the JWT; the API verifies it against Supabase's JWKS |

### Directories that are not services

`identity/` and `media/` each hold a Dockerfile and nothing else. They were
placeholders for services that have not been started. `web/` holds a committed
static build of the marketing site.

---

## Authentication

1. The client signs in through Supabase Auth and receives a JWT.
2. Every API request carries it as a bearer token.
3. `AuthGuard` verifies the signature against Supabase's JWKS endpoint, checks
   the issuer and expiry, and resolves the token's subject to a row in `User`.

There is no session table and no refresh handled by the API; Supabase owns both.

---

## The feed

`RankingService` scores candidate posts rather than ordering by time. The
signals are:

- topics the reader has said they are interested in
- authors the reader follows
- authors whose posts the reader has liked before
- recency, as a decay rather than a sort

Paging is a cursor of the form `r<seed>-<offset>`, so the ranking a reader is
part-way through stays stable while they page rather than reshuffling under
them.

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

The client picks a file, uploads it to the API, and the API puts it in Supabase
Storage and answers with a public URL, which is stored on the post.

There is no transcoding, no server-side thumbnail generation and no duration
ceiling enforced past the client. See [`ROADMAP.md`](ROADMAP.md).

---

## Deployment

| Target | What runs there |
|:--|:--|
| Fly.io (`api/fly.toml`) | The API. `api/scripts/start.sh` runs `prisma migrate deploy` on every boot |
| Render (`render.yaml`) | The static marketing site and the committed Flutter web build |
| Supabase | Postgres, Auth and Storage |

Redis appears in `docker-compose.yml` and in the API's config, and nothing in
`api/src` reads it.

---

## Data

Prisma owns the schema; migrations live in `api/prisma/migrations` and are
applied on every boot. A separate set of migrations in `supabase/migrations`
covers what the client reads directly (profiles, interests) and the grants that
shut the anon key out of the API's own tables.
