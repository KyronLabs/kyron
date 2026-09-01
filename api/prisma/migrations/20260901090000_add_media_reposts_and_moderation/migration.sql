-- CreateEnum
CREATE TYPE "MediaKind" AS ENUM ('IMAGE', 'VIDEO', 'GIF');

-- CreateEnum
CREATE TYPE "ReplyPolicy" AS ENUM ('EVERYONE', 'FOLLOWERS', 'MENTIONED', 'NOBODY');

-- CreateEnum
CREATE TYPE "MuteKind" AS ENUM ('USER', 'WORD', 'THREAD');

-- CreateEnum
CREATE TYPE "InterestKind" AS ENUM ('MORE', 'LESS');

-- CreateEnum
CREATE TYPE "ReportTarget" AS ENUM ('POST', 'COMMENT', 'USER');

-- CreateEnum
CREATE TYPE "ReportReason" AS ENUM ('SPAM', 'HARASSMENT', 'HATE', 'VIOLENCE', 'SELF_HARM', 'SEXUAL_CONTENT', 'CHILD_SAFETY', 'MISINFORMATION', 'IMPERSONATION', 'INTELLECTUAL_PROPERTY', 'ILLEGAL_GOODS', 'SOMETHING_ELSE');

-- CreateEnum
CREATE TYPE "ReportStatus" AS ENUM ('RECEIVED', 'REVIEWING', 'ACTIONED', 'DISMISSED');

-- AlterTable
ALTER TABLE "Post" ADD COLUMN "replyPolicy" "ReplyPolicy" NOT NULL DEFAULT 'EVERYONE',
                  ADD COLUMN "quotedPostId" UUID;

-- CreateTable
CREATE TABLE "Media" (
    "id" UUID NOT NULL,
    "postId" UUID,
    "commentId" UUID,
    "kind" "MediaKind" NOT NULL DEFAULT 'IMAGE',
    "url" TEXT NOT NULL,
    "width" INTEGER,
    "height" INTEGER,
    "alt" TEXT,
    "position" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Media_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Repost" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "postId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Repost_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Hashtag" (
    "id" UUID NOT NULL,
    "tag" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Hashtag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PostHashtag" (
    "postId" UUID NOT NULL,
    "hashtagId" UUID NOT NULL,

    CONSTRAINT "PostHashtag_pkey" PRIMARY KEY ("postId","hashtagId")
);

-- CreateTable
CREATE TABLE "Block" (
    "id" UUID NOT NULL,
    "blockerId" UUID NOT NULL,
    "blockedId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Block_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Mute" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "kind" "MuteKind" NOT NULL,
    "targetUserId" UUID,
    "targetPostId" UUID,
    "phrase" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Mute_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HiddenPost" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "postId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "HiddenPost_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InterestSignal" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "postId" UUID NOT NULL,
    "kind" "InterestKind" NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "InterestSignal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Report" (
    "id" UUID NOT NULL,
    "reporterId" UUID NOT NULL,
    "target" "ReportTarget" NOT NULL,
    "targetId" UUID NOT NULL,
    "reason" "ReportReason" NOT NULL,
    "detail" TEXT,
    "status" "ReportStatus" NOT NULL DEFAULT 'RECEIVED',
    "snapshot" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "Report_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Media_postId_position_idx" ON "Media"("postId", "position");
CREATE INDEX "Media_commentId_position_idx" ON "Media"("commentId", "position");
CREATE UNIQUE INDEX "Repost_userId_postId_key" ON "Repost"("userId", "postId");
CREATE INDEX "Repost_postId_idx" ON "Repost"("postId");
CREATE INDEX "Repost_userId_createdAt_idx" ON "Repost"("userId", "createdAt" DESC);
CREATE UNIQUE INDEX "Hashtag_tag_key" ON "Hashtag"("tag");
CREATE INDEX "PostHashtag_hashtagId_idx" ON "PostHashtag"("hashtagId");
CREATE UNIQUE INDEX "Block_blockerId_blockedId_key" ON "Block"("blockerId", "blockedId");
CREATE INDEX "Block_blockedId_idx" ON "Block"("blockedId");
CREATE UNIQUE INDEX "Mute_userId_kind_targetUserId_targetPostId_phrase_key" ON "Mute"("userId", "kind", "targetUserId", "targetPostId", "phrase");
CREATE INDEX "Mute_userId_kind_idx" ON "Mute"("userId", "kind");
CREATE UNIQUE INDEX "HiddenPost_userId_postId_key" ON "HiddenPost"("userId", "postId");
CREATE INDEX "HiddenPost_userId_idx" ON "HiddenPost"("userId");
CREATE UNIQUE INDEX "InterestSignal_userId_postId_key" ON "InterestSignal"("userId", "postId");
CREATE INDEX "InterestSignal_userId_kind_idx" ON "InterestSignal"("userId", "kind");
CREATE UNIQUE INDEX "Report_reporterId_target_targetId_key" ON "Report"("reporterId", "target", "targetId");
CREATE INDEX "Report_target_targetId_idx" ON "Report"("target", "targetId");
CREATE INDEX "Report_status_createdAt_idx" ON "Report"("status", "createdAt");

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_quotedPostId_fkey" FOREIGN KEY ("quotedPostId") REFERENCES "Post"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "Media" ADD CONSTRAINT "Media_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Media" ADD CONSTRAINT "Media_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES "Comment"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Repost" ADD CONSTRAINT "Repost_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Repost" ADD CONSTRAINT "Repost_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "PostHashtag" ADD CONSTRAINT "PostHashtag_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "PostHashtag" ADD CONSTRAINT "PostHashtag_hashtagId_fkey" FOREIGN KEY ("hashtagId") REFERENCES "Hashtag"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Block" ADD CONSTRAINT "Block_blockerId_fkey" FOREIGN KEY ("blockerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Block" ADD CONSTRAINT "Block_blockedId_fkey" FOREIGN KEY ("blockedId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Mute" ADD CONSTRAINT "Mute_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Mute" ADD CONSTRAINT "Mute_targetUserId_fkey" FOREIGN KEY ("targetUserId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Mute" ADD CONSTRAINT "Mute_targetPostId_fkey" FOREIGN KEY ("targetPostId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "HiddenPost" ADD CONSTRAINT "HiddenPost_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "HiddenPost" ADD CONSTRAINT "HiddenPost_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "InterestSignal" ADD CONSTRAINT "InterestSignal_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "InterestSignal" ADD CONSTRAINT "InterestSignal_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Report" ADD CONSTRAINT "Report_reporterId_fkey" FOREIGN KEY ("reporterId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
