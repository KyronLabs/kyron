-- Kyron financial ledger foundation.
--
-- This migration is additive. It does not rewrite or migrate existing CoinEntry
-- rows and does not enable purchases, withdrawals, or live money movement.
-- The existing CoinEntry remains the virtual-coin source ledger during the
-- separately reviewed bridge/migration phase.

CREATE TYPE "FinancialAccountType" AS ENUM (
  'ASSET',
  'LIABILITY',
  'EQUITY',
  'REVENUE',
  'EXPENSE'
);

CREATE TYPE "FinancialEntrySide" AS ENUM ('DEBIT', 'CREDIT');

CREATE TYPE "FinancialAccountStatus" AS ENUM ('ACTIVE', 'FROZEN', 'CLOSED');

CREATE TABLE "LedgerAccount" (
  "id" UUID NOT NULL,
  "accountKey" VARCHAR(160) NOT NULL,
  "name" VARCHAR(120) NOT NULL,
  "accountType" "FinancialAccountType" NOT NULL,
  "normalSide" "FinancialEntrySide" NOT NULL,
  "currencyCode" VARCHAR(12) NOT NULL,
  "ownerId" UUID,
  "status" "FinancialAccountStatus" NOT NULL DEFAULT 'ACTIVE',
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatedAt" TIMESTAMPTZ NOT NULL,
  CONSTRAINT "LedgerAccount_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "LedgerAccount_currencyCode_uppercase" CHECK ("currencyCode" = upper("currencyCode"))
);

CREATE TABLE "LedgerTransaction" (
  "id" UUID NOT NULL,
  "createdXid" BIGINT NOT NULL DEFAULT txid_current(),
  "idempotencyKey" VARCHAR(200) NOT NULL,
  "requestHash" CHAR(64) NOT NULL,
  "eventType" VARCHAR(64) NOT NULL,
  "sourceType" VARCHAR(64) NOT NULL,
  "sourceId" VARCHAR(160),
  "correlationId" VARCHAR(160),
  "currencyCode" VARCHAR(12) NOT NULL,
  "description" VARCHAR(500),
  "metadata" JSONB,
  "reversalOfId" UUID,
  "actorId" UUID,
  "effectiveAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "LedgerTransaction_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "LedgerTransaction_currencyCode_uppercase" CHECK ("currencyCode" = upper("currencyCode"))
);

CREATE TABLE "LedgerPosting" (
  "id" UUID NOT NULL,
  "transactionId" UUID NOT NULL,
  "accountId" UUID NOT NULL,
  "lineNumber" INTEGER NOT NULL,
  "side" "FinancialEntrySide" NOT NULL,
  "amount" DECIMAL(24,8) NOT NULL,
  "memo" VARCHAR(240),
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "LedgerPosting_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "LedgerPosting_positive_amount" CHECK ("amount" > 0),
  CONSTRAINT "LedgerPosting_positive_line_number" CHECK ("lineNumber" > 0)
);

CREATE TABLE "CreatorConversionRate" (
  "id" UUID NOT NULL,
  "countryCode" CHAR(2) NOT NULL,
  "currencyCode" CHAR(3) NOT NULL,
  "fiatPerCoin" DECIMAL(24,12) NOT NULL,
  "rateSource" VARCHAR(80) NOT NULL,
  "policyVersion" INTEGER NOT NULL DEFAULT 1,
  "effectiveAt" TIMESTAMPTZ NOT NULL,
  "expiresAt" TIMESTAMPTZ,
  "createdById" UUID,
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "CreatorConversionRate_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "CreatorConversionRate_positive_rate" CHECK ("fiatPerCoin" > 0),
  CONSTRAINT "CreatorConversionRate_positive_policy_version" CHECK ("policyVersion" > 0),
  CONSTRAINT "CreatorConversionRate_valid_window" CHECK ("expiresAt" IS NULL OR "expiresAt" > "effectiveAt"),
  CONSTRAINT "CreatorConversionRate_country_uppercase" CHECK ("countryCode" = upper("countryCode")),
  CONSTRAINT "CreatorConversionRate_currency_uppercase" CHECK ("currencyCode" = upper("currencyCode"))
);

CREATE TABLE "FinancialAuditEvent" (
  "id" UUID NOT NULL,
  "actorId" UUID,
  "eventType" VARCHAR(80) NOT NULL,
  "subjectType" VARCHAR(80) NOT NULL,
  "subjectId" VARCHAR(160),
  "requestId" VARCHAR(160),
  "metadata" JSONB NOT NULL,
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "FinancialAuditEvent_pkey" PRIMARY KEY ("id")
);

-- These tables contain financial/accounting evidence. They are API-owned,
-- not client Data API tables. Keep them out of anon/authenticated access even
-- if project-level default privileges change; Prisma uses the server DB role.
ALTER TABLE "LedgerAccount" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "LedgerTransaction" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "LedgerPosting" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CreatorConversionRate" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "FinancialAuditEvent" ENABLE ROW LEVEL SECURITY;

REVOKE ALL ON TABLE
  "LedgerAccount",
  "LedgerTransaction",
  "LedgerPosting",
  "CreatorConversionRate",
  "FinancialAuditEvent"
FROM PUBLIC, anon, authenticated, service_role;

CREATE UNIQUE INDEX "LedgerAccount_accountKey_key" ON "LedgerAccount"("accountKey");
CREATE UNIQUE INDEX "LedgerTransaction_idempotencyKey_key" ON "LedgerTransaction"("idempotencyKey");
CREATE UNIQUE INDEX "LedgerTransaction_reversalOfId_key" ON "LedgerTransaction"("reversalOfId");
CREATE UNIQUE INDEX "LedgerPosting_transactionId_lineNumber_key" ON "LedgerPosting"("transactionId", "lineNumber");
CREATE INDEX "LedgerAccount_ownerId_currencyCode_status_idx" ON "LedgerAccount"("ownerId", "currencyCode", "status");
CREATE INDEX "LedgerAccount_accountType_currencyCode_idx" ON "LedgerAccount"("accountType", "currencyCode");
CREATE INDEX "LedgerTransaction_sourceType_sourceId_idx" ON "LedgerTransaction"("sourceType", "sourceId");
CREATE INDEX "LedgerTransaction_correlationId_idx" ON "LedgerTransaction"("correlationId");
CREATE INDEX "LedgerTransaction_actorId_createdAt_idx" ON "LedgerTransaction"("actorId", "createdAt");
CREATE INDEX "LedgerTransaction_reversalOfId_idx" ON "LedgerTransaction"("reversalOfId");
CREATE INDEX "LedgerTransaction_createdAt_idx" ON "LedgerTransaction"("createdAt");
CREATE INDEX "LedgerPosting_accountId_createdAt_idx" ON "LedgerPosting"("accountId", "createdAt");
CREATE INDEX "CreatorConversionRate_countryCode_currencyCode_effectiveAt_idx" ON "CreatorConversionRate"("countryCode", "currencyCode", "effectiveAt");
CREATE INDEX "FinancialAuditEvent_actorId_createdAt_idx" ON "FinancialAuditEvent"("actorId", "createdAt");
CREATE INDEX "FinancialAuditEvent_subjectType_subjectId_createdAt_idx" ON "FinancialAuditEvent"("subjectType", "subjectId", "createdAt");
CREATE INDEX "FinancialAuditEvent_eventType_createdAt_idx" ON "FinancialAuditEvent"("eventType", "createdAt");

-- Actor/owner IDs are immutable UUID snapshots, intentionally not foreign
-- keys to User. Account deletion must not mutate or cascade through financial
-- evidence; the retained UUID is pseudonymous and the User row may be deleted.
ALTER TABLE "LedgerTransaction"
  ADD CONSTRAINT "LedgerTransaction_reversalOfId_fkey"
  FOREIGN KEY ("reversalOfId") REFERENCES "LedgerTransaction"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "LedgerPosting"
  ADD CONSTRAINT "LedgerPosting_transactionId_fkey"
  FOREIGN KEY ("transactionId") REFERENCES "LedgerTransaction"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT "LedgerPosting_accountId_fkey"
  FOREIGN KEY ("accountId") REFERENCES "LedgerAccount"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- A transaction and all of its postings must be written in one database
-- transaction. This prevents adding a balanced pair to an old ledger event.
CREATE FUNCTION "kyron_require_same_xact_for_ledger_posting"()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
  parent_xid BIGINT;
BEGIN
  SELECT "createdXid" INTO parent_xid
  FROM "LedgerTransaction"
  WHERE "id" = NEW."transactionId";

  IF parent_xid IS NULL OR parent_xid <> txid_current() THEN
    RAISE EXCEPTION 'Ledger postings must be created in the same SQL transaction as their LedgerTransaction'
      USING ERRCODE = '23514';
  END IF;

  RETURN NEW;
END;
$$;

CREATE TRIGGER "LedgerPosting_same_xact_before_insert"
BEFORE INSERT ON "LedgerPosting"
FOR EACH ROW
EXECUTE FUNCTION "kyron_require_same_xact_for_ledger_posting"();

-- Balance is checked at commit, after all posting lines have been inserted.
-- Every posting must use an account denominated in the transaction currency.
CREATE FUNCTION "kyron_assert_ledger_transaction_balanced"()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
  posting_count BIGINT;
  debit_total NUMERIC;
  credit_total NUMERIC;
  currency_mismatch BOOLEAN;
BEGIN
  SELECT
    COUNT(p."id"),
    COALESCE(SUM(CASE WHEN p."side" = 'DEBIT' THEN p."amount" ELSE 0 END), 0),
    COALESCE(SUM(CASE WHEN p."side" = 'CREDIT' THEN p."amount" ELSE 0 END), 0),
    COALESCE(BOOL_OR(a."currencyCode" <> t."currencyCode"), FALSE)
  INTO posting_count, debit_total, credit_total, currency_mismatch
  FROM "LedgerTransaction" t
  LEFT JOIN "LedgerPosting" p ON p."transactionId" = t."id"
  LEFT JOIN "LedgerAccount" a ON a."id" = p."accountId"
  WHERE t."id" = NEW."id"
  GROUP BY t."id", t."currencyCode";

  IF posting_count < 2 THEN
    RAISE EXCEPTION 'Ledger transaction % must contain at least two posting lines', NEW."id"
      USING ERRCODE = '23514';
  END IF;

  IF debit_total <> credit_total THEN
    RAISE EXCEPTION 'Ledger transaction % is not balanced (debits %, credits %)', NEW."id", debit_total, credit_total
      USING ERRCODE = '23514';
  END IF;

  IF currency_mismatch THEN
    RAISE EXCEPTION 'Ledger transaction % contains a posting to an account in another currency', NEW."id"
      USING ERRCODE = '23514';
  END IF;

  RETURN NULL;
END;
$$;

CREATE CONSTRAINT TRIGGER "LedgerTransaction_balanced_at_commit"
AFTER INSERT ON "LedgerTransaction"
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW
EXECUTE FUNCTION "kyron_assert_ledger_transaction_balanced"();

-- Financial evidence is append-only. Corrections are new compensating events.
CREATE FUNCTION "kyron_reject_financial_evidence_mutation"()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE EXCEPTION 'Financial evidence is append-only; create a compensating event instead'
    USING ERRCODE = '55000';
END;
$$;

CREATE TRIGGER "LedgerTransaction_immutable"
BEFORE UPDATE OR DELETE ON "LedgerTransaction"
FOR EACH ROW EXECUTE FUNCTION "kyron_reject_financial_evidence_mutation"();

CREATE TRIGGER "LedgerPosting_immutable"
BEFORE UPDATE OR DELETE ON "LedgerPosting"
FOR EACH ROW EXECUTE FUNCTION "kyron_reject_financial_evidence_mutation"();

CREATE TRIGGER "FinancialAuditEvent_immutable"
BEFORE UPDATE OR DELETE ON "FinancialAuditEvent"
FOR EACH ROW EXECUTE FUNCTION "kyron_reject_financial_evidence_mutation"();

CREATE TRIGGER "CreatorConversionRate_immutable"
BEFORE UPDATE OR DELETE ON "CreatorConversionRate"
FOR EACH ROW EXECUTE FUNCTION "kyron_reject_financial_evidence_mutation"();

-- An account may be renamed or frozen, but its historical identity,
-- classification, denomination and owner cannot be rewritten.
CREATE FUNCTION "kyron_protect_ledger_account_identity"()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW."accountKey" IS DISTINCT FROM OLD."accountKey"
     OR NEW."accountType" IS DISTINCT FROM OLD."accountType"
     OR NEW."normalSide" IS DISTINCT FROM OLD."normalSide"
     OR NEW."currencyCode" IS DISTINCT FROM OLD."currencyCode"
     OR NEW."ownerId" IS DISTINCT FROM OLD."ownerId" THEN
    RAISE EXCEPTION 'Ledger account identity is immutable; create a new account instead'
      USING ERRCODE = '55000';
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER "LedgerAccount_identity_immutable"
BEFORE UPDATE ON "LedgerAccount"
FOR EACH ROW EXECUTE FUNCTION "kyron_protect_ledger_account_identity"();
