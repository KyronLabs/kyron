<div align="center">

<img src="./docs/kyron-readme-banner.png" alt="Kyron" width="100%" />

### An open social app you can run yourself

*Flutter client · NestJS API · Postgres. Android is the active app release target; Windows builds are temporarily paused.*

<br>

[![Flutter CI](https://github.com/KyronLabs/kyron/actions/workflows/flutter-ci.yml/badge.svg)](https://github.com/KyronLabs/kyron/actions/workflows/flutter-ci.yml)
[![API CI](https://github.com/KyronLabs/kyron/actions/workflows/api-ci.yml/badge.svg)](https://github.com/KyronLabs/kyron/actions/workflows/api-ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Stars](https://img.shields.io/github/stars/KyronLabs/kyron?style=social)](https://github.com/KyronLabs/kyron)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

<br>

**[See it running →](docs/SCREENSHOTS.md)**

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
| **Accounts** | Email and password or Google over Supabase Auth, JWT verified against JWKS, onboarding gate, a password reset that says what happens next — [turning Google on](docs/GOOGLE_SIGN_IN.md). Deleting the account from Settings, sign-in and all; a request by email is handled with `npm run account:delete` in `api/` |
| **Notifications** | Delivered over the socket when the app is open and as a push when it is not — [how it is wired and what it needs](docs/PUSH.md) |
| **Feed** | Ranked by interests, who you follow, what you have liked, how long you read, what you have asked to see less of, and recency; cursor-paged |
| **Posts** | Text, photos, video, polls, voice recordings, link previews, quotes, reposts |
| **Video** | The API probes public clips, creates a poster and queues oversized/high-bitrate video for background H.264 re-encoding; the original remains available if processing cannot improve it — [how the upload and queue work](docs/MEDIA_JOBS.md) |
| **Comments** | Real threading at any depth, connector rails, a page per comment, media in replies |
| **Profiles** | Bio, links, avatar and cover, followers and following, editing |
| **Messages** | One-to-one, attachments, read state, mute, block, report, delete. Text is encrypted end to end — [what that does and does not cover](docs/E2EE.md) |
| **Communities** | Create, join, post, moderate, roles, bans, banner and picture |
| **AR camera** | Seven colour lenses in the app and more from the catalogue: face-tracked attachments that stay on the eyes, sized in pupil-gaps so one lens is right on any face at any distance, and effects that change the face itself — your nose and mouth taken out under skin sampled from your own cheeks, or everything frosted but the eyes. MediaPipe's mesh, 478 landmarks. Lenses are data, not code, so new ones ship from [their own repo](https://github.com/KyronLabs/kyron-lenses) without an app release — [how the app reads them](docs/LENS_FORMAT.md). No 3D, expression, occlusion or warping — [what is and is not there](docs/AR.md) |
| **Explore** | Trending hashtags, topics, people you might follow |
| **Moderation** | Report, block, mute people, threads and words |
| **Search** | People, posts and hashtags, with filters |
| **Operations** | A request id on every response, structured request logs, error aggregation, and a token-guarded `/metrics` — [what is measurable and what is not](docs/OBSERVABILITY.md) |
| **Performance** | Measured, not asserted — [what every endpoint actually costs](docs/PERFORMANCE.md), and the load test that produced it |
| **All of it** | [Screenshots of every screen above](docs/SCREENSHOTS.md), from a build on a real handset |

### Not built yet

Listed because they have been described as finished elsewhere and are not.

| Planned | State today |
|:--|:--|
| Live video | Not started — the decision, costed, is in [kyron-live](https://github.com/KyronLabs/kyron-live) |
| Portable identity (DID / AT Protocol) | **Not being built — decided, not deferred.** Every account gets a real `did:key` it proves it controls, kept as a fingerprint anybody can verify. Nothing carries an account to another server, and nothing is planned to — [why, and what would change that](docs/IDENTITY.md) |
| End-to-end encrypted *posts* | Not started. Direct messages are encrypted; posts are public by nature |
| Creator equity pool | Not started |

The plan, and the order, is in [`ROADMAP.md`](ROADMAP.md).

---

## ◈ Quickstart

**Prerequisites:** Node.js 22 · Flutter 3.47.9 (the CI-pinned stable version) · Docker

```bash
# 1. Clone
git clone https://github.com/KyronLabs/kyron.git && cd kyron

# 2. Postgres
docker compose up -d postgres
cp api/.env.example api/.env
# Edit api/.env with your local DATABASE_URL and Supabase project values.

# 3. API                                    → http://localhost:3000
cd api && npm ci && npx prisma generate && npx prisma migrate deploy && npm run start:dev

# 4. App
cd ../app && flutter pub get && flutter run
```

The API needs a local `DATABASE_URL` and the appropriate Supabase project
settings, including the server-side service-role key for Storage operations.
It refuses to boot without its required configuration rather than starting in
a state that fails later. See [`api/.env.example`](api/.env.example).

The migrations revoke table access from two roles that only Supabase's Postgres
has. The Docker database creates them on first start; on any other plain
Postgres, run [`infra/postgres/init/01-supabase-roles.sql`](infra/postgres/init/01-supabase-roles.sql)
once before migrating. A Docker volume from an attempt that stopped at
`role "anon" does not exist` needs `docker compose down -v` to start clean.

---

## ◈ Architecture

One API, one database. Kyron is a modular monolith, not a microservice
topology. The top-level `media/` folder is not a deployed service: the active
media upload and background re-encode implementation is part of the API in
`api/src/modules/media/`. The web app is withdrawn; Render still serves a
static download/marketing site from `web/build/web/`.

```
┌─────────────────────────────────────────────┐
│   Flutter client · Android app             │
│   Riverpod · Dio HTTP · REST + WebSocket   │
└───────────────────────┬─────────────────────┘
                        │  HTTPS / JSON
┌───────────────────────┴─────────────────────┐
│   NestJS on Fastify                         │
│   REST controllers + WebSocket gateway     │
│   Supabase JWT verified server-side        │
└───────┬─────────────────────────┬───────────┘
        │  Prisma                 │
┌───────┴───────────┐   ┌─────────┴───────────┐
│  Postgres         │   │  Supabase Storage   │
│  (Supabase)       │   │  photos · video     │
└───────────────────┘   └─────────────────────┘
```

The API and a static download/marketing site both run on Render
(`render.yaml`). The interactive Flutter web app is withdrawn; the current
app release target is Android; Windows packaging is temporarily paused. The API is what
`app/lib/services/api_client.dart` points at, and `/health` on it is the
quickest way to see which Supabase project a deployment is verifying against.
The API runs as a single instance, which is what
`docs/OBSERVABILITY.md` and `docs/PERFORMANCE.md` mean when they say "one
process". More in [`ARCHITECTURE.md`](ARCHITECTURE.md).

**Migrations apply before the API starts.** A merge to `main` redeploys the API,
and [`api/scripts/start.sh`](api/scripts/start.sh) runs `prisma migrate deploy`
with a 180-second default timeout (configurable with `MIGRATE_TIMEOUT`). If a
migration fails or times out, the container exits non-zero and does not start
the API. The startup script never marks a migration as applied automatically.
The API also refuses to finish startup if Postgres remains unreachable after
its connection retries. Check the `[start]` lines in the Render deploy log and
confirm the newest rows in `_prisma_migrations`. `GET /health` reports current
database reachability, not migration currency. Existing databases with an
unrecorded migration history must be reconciled by an operator before this
fail-closed startup path is deployed; do not add automatic baseline resolution.

---

## ◈ The other repositories

This one holds the app, the API and the web build. Five more sit around it, and
each is separate for a reason rather than for tidiness.

| Repository | What it is | Why it is not in here |
|:--|:--|:--|
| [**kyron-lenses**](https://github.com/KyronLabs/kyron-lenses) | The published catalogue of AR lenses: `lenses.json`, the artwork they hang on a face, and `tools/lens.py`, which checks a lens against the format before it goes out. | A lens is data, not code. New lenses reach phones by being merged here, with no app release and nothing to wait for in a store queue. The format is in [`docs/LENS_FORMAT.md`](docs/LENS_FORMAT.md); the app's reader, the catalogue's checker and the studio's checker are all held to one shared file of test vectors. |
| [**kyron-lens-studio**](https://github.com/KyronLabs/kyron-lens-studio) | A Windows desktop tool for authoring those lenses. Paint a sticker, place it on a 3D face, see it the way the camera will, and open a pull request against the catalogue without touching JSON. | Every measurement in a lens is in **pupil-gaps** — multiples of the distance between the two pupils, in a frame that rotates with the head. That is what makes a lens correct on any face at any distance, and it is nothing like how anybody draws. The conversion in both directions is what this tool is. It is Electron rather than Flutter for one reason: a 3D face mockup, and Flutter has no mature 3D. |
| [**design-system**](https://github.com/KyronLabs/design-system) | The colours, spacing, radius and type scales, and the Flutter theme built from them. Pulled in as a git dependency by `app/pubspec.yaml`. | The app is not the only thing that has to look like Kyron. Keeping the tokens out here is what stops a screen inventing its own 14-pixel gap. |
| [**Kyron_Terms_and_Privacy**](https://github.com/KyronLabs/Kyron_Terms_and_Privacy) | The Terms and the Privacy Policy, as static pages. The get-started screen will not let anybody past until they have been shown. | Legal text changes on its own schedule and must not need an app release. The app's links to it are in `app/lib/config/legal_links.dart`. |
| [**kyron-live**](https://github.com/KyronLabs/kyron-live) | Live video. **No system yet, deliberately** — `docs/DECISION.md` costs the options against each other with worked numbers and names the questions that need a human first. | Live is the one part of Kyron where the wrong early choice costs money every month rather than a refactor, and where the hardest problem is not cost: live video cannot be pre-moderated. A finished stream is an ordinary video file, so it lands in the media pipeline this repo already has. |

---

## ◈ Testing and CI

[Pull Request CI](.github/workflows/pr-gate.yml) reports **Kyron PR gate** on
every PR with a merge ref. It runs the API, Flutter, and localization suites
when their paths change and reports success for docs-only changes. Require
the **Kyron PR gate** job in branch protection once it has reported on GitHub.
The individual workflows still run on their existing push triggers.

| Area | Checks | Workflow |
|:--|:--|:--|
| Flutter | Dart formatting, Flutter analysis and widget/unit tests; Android release wiring checks. Windows build validation is paused. | [Flutter CI](.github/workflows/flutter-ci.yml) on app changes and workflow changes |
| API | Production dependency audit, Prisma generation, typecheck, build, Jest unit specs and ESLint | [API CI](.github/workflows/api-ci.yml) on API changes |
| API database | PostgreSQL 16 migrations and database-backed integration specs | Separate job in [API CI](.github/workflows/api-ci.yml) |

Locally:

```bash
cd app && flutter analyze && flutter test
cd api && npx tsc --noEmit && npx eslint src && npx jest
```

---

## ◈ Builds and releases

The Flutter client lives in `app/`. Its version is `MAJOR.MINOR.PATCH+BUILD` in
`app/pubspec.yaml`; GitHub Actions supplies the build number, which is the
number of commits behind the one being built (`scripts/build-number.sh`). Both
build workflows count the same way, so version codes rise across development
builds and releases alike — which phones and Play both require.

Kyron currently publishes Android builds only. Windows packaging is temporarily
paused to stay within the available GitHub Actions artifact-storage allowance.
The Windows project files remain in `app/windows/`, but no Windows app is built
or attached to development or versioned releases.

| | Android |
|---|---|
| **Development build**, on every push to `main` | APKs signed with a private development key, per architecture and universal |
| **Release**, on a `vX.Y.Z` tag | APKs signed with the upload key, per architecture and universal, plus a Play `.aab` |

To cut a release, run **Create Versioned Release** and choose `patch`, `minor`
or `major`. It checks the signing secrets first, then bumps the version,
commits, tags `vX.Y.Z` and starts **Release** on that tag. (It has to start it
by name: a tag pushed with a workflow's own token starts no other workflow.)
The Android build follows the shared checks, then publishes its checked APKs
and Play bundle. `scripts/check-workflows.py` verifies that wiring on every
pull request and keeps the temporary Windows pause from being undone silently.

The Windows runner and packaging script remain in the repository for a later
return to desktop builds. They are not part of current CI or releases. Platform
feature coverage is tracked in [what runs where](app/lib/services/platform_support.dart).

Release signing needs `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`,
`ANDROID_KEY_ALIAS` and `ANDROID_KEY_PASSWORD` as repository secrets, and push
needs `GOOGLE_SERVICES_JSON`. The keystore is the Play upload key and must never
be committed. **Create Versioned Release** opens it with those passwords
(`scripts/check-release-secrets.sh`) before it changes anything, and prints the
key's fingerprints in its run summary. Development builds never receive the
Play upload key. Configure a new private development key as described in
[development signing](app/android/dev-signing/README.md).

Development builds publish their four verified APKs directly to GitHub
Releases from the Android runner. They do not use temporary
Actions artifact storage. The Android job has contents-write permission for
release publication, and checkout does not persist that credential. Temporary
signing files are removed before publishing. Versioned releases retain their
separate artifact and Play-upload jobs.

### Google Play

The `.aab` is what goes to Play; the APKs are for installing by hand. Only
versioned releases create an AAB. It is checked before publication
(`scripts/check-aab.sh`): signed with the upload key and carrying the version
code derived from the release's build number.

Once it is set up (below), every **versioned release** sends its bundle to
**Closed testing - Alpha**, where Kyron's testers are, with its changelog
section as the notes in the listing's default language. Google reviews a
closed testing release before testers get it -- Play Console → **Publishing
overview** shows where it is. To send to another track, set the repository
variable `PLAY_TRACK` (Settings → Secrets and variables → Actions →
Variables) to Play's name for it: `internal` for internal testing, `beta` for
open testing. Never production; the script refuses it, and that stays a
decision made in Play Console. Development builds are not sent and no longer receive the upload key.
Use a versioned release for Play testing, or use the verified development
APKs for sideload testing. With Play App Signing (the default), Google re-signs
the AAB with the app signing key. Verify the release upload certificate against
Play Console's App integrity settings.

#### Sending bundles to Play from CI

Only an app's first bundle has to be uploaded by hand. After that,
`scripts/play-upload.py` sends each release's through Play's Developer API,
as a service account, from the "Send the bundle to Play testing" job in the
Release workflow. Setting it up, once:

1. **Google Cloud Console**, in the project linked to Play Console
   (`601078807832`): APIs & Services → Library → enable the **Google Play
   Android Developer API**.
2. IAM & Admin → **Service accounts** → Create service account (any name,
   e.g. `kyron-play-ci`; it needs no Cloud roles). Open it → Keys → Add key →
   **JSON**. A key file downloads.
3. **Play Console** → Users and permissions → **Invite new users** → the
   service account's email (`…@….iam.gserviceaccount.com`) → App
   permissions → Kyron → **Release apps to testing tracks**. Not admin, and
   not production: a key that leaks can then reach testers and no one else.
4. **GitHub** → Settings → Secrets and variables → Actions → new repository
   secret **`PLAY_SERVICE_ACCOUNT_JSON`**, the whole key file pasted in.
   Then delete the downloaded file. Never commit it, paste it anywhere else,
   or put it in a chat.

The next versioned release sends its bundle. A newly invited service account
can take up to a day before Play lets it in; until then the job fails with
"The caller does not have permission", and the GitHub release is published
regardless. Without the secret the job says so and does nothing, which is
what a fork sees.

Three things follow from Google re-signing it:

- A phone with a development or GitHub release build on it must uninstall that
  first. It is the same package signed with a different key, and Android will
  not install one over the other.
- Google sign-in on a Play install needs the **app signing** key's SHA-1, from
  App integrity, as an Android OAuth client. The upload key's is not the one on
  the phone. [docs/AUTH_GOOGLE.md](docs/AUTH_GOOGLE.md) has the table.
- Every upload needs a higher version code than the last. Each build's is
  100000 plus the commit count, so anything built from later on `main` is
  above anything built before it, whichever workflow built it. The flip side:
  once a bundle is uploaded, an older one cannot follow it, and a re-run of
  the same commit carries the same number. Never force-push `main` — a
  shorter history would number builds below ones already published.

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

*Kyron is built by [KyronLabs](https://github.com/KyronLabs), a division of [Spidroid Technologies](https://spidroid.com)*

</div>
