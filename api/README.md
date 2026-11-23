# Kyron API

The API is the server side of Kyron. It is a **NestJS application using the
Fastify adapter**, organised as a modular monolith rather than separately
deployed microservices.

It uses:

- PostgreSQL, with the application schema managed by Prisma.
- Supabase Auth for account identity and JWTs verified by the API.
- Supabase Storage for uploaded media.
- A Postgres-backed media-job table and an in-process worker for eligible
  video re-encoding.

The active app release targets are Android and Windows. The web build in
`web/build/web` is a static download/marketing site; the interactive web app
is withdrawn.

## Requirements

- Node.js 22 (the Docker image and API CI both use Node 22).
- npm.
- A disposable PostgreSQL database for local development and database tests.
- A Supabase project for authenticated application flows and Storage.

## Local development

From the repository root, start the development PostgreSQL service:

```bash
docker compose up -d postgres
```

The repository's Docker Compose setup prepares the Supabase-compatible
PostgreSQL roles used by the migrations. For an existing local database,
inspect the SQL in `infra/postgres/init/` and ensure the expected roles and
Supabase auth helpers exist before applying migrations.

Then configure the API environment and start it:

```bash
cd api
cp .env.example .env
# Fill in the local DATABASE_URL and the required Supabase project values.
npm ci
npx prisma generate
npx prisma migrate deploy
npm run start:dev
```

The development server listens on the configured `PORT` (3000 by default).
Never commit a populated `.env` file or paste production credentials into
issues, logs or pull requests. The checked-in `.env.example` contains
placeholders and documents the current environment variables.

## Database and startup behavior

- `api/prisma/schema.prisma` and `api/prisma/migrations/` own the
  Prisma-managed application schema.
- `supabase/migrations/` holds Supabase-specific SQL such as grants, RLS and
  client-facing database objects. Keep both migration sets in sync when a
  change spans both ownership areas.
- `npm run start:dev` starts the NestJS development process directly. Apply
  pending migrations first with `npx prisma migrate deploy`.
- `npm start` runs `scripts/start.sh`: it executes
  `prisma migrate deploy` with a bounded timeout and starts the compiled API
  only if migrations succeed. The script does not automatically baseline a
  database or mark migrations as applied.
- Prisma also checks database connectivity during application startup and
  refuses to start after its bounded connection retries are exhausted.

Do not use `prisma migrate reset`, destructive seed logic or manual baseline
resolution against production. Reconcile existing migration history and
verify backups before an operator-authorised repair.

## Quality checks

Run these from `api/`:

```bash
npm run typecheck
npm run build
npm test
npm run lint
```

The API CI workflow runs dependency auditing, Prisma generation, typecheck,
build, Jest unit specs and ESLint when API code changes.

Database integration specs use a PostgreSQL database and are skipped when
`MODERATION_TEST_DATABASE_URL` is not set. Against a disposable database,
provide both `DATABASE_URL` and `MODERATION_TEST_DATABASE_URL`, apply the
migrations and run:

```bash
npx jest db.spec --runInBand
```

The CI database job uses PostgreSQL 16 and prepares the Supabase roles and
auth helper functions required by the migration set before applying
migrations. Do not point database integration tests at production data.

## Runtime media processing

The API Docker image installs ffmpeg. The media module validates uploads,
probes video and creates a poster during the upload request, then queues
eligible public clips for re-encoding. A worker processes one Postgres-backed
`MediaJob` at a time and writes a smaller H.264 result over the same Storage
path. If ffmpeg is unavailable or a re-encode cannot improve the file, the
original upload remains available; see [Media jobs](../docs/MEDIA_JOBS.md).

Private chat and view-once uploads use private Storage paths and do not enter
the public poster/re-encode path.

## Related documentation

- [System architecture](../ARCHITECTURE.md)
- [Production readiness masterplan](../docs/engineering/PRODUCTION_READINESS_MASTERPLAN.md)
- [Media processing queue](../docs/MEDIA_JOBS.md)
- [Observability](../docs/OBSERVABILITY.md)
- [API environment template](.env.example)
