# Kyron Financial Ecosystem

**Status:** Implementation foundation — additive database and ledger service layer  
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

## Existing source records

The existing `CoinEntry` model remains the source record for historical virtual-coin movements during the bridge phase.

- `PURCHASE_EARN` and `REWARD_EARN` are the two withdrawable creator-proceeds classifications.
- `PROMOTIONAL_EARN` is legacy complimentary proceeds and is not withdrawable.
- Legacy `EARN` has unknown test-era provenance and must never become withdrawable by inference.
- Reward-funded creator proceeds have the same withdrawal eligibility as purchased-coin proceeds; their source labels are retained for reconciliation.
- The foundation migration removes the cascading User foreign key from `CoinEntry`; its `userId` remains as an immutable UUID snapshot, so account deletion no longer erases coin history.
- Existing coin balances are not fiat balances.

Do not silently rewrite old rows or infer purchase provenance from a user's current total.

**Outstanding source-retention blocker:** current `Gift` rows can still be cascade-deleted with their recipient, post or comment; `PostRewardGrant` rows can be cascade-deleted with their program, nomination, post or recipient. `CoinEntry` will now survive user deletion, but its `giftId` can be nulled when a Gift is deleted and the richer source record may disappear. Before the real-money bridge or launch, introduce reviewed tombstone/soft-delete retention for these source records and verify that reward audit evidence remains linkable.

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

## Bank payout boundary

Bank payout integration is provider-neutral until a provider is selected after country coverage, licensing, settlement status, fees, reversals, webhook security and support procedures have been assessed. Store only the minimum bank destination data required, encrypt sensitive values, and never write full account numbers or credentials into audit metadata or application logs.

## Implementation sequence

1. **Ledger foundation (this phase):** schema, migration, database invariants, idempotent posting/reversal service and integration tests.
2. **Legacy bridge:** reconcile existing `CoinEntry` balances/provenance and create opening ledger entries under a reviewed, repeatable migration plan.
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


## Financial source retention

Gift and fulfilled reward events are copied transactionally into the immutable
`FinancialSourceRecord` evidence table. It preserves the source event ID,
pseudonymous actor and beneficiary UUIDs, related source identifiers, value,
unit and the minimum event payload needed for reconciliation. It intentionally
does not copy profile details, post/comment text, nomination reasons or review
notes. See [Ledger and Migration](./LEDGER_AND_MIGRATION.md#financial-source-record-retention).
