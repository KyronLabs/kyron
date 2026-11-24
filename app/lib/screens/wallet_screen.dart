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
                      wallet == null
                          ? strings.literalcouldNotLoadThisList
                          : strings.ui('analytics_coins', 'Coins'),
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
            if (wallet != null) ...[
              const Hairline(),
              _Balance(
                strings.ui('ui_wallet_spendable', 'Spendable coins'),
                coins(wallet.coins),
              ),
              const Hairline(),
              _Balance(
                strings.ui('ui_wallet_received', 'Total gift earnings'),
                coins(wallet.earned),
              ),
              const Hairline(),
              _Balance(
                strings.ui(
                  'ui_wallet_qualifying',
                  'From qualifying gifts, before payout checks',
                ),
                coins(wallet.withdrawableEarned),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _Balance extends StatelessWidget {
  const _Balance(this.label, this.value);

  final String label;
  final String value;

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
          ],
        ),
      ),
    );
  }
}
