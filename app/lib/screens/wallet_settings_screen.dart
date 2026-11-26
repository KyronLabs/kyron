import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../repositories/play_coins_repository.dart';
import '../widgets/kyron_app_bar.dart';
import 'coin_help_screen.dart';

typedef WalletPrice = ({String currency, double perCoin});

final walletPriceProvider =
    FutureProvider.autoDispose<WalletPrice?>((ref) async {
  final user = ref.watch(currentAuthUserProvider);
  if (user == null || kIsWeb || !Platform.isAndroid) return null;
  final token = CancelToken();
  ref.onDispose(token.cancel);
  final catalogue =
      await ref.watch(playCoinsRepositoryProvider).catalogue(token);
  final count = catalogue?.coinsByProduct['coins_100'];
  if (count == null || count != 100) return null;
  final products =
      await InAppPurchase.instance.queryProductDetails({'coins_100'});
  if (products.error != null || products.productDetails.length != 1)
    return null;
  final pack = products.productDetails.single;
  if (pack.id != 'coins_100' || !pack.rawPrice.isFinite || pack.rawPrice <= 0)
    return null;
  return (currency: pack.currencyCode, perCoin: pack.rawPrice / count);
});

const _key = 'wallet.displayCurrency';
final walletCurrencyProvider = FutureProvider<String>((ref) async =>
    (await SharedPreferences.getInstance()).getString(_key) ?? 'AUTO');

class WalletSettingsScreen extends ConsumerWidget {
  const WalletSettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final code = ref.watch(walletCurrencyProvider).asData?.value ?? 'AUTO';
    final store = ref.watch(walletPriceProvider).asData?.value?.currency;
    final automatic =
        strings.ui('ui_wallet_store_currency', 'Google Play currency');
    final options = {
      'AUTO',
      if (store != null) store,
      code,
      'GHS',
      'USD',
      'EUR',
      'GBP',
      'TRY',
      'CDF',
      'XAF'
    };
    return Scaffold(
        appBar: KyronAppBar(
            title: Text(strings.ui('ui_wallet_settings', 'Wallet settings'))),
        body: ListView(children: [
          ListTile(
              title: Text(
                  strings.ui('ui_wallet_set_currency', 'Display currency')),
              subtitle: Text(strings.ui('ui_wallet_currency_hint',
                  'Estimates use the current 100-coin pack price. An estimate is available only in the currency Google Play quotes.')),
              trailing: DropdownButton<String>(
                  value: code,
                  items: [
                    for (final item in options)
                      DropdownMenuItem(
                          value: item,
                          child: Text(item == 'AUTO'
                              ? strings.ui('ui_wallet_auto', 'Auto')
                              : item))
                  ],
                  onChanged: (value) async {
                    if (value == null) return;
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(_key, value);
                    if (context.mounted) ref.invalidate(walletCurrencyProvider);
                  })),
          ListTile(title: Text(automatic), trailing: Text(store ?? '—')),
          ListTile(
              title: Text(strings.ui('ui_wallet_coins_faq', 'Coins FAQ')),
              onTap: () => openCoinHelp(context)),
        ]));
  }
}
