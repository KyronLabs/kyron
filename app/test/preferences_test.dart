import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/app_language.dart';
import 'package:kyron_app/services/app_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('AppLanguage', () {
    test('resolves a known code', () {
      expect(AppLanguage.fromCode('fr'), AppLanguage.french);
    });

    test('falls back to English rather than throwing', () {
      // A code stored by a build that offered a language this one does not
      // must not stop the app from starting.
      expect(AppLanguage.fromCode('xx'), AppLanguage.english);
      expect(AppLanguage.fromCode(null), AppLanguage.english);
      expect(AppLanguage.fromCode(''), AppLanguage.english);
    });

    test('every language has a code, both names, and a locale', () {
      for (final language in AppLanguage.values) {
        expect(language.code, isNotEmpty);
        expect(language.englishName, isNotEmpty);
        expect(language.nativeName, isNotEmpty);
        expect(language.locale.languageCode, language.code);
      }
    });

    test('codes are unique', () {
      final codes = AppLanguage.values.map((l) => l.code).toSet();
      expect(codes, hasLength(AppLanguage.values.length));
    });
  });

  group('AppPreferences', () {
    setUp(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

    test('defaults before anything is stored', () async {
      final prefs = AppPreferences();
      expect(await prefs.readLanguage(), AppLanguage.english);
      expect(await prefs.readTextScale(), AppPreferences.defaultTextScale);
      expect(await prefs.readPushEnabled(), isTrue);
      expect(await prefs.readEmailEnabled(), isTrue);
    });

    test('round-trips a language', () async {
      final prefs = AppPreferences();
      await prefs.writeLanguage(AppLanguage.swahili);
      expect(await prefs.readLanguage(), AppLanguage.swahili);
    });

    test('round-trips a text scale', () async {
      final prefs = AppPreferences();
      await prefs.writeTextScale(1.3);
      expect(await prefs.readTextScale(), 1.3);
    });

    test('rejects a stored scale that is not on offer', () async {
      // A value from a build with a different set would otherwise render at a
      // size no screen was ever checked against.
      SharedPreferences.setMockInitialValues({'pref_text_scale': 4.0});
      expect(
        await AppPreferences().readTextScale(),
        AppPreferences.defaultTextScale,
      );
    });

    test('round-trips the notification switches', () async {
      final prefs = AppPreferences();
      await prefs.writePushEnabled(false);
      await prefs.writeEmailEnabled(false);
      expect(await prefs.readPushEnabled(), isFalse);
      expect(await prefs.readEmailEnabled(), isFalse);
    });

    test('every offered scale has a label', () {
      expect(
        AppPreferences.textScaleLabels,
        hasLength(AppPreferences.textScales.length),
      );
      for (final scale in AppPreferences.textScales) {
        expect(AppPreferences.labelForScale(scale), isNotEmpty);
      }
    });

    test('an unknown scale still gets a sensible label', () {
      expect(AppPreferences.labelForScale(99), 'Small');
    });
  });
}
