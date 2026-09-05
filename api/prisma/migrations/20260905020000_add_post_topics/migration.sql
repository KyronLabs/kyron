-- A topic the author filed a post under.
--
-- Separate from post hashtags: a hashtag is whatever somebody typed, a topic
-- is one of a fixed set chosen deliberately, and it is the same set people
-- pick from when they say what they are interested in.
CREATE TABLE "PostTopic" (
    "postId" UUID NOT NULL,
    "interestId" UUID NOT NULL,

    CONSTRAINT "PostTopic_pkey" PRIMARY KEY ("postId","interestId")
);

CREATE INDEX "PostTopic_interestId_idx" ON "PostTopic"("interestId");

ALTER TABLE "PostTopic" ADD CONSTRAINT "PostTopic_postId_fkey"
    FOREIGN KEY ("postId") REFERENCES "Post"("id")
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "PostTopic" ADD CONSTRAINT "PostTopic_interestId_fkey"
    FOREIGN KEY ("interestId") REFERENCES "Interest"("id")
    ON DELETE CASCADE ON UPDATE CASCADE;
