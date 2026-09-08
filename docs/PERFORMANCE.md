# What the API actually costs

Nobody had measured it. The README quoted latency targets, the roadmap said
they could not be claimed, and both were right — there was no load test and no
way to run one. This is the first set of real numbers, how they were obtained,
and what they exposed.

Re-run it yourself: `api/scripts/loadtest.mjs`, described at the bottom.

## The numbers

Against a real Postgres 16 seeded with 500 accounts, 3,000 posts spread across
the fourteen-day ranking window, ~60,000 likes, ~9,000 comments, ~30,000
follows, 3,000 view records and 600 interest signals. One API process, one
database, both on the same machine, so **there is no network between them** —
these are lower bounds, not production figures.

Milliseconds, whole round trip including reading the body.

### One client at a time

| Route | rps | p50 | p95 | p99 |
|:--|--:|--:|--:|--:|
| `GET /profile/interests` | 418 | 2.3 | 2.8 | 3.6 |
| `GET /messages` | 338 | 2.8 | 3.4 | 4.8 |
| `GET /profile/me` | 322 | 3.0 | 3.8 | 4.8 |
| `GET /notifications` | 157 | 6.2 | 7.7 | 9.2 |
| `GET /feed/trending/tags` | 117 | 8.3 | 10.4 | 12.0 |
| `GET /feed/search` | 113 | 8.5 | 11.1 | 14.3 |
| `GET /feed/following` | 100 | 9.7 | 12.0 | 15.6 |
| `GET /feed/recent` | 49 | 20.1 | 24.6 | 28.6 |
| `GET /health` | 36 | 27.5 | 31.5 | 34.8 |

### Sixteen concurrent clients

| Route | rps | p50 | p95 | p99 |
|:--|--:|--:|--:|--:|
| `GET /profile/interests` | 1294 | 12.0 | 17.5 | 21.0 |
| `GET /messages` | 1119 | 14.0 | 20.3 | 24.1 |
| `GET /profile/me` | 790 | 19.7 | 27.1 | 34.1 |
| `GET /health` | 514 | 30.1 | 39.7 | 50.3 |
| `GET /feed/trending/tags` | 434 | 36.6 | 47.2 | 53.3 |
| `GET /feed/search` | 306 | 52.7 | 63.8 | 69.2 |
| `GET /notifications` | 283 | 57.3 | 67.8 | 73.5 |
| `GET /feed/following` | 258 | 61.4 | 78.5 | 101.5 |
| `GET /feed/recent` | 107 | 150.0 | 188.2 | 202.2 |

## What measuring found

### The main feed read twenty times more than it returned

`GET /feed/recent` was by a wide margin the slowest thing the app does, and it
is the screen that opens first. It ranked a pool of four hundred candidates and
returned twenty — but selected the *whole* post shape for all four hundred:
author, media, the quoted post with its own author and media, the poll with its
options and this reader's vote, and four relation-filtered lookups per row. Then
it threw three hundred and eighty of them away.

It now ranks on the six columns scoring actually uses and loads the full shape
once, for the twenty being shown.

| `GET /feed/recent` | first measured | after the split | after the counters |
|:--|--:|--:|--:|
| 16 clients, rps | 31 | 55 | **107** |
| 16 clients, p50 | 549.5 | 299.2 | **150.0** |
| 16 clients, p95 | 615.1 | 365.1 | **188.2** |
| 1 client, p50 | 69.0 | 55.8 | **20.1** |

### `_count` was aggregating the whole table on every read

The split above helped, but less than expected, and the reason was a wrong
guess written down here: an earlier version of this document said the
remaining cost was "not the database", on the strength of a hand-written
`EXPLAIN ANALYZE` that ran in 3.1ms. **That was wrong.** The hand-written
query was not the query Prisma sends. Asking Postgres to log every statement
showed the real one taking 13.7ms, and showed why:

```sql
LEFT JOIN (SELECT "postId", COUNT(*) FROM "PostLike" WHERE 1=1
           GROUP BY "postId") AS aggr_selection_0_PostLike ON …
```

Prisma compiles a relation `_count` into an aggregate over the **entire
table**, unfiltered by the posts being fetched, and then joins it. The cost is
therefore the size of `PostLike`, not the size of the page — which is why
hydrating twenty posts cost 10.5ms, nearly as much as ranking four hundred,
and why splitting one query into two barely moved it. Both halves were still
paying for it. The same 20 posts, measured directly:

| | Execution time |
|:--|--:|
| With the three aggregate joins | 13.5 ms |
| Reading three columns instead | **0.46 ms** |

`Post` now carries `likeCount`, `commentCount` and `repostCount`, maintained
on the write paths inside the same transaction as the row they count, and
recomputable with `scripts/recount.sql`. Total database time for one
`/feed/recent`, counted from Postgres's own statement log:

| | before | after |
|:--|--:|--:|
| Database time per request | 29.8 ms | **6.9 ms** |
| The candidate query | 13.7 ms | **0.29 ms** |
| The page hydration query | 10.5 ms | **< 0.5 ms** |

Two details worth knowing. The counters move by what the write **actually
did**, not by what the caller intended: `createMany({ skipDuplicates: true })`
answers 0 when the row was already there and `deleteMany` answers 0 when there
was nothing to remove, so a double tap adds nothing. An `upsert` cannot tell
those apart, and every second tap would have added one.

And `commentCount` counts what the thread shows. The `_count` it replaces
included soft-deleted comments while the listing filtered them out, so a post
could report five comments and display four — the badge and the thread
disagreeing about the same conversation.

### The rate limit had never worked

The first run came back entirely `429`, which is how this was found. Two
separate faults, one on top of the other:

- `ConfigService.get<number>('RATE_LIMIT_MAX')` reads the raw environment and
  returns a **string**, whatever the type parameter says.
- `@fastify/rate-limit` silently ignores a `max` that is not a number and
  applies its own default of **1000**.

So every deployment that set `RATE_LIMIT_MAX` got 1000 requests a minute
whatever it asked for, and only a deployment that left it unset got the 100 the
code appears to say. Separately, the config factory's `Number(x) || 100` turned
any unparseable value into 100 with nothing said about it — so the same variable
could silently become 100 *or* 1000 depending on which layer swallowed it first.

Both now go through `src/config/rate-limit.ts`, which coerces once and refuses
to start on a value it cannot honour. A limit nobody can set is not a limit, and
one that is silently ten times what was asked for is worse than none, because it
is relied upon.

### The limit is now per account, not per address

Keyed on the address alone, one bucket covers everybody behind it — an office, a
school, or a mobile carrier's NAT, where thousands of phones share a handful of
addresses. The first few people through would spend the budget for everyone else
on the network, and it would read as the app being broken.

The token is read for its `sub` and **not** verified; `AuthGuard` does that. So
the worst a forged token buys is a private bucket of the same size, while
anonymous traffic stays limited by address exactly as before.

### A 429 was being logged as a server error

Found in the same run. The observability filter classified anything that was not
a Nest `HttpException` as a 500 — and the rate limiter throws a plain `Error`
carrying `statusCode: 429`. Every throttled request wrote a full stack trace at
error level, turning ordinary throttling into what looked, in the log a person
reads to find out whether the server is falling over, like the server falling
over.

### `/health` is slow, and that is fine


~29ms uncontended, because it deliberately checks database reachability and
whether the Supabase mirror tables exist. No user waits on it.

## What this does not measure

- **No network.** Client, API and database share a machine. Add real latency
  between the app and Fly, and between Fly and Supabase, for anything resembling
  a production number.
- **Reads only.** Posting, uploading and transcoding are not exercised. Media
  upload is the one request known to be long — a clip is re-encoded before the
  response — and it is not in this table.
- **One process.** Which is what `fly.toml` runs; see the one-instance section
  of [OBSERVABILITY.md](OBSERVABILITY.md).
- **One reader.** Every request authenticates as the same account, so caches and
  query plans are warmer than real traffic would leave them.
- **Cold start is excluded** by design: a warm-up pass runs before each sample,
  because a first request paying for a query plan and Node's JIT would otherwise
  make one p99 describe two different things.

## Running it

```sh
# 1. A database with the schema on it.
createdb kyron && psql kyron -c 'CREATE ROLE anon; CREATE ROLE authenticated;'
DATABASE_URL=... npx prisma migrate deploy

# 2. The data these numbers were taken against. Takes about three seconds.
psql "$DATABASE_URL" -f scripts/seed-loadtest.sql

# 3. The API, pointed at it, with the limiter out of the way -- otherwise the
#    run measures the rate limiter, which is exactly what happened the first
#    time and is why every row came back 429.
RATE_LIMIT_MAX=100000000 node dist/src/main.js

# 4. The run.
node scripts/loadtest.mjs \
  --base http://127.0.0.1:3999 \
  --token "$A_SUPABASE_ACCESS_TOKEN" \
  --concurrency 16 --seconds 8 --warmup 2
```

The seed namespaces everything it writes, so it can be taken out again:

```sh
psql "$DATABASE_URL" -c 'DELETE FROM "User" WHERE email LIKE %@load.test%'
```

To see where the time goes rather than only how much there is, ask Postgres:

```sh
psql "$DATABASE_URL" -c 'ALTER SYSTEM SET log_min_duration_statement = 0'
# then reload, make one request, and read the server log
```

That is how the `_count` aggregate above was found, after an `EXPLAIN ANALYZE`
of a hand-written approximation had pointed the wrong way. Measure the query
the ORM actually sends.

It has no dependencies and prints the status codes it received alongside the
percentiles — which is the column that matters. The first run of this test
reported a confident 4,900 requests a second that were entirely connection
refusals, and the status column is the only reason that was caught rather than
written down as a result.
