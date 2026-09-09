# Kyron Roadmap

What is built, what is not, and the order to do the rest in.

This file is kept honest deliberately. Every "done" below was checked against
the code, not against an older plan. Where the README claims something this
file does not, the README is wrong — see [Correcting the README](#correcting-the-readme).

Last audited: 8 September 2026.

---

## Where the project actually is

A working single-server social app: NestJS + Prisma over one Postgres
(Supabase), a Flutter client, REST between them. 458 Flutter tests and 420 API
tests, both wired to CI. Measured, not guessed: `docs/PERFORMANCE.md`.

### Built and working

| Area | State |
|:--|:--|
| Accounts | Supabase JWT via JWKS, onboarding gate, logout that sticks |
| Feed | Ranked (interests, follows, likes, dwell, negative feedback, recency), cursor-paged |
| Posts | Text, images, video, polls, voice, link previews, quotes, reposts |
| Comments | Real threading at depth, connectors, per-comment pages, media in replies |
| Profiles | Full profile, followers/following, editing, avatar and cover upload |
| Messages | One-to-one, attachments, read state, mute, block, report, delete |
| Communities | Create, join, post, manage, roles, bans, gallery images |
| Explore | Trending hashtags, topics, suggested people |
| Moderation | Report, block, mute users and threads and words |
| Search | People, posts, hashtags, with filters |
| Settings | The whole suite, including every subscreen |
| Security | Anon key shut out of all 40 API tables, RLS on, rate limiting on |
| Operations | Request ids, structured request logs, a guarded `/metrics`, error aggregation |

### Stubs shipped as if finished

| Thing | Reality |
|:--|:--|
| AR camera lenses | Colour lenses and face-tracked ones, published from the kyron-lenses repository rather than compiled in. Flat sprites on 478 landmarks; no 3D, expression or occlusion yet -- `docs/AR.md` |
| Live | `ComingSoonScreen.live()` |
| DID / portable identity | Half built. A real `did:key`, proved by signature -- but nothing consumes it, so it is not portable. `docs/IDENTITY.md` |
| End-to-end encryption | Built for direct messages. X25519 per install, XChaCha20-Poly1305 on the wire, the server holding ciphertext it has no key for -- `docs/E2EE.md`. One device per install, no forward secrecy, no key verification, attachments still in the clear |
| Creator equity pool | No contract, no chain, no testnet |
| `identity/` service | A Dockerfile and three GitHub templates. The Nest module of the same name is real now |
| `media/` service | A Dockerfile |
| Redis | In config and docker-compose, never read by `api/src` |

---

## The order to build in

Sequenced by what unblocks the most, not by what is most exciting. Each phase
is shippable on its own.

### Phase 1 — Make it a live app ✅ done

1. ~~**Push notifications.**~~ Built. `DeliveryService` picks the socket or a
   push per person. Turning it on needs a Firebase project — `docs/PUSH.md`.
   The app still needs one class to supply a token, which is the only step
   that could not be verified without an Android SDK.
2. ~~**Realtime messages.**~~ Built. One authenticated socket at `/realtime`,
   carrying ids; the client fetches through the endpoints it already used.
3. ~~**Realtime notification badge.**~~ Built, on the same channel.
4. ~~**Delivery and read receipts on the wire.**~~ Built. The events existed
   and nothing emitted them; the server now sends `message.read` and
   `message.deleted` to the other side, without a push -- a phone that buzzes
   because somebody read a message is a phone nobody wants. The client applies
   both in place rather than refetching, which would blink the thread being
   read.

### Phase 2 — Close the loop on what exists (weeks)

5. **Media pipeline.** Partly done. An earlier draft of this file said there
   was no size ceiling past the client; that was wrong — the service sniffs the
   type from the bytes and caps at 25 MB, and never trusts an uploaded
   filename. What has since been added: a ceiling per kind, so a photograph
   cannot be 25 MB; real dimensions parsed from the file's own header rather
   than taken from the client, so the feed cannot be made to jump; and a pixel
   ceiling, so a small highly-compressible image cannot decode to hundreds of
   megabytes on every phone that opens the post.

   ~~**Still open: transcoding.**~~ Built, and now off the request thread. A
   clip over 1280p or 2.5 Mbps is re-encoded to H.264 with the index moved to
   the front so playback starts before the file has finished arriving, a poster
   is cut from one second in, and anything over five minutes is refused rather
   than silently truncated. Without ffmpeg the clip is stored exactly as it
   arrived and the service says so at boot.

   The re-encode itself is queued rather than waited for -- it was 93% of the
   upload request -- and writes back over the same path, so the URL the client
   already has keeps working. `docs/MEDIA_JOBS.md`.
6. ~~**Feed quality signals.**~~ Built, and the worst of it was not the
   missing data but the data already being collected and read by nothing:
   every "show me less of this" tap wrote a row that changed no subsequent
   feed. That is now a standing damper on the author, unexpiring, and strong
   enough to outweigh following them -- asking for less of somebody you follow
   is a correction, not a contradiction to split the difference on. "Show me
   more" lifts them, above a like.

   Alongside it: `seen` was one bit with a flat penalty, so a post read four
   times ranked exactly where one glanced at once did. The view row counts the
   opens now and the penalty compounds, floored so nothing is retired for
   good. And it totals dwell, reported when the post leaves the screen and
   when the app goes to the background -- otherwise every read that ends by
   switching apps is lost. Time spent counts towards the author below a like:
   reading something is not endorsing it.
7. ~~**Draft posts and failed-post recovery.**~~ Built. Drafts existed, but
   only on the way out through the "save this?" sheet, so the app being killed
   with the composer open lost everything -- and a phone taking a call is not
   a rare event. The composer writes a couple of seconds after a change, again
   when the app goes to the background, and immediately when a post fails,
   which is exactly when somebody force-quits. Not the three-second poll that
   was removed before: nothing is written unless something was edited.

   Saving also knew a list of fields the composer had outgrown, so a poll
   somebody had filled in went into the draft sheet and came back a bare
   sentence. The poll, topics, reply setting and quoted post are all kept now,
   through one JSON column added to the table rather than one per field.

   And the recovered draft reached the screen's state but never its text box:
   the box is synced once, just after the first frame, and reading a draft off
   the device takes longer than that. The counter under the box showed the
   recovered characters while the box showed nothing, and the first thing
   typed replaced what had been recovered.
8. ~~**Empty and error states audit.**~~ Done, and the finding was not what
   this line expected: empty and failed states were already covered almost
   everywhere, through `EmptyState` and `EmptyState.failed`. The real gap was
   the *loading* state, which was a centred spinner on eleven screens. Those
   are skeletons now, shaped like the rows that replace them. A one-off
   shimmer skeleton on the notifications screen -- its own library, its own
   hardcoded hex colours -- was folded into the same system, and the `shimmer`
   dependency dropped with it.

### Phase 3 — The identity story: started, not finished

The `did` column nobody wrote to is now a real `did:key` that the account
proves it controls -- generated on the device, claimed by signing a
server-issued challenge bound to the account, and verifiable by anyone without
asking Kyron. Along the way it closed a hole: `POST /identity/users` created a
`User` row for anybody on the internet, and `GET /identity/users/:id` answered
with that user's email.

**It is not portable yet, and the README should not say it is.** Nothing
consumes the identifier: no export, no federation, no second server that would
recognise it. It also cannot survive losing the device, which is the gap that
matters most -- an identity you cannot carry to a new phone is not one you can
carry to a new server. `docs/IDENTITY.md` has the full list.

The decision that remains is the same one, now narrower:

- **Carry on.** A recovery phrase, then signed posts, then an export something
  else can read. Each is a real step, and the first two are small.
- **Stop here.** Keep the identifier as a verifiable account fingerprint and
  rewrite the positioning around what Kyron is: an open-source, self-hostable
  social app with communities and a transparent ranking engine. That is a real
  story and it is true today.

### Phase 4 — Scale and operate (months)

9. **Use Redis or remove it.** Still open, and now written down rather than
   left implicit -- see the one-instance section of `docs/OBSERVABILITY.md`.
   The honest position: `fly.toml` runs a single machine that stops when idle,
   so nothing needs Redis today, and three things break the moment there are
   two machines -- the rate limiter counts per process, the realtime service
   holds its sockets in a `Map`, and the metrics below describe whichever
   machine was scraped. `ioredis` and `bullmq` stay installed against that day;
   `REDIS_HOST` is the shape of the answer, not the answer.
10. ~~**Observability.**~~ Built. Every request now carries an id -- generated,
    or taken from an incoming `x-request-id` so it survives a proxy hop, and
    stripped before it reaches a log line or a header -- and produces one
    structured line on stdout, levelled so a 5xx, a 4xx and a slow success read
    differently. `GET /metrics` serves request counts, a duration histogram (so
    a P95 is computed rather than guessed), failures by exception class, and
    the process itself; it is shut and answers 404 unless `METRICS_TOKEN` is
    set. A global filter counts and logs failures without touching the response
    body the client reads.

    Two things worth knowing. The route label is the matched pattern, never the
    URL, with a cardinality ceiling that is reported when it is hit: one series
    per request is how a metrics endpoint takes down its own scraper. And it is
    a Fastify hook rather than a Nest interceptor, because interceptors never
    run for a request a guard rejected -- an interceptor counts the traffic
    that worked and misses every 401.

    Removed with it: a winston logger that rotated fourteen days of files into
    a container destroyed on every deploy, which nothing imported, plus eight
    other dependencies nothing imported at all -- `bcrypt`, `passport`,
    `passport-jwt`, `@nestjs/passport`, `multer`, `@types/multer` and
    `@nestjs/platform-express`, that last one sitting alongside Fastify.
11. ~~**Background jobs.**~~ Done, for the one thing that was genuinely
    inline. Notification fan-out was already off the request thread --
    `DeliveryService` fires and does not await -- and the transcoder already
    probed a clip before re-encoding, so an over-long one was refused without
    paying for it. What held the upload request open was the re-encode of a
    *valid* clip: 4771ms of it on a 4K test clip, against 388ms for everything
    else the request has to do.

    That is a `MediaJob` row now, claimed with `FOR UPDATE SKIP LOCKED` and
    written back over the same storage path so the URL handed out at upload
    keeps working. Postgres rather than Redis, which is what item 9 was really
    asking: one machine does not need a broker, and a table survives the deploy
    that lands mid-encode. `docs/MEDIA_JOBS.md`.
12. ~~**Load testing** against the P95 targets before quoting them.~~ Done, and
    there are now real numbers to quote -- `docs/PERFORMANCE.md`. A
    dependency-free driver lives at `api/scripts/loadtest.mjs`.

    It found four things. The main feed selected the whole post shape for all
    four hundred ranking candidates and returned twenty, making it by a wide
    margin the slowest thing the app does on the screen that opens first; it
    now ranks on six columns and hydrates the page. And underneath that,
    Prisma was compiling every relation `_count` into an aggregate over the
    *entire* table -- so a page of twenty posts paid for every like on the
    service, and splitting the query barely helped because both halves still
    paid it. `Post` carries its own engagement counters now. Together: 31 to
    107 rps at sixteen concurrent readers, p95 615ms to 188ms, and database
    time per request from 29.8ms to 6.9ms. The
    rate limit had never worked -- `ConfigService.get<number>` hands back a
    string, the plugin ignores a non-numeric `max` and silently uses its own
    default of 1000, so every deployment that set the variable got 1000 a
    minute whatever it asked for. And a 429 was being logged as a 500 with a
    full stack, because the limiter throws a plain `Error` rather than a Nest
    `HttpException`.

    Rate limiting is also keyed per account now, falling back to the address.
    One bucket per address means a carrier's NAT shares one limit between
    thousands of phones.

### Phase 5 — The advertised features (quarters)

13. ~~**AR camera.**~~ Built, and it tracks faces now -- this entry used to
    say "there is no tracking of any kind", which stopped being true two
    schemas ago.

    MediaPipe's face mesh runs on the device and returns 478 landmarks. A lens
    states its sizes in pupil-gaps rather than pixels, which is the one
    measurement that keeps meaning the same thing as a head turns, so a lens
    written once is right at any distance and on any face. Three kinds now: a
    colour matrix, pictures hung on a tracked face (schema 2), and effects
    that change the face itself (schema 3) -- a region filled with skin
    sampled off that same face, or everything frosted but the eyes.

    Lenses are published from the kyron-lenses repository rather than compiled
    in, so a new one needs a merge and not a release. Nothing downloaded is
    ever executed: a lens names things the app already knows how to do.

    Still not done: no 3D, no expression (the tracker reports 52 blendshapes
    and nothing reads them), no occlusion, no warping, and no video. And none
    of the tracking has been seen running on a phone -- `docs/AR.md` keeps the
    list of what is checked and what is not.
14. **Live.** Streaming infrastructure is its own project, and the decision
    comes before the code: broadcast or interactive settles the vendor, the
    cost and the client, and the managed options differ by more than price
    (Cloudflare charges per delivered minute regardless of resolution;
    LiveKit charges per gigabyte). Written up with worked numbers in
    the kyron-live repository's `docs/DECISION.md`. The part needing the most
    thought is not cost -- it is that live video cannot be pre-moderated.
15. **Creator equity pool.** Needs legal review before it needs code.

---

## Correcting the README

The README's investor table and feature table state as **✅ Live** several
things that do not exist: AR lenses, per-post E2EE, portable DID identity, and
a creator equity pool described as "code complete · on testnet". The
architecture diagram names GraphQL, gRPC, Pinecone and an AT Protocol node; the
codebase has none of them — it is REST over Dio to 13 Nest controllers.

Smaller inaccuracies: the quickstart says `pnpm` (the API uses npm), and
Flutter 3.19 (CI runs stable, currently 3.35).

This matters beyond tidiness. Those claims sit under a heading that says **For
Investors**. Publishing false capability claims to investors is not a
documentation bug. The README should be rewritten to describe the real system —
which is a substantial, working piece of software that does not need the
embellishment.

---

## Housekeeping

- `web/build/` — 87 build artifacts tracked in git.
- `MILESTONES.md` — deleted; it described a different project.
- `INITIAL_ISSUES.md` — deleted. `FOLDER_STRUCTURE.md` rewritten to match the tree.
- `identity/` and `media/` — empty service shells. Start them or remove them.
