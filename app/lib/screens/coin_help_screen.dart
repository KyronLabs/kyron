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
    final sections = [
      (
        strings.ui('ui_coin_help_section_buying', "Buying coins"),
        [
          (
            strings.ui('ui_coin_help_buy', "How do I buy coins?"),
            strings.ui('ui_coin_help_buy_detail',
                "Choose a coin pack and tap Recharge. You can open Recharge from Wallet or the + beside your balance in the gift sheet. Google Play shows the price and asks you to confirm. Kyron credits the purchased coins once it verifies the completed order.")
          ),
          (
            strings.ui(
                'ui_coin_help_store', "Why do prices or packs look different?"),
            strings.ui('ui_coin_help_store_detail',
                "Recharge shows the packs available in your Google Play storefront and the price in its currency. A pack labelled 100 coins adds 100 coins. The price you pay for a pack does not set a cash value for gifts or earnings.")
          ),
          (
            strings.ui(
                'ui_coin_help_unavailable', "Why is Recharge unavailable?"),
            strings.ui('ui_coin_help_unavailable_detail',
                "Purchases require a supported Android device, a connection to Google Play, and coin packs enabled for your storefront by Kyron. If the shop offers Check again, tap it to reload. Contact support if you expected to see a pack.")
          ),
          (
            strings.ui('ui_coin_help_pending', "I paid. Where are my coins?"),
            strings.ui('ui_coin_help_pending_detail',
                "Check the order status in Google Play. A pending order can take time. If it shows completed, sign in to the Kyron account you used, reopen Recharge and tap Check again if shown. Then refresh Wallet. If the coins are still missing, contact support with the Google Play order reference before buying again.")
          )
        ]
      ),
      (
        strings.ui('ui_coin_help_section_wallet', "Wallet balances and gifts"),
        [
          (
            strings.ui(
                'ui_coin_help_balances', "What does Spendable coins include?"),
            strings.ui('ui_coin_help_balances_detail',
                "This is how many coins you can use to send gifts. Purchased coins come from verified Google Play orders. Reward coins come from Kyron reward programmes. Legacy complimentary coins are unused coins from the retired weekly grant. The three amounts add up to your spendable balance. Gift earnings are tracked separately.")
          ),
          (
            strings.ui(
                'ui_coin_help_spend', "Which coins does a gift use first?"),
            strings.ui('ui_coin_help_spend_detail',
                "Kyron uses legacy complimentary coins first, then reward coins, then purchased coins. For example, a 15-coin gift uses your 5 legacy coins and 10 reward coins if you have both. You need enough spendable coins to cover the full gift. The old weekly allowance no longer refills.")
          ),
          (
            strings.ui(
                'ui_coin_help_refresh', "What does the refresh icon do?"),
            strings.ui('ui_coin_help_refresh_detail',
                "The circular arrow beside the help icon reloads your balance, earnings and recent adjustments. Refreshing is free and does not purchase or grant coins.")
          )
        ]
      ),
      (
        strings.ui('ui_coin_help_section_earnings',
            "Creator earnings and withdrawals"),
        [
          (
            strings.ui(
                'ui_coin_help_qualify', "Why are there two earnings figures?"),
            strings.ui('ui_coin_help_qualify_detail',
                "Total gift earnings counts all coin proceeds you have received from gifts. “From qualifying gifts, before payout checks” is the part funded by purchased coins or approved reward coins. Older earnings with unknown funding and gifts funded by legacy complimentary coins do not qualify. The qualifying figure is already included in the total.")
          ),
          (
            strings.ui(
                'ui_coin_help_withdraw', "What happens when I tap Withdraw?"),
            strings.ui('ui_coin_help_withdraw_detail',
                "Withdraw currently shows the status of bank withdrawals. You cannot submit a bank transfer in the app yet. Buying coins for yourself does not create creator earnings. A qualifying earnings balance is measured in coins and still needs payout checks before any bank payment.")
          ),
          (
            strings.ui(
                'ui_coin_help_rate', "How much are my earnings worth in cash?"),
            strings.ui('ui_coin_help_rate_detail',
                "Wallet shows your coin count and, when available, an estimated purchase value based on the current Google Play price of the 100-coin pack. This estimate includes all spendable coins, even those received as rewards. It does not show how much you paid or how much you can withdraw. Change the display currency in Wallet settings. A cash payout needs a withdrawal quote using the applicable country, currency and conversion rate. No bank payout quote is available in the app yet.")
          )
        ]
      ),
      (
        strings.ui('ui_coin_help_section_activity',
            "Transactions, refunds and support"),
        [
          (
            strings.ui(
                'ui_coin_help_history', "How do I read View transactions?"),
            strings.ui('ui_coin_help_history_detail',
                "View transactions lists your latest 50 coin entries, newest first, in your local time. A plus means coins were credited. A minus means coins were deducted. Gift earnings increase your creator earnings. A purchased coin debit reduces your purchased balance. A gift paid from two coin sources can have two entries.")
          ),
          (
            strings.ui('ui_coin_help_refunds', "What happens after a refund?"),
            strings.ui('ui_coin_help_refunds_detail',
                "After Kyron verifies a Google Play refund, it can remove eligible unspent purchased coins from that order. Recent adjustments shows the verified refund amount in coins and how many coins were actually removed. Those figures can differ when coins have already been spent. A correction appears as coins restored.")
          ),
          (
            strings.ui(
                'ui_coin_help_support', "What should I send to support?"),
            strings.ui('ui_coin_help_support_detail',
                "Tap Contact support below. For a missing purchase, include the pack, purchase date and Google Play order reference. For a wallet adjustment, include its adjustment reference and the amount removed or restored. Keep passwords, bank details and full card numbers private.")
          )
        ]
      ),
    ];
    return Scaffold(
      appBar: KyronAppBar(title: Text(title)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SpacingTokens.space16),
          children: [
            for (final (heading, questions) in sections) ...[
              Padding(
                padding: const EdgeInsets.only(top: SpacingTokens.space16),
                child: Semantics(
                    header: true,
                    child: Text(heading,
                        style: Theme.of(context).textTheme.titleMedium)),
              ),
              for (final (question, answer) in questions)
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
