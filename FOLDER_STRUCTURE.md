# Kyron Repository Folder Structure

The tree below is what is in the repository. An earlier version of this file
described a layout the code does not use — `app/lib/features/`, `api/src/feed/`
and an `identity/` service with AT Protocol logic in it.

```
kyron/                          # repository root
│
├── app/                        # Flutter client (Android · iOS · Web)
│   ├── lib/
│   │   ├── models/             # plain data classes, JSON in and out
│   │   ├── providers/          # Riverpod state per feature
│   │   ├── repositories/       # one per API area, over Dio
│   │   ├── screens/            # 43 screens
│   │   ├── services/           # ApiClient, auth, profile, logging
│   │   ├── utils/              # pure helpers: thread layout, formatting
│   │   ├── widgets/            # shared UI: post card, thread, sheets
│   │   └── routes.dart         # every named route
│   ├── test/                   # 32 test files, 388 tests
│   └── pubspec.yaml
│
├── api/                        # NestJS API (Fastify adapter)
│   ├── prisma/
│   │   ├── schema.prisma       # 40 models
│   │   └── migrations/         # applied on every boot by scripts/start.sh
│   ├── src/
│   │   ├── modules/            # auth, feed, messages, communities,
│   │   │                       # profile, moderation, notifications,
│   │   │                       # media, links, users, identity, gateway
│   │   ├── infrastructure/     # Prisma and Supabase clients
│   │   ├── config/             # environment, validated at boot
│   │   └── common/             # guards, filters, shared DTOs
│   ├── fly.toml                # deploy target
│   └── package.json            # npm, not pnpm
│
├── supabase/
│   └── migrations/             # client-facing tables, RLS and grants
│
├── web/build/web/              # committed static marketing site
│
├── docs/                       # images and assets used by the docs
│
├── identity/                   # a Dockerfile. Not a service yet
├── media/                      # a Dockerfile. Not a service yet
├── infra/                      # a placeholder
│
├── ROADMAP.md                  # what is built, what is not, what is next
├── ARCHITECTURE.md             # how the running system fits together
└── CHANGELOG.md                # notable changes, newest first
```

## Where things go

| Adding | Put it in |
|:--|:--|
| A screen | `app/lib/screens/`, with a route in `routes.dart` |
| Shared UI | `app/lib/widgets/` |
| Logic worth testing on its own | `app/lib/utils/`, as a pure function |
| An API area | `api/src/modules/<area>/` with a controller, service and spec |
| A schema change | `api/prisma/schema.prisma` plus a migration |
| Anything the client reads directly from Postgres | `supabase/migrations/` |
