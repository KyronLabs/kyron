import 'dart:io';

import 'package:intl/intl.dart';

import '../models/country.dart';
import '../models/wallet_currencies.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

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

final walletPriceProvider = FutureProvider.autoDispose<WalletPrice?>((
  ref,
) async {
  final user = ref.watch(currentAuthUserProvider);
  if (user == null || kIsWeb || !Platform.isAndroid) return null;
  final token = CancelToken();
  ref.onDispose(token.cancel);
  final catalogue = await ref
      .watch(playCoinsRepositoryProvider)
      .catalogue(token);
  final count = catalogue?.coinsByProduct['coins_100'];
  if (count == null || count != 100) return null;
  final products = await InAppPurchase.instance.queryProductDetails({
    'coins_100',
  });
  if (products.error != null || products.productDetails.length != 1)
    return null;
  final pack = products.productDetails.single;
  if (pack.id != 'coins_100' || !pack.rawPrice.isFinite || pack.rawPrice <= 0)
    return null;
  return (currency: pack.currencyCode, perCoin: pack.rawPrice / count);
});

const _key = 'wallet.displayCurrency';
final walletCurrencyProvider = FutureProvider<String>(
  (ref) async =>
      (await SharedPreferences.getInstance()).getString(_key) ?? 'AUTO',
);

class WalletSettingsScreen extends ConsumerWidget {
  const WalletSettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final code = ref.watch(walletCurrencyProvider).asData?.value ?? 'AUTO';
    final store = ref.watch(walletPriceProvider).asData?.value?.currency;
    final automatic = strings.ui(
      'ui_wallet_store_currency',
      'Google Play currency',
    );
    final locale = Localizations.localeOf(context);
    final names = ref
        .watch(countryNamesProvider(locale.languageCode))
        .asData
        ?.value;
    String symbol(String iso) =>
        const {
          'GHS': 'GH₵',
          'CDF': 'FC',
          'XAF': 'FCFA',
          'AFN': 'Af',
          'ALL': 'L',
          'DZD': 'DA',
          'AOA': 'Kz',
        }[iso] ??
        NumberFormat.simpleCurrency(
          locale: locale.toString(),
          name: iso,
        ).currencySymbol;
    String detail(String iso) {
      final sign = symbol(iso);
      return sign == iso ? iso : '$sign · $iso';
    }

    final countries =
        (walletCountryOrder[locale.languageCode] ?? walletCountryOrder['en']!)
            .split(' ');
    final rank = {
      for (final entry in countries.asMap().entries) entry.value: entry.key,
    };
    final options =
        [
          for (final row in walletCurrencies)
            (
              country: row.country,
              id: '${row.country}:${row.currency}',
              name: names?[row.country] ?? row.country,
              iso: row.currency,
            ),
        ]..sort((a, b) {
          final order = (rank[a.country] ?? countries.length).compareTo(
            rank[b.country] ?? countries.length,
          );
          return order != 0 ? order : a.iso.compareTo(b.iso);
        });
    final active = options.where((row) => row.id == code).firstOrNull;
    return Scaffold(
      appBar: KyronAppBar(
        title: Text(strings.ui('ui_wallet_settings', 'Wallet settings')),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              strings.ui('ui_wallet_set_currency', 'Display currency'),
            ),
            subtitle: Text(
              code == 'AUTO'
                  ? (store == null ? automatic : '$automatic ($store)')
                  : active == null
                  ? detail(code.split(':').last)
                  : '${active.name} · ${detail(active.iso)}',
            ),
            trailing: const Icon(Iconsax.arrow_right_3_copy),
            onTap: names == null
                ? null
                : () async {
                    var selected = code;
                    var query = '';
                    final value = await showModalBottomSheet<String>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => SafeArea(
                        top: false,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.viewInsetsOf(context).bottom,
                          ),
                          child: DraggableScrollableSheet(
                            initialChildSize: .6,
                            minChildSize: .4,
                            maxChildSize: .95,
                            builder: (context, controller) => Material(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(RadiusTokens.radius20),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: StatefulBuilder(
                                builder: (context, update) => Column(
                                  children: [
                                    SizedBox(
                                      height: 56,
                                      child: Row(
                                        children: [
                                          BackButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          Expanded(
                                            child: Text(
                                              strings.ui(
                                                'ui_wallet_set_currency',
                                                'Display currency',
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                              context,
                                              selected,
                                            ),
                                            child: Text(strings.done),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: SpacingTokens.space16,
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Iconsax.search_normal_1_copy,
                                          ),
                                          hintText: strings.search,
                                        ),
                                        onChanged: (text) => update(
                                          () =>
                                              query = text.trim().toLowerCase(),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView(
                                        controller: controller,
                                        children: [
                                          ListTile(
                                            subtitle: Text(
                                              strings.ui(
                                                'ui_wallet_currency_hint',
                                                'Estimates use the current 100-coin pack price. An estimate is available only in the currency Google Play quotes.',
                                              ),
                                            ),
                                          ),
                                          if (query.isEmpty ||
                                              '$automatic ${store ?? ''}'
                                                  .toLowerCase()
                                                  .contains(query))
                                            ListTile(
                                              title: Text(automatic),
                                              subtitle: store == null
                                                  ? null
                                                  : Text(detail(store)),
                                              selected: selected == 'AUTO',
                                              trailing: selected == 'AUTO'
                                                  ? const Icon(
                                                      Iconsax.tick_circle_copy,
                                                    )
                                                  : null,
                                              onTap: () => update(
                                                () => selected = 'AUTO',
                                              ),
                                            ),
                                          for (final row in options)
                                            if ('${row.name} ${row.iso} ${symbol(row.iso)}'
                                                .toLowerCase()
                                                .contains(query))
                                              ListTile(
                                                title: Text(row.name),
                                                subtitle: Text(detail(row.iso)),
                                                selected: selected == row.id,
                                                trailing: selected == row.id
                                                    ? const Icon(
                                                        Iconsax
                                                            .tick_circle_copy,
                                                      )
                                                    : null,
                                                onTap: () => update(
                                                  () => selected = row.id,
                                                ),
                                              ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                    if (value == null || value == code || !context.mounted)
                      return;
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(_key, value);
                    if (context.mounted) ref.invalidate(walletCurrencyProvider);
                  },
          ),
          ListTile(
            title: Text(strings.ui('ui_wallet_coins_faq', 'Coins FAQ')),
            onTap: () => openCoinHelp(context),
          ),
        ],
      ),
    );
  }
}
