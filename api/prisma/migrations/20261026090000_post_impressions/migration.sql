-- What a feed has put in front of a reader, opened or not. Read by ranking
-- only; PostView stays what a reader opened. See docs/FEED.md.

-- CreateTable
CREATE TABLE "PostImpression" (
    "viewerId" UUID NOT NULL,
    "postId" UUID NOT NULL,
    "count" INTEGER NOT NULL DEFAULT 1,
    "lastAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "prevAt" TIMESTAMPTZ,

    CONSTRAINT "PostImpression_pkey" PRIMARY KEY ("viewerId","postId")
);

-- CreateIndex
CREATE INDEX "PostImpression_postId_idx" ON "PostImpression"("postId");

-- AddForeignKey
ALTER TABLE "PostImpression" ADD CONSTRAINT "PostImpression_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostImpression" ADD CONSTRAINT "PostImpression_viewerId_fkey" FOREIGN KEY ("viewerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- What one person scrolled past is theirs. Only the API reads it: nothing for
-- Supabase's public roles, and RLS on with no policies in case a grant is
-- ever added by mistake.
REVOKE ALL ON TABLE "PostImpression" FROM anon, authenticated;
ALTER TABLE "PostImpression" ENABLE ROW LEVEL SECURITY;
