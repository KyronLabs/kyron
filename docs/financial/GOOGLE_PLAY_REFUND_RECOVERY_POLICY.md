# Google Play coin refund and chargeback recovery policy

Status: Proposed for approval. This policy applies to Google Play purchases of Kyron coins. Activate recovery only for approved markets after the wallet terms, support process, and implementation are ready.

## When recovery applies

A refund or chargeback is eligible only after Kyron links authoritative Google Play evidence to an order credited to the buyer. A notification starts verification. An inconsistent, unmatched, or unverified event stays in review. Chargebacks require an active administrator with a verified second factor to record a recovery referral. A referral opens a case and carries no posting authority by itself.

## What Kyron recovers

1. Calculate the cumulative refundable coin reversal from the original coin grant and the verified cumulative refunded quantity. Subtract the amount already recovered for that order. A repeated notification or observation creates no additional recovery.
2. Recover up to the amount still due from the buyer’s available purchased-coin balance. This is an account-level pool and may contain coins from another order. Disclose that rule before enabling it.
3. Record any remainder as an order-linked unrecovered amount for staff review. Keep the spendable balance at or above zero. The remainder is an internal exposure record. It creates no customer payment obligation and is never automatically collected from future purchases.
4. Protect reward coins, legacy complimentary credits, creator earnings, and bank payouts from buyer-side recovery. Gifts and associated creator earnings stay intact under this policy. Any creator-side action requires a separate policy, evidence and review.

When several orders compete for the same purchased balance, apply outstanding eligible recoveries in verified refund-time order, using the internal purchase ID to break ties. If an earlier case is unresolved or eligibility is uncertain, route competing cases to staff review before debiting.

## User notice and disputes

Show the buyer the order reference, verified refund amount in coins, coins removed, and a way to dispute the adjustment. The wallet display should distinguish an actual debit from any unresolved amount tracked internally. A valid dispute can suspend further staff action on the case. Correct an erroneous debit with a linked compensating entry. Store a minimal audit trail and keep raw purchase tokens and provider responses out of notices and operator-facing logs.

## Posting and activation

Use an idempotent transaction that takes the same buyer wallet lock as gift spending, reloads verified evidence and prior recoveries, computes the available purchased balance, and writes the wallet debit, balanced KCOIN posting, and audit evidence together. Preserve order, evidence, coin amount, staff authorization where required, and original posting references. Use cumulative quantities as the cap even when later or overlapping events arrive. Start with staff-approved execution. Require explicit approval before enabling automatic recovery or changing how shortfalls are handled.

Before enabling in a market, confirm the terms and notices with the appropriate reviewer, including the treatment of accounts aged 13–17. Validate full and partial refunds, duplicate events, competing orders, concurrent spending, insufficient balances, disputed adjustments, and correction entries against PostgreSQL. Verify recovery controls in a test environment before changing live balances.

[Google Play Voided Purchases API](https://developers.google.com/android-publisher/voided-purchases)
