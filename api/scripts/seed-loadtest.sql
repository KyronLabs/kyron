-- A dataset the ranking engine has to work at.
--
-- Not a fixture for correctness tests -- those live beside the code and use
-- fakes. This exists so the numbers in docs/PERFORMANCE.md can be reproduced,
-- and so a change that slows the feed down shows up as a number rather than as
-- a complaint six weeks later.
--
-- Shaped to make the ranker work rather than to look realistic: the candidate
-- pool is 400 and the window is fourteen days, so the posts have to outnumber
-- the pool and span the window, or freshness decay has nothing to sort by.
--
--   psql "$DATABASE_URL" -f scripts/seed-loadtest.sql
--
-- Every row it writes is namespaced under an id prefix and an @load.test
-- address, so it can be removed again without touching anything real:
--   DELETE FROM "User" WHERE email LIKE '%@load.test';
SET client_min_messages TO WARNING;

INSERT INTO "User" (id, email, username, password, name, role, status,
                    "kyronPoints", "emailStatus", "createdAt", "updatedAt")
SELECT
  ('00000000-0000-4000-8000-' || lpad(n::text, 12, '0'))::uuid,
  'user' || n || '@load.test',
  'user' || n,
  'not-a-real-hash',
  'Load User ' || n,
  'USER', 'ACTIVE', 0, 'VERIFIED',
  now() - (n || ' minutes')::interval,
  now()
FROM generate_series(1, 500) AS n
ON CONFLICT DO NOTHING;

INSERT INTO "UserProfile" (id, "userId", bio, "avatarUrl")
SELECT gen_random_uuid(), id, 'A profile for load testing.',
       'https://example.test/a.png'
FROM "User" WHERE email LIKE '%@load.test'
ON CONFLICT DO NOTHING;

-- Spread across the whole ranking window, so freshness has a range to work
-- over rather than every candidate scoring alike.
INSERT INTO "Post" (id, "authorId", content, "createdAt", "updatedAt",
                    "replyPolicy")
SELECT
  ('10000000-0000-4000-8000-' || lpad(n::text, 12, '0'))::uuid,
  ('00000000-0000-4000-8000-' || lpad(((n % 500) + 1)::text, 12, '0'))::uuid,
  'Load test post ' || n || ' with #tag' || (n % 40) || ' and enough words to lay out.',
  now() - ((n % 20160) || ' minutes')::interval,
  now(),
  'EVERYONE'
FROM generate_series(1, 3000) AS n
ON CONFLICT DO NOTHING;

-- Engagement, skewed: a few posts do well and most do not, which is the shape
-- the log-damping in the ranker exists to handle.
INSERT INTO "PostLike" (id, "postId", "userId", "createdAt")
SELECT
  gen_random_uuid(),
  ('10000000-0000-4000-8000-' || lpad(p::text, 12, '0'))::uuid,
  ('00000000-0000-4000-8000-' || lpad(u::text, 12, '0'))::uuid,
  now() - ((p % 500) || ' minutes')::interval
FROM generate_series(1, 3000) AS p, generate_series(1, 40) AS u
WHERE u <= (p % 41)
ON CONFLICT DO NOTHING;

INSERT INTO "Comment" (id, "postId", "authorId", content, "createdAt", "updatedAt")
SELECT
  gen_random_uuid(),
  ('10000000-0000-4000-8000-' || lpad(p::text, 12, '0'))::uuid,
  ('00000000-0000-4000-8000-' || lpad(((p * 7 % 500) + 1)::text, 12, '0'))::uuid,
  'A comment on post ' || p,
  now() - ((p % 1000) || ' minutes')::interval,
  now()
FROM generate_series(1, 3000) AS p, generate_series(1, 6) AS c
WHERE c <= (p % 7);

INSERT INTO "Follow" (id, "followerId", "followingId", "createdAt")
SELECT
  gen_random_uuid(),
  ('00000000-0000-4000-8000-' || lpad(a::text, 12, '0'))::uuid,
  ('00000000-0000-4000-8000-' || lpad((((a * 13 + b) % 500) + 1)::text, 12, '0'))::uuid,
  now()
FROM generate_series(1, 500) AS a, generate_series(1, 60) AS b
WHERE (((a * 13 + b) % 500) + 1) <> a
ON CONFLICT DO NOTHING;

INSERT INTO "Hashtag" (id, tag, "createdAt")
SELECT gen_random_uuid(), 'tag' || n, now() FROM generate_series(0, 39) AS n
ON CONFLICT DO NOTHING;

INSERT INTO "PostHashtag" ("postId", "hashtagId")
SELECT
  ('10000000-0000-4000-8000-' || lpad(p::text, 12, '0'))::uuid,
  (SELECT id FROM "Hashtag" WHERE tag = 'tag' || (p % 40))
FROM generate_series(1, 3000) AS p
ON CONFLICT DO NOTHING;

-- The signals ranking reads, so the viewer query has rows to gather rather
-- than measuring the empty case.
INSERT INTO "PostView" (id, "postId", "viewerId", count, "dwellMs",
                        "createdAt", "lastViewedAt")
SELECT
  gen_random_uuid(),
  ('10000000-0000-4000-8000-' || lpad(p::text, 12, '0'))::uuid,
  ('00000000-0000-4000-8000-' || lpad((((p + 37) % 500) + 1)::text, 12, '0'))::uuid,
  1 + (p % 4),
  (p % 30) * 1000,
  now() - ((p % 400) || ' minutes')::interval,
  now() - ((p % 400) || ' minutes')::interval
FROM generate_series(1, 3000) AS p
ON CONFLICT DO NOTHING;

INSERT INTO "InterestSignal" (id, "userId", "postId", kind, "createdAt")
SELECT
  gen_random_uuid(),
  ('00000000-0000-4000-8000-' || lpad(((p % 500) + 1)::text, 12, '0'))::uuid,
  ('10000000-0000-4000-8000-' || lpad(p::text, 12, '0'))::uuid,
  CASE WHEN p % 3 = 0 THEN 'LESS'::"InterestKind" ELSE 'MORE'::"InterestKind" END,
  now()
FROM generate_series(1, 600) AS p
ON CONFLICT DO NOTHING;

ANALYZE;
