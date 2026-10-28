-- When each post was first on screen for each reader, for Insights' reach.
--
-- Rows written before this get the earliest time they still know: the
-- sitting before the last if there was one, else the last. That is later
-- than the truth for posts seen three times or more, so reach before this
-- migration leans recent; from here on it is exact.
ALTER TABLE "PostImpression" ADD COLUMN "createdAt" TIMESTAMPTZ;
UPDATE "PostImpression" SET "createdAt" = COALESCE(LEAST("prevAt", "lastAt"), "lastAt");
ALTER TABLE "PostImpression" ALTER COLUMN "createdAt" SET DEFAULT now();
ALTER TABLE "PostImpression" ALTER COLUMN "createdAt" SET NOT NULL;

CREATE INDEX "PostImpression_postId_createdAt_idx" ON "PostImpression"("postId", "createdAt");
