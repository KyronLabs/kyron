-- What a community owner needs beyond a name.

-- A banner, alongside the avatar the model already had.
ALTER TABLE "Community" ADD COLUMN IF NOT EXISTS "bannerUrl" TEXT;

-- Somebody removed from a community.
--
-- A row of its own rather than a flag on the membership, because removing
-- deletes the membership: without this, "you are out" and "join again" are the
-- same button and a moderator's decision lasts until the person taps it.
CREATE TABLE IF NOT EXISTS "CommunityBan" (
    "communityId" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "bannedById" UUID NOT NULL,
    "reason" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CommunityBan_pkey" PRIMARY KEY ("communityId", "userId")
);

CREATE INDEX IF NOT EXISTS "CommunityBan_userId_idx" ON "CommunityBan"("userId");

ALTER TABLE "CommunityBan"
    ADD CONSTRAINT "CommunityBan_communityId_fkey" FOREIGN KEY ("communityId")
    REFERENCES "Community"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "CommunityBan"
    ADD CONSTRAINT "CommunityBan_userId_fkey" FOREIGN KEY ("userId")
    REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "CommunityBan"
    ADD CONSTRAINT "CommunityBan_bannedById_fkey" FOREIGN KEY ("bannedById")
    REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
