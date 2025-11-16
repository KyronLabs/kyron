&lt;!--  HERO  --&gt;
# Kyron — The User-Owned Social Stack

[![CI](https://github.com/kyronso/kyron/actions/workflows/ci.yml/badge.svg)](https://github.com/kyronso/kyron/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Stars](https://img.shields.io/github/stars/kyronso/kyron?style=social)](https://github.com/kyronso/kyron)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

&gt; One code-base → iOS · Android · Web.  
&gt; TikTok-grade discovery, Instagram AR camera, YouTube shelf-life, Bluesky portability.

---

## TL;DR for Investors
- **Problem**: 5 gatekeepers control 90 % of social ad spend; creators keep &lt; 30 %.  
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
| Real-time trending (&lt;200 ms) | ✅ | [gif](https://gif.kyron.so) |
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
