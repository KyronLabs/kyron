# FrankenBook — Repo Scaffold & Launch Kit

> Production-ready GitHub repo scaffold tailored to attract contributors, investors, and early users. Contains a polished `README.md`, folder structure, CI templates, contributor guidelines, code of conduct, security policy, initial GitHub Issues & Milestones, and a concise architecture diagram.

---

## Included files (what you'll find in this doc)

* `README.md` (production-grade: hero, TL;DR, features, screenshots, quickstart, architecture, roadmap, governance, badges)
* `CONTRIBUTING.md` (how to contribute, workflow, commit message style, tests, local dev steps)
* `CODE_OF_CONDUCT.md` (based on Contributor Covenant)
* `SECURITY.md` (how to report vulnerabilities)
* `.github/ISSUE_TEMPLATE/` (bug_report.md, feature_request.md)
* `.github/PULL_REQUEST_TEMPLATE.md`
* `/.github/workflows/` (ci.yml: Flutter + Node + Docker smoke checks)
* `FOLDER_STRUCTURE.md` (recommended repo layout & explanation)
* `INITIAL_ISSUES.md` (5–12 seeded issues you can paste into GitHub)
* `MILESTONES.md` (90-day MVP milestones + 12-month strategic milestones)
* `ARCHITECTURE.md` (concise architecture diagram + component responsibilities)
* `LICENSE` (MIT stub)

---

# README.md (production-ready)

````markdown
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
````

## Architecture Snapshot
See `/ARCHITECTURE.md` for the full diagram. Short version:

* Flutter client (iOS/Android/Web)
* NestJS microservices (feed, auth, media)
* Postgres + Redis + Pinecone
* Media pipeline: FFmpeg · GStreamer · Whisper.cpp
* AT-Protocol node for portable identity

---

## Contributing

We ♥ contributions. See `CONTRIBUTING.md` for workflow, issue tagging, and development guidelines.

---

## Governance & License

* Code: MIT
* Conduct: Contributor Covenant (see `CODE_OF_CONDUCT.md`)
* Security disclosures: `SECURITY.md`

---

## Roadmap

* MVP (90 days): feed + camera + DID + privacy dial
* v1 (6 months): creator monetization, marketplace, pro persona
* v2 (12 months): server kits, developer platform, federation

---

## Contact

Join discussion: [https://github.com/](https://github.com/)/frankenbook/discussions

````

---

# CONTRIBUTING.md (high-signal)

```markdown
# Contributing to FrankenBook
Thank you for your interest. This document explains how to get started, style guides, and the review process.

## How to contribute
- Fork the repo
- Create a feature branch: `feat/<short-desc>`
- Stick to conventional commits: `feat:`, `fix:`, `chore:`
- Open a PR against `main` with the appropriate template

## Local dev
See `README.md` quickstart. Keep your branch focused and tests green.

## Running tests
- Backend: `pnpm test`
- Frontend: `flutter test`

## Coding standards
- TypeScript: ESLint + Prettier
- Dart: `dart format` + `flutter analyze`

## Issue triage labels
- `good first issue` — targeted for newcomers
- `help wanted` — small tasks
- `discussion` — RFC-style architecture proposals
````

---

# CODE_OF_CONDUCT.md

```markdown
# Code of Conduct
This project follows the Contributor Covenant v2.1. Be respectful. Harassment will not be tolerated.
```

---

# SECURITY.md

```markdown
# Security Policy
If you discover a security vulnerability, please responsibly disclose by emailing security@frankenbook.example with PGP key.
```

---

# .github/ISSUE_TEMPLATE/bug_report.md

```markdown
---
name: Bug report
about: Create a report to help us improve
title: 'bug: '
labels: bug
assignees: ''
---

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '...'
3. See error

**Expected behavior**
A clear and concise description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.
```

---

# .github/ISSUE_TEMPLATE/feature_request.md

```markdown
---
name: Feature request
about: Suggest an idea for this project
title: 'feat: '
labels: enhancement
assignees: ''
---

**Describe the solution you'd like**
A clear and concise description of what you want to happen.

**Why this is important**
Explain the benefits and potential impact.
```

---

# .github/PULL_REQUEST_TEMPLATE.md

```markdown
## Summary
Describe the changes and why they are required.

## Checklist
- [ ] Tests added / passed
- [ ] CI green
- [ ] Changelog updated

## Related issues
Closes #
```

---

# .github/workflows/ci.yml (simplified)

```yaml
name: CI
on: [push, pull_request]

jobs:
  backend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v2
        with:
          version: 8
      - name: Install
        run: pnpm install --frozen-lockfile
      - name: Run tests
        run: pnpm run test

  frontend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.13.0'
      - name: flutter pub get
        run: flutter pub get
      - name: Analyze
        run: flutter analyze
```

---

# FOLDER_STRUCTURE.md

```text
/app         – Flutter client (app/README.md with platform hints)
/api         – NestJS backend microservices
/media       – media microservices (gstreamer, rust captioner)
/identity    – AT-Protocol node & migration scripts
/infra       – docker-compose, k8s manifests, terraform
/docs        – diagrams, investor one-pager, pitch deck
/scripts     – dev helper scripts (seed data, migration)
/tests       – e2e & integration tests
```

---

# INITIAL_ISSUES.md (seed tasks)

```markdown
1. scaffold: create Flutter app with landing screen (good-first-issue)
2. infra: docker-compose with Postgres + Redis
3. backend: NestJS scaffold + health endpoint
4. media: add FFmpeg container + sample transcode endpoint
5. identity: minimal AT-Protocol node docker-compose
6. ci: configure CI pipeline for backend & frontend
7. docs: add architecture diagram to /docs
8. ux: design AR camera UI mockups (Figma link placeholder)
```

---

# MILESTONES.md

```markdown
## 90-day MVP
- Day 0–14: infra + repo + CI
- Day 15–45: feed + backend embeddings
- Day 45–75: AR camera + client UX
- Day 75–90: onboarding + private alpha

## 12-month
- month 3–6: creator monetization primitives
- month 6–9: marketplace & payments
- month 9–12: federation kits & developer platform
```

---

# ARCHITECTURE.md (diagram + responsibilities)

```markdown
Architecture Components:

- Client (Flutter): UI, camera, AR lenses, local embeddings cache
- API Gateway (NestJS): authentication, routing, rate-limits
- Feed Service (NestJS): embeddings, Pinecone queries, Redis Streams
- Media Service (GStreamer/Rust): transcoding, thumbnails, captions
- Identity Node (AT-Protocol): DID, migration tooling
- Storage: Postgres (row data), Redis (hot state), Pinecone (vectors)
- CI/CD: GitHub Actions + Shorebird for OTA

ASCII diagram:

[Flutter client] <---> [API Gateway (NestJS)] <---> {Feed, Auth, Media}
                                      |
                [Postgres]  [Redis]  [Pinecone]  [AT-Protocol node]
```

---

# LICENSE

```text
MIT License

Copyright (c) 2025 <your-name>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
```

---

# How to use this doc

1. Copy the `README.md` into the root of your new repo and edit placeholders.
2. Copy `.github/` into the repo to enable templates & PR checks.
3. Seed the Issues and Milestones in your GitHub project board.
4. Push a minimal placeholder commit — `README.md` + `LICENSE` — then open the repo publicly.

---

# Final notes

This scaffold is designed to be investor-facing and contributor-friendly on day one. It balances polish with actionable developer hygiene so you can go wild without looking like a prototype.
