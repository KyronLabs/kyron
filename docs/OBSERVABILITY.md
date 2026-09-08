# Knowing what the API is doing

Until this existed there was nothing: no metrics, no request log, no error
aggregation. A 500 left a stack in whatever the platform happened to capture,
with nothing tying it to the request that caused it or to how often it had
happened, and none of the numbers the README quotes could be measured — so none
of them could honestly be claimed.

This document is mostly about what is now measurable and what still is not,
because a dashboard that looks complete is worse than no dashboard: people stop
looking for the thing it does not show.

## What it does

**A request id per request.** Generated at the Fastify layer, or taken from an
incoming `x-request-id` so an id set by a proxy survives the hop. It is
stripped to `[\w.:-]` and capped at 64 characters first — it goes into a log
line and a response header, and a client must not be able to write either. It
comes back on every response, including the failures, which is what turns "it
broke this morning" into one line of log.

**One structured line per served request**, to stdout:

```json
{"requestId":"9dbaa66e-…","method":"GET","route":"/feed/posts/:id/analytics","status":401,"ms":3.2,"userId":"…"}
```

Levelled by what the line is for: 5xx as an error, 4xx as a warning, and a
success over a second as a warning too — that last one is the case that would
otherwise never be noticed until somebody said the app felt heavy.

To stdout, not a file. This replaces a winston logger that rotated fourteen
days of files into a directory inside a container that is destroyed on every
deploy, and that nothing in the codebase imported anyway.

**`GET /metrics`**, in Prometheus text format:

| Metric | What it is |
|:--|:--|
| `http_requests_total{method,route,status}` | Requests served |
| `http_request_duration_seconds{…}` | A histogram, so P95 is computable rather than guessed |
| `http_errors_total{route,kind}` | Failures by exception class |
| `kyron_realtime_readers` | Readers with a socket open on this instance |
| `kyron_uptime_seconds`, `process_resident_memory_bytes` | The process itself |
| `kyron_metrics_series_folded_total` | Label combinations dropped for cardinality |

**Error aggregation.** A global filter counts every failure by route and by
exception class, and logs the 5xx ones with their stack and request id. It
changes no response body: the client reads the shape Nest already produced, so
the base filter still writes it.

## Decisions worth knowing about

**The route label is a pattern, never a URL.** `/feed/posts/:id/view`, not
`/feed/posts/9f3…/view`. One series per request is how a metrics endpoint takes
down the thing scraping it. Fastify knows the pattern it matched, so that is
used; requests that matched no route — the 404s, which are exactly the traffic
worth counting — go through a normaliser that folds anything longer than 24
characters, anything numeric, and anything shaped like a uuid. There is no
exception for a segment that looks like a word: base64 is letters and digits
often enough that any such exception lets one through, and the longest route
segment this API declares is `default-cover`, at thirteen.

Past 500 distinct label combinations the rest fold into `route="other"` and
`kyron_metrics_series_folded_total` rises. A ceiling that is visible beats
trusting every future route to behave.

**It is a Fastify hook, not a Nest interceptor.** Interceptors do not run for a
request a guard rejected or a route that matched nothing, so an interceptor
counts the traffic that worked and misses every 401 and 404 — most of what
anybody opens a dashboard to find.

**`/metrics` is shut unless `METRICS_TOKEN` is set**, and answers **404** rather
than 401 when it is not, or when the token is wrong. A deployment with no token
should look like one with no metrics endpoint rather than advertise a door and
refuse to open it. The token is compared without returning early on the first
differing byte. Route names and traffic shape are more than a stranger needs.

## What it does not do

- **No traces.** One line per request, with no causal link between the request
  and the queries it made. A slow endpoint can be found; *why* it was slow still
  has to be worked out by reading it.
- **No error reporting service.** Failures are counted and logged. Nothing pages
  anybody, and nothing groups a new exception as new.
- **Nothing survives a restart.** Counters are in memory and per process, which
  is what a scrape is for. A machine that restarts starts from zero, and Fly
  stops this one when it is idle.
- **No database, queue or cache metrics.** Query timing, connection pool state
  and Supabase latency are all invisible.
- **No client-side anything.** Crashes and slow frames in the app are not here.
- **No alerting.** These numbers have to be scraped by something that has
  opinions before they wake anybody up.

## The one-instance assumption

Several things here are per process, and that is correct today: `fly.toml` runs
a single machine that stops when idle. It stops being correct at instance two,
and three separate things break at once — the rate limiter allows N per
instance rather than N in total, the realtime service holds its sockets in a
`Map` so a message from one instance never reaches a reader connected to
another, and these counters describe whichever machine the scrape happened to
land on.

That is what `REDIS_HOST` in `.env.example` is for, and it is read by nothing:
it is the shape of the answer, not the answer. `ioredis` and `bullmq` are
installed against the same day. None of it is wired, deliberately — a Redis that
is half-used is a dependency paid for and not delivering, which is the state the
roadmap called out.

## Turning it on

```sh
# In the API's environment
METRICS_TOKEN=$(openssl rand -hex 32)
```

Then point a scraper at `https://<host>/metrics` with
`Authorization: Bearer <that value>`. Without the variable the endpoint 404s and
the API says so in its log, once, at the first request.
