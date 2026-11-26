# Kyron Financial Ecosystem

**Status:** Immutable ledger foundation and read-only legacy coin reconciliation  
**Owner:** KyronLabs / Kyron  
**Baseline:** 22 November 2026

This document records the approved product requirements and the implementation boundaries for Kyron's financial ecosystem. It distinguishes existing virtual-coin behavior from new real-money capabilities.

## Approved product requirements

| Area | Decision | Engineering consequence |
|---|---|---|
| Coin purchasing | Google Play Billing first | Android purchase flow must use Play Billing; backend verification is authoritative. |
| Payout methods | Bank accounts first | Provider-neutral bank destination model; no mobile-money UI or payout integration in the first release. |
| Coin conversion | Dynamic | Rate is selected by country/currency and snapshotted into each accepted withdrawal quote. |
| Minimum withdrawal | Decide later | No invented threshold. Withdrawal activation stays disabled until an approved policy is configured. |
| Earnings availability | Immediate unless risk/compliance hold applies | Qualifying earnings accrue immediately; holds are explicit, reason-coded and auditable. |

## System boundaries

Kyron remains a modular monolith:

- Flutter application in `app/`.
- NestJS API in `api/`.
- Prisma owns API-managed relational schema.
- Supabase PostgreSQL remains the database.
- Google Play is the first Android coin-purchase channel.
- Bank payout provider selection is deferred; the model must not bind Kyron to an unselected vendor.

No separate financial microservice is introduced in this phase.

## Separate the units

Three different concepts must never be presented as interchangeable:

1. **Virtual coins** — non-fiat units used inside Kyron.
2. **Creator payable** — a coin-denominated accounting entitlement created by qualifying gifts.
3. **Fiat payout** — a bank transfer amount in a real currency, quoted at a specific dynamic rate and settled by a payout provider.

There is no assumed fixed coin-to-currency equivalence. A dynamic rate must be explicitly configured and captured as immutable evidence for every accepted quote.

## Google Play coin packs for Closed testing

Use the same product IDs and coin quantities across Play storefronts. Configure
market availability and local prices in Play Console. The app displays the
formatted price that Play returns for the tester's active storefront, including
its currency. A phone's language and a Kyron profile location can differ from
the tester's Play storefront. The app only offers products returned by both
Google Play and Kyron's server catalogue.

| Play product ID | Coins | Ghana reference price for Closed testing |
| --- | ---: | ---: |
| `coins_100` | 100 | GH₵5 |
| `coins_500` | 500 | GH₵25 |
| `coins_1000` | 1,000 | GH₵50 |

The starter pack covers 20 Sparks at 5 coins each, 10 Roses at 10 coins
each, or one Rocket at 100 coins. The gift catalogue sets coin costs
for new gifts. Previously sent gifts retain their recorded coin amounts.

Before activating test offers, confirm the testers' Play storefronts, including
Türkiye and the applicable Congo storefronts. Review the local price and
availability for each supported storefront in Play Console. Use matching
`productId` and `coins` values in the test API's `GOOGLE_PLAY_COIN_PRODUCTS`
catalogue and verify the purchase with a Play-installed build and a license
tester account. Check a supported storefront, a storefront with no offers,
and an account that changes storefront between sessions. Keep the production
market approval separate from this test configuration.

The local pack price is the cost of buying virtual coins. Creator bank
withdrawals use their own country and currency eligibility and the dynamic
rate captured when a withdrawal quote is accepted.

## Existing source records

The existing `CoinEntry` model remains the source record for historical virtual-coin movements during the bridge phase.

- `PURCHASE_EARN` and `REWARD_EARN` are the two withdrawable creator-proceeds classifications.
- `PROMOTIONAL_EARN` is legacy complimentary proceeds and is not withdrawable.
- Legacy `EARN` has unknown test-era provenance and must never become withdrawable by inference.
- Reward-funded creator proceeds have the same withdrawal eligibility as purchased-coin proceeds; their source labels are retained for reconciliation.
- The foundation migration removes the cascading User foreign key from `CoinEntry`; its `userId` remains as an immutable UUID snapshot, so account deletion no longer erases coin history.
- Existing coin balances are not fiat balances.

Do not silently rewrite old rows or infer purchase provenance from a user's current total.

**Historical source-retention boundary:** Gift and PostRewardGrant operational rows remain subject to social/identity cascades. PR #209 now snapshots their minimum financial facts into immutable `FinancialSourceRecord` rows in the same transaction as the event. The optional `CoinEntry.giftId` can still be nulled, so reconciliation recovers gift IDs from the stable `gift:<uuid>:...` idempotency key. Source events deleted before PR #209 and not present for its backfill cannot be reconstructed; PR #210 treats missing snapshots as blockers rather than guessing.

## New ledger foundation

The additive Prisma schema and migration introduce:

- `LedgerAccount` — stable chart-of-accounts entries, with immutable identity and denomination.
- `LedgerTransaction` — idempotent accounting events, one currency per transaction.
- `LedgerPosting` — positive debit/credit lines.
- `CreatorConversionRate` — immutable country/currency rate versions.
- `FinancialAuditEvent` — append-only operational/security audit evidence.

The backend `LedgerService` posts balanced events atomically, fingerprints idempotent requests, and creates full reversals as new transactions.

Database enforcement:
- At least two posting lines per ledger transaction.
- Total debits must equal total credits.
- Every posting account must use the transaction's currency.
- All posting lines must be created in the same SQL transaction as their parent ledger transaction.
- Posted transactions, postings, audit events and conversion-rate versions cannot be updated or deleted.
- Corrections use new compensating events.
- Account identity and denomination cannot be rewritten.
- Actor/owner UUIDs are immutable snapshots without User foreign keys, so deleting a user cannot mutate or cascade through financial evidence.

A ledger transaction represents one currency. A cross-currency conversion is a correlated set of balanced transactions, with the conversion rate snapshot recorded alongside the withdrawal quote.

## Withdrawal and risk policy

A qualifying creator earning is available immediately unless a risk/compliance control applies. The system must support at least:

- `AVAILABLE` — eligible for withdrawal.
- `HELD_RISK` — temporarily unavailable pending risk review.
- `HELD_COMPLIANCE` — unavailable pending eligibility/compliance review.
- `RESERVED` — atomically reserved by an active withdrawal request.
- `PAID` — payout settlement has been independently verified.
- `REVERSED` — a compensating event reverses a prior entitlement.

A withdrawal must reserve funds atomically before approval or payout execution. A provider accepting a payout instruction is not proof of settlement. A failed payout must release the reservation through a controlled ledger operation.

The minimum withdrawal threshold is intentionally unresolved. Until the product owner approves a value and it is stored as an active policy, withdrawal creation must remain disabled rather than silently treating the minimum as zero.

## Age and jurisdiction

Kyron is a 13+ platform. Access to the social platform does not imply eligibility for creator monetization or bank payouts. Payout eligibility must separately enforce applicable legal age, identity, country, tax and bank-account ownership requirements. Never infer that a minor can receive a payout merely because the account can use Kyron.

## Google Play purchase boundary

The client purchase callback is not proof of payment. The API must verify purchase tokens against Google Play, bind each token to one account/order, grant coins exactly once, process voids/refunds/chargebacks, and preserve the provider receipt reference. The client must never be able to submit an arbitrary coin amount as a successful purchase.

Purchase UI must not ship until the backend verification and refund/reconciliation path is tested.

### RTDN receipt boundary

`POST /purchases/google-play/notifications` receives wrapped, authenticated
Pub/Sub push messages only when `GOOGLE_PLAY_RTDN_ENABLED=true` and all
dedicated push settings are configured. Verify Google's RS256 signature,
issuer, expiration, audience, verified service-account email and immutable
numeric service-account subject. Configure the exact subscription resource
and Android package. Restrict IAM access to the dedicated push account's
token-minting permissions and the topic's publishers.

The existing `GooglePlayNotification` inbox deduplicates message IDs and
rejects an ID reused with different decoded content. A successful response
means receipt was committed, not that financial state changed. Retain a
SHA-256 fingerprint, normalized event metadata, token hashes and encrypted
tokens (including distinct pending refund-review tokens). Do not retain raw
Pub/Sub bodies or JWTs. The inbox distinguishes purchases, cancellations,
full and quantity-based partial voids, pending chargeback reviews,
subscription notices and console test events. Malformed or unsupported
events are rejected; configure Pub/Sub dead-letter handling.

This slice does not call the Publisher API, grant or debit coins, update
purchase status, issue or review refunds, change holds or move money.
`processedAt` remains null until a later reconciliation implementation.
Verify authoritative order and quantity evidence before posting compensating
entries. Pending chargeback reviews require timely operator handling (Google
documents a 24-hour response window). Keep live ingestion and purchases
disabled until these operational paths are implemented and tested.

References: [RTDN event reference](https://developer.android.com/google/play/billing/rtdn-reference)
and [authenticated Pub/Sub pushes](https://cloud.google.com/pubsub/docs/authenticate-push-subscriptions).

### Authoritative refund observation (evidence only)

Active administrators with AAL2 can list outstanding receipt IDs using
`GET /financial-operations/google-play/notifications?after=<UUID>` and retry
one receipt with
`POST /financial-operations/google-play/notifications/<UUID>/reconcile`.
The list contains no encrypted tokens, raw payloads or customer addresses.
Reconciliation defaults off (`GOOGLE_PLAY_RECONCILIATION_ENABLED=false`);
the purchase grant flag is independent.

Bind one-time void or cancellation notices to the stored purchase token,
order ID, product, original quantity and purchaser's obfuscated identity
using fresh Publisher API evidence. Partial monetary refunds without
confirmed quantity reductions, missing refundable quantities and inconsistent
evidence remain unresolved. The original quantity minus remaining refundable
quantity is cumulative, never the amount of one notification. Use the
original recorded coin amount rather than the current product catalogue.
The Voided Purchases API provides supporting reason/source evidence; its
visibility is limited to 30 days and the bounded scan may be incomplete.
An empty page does not establish absence of a refund. This is an operator
retry path, not yet a scheduled global sweep for missed notifications.

An immutable `GOOGLE_PLAY_REFUND_OBSERVATION` source record and audit event
are committed atomically with the receipt's processing marker. Serialize
observations per purchase and reject cumulative regressions. Multiple
notifications may report the same cumulative quantity. **Never sum these
records.** The generic source amount and unit are unset; cumulative coin
equivalents are evidence fields, not postings.

Unmatched, inconsistent, unavailable and pending-review notices remain
discoverable for retry. Processed means evidence retained, not funds
recovered. This slice performs no automatic reversal, freeze, creator
clawback, purchase status mutation, refund review response or payout.
Later posting must apply only an independently idempotent incremental
difference under the correct purchase and wallet locks. Keep live coin
purchases disabled until those paths and missed-notification recovery
are implemented and tested.

References: [Orders](https://developers.google.com/android-publisher/api-ref/rest/v3/orders),
[ProductPurchaseV2](https://developers.google.com/android-publisher/api-ref/rest/v3/purchases.productsv2)
and [Voided Purchases](https://developers.google.com/android-publisher/api-ref/rest/v3/purchases.voidedpurchases/list).

## Bank payout boundary

Bank payout integration is provider-neutral until a provider is selected after country coverage, licensing, settlement status, fees, reversals, webhook security and support procedures have been assessed. Store only the minimum bank destination data required, encrypt sensitive values, and never write full account numbers or credentials into audit metadata or application logs.

## Implementation sequence

1. **Ledger foundation (this phase):** schema, migration, database invariants, idempotent posting/reversal service and integration tests.
2. **Legacy bridge:** PR #210 provides a read-only, repeatable dry-run inventory and source reconciliation. Any later opening-balance import is a separate implementation and approval gate; this phase does not post ledger entries.
3. **Google Play purchases:** package catalogue, purchase verification, refunds/voids, idempotent coin grant.
4. **Creator payable and risk controls:** immediate accrual, reason-coded holds, eligibility and reservations.
5. **Withdrawal quotes:** dynamic rate snapshot, fee disclosure, expiry and accepted quote evidence. Minimum remains disabled until approved.
6. **Bank payouts:** provider adapter, dual control, idempotency, webhook verification and settlement reconciliation.
7. **User/admin UI:** wallet, purchase, creator earnings, bank destination, withdrawal, history and staff operations.
8. **Controlled launch:** sandbox, reconciliation, fraud/compliance review, support runbooks and staged enablement.

## Explicit non-goals for this migration

- No live purchase processing.
- No cash withdrawal or bank transfer.
- No payout provider selection.
- No coin-to-fiat fixed rate.
- No minimum withdrawal value.
- No historical `CoinEntry` backfill.
- No modification to production database or balances.
- No frontend screen changes.

## Frontend design-system gate

When frontend work begins, it must follow both the design-system source and the root `DESIGN_SYSTEM_COMPLIANCE_REPORT.md`:

- Use the shared `kyron_design_system` package; do not introduce local theme/token forks.
- Flat surfaces and full-bleed hairline separators; no elevated cards or shadows for separation.
- Pill-shaped buttons; use shared button components and the documented 40-point visible button height.
- Bottom sheets for mobile forms, pickers and confirmations; no centered alert dialogs.
- Iconsax, no Material Icons; no ink ripples.
- Typography from shared modular-scale tokens, fractional sizes preserved, zero letter spacing.
- Spacing from the documented 2/4/8/12/16/20/24/28/32/40 scale.
- Minimum 44×44 touch targets even where the visible pill itself is 40 high.
- Use semantic theme colors and the documented `primary_500` accent (`#006AFF`); no custom UI hex colors.
- Add screen-level and component tests. The compliance report explicitly says touch-target coverage is incomplete and spacing/motion are not comprehensively guarded; new screens must not repeat those gaps.

The compliance report must remain honest: do not claim app-wide compliance based only on a local screen test.

## Legacy coin reconciliation

PR #210 adds a read-only, repeatable `CoinEntry` reconciliation command. It
maps all current coin kinds into segregated KCOIN buckets, checks gift and
reward source snapshots, detects existing ledger references and produces
balanced posting proposals without creating accounts, transactions or
postings. See [Legacy CoinEntry reconciliation](./LEGACY_COIN_RECONCILIATION.md).


## Financial source retention

Gift and fulfilled reward events are copied transactionally into the immutable
`FinancialSourceRecord` evidence table. It preserves the source event ID,
pseudonymous actor and beneficiary UUIDs, related source identifiers, value,
unit and the minimum event payload needed for reconciliation. It intentionally
does not copy profile details, post/comment text, nomination reasons or review
notes. See [Ledger and Migration](./LEDGER_AND_MIGRATION.md#financial-source-record-retention).

### Scheduled recovery of missed void notifications

The separate `Google Play void recovery` workflow runs twice per hour when
repository variable `GOOGLE_PLAY_RECOVERY_ENABLED=true`. Configure the
same dedicated random `GOOGLE_PLAY_RECOVERY_CRON_KEY` as a GitHub secret
and an API environment variable; also enable
`GOOGLE_PLAY_RECOVERY_ENABLED=true` on the API, with configured Publisher
credentials, package and token encryption key. Do not reuse CRON_KEY.
Without these settings, the workflow is skipped or the API fails closed.

A successful page stores normalized, encrypted-token receipts in the existing
GooglePlayNotification inbox and advances the package checkpoint in one
transaction. A revision compare-and-swap prevents competing runners from
overwriting progress. The first scan requests the preceding 29 days ending
five minutes before the current time. Later scans overlap the last completed
window by 48 hours, and a fixed window plus encrypted continuation token
survives restarts. The completed coverage watermark advances only after the
last page; a backward clock adjustment cannot reduce it. Provider
selection is by API visibility time, not the returned void timestamp; never
derive the next cursor from that timestamp. The workflow attempts at most six
pages per run, resumes next run, and surfaces failures without logging tokens.
An invalid continuation token restarts the same window with deterministic
receipt IDs. A malformed page or retention gap fails closed. A checkpoint
older than the supported window requires audited manual incident recovery;
do not reset it and silently claim the missing history was covered.

Exact repeated provider records use deterministic IDs based on package, order,
token digest, void time, quantity, reason and source. RTDN uses Pub/Sub message
IDs, so the same underlying refund may have a receipt from each channel.
Both feed the same cumulative observation service; do not sum receipts or
observations, and never assume a partial quantity is a full refund. Recovered
notices are `ONE_TIME_VOID_RECOVERED` and remain pending for authoritative
order/product verification through the existing operator retry path. A
scheduled verification worker, chargeback review and ledger posting are
still separate follow-ups. No coin, creator earnings, purchase status or
payout changes occur during the sweep.

AAL2 administrators can inspect sanitized checkpoint progress and pending
recovered receipt count at `GET /financial-operations/google-play/void-recovery`.
The endpoint omits encrypted continuation tokens, raw purchase tokens and
provider bodies. A retention gap or repeated page/provider error requires
operator intervention. The checkpoint table is RLS-enabled and inaccessible
to public Supabase roles.

### Automated authoritative refund verification

The recovery workflow now has an independent verification job. Opt in with
repository variable `GOOGLE_PLAY_AUTOMATED_RECONCILIATION_ENABLED=true`,
the API flag of the same name, and the existing
`GOOGLE_PLAY_RECONCILIATION_ENABLED=true`. Configure the same dedicated
`GOOGLE_PLAY_RECOVERY_CRON_KEY`, Publisher credentials and encryption key.
The verification job runs even if the separate receipt recovery job fails.
Both are off by default. No purchase activation is implied.

Each request claims up to two due one-time refund receipts via a single
Postgres UPDATE with FOR UPDATE SKIP LOCKED and a two-minute lease. The
worker runs the existing authoritative reconciliation service with a null
actor ID (system observation, not an impersonated administrator). No
provider network calls are made while holding the claim transaction.
Concurrent workers may not claim the same live lease. An expired lease is
reclaimable, and a superseded worker cannot overwrite another worker's
retry scheduling. The existing purchase/receipt locks and unique evidence
source protect financial observations even if a lease expires mid-request.

Unresolved or failed receipts are retried with exponential delays of
5 minutes up to 24 hours. The attempt counter saturates at 31; receipts
are never discarded or marked processed merely because of repeated errors.
The scheduled job makes at most six two-receipt requests per run, and may
drain fewer; monitor backlog and provider limits before increasing it.
Administrators can still retry immediately through the existing AAL2
operator endpoint, which shares evidence idempotency. Pending chargeback
review, test and subscription notifications are not claimed by this worker.

AAL2 administrators can inspect aggregate due, leased, deferred and
unresolved counts at
`GET /financial-operations/google-play/refund-reconciliation`.
The existing pending list now exposes attempt count and next attempt time.
Neither endpoint reveals tokens or provider response bodies. A processed
receipt still means only that evidence was retained. There is no balance
deduction, creator clawback, provider refund or payout in this slice.
