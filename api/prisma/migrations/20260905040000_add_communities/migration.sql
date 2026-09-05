CREATE TYPE "CommunityRole" AS ENUM ('OWNER', 'MODERATOR', 'MEMBER');

CREATE TABLE "Community" (
    "id" UUID NOT NULL,
    -- Lower-cased on the way in, like a hashtag, so /c/Design and /c/design
    -- are the same place.
    "slug" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "avatarUrl" TEXT,
    "createdById" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    -- Soft delete, so a post that pointed at it still resolves to something.
    "deletedAt" TIMESTAMPTZ,

    CONSTRAINT "Community_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "Community_slug_key" ON "Community"("slug");
CREATE INDEX "Community_slug_idx" ON "Community"("slug");
CREATE INDEX "Community_createdAt_id_idx"
    ON "Community"("createdAt" DESC, "id" DESC);

CREATE TABLE "CommunityMember" (
    "communityId" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "role" "CommunityRole" NOT NULL DEFAULT 'MEMBER',
    "joinedAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CommunityMember_pkey" PRIMARY KEY ("communityId","userId")
);

CREATE INDEX "CommunityMember_userId_idx" ON "CommunityMember"("userId");

ALTER TABLE "CommunityMember" ADD CONSTRAINT "CommunityMember_communityId_fkey"
    FOREIGN KEY ("communityId") REFERENCES "Community"("id")
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "CommunityMember" ADD CONSTRAINT "CommunityMember_userId_fkey"
    FOREIGN KEY ("userId") REFERENCES "User"("id")
    ON DELETE CASCADE ON UPDATE CASCADE;

-- A post written into a community rather than into the feed.
ALTER TABLE "Post" ADD COLUMN "communityId" UUID;
CREATE INDEX "Post_communityId_idx" ON "Post"("communityId");
ALTER TABLE "Post" ADD CONSTRAINT "Post_communityId_fkey"
    FOREIGN KEY ("communityId") REFERENCES "Community"("id")
    ON DELETE SET NULL ON UPDATE CASCADE;
