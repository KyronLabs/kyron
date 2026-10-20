-- Group conversations with roles, and view-once attachments.
-- See docs/MESSAGING.md.

-- CreateEnum
CREATE TYPE "ConversationKind" AS ENUM ('DIRECT', 'GROUP');

-- CreateEnum
CREATE TYPE "MemberRole" AS ENUM ('OWNER', 'ADMIN', 'MEMBER', 'SPECTATOR');

-- AlterTable
ALTER TABLE "Conversation" ADD COLUMN     "joinRole" "MemberRole" NOT NULL DEFAULT 'MEMBER',
ADD COLUMN     "kind" "ConversationKind" NOT NULL DEFAULT 'DIRECT',
ADD COLUMN     "title" TEXT;

-- AlterTable
ALTER TABLE "ConversationMember" ADD COLUMN     "handRaisedAt" TIMESTAMPTZ,
ADD COLUMN     "role" "MemberRole" NOT NULL DEFAULT 'MEMBER';

-- AlterTable
ALTER TABLE "Media" ADD COLUMN     "privatePath" TEXT;

-- AlterTable
ALTER TABLE "Message" ADD COLUMN     "event" JSONB,
ADD COLUMN     "mediaGoneAt" TIMESTAMPTZ,
ADD COLUMN     "purgeAfter" TIMESTAMPTZ,
ADD COLUMN     "viewOnce" BOOLEAN NOT NULL DEFAULT false;

-- CreateTable
CREATE TABLE "MessageOpen" (
    "messageId" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "openedAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MessageOpen_pkey" PRIMARY KEY ("messageId","userId")
);

-- CreateIndex
CREATE INDEX "Message_viewOnce_mediaGoneAt_idx" ON "Message"("viewOnce", "mediaGoneAt");

-- AddForeignKey
ALTER TABLE "MessageOpen" ADD CONSTRAINT "MessageOpen_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES "Message"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MessageOpen" ADD CONSTRAINT "MessageOpen_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- Who opened what is the API's to know and nobody else's.
REVOKE ALL ON TABLE "MessageOpen" FROM anon, authenticated;
ALTER TABLE "MessageOpen" ENABLE ROW LEVEL SECURITY;
