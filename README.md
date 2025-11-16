<!-- HERO -->
# FrankenBook — A Portable, AR-First, AI-Ranked Social Stack

[![Build Status](https://img.shields.io/badge/ci-passing-brightgreen)]()
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)]()
[![Contributors](https://img.shields.io/badge/contributors-welcome-orange.svg)]()

> One codebase for iOS · Android · Web — TikTok-grade feed, Instagram AR camera, YouTube library, Bluesky portability.

---

## TL;DR
- **Ship** a cross-platform MVP: Flutter front-end + NestJS backend.
- **Key differentiators:** Zero-follower discovery, portable DID identity, per-post privacy dial, AR-first camera, creator equity pool.
- **Goal:** Alpha in 90 days, private beta with 1k creators by month 6.

---

## Why this repo
This project demonstrates a modern, privacy-first social stack that combines rapid discovery, creator-first economics, and portable identity. It's built so a single developer can bootstrap an MVP and scale with contributors.

---

## Features (Day‑1)
- Personalized vector-ranked feed (Pinecone + Redis)
- AR Camera v1 (MediaPipe + Flutter plugin)
- Portable DID auth (AT-Protocol compatible)
- Ephemerity toggle + universal privacy dial
- Lightning (real-time trending)

---

## Quickstart (local dev)
**Prerequisites**
- Windows/macOS/Linux
- Node.js 20 LTS
- Flutter SDK
- Docker Desktop
- Android SDK (Android Studio)
- Git

**Clone & run**
```bash
# clone
git clone https://github.com/<your-org>/frankenbook.git
cd frankenbook

# start infra (Postgres, Redis, Pinecone-mock)
docker compose up -d

# run backend
cd api
pnpm install
pnpm run dev

# run frontend (web)
cd app
flutter pub get
flutter run -d chrome
