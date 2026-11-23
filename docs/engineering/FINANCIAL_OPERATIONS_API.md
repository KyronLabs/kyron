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
and recent manual-review audit records. Each report read also creates a
`FINANCIAL_OPERATIONS_REPORT_VIEWED` audit event with the acting admin,
requested bounds and aggregate counts; individual payout details are not
copied into that audit record. Monetary minor-unit values are returned
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


### Request dual-control withdrawal approval

`POST /financial-operations/creator-withdrawals/:id/approval-request`

```json
{
  "requestId": "withdrawal-approval-01"
}
```

The authenticated AAL2 administrator records the approval request. The
withdrawal remains in its existing `REQUESTED` or `UNDER_REVIEW` state.
The request stores the initiating administrator, timestamp and unique request
key, and appends a `CREATOR_WITHDRAWAL_APPROVAL_REQUESTED` audit event.

### Approve a withdrawal with a second administrator

`POST /financial-operations/creator-withdrawals/:id/approve`

```json
{
  "requestId": "withdrawal-approval-01"
}
```

A different authenticated AAL2 administrator must supply the exact request
key. The service locks the withdrawal row, verifies the pending request and
distinct actor identity, then records `approvedById`, transitions the
withdrawal to `APPROVED`, and appends a `CREATOR_WITHDRAWAL_APPROVED`
audit event containing both administrator IDs. Replays and competing approval
requests cannot create a second approval.

Approval does not submit a payout, create a payout attempt, call a provider or
move funds. Existing provider adapters remain disabled.



### Inspect payout submission readiness

`GET /financial-operations/creator-withdrawals/:id/submission-readiness`

Returns an operator preflight assessment with a `ready` boolean and stable
blocker codes. The assessment checks the separate payout-submission kill
switch, creator-withdrawal feature flag and minimum, bank-provider
configuration, APPROVED withdrawal state, complete dual-control approval by
two different administrators, active destination ownership, matching and
unexpired FX quote, active earnings reservation, and unresolved payout
attempts.

The response includes only the withdrawal ID, coin amount, currency, fiat
minor-unit amount as a decimal string, blocker codes and assessment time. It
does not return tokenized recipient references or bank details. Each
assessment appends a `CREATOR_PAYOUT_SUBMISSION_PREFLIGHT_VIEWED` audit event
with the authenticated administrator, readiness result and blocker codes.

This operation is a read-only financial preflight: it does not create a payout
attempt, change a withdrawal or reservation, consume an FX quote, reserve
coins, or call a provider. A `ready: true` result is a point-in-time assessment,
not authorization to dispatch; all checks are repeated by the protected
submission service when any future dispatch path is explicitly approved.

## Payout submission safety gate

The internal `CreatorWithdrawalsService.submitApproved()` boundary is protected
by a separate server-side kill switch:

- `CREATOR_PAYOUT_SUBMISSIONS_ENABLED` must be exactly `true`; it defaults
  to closed when unset or set to any other value.
- The existing creator-withdrawal feature flag and configured minimum remain
  independently required.
- A configured bank payout provider is also required.
- The withdrawal must contain the persisted approval request ID, requester,
  request timestamp, approver and approval timestamp.
- The requester and approver IDs must differ. Withdrawals approved before the
  dual-control metadata existed are not eligible for submission through this
  path until properly re-approved.
- The earnings reservation must still be `ACTIVE` before a payout attempt is
  created.
- A definite provider rejection updates the payout attempt, withdrawal and
  earnings reservation to their terminal states in one database transaction.
  The rejection and reservation-release audit events are committed in that
  same transaction.
- Provider transport errors and persistence failures after an accepted
  response remain unresolved/unknown and require reconciliation; a known
  rejection is never relabelled as an unknown provider outcome merely because
  reservation finalization failed.

The kill switch is evaluated before any database preparation or provider
configuration check. A closed switch therefore cannot create a payout attempt
or call a provider. This PR adds no dispatch endpoint, worker, provider adapter
or automatic submission behavior. The default remains disabled.

## Explicitly out of scope

- No endpoint submits a payout or creates a new payout attempt.
- No automatic retry or provider status lookup is performed.
- No FX, bank payout or webhook provider is enabled.
- No raw webhook payload, signature or bank-account data is returned.
- No production funds are moved by the operations API.
