# Kyron’s first Google Play production release

**Release sequence under consideration.** A social-only first release can precede live finance. The purchase-to-bank milestones below remain the acceptance gates for financial activation. Before submitting a social-only build, verify the exact production configuration and signed candidate in Closed testing, then review the Play Console listing and declarations against the features users can access.

For a social-only deployment, leave CASH_EARNING_GIFTS_ENABLED unset or false, set GOOGLE_PLAY_NEW_SALES_PAUSED=true, and keep creator withdrawal requests and payout submissions disabled. The gift switch pauses every new coin-funded gift on posts and comments. An already committed gift can be retried. Leave authoritative purchase verification, refunds, corrections and support available for existing transactions. Deactivate Play offers for the intended production storefronts and account for any shared testing catalogue. Pausing offers in the API cannot recall a checkout already opened on a device.

Check existing balances and outstanding orders before rollout. Verify that testers can read history and contact support, and that social features work with gifting paused. Review or hide inactive recharge, withdrawal and reward promotions. For new cash-earning markets, establish verified recipient eligibility, approved payout routes, fees, age rules and settlement evidence before switching on acceptance. A global on/off switch alone does not implement country or creator eligibility.

See the [28 November financial flow audit](FINANCIAL_FLOW_AUDIT.md) for the implementation map, evidence and ordered production gates.

## Release baseline

- Production access and an empty production track were previously reported. The 0.1.51 release workflow subsequently uploaded the bundle to Play testing. Current production-track state requires separate verification.
- Main includes the coin ledger, gifts, creator earnings and reservations, server-side Play purchase verification, refund and chargeback evidence, staff-approved recovery and correction, and wallet adjustment notices.
- The Android purchase flow is implemented. The signed tester purchase and credit scenario still needs evidence. Main binds disabled bank payout, FX quote and payout webhook providers. Fiat postings and settlement reconciliation remain open. Production credentials, flags and end-to-end behavior are unverified.
- Production recovery defaults off. Approval of a code change or a green CI run does not establish live readiness.

## Critical path

| Milestone | Work | Completion evidence |
| --- | --- | --- |
| 1. Android coin purchases | Verify the implemented Wallet purchase flow in Flutter. Load Kyron’s server catalogue and [storefront-specific Play prices](README.md#google-play-coin-packs-for-closed-testing), bind purchases to the signed-in account, submit tokens to the existing API, and recover unfinished purchases after restart. Refresh the Wallet after verification. | A Play-installed test build completes a coin purchase and credits exactly once. Pending, cancelled, interrupted, repeated and wrong-account cases pass. |
| 2. Live payout backend | Select the first finance market and bank payout provider. Confirm supported bank rails, currencies, onboarding, FX quote source, fees, status API and webhook contract. Implement the provider, quote adapter and authenticated webhook. Connect the existing withdrawal review, reservation, submission and reconciliation paths. | A provider sandbox withdrawal settles. Replayed webhooks, duplicate submits, expired quotes, timeouts, unknown outcomes, rejections and returns preserve balances and reservations. |
| 3. Fiat and settlement accounting | Define currency-level postings for purchase proceeds, applicable tax and fees, creator liability, FX, payout settlement and returns. Track Play fees separately from Kyron’s commission. Reconcile Play reports and payout provider settlements to immutable events. | Accounting reviewer approves the posting model. A purchase, gift, withdrawal, refund and payout return reconcile in a controlled run. Exceptions are visible with an owner and resolution path. |
| 4. Eligibility and operations | Approve initial financial markets and eligibility for buyers and creators, including treatment of users aged 13–17. Confirm payout onboarding, disclosures, refunds and disputes, activation flags, thresholds, support and incident controls. Keep finance eligibility distinct from app availability. | Approved market and provider settings are documented. Ineligible users cannot buy or withdraw. Staff can review problems, stop new financial activity and reconcile work already in flight. |
| 5. Signed Play candidate | Cut a new version from reviewed main. Verify the signed AAB, upload certificate and unused version code. Put that exact bundle on Closed testing and test the supported purchase-to-settlement path with authorized testers. Verify the production configuration and Play Console disclosures. | Play accepts the AAB. A tester buys coins, gifts them, and the eligible creator’s bank withdrawal settles and reconciles. Refund and chargeback simulations, corrections and support notices also pass. |
| 6. Submit and publish | Promote the tested bundle to the production track with the intended app countries, finance eligibility and reviewed store assets. Submit it for Google review and verify the resulting release status. | Google approves the release, the intended version is visible on the public listing, and launch monitoring shows purchases, withdrawals and reconciliation behaving as expected. |

Run signed purchase acceptance now and correct the Wallet’s gross qualifying earnings projection before enabling withdrawals. Provider and market selection should proceed alongside it because both affect the payout adapter and fiat accounting design. Keep the existing choices of Google Play Billing for coin purchases, bank payouts, dynamic conversion, risk-based earnings availability, and a minimum withdrawal amount to be decided before activation. Do not assume Play’s fee and Kyron’s commission are calculated on the same base.

## How we track this work

Every release PR should identify its milestone and report its verification evidence. Update this roadmap when a milestone is demonstrated or a launch decision changes. Give priority to deliverables that advance the first public financial release. Keep unrelated work outside this sequence unless it blocks a milestone.

The broader [production readiness masterplan](../engineering/PRODUCTION_READINESS_MASTERPLAN.md) and [refund recovery policy](GOOGLE_PLAY_REFUND_RECOVERY_POLICY.md) continue to govern their wider scopes.
