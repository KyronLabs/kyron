-- Likes on comments.
--
-- The same shape as PostLike, and a separate table for the same reason those
-- are separate: a single polymorphic "like" row pointing at either a post or a
-- comment needs a check constraint to stop it pointing at both, and gains
-- nothing for it.
CREATE TABLE IF NOT EXISTS "CommentLike" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "commentId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CommentLike_pkey" PRIMARY KEY ("id")
);

-- One like per person per comment. Without it a double tap counts twice.
CREATE UNIQUE INDEX IF NOT EXISTS "CommentLike_userId_commentId_key"
    ON "CommentLike"("userId", "commentId");

-- Counting a comment's likes reads this.
CREATE INDEX IF NOT EXISTS "CommentLike_commentId_idx"
    ON "CommentLike"("commentId");

ALTER TABLE "CommentLike"
    ADD CONSTRAINT "CommentLike_userId_fkey" FOREIGN KEY ("userId")
    REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "CommentLike"
    ADD CONSTRAINT "CommentLike_commentId_fkey" FOREIGN KEY ("commentId")
    REFERENCES "Comment"("id") ON DELETE CASCADE ON UPDATE CASCADE;
