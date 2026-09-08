-- Recomputes Post's engagement counters from the rows themselves.
--
-- The counters are maintained on the write paths, inside the same transaction
-- as the row they count, so they should not drift. This exists because
-- "should not" is not "cannot": a restore from a partial backup, a manual
-- DELETE, or a bug in a future write path would all leave a number that is
-- quietly wrong, and a wrong number nobody can correct is worse than a slow
-- query.
--
--   psql "$DATABASE_URL" -f scripts/recount.sql
--
-- Safe to run against a live database: it takes no locks a normal UPDATE
-- would not, and the counters it writes are the ones the reads already
-- expect.
UPDATE "Post" p SET
  "likeCount" = COALESCE(l.n, 0),
  "commentCount" = COALESCE(c.n, 0),
  "repostCount" = COALESCE(r.n, 0)
FROM (SELECT id FROM "Post") ids
LEFT JOIN (SELECT "postId", COUNT(*) AS n FROM "PostLike" GROUP BY "postId") l
  ON l."postId" = ids.id
LEFT JOIN (
  SELECT "postId", COUNT(*) AS n FROM "Comment"
  WHERE "deletedAt" IS NULL GROUP BY "postId"
) c ON c."postId" = ids.id
LEFT JOIN (SELECT "postId", COUNT(*) AS n FROM "Repost" GROUP BY "postId") r
  ON r."postId" = ids.id
WHERE p.id = ids.id
  AND (p."likeCount" IS DISTINCT FROM COALESCE(l.n, 0)
    OR p."commentCount" IS DISTINCT FROM COALESCE(c.n, 0)
    OR p."repostCount" IS DISTINCT FROM COALESCE(r.n, 0));
