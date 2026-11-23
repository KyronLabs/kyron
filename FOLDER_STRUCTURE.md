# Kyron Repository Structure

This guide describes the current repository layout. Exact screen, model and
test counts are intentionally omitted because they change frequently; use the
source tree and CI for current inventories.

```
kyron/
├── app/                              # Flutter client
│   ├── android/                      # Android runner and Play build
│   ├── windows/                      # Windows runner
│   ├── ios/                          # iOS runner source (not a current release target)
│   ├── web/                          # Flutter web source (interactive web app withdrawn)
│   ├── lib/
│   │   ├── models/                   # data models and JSON mapping
│   │   ├── providers/                 # Riverpod state
│   │   ├── repositories/              # API repositories over Dio
│   │   ├── screens/                   # application screens
│   │   ├── services/                  # API client, auth and platform services
│   │   ├── utils/                     # pure helpers and formatting
│   │   ├── widgets/                   # shared UI components
│   │   └── routes.dart                # named routes
│   ├── test/                          # Flutter unit and widget tests
│   └── pubspec.yaml
│
├── api/                              # NestJS API using the Fastify adapter
│   ├── prisma/
│   │   ├── schema.prisma              # Prisma-managed relational schema
│   │   └── migrations/                # API-managed database migrations
│   ├── src/
│   │   ├── modules/                   # domain modules: feed, messages, media,
│   │   │                              # identity, moderation, financial ledger, etc.
│   │   ├── infrastructure/            # Prisma, Supabase and observability adapters
│   │   ├── config/                    # environment and runtime configuration
│   │   └── main.ts                    # API bootstrap
│   ├── scripts/                       # fail-closed startup and operational scripts
│   ├── test/                          # API end-to-end test support
│   └── package.json                  # npm scripts and dependencies
│
├── supabase/
│   └── migrations/                   # Supabase-specific RLS, grants and SQL objects
│
├── web/build/web/                    # committed static download/marketing site
├── infra/postgres/init/              # local PostgreSQL role initialization
├── media/                            # not a separately deployed service; see api/src/modules/media/
├── docs/                             # product and engineering documentation
├── .github/workflows/                # Flutter, API, Windows and release workflows
│
├── ARCHITECTURE.md                   # current system boundaries and runtime shape
├── FOLDER_STRUCTURE.md               # this repository guide
├── ROADMAP.md                        # product work and next steps
└── CHANGELOG.md                      # user-facing release notes
```

## Where changes belong

| Change | Location |
|:--|:--|
| A Flutter screen | `app/lib/screens/`, with its route in `routes.dart` |
| Shared Flutter UI | `app/lib/widgets/` |
| Pure client-side logic | `app/lib/utils/` with focused tests |
| An API domain feature | `api/src/modules/<area>/` with its module, controller/service as needed, and specs |
| A Prisma-managed schema change | `api/prisma/schema.prisma` plus a migration |
| Supabase-specific RLS, grants or client-facing SQL | `supabase/migrations/` |
| Local PostgreSQL initialization | `infra/postgres/init/` |
| API startup or operational tooling | `api/scripts/` |
| Architecture or operating guidance | `docs/engineering/` and the linked root-level guides |

## Runtime boundaries

- The Flutter application and NestJS API are separate deployable artifacts.
- The API is a modular monolith backed by one Supabase PostgreSQL database.
- Media upload, queueing and re-encoding run inside the API; the root-level
  `media/` directory is not a deployed media service.
- The top-level `web/build/web/` output is a static site. It does not mean the
  interactive Flutter web application is currently available.
- Redis is not currently the backing store for the API's rate limiter,
  realtime registry or media queue; the media queue is stored in PostgreSQL.
