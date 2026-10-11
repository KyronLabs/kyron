# Kyron – Investor One-Pager

Every claim below can be checked against the public repository; most link to
where.

**What it is**

An open-source social app you can run yourself: posts, a ranked feed, threaded
comments, end-to-end encrypted direct messages, communities and an AR camera.
One Flutter codebase for Android, iOS, Windows and the web; one NestJS API over
one Postgres database. MIT licensed.

**Why it is different**

The feed's ranking is code anybody can read — interests, follows, likes, time
spent reading, "show me less of this", recency — and anybody can fork it or run
their own instance. Not a promise of decentralisation: a working app whose rules
are public. [What the app does today](../README.md#-where-it-stands)

**Where it stands**

- **Built and working:** accounts (email or Google), the ranked feed, posts with
  photos, video, polls and voice, comments, profiles, encrypted messages,
  communities with moderation tools, search, push notifications, and AR lenses
  that ship without an app release. [Roadmap, audited against the code](../ROADMAP.md)
- **Measured, not asserted:** the main feed serves 107 requests a second at a
  p95 of 188 ms with sixteen concurrent readers — on one machine against a
  seeded database, so a lower bound rather than a production figure.
  [How it was measured](PERFORMANCE.md)
- **Tested:** over 1,400 automated tests across the app and the API, run in CI
  on every change.
- **Not yet:** no public release — development builds for Android and Windows
  only. The AR camera's face tracking has not yet been run on a physical
  phone. iOS push needs switching on at Apple's end.
  [What the AR camera has and has not been checked on](AR.md)

**What it is not**

- **Not portable identity.** Every account has a decentralised identifier it can
  prove it controls, kept as a fingerprint anybody can verify. Carrying an
  account to another server is not built and not planned.
  [The decision and why](IDENTITY.md)
- **No creator-equity pool, points or token.** None exists, and none is promised.
- **No live video yet.** The options are costed in the
  [kyron-live](https://github.com/KyronLabs/kyron-live) repository; nothing is
  built.

**Team**

**To fill in before this is sent.** The earlier figure — six full-time
contributors — does not match the repository's commit history.

**Market**

**To fill in before this is sent, with a source.** The earlier figures were
unsourced.

**Ask**

$1.5 M seed for 18-month runway (tech + compliance + core team).

**Contact**

pitch@kyron.so

---

*Corrected on 11 October 2026.* An earlier version of this page offered
portable identity, a vector feed, a creator-equity pool, six full-time
contributors and an alpha in ninety days. The repository contains no vector
feed and no equity pool, the identifier was never portable, and there has been
no release. It is in the git history, which is why this note is here rather
than nowhere.
