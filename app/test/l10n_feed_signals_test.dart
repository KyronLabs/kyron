import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:kyron_app/l10n/app_localizations.dart';
import 'package:kyron_app/l10n/generated/messages_all.dart';

/// The menu's Undo and the Your feed signals screen, read back through the
/// lookup the app uses, in every language, and held to the catalog.
///
/// The ARB check sees the catalogs; the app reads the generated Dart. This
/// is the test that the two agree.
const _keys = [
  'ui_undo',
  'ui_feed_signals',
  'ui_feed_signals_help',
  'ui_feed_signals_intro',
  'ui_feed_signals_empty_title',
  'ui_feed_signals_empty',
  'ui_feed_signal_more',
  'ui_feed_signal_less',
  'ui_feed_signal_fading',
  'ui_feed_signal_removed',
];

void main() {
  final catalogs = Directory('lib/l10n')
      .listSync()
      .whereType<File>()
      .where((f) => RegExp(r'app_[a-z]+\.arb$').hasMatch(f.path))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  test('there are catalogs to read', () {
    expect(catalogs.length, greaterThan(60));
  });

  for (final file in catalogs) {
    final locale = RegExp(r'app_([a-z]+)\.arb$').firstMatch(file.path)![1]!;
    final arb = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

    test('$locale: every feed-signal string reads as its catalog says',
        () async {
      await initializeMessages(locale);
      Intl.withLocale(locale, () {
        final l10n = AppLocalizations();
        for (final key in _keys) {
          expect(arb[key], isA<String>(), reason: '$locale/$key missing');
          expect(
            l10n.ui(key, '<fallback>'),
            arb[key],
            reason: '$locale/$key fell back or differs from the catalog',
          );
        }
      });
    });
  }
}
