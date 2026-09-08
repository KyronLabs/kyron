-- What a view record has to remember beyond "it happened".
--
-- Ranking treated seen as a single bit with a flat penalty, so a post glanced
-- at once and a post opened four times scored the same, and how long anybody
-- stayed was not recorded at all. One row per person per post still -- an
-- impression count that rises on every refresh tells the author nothing --
-- but the row now counts the opens and totals the time.
ALTER TABLE "PostView"
  ADD COLUMN "count" INTEGER NOT NULL DEFAULT 1,
  ADD COLUMN "dwellMs" INTEGER NOT NULL DEFAULT 0,
  ADD COLUMN "lastViewedAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- Rows written before this existed were one open apiece, at the time they
-- were written. Leaving lastViewedAt at the default would date every historic
-- view to this migration and make a year-old read look like a fresh one.
UPDATE "PostView" SET "lastViewedAt" = "createdAt";

-- Affinity reads one reader's recent views, so the index it needs is by
-- viewer and recency; the existing one is by post, for the author's counts.
CREATE INDEX "PostView_viewerId_lastViewedAt_idx" ON "PostView"("viewerId", "lastViewedAt");
