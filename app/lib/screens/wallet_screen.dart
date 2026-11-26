import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/gift.dart';
import '../providers/auth_provider.dart';
import '../providers/gifts_provider.dart';
import '../routes.dart';
import 'wallet_settings_screen.dart';
import '../widgets/action_button.dart';
import '../widgets/app_sheet.dart';
import 'wallet_transactions_screen.dart';
import '../widgets/hairline.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/play_coin_purchase_panel.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentAuthUserProvider);
    final strings = AppLocalizations.of(context);
    if (user != null) {
      return _WalletBalances(userId: user.id, key: ValueKey(user.id));
    }
    return _WalletFrame(body: Center(child: Text(strings.signInToKyron)));
  }
}

class _WalletFrame extends StatelessWidget {
  const _WalletFrame({required this.body, this.refresh});
  final Widget body;
  final Widget? refresh;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: KyronAppBar(
          title: Text(strings.ui('ui_wallet_title', 'Wallet')),
          actions: [
            if (refresh != null) refresh!,
            ActionIconButton(
                tooltip: strings.ui('ui_wallet_settings', 'Wallet settings'),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                        builder: (_) => const WalletSettingsScreen())),
                icon: Iconsax.setting_2_copy,
                size: kMinInteractiveDimension,
                outlined: false),
          ]),
      body: SafeArea(top: false, child: body),
    );
  }
}

class _WalletBalances extends ConsumerStatefulWidget {
  const _WalletBalances({required this.userId, super.key});

  final String userId;

  @override
  ConsumerState<_WalletBalances> createState() => _WalletBalancesState();
}

class _WalletBalancesState extends ConsumerState<_WalletBalances> {
  late Future<GiftWallet> _wallet = ref.read(giftsRepositoryProvider).wallet();

  void _refresh() {
    if (!mounted || ref.read(currentAuthUserProvider)?.id != widget.userId)
      return;
    ref.invalidate(walletPriceProvider);
    final next = ref.read(giftsRepositoryProvider).wallet();
    setState(() {
      _wallet = next;
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    final quote = ref.watch(walletPriceProvider).asData?.value;
    final currency = ref.watch(walletCurrencyProvider).asData?.value;
    final numbers = NumberFormat.decimalPattern(locale);
    String coins(int count) {
      if (count == 1) return strings.ui('ui_gift_one_coin', '1 coin');
      final units = strings.ui('ui_gift_coins', r'$count coins');
      return units.replaceAll(r'$count', numbers.format(count));
    }

    return FutureBuilder<GiftWallet>(
      future: _wallet,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return _WalletFrame(
              body: Center(
            child: CircularProgressIndicator(
              semanticsLabel: strings.ui(
                'audit_skeleton_loading_18e82bcc',
                'Loading…',
              ),
            ),
          ));
        }

        final wallet = snapshot.data;
        final retry = strings.retry;
        final action = wallet == null ? retry : strings.literalcheckAgain;
        return _WalletFrame(
            refresh: ActionIconButton(
                icon: Iconsax.refresh_copy,
                tooltip: action,
                size: kMinInteractiveDimension,
                outlined: false,
                onPressed: _refresh),
            body: ListView(
              children: [
                if (wallet == null)
                  Padding(
                    padding: const EdgeInsets.all(SpacingTokens.space16),
                    child: Text(
                      strings.literalcouldNotLoadThisList,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                else ...[
                  Padding(
                    padding: const EdgeInsets.all(SpacingTokens.space16),
                    child: _CoinPocket(
                      label:
                          strings.ui('ui_wallet_spendable', 'Spendable coins'),
                      amount: coins(wallet.coins),
                      estimate: quote != null &&
                              (currency == 'AUTO' || currency == quote.currency)
                          ? '${strings.ui('ui_wallet_estimate', 'Estimated purchase value')}  ≈ ${NumberFormat.simpleCurrency(locale: locale, name: quote.currency).format(wallet.coins * quote.perCoin)} ${quote.currency}'
                          : strings.ui('ui_wallet_estimate_missing',
                              'Purchase estimate unavailable'),
                      recharge: strings.ui('ui_wallet_recharge', 'Recharge'),
                      withdraw: strings.ui('ui_wallet_withdraw', 'Withdraw'),
                      onWithdraw: () => showAppSheet<void>(
                          context: context,
                          builder: (context) => SafeArea(
                              child: Padding(
                                  padding: const EdgeInsets.all(
                                      SpacingTokens.space20),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            strings.ui(
                                                'ui_wallet_bank_withdrawals',
                                                'Bank withdrawals'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge),
                                        const SizedBox(
                                            height: SpacingTokens.space12),
                                        Text(strings.ui(
                                            'ui_wallet_withdrawal_availability',
                                            'Bank withdrawals are not available in the app yet. Qualifying gift earnings are reviewed before payout.')),
                                      ])))),
                      onRecharge: () => openCoinPurchaseSheet(
                        context,
                        userId: widget.userId,
                        coins: coins,
                        onWalletChanged: _refresh,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(strings.ui(
                        'ui_wallet_view_transactions', 'View transactions')),
                    trailing: const Icon(Iconsax.arrow_right_3_copy),
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                            builder: (_) => WalletTransactionsScreen(
                                userId: widget.userId))),
                  ),
                  if (_hasCoinSourceBreakdown(wallet)) ...[
                    const Hairline(),
                    _Balance(
                      strings.ui(
                          'ui_wallet_purchased_coins', 'Purchased coins'),
                      coins(wallet.purchased),
                      detail: true,
                    ),
                    const Hairline(),
                    _Balance(
                      strings.ui('ui_wallet_reward_coins', 'Reward coins'),
                      coins(wallet.promotional),
                      detail: true,
                    ),
                    const Hairline(),
                    _Balance(
                      strings.ui(
                        'ui_wallet_legacy_complimentary_coins',
                        'Legacy complimentary coins',
                      ),
                      coins(wallet.legacyComplimentary),
                      detail: true,
                    ),
                  ],
                  const Hairline(),
                  _Balance(
                    strings.ui('ui_wallet_received', 'Total gift earnings'),
                    coins(wallet.earned),
                    prominent: true,
                  ),
                  const Hairline(),
                  _Balance(
                    strings.ui(
                      'ui_wallet_qualifying',
                      'From qualifying gifts, before payout checks',
                    ),
                    coins(wallet.withdrawableEarned),
                  ),
                  const Hairline(),
                  Padding(
                    padding: const EdgeInsets.all(SpacingTokens.space16),
                    child: Text(
                      strings.ui(
                        'ui_gift_rewards_notice',
                        'Coins are not automatically replenished. New coins are awarded through Kyron reward programmes.',
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  if (wallet.recoveryNotices.isNotEmpty) ...[
                    const Hairline(),
                    Padding(
                      padding: const EdgeInsets.all(SpacingTokens.space16),
                      child: Text(
                        strings.ui(
                          'ui_wallet_recent_adjustments',
                          'Recent adjustments',
                        ),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    for (final notice in wallet.recoveryNotices) ...[
                      _Balance(
                        notice.correction
                            ? strings.ui(
                                'ui_wallet_coins_restored',
                                'Coins restored',
                              )
                            : strings.ui(
                                'ui_wallet_coins_removed',
                                'Coins removed',
                              ),
                        coins(notice.coins),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(SpacingTokens.space16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (notice.occurredAt case final date?)
                              Text(DateFormat.yMMMd(locale)
                                  .format(date.toLocal())),
                            if (notice.verifiedRefundCoins case final amount?)
                              Text(
                                strings
                                    .ui(
                                      'ui_wallet_verified_refund',
                                      r'Verified refund: $coins',
                                    )
                                    .replaceAll(r'$coins', coins(amount)),
                              ),
                            if (notice.orderReference case final order?)
                              SelectableText(
                                strings
                                    .ui(
                                      'ui_wallet_play_order',
                                      r'Google Play order: $reference',
                                    )
                                    .replaceAll(r'$reference', order),
                              ),
                            SelectableText(
                              strings
                                  .ui(
                                    'ui_wallet_notice_reference',
                                    r'Adjustment reference: $reference',
                                  )
                                  .replaceAll(r'$reference', notice.id),
                            ),
                            const SizedBox(height: SpacingTokens.space8),
                            ActionButton(
                              label: strings.contactSupport,
                              kind: ActionButtonKind.outlined,
                              onPressed: () => Navigator.pushNamed(
                                context,
                                Routes.settingsContactSupport,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Hairline(),
                    ],
                  ],
                ],
              ],
            ));
      },
    );
  }

  bool _hasCoinSourceBreakdown(GiftWallet wallet) =>
      wallet.purchased != 0 ||
      wallet.promotional != 0 ||
      wallet.legacyComplimentary != 0;
}

class _Balance extends StatelessWidget {
  const _Balance(
    this.label,
    this.value, {
    this.detail = false,
    this.prominent = false,
  });

  final String label;
  final String value;
  final bool detail;
  final bool prominent;

  @override
  Widget build(BuildContext context) {
    final type = Theme.of(context).textTheme;
    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: detail ? type.bodySmall : type.bodyMedium),
            const SizedBox(height: SpacingTokens.space4),
            Text(
              value,
              style: prominent ? type.headlineMedium : type.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _CoinPocket extends StatelessWidget {
  const _CoinPocket(
      {required this.label,
      required this.amount,
      required this.estimate,
      required this.recharge,
      required this.withdraw,
      required this.onWithdraw,
      required this.onRecharge});
  final String label;
  final String amount;
  final String estimate;
  final String recharge;
  final String withdraw;
  final VoidCallback onWithdraw;
  final VoidCallback onRecharge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(builder: (context, constraints) {
          return Stack(alignment: AlignmentDirectional.centerStart, children: [
            Positioned.fill(
                child: Image.asset('assets/wallet/coin-pocket.webp',
                    fit: BoxFit.fill, excludeFromSemantics: true)),
            Container(
              constraints: BoxConstraints(minHeight: constraints.maxWidth / 2),
              padding: EdgeInsets.fromLTRB(
                  SpacingTokens.space24,
                  constraints.maxWidth * .20,
                  SpacingTokens.space24,
                  SpacingTokens.space24),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: theme.textTheme.labelLarge?.copyWith(
                            color: const Color(0xFFE4DBCA), letterSpacing: .6)),
                    const SizedBox(height: SpacingTokens.space4),
                    Row(children: [
                      Image.asset('assets/gifts/coin.png',
                          width: 24, height: 24, excludeFromSemantics: true),
                      const SizedBox(width: SpacingTokens.space8),
                      Flexible(
                          child: Text(amount,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                  color: const Color(0xFFFFF9EF),
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600)))
                    ]),
                    Text(estimate,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: Colors.white)),
                  ]),
            ),
          ]);
        }),
        const SizedBox(height: SpacingTokens.space12),
        Row(children: [
          Expanded(
              child: ActionButton(
                  label: recharge, expand: true, onPressed: onRecharge)),
          const SizedBox(width: SpacingTokens.space8),
          Expanded(
              child: ActionButton(
                  label: withdraw,
                  kind: ActionButtonKind.outlined,
                  expand: true,
                  onPressed: onWithdraw)),
        ]),
      ],
    );
  }
}
