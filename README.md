<div align="center">

<img src="./docs/favicon.svg" width="88" height="88" alt="Kyron" />

# KYRON

### An open social app you can run yourself

*Flutter client · NestJS API · Postgres. One codebase → Android · iOS · Web.*

<br>

[![CI](https://github.com/KyronLabs/kyron/actions/workflows/flutter-ci.yml/badge.svg)](https://github.com/KyronLabs/kyron/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Stars](https://img.shields.io/github/stars/KyronLabs/kyron?style=social)](https://github.com/KyronLabs/kyron)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

</div>

---

## ◈ What Kyron is

A social app — posts, a ranked feed, threaded comments, direct messages and
communities — built in the open under an MIT licence, so anyone can read how the
ranking works, fork it, or run their own instance.

It is under active development and pre-launch. What follows is what the code
does today. Where something is planned rather than built, it says so.

---

## ◈ Where it stands

### Working

| Area | What it does |
|:--|:--|
| **Accounts** | Email and password over Supabase Auth, JWT verified against JWKS, onboarding gate |
| **Feed** | Ranked by interests, who you follow, what you have liked, how long you read, what you have asked to see less of, and recency; cursor-paged |
| **Posts** | Text, photos, video, polls, voice recordings, link previews, quotes, reposts |
| **Comments** | Real threading at any depth, connector rails, a page per comment, media in replies |
| **Profiles** | Bio, links, avatar and cover, followers and following, editing |
| **Messages** | One-to-one, attachments, read state, mute, block, report, delete. Text is encrypted end to end — [what that does and does not cover](docs/E2EE.md) |
| **Communities** | Create, join, post, moderate, roles, bans, banner and picture |
| **Explore** | Trending hashtags, topics, people you might follow |
| **Moderation** | Report, block, mute people, threads and words |
| **Search** | People, posts and hashtags, with filters |

### Not built yet

Listed because they have been described as finished elsewhere and are not.

| Planned | State today |
|:--|:--|
| AR camera lenses | Not started. The menu entry opens a "coming soon" screen |
| Live video | Not started. Same |
| Portable identity (DID / AT Protocol) | Not started. The column exists; nothing writes to it |
| End-to-end encrypted *posts* | Not started. Direct messages are encrypted; posts are public by nature |
| Creator equity pool | Not started |

The plan, and the order, is in [`ROADMAP.md`](ROADMAP.md).

---

## ◈ Quickstart

**Prerequisites:** Node.js 20 · Flutter (stable channel) · Docker

```bash
# 1. Clone
git clone https://github.com/KyronLabs/kyron.git && cd kyron

# 2. Postgres
docker compose up -d postgres

# 3. API                                    → http://localhost:3000
cd api && npm install && npx prisma migrate deploy && npm run start:dev

# 4. App
cd ../app && flutter pub get && flutter run
```

The API needs `DATABASE_URL` and `SUPABASE_URL` set; it refuses to boot without
them rather than starting in a state that fails later. See
[`api/.env.example`](api/.env.example).

---

## ◈ Architecture

One API, one database. Not microservices — the `identity/` and `media/`
directories are placeholders for services that have not been written.

```
┌─────────────────────────────────────────────┐
│   Flutter  ·  Android · iOS · Web           │
│   Riverpod state  ·  Dio HTTP  ·  REST      │
└───────────────────────┬─────────────────────┘
                        │  HTTPS / JSON
┌───────────────────────┴─────────────────────┐
│   NestJS on Fastify                         │
│   13 REST controllers  ·  rate limited      │
│   Supabase JWT verified against JWKS        │
└───────┬─────────────────────────┬───────────┘
        │  Prisma                 │
┌───────┴───────────┐   ┌─────────┴───────────┐
│  Postgres         │   │  Supabase Storage   │
│  (Supabase)       │   │  photos · video     │
└───────────────────┘   └─────────────────────┘
```

Deployed to Fly.io (`api/fly.toml`); the marketing site and web build are
static on Render (`render.yaml`). More in [`ARCHITECTURE.md`](ARCHITECTURE.md).

---

## ◈ Testing and CI

| Suite | Count | Runs on |
|:--|:--|:--|
| Flutter widget and unit tests | 388 | Every push and PR touching `app/` |
| API unit tests | 292 | Every push and PR touching `api/` |

Locally:

```bash
cd app && flutter analyze && flutter test
cd api && npx tsc --noEmit && npx eslint src && npx jest
```

---

## ◈ Builds and releases

The Flutter client lives in `app/`. Its version is `MAJOR.MINOR.PATCH+BUILD` in
`app/pubspec.yaml`; GitHub Actions supplies the build number from the run
number, so every artifact has a unique Android version code.

Every push to `main` produces a debug APK from the **Flutter Debug Build**
workflow. To cut a release, run **Create Versioned Release** and choose `patch`,
`minor` or `major`: it bumps the version, commits, and tags `vX.Y.Z`, which
starts **Flutter Android Release** to publish a signed APK and App Bundle.

Release signing needs `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`,
`ANDROID_KEY_ALIAS` and `ANDROID_KEY_PASSWORD` as repository secrets. The
keystore is an upload key and must never be committed. A release build fails
when the secret is missing rather than shipping something signed with the debug
key.

---

## ◈ Contributing

Kyron is MIT-licensed and open to contributions.

1. Read [`CONTRIBUTING.md`](CONTRIBUTING.md) and sign your commits (`git commit -s`)
2. Pick something from [`ROADMAP.md`](ROADMAP.md) or the [issues](https://github.com/KyronLabs/kyron/issues)
3. Open a PR against `main`

> **On rewards:** an earlier version of this file promised equity-convertible
> "Kyron Points" for merged PRs. No such agreement, token or programme exists.
> Contribute because the project is useful to you, not because of that promise.

---

## ◈ Governance & Legal

| Topic | Details |
|:--|:--|
| **License** | MIT — see [`LICENSE`](LICENSE) |
| **Code of Conduct** | [Contributor Covenant 2.1](CODE_OF_CONDUCT.md) |
| **Security** | Report to [security@kyron.so](mailto:security@kyron.so) · see [`SECURITY.md`](SECURITY.md) |

---

<div align="center">

*Kyron is built by [KyronLabs](https://github.com/KyronLabs), a subsidiary of [Spidroid Technologies Inc.](https://spidroid.com)*

</div>
