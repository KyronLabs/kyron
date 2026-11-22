# Ledger and database design

## 1. Accounting rules

- Every posted transaction has at least two lines.
- Debits equal credits exactly at the stored decimal precision.
- Every line is positive; direction is expressed by `DEBIT` or `CREDIT`.
- One ledger transaction uses one currency/unit code. Use `KCOIN` for virtual coins and ISO currency codes such as `GHS` for fiat.
- Cross-currency operations use correlated balanced transactions, not a mixed-currency unbalanced journal.
- Idempotency keys are unique and stable per source event.
- Posted records are immutable. A correction is a new compensating transaction.
- Never derive balances from client-supplied values.
- Do not delete financial evidence when a user, post, gift or reward record is removed.

## 2. Chart of accounts

Provision accounts lazily and idempotently using deterministic `accountKey` values. Initial account families:

| Account | Type | Unit | Purpose |
|---|---|---|---|
| Google Play clearing | Asset | fiat | Verified Play proceeds receivable/settlement clearing |
| Platform bank/cash | Asset | fiat | Settled platform cash |
| User coin liability | Liability | KCOIN | Spendable purchased coin obligation |
| Promotional coin liability | Liability | KCOIN | Non-cash promotional coin obligation |
| Creator payable | Liability | KCOIN | Eligible creator proceeds |
| Creator risk hold | Liability | KCOIN | Creator proceeds unavailable under risk/compliance hold |
| Creator reserved | Liability | KCOIN | Creator proceeds reserved for an active withdrawal |
| Payout clearing | Liability | fiat | Approved bank payout awaiting verified settlement |
| Platform revenue/expense | Revenue/Expense | fiat | Only where an approved commercial/accounting policy recognizes it |

Do not hard-code platform commission, tax, Google Play fees, conversion spread or creator share in the ledger service. Those values require approved product/accounting policy and explicit source data.

## 3. Event posting patterns

The exact amounts and counterpart accounts must be approved with the commercial/accounting policy. These patterns describe structure, not a final revenue split.

### Verified coin purchase

- Fiat transaction: debit Play clearing; credit the appropriate deferred/contract liability account.
- Coin transaction: debit the funding/clearing coin account; credit the user's purchased-coin liability.
- Both carry a common correlation ID and a verified purchase source reference.
- A unique purchase token/order reference prevents duplicate grants.

### Gift spending

- KCOIN transaction: debit sender's spendable coin liability; credit creator payable or the appropriate held creator liability.
- The creator proceeds source is derived from the existing spend provenance: purchased and approved reward coins qualify; legacy complimentary proceeds do not.
- Preserve gift ID and CoinEntry source IDs in metadata/reference fields for reconciliation.
- Do not let a gift alter feed ranking.

### Risk hold

- Reclassify the creator liability from available to held through a balanced KCOIN transaction.
- Record a reason code, rule/policy version, actor/system source and review state in the audit trail.
- Releasing a hold is another transaction, not an update to the original posting.

### Withdrawal reservation

- Debit creator payable (KCOIN); credit creator reserved (KCOIN).
- In a separate fiat-currency transaction, record the accepted conversion quote and payout obligation.
- A reservation is not a payout and is not a completed cash withdrawal.

### Successful bank payout

- Debit payout clearing; credit bank/cash clearing only when provider settlement evidence is verified, with exact accounting mapping finalized after provider selection.
- Marking a request complete is a workflow state change backed by provider settlement evidence and ledger posting, not merely an HTTP 200 from the provider.

### Failed/cancelled payout

- Reverse/release the reservation with a new compensating transaction.
- Preserve the original request, attempt, provider reference and failure reason.

## 4. Dynamic conversion

The rate table is versioned and immutable. Each withdrawal quote must persist:

- Country and fiat currency.
- Coin amount.
- Rate record ID and copied rate value.
- Gross fiat amount in minor units.
- Fee amount and fee policy version.
- Net fiat amount in minor units.
- Rounding rule/version.
- Quote creation/expiry timestamps.
- User acceptance timestamp and quote fingerprint.

A later rate update must never change an accepted quote. The minimum withdrawal is not assumed; withdrawal creation remains disabled until the threshold policy is explicitly approved and configured.

## 5. Risk and eligibility

Eligibility is evaluated on the server for every withdrawal attempt and again before payout execution. At minimum:

- account active and not restricted;
- creator monetization eligibility and applicable age requirement;
- country/jurisdiction supported;
- identity/compliance checks complete where required;
- bank destination ownership verified;
- enough available proceeds after existing reservations;
- no active risk/compliance hold;
- rate quote valid and accepted;
- minimum-withdrawal policy configured and satisfied;
- risk limits and velocity checks pass.

Risk rules must not silently erase or confiscate earnings. Holds need explicit reason codes, review/appeal paths and audit events.

## 6. Migration and legacy bridge

The migration in this phase creates new tables and database enforcement only. It intentionally does not backfill existing records.

It also removes the old cascading foreign key from `CoinEntry.userId` without changing any rows. `userId` remains a required UUID snapshot, so deleting a Kyron account no longer cascades through its virtual-coin history. No code path currently depends on a Prisma `CoinEntry.user` relation; wallet queries continue to filter by `userId`.

**Historical retention boundary:** operational `Gift` and `PostRewardGrant` rows remain subject to social/identity cascades, but PR #209 writes their minimum financial source facts to independent immutable `FinancialSourceRecord` rows in the same transaction. The `CoinEntry.giftId` relation may still be set to null; current gift idempotency keys retain the gift UUID for reconciliation. Rows deleted before PR #209 and not available for its backfill remain unrecoverable. A missing source snapshot is therefore a reconciliation blocker, not an invitation to infer provenance.

Before the bridge is enabled:
1. Take and verify a database backup.
2. Reconcile live schema and `_prisma_migrations` against the repository's migration history.
3. Export immutable counts and sums by `CoinKind`, user, source and time range.
4. Identify orphaned or cascade-deletion-exposed history.
5. Define opening balances per user and unit with explicit source provenance.
6. Run a dry-run import into a disposable database and compare every user's totals.
7. Ensure the import is idempotent and can be resumed safely.
8. Have finance/product approve discrepancies before any production cutover.

Never mark old `EARN` or `PROMOTIONAL_EARN` as withdrawable. Only verified `PURCHASE_EARN` and `REWARD_EARN` qualify under the current approved rule.

## 7. Database enforcement in this phase

The migration enforces:
- immutable posted transactions and posting lines;
- same-SQL-transaction creation for transaction plus posting lines;
- at least two lines;
- debit/credit equality;
- account denomination equals transaction denomination;
- immutable conversion-rate and audit-event rows;
- stable account identity/denomination;
- restrictive foreign keys from postings to accounts/transactions;
- Actor/owner UUIDs are retained as immutable pseudonymous references without User foreign keys, so user deletion cannot mutate or cascade through financial evidence.

Application services must still enforce authorization, idempotency semantics, account status, event-source validity and business-level limits. Database triggers are defense in depth, not a substitute for service logic.


## Financial source-record retention

The financial ledger migration deliberately leaves the existing `CoinEntry`
history in place. This retention layer adds `FinancialSourceRecord`, an
immutable, API-owned snapshot for source events that can create or explain
coin movements.

A source record is written in the same database transaction as its source
event. The unique (`sourceType`, `sourceId`) key makes the source identity
unambiguous. Gift snapshots retain sender/recipient UUIDs, post/comment UUIDs,
gift type, coin amount and request ID. Reward snapshots retain grant,
programme, nomination, post, beneficiary and staff actor UUIDs, reward type,
reward payload and idempotency key.

These identifiers are pseudonymous references, not copies of names, email
addresses, post text, comment text, nomination reasons or review notes. The
table has no foreign keys to users or social content, so deleting those
records cannot delete or rewrite the source evidence. Its database trigger
rejects updates and deletes; corrections must be represented by a new,
separately identified event.

The migration backfills snapshots for Gift and PostRewardGrant rows that
still exist when it is applied. It cannot reconstruct sources already erased
by earlier cascades. This table is provenance, not a spendable balance and
not a replacement for CoinEntry or the double-entry ledger. PR #210's
read-only reconciliation uses these snapshots as an independent source of
truth for gift and reward validation; missing snapshots block the affected
history from a future import.

See [Legacy CoinEntry reconciliation](./LEGACY_COIN_RECONCILIATION.md) for the
kind mapping, report semantics, dry-run command and explicit non-goals.
