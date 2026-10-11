# Contributing to Kyron

## Workflow
1. Fork the repo
2. Create a feature branch: `git checkout -b feat/short-desc`
3. Follow [Conventional Commits](https://www.conventionalcommits.org):
   - `feat:` new feature
   - `fix:` bug fix
   - `docs:` documentation
   - `chore:` maintenance
4. Ensure CI passes: `pnpm test` (api) & `flutter test` (app)
5. Open a PR against `main` and fill out the template

## Local Dev
See root [README.md](README.md#quickstart).

## Testing
- Backend: `pnpm run test:cov` (aim ≥ 80 %)
- Flutter: `flutter test --coverage`

## Style
- TypeScript: ESLint + Prettier (auto-run on commit via husky)
- Dart: `dart format .` + `flutter analyze`

## Rewards
There are none. This section used to say that merged PRs earn Kyron Points,
tracked in a `CONTRIBUTORS.md`, which would convert to token warrants at a v1.0
DAO snapshot. No such points, file, token, warrants or DAO exist. The points
that were in the API could be awarded by any signed-in account to any account,
and were removed on 11 October 2026.

Contribute because the project is useful to you.
