CREATE TYPE "PayoutProviderEventOutcome" AS ENUM ('PENDING', 'SUCCEEDED', 'FAILED');

ALTER TABLE "PayoutProviderEvent"
  ADD COLUMN "outcome" "PayoutProviderEventOutcome",
  ADD COLUMN "providerTransferRef" VARCHAR(255),
  ADD COLUMN "providerIdempotencyKey" VARCHAR(200),
  ADD COLUMN "amountMinor" BIGINT,
  ADD COLUMN "currency" CHAR(3),
  ADD COLUMN "providerOccurredAt" TIMESTAMPTZ;

ALTER TABLE "PayoutProviderEvent"
  ADD CONSTRAINT "PayoutProviderEvent_amount_positive"
  CHECK ("amountMinor" IS NULL OR "amountMinor" > 0);

CREATE INDEX "PayoutProviderEvent_provider_transfer_ref_idx"
  ON "PayoutProviderEvent"("providerCode", "providerTransferRef");
CREATE INDEX "PayoutProviderEvent_provider_idempotency_key_idx"
  ON "PayoutProviderEvent"("providerCode", "providerIdempotencyKey");
CREATE INDEX "PayoutProviderEvent_outcome_processedAt_receivedAt_idx"
  ON "PayoutProviderEvent"("outcome", "processedAt", "receivedAt");

-- Provider facts are immutable. An unmatched event may be attached to one
-- withdrawal once; processing is still a one-time terminal marker.
CREATE OR REPLACE FUNCTION "kyron_protect_payout_provider_event"()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    RAISE EXCEPTION 'Payout provider events cannot be deleted' USING ERRCODE = '55000';
  END IF;
  IF NEW."id" IS DISTINCT FROM OLD."id"
     OR NEW."providerCode" IS DISTINCT FROM OLD."providerCode"
     OR NEW."providerEventId" IS DISTINCT FROM OLD."providerEventId"
     OR (OLD."withdrawalId" IS NOT NULL AND NEW."withdrawalId" IS DISTINCT FROM OLD."withdrawalId")
     OR NEW."eventType" IS DISTINCT FROM OLD."eventType"
     OR NEW."payloadHash" IS DISTINCT FROM OLD."payloadHash"
     OR NEW."outcome" IS DISTINCT FROM OLD."outcome"
     OR NEW."providerTransferRef" IS DISTINCT FROM OLD."providerTransferRef"
     OR NEW."providerIdempotencyKey" IS DISTINCT FROM OLD."providerIdempotencyKey"
     OR NEW."amountMinor" IS DISTINCT FROM OLD."amountMinor"
     OR NEW."currency" IS DISTINCT FROM OLD."currency"
     OR NEW."providerOccurredAt" IS DISTINCT FROM OLD."providerOccurredAt"
     OR NEW."receivedAt" IS DISTINCT FROM OLD."receivedAt"
     OR OLD."processedAt" IS NOT NULL
     OR NEW."processedAt" IS NULL THEN
    RAISE EXCEPTION 'Payout provider event may only be processed once' USING ERRCODE = '55000';
  END IF;
  RETURN NEW;
END;
$$;
