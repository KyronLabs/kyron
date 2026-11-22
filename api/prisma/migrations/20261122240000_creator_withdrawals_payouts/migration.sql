-- Creator withdrawal requests, FX quote snapshots and provider payout evidence.
-- All records are server-only. No live payout provider is enabled by this migration.
CREATE TYPE "CreatorWithdrawalStatus" AS ENUM (
  'REQUESTED', 'UNDER_REVIEW', 'APPROVED', 'PROCESSING',
  'PAID', 'FAILED', 'CANCELLED', 'REVERSED'
);
CREATE TYPE "PayoutDestinationStatus" AS ENUM ('ACTIVE', 'DISABLED');
CREATE TYPE "PayoutAttemptStatus" AS ENUM (
  'CREATED', 'SUBMITTED', 'SUCCEEDED', 'FAILED', 'UNKNOWN'
);
CREATE TYPE "FxQuoteStatus" AS ENUM ('ACTIVE', 'CONSUMED', 'EXPIRED');

CREATE TABLE "PayoutDestination" (
  "id" UUID NOT NULL,
  "creatorId" UUID NOT NULL,
  "providerCode" VARCHAR(40) NOT NULL,
  "providerRecipientRef" VARCHAR(255) NOT NULL,
  "countryCode" CHAR(2) NOT NULL,
  "currency" CHAR(3) NOT NULL,
  "bankCode" VARCHAR(40),
  "accountLast4" CHAR(4),
  "status" "PayoutDestinationStatus" NOT NULL DEFAULT 'ACTIVE',
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatedAt" TIMESTAMPTZ NOT NULL,
  CONSTRAINT "PayoutDestination_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "FxQuote" (
  "id" UUID NOT NULL,
  "creatorId" UUID NOT NULL,
  "coinAmount" INTEGER NOT NULL,
  "targetCurrency" CHAR(3) NOT NULL,
  "targetAmountMinor" BIGINT NOT NULL,
  "rateNumerator" BIGINT NOT NULL,
  "rateDenominator" BIGINT NOT NULL,
  "providerCode" VARCHAR(40) NOT NULL,
  "providerQuoteRef" VARCHAR(255),
  "status" "FxQuoteStatus" NOT NULL DEFAULT 'ACTIVE',
  "quotedAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "expiresAt" TIMESTAMPTZ NOT NULL,
  CONSTRAINT "FxQuote_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "FxQuote_coinAmount_positive" CHECK ("coinAmount" > 0),
  CONSTRAINT "FxQuote_targetAmount_positive" CHECK ("targetAmountMinor" > 0),
  CONSTRAINT "FxQuote_rate_positive" CHECK ("rateNumerator" > 0 AND "rateDenominator" > 0),
  CONSTRAINT "FxQuote_expiry_after_quote" CHECK ("expiresAt" > "quotedAt")
);

CREATE TABLE "CreatorWithdrawal" (
  "id" UUID NOT NULL,
  "creatorId" UUID NOT NULL,
  "reservationId" UUID NOT NULL,
  "destinationId" UUID NOT NULL,
  "fxQuoteId" UUID NOT NULL,
  "idempotencyKey" VARCHAR(200) NOT NULL,
  "coinAmount" INTEGER NOT NULL,
  "currency" CHAR(3) NOT NULL,
  "fiatAmountMinor" BIGINT NOT NULL,
  "status" "CreatorWithdrawalStatus" NOT NULL DEFAULT 'REQUESTED',
  "requestedAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "approvedAt" TIMESTAMPTZ,
  "completedAt" TIMESTAMPTZ,
  "failureCode" VARCHAR(80),
  CONSTRAINT "CreatorWithdrawal_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "CreatorWithdrawal_coinAmount_positive" CHECK ("coinAmount" > 0),
  CONSTRAINT "CreatorWithdrawal_fiatAmount_positive" CHECK ("fiatAmountMinor" > 0)
);

CREATE TABLE "PayoutAttempt" (
  "id" UUID NOT NULL,
  "withdrawalId" UUID NOT NULL,
  "providerCode" VARCHAR(40) NOT NULL,
  "idempotencyKey" VARCHAR(200) NOT NULL,
  "providerTransferRef" VARCHAR(255),
  "status" "PayoutAttemptStatus" NOT NULL DEFAULT 'CREATED',
  "submittedAt" TIMESTAMPTZ,
  "completedAt" TIMESTAMPTZ,
  "providerErrorCode" VARCHAR(100),
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "PayoutAttempt_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "PayoutProviderEvent" (
  "id" UUID NOT NULL,
  "providerCode" VARCHAR(40) NOT NULL,
  "providerEventId" VARCHAR(255) NOT NULL,
  "withdrawalId" UUID,
  "eventType" VARCHAR(100) NOT NULL,
  "payloadHash" CHAR(64) NOT NULL,
  "receivedAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "processedAt" TIMESTAMPTZ,
  "processingError" VARCHAR(500),
  CONSTRAINT "PayoutProviderEvent_pkey" PRIMARY KEY ("id")
);

ALTER TABLE "CreatorWithdrawal"
  ADD CONSTRAINT "CreatorWithdrawal_reservationId_fkey"
  FOREIGN KEY ("reservationId") REFERENCES "CreatorEarningReservation"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT "CreatorWithdrawal_destinationId_fkey"
  FOREIGN KEY ("destinationId") REFERENCES "PayoutDestination"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT "CreatorWithdrawal_fxQuoteId_fkey"
  FOREIGN KEY ("fxQuoteId") REFERENCES "FxQuote"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "PayoutAttempt"
  ADD CONSTRAINT "PayoutAttempt_withdrawalId_fkey"
  FOREIGN KEY ("withdrawalId") REFERENCES "CreatorWithdrawal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE UNIQUE INDEX "PayoutDestination_providerCode_providerRecipientRef_key"
  ON "PayoutDestination"("providerCode", "providerRecipientRef");
CREATE INDEX "PayoutDestination_creatorId_status_createdAt_idx"
  ON "PayoutDestination"("creatorId", "status", "createdAt");
CREATE INDEX "FxQuote_creatorId_status_expiresAt_idx"
  ON "FxQuote"("creatorId", "status", "expiresAt");
CREATE INDEX "FxQuote_expiresAt_idx" ON "FxQuote"("expiresAt");
CREATE UNIQUE INDEX "CreatorWithdrawal_reservationId_key" ON "CreatorWithdrawal"("reservationId");
CREATE UNIQUE INDEX "CreatorWithdrawal_idempotencyKey_key" ON "CreatorWithdrawal"("idempotencyKey");
CREATE INDEX "CreatorWithdrawal_creatorId_status_requestedAt_idx"
  ON "CreatorWithdrawal"("creatorId", "status", "requestedAt");
CREATE INDEX "CreatorWithdrawal_status_requestedAt_idx"
  ON "CreatorWithdrawal"("status", "requestedAt");
CREATE UNIQUE INDEX "PayoutAttempt_idempotencyKey_key" ON "PayoutAttempt"("idempotencyKey");
CREATE INDEX "PayoutAttempt_withdrawalId_createdAt_idx" ON "PayoutAttempt"("withdrawalId", "createdAt");
CREATE INDEX "PayoutAttempt_providerCode_providerTransferRef_idx"
  ON "PayoutAttempt"("providerCode", "providerTransferRef");
CREATE INDEX "PayoutAttempt_status_createdAt_idx" ON "PayoutAttempt"("status", "createdAt");
CREATE UNIQUE INDEX "PayoutProviderEvent_providerCode_providerEventId_key"
  ON "PayoutProviderEvent"("providerCode", "providerEventId");
CREATE INDEX "PayoutProviderEvent_withdrawalId_receivedAt_idx"
  ON "PayoutProviderEvent"("withdrawalId", "receivedAt");
CREATE INDEX "PayoutProviderEvent_processedAt_receivedAt_idx"
  ON "PayoutProviderEvent"("processedAt", "receivedAt");

ALTER TABLE "PayoutDestination" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "FxQuote" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CreatorWithdrawal" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "PayoutAttempt" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "PayoutProviderEvent" ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE
  "PayoutDestination", "FxQuote", "CreatorWithdrawal",
  "PayoutAttempt", "PayoutProviderEvent"
FROM PUBLIC, anon, authenticated, service_role;

-- Quote terms are immutable. Only an ACTIVE quote can be consumed or expired.
CREATE FUNCTION "kyron_protect_fx_quote"()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    RAISE EXCEPTION 'FX quotes cannot be deleted' USING ERRCODE = '55000';
  END IF;
  IF NEW."id" IS DISTINCT FROM OLD."id"
     OR NEW."creatorId" IS DISTINCT FROM OLD."creatorId"
     OR NEW."coinAmount" IS DISTINCT FROM OLD."coinAmount"
     OR NEW."targetCurrency" IS DISTINCT FROM OLD."targetCurrency"
     OR NEW."targetAmountMinor" IS DISTINCT FROM OLD."targetAmountMinor"
     OR NEW."rateNumerator" IS DISTINCT FROM OLD."rateNumerator"
     OR NEW."rateDenominator" IS DISTINCT FROM OLD."rateDenominator"
     OR NEW."providerCode" IS DISTINCT FROM OLD."providerCode"
     OR NEW."providerQuoteRef" IS DISTINCT FROM OLD."providerQuoteRef"
     OR NEW."quotedAt" IS DISTINCT FROM OLD."quotedAt"
     OR NEW."expiresAt" IS DISTINCT FROM OLD."expiresAt"
     OR OLD."status" <> 'ACTIVE'
     OR NEW."status" NOT IN ('CONSUMED', 'EXPIRED') THEN
    RAISE EXCEPTION 'An FX quote may only be finalized once' USING ERRCODE = '55000';
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER "FxQuote_finalize_only"
BEFORE UPDATE OR DELETE ON "FxQuote"
FOR EACH ROW EXECUTE FUNCTION "kyron_protect_fx_quote"();

-- The event identity and payload hash are immutable; processing can be marked once.
CREATE FUNCTION "kyron_protect_payout_provider_event"()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    RAISE EXCEPTION 'Payout provider events cannot be deleted' USING ERRCODE = '55000';
  END IF;
  IF NEW."id" IS DISTINCT FROM OLD."id"
     OR NEW."providerCode" IS DISTINCT FROM OLD."providerCode"
     OR NEW."providerEventId" IS DISTINCT FROM OLD."providerEventId"
     OR NEW."withdrawalId" IS DISTINCT FROM OLD."withdrawalId"
     OR NEW."eventType" IS DISTINCT FROM OLD."eventType"
     OR NEW."payloadHash" IS DISTINCT FROM OLD."payloadHash"
     OR NEW."receivedAt" IS DISTINCT FROM OLD."receivedAt"
     OR OLD."processedAt" IS NOT NULL
     OR NEW."processedAt" IS NULL THEN
    RAISE EXCEPTION 'Payout provider event may only be processed once' USING ERRCODE = '55000';
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER "PayoutProviderEvent_process_once"
BEFORE UPDATE OR DELETE ON "PayoutProviderEvent"
FOR EACH ROW EXECUTE FUNCTION "kyron_protect_payout_provider_event"();

CREATE TRIGGER "PayoutDestination_no_delete"
BEFORE DELETE ON "PayoutDestination"
FOR EACH ROW EXECUTE FUNCTION "kyron_reject_financial_evidence_mutation"();
