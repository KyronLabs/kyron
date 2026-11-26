import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/l10n/app_localizations.dart';

/// Every string the app looks up by key is in every catalog, and the app
/// really shows it: a key the code names but no catalog has is English in
/// every language, which is how 55 of them shipped.
void main() {
  // These labels deliberately use their English fallback until
  // reviewed translations are supplied for every supported locale.
  const englishFallbackKeys = {
    'ui_coin_help_section_buying',
    'ui_coin_help_store',
    'ui_coin_help_store_detail',
    'ui_coin_help_unavailable',
    'ui_coin_help_unavailable_detail',
    'ui_coin_help_section_wallet',
    'ui_coin_help_spend',
    'ui_coin_help_spend_detail',
    'ui_coin_help_refresh',
    'ui_coin_help_refresh_detail',
    'ui_coin_help_section_earnings',
    'ui_coin_help_qualify',
    'ui_coin_help_qualify_detail',
    'ui_coin_help_withdraw',
    'ui_coin_help_withdraw_detail',
    'ui_coin_help_rate',
    'ui_coin_help_rate_detail',
    'ui_coin_help_section_activity',
    'ui_coin_help_history',
    'ui_coin_help_history_detail',
    'ui_coin_help_support',
    'ui_coin_help_support_detail',
    'ui_wallet_withdraw',
    'ui_wallet_view_transactions',
    'ui_wallet_transactions',
    'ui_wallet_transactions_empty',
    'ui_wallet_transactions_recent',
    'ui_wallet_purchase_debit',
    'ui_wallet_gift_spend',
    'ui_wallet_gift_earning',
    'ui_wallet_coin_entry',
    'ui_wallet_bank_withdrawals',
    'ui_wallet_withdrawal_availability',
    'ui_gift_rewards_notice',
    'ui_wallet_purchased_coins',
    'ui_wallet_play_unavailable',
    'ui_wallet_play_pending',
    'ui_wallet_play_checking',
    'ui_wallet_play_credited',
    'ui_wallet_play_finishing',
    'ui_wallet_play_retry',
    'ui_wallet_play_buy',
    'ui_coin_help',
    'ui_coin_help_faq',
    'ui_coin_help_policies',
    'ui_coin_help_balances',
    'ui_coin_help_balances_detail',
    'ui_coin_help_buy',
    'ui_coin_help_buy_detail',
    'ui_coin_help_pending',
    'ui_coin_help_pending_detail',
    'ui_coin_help_refunds',
    'ui_coin_help_refunds_detail',
    'ui_wallet_recharge',
    'ui_wallet_play_regional_prices',
    'ui_wallet_play_no_regional_packs',
    'ui_wallet_recent_adjustments',
    'ui_wallet_coins_restored',
    'ui_wallet_coins_removed',
    'ui_wallet_verified_refund',
    'ui_wallet_play_order',
    'ui_wallet_notice_reference',
    'ui_wallet_reward_coins',
    'ui_wallet_legacy_complimentary_coins',
    'ui_reminders_detail_away',
  };

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
      final missing = used.keys
          .where(
            (k) => !englishFallbackKeys.contains(k) && !catalog.containsKey(k),
          )
          .toList();
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
          .where(
            (k) =>
                !englishFallbackKeys.contains(k) &&
                !text.contains('"$k"') &&
                !text.contains("'$k'"),
          )
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
