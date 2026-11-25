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
import '../widgets/action_button.dart';
import '../widgets/hairline.dart';
import '../widgets/kyron_app_bar.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentAuthUserProvider);
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: KyronAppBar(title: Text(strings.ui('ui_wallet_title', 'Wallet'))),
      body: SafeArea(
        top: false,
        child: user == null
            ? Center(
                child: Text(strings.signInToKyron),
              )
            : _WalletBalances(key: ValueKey(user.id)),
      ),
    );
  }
}

class _WalletBalances extends ConsumerStatefulWidget {
  const _WalletBalances({super.key});

  @override
  ConsumerState<_WalletBalances> createState() => _WalletBalancesState();
}

class _WalletBalancesState extends ConsumerState<_WalletBalances> {
  late Future<GiftWallet> _wallet = ref.read(giftsRepositoryProvider).wallet();

  void _refresh() {
    final next = ref.read(giftsRepositoryProvider).wallet();
    setState(() {
      _wallet = next;
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
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
          return Center(
            child: CircularProgressIndicator(
              semanticsLabel: strings.ui(
                'audit_skeleton_loading_18e82bcc',
                'Loading…',
              ),
            ),
          );
        }

        final wallet = snapshot.data;
        final retry = strings.retry;
        final action = wallet == null ? retry : strings.literalcheckAgain;
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(SpacingTokens.space16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      strings.ui('analytics_coins', 'Coins'),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  ActionIconButton(
                    icon: Iconsax.refresh_copy,
                    tooltip: action,
                    size: kMinInteractiveDimension,
                    outlined: false,
                    onPressed: _refresh,
                  ),
                ],
              ),
            ),
            const Hairline(),
            if (wallet == null)
              Padding(
                padding: const EdgeInsets.all(SpacingTokens.space16),
                child: Text(
                  strings.literalcouldNotLoadThisList,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )
            else ...[
              _Balance(
                strings.ui('ui_wallet_spendable', 'Spendable coins'),
                coins(wallet.coins),
                prominent: true,
              ),
              if (_hasCoinSourceBreakdown(wallet)) ...[
                const Hairline(),
                _Balance(
                  strings.ui('ui_wallet_purchased_coins', 'Purchased coins'),
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
                          Text(DateFormat.yMMMd(locale).format(date.toLocal())),
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
        );
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
