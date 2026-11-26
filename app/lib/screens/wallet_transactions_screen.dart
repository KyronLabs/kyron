import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../providers/gifts_provider.dart';
import '../widgets/kyron_app_bar.dart';

class WalletTransactionsScreen extends ConsumerStatefulWidget {
  const WalletTransactionsScreen({required this.userId, super.key});
  final String userId;
  @override
  ConsumerState<WalletTransactionsScreen> createState() => _TransactionsState();
}

class _TransactionsState extends ConsumerState<WalletTransactionsScreen> {
  late var entries = ref.read(giftsRepositoryProvider).transactions();

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    final current = ref.watch(currentAuthUserProvider)?.id;
    return Scaffold(
      appBar: KyronAppBar(
          title: Text(strings.ui('ui_wallet_transactions', 'Transactions'))),
      body: current != widget.userId
          ? Center(child: Text(strings.signInToKyron))
          : FutureBuilder(
              future: entries,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done)
                  return const Center(child: CircularProgressIndicator());
                if (snapshot.hasError || !snapshot.hasData)
                  return Center(
                      child: TextButton(
                          onPressed: () => setState(() => entries =
                              ref.read(giftsRepositoryProvider).transactions()),
                          child: Text(strings.retry)));
                final rows = snapshot.data!;
                if (rows.isEmpty)
                  return Center(
                      child: Text(strings.ui('ui_wallet_transactions_empty',
                          'No coin transactions yet.')));
                return ListView(children: [
                  ListTile(
                      title: Text(strings.ui('ui_wallet_transactions_recent',
                          'Latest 50 coin entries'))),
                  for (final row in rows)
                    ListTile(
                        title: Text(switch (row.kind) {
                          'PURCHASE_GRANT' => strings.ui(
                              'ui_wallet_purchased_coins', 'Purchased coins'),
                          'PURCHASE_SPEND' => strings.ui(
                              'ui_wallet_purchase_debit',
                              'Purchased coin debit'),
                          'REWARD_GRANT' => strings.ui(
                              'ui_wallet_reward_coins', 'Reward coins'),
                          'REWARD_SPEND' ||
                          'SPEND' =>
                            strings.ui('ui_wallet_gift_spend', 'Gift sent'),
                          'GRANT' => strings.ui(
                              'ui_wallet_legacy_complimentary_coins',
                              'Legacy complimentary coins'),
                          'EARN' ||
                          'PURCHASE_EARN' ||
                          'REWARD_EARN' ||
                          'PROMOTIONAL_EARN' =>
                            strings.ui(
                                'ui_wallet_gift_earning', 'Gift earnings'),
                          _ => strings.ui(
                              'ui_wallet_coin_entry', 'Coin adjustment'),
                        }),
                        subtitle: Text(
                            DateFormat.yMMMd(locale).add_jm().format(row.time)),
                        trailing: Text(
                            '${row.amount > 0 ? '+' : ''}${NumberFormat.decimalPattern(locale).format(row.amount)}')),
                ]);
              }),
    );
  }
}
