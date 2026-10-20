-- Community chats: rooms inside a community, several per community.
--
-- Not end-to-end encrypted, and kept apart from Conversation/Message on
-- purpose: see the CommunityChat model and docs/MESSAGING.md. The text in
-- these tables is readable, which is why the last block of this file matters.

-- CreateEnum
CREATE TYPE "CommunityChatWriters" AS ENUM ('MEMBERS', 'MODERATORS');

-- AlterEnum
ALTER TYPE "ReportTarget" ADD VALUE 'COMMUNITY_MESSAGE';

-- CreateTable
CREATE TABLE "CommunityChat" (
    "id" UUID NOT NULL,
    "communityId" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "writers" "CommunityChatWriters" NOT NULL DEFAULT 'MEMBERS',
    "slowModeSeconds" INTEGER NOT NULL DEFAULT 0,
    "position" INTEGER NOT NULL DEFAULT 0,
    "pinnedMessageId" UUID,
    "createdById" UUID,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastMessageAt" TIMESTAMPTZ,
    "deletedAt" TIMESTAMPTZ,

    CONSTRAINT "CommunityChat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CommunityChatMember" (
    "chatId" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "joinedAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastReadAt" TIMESTAMPTZ,

    CONSTRAINT "CommunityChatMember_pkey" PRIMARY KEY ("chatId","userId")
);

-- CreateTable
CREATE TABLE "CommunityChatMessage" (
    "id" UUID NOT NULL,
    "chatId" UUID NOT NULL,
    "senderId" UUID NOT NULL,
    "body" TEXT NOT NULL,
    "replyToId" UUID,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMPTZ,
    "deletedById" UUID,

    CONSTRAINT "CommunityChatMessage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CommunityChatReaction" (
    "messageId" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "emoji" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CommunityChatReaction_pkey" PRIMARY KEY ("messageId","userId")
);

-- CreateIndex
CREATE UNIQUE INDEX "CommunityChat_pinnedMessageId_key" ON "CommunityChat"("pinnedMessageId");

-- CreateIndex
CREATE INDEX "CommunityChat_communityId_position_idx" ON "CommunityChat"("communityId", "position");

-- CreateIndex
CREATE INDEX "CommunityChatMember_userId_idx" ON "CommunityChatMember"("userId");

-- CreateIndex
CREATE INDEX "CommunityChatMessage_chatId_createdAt_id_idx" ON "CommunityChatMessage"("chatId", "createdAt" DESC, "id" DESC);

-- CreateIndex
CREATE INDEX "CommunityChatMessage_senderId_createdAt_idx" ON "CommunityChatMessage"("senderId", "createdAt" DESC);

-- CreateIndex
CREATE INDEX "CommunityChatReaction_userId_idx" ON "CommunityChatReaction"("userId");

-- AddForeignKey
ALTER TABLE "CommunityChat" ADD CONSTRAINT "CommunityChat_communityId_fkey" FOREIGN KEY ("communityId") REFERENCES "Community"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunityChat" ADD CONSTRAINT "CommunityChat_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunityChat" ADD CONSTRAINT "CommunityChat_pinnedMessageId_fkey" FOREIGN KEY ("pinnedMessageId") REFERENCES "CommunityChatMessage"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunityChatMember" ADD CONSTRAINT "CommunityChatMember_chatId_fkey" FOREIGN KEY ("chatId") REFERENCES "CommunityChat"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunityChatMember" ADD CONSTRAINT "CommunityChatMember_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunityChatMessage" ADD CONSTRAINT "CommunityChatMessage_chatId_fkey" FOREIGN KEY ("chatId") REFERENCES "CommunityChat"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunityChatMessage" ADD CONSTRAINT "CommunityChatMessage_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunityChatMessage" ADD CONSTRAINT "CommunityChatMessage_deletedById_fkey" FOREIGN KEY ("deletedById") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunityChatMessage" ADD CONSTRAINT "CommunityChatMessage_replyToId_fkey" FOREIGN KEY ("replyToId") REFERENCES "CommunityChatMessage"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunityChatReaction" ADD CONSTRAINT "CommunityChatReaction_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES "CommunityChatMessage"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunityChatReaction" ADD CONSTRAINT "CommunityChatReaction_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;


-- Nobody reaches these through Supabase's own API. The app reads and writes
-- them through this API only, which checks community membership on every
-- request. Without this, readable chat text would be one anon-key query away.
REVOKE ALL ON TABLE "CommunityChat" FROM anon, authenticated;
REVOKE ALL ON TABLE "CommunityChatMember" FROM anon, authenticated;
REVOKE ALL ON TABLE "CommunityChatMessage" FROM anon, authenticated;
REVOKE ALL ON TABLE "CommunityChatReaction" FROM anon, authenticated;
ALTER TABLE "CommunityChat" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CommunityChatMember" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CommunityChatMessage" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CommunityChatReaction" ENABLE ROW LEVEL SECURITY;
