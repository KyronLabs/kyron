# Google Play coin refund and chargeback recovery policy

Status: Owner-approved product rules. Production activation is pending. This policy applies to Google Play purchases of Kyron coins. Activate recovery only for approved markets after the wallet terms, support process, and implementation are ready.

## When recovery applies

A refund or chargeback is eligible only after Kyron links authoritative Google Play evidence to an order credited to the buyer. A notification starts verification. An inconsistent, unmatched, or unverified event stays in review. Chargebacks require an active administrator with a verified second factor to record a recovery referral. A referral opens a case and carries no posting authority by itself.

## What Kyron recovers

1. Calculate the cumulative coin reversal from the original grant and the verified cumulative refunded quantity. Subtract what was already recovered for the order. Repeated evidence creates no additional recovery.
2. Recover unspent purchased coins attributable to the refunded order first. Other orders may cover an eligible remainder only from their unspent purchased coins and only where Kyron has disclosed the pooled-wallet rule to the buyer. A pooled balance alone does not establish eligibility. If records cannot establish which coins are eligible, send the case to staff review before posting.
3. Already-gifted coins must not be recovered by debiting unrelated purchases, even when the pooled-wallet rule applies. Protect reward coins, legacy credits, recipients’ gifts, creator earnings, and payouts from buyer-side recovery.
4. For a refund request Kyron can still decide, default to a partial refund when the eligible unspent quantity supports one, or deny the request when it does not, subject to applicable rights and Google Play’s rules. If Google Play has already completed the refund, retain it as authoritative, recover only eligible coins, and record any shortfall internally. Kyron cannot use a wallet shortfall to retroactively deny a completed refund.
5. Ordinary refunds must not create a negative balance. A negative purchased-coin balance is reserved for a separately approved chargeback, confirmed fraud, or explicit recovery workflow with documented authority, evidence, staff approval and notice. A chargeback referral alone does not authorize it. A negative balance under this policy does not authorize a fiat charge, an automatic future deduction, or recovery of gifted coins from unrelated purchases.

When several orders compete for the same purchased balance, apply outstanding eligible recoveries in verified refund-time order, using the internal purchase ID to break ties. If an earlier case is unresolved or eligibility is uncertain, route competing cases to staff review before debiting.

## User notice and disputes

Show the buyer the order reference, verified refund amount in coins, coins removed, and a way to dispute the adjustment. The wallet display should distinguish an actual debit from any unresolved amount tracked internally. A valid dispute can suspend further staff action on the case. Correct an erroneous debit with a linked compensating entry. Store a minimal audit trail and keep raw purchase tokens and provider responses out of notices and operator-facing logs.

## Posting and activation

Use an idempotent transaction that takes the same buyer wallet lock as gift spending, reloads verified evidence and prior recoveries, establishes order-level eligibility and computes the available unspent purchased balance, and writes the wallet debit, balanced KCOIN posting, and audit evidence together. Preserve order, evidence, coin amount, staff authorization where required, and original posting references. Use cumulative quantities as the cap even when later or overlapping events arrive. Start with staff-approved execution. Require explicit approval before enabling automatic recovery or changing how shortfalls are handled.

Before enabling in a market, add or verify spend attribution that distinguishes gifted coins from unspent coins by order. Until then, the pooled reversal preview is an estimate for review and cannot authorize a debit. Then confirm the terms and notices with the appropriate reviewer, including the treatment of accounts aged 13–17. Validate full and partial refunds, duplicate events, competing orders, concurrent spending, insufficient balances, disputed adjustments, and correction entries against PostgreSQL. Verify recovery controls in a test environment before changing live balances.

[Google Play Voided Purchases API](https://developers.google.com/android-publisher/voided-purchases)
