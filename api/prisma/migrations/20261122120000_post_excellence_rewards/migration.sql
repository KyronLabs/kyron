-- Keep promotional reward credits distinct from the weekly refill bucket.
-- GiftsService spends the weekly allowance first and promotional credits second.
ALTER TYPE "CoinKind" ADD VALUE 'REWARD_GRANT';
ALTER TYPE "CoinKind" ADD VALUE 'REWARD_SPEND';
ALTER TYPE "CoinKind" ADD VALUE 'PROMOTIONAL_EARN';
ALTER TYPE "CoinKind" ADD VALUE 'PURCHASE_EARN';

-- Post excellence rewards.
--
-- Program rules are versioned JSON, nominations are not awards, and each
-- benefit is written once with an append-only audit event. The first reward
-- handler is promotional coins; it uses the existing non-cash CoinEntry
-- ledger and never creates withdrawable creator earnings.

CREATE TYPE "RewardProgramStatus" AS ENUM ('DRAFT', 'ACTIVE', 'PAUSED', 'ENDED');
CREATE TYPE "RewardNominationStatus" AS ENUM ('PENDING', 'APPROVED', 'DECLINED');

CREATE TABLE "PostRewardProgram" (
    "id" UUID NOT NULL,
    "key" VARCHAR(64) NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "status" "RewardProgramStatus" NOT NULL DEFAULT 'DRAFT',
    "policyVersion" INTEGER NOT NULL DEFAULT 1,
    "policy" JSONB NOT NULL,
    "startsAt" TIMESTAMPTZ,
    "endsAt" TIMESTAMPTZ,
    "createdById" UUID,
    "updatedById" UUID,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    CONSTRAINT "PostRewardProgram_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "PostRewardNomination" (
    "id" UUID NOT NULL,
    "programId" UUID NOT NULL,
    "postId" UUID NOT NULL,
    "nominatorId" UUID,
    "reason" TEXT NOT NULL,
    "status" "RewardNominationStatus" NOT NULL DEFAULT 'PENDING',
    "policyVersion" INTEGER NOT NULL,
    "policySnapshot" JSONB NOT NULL,
    "reviewedById" UUID,
    "reviewNote" TEXT,
    "reviewedAt" TIMESTAMPTZ,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    CONSTRAINT "PostRewardNomination_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "PostRewardGrant" (
    "id" UUID NOT NULL,
    "programId" UUID NOT NULL,
    "nominationId" UUID NOT NULL,
    "postId" UUID NOT NULL,
    "recipientId" UUID NOT NULL,
    "rewardType" VARCHAR(64) NOT NULL,
    "payload" JSONB NOT NULL,
    "idempotencyKey" TEXT NOT NULL,
    "grantedById" UUID,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "PostRewardGrant_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "PostRewardAuditEvent" (
    "id" UUID NOT NULL,
    "programId" UUID,
    "nominationId" UUID,
    "grantId" UUID,
    "actorId" UUID,
    "eventType" VARCHAR(64) NOT NULL,
    "details" JSONB NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "PostRewardAuditEvent_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "PostRewardProgram_key_key" ON "PostRewardProgram"("key");
CREATE INDEX "PostRewardProgram_status_startsAt_endsAt_idx"
    ON "PostRewardProgram"("status", "startsAt", "endsAt");

CREATE UNIQUE INDEX "PostRewardNomination_programId_postId_nominatorId_key"
    ON "PostRewardNomination"("programId", "postId", "nominatorId");
CREATE INDEX "PostRewardNomination_programId_status_createdAt_idx"
    ON "PostRewardNomination"("programId", "status", "createdAt");
CREATE INDEX "PostRewardNomination_postId_createdAt_idx"
    ON "PostRewardNomination"("postId", "createdAt");
CREATE INDEX "PostRewardNomination_nominatorId_createdAt_idx"
    ON "PostRewardNomination"("nominatorId", "createdAt");

CREATE UNIQUE INDEX "PostRewardGrant_idempotencyKey_key"
    ON "PostRewardGrant"("idempotencyKey");
CREATE UNIQUE INDEX "PostRewardGrant_nominationId_rewardType_key"
    ON "PostRewardGrant"("nominationId", "rewardType");
CREATE INDEX "PostRewardGrant_recipientId_createdAt_idx"
    ON "PostRewardGrant"("recipientId", "createdAt" DESC);
CREATE INDEX "PostRewardGrant_postId_createdAt_idx"
    ON "PostRewardGrant"("postId", "createdAt" DESC);

CREATE INDEX "PostRewardAuditEvent_programId_createdAt_idx"
    ON "PostRewardAuditEvent"("programId", "createdAt");
CREATE INDEX "PostRewardAuditEvent_nominationId_createdAt_idx"
    ON "PostRewardAuditEvent"("nominationId", "createdAt");
CREATE INDEX "PostRewardAuditEvent_grantId_createdAt_idx"
    ON "PostRewardAuditEvent"("grantId", "createdAt");
CREATE INDEX "PostRewardAuditEvent_actorId_createdAt_idx"
    ON "PostRewardAuditEvent"("actorId", "createdAt");

ALTER TABLE "PostRewardProgram"
    ADD CONSTRAINT "PostRewardProgram_createdById_fkey"
    FOREIGN KEY ("createdById") REFERENCES "User"("id")
    ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "PostRewardProgram"
    ADD CONSTRAINT "PostRewardProgram_updatedById_fkey"
    FOREIGN KEY ("updatedById") REFERENCES "User"("id")
    ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "PostRewardNomination"
    ADD CONSTRAINT "PostRewardNomination_programId_fkey"
    FOREIGN KEY ("programId") REFERENCES "PostRewardProgram"("id")
    ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "PostRewardNomination"
    ADD CONSTRAINT "PostRewardNomination_postId_fkey"
    FOREIGN KEY ("postId") REFERENCES "Post"("id")
    ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "PostRewardNomination"
    ADD CONSTRAINT "PostRewardNomination_nominatorId_fkey"
    FOREIGN KEY ("nominatorId") REFERENCES "User"("id")
    ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "PostRewardNomination"
    ADD CONSTRAINT "PostRewardNomination_reviewedById_fkey"
    FOREIGN KEY ("reviewedById") REFERENCES "User"("id")
    ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "PostRewardGrant"
    ADD CONSTRAINT "PostRewardGrant_programId_fkey"
    FOREIGN KEY ("programId") REFERENCES "PostRewardProgram"("id")
    ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "PostRewardGrant"
    ADD CONSTRAINT "PostRewardGrant_nominationId_fkey"
    FOREIGN KEY ("nominationId") REFERENCES "PostRewardNomination"("id")
    ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "PostRewardGrant"
    ADD CONSTRAINT "PostRewardGrant_postId_fkey"
    FOREIGN KEY ("postId") REFERENCES "Post"("id")
    ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "PostRewardGrant"
    ADD CONSTRAINT "PostRewardGrant_recipientId_fkey"
    FOREIGN KEY ("recipientId") REFERENCES "User"("id")
    ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "PostRewardGrant"
    ADD CONSTRAINT "PostRewardGrant_grantedById_fkey"
    FOREIGN KEY ("grantedById") REFERENCES "User"("id")
    ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "PostRewardAuditEvent"
    ADD CONSTRAINT "PostRewardAuditEvent_programId_fkey"
    FOREIGN KEY ("programId") REFERENCES "PostRewardProgram"("id")
    ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "PostRewardAuditEvent"
    ADD CONSTRAINT "PostRewardAuditEvent_nominationId_fkey"
    FOREIGN KEY ("nominationId") REFERENCES "PostRewardNomination"("id")
    ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "PostRewardAuditEvent"
    ADD CONSTRAINT "PostRewardAuditEvent_grantId_fkey"
    FOREIGN KEY ("grantId") REFERENCES "PostRewardGrant"("id")
    ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "PostRewardAuditEvent"
    ADD CONSTRAINT "PostRewardAuditEvent_actorId_fkey"
    FOREIGN KEY ("actorId") REFERENCES "User"("id")
    ON DELETE SET NULL ON UPDATE CASCADE;

-- The API is the only writer. Supabase's public Data API must not expose the
-- nomination queue, programme configuration or reward ledger.
REVOKE ALL ON TABLE "PostRewardProgram" FROM anon, authenticated;
REVOKE ALL ON TABLE "PostRewardNomination" FROM anon, authenticated;
REVOKE ALL ON TABLE "PostRewardGrant" FROM anon, authenticated;
REVOKE ALL ON TABLE "PostRewardAuditEvent" FROM anon, authenticated;

ALTER TABLE "PostRewardProgram" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "PostRewardNomination" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "PostRewardGrant" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "PostRewardAuditEvent" ENABLE ROW LEVEL SECURITY;

-- The scheduled weekly complimentary coin benefit has been retired.
-- Existing GRANT entries remain in the immutable ledger as grandfathered
-- balances; only the unused per-user refill-notification timestamp is removed.
ALTER TABLE "User" DROP COLUMN IF EXISTS "refillPushAt";
