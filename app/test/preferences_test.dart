import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/language.dart';
import 'package:kyron_app/services/app_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('AppPreferences', () {
    setUp(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

    test('defaults before anything is stored', () async {
      final prefs = AppPreferences();
      expect(await prefs.readLanguage(), Languages.fallback);
      expect(await prefs.readTextScale(), AppPreferences.defaultTextScale);
      expect(await prefs.readPushEnabled(), isTrue);
      expect(await prefs.readEmailEnabled(), isTrue);
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
