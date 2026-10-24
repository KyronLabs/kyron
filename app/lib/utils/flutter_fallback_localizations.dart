// lib/utils/flutter_fallback_localizations.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../l10n/app_localizations.dart';

/// Every delegate the app is built with, in one place so a test can build
/// with the same ones: Kyron's words, Flutter's in the reader's language
/// where it has them, and Flutter's in English where it has none.
const appLocalizationsDelegates = <LocalizationsDelegate<Object>>[
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  FallbackMaterialLocalizationsDelegate(),
  FallbackCupertinoLocalizationsDelegate(),
];

/// Flutter's own words -- "Back", "OK", "Cut", the date picker -- in English,
/// for the languages Kyron is translated into and Flutter is not.
///
/// Yoruba, Hausa, Igbo, Xhosa and Somali are in Kyron's language list, and
/// Flutter ships no Material or Cupertino strings for any of them. Choosing
/// one left the app with none at all, and every back button, app bar and
/// dialog threw while building. Kyron's own words still come from the
/// chosen language; only Flutter's fall back.
class FallbackMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      !GlobalMaterialLocalizations.delegate.isSupported(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      GlobalMaterialLocalizations.delegate.load(const Locale('en'));

  @override
  bool shouldReload(FallbackMaterialLocalizationsDelegate old) => false;
}

/// The Cupertino half of [FallbackMaterialLocalizationsDelegate].
class FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      !GlobalCupertinoLocalizations.delegate.isSupported(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      GlobalCupertinoLocalizations.delegate.load(const Locale('en'));

  @override
  bool shouldReload(FallbackCupertinoLocalizationsDelegate old) => false;
}
