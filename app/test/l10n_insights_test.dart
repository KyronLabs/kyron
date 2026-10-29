import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:kyron_app/l10n/app_localizations.dart';
import 'package:kyron_app/l10n/generated/messages_all.dart';

/// The Insights screen's strings, in every language, read back through the
/// lookup the app uses -- and each still carrying the `{name}` slots the
/// screen fills in. A translation that dropped `{reach}` would show a
/// sentence with the number missing, and no other check would notice.
void main() {
  final dir = Directory('lib/l10n');
  final english = jsonDecode(File('${dir.path}/app_en.arb').readAsStringSync())
      as Map<String, dynamic>;
  final keys = english.keys.where((k) => k.startsWith('ins_')).toList();
  final slots = RegExp(r'\{[a-z]+\}');
  List<String> slotsOf(String s) =>
      slots.allMatches(s).map((m) => m.group(0)!).toList()..sort();

  test('the screen has its strings', () {
    expect(keys.length, greaterThan(60));
  });

  final catalogs = dir
      .listSync()
      .whereType<File>()
      .where((f) => RegExp(r'app_[a-z]+\.arb$').hasMatch(f.path))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  for (final file in catalogs) {
    final locale = RegExp(r'app_([a-z]+)\.arb$').firstMatch(file.path)![1]!;
    final arb = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

    test('$locale: every Insights string reads as its catalog says', () async {
      await initializeMessages(locale);
      Intl.withLocale(locale, () {
        final l10n = AppLocalizations();
        for (final key in keys) {
          final value = arb[key];
          expect(value, isA<String>(), reason: '$locale/$key missing');
          expect(l10n.ui(key, '<fallback>'), value, reason: '$locale/$key');
          expect(
            slotsOf(value as String),
            slotsOf(english[key] as String),
            reason: '$locale/$key lost or gained a {slot}',
          );
        }
      });
    });
  }
}
