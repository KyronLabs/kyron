-- Dual-control approval metadata for creator withdrawals.
-- Existing approved rows remain valid; the new approval path requires a
-- persisted request and a second, distinct administrator before transition.
ALTER TABLE "CreatorWithdrawal"
  ADD COLUMN "approvalRequestId" VARCHAR(160),
  ADD COLUMN "approvalRequestedById" UUID,
  ADD COLUMN "approvalRequestedAt" TIMESTAMPTZ,
  ADD COLUMN "approvedById" UUID;

CREATE UNIQUE INDEX "CreatorWithdrawal_approvalRequestId_key"
  ON "CreatorWithdrawal"("approvalRequestId");

ALTER TABLE "CreatorWithdrawal"
  ADD CONSTRAINT "CreatorWithdrawal_approval_request_complete"
  CHECK (
    (
      "approvalRequestId" IS NULL
      AND "approvalRequestedById" IS NULL
      AND "approvalRequestedAt" IS NULL
    )
    OR
    (
      "approvalRequestId" IS NOT NULL
      AND "approvalRequestedById" IS NOT NULL
      AND "approvalRequestedAt" IS NOT NULL
    )
  ),
  ADD CONSTRAINT "CreatorWithdrawal_dual_control_distinct_actors"
  CHECK (
    "approvedById" IS NULL
    OR "approvalRequestedById" IS NULL
    OR "approvedById" <> "approvalRequestedById"
  );
