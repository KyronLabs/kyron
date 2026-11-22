-- Creator earnings, compliance holds and withdrawal-independent reservations.
-- Earnings are materialized from creator CoinEntry rows without user/social FKs.
CREATE TYPE "CreatorEarningSource" AS ENUM (
  'PURCHASE',
  'APPROVED_REWARD',
  'LEGACY_PROMOTIONAL',
  'UNKNOWN'
);

CREATE TYPE "CreatorEarningReservationStatus" AS ENUM (
  'ACTIVE',
  'RELEASED',
  'SETTLED'
);

CREATE TABLE "CreatorEarning" (
  "id" UUID NOT NULL,
  "creatorId" UUID NOT NULL,
  "sourceCoinEntryKey" VARCHAR(200) NOT NULL,
  "giftId" UUID,
  "source" "CreatorEarningSource" NOT NULL,
  "amount" INTEGER NOT NULL,
  "withdrawable" BOOLEAN NOT NULL,
  "availableAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "CreatorEarning_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "CreatorEarning_amount_positive" CHECK ("amount" > 0)
);


-- Materialize historical creator proceeds before live writes begin. Unknown
-- legacy EARN rows remain explicitly non-withdrawable.
INSERT INTO "CreatorEarning" (
  "id", "creatorId", "sourceCoinEntryKey", "giftId", "source",
  "amount", "withdrawable", "availableAt", "createdAt"
)
SELECT
  gen_random_uuid(),
  "userId",
  "key",
  "giftId",
  CASE "kind"
    WHEN 'PURCHASE_EARN' THEN 'PURCHASE'::"CreatorEarningSource"
    WHEN 'REWARD_EARN' THEN 'APPROVED_REWARD'::"CreatorEarningSource"
    WHEN 'PROMOTIONAL_EARN' THEN 'LEGACY_PROMOTIONAL'::"CreatorEarningSource"
    ELSE 'UNKNOWN'::"CreatorEarningSource"
  END,
  "amount",
  "kind" IN ('PURCHASE_EARN', 'REWARD_EARN'),
  "createdAt",
  "createdAt"
FROM "CoinEntry"
WHERE "kind" IN ('PURCHASE_EARN', 'REWARD_EARN', 'PROMOTIONAL_EARN', 'EARN')
  AND "amount" > 0;

CREATE TABLE "CreatorEarningHold" (
  "id" UUID NOT NULL,
  "earningId" UUID NOT NULL,
  "reasonCode" VARCHAR(80) NOT NULL,
  "note" VARCHAR(500),
  "placedById" UUID NOT NULL,
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "releasedAt" TIMESTAMPTZ,
  "releasedById" UUID,
  "releaseNote" VARCHAR(500),
  CONSTRAINT "CreatorEarningHold_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "CreatorEarningHold_release_pair" CHECK (
    ("releasedAt" IS NULL AND "releasedById" IS NULL) OR
    ("releasedAt" IS NOT NULL AND "releasedById" IS NOT NULL)
  )
);

CREATE TABLE "CreatorEarningReservation" (
  "id" UUID NOT NULL,
  "creatorId" UUID NOT NULL,
  "idempotencyKey" VARCHAR(200) NOT NULL,
  "amount" INTEGER NOT NULL,
  "status" "CreatorEarningReservationStatus" NOT NULL DEFAULT 'ACTIVE',
  "expiresAt" TIMESTAMPTZ,
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "finalizedAt" TIMESTAMPTZ,
  CONSTRAINT "CreatorEarningReservation_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "CreatorEarningReservation_amount_positive" CHECK ("amount" > 0),
  CONSTRAINT "CreatorEarningReservation_finalized_state" CHECK (
    ("status" = 'ACTIVE' AND "finalizedAt" IS NULL) OR
    ("status" IN ('RELEASED', 'SETTLED') AND "finalizedAt" IS NOT NULL)
  )
);

CREATE TABLE "CreatorEarningReservationLine" (
  "id" UUID NOT NULL,
  "reservationId" UUID NOT NULL,
  "earningId" UUID NOT NULL,
  "amount" INTEGER NOT NULL,
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "CreatorEarningReservationLine_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "CreatorEarningReservationLine_amount_positive" CHECK ("amount" > 0)
);

ALTER TABLE "CreatorEarningHold"
  ADD CONSTRAINT "CreatorEarningHold_earningId_fkey"
  FOREIGN KEY ("earningId") REFERENCES "CreatorEarning"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "CreatorEarningReservationLine"
  ADD CONSTRAINT "CreatorEarningReservationLine_reservationId_fkey"
  FOREIGN KEY ("reservationId") REFERENCES "CreatorEarningReservation"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT "CreatorEarningReservationLine_earningId_fkey"
  FOREIGN KEY ("earningId") REFERENCES "CreatorEarning"("id") ON DELETE RESTRICT ON UPDATE CASCADE;


-- A reservation is valid only when its allocation lines exactly equal its
-- requested amount. Deferred checking allows the header and lines to be
-- inserted atomically in either statement order within one transaction.
CREATE FUNCTION "kyron_assert_creator_earning_reservation_total"()
RETURNS trigger
LANGUAGE plpgsql
AS $creator_earning_total$
DECLARE
  allocated INTEGER;
BEGIN
  SELECT COALESCE(SUM("amount"), 0)::int
  INTO allocated
  FROM "CreatorEarningReservationLine"
  WHERE "reservationId" = NEW."id";

  IF allocated <> NEW."amount" THEN
    RAISE EXCEPTION 'Creator earning reservation % allocates %, expected %',
      NEW."id", allocated, NEW."amount"
      USING ERRCODE = '23514';
  END IF;
  RETURN NULL;
END;
$creator_earning_total$;
CREATE CONSTRAINT TRIGGER "CreatorEarningReservation_allocation_total"
AFTER INSERT ON "CreatorEarningReservation"
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION "kyron_assert_creator_earning_reservation_total"();

CREATE UNIQUE INDEX "CreatorEarning_sourceCoinEntryKey_key" ON "CreatorEarning"("sourceCoinEntryKey");
CREATE INDEX "CreatorEarning_creatorId_withdrawable_availableAt_createdAt_idx"
  ON "CreatorEarning"("creatorId", "withdrawable", "availableAt", "createdAt");
CREATE INDEX "CreatorEarning_giftId_idx" ON "CreatorEarning"("giftId");
CREATE INDEX "CreatorEarningHold_earningId_releasedAt_idx" ON "CreatorEarningHold"("earningId", "releasedAt");
CREATE INDEX "CreatorEarningHold_createdAt_idx" ON "CreatorEarningHold"("createdAt");
CREATE UNIQUE INDEX "CreatorEarningReservation_idempotencyKey_key" ON "CreatorEarningReservation"("idempotencyKey");
CREATE INDEX "CreatorEarningReservation_creatorId_status_createdAt_idx"
  ON "CreatorEarningReservation"("creatorId", "status", "createdAt");
CREATE INDEX "CreatorEarningReservation_status_expiresAt_idx"
  ON "CreatorEarningReservation"("status", "expiresAt");
CREATE UNIQUE INDEX "CreatorEarningReservationLine_reservationId_earningId_key"
  ON "CreatorEarningReservationLine"("reservationId", "earningId");
CREATE INDEX "CreatorEarningReservationLine_earningId_idx"
  ON "CreatorEarningReservationLine"("earningId");

ALTER TABLE "CreatorEarning" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CreatorEarningHold" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CreatorEarningReservation" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CreatorEarningReservationLine" ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE
  "CreatorEarning",
  "CreatorEarningHold",
  "CreatorEarningReservation",
  "CreatorEarningReservationLine"
FROM PUBLIC, anon, authenticated, service_role;

-- Earnings and reservation allocations are immutable evidence. Holds may only
-- transition once from active to released; their original decision is retained.
CREATE TRIGGER "CreatorEarning_immutable"
BEFORE UPDATE OR DELETE ON "CreatorEarning"
FOR EACH ROW EXECUTE FUNCTION "kyron_reject_financial_evidence_mutation"();

CREATE TRIGGER "CreatorEarningReservationLine_immutable"
BEFORE UPDATE OR DELETE ON "CreatorEarningReservationLine"
FOR EACH ROW EXECUTE FUNCTION "kyron_reject_financial_evidence_mutation"();

CREATE FUNCTION "kyron_protect_creator_earning_hold"()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    RAISE EXCEPTION 'Creator earning holds cannot be deleted'
      USING ERRCODE = '55000';
  END IF;
  IF NEW."id" IS DISTINCT FROM OLD."id"
     OR NEW."earningId" IS DISTINCT FROM OLD."earningId"
     OR NEW."reasonCode" IS DISTINCT FROM OLD."reasonCode"
     OR NEW."note" IS DISTINCT FROM OLD."note"
     OR NEW."placedById" IS DISTINCT FROM OLD."placedById"
     OR NEW."createdAt" IS DISTINCT FROM OLD."createdAt"
     OR OLD."releasedAt" IS NOT NULL
     OR NEW."releasedAt" IS NULL
     OR NEW."releasedById" IS NULL THEN
    RAISE EXCEPTION 'A creator earning hold may only be released once'
      USING ERRCODE = '55000';
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER "CreatorEarningHold_release_only"
BEFORE UPDATE OR DELETE ON "CreatorEarningHold"
FOR EACH ROW EXECUTE FUNCTION "kyron_protect_creator_earning_hold"();

CREATE FUNCTION "kyron_protect_creator_earning_reservation"()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    RAISE EXCEPTION 'Creator earning reservations cannot be deleted'
      USING ERRCODE = '55000';
  END IF;
  IF NEW."id" IS DISTINCT FROM OLD."id"
     OR NEW."creatorId" IS DISTINCT FROM OLD."creatorId"
     OR NEW."idempotencyKey" IS DISTINCT FROM OLD."idempotencyKey"
     OR NEW."amount" IS DISTINCT FROM OLD."amount"
     OR NEW."expiresAt" IS DISTINCT FROM OLD."expiresAt"
     OR NEW."createdAt" IS DISTINCT FROM OLD."createdAt"
     OR OLD."status" <> 'ACTIVE'
     OR NEW."status" NOT IN ('RELEASED', 'SETTLED')
     OR NEW."finalizedAt" IS NULL THEN
    RAISE EXCEPTION 'A creator earning reservation may only be finalized once'
      USING ERRCODE = '55000';
  END IF;
  RETURN NEW;
END;
$$;
CREATE TRIGGER "CreatorEarningReservation_finalize_only"
BEFORE UPDATE OR DELETE ON "CreatorEarningReservation"
FOR EACH ROW EXECUTE FUNCTION "kyron_protect_creator_earning_reservation"();
