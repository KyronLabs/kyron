# Kyron Roadmap

What is built, what is not, and the order to do the rest in.

This file is kept honest deliberately. Every "done" below was checked against
the code, not against an older plan. Where the README claims something this
file does not, the README is wrong — see [Correcting the README](#correcting-the-readme).

Last audited: 7 September 2026.

---

## Where the project actually is

A working single-server social app: NestJS + Prisma over one Postgres
(Supabase), a Flutter client, REST between them. 388 Flutter tests and 292 API
tests, both wired to CI.

### Built and working

| Area | State |
|:--|:--|
| Accounts | Supabase JWT via JWKS, onboarding gate, logout that sticks |
| Feed | Ranked (interests, follows, likes, recency), cursor-paged |
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

### Stubs shipped as if finished

| Thing | Reality |
|:--|:--|
| AR camera lenses | `ComingSoonScreen.arLens()`. No camera code exists |
| Live | `ComingSoonScreen.live()` |
| DID / portable identity | A nullable column. Generation is a commented-out TODO |
| End-to-end encryption | No encryption code anywhere in the repo |
| Creator equity pool | No contract, no chain, no testnet |
| `identity/` service | A Dockerfile and three GitHub templates |
| `media/` service | A Dockerfile |
| Redis | In config and docker-compose, never read by `api/src` |

---

## The order to build in

Sequenced by what unblocks the most, not by what is most exciting. Each phase
is shippable on its own.

### Phase 1 — Make it a live app (highest value, weeks)

Everything here is invisible in a screenshot and decisive in use.

1. **Push notifications.** There is no FCM, no APNs, no local notifications —
   nothing. A social app nobody can be told about is one people open once. This
   is the single biggest retention gap in the project.
2. **Realtime messages.** Chat polls. A conversation that does not update until
   you pull it is the most visible unfinished thing in the product. WebSocket or
   SSE on the existing gateway; the notification badge rides the same channel.
3. **Realtime notification badge.** Falls out of (2) once the channel exists.
4. **Delivery and read receipts on the wire** rather than inferred from a
   refresh.

### Phase 2 — Close the loop on what exists (weeks)

5. **Media pipeline.** Video is uploaded as-is: no transcode, no thumbnail
   generation server-side, no size ceiling enforced beyond the client. One large
   upload from one user degrades the feed for everyone. This is what `media/`
   was meant to be.
6. **Feed quality signals.** Ranking has no dwell time, no negative feedback,
   no "seen" decay beyond the view record. The engine is there; it is being fed
   almost nothing.
7. **Draft posts and failed-post recovery.** A composer that loses work on a
   dropped connection.
8. **Empty and error states audit.** Several screens still show a spinner where
   an explanation belongs.

### Phase 3 — Decide the identity story (weeks, mostly design)

The README sells portable identity as the reason Kyron exists. It does not
exist. There are two honest paths and the project has to pick one:

- **Build it.** AT Protocol node, real DID generation, repo export. This is a
  quarter of work minimum and changes the data model.
- **Drop it.** Rewrite the positioning around what Kyron actually is: an
  open-source, self-hostable social app with communities and a transparent
  ranking engine. That is a real story and it is true today.

Half-shipping it — a `did` column nobody writes to — is the worst of both.

### Phase 4 — Scale and operate (months)

9. **Use Redis or remove it.** Feed caching, trending counts, rate-limit state,
   session revocation. Right now it is a dependency the project pays for in
   setup complexity and gets nothing from.
10. **Observability.** No metrics, no traces, no error aggregation. None of the
    KPIs in the README can currently be measured, so none of them can be
    claimed.
11. **Background jobs.** Trending recomputation, notification fan-out and media
    processing all run inline on request threads today.
12. **Load testing** against the P95 targets before quoting them.

### Phase 5 — The advertised features (quarters)

13. **AR camera.** A real camera pipeline with lenses. Large, and worth doing
    only after Phases 1–2 make the app worth opening daily.
14. **Live.** Streaming infrastructure is its own project.
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
- `MILESTONES.md` — describes a different project; fold into this file or delete.
- `INITIAL_ISSUES.md`, `FOLDER_STRUCTURE.md` — stale.
- `identity/` and `media/` — empty service shells. Start them or remove them.
