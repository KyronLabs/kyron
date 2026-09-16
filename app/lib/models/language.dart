import 'dart:ui' show Locale;

/// One language Kyron can be asked for.
///
/// Three names matter and they are not the same name: the BCP 47 [code] is
/// what is stored and sent, [englishName] is what a screen reader and a
/// support ticket use, and [nativeName] is what the person choosing it reads.
/// Somebody looking for their own language is looking for the last one.
class Language {
  const Language(
    this.code,
    this.englishName,
    this.nativeName, {
    this.rtl = false,
  });

  /// BCP 47, and what is persisted and sent.
  final String code;

  /// The name in English. For accessibility labels and for searching in
  /// English, which is how most people type when the keyboard is not theirs.
  final String englishName;

  /// The name as somebody who speaks it writes it.
  final String nativeName;

  /// Written right to left. Drives text direction, not just the picker.
  final bool rtl;

  Locale get locale => Locale(code);

  /// Whether this is one of the languages [query] is looking for.
  ///
  /// Matches either name and the code, because somebody may type "German",
  /// "Deutsch" or "de" and all three are the same question.
  bool matches(String query) {
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) return true;
    return englishName.toLowerCase().contains(needle) ||
        nativeName.toLowerCase().contains(needle) ||
        code.toLowerCase() == needle;
  }

  @override
  bool operator ==(Object other) => other is Language && other.code == code;

  @override
  int get hashCode => code.hashCode;
}

/// The languages Kyron offers.
///
/// **A starter set, not a finished one.** These are here so the pickers, the
/// storage and the screens can be built and checked against something real;
/// the list itself wants a linguist. Adding one is a single line, and nothing
/// below depends on the length of this list or the order of it.
///
/// Sorted by English name, because that is the order the list is drawn in and
/// a list whose order comes from its data cannot drift from its display.
///
/// Every entry carries its own endonym. Writing "Yoruba" where somebody
/// expects "Yorùbá" is the kind of detail that tells a reader whether the
/// people who built a thing were paying attention.
abstract final class Languages {
  const Languages._();

  /// What a fresh install gets, and what an unknown code falls back to.
  static const fallback = Language('en', 'English', 'English');

  static const all = <Language>[
    Language('af', 'Afrikaans', 'Afrikaans'),
    Language('am', 'Amharic', 'አማርኛ'),
    Language('ar', 'Arabic', 'العربية', rtl: true),
    Language('hy', 'Armenian', 'Հայերեն'),
    Language('az', 'Azerbaijani', 'Azərbaycan'),
    Language('eu', 'Basque', 'Euskara'),
    Language('bn', 'Bengali', 'বাংলা'),
    Language('bg', 'Bulgarian', 'Български'),
    Language('my', 'Burmese', 'မြန်မာ'),
    Language('ca', 'Catalan', 'Català'),
    Language('zh', 'Chinese', '中文'),
    Language('hr', 'Croatian', 'Hrvatski'),
    Language('cs', 'Czech', 'Čeština'),
    Language('da', 'Danish', 'Dansk'),
    Language('nl', 'Dutch', 'Nederlands'),
    fallback,
    Language('et', 'Estonian', 'Eesti'),
    Language('tl', 'Filipino', 'Filipino'),
    Language('fi', 'Finnish', 'Suomi'),
    Language('fr', 'French', 'Français'),
    Language('gl', 'Galician', 'Galego'),
    Language('ka', 'Georgian', 'ქართული'),
    Language('de', 'German', 'Deutsch'),
    Language('el', 'Greek', 'Ελληνικά'),
    Language('gu', 'Gujarati', 'ગુજરાતી'),
    Language('ha', 'Hausa', 'Hausa'),
    Language('he', 'Hebrew', 'עברית', rtl: true),
    Language('hi', 'Hindi', 'हिन्दी'),
    Language('hu', 'Hungarian', 'Magyar'),
    Language('ig', 'Igbo', 'Igbo'),
    Language('id', 'Indonesian', 'Bahasa Indonesia'),
    Language('it', 'Italian', 'Italiano'),
    Language('ja', 'Japanese', '日本語'),
    Language('kn', 'Kannada', 'ಕನ್ನಡ'),
    Language('kk', 'Kazakh', 'Қазақ'),
    Language('km', 'Khmer', 'ភាសាខ្មែ'),
    Language('ko', 'Korean', '한국어'),
    Language('lv', 'Latvian', 'Latviešu'),
    Language('lt', 'Lithuanian', 'Lietuvių'),
    Language('ms', 'Malay', 'Bahasa Melayu'),
    Language('ml', 'Malayalam', 'മലയാളം'),
    Language('mr', 'Marathi', 'मराठी'),
    Language('ne', 'Nepali', 'नेपाली'),
    Language('nb', 'Norwegian Bokmål', 'Norsk bokmål'),
    Language('fa', 'Persian', 'فارسی', rtl: true),
    Language('pl', 'Polish', 'Polski'),
    Language('pt', 'Portuguese', 'Português'),
    Language('pa', 'Punjabi', 'ਪੰਜਾਬੀ'),
    Language('ro', 'Romanian', 'Română'),
    Language('ru', 'Russian', 'Русский'),
    Language('sr', 'Serbian', 'Српски'),
    Language('si', 'Sinhala', 'සිංහල'),
    Language('sk', 'Slovak', 'Slovenčina'),
    Language('sl', 'Slovenian', 'Slovenščina'),
    Language('so', 'Somali', 'Soomaali'),
    Language('es', 'Spanish', 'Español'),
    Language('sw', 'Swahili', 'Kiswahili'),
    Language('sv', 'Swedish', 'Svenska'),
    Language('ta', 'Tamil', 'தமிழ்'),
    Language('te', 'Telugu', 'తెలుగు'),
    Language('th', 'Thai', 'ไทย'),
    Language('tr', 'Turkish', 'Türkçe'),
    Language('uk', 'Ukrainian', 'Українська'),
    Language('ur', 'Urdu', 'اردو', rtl: true),
    Language('uz', 'Uzbek', 'Oʻzbek'),
    Language('vi', 'Vietnamese', 'Tiếng Việt'),
    Language('xh', 'Xhosa', 'isiXhosa'),
    Language('yo', 'Yoruba', 'Yorùbá'),
    Language('zu', 'Zulu', 'isiZulu'),
  ];

  /// Falls back rather than throwing: a code stored by a build whose list was
  /// longer than this one must not stop the app from starting.
  static Language fromCode(String? code) {
    if (code == null) return fallback;
    for (final language in all) {
      if (language.code == code) return language;
    }
    return fallback;
  }

  /// Every stored code that this build still knows, in the list's own order.
  ///
  /// Unknown codes are dropped rather than carried as blanks: a row somebody
  /// cannot read and cannot name is worse than a row that is not there.
  static List<Language> fromCodes(Iterable<String> codes) {
    final wanted = codes.toSet();
    return [
      for (final l in all)
        if (wanted.contains(l.code)) l
    ];
  }

  static List<Language> search(String query) => [
        for (final l in all)
          if (l.matches(query)) l
      ];
}
