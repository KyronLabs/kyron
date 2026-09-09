# Re-encoding clips off the request

Uploading a clip used to mean waiting for ffmpeg. The request handler probed
the file, cut a poster, re-encoded it, and only then answered — so somebody
posting a 4K clip from their phone watched a spinner for the whole encode.

The upload now stores the clip and answers. Re-encoding happens afterwards, on
a queue, and writes a smaller file back over the same path.

## What the request still does

Probe and poster. Both are quick, and both produce values the response has to
carry — the clip's shape, how long it runs, and the URL of the still every feed
tile draws before anybody presses play.

Measured on a 10-second 3840×2160 clip, 17.7 MB, on a four-core machine:

| | |
|:--|--:|
| `prepare()` — what the request waits for | **388 ms** |
| `reencode()` — what moved to the queue | 4771 ms |
| Request before | 5159 ms |
| Request now | **388 ms** |

Reproduce it with `npx ts-node` over `TranscodeService`; the numbers above are
a median of three runs. A real phone clip encodes slower than this synthetic
one, which makes the gap wider, not narrower.

## What the queue does

`MediaJob` is a table. A row says a stored clip is owed a re-encode; the worker
claims one at a time, fetches the bytes from storage, runs ffmpeg, and writes
the result back **over the same path**.

The path is the point. The URL was handed to the client before any of this ran,
and it is already inside somebody's post — so the bytes behind it improve and
nothing else has to change. No row to update, no second URL, no window where a
post points at a file that does not exist yet.

A table rather than a promise in memory: the work takes tens of seconds, so a
deploy lands in the middle of one regularly. Held in memory that work would
vanish with nothing recording that it had, and the clip would keep its upload
bitrate forever.

## What it costs

**Overwriting is not free.** Two honest consequences:

- A viewer streaming the clip at the instant it is replaced may see that
  request fail. They are watching a clip uploaded seconds ago, so this is rare,
  and a retry fixes it.
- A CDN or cache that already holds the original keeps serving it until it
  expires. That is the larger file, which plays correctly — the saving arrives
  late for those viewers rather than not at all.

The alternative — writing to a new path and updating every row that links to
the old one — trades those for a window where a post can point at a file that
is not there. This is the better trade for a clip that is seconds old.

## When it does not run

Nothing here is load-bearing for playing a clip. The original is stored, plays,
and has a poster before the queue is involved at all. Every outcome below costs
a smaller file and nothing else:

| Outcome | What happened |
|:--|:--|
| `SKIPPED` | ffmpeg is not installed, or it read the clip and refused, or the re-encode came out *bigger* than the original |
| `FAILED` | Three attempts failed. `lastError` says why |
| `PENDING` after a failure | A transient failure — a storage blip, a machine that went away. It will be picked up again |

A clip is only queued when `shouldReencode` says it is worth it: taller than
1280 or fatter than 2.5 Mbps. A phone's own recording is usually already H.264
at a sane bitrate, and re-encoding it costs quality and CPU for nothing.

## Sharing one machine

The API and ffmpeg run on the same box, so the encoder is capped at
`cpus - 1` threads. libx264 takes every core it can see otherwise, which turns
"the upload is quick now" into "everything else got slow instead".

The worker runs **one** clip at a time for the same reason. ffmpeg is a child
process, so it never blocks the event loop — what it competes for is CPU, and
two encodes at once make every request served alongside them slower without
finishing the queue any sooner.

## Watching it

Two gauges on `/metrics`:

- `kyron_media_reencode_pending` — clips waiting. Should sit near zero and come
  back down after a burst. A number that only grows means the encoder cannot
  keep up with uploads.
- `kyron_media_reencode_failed` — clips given up on. Each still plays. Any
  sustained non-zero value is worth reading `lastError` for.

Both are read on the worker's tick rather than at scrape time, so scraping
never puts a query on the database.

## Checking the queue itself

The claim is raw SQL — `FOR UPDATE SKIP LOCKED`, an interval, an enum
comparison — and a jest spec with a faked Prisma exercises none of it. The
failures that would hide there are the expensive ones: two workers running the
same encode, or a job never picked up again after the process holding it died.

`api/scripts/check-media-queue.ts` runs the real `MediaQueue` against a real
Postgres and checks exactly those:

```
DATABASE_URL=postgresql://... npx ts-node scripts/check-media-queue.ts
```

It imports the service rather than restating its SQL, so it cannot drift into
checking a copy. All nine checks pass against Postgres 16, including two
workers racing for one job and a job abandoned by a killed process being
reclaimed on its second attempt.

There is one API process today, so `SKIP LOCKED` is not strictly needed. It is
there because it is the difference between "correct on one machine" and
"correct", and it costs a clause.

## Clips that predate all of this

The queue only ever received clips as they were uploaded. Everything posted
before it existed kept whatever the phone recorded, because that is what this
service does when it cannot help: **"a clip that ffmpeg cannot read, or a
server with no ffmpeg on it, means the original bytes are stored exactly as
they arrived — which is what happened to every clip before this existed."**

So an old 4K clip is still 4K. The app cannot make decoding one cheap, and it
is felt in a feed: a phone has a hard ceiling on concurrent decoders, and a
clip well over the size ceiling eats a disproportionate share of one.

`api/scripts/backfill-media.ts` queues them. It reports by default and only
writes when told to:

```
npx ts-node scripts/backfill-media.ts              # count, change nothing
npx ts-node scripts/backfill-media.ts --probe      # ...and read each file
npx ts-node scripts/backfill-media.ts --commit     # queue the work
npx ts-node scripts/backfill-media.ts --limit 20   # look at no more than 20
```

Three things worth knowing before running it with `--commit`:

1. **It queues; it does not encode.** `MediaWorker` drains the rows one at a
   time and probes each clip first, so anything already inside the ceiling is
   recorded `SKIPPED`. Queueing a clip that turns out not to need it costs a
   probe, not a file.
2. **A re-encode replaces the original bytes.** The path does not change, so
   no URL breaks and nothing linking to a clip needs updating — but the file
   that was there is gone. There is no undo.
3. **It is idempotent.** A clip with a `MediaJob` of any status is left alone,
   so a second run queues nothing and a `DONE` clip is never re-encoded.

The default report says what can be known from the database alone: how many
video attachments there are, how many have a storage path the script can act
on, how many were queued at some point already, and how many are taller than
1280 by their stored height. That height is a **floor rather than the answer** —
it cannot show a 720p clip at 8 Mbps, which is over the bitrate ceiling and
every bit as expensive to decode. `--probe` downloads each clip and asks
ffprobe, which is the only way to count those; it costs a whole download per
clip, so pair it with `--limit` the first time.

A URL the script does not recognise is counted with its reason rather than
guessed at. `storedPathFromUrl` is strict on purpose: a path is where the
smaller file gets written back, so a wrong one aims a write at the wrong
object.

Verified end to end against Postgres 16 with the schema and a spread of seeded
rows — clips over and under the ceiling, one with no dimensions recorded, a
percent-encoded name, one already queued, one on another host, and a picture.
The dry run counted every group correctly, `--commit` wrote five `PENDING`
rows and left the `DONE` one alone, and a second `--commit` queued nothing.
The download itself was served by a local stand-in, so what has **not** been
exercised here is a real Supabase fetch — that path is the same
`storage.downloadFile` the worker already uses in production.
