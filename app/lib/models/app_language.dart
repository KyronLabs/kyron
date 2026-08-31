import 'dart:ui' show Locale;

/// The languages Kyron offers, defined once.
///
/// The get-started screen and the settings screen each had their own idea of
/// this: settings showed a hard-coded "English" subtitle that no screen wrote
/// to, and the welcome screen's selector took `onChanged: (v) {}` -- a picker
/// that visibly changed and then did nothing at all.
enum AppLanguage {
  english('en', 'English', 'English'),
  spanish('es', 'Spanish', 'Español'),
  french('fr', 'French', 'Français'),
  portuguese('pt', 'Portuguese', 'Português'),
  swahili('sw', 'Swahili', 'Kiswahili'),
  arabic('ar', 'Arabic', 'العربية');

  const AppLanguage(this.code, this.englishName, this.nativeName);

  /// BCP 47 code, and what is persisted.
  final String code;

  /// The name in English, for accessibility labels.
  final String englishName;

  /// The name as a speaker of it would write it, which is what a picker shows.
  final String nativeName;

  Locale get locale => Locale(code);

  /// Falls back to English rather than throwing: a stored code from a build
  /// that offered a language this one does not should not stop the app.
  static AppLanguage fromCode(String? code) {
    for (final language in AppLanguage.values) {
      if (language.code == code) return language;
    }
    return AppLanguage.english;
  }
}
