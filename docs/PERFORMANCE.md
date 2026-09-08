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
| `GET /profile/interests` | 306 | 3.2 | 4.0 | 5.3 |
| `GET /messages` | 270 | 3.5 | 4.8 | 5.9 |
| `GET /profile/me` | 220 | 4.3 | 5.8 | 9.8 |
| `GET /notifications` | 123 | 7.8 | 9.9 | 11.6 |
| `GET /feed/trending/tags` | 97 | 10.1 | 11.8 | 15.5 |
| `GET /feed/following` | 33 | 30.1 | 34.3 | 43.1 |
| `GET /feed/search` | 29 | 34.5 | 39.2 | 41.2 |
| `GET /feed/recent` | 18 | 55.8 | 67.3 | 98.7 |
| `GET /health` | 34 | 28.8 | 34.5 | 36.0 |

### Sixteen concurrent clients

| Route | rps | p50 | p95 | p99 |
|:--|--:|--:|--:|--:|
| `GET /profile/interests` | 1048 | 14.8 | 21.4 | 25.3 |
| `GET /messages` | 920 | 17.1 | 24.0 | 28.3 |
| `GET /profile/me` | 607 | 26.0 | 34.7 | 41.5 |
| `GET /health` | 375 | 40.3 | 61.5 | 96.8 |
| `GET /feed/trending/tags` | 340 | 46.1 | 64.0 | 76.0 |
| `GET /notifications` | 236 | 68.4 | 82.6 | 94.0 |
| `GET /feed/following` | 127 | 126.6 | 155.8 | 175.8 |
| `GET /feed/search` | 115 | 138.5 | 181.6 | 209.9 |
| `GET /feed/recent` | 55 | 299.2 | 365.1 | 400.4 |

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

| | before | after |
|:--|--:|--:|
| 16 clients, rps | 31 | **55** |
| 16 clients, p50 | 549.5 | **299.2** |
| 16 clients, p95 | 615.1 | **365.1** |
| 1 client, p50 | 69.0 | **55.8** |

Still the slowest route, and the remaining cost is **not** the database: the
candidate query runs in 3.1ms in Postgres (`EXPLAIN ANALYZE`, including the
three per-row engagement counts). What is left is Node-side — Prisma issuing
and stitching the relation loads for four hundred rows. The next step is
denormalised `likeCount`/`commentCount`/`repostCount` columns on `Post`,
maintained on write, which would make the candidate query a single index scan
with no relation loads at all. **That is not done.**

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
# A database with data in it, and the API pointed at it.
node scripts/loadtest.mjs \
  --base http://127.0.0.1:3999 \
  --token "$A_SUPABASE_ACCESS_TOKEN" \
  --concurrency 16 --seconds 8 --warmup 2
```

It has no dependencies and prints the status codes it received alongside the
percentiles — which is the column that matters. The first run of this test
reported a confident 4,900 requests a second that were entirely connection
refusals, and the status column is the only reason that was caught rather than
written down as a result.
