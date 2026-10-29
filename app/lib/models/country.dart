// lib/models/country.dart
import 'dart:convert';
import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'countries.g.dart';

export 'countries.g.dart' show countryCodes;

/// Where somebody is, as a country picked from a list.
///
/// A list and not a text field: "Lagos", "lagos nigeria" and "9ja" are one
/// place and three strings, and only one of the three could ever be counted
/// in Insights. Countries rather than cities because a city on every post
/// says more about somebody than they mean to say, and because a list of
/// cities is a list nobody can scroll. See docs/INSIGHTS.md.
abstract final class Countries {
  static final Set<String> _known = {...countryCodes};

  static bool isCode(String? code) => code != null && _known.contains(code);

  /// The flag, from the two regional-indicator letters that make one.
  ///
  /// Every phone draws these from its emoji font, so the flag costs nothing
  /// to ship. Windows has no flag emoji and shows the two letters instead,
  /// which still says which country it is.
  static String flag(String code) => String.fromCharCodes([
        for (final unit in code.toUpperCase().codeUnits) 0x1F1E6 + unit - 0x41,
      ]);

  /// The countries the phone's own settings point at, most likely first.
  ///
  /// From the region of each language the phone is set to ("en_NG"). Only a
  /// suggestion, shown at the top of the list and never chosen for anybody:
  /// plenty of phones in Lagos say en_US.
  static List<String> suggested([List<Object?>? regions]) {
    final from = regions ??
        [for (final l in PlatformDispatcher.instance.locales) l.countryCode];
    final out = <String>[];
    for (final region in from) {
      final code = '${region ?? ''}'.toUpperCase();
      if (isCode(code) && !out.contains(code)) out.add(code);
    }
    return out;
  }
}

/// Country names in one of the app's languages, code to name.
///
/// From Unicode CLDR (scripts/generate-countries.py), one small file per
/// language, read the first time it is needed and then kept. A language
/// without a file reads English.
final countryNamesProvider =
    FutureProvider.family<Map<String, String>, String>((ref, language) async {
  Future<Map<String, String>> read(String l) async {
    // Not the bundle's cache as well: this provider is the cache, and the
    // bundle's would hold a second copy of every language read.
    final raw = await rootBundle.loadString(
      'assets/countries/$l.json',
      cache: false,
    );
    return (jsonDecode(raw) as Map<String, dynamic>).cast<String, String>();
  }

  try {
    return await read(language);
  } catch (_) {
    return read('en');
  }
});
