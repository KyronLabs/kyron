<div align="center">

<img src="./docs/favicon.svg" width="88" height="88" alt="Kyron" />

# KYRON

### The User-Owned Social Stack

*TikTok-grade discovery. Instagram AR. YouTube shelf-life. Bluesky portability.*  
*One codebase → iOS · Android · Web.*

<br>

[![CI](https://github.com/KyronLabs/kyron/actions/workflows/ci.yml/badge.svg)](https://github.com/KyronLabs/kyron/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Stars](https://img.shields.io/github/stars/KyronLabs/kyron?style=social)](https://github.com/KyronLabs/kyron)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

</div>

---

## ◈ The Problem, In One Sentence

> Five gatekeepers control 90% of social ad spend — and creators keep less than 30 cents of every dollar they generate.

Kyron fixes the ownership layer.

---

## ◈ For Investors

| Signal | Detail |
|:-------|:-------|
| **Problem** | 5 platforms own the graph, the algorithm, and the money |
| **Solution** | Portable identity + on-device AR + vector feed + creator equity pool |
| **Business model** | 10% ad-share pool + white-label enterprise nodes → CF-positive at **250k MAU** (conservative CPM €6) |
| **Moat** | Patent-pending vector-rank engine · GPL-3 AR pipeline · AT Protocol federation |
| **Stage** | Pre-seed · alpha in 90 days · 6 full-stack contributors · MIT-licensed core |

---

## ◈ Why Kyron Exists

Social graphs are **locked gardens**. Your followers, your content, your audience — all held hostage by platforms that could suspend you tomorrow.

Kyron gives every user a **cryptographic passport** (DID). Your identity is yours. Your data leaves with you. Your audience is portable.

| Feature | Status | |
|:--------|:------:|:--|
| Zero-follower discovery | ✅ Live | [Watch demo →](https://v.kyron.so) |
| AR camera lenses · 30fps | ✅ Live | [See a clip →](https://cam.kyron.so) |
| Per-post privacy dial (public → E2EE) | ✅ Live | [See it →](https://gif.kyron.so) |
| Real-time trending · <200ms | ✅ Live | [See it →](https://gif.kyron.so) |
| Creator equity pool · 10% rev-share | 🚧 Soon | Code complete · on testnet |

---

## ◈ Quickstart

> Local dev in under 5 minutes.

**Prerequisites:** Node.js 20 + pnpm · Flutter 3.19 · Docker Desktop

```bash
# 1. Clone
git clone https://github.com/KyronLabs/kyron.git && cd kyron

# 2. Spin up infrastructure
docker compose up -d              # Postgres · Redis · Pinecone-mock

# 3. Start backend
cd api && pnpm i && pnpm dev      # → http://localhost:3000

# 4. Start frontend
cd app && flutter pub get && flutter run -d chrome
```

---

## ◈ Architecture

```
┌────────────────────────────────────────┐
│        Flutter  (iOS · Android · Web)  │
│        AR Camera  ·  Vector Cache      │
└──────────────┬──────────────┬──────────┘
               │  GraphQL+WS  │  gRPC
┌──────────────┴──────────────┴──────────┐
│     NestJS API Gateway   ·  media-svc  │
├──────────────┬──────────────┬──────────┤
│    Redis     │  Postgres    │ Pinecone │
└──────────────┴──────────────┴──────────┘
        ▲                          ▲
        │   AT Protocol Node       │  FFmpeg
        └────── DID + Repo ────────┘
```

Full diagram → [`ARCHITECTURE.md`](ARCHITECTURE.md)

---

## ◈ Roadmap

| Milestone | Target | KPI |
|:----------|:------:|:----|
| **Alpha · MVP** | 90 days | 1k DAUs · feed P95 <300ms |
| **Private Beta** | 6 months | 25k MAU · 40% D1 retention |
| **Public Launch** | 12 months | 250k MAU · cash-flow positive |
| **Federation v2** | 18 months | 50 self-hosted nodes live |

Track everything live → [Projects Board](https://github.com/KyronLabs/kyron/projects)

---

## ◈ Contributing = Equity

We don't do stickers. We do upside.

Every merged PR earns you **Kyron Points** — convertible to future token warrants under our **Contributor Equity Agreement**. Ship real code, earn a real stake.

**Get started:**

1. Browse [`good first issue`](https://github.com/KyronLabs/kyron/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22) labels
2. Read [`CONTRIBUTING.md`](CONTRIBUTING.md) · sign your commits with `git commit -s`
3. Open a PR against `main` → merge → earn

> The DAO snapshot is planned at v1.0. Code decides. Not VCs.

---

## ◈ Governance & Legal

| Topic | Details |
|:------|:--------|
| **License** | MIT — see [`LICENSE`](LICENSE) |
| **Code of Conduct** | [Contributor Covenant 2.1](CODE_OF_CONDUCT.md) |
| **Security** | Report to [security@kyron.so](mailto:security@kyron.so) · PGP key in [`SECURITY.md`](SECURITY.md) |
| **Governance** | DAO snapshot planned at v1.0 — code decides, not VCs |

---

<div align="center">

### ⭐ Star & Share

If you believe social should be **user-owned** —  
star the repo and share it with every creator who deserves more than 30%.

<br>

---

*"Be the lord of your own feed."*

**[kyron.spidroid.com](https://kyron.spidroid.com)** · **[Discord](https://discord.gg/kyron)** · **[Bluesky](https://bsky.app)**

*Kyron is built by [KyronLabs](https://github.com/KyronLabs), a subsidiary of [Spidroid Technologies Inc.](https://spidroid.com)*

</div>

## Flutter builds and releases

The Flutter client lives in `app/`. Its public version is defined in `app/pubspec.yaml` as `MAJOR.MINOR.PATCH+BUILD`. The `MAJOR`, `MINOR`, and `PATCH` components follow semantic versioning. GitHub Actions supplies a monotonically increasing build number from the workflow run number so every generated artifact has a unique Android version code.

Every push to `main` produces a downloadable debug APK from the **Flutter Debug Build** workflow. The **Flutter CI** workflow runs dependency installation, formatting checks, static analysis, and widget tests on pushes and pull requests that modify the Flutter app.

To create a versioned release, open the **Create Versioned Release** workflow in GitHub Actions and choose `patch`, `minor`, or `major`. The workflow updates `app/pubspec.yaml`, commits the change, and creates a matching `vX.Y.Z` tag. The tag starts the **Flutter Android Release** workflow, which publishes a signed APK and Android App Bundle to a GitHub Release.

Before creating a distributable release, configure these repository secrets: `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`, and `ANDROID_KEY_PASSWORD`. The keystore should be an upload key and must never be committed to the repository. Release builds intentionally fail when the keystore secret is absent rather than publishing an artifact signed with the debug key.
