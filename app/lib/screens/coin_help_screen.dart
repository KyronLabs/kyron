import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../routes.dart';
import '../widgets/action_button.dart';
import '../widgets/kyron_app_bar.dart';

void openCoinHelp(BuildContext context) {
  Navigator.of(context).push<void>(
    MaterialPageRoute(builder: (_) => const CoinHelpScreen()),
  );
}

class CoinHelpScreen extends StatelessWidget {
  const CoinHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final title = strings.ui('ui_coin_help', 'Coin help');
    final questions = [
      (
        strings.ui('ui_coin_help_buy', 'How do I buy coins?'),
        strings.ui('ui_coin_help_buy_detail',
            'Choose a coin pack and tap Recharge. Google Play shows the final price and asks you to confirm. Kyron adds the coins after verifying the purchase.'),
      ),
      (
        strings.ui('ui_coin_help_pending', 'Why haven’t my coins appeared?'),
        strings.ui('ui_coin_help_pending_detail',
            'If payment is pending, wait for Google Play to finish it. Reopen the coin shop and tap Check again to look for a completed purchase. Check that you’re signed in to the Kyron account you used to buy the pack.'),
      ),
      (
        strings.ui(
            'ui_coin_help_balances', 'Which coins can I use or withdraw?'),
        strings.ui('ui_coin_help_balances_detail',
            'Purchased and eligible reward coins can be used for gifts. Only qualifying creator earnings can go through payout checks. Your spendable coins and creator earnings are separate balances.'),
      ),
      (
        strings.ui('ui_coin_help_refunds', 'What happens after a refund?'),
        strings.ui('ui_coin_help_refunds_detail',
            'Kyron may adjust your purchased-coin balance after verifying a Google Play refund. Open Recent adjustments in Wallet to find the reference and the number of coins removed or restored. Contact support if you think an adjustment is wrong.'),
      ),
    ];
    return Scaffold(
      appBar: KyronAppBar(title: Text(title)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SpacingTokens.space16),
          children: [
            for (final (index, (question, answer)) in questions.indexed) ...[
              if (index == 0 || index == 2)
                Padding(
                  padding: const EdgeInsets.only(top: SpacingTokens.space12),
                  child: Text(
                    index == 0
                        ? strings.ui(
                            'ui_coin_help_faq', 'Frequently asked questions')
                        : strings.ui('ui_coin_help_policies', 'Coin policies'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ExpansionTile(
                title: Text(question),
                trailing: const Icon(Iconsax.arrow_down_1_copy),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                childrenPadding: const EdgeInsets.fromLTRB(
                  SpacingTokens.space16,
                  0,
                  SpacingTokens.space16,
                  SpacingTokens.space16,
                ),
                children: [Text(answer)],
              ),
            ],
            const SizedBox(height: SpacingTokens.space16),
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
    );
  }
}
