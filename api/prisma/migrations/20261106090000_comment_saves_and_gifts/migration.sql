-- Comments can be saved and sent gifts, as posts can.
--
-- A gift to a comment is a Gift row with commentId set. Its postId is still
-- the post the comment was written under, so nothing about the gift's ledger
-- changes -- but a post's own gift counts and lists now read commentId IS
-- NULL, so a reply's gifts are never added to the post it answered.

-- AlterTable
ALTER TABLE "Comment" ADD COLUMN "giftCount" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN "giftTypes" TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[];

-- AlterTable
ALTER TABLE "Gift" ADD COLUMN "commentId" UUID;

-- CreateTable
CREATE TABLE "CommentSave" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "commentId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CommentSave_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "CommentSave_commentId_idx" ON "CommentSave"("commentId");

-- CreateIndex
CREATE INDEX "CommentSave_userId_createdAt_idx" ON "CommentSave"("userId", "createdAt" DESC);

-- CreateIndex
CREATE UNIQUE INDEX "CommentSave_userId_commentId_key" ON "CommentSave"("userId", "commentId");

-- CreateIndex
CREATE INDEX "Gift_commentId_type_idx" ON "Gift"("commentId", "type");

-- AddForeignKey
ALTER TABLE "CommentSave" ADD CONSTRAINT "CommentSave_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommentSave" ADD CONSTRAINT "CommentSave_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES "Comment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Gift" ADD CONSTRAINT "Gift_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES "Comment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- Shut to the anon key, like every other table the API owns.
REVOKE ALL ON TABLE "CommentSave" FROM anon, authenticated;
ALTER TABLE "CommentSave" ENABLE ROW LEVEL SECURITY;
