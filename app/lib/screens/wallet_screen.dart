import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/gift.dart';
import '../providers/auth_provider.dart';
import '../providers/gifts_provider.dart';
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
                child: Text(
                  strings.ui(
                    'ui_wallet_sign_in',
                    'Sign in to view your wallet.',
                  ),
                ),
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
    setState(() => _wallet = ref.read(giftsRepositoryProvider).wallet());
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    final numbers = NumberFormat.decimalPattern(locale);
    return FutureBuilder<GiftWallet>(
      future: _wallet,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(
              semanticsLabel: strings.ui('ui_wallet_loading', 'Loading wallet'),
            ),
          );
        }
        final wallet = snapshot.data;
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(SpacingTokens.space16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      wallet == null
                          ? strings.ui(
                              'ui_wallet_error',
                              'Could not load your wallet.',
                            )
                          : strings.ui('ui_wallet_balances', 'Coin balances'),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  ActionIconButton(
                    icon: Iconsax.refresh_copy,
                    tooltip: wallet == null
                        ? strings.ui('ui_wallet_retry', 'Retry')
                        : strings.ui('ui_wallet_refresh', 'Refresh balances'),
                    size: kMinInteractiveDimension,
                    outlined: false,
                    onPressed: _refresh,
                  ),
                ],
              ),
            ),
            if (wallet != null) ...[
              const Hairline(),
              _Balance(
                strings.ui('ui_wallet_spendable', 'Spendable coins'),
                numbers.format(wallet.coins),
              ),
              const Hairline(),
              _Balance(
                strings.ui(
                  'ui_wallet_received',
                  'Total gift earnings in coins',
                ),
                numbers.format(wallet.earned),
              ),
              const Hairline(),
              _Balance(
                strings.ui(
                  'ui_wallet_qualifying',
                  'Qualifying gift earnings in coins',
                ),
                numbers.format(wallet.withdrawableEarned),
                detail: strings.ui(
                  'ui_wallet_qualifying_detail',
                  'Included in total gift earnings. Payout eligibility and '
                      'holds are checked separately.',
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _Balance extends StatelessWidget {
  const _Balance(this.label, this.value, {this.detail});

  final String label;
  final String value;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final type = Theme.of(context).textTheme;
    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: type.bodyMedium),
            const SizedBox(height: SpacingTokens.space4),
            Text(value, style: type.headlineMedium),
            if (detail != null) ...[
              const SizedBox(height: SpacingTokens.space8),
              Text(detail!, style: type.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}
