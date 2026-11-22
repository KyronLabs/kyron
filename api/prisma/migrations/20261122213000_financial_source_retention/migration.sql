-- Immutable source snapshots for gift and post-reward financial events.
-- These records deliberately have no foreign keys to users or social content.

CREATE TABLE "FinancialSourceRecord" (
  "id" UUID NOT NULL,
  "sourceType" VARCHAR(64) NOT NULL,
  "sourceId" VARCHAR(160) NOT NULL,
  "eventType" VARCHAR(80) NOT NULL,
  "actorId" UUID,
  "beneficiaryId" UUID,
  "relatedIds" JSONB NOT NULL,
  "amount" DECIMAL(24,8),
  "unitCode" VARCHAR(16),
  "payload" JSONB NOT NULL,
  "occurredAt" TIMESTAMPTZ NOT NULL,
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "FinancialSourceRecord_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "FinancialSourceRecord_nonnegative_amount"
    CHECK ("amount" IS NULL OR "amount" >= 0)
);

CREATE UNIQUE INDEX "FinancialSourceRecord_sourceType_sourceId_key"
  ON "FinancialSourceRecord"("sourceType", "sourceId");
CREATE INDEX "FinancialSourceRecord_beneficiaryId_occurredAt_idx"
  ON "FinancialSourceRecord"("beneficiaryId", "occurredAt" DESC);
CREATE INDEX "FinancialSourceRecord_sourceType_occurredAt_idx"
  ON "FinancialSourceRecord"("sourceType", "occurredAt");

ALTER TABLE "FinancialSourceRecord" ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE "FinancialSourceRecord"
  FROM PUBLIC, anon, authenticated, service_role;

CREATE TRIGGER "FinancialSourceRecord_immutable"
BEFORE UPDATE OR DELETE ON "FinancialSourceRecord"
FOR EACH ROW EXECUTE FUNCTION "kyron_reject_financial_evidence_mutation"();

-- Backfill the surviving gift source records. IDs are retained as UUID
-- strings inside JSON; no personal profile fields or content are copied.
INSERT INTO "FinancialSourceRecord" (
  "id", "sourceType", "sourceId", "eventType", "actorId",
  "beneficiaryId", "relatedIds", "amount", "unitCode", "payload",
  "occurredAt"
)
SELECT
  gen_random_uuid(), 'GIFT', g."id"::text, 'GIFT_SENT', g."senderId",
  g."recipientId",
  jsonb_build_object('postId', g."postId", 'commentId', g."commentId"),
  g."coins", 'COIN',
  jsonb_build_object(
    'type', g."type",
    'coins', g."coins",
    'requestId', g."requestId"
  ),
  g."createdAt"
FROM "Gift" g
ON CONFLICT ("sourceType", "sourceId") DO NOTHING;

-- Backfill surviving fulfilled rewards. Only a numeric amount is treated as
-- a coin quantity; other reward payloads remain preserved as JSON.
INSERT INTO "FinancialSourceRecord" (
  "id", "sourceType", "sourceId", "eventType", "actorId",
  "beneficiaryId", "relatedIds", "amount", "unitCode", "payload",
  "occurredAt"
)
SELECT
  gen_random_uuid(), 'POST_REWARD_GRANT', g."id"::text, 'REWARD_GRANTED',
  g."grantedById", g."recipientId",
  jsonb_build_object(
    'programId', g."programId",
    'nominationId', g."nominationId",
    'postId', g."postId"
  ),
  CASE
    WHEN g."payload"->>'amount' ~ '^[0-9]+([.][0-9]+)?$'
    THEN (g."payload"->>'amount')::DECIMAL(24,8)
    ELSE NULL
  END,
  CASE WHEN g."rewardType" = 'PROMOTIONAL_COINS' THEN 'COIN' ELSE NULL END,
  jsonb_build_object(
    'rewardType', g."rewardType",
    'rewardPayload', g."payload",
    'idempotencyKey', g."idempotencyKey",
    'grantedById', g."grantedById"
  ),
  g."createdAt"
FROM "PostRewardGrant" g
ON CONFLICT ("sourceType", "sourceId") DO NOTHING;
