-- Durable scheduling metadata on the existing server-only notification inbox.
-- Existing evidence, receipts and monetary records are unchanged.
ALTER TABLE "GooglePlayNotification"
  ADD COLUMN "reconciliationAttemptCount" INTEGER NOT NULL DEFAULT 0,
  ADD COLUMN "reconciliationNextAttemptAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ADD COLUMN "reconciliationLeaseId" UUID,
  ADD COLUMN "reconciliationLeaseUntil" TIMESTAMPTZ,
  ADD CONSTRAINT "GooglePlayNotification_reconcile_attempt_valid"
    CHECK ("reconciliationAttemptCount" BETWEEN 0 AND 31),
  ADD CONSTRAINT "GooglePlayNotification_reconcile_lease_pair"
    CHECK (("reconciliationLeaseId" IS NULL) = ("reconciliationLeaseUntil" IS NULL));

CREATE INDEX "GooglePlayNotification_reconcile_due_idx"
  ON "GooglePlayNotification" ("processedAt", "reconciliationNextAttemptAt", "receivedAt");
