-- When each member last opened a community, so the Communities list can say
-- what is new in it.
ALTER TABLE "CommunityMember" ADD COLUMN "lastReadAt" TIMESTAMPTZ;

-- Whether a community's posts also appear in Home for this account.
ALTER TABLE "User" ADD COLUMN "communityPostsInHome" BOOLEAN NOT NULL DEFAULT true;

-- The newest post per community, and the count after a member's mark.
CREATE INDEX "Post_communityId_createdAt_idx" ON "Post"("communityId", "createdAt" DESC);
