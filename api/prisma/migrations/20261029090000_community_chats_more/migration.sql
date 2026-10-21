-- Community chats: muting, one push per unread run, edits kept for review,
-- photos/clips/voice notes in the private bucket, and polls.

-- AlterTable
ALTER TABLE "CommunityChatMember" ADD COLUMN     "mutedAt" TIMESTAMPTZ,
ADD COLUMN     "notifiedAt" TIMESTAMPTZ;

-- AlterTable
ALTER TABLE "CommunityChatMessage" ADD COLUMN     "editedAt" TIMESTAMPTZ;

-- AlterTable
ALTER TABLE "Media" ADD COLUMN     "communityMessageId" UUID;

-- CreateTable
CREATE TABLE "CommunityChatMessageEdit" (
    "id" UUID NOT NULL,
    "messageId" UUID NOT NULL,
    "body" TEXT NOT NULL,
    "editedAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CommunityChatMessageEdit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CommunityChatPoll" (
    "id" UUID NOT NULL,
    "messageId" UUID NOT NULL,
    "multiple" BOOLEAN NOT NULL DEFAULT false,
    "closedAt" TIMESTAMPTZ,

    CONSTRAINT "CommunityChatPoll_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CommunityChatPollOption" (
    "id" UUID NOT NULL,
    "pollId" UUID NOT NULL,
    "text" TEXT NOT NULL,
    "position" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "CommunityChatPollOption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CommunityChatPollVote" (
    "pollId" UUID NOT NULL,
    "optionId" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CommunityChatPollVote_pkey" PRIMARY KEY ("optionId","userId")
);

-- CreateIndex
CREATE INDEX "CommunityChatMessageEdit_messageId_editedAt_idx" ON "CommunityChatMessageEdit"("messageId", "editedAt");

-- CreateIndex
CREATE UNIQUE INDEX "CommunityChatPoll_messageId_key" ON "CommunityChatPoll"("messageId");

-- CreateIndex
CREATE INDEX "CommunityChatPollOption_pollId_position_idx" ON "CommunityChatPollOption"("pollId", "position");

-- CreateIndex
CREATE INDEX "CommunityChatPollVote_pollId_userId_idx" ON "CommunityChatPollVote"("pollId", "userId");

-- CreateIndex
CREATE INDEX "Media_communityMessageId_position_idx" ON "Media"("communityMessageId", "position");

-- AddForeignKey
ALTER TABLE "Media" ADD CONSTRAINT "Media_communityMessageId_fkey" FOREIGN KEY ("communityMessageId") REFERENCES "CommunityChatMessage"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunityChatMessageEdit" ADD CONSTRAINT "CommunityChatMessageEdit_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES "CommunityChatMessage"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunityChatPoll" ADD CONSTRAINT "CommunityChatPoll_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES "CommunityChatMessage"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunityChatPollOption" ADD CONSTRAINT "CommunityChatPollOption_pollId_fkey" FOREIGN KEY ("pollId") REFERENCES "CommunityChatPoll"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunityChatPollVote" ADD CONSTRAINT "CommunityChatPollVote_pollId_fkey" FOREIGN KEY ("pollId") REFERENCES "CommunityChatPoll"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunityChatPollVote" ADD CONSTRAINT "CommunityChatPollVote_optionId_fkey" FOREIGN KEY ("optionId") REFERENCES "CommunityChatPollOption"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunityChatPollVote" ADD CONSTRAINT "CommunityChatPollVote_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- Out of reach of Supabase's own API roles, like the other community chat
-- tables: what is said in a chat, and who voted for what, go through the
-- API's checks or nowhere.
REVOKE ALL ON TABLE "CommunityChatMessageEdit" FROM anon, authenticated;
REVOKE ALL ON TABLE "CommunityChatPoll" FROM anon, authenticated;
REVOKE ALL ON TABLE "CommunityChatPollOption" FROM anon, authenticated;
REVOKE ALL ON TABLE "CommunityChatPollVote" FROM anon, authenticated;
ALTER TABLE "CommunityChatMessageEdit" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CommunityChatPoll" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CommunityChatPollOption" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CommunityChatPollVote" ENABLE ROW LEVEL SECURITY;
