# Kyron Flutter app

The Kyron mobile client is a Flutter application. The user-facing copy is catalogued under `lib/l10n` so the same UI can be translated consistently across screens, widgets, drawers, dialogs, bottom sheets, empty states, and form controls.

## Localization workflow

`lib/l10n/app_en.arb` is the English source catalog. `app_es.arb` and `app_zh.arb` must contain the same keys and placeholders; translated values can be added without changing Dart call sites. Generated Intl lookup files live under `lib/l10n/generated` and are committed because the app uses a hand-maintained locale dispatcher.

The repository includes an audit and synchronization workflow from the repository root:

```bash
python3 scripts/audit-dart-literals.py
python3 scripts/extract-ui-candidates.py
python3 scripts/sync-new-l10n-keys.py
python3 scripts/check-localization.py
```

When the catalog changes, regenerate the lookup files with the pinned Dart SDK tooling used by the project, then run formatting and tests:

```bash
dart pub global run intl_translation:generate_from_arb \
  --output-dir=app/lib/l10n/generated \
  app/lib/l10n/app_localizations.dart \
  app/lib/l10n/app_en.arb app/lib/l10n/app_es.arb app/lib/l10n/app_zh.arb
dart format app/lib/l10n app/lib/screens app/lib/widgets
flutter test --no-pub
```

The localization checker fails on missing or extra keys and placeholder drift. Values that remain equal to English are reported for translator review; brand names, technical labels, and symbols may legitimately remain unchanged.

## Getting started

Install the Flutter stable channel, run `flutter pub get` from this directory, and provide the required Supabase values through the project’s documented `--dart-define` configuration. Do not commit secrets or local environment files.
