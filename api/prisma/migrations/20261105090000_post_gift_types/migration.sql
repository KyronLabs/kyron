-- Each kind of gift a post has been sent, once each, so the feed can stack a
-- post's gifts over its heart without a query per post. Kept by
-- GiftsService alongside giftCount.

-- AlterTable
ALTER TABLE "Post" ADD COLUMN "giftTypes" TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[];

-- Backfill from the gifts already sent, earliest first.
UPDATE "Post" p
SET "giftTypes" = kinds.types
FROM (
  SELECT "postId", array_agg(type ORDER BY first) AS types
  FROM (
    SELECT "postId", type, min("createdAt") AS first
    FROM "Gift"
    GROUP BY "postId", type
  ) firsts
  GROUP BY "postId"
) kinds
WHERE p.id = kinds."postId";
