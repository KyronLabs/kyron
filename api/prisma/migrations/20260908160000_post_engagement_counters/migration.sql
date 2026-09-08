-- Engagement counted on the post, rather than aggregated on every read.
--
-- Prisma compiles a relation `_count` into a LEFT JOIN over an unfiltered
-- `GROUP BY "postId"` across the whole table, so the cost of a page is the
-- size of PostLike rather than the size of the page: fetching twenty posts
-- that way measured 13.5ms against 0.46ms for the same twenty reading
-- columns, and it grew with every like ever recorded rather than with the
-- feed.
ALTER TABLE "Post" ADD COLUMN "likeCount" INTEGER NOT NULL DEFAULT 0;
ALTER TABLE "Post" ADD COLUMN "commentCount" INTEGER NOT NULL DEFAULT 0;
ALTER TABLE "Post" ADD COLUMN "repostCount" INTEGER NOT NULL DEFAULT 0;

-- Backfilled from the rows that exist, so an install upgrading does not show
-- every post as having no engagement.
UPDATE "Post" p SET "likeCount" = c.n
FROM (SELECT "postId", COUNT(*) AS n FROM "PostLike" GROUP BY "postId") c
WHERE p.id = c."postId";

-- Only the comments a reader can actually see. The `_count` this replaces
-- included soft-deleted ones, so a post could report five and list four; the
-- backfill takes the number the thread shows, not the one it used to claim.
UPDATE "Post" p SET "commentCount" = c.n
FROM (
  SELECT "postId", COUNT(*) AS n FROM "Comment"
  WHERE "deletedAt" IS NULL GROUP BY "postId"
) c
WHERE p.id = c."postId";

UPDATE "Post" p SET "repostCount" = c.n
FROM (SELECT "postId", COUNT(*) AS n FROM "Repost" GROUP BY "postId") c
WHERE p.id = c."postId";
