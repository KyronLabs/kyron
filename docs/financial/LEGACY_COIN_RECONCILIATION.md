# Legacy CoinEntry reconciliation

**Status:** PR #210 — read-only dry-run implementation  
**Database effect:** none; the reconciliation transaction is explicitly read-only.

This phase inventories the existing `CoinEntry` history and produces deterministic
balanced posting plans. It does not create ledger accounts, transactions or
postings. Do not treat a clean dry run as authorization to import or move funds.

## Approved kind mapping

| CoinEntry kind | Ledger liability bucket | Withdrawable? | Meaning |
|---|---|---:|---|
| `GRANT` | `LEGACY_COMPLIMENTARY` | No | Grandfathered weekly complimentary coins |
| `SPEND` | `LEGACY_COMPLIMENTARY` | No | Spending those grandfathered coins |
| `REWARD_GRANT` | `REWARD_PROMOTIONAL` | No | Coins issued by an approved post-reward grant |
| `REWARD_SPEND` | `REWARD_PROMOTIONAL` | No | Spending approved reward coins |
| `PURCHASE_EARN` | `CREATOR_PAYABLE` | Yes | Creator proceeds explicitly attributed to purchased-coin spending |
| `REWARD_EARN` | `CREATOR_PAYABLE` | Yes | Creator proceeds explicitly attributed to approved reward-coin spending |
| `PROMOTIONAL_EARN` | `CREATOR_PROMOTIONAL` | No | Creator proceeds funded by the retired weekly complimentary balance |
| `EARN` | `CREATOR_UNKNOWN` | No | Legacy test-era proceeds with unknown provenance |

The same bucket is used for a grant and its later spend so the projected
liability is the signed sum of the original entries. Purchased-coin and
approved reward-funded creator proceeds share the payable bucket because the
approved policy gives them the same withdrawal eligibility; the original
CoinEntry kind remains in every proposed transaction's metadata. Unknown
`EARN` and legacy `PROMOTIONAL_EARN` remain segregated and non-withdrawable.

## Proposed posting shape

Every non-zero, supported CoinEntry row receives a stable proposal:

- source type: `LEGACY_COIN_ENTRY`;
- source ID: the immutable CoinEntry UUID;
- idempotency key: `legacy-coin-entry:<CoinEntry UUID>`;
- currency/unit: `KCOIN`;
- effective timestamp: the original `CoinEntry.createdAt`.

A positive CoinEntry amount credits that owner's liability account and debits
the matching `SYSTEM:LEGACY_COIN_BRIDGE` equity-offset account. A negative
amount debits the owner's liability account and credits the same offset. Both
lines use the absolute amount, so each proposed journal is balanced. The
offset is a migration-control account, not cash, revenue, Google Play
settlement or creator proceeds.

## Source reconciliation

Gift-related entries are grouped by gift ID. The ID is recovered from
`CoinEntry.giftId` or from the existing `gift:<uuid>:...` idempotency key;
this still works when the optional Gift foreign key was set to null. The
service checks the immutable `FinancialSourceRecord` for:

- sender and creator ownership;
- gift amount and coin unit;
- total sender spend against the source amount;
- total creator proceeds against the same source amount;
- exactly one sender and one creator proceeds owner.

Reward grant entries resolve `reward:<grant UUID>` to the retained
`POST_REWARD_GRANT` source snapshot and check reward type, beneficiary,
amount and unit. A missing snapshot, inconsistent amount, source mismatch,
negative owner bucket, zero-value entry, unmapped future kind or idempotency
collision is a blocker. Unknown `EARN` is reported as a warning because its
approved treatment is to retain it outside withdrawable proceeds.

## Running the dry run

From `api/`:

```bash
npm ci
npm run prisma:generate
npm run financial:legacy-coin-dry-run
```

To include every pseudonymous owner UUID and their five projected balances:

```bash
npm run financial:legacy-coin-dry-run -- --include-user-balances
```

The command requires `DATABASE_URL`. It uses a PostgreSQL repeatable-read
transaction and sets it read-only before querying. It scans in bounded pages
and prints a JSON report to stdout. A report with blockers exits with code 2;
an execution failure exits with code 1. The command has no write path.

Use a database identity with read access only when running the report. The
database and `_prisma_migrations` history must still be independently
reconciled before any future import. For a production inventory, take and
verify a backup first, compare counts/sums by kind, user and time window, and
preserve the output as an operator-controlled artifact.

## Explicit non-goals

- No CoinEntry edits or deletions.
- No ledger account or transaction creation.
- No opening-balance posting or cutover.
- No live wallet balance changes.
- No Google Play purchase or refund processing.
- No fiat valuation, payout or withdrawal.
- No inference that a current wallet balance proves historical source provenance.
- No automatic promotion of `EARN` or `PROMOTIONAL_EARN` to withdrawable value.

An approved future execution phase must separately specify opening-balance
journal semantics, contra-account treatment, rehearsal against a disposable
database, operational approval and a controlled cutover. This dry run is not
that authorization.
