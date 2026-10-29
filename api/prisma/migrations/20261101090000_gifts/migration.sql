-- Gifts: a reader spends coins to send a gift to a post they liked.
--
-- A test version. Coins are handed out by a weekly refill and cannot be
-- bought; earnings cannot be withdrawn. The ledger is built the way a paid
-- version needs it -- append-only, every entry keyed so it cannot be recorded
-- twice -- so purchases and payouts plug into it later rather than replace it.

-- CreateEnum
CREATE TYPE "CoinKind" AS ENUM ('GRANT', 'SPEND', 'EARN');

-- AlterTable
ALTER TABLE "Post" ADD COLUMN     "giftCount" INTEGER NOT NULL DEFAULT 0;

-- CreateTable
CREATE TABLE "CoinEntry" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "kind" "CoinKind" NOT NULL,
    "amount" INTEGER NOT NULL,
    "key" TEXT NOT NULL,
    "giftId" UUID,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CoinEntry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Gift" (
    "id" UUID NOT NULL,
    "senderId" UUID,
    "recipientId" UUID NOT NULL,
    "postId" UUID NOT NULL,
    "type" TEXT NOT NULL,
    "coins" INTEGER NOT NULL,
    "requestId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Gift_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "CoinEntry_key_key" ON "CoinEntry"("key");

-- CreateIndex
CREATE INDEX "CoinEntry_userId_kind_idx" ON "CoinEntry"("userId", "kind");

-- CreateIndex
CREATE INDEX "Gift_postId_type_idx" ON "Gift"("postId", "type");

-- CreateIndex
CREATE INDEX "Gift_recipientId_createdAt_idx" ON "Gift"("recipientId", "createdAt" DESC);

-- CreateIndex
CREATE UNIQUE INDEX "Gift_senderId_requestId_key" ON "Gift"("senderId", "requestId");

-- AddForeignKey
ALTER TABLE "CoinEntry" ADD CONSTRAINT "CoinEntry_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CoinEntry" ADD CONSTRAINT "CoinEntry_giftId_fkey" FOREIGN KEY ("giftId") REFERENCES "Gift"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Gift" ADD CONSTRAINT "Gift_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Gift" ADD CONSTRAINT "Gift_recipientId_fkey" FOREIGN KEY ("recipientId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Gift" ADD CONSTRAINT "Gift_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;


-- Wallets are reached through this API only. Without this, every account's
-- balance and every gift would be one anon-key query away.
REVOKE ALL ON TABLE "CoinEntry" FROM anon, authenticated;
REVOKE ALL ON TABLE "Gift" FROM anon, authenticated;
ALTER TABLE "CoinEntry" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Gift" ENABLE ROW LEVEL SECURITY;
