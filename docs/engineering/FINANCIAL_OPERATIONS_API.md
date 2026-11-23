# Financial Operations API

The financial-operations routes are internal operator endpoints. They are not
available to ordinary users or moderators.

## Access requirements

Every route requires:

- A valid Supabase bearer access token, verified by the API `AuthGuard`.
- A Kyron account with role `ADMIN`.
- Account status `ACTIVE`.
- An access token whose verified `aal` claim is `aal2` (second factor).

The AAL2 requirement is mandatory for this API and is independent of
`STAFF_REQUIRE_SECOND_FACTOR`. A password-only admin session receives
`403 FINANCIAL_OPERATIONS_SECOND_FACTOR_REQUIRED`. The financial guard hides
the routes from non-admin accounts; Kyron's general authentication guard also
enforces the account's suspension, ban and deletion status before the
financial guard runs.

The acting administrator ID is always taken from the authenticated request.
No endpoint accepts an actor ID from the caller. Request IDs are required for
auditable idempotency and must be 8–160 characters using letters, digits,
periods, underscores, colons or hyphens.

## Routes

### Read payout operations report

`GET /financial-operations/payouts?staleAfterMinutes=60&limit=100`

Both query parameters are optional. `staleAfterMinutes` is bounded from 1 to
10,080; `limit` is bounded from 1 to 500. The report includes stale
`CREATED`, `SUBMITTED` and `UNKNOWN` attempts, unresolved provider events
and recent manual-review audit records. Monetary minor-unit values are returned
as decimal strings to remain JSON-safe.

### Request manual review

`POST /financial-operations/payout-attempts/:id/manual-review`

```json
{
  "requestId": "review-request-01",
  "reasonCode": "UNKNOWN_PROVIDER_OUTCOME"
}
```

Supported reasons:

- `STALE_CREATED_ATTEMPT`
- `STALE_SUBMITTED_ATTEMPT`
- `UNKNOWN_PROVIDER_OUTCOME`
- `MISSING_TRANSFER_REFERENCE`
- `CONFLICTING_PROVIDER_EVIDENCE`
- `OTHER`

The service records the request in `FinancialAuditEvent`; it does not change
payout, withdrawal or reservation state.

### Resolve manual review

`POST /financial-operations/payout-attempts/:id/manual-review/resolve`

```json
{
  "requestId": "review-request-01",
  "resolutionCode": "ESCALATED_TO_PROVIDER"
}
```

Supported resolutions:

- `EVIDENCE_ATTACHED_FOR_RECONCILIATION`
- `NO_PROVIDER_TRANSFER_FOUND`
- `ESCALATED_TO_PROVIDER`
- `NO_ACTION_REQUIRED`

Resolution closes the operational review record only. It does not declare
that money was paid, reverse a transfer or release an earnings reservation.

### Reprocess authenticated provider evidence

`POST /financial-operations/provider-events/:id/reprocess`

```json
{
  "requestId": "provider-replay-01"
}
```

Only an unprocessed, unmatched event with an already authenticated terminal
outcome (`SUCCEEDED` or `FAILED`) can be replayed. The request delegates to
the existing payout reconciliation service, preserving its locks, provider
reference matching, amount/currency checks, state checks and reservation
finalization rules.

## Explicitly out of scope

- No endpoint submits a payout or creates a new payout attempt.
- No automatic retry or provider status lookup is performed.
- No FX, bank payout or webhook provider is enabled.
- No raw webhook payload, signature or bank-account data is returned.
- No production funds are moved by the operations API.
