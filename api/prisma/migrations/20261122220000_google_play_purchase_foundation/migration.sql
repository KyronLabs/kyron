-- Google Play one-time purchase evidence and notification inbox.
-- No user foreign keys: financial evidence must survive account deletion.
CREATE TYPE "GooglePlayPurchaseStatus" AS ENUM ('VERIFIED', 'CONSUMED', 'VOIDED', 'REFUNDED');

CREATE TABLE "GooglePlayPurchase" (
  "id" UUID NOT NULL,
  "userId" UUID NOT NULL,
  "purchaseTokenHash" CHAR(64) NOT NULL,
  "encryptedToken" TEXT NOT NULL,
  "productId" VARCHAR(160) NOT NULL,
  "orderId" VARCHAR(160),
  "quantity" INTEGER NOT NULL,
  "coinAmount" INTEGER NOT NULL,
  "purchaseTime" TIMESTAMPTZ NOT NULL,
  "acknowledgementState" INTEGER NOT NULL,
  "status" "GooglePlayPurchaseStatus" NOT NULL DEFAULT 'VERIFIED',
  "coinEntryKey" VARCHAR(200) NOT NULL,
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatedAt" TIMESTAMPTZ NOT NULL,
  CONSTRAINT "GooglePlayPurchase_pkey" PRIMARY KEY ("id"),
  CONSTRAINT "GooglePlayPurchase_quantity_positive" CHECK ("quantity" > 0),
  CONSTRAINT "GooglePlayPurchase_coinAmount_positive" CHECK ("coinAmount" > 0),
  CONSTRAINT "GooglePlayPurchase_ack_state_valid" CHECK ("acknowledgementState" IN (0, 1))
);
CREATE UNIQUE INDEX "GooglePlayPurchase_purchaseTokenHash_key" ON "GooglePlayPurchase"("purchaseTokenHash");
CREATE UNIQUE INDEX "GooglePlayPurchase_coinEntryKey_key" ON "GooglePlayPurchase"("coinEntryKey");
CREATE INDEX "GooglePlayPurchase_userId_createdAt_idx" ON "GooglePlayPurchase"("userId", "createdAt" DESC);
CREATE INDEX "GooglePlayPurchase_orderId_idx" ON "GooglePlayPurchase"("orderId");

CREATE TABLE "GooglePlayNotification" (
  "id" UUID NOT NULL,
  "messageId" VARCHAR(200) NOT NULL,
  "eventType" VARCHAR(80) NOT NULL,
  "purchaseTokenHash" CHAR(64),
  "payload" JSONB NOT NULL,
  "receivedAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "processedAt" TIMESTAMPTZ,
  "processingError" VARCHAR(500),
  CONSTRAINT "GooglePlayNotification_pkey" PRIMARY KEY ("id")
);
CREATE UNIQUE INDEX "GooglePlayNotification_messageId_key" ON "GooglePlayNotification"("messageId");
CREATE INDEX "GooglePlayNotification_token_received_idx" ON "GooglePlayNotification"("purchaseTokenHash", "receivedAt");
CREATE INDEX "GooglePlayNotification_pending_idx" ON "GooglePlayNotification"("processedAt", "receivedAt");

ALTER TABLE "GooglePlayPurchase" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "GooglePlayNotification" ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE "GooglePlayPurchase", "GooglePlayNotification"
  FROM PUBLIC, anon, authenticated, service_role;
