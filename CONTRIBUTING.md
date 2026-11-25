# Contributing to Kyron

## Workflow
1. Fork the repo
2. Create a feature branch: `git checkout -b feat/short-desc`
3. Follow [Conventional Commits](https://www.conventionalcommits.org):
   - `feat:` new feature
   - `fix:` bug fix
   - `docs:` documentation
   - `chore:` maintenance
4. Ensure CI passes: `npm ci`, `npm run lint`, `npm run typecheck`, `npm test` (api) and `flutter analyze`, `flutter test` (app)
5. Open a PR against `main` and fill out the template

## Local Dev
See root [README.md](README.md#quickstart).

## Testing
- Backend: from `api/`, run `npm test -- --coverage`
- Flutter: `flutter test --coverage`

## Style
- TypeScript: ESLint + Prettier; run `npm run lint` before submitting
- Dart: `dart format .` + `flutter analyze`

## Rewards
There are none. This section used to say that merged PRs earn Kyron Points,
tracked in a `CONTRIBUTORS.md`, which would convert to token warrants at a v1.0
DAO snapshot. No such points, file, token, warrants or DAO exist. The points
that were in the API could be awarded by any signed-in account to any account,
and were removed on 11 October 2026.

Contribute because the project is useful to you.

## Security and contributions

Never include live credentials, signing keys, customer data or production
database exports in changes, logs or issue attachments. Use synthetic
fixtures and local development services. Report vulnerabilities privately
as described in [SECURITY.md](SECURITY.md). Do not test against other
users' accounts. Changes to CI, authentication, authorization, payment
logic and database migrations require maintainer review before deployment.
