# Kyron — The User-Owned Social Stack

[![CI](https://github.com/KyronLabs/kyron/actions/workflows/ci.yml/badge.svg)](https://github.com/KyronLabs/kyron/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Stars](https://img.shields.io/github/stars/KyronLabs/kyron?style=social)](https://github.com/KyronLabs/kyron)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

> One code-base → iOS · Android · Web.  
> TikTok-grade discovery, Instagram AR camera, YouTube shelf-life, Bluesky portability.

---

## TL;DR for Investors
- **Problem**: 5 gatekeepers control 90 % of social ad spend; creators keep < 30 %.  
- **Solution**: portable identity + on-device AR + vector feed + creator-equity pool.  
- **Biz model**: 10 % ad-share pool + white-label enterprise nodes → cash-flow positive at **250 k MAU** (conservative CPM €6).  
- **Moat**: patent-pending vector-rank engine + GPL-3 AR pipeline + AT-Protocol federation.  
- **Stage**: pre-seed, alpha in 90 days, 6 full-stack contributors, MIT-licensed core.

---

## Why Kyron?
Social graphs are **locked gardens**. Kyron gives every user a **cryptographic passport** (DID) that unlocks:

| Feature | Status | Demo |
|---------|--------|------|
| Zero-follower discovery | ✅ | [video](https://v.kyron.so) |
| AR camera lenses (30 fps) | ✅ | [clip](https://cam.kyron.so) |
| Per-post privacy dial (public → e2ee) | ✅ | [gif](https://gif.kyron.so) |
| Real-time trending (<200 ms) | ✅ | [gif](https://gif.kyron.so) |
| Creator equity pool (10 % rev-share) | 🚧 | code complete, test-net |

---

## Quickstart (local dev in 5 min)

**Prerequisites**  
- Node.js 20 + pnpm  
- Flutter 3.19  
- Docker Desktop

```bash
git clone https://github.com/kyronso/kyron.git && cd kyron
docker compose up -d                # Postgres · Redis · Pinecone-mock
cd api && pnpm i && pnpm dev        # backend  → http://localhost:3000
cd app && flutter pub get && flutter run -d chrome   # web client
```

---

## Architecture Snapshot

```
┌─ Flutter (iOS/Android/Web) ─┐
│ AR camera │ vector cache    │
└──────▲───────────▲──────────┘
       │GraphQL+WS │gRPC
┌──────┴───────────┴──────────┐
│ NestJS gateway  │  media-svc│
├──────┬───────────┬──────────┤
│Redis │Postgres   │Pinecone  │
└──────┴───────────┴──────────┘
  ▲                    ▲
  │AT-Protocol node    │FFmpeg
  └────DID+repo────────┘
```

Full diagram → [ARCHITECTURE.md](ARCHITECTURE.md)

---

## Roadmap & KPIs

| Milestone | Date | KPI |
|-----------|------|-----|
| Alpha (MVP) | 90 d | 1 k DAUs, <300 ms feed P95 |
| Private Beta | 6 m | 25 k MAU, 40 % D1 retention |
| Public Launch | 12 m | 250 k MAU, CF-positive |
| Federation v2 | 18 m | 50 self-hosted nodes |

Detailed issues → [Projects board](https://github.com/KyronLabs/kyron/projects)

---

## Contributing = Equity
We use **Contributor Equity Agreements**: every merged PR earns you **Kyron Points** convertible to future token warrants.  
Start with [`good first issue`](https://github.com/KyronLabs/kyron/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22) → ship → get paid in upside, not stickers.

---

## Governance & License
- Code: MIT (see [LICENSE](LICENSE))  
- Conduct: [Contributor Covenant 2.1](CODE_OF_CONDUCT.md)  
- Security: report → security@kyron.so (PGP in [SECURITY.md](SECURITY.md))  
- DAO snapshot planned at v1.0 → code decides, not VCs.

---

## Star ⭐ & Share
If you believe social should be **user-owned**, star the repo and share with creators who deserve better than 30 %.

---
Kyron — *“Be the lord of your own feed.”*
