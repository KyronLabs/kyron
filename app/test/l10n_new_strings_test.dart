import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/l10n/app_localizations.dart';

/// Every string the app looks up by key is in every catalog, and the app
/// really shows it: a key the code names but no catalog has is English in
/// every language, which is how 55 of them shipped.
void main() {
  final used = <String, String>{};
  final call = RegExp(
    r"""\.ui\(\s*['"]([A-Za-z0-9_]+)['"]""",
  );
  for (final file in Directory('lib').listSync(recursive: true)) {
    if (file is! File || !file.path.endsWith('.dart')) continue;
    if (file.path.contains('/l10n/')) continue;
    for (final m in call.allMatches(file.readAsStringSync())) {
      used.putIfAbsent(m.group(1)!, () => file.path);
    }
  }
  final catalogs = Directory('lib/l10n')
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.arb'))
      .toList();

  test('every key the code looks up is in every catalog', () {
    expect(used, isNotEmpty);
    for (final file in catalogs) {
      final catalog = jsonDecode(file.readAsStringSync()) as Map;
      final missing = used.keys.where((k) => !catalog.containsKey(k)).toList();
      expect(missing, isEmpty, reason: '${file.path} lacks $missing');
    }
  });

  // English is the fallback written in the code, so its lookup can lag;
  // every other language has only its lookup.
  test('every key the code looks up is in every translated lookup', () {
    for (final file in Directory('lib/l10n/generated').listSync()) {
      if (file is! File ||
          !file.path.endsWith('.dart') ||
          file.path.endsWith('messages_all.dart') ||
          file.path.endsWith('messages_en.dart')) {
        continue;
      }
      final text = file.readAsStringSync();
      final missing = used.keys
          .where((k) => !text.contains('"$k"') && !text.contains("'$k'"))
          .toList();
      expect(missing, isEmpty, reason: '${file.path} lacks $missing');
    }
  });

  for (final (locale, key, english, expected) in [
    ('fr', 'ui_select_all', 'Select all', 'Tout sélectionner'),
    ('de', 'ui_edit_post', 'Edit post', 'Beitrag bearbeiten'),
    ('ja', 'ui_sort_recent', 'Recent', '新着'),
    ('ar', 'ui_gift_title', 'Send a gift', 'إرسال هدية'),
    ('yo', 'ui_copy', 'Copy', 'Ṣàdàkọ'),
  ]) {
    test('$locale shows its own words for $key', () async {
      final l10n = await AppLocalizations.load(Locale(locale));
      expect(l10n.ui(key, english), expected);
    });
  }

  test('a placeholder survives translation, to be filled in after', () async {
    final l10n = await AppLocalizations.load(const Locale('es'));
    expect(
      l10n.ui('ui_gift_send_named', r'Send $gift').replaceAll(r'$gift', 'Rosa'),
      'Enviar Rosa',
    );
    expect(
      l10n
          .ui('ui_feed_tag_detail', r'Nothing has been posted under #$tab yet.')
          .replaceAll(r'$tab', 'kudu'),
      'Aún no se ha publicado nada en #kudu.',
    );
  });
}
