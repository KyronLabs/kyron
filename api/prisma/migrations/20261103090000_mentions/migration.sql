-- Who was mentioned, in which post or reply.
--
-- The notifications screen reads the activity tables themselves (likes,
-- comments, reposts, follows). Nothing recorded a mention, so somebody
-- written as @them was never told.
-- CreateTable
CREATE TABLE "Mention" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "authorId" UUID NOT NULL,
    "postId" UUID NOT NULL,
    "commentId" UUID,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Mention_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Mention_userId_createdAt_idx" ON "Mention"("userId", "createdAt");

-- CreateIndex
CREATE INDEX "Mention_postId_idx" ON "Mention"("postId");

-- CreateIndex
CREATE INDEX "Mention_commentId_idx" ON "Mention"("commentId");

-- AddForeignKey
ALTER TABLE "Mention" ADD CONSTRAINT "Mention_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Mention" ADD CONSTRAINT "Mention_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Mention" ADD CONSTRAINT "Mention_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Mention" ADD CONSTRAINT "Mention_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES "Comment"("id") ON DELETE CASCADE ON UPDATE CASCADE;


-- Read and written through the API only, like every other table: the app's
-- own Supabase keys see none of it.
REVOKE ALL ON TABLE "Mention" FROM anon, authenticated;
ALTER TABLE "Mention" ENABLE ROW LEVEL SECURITY;
