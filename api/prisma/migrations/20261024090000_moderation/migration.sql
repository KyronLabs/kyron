-- Enforcement and appeals: what the team decided about an account, the
-- account's appeal against it, and the addresses of banned accounts kept as
-- hashes. See ModerationAction, Appeal and BannedIdentity in schema.prisma,
-- and docs/MODERATION.md.
-- CreateEnum
CREATE TYPE "ModerationKind" AS ENUM ('REMOVE', 'WARN', 'SUSPEND', 'BAN');

-- CreateEnum
CREATE TYPE "AppealStatus" AS ENUM ('OPEN', 'UPHELD', 'OVERTURNED');

-- AlterEnum
ALTER TYPE "AccountStatus" ADD VALUE 'BANNED';

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "suspendedUntil" TIMESTAMPTZ;

-- AlterTable
ALTER TABLE "Report" ADD COLUMN     "actionId" UUID,
ADD COLUMN     "resolvedAt" TIMESTAMPTZ,
ADD COLUMN     "resolvedById" UUID;

-- CreateTable
CREATE TABLE "ModerationAction" (
    "id" UUID NOT NULL,
    "number" SERIAL NOT NULL,
    "subjectId" UUID,
    "moderatorId" UUID,
    "kind" "ModerationKind" NOT NULL,
    "rule" "ReportReason" NOT NULL,
    "message" TEXT NOT NULL,
    "note" TEXT,
    "target" "ReportTarget",
    "targetId" UUID,
    "removedContent" BOOLEAN NOT NULL DEFAULT false,
    "snapshot" TEXT,
    "endsAt" TIMESTAMPTZ,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "seenAt" TIMESTAMPTZ,
    "reversedAt" TIMESTAMPTZ,
    "reversedById" UUID,
    "reversal" TEXT,

    CONSTRAINT "ModerationAction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Appeal" (
    "id" UUID NOT NULL,
    "actionId" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "statement" TEXT NOT NULL,
    "status" "AppealStatus" NOT NULL DEFAULT 'OPEN',
    "reviewerId" UUID,
    "response" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "decidedAt" TIMESTAMPTZ,
    "seenAt" TIMESTAMPTZ,

    CONSTRAINT "Appeal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BannedIdentity" (
    "emailHash" TEXT NOT NULL,
    "actionId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "BannedIdentity_pkey" PRIMARY KEY ("emailHash")
);

-- CreateIndex
CREATE UNIQUE INDEX "ModerationAction_number_key" ON "ModerationAction"("number");

-- CreateIndex
CREATE INDEX "ModerationAction_subjectId_createdAt_idx" ON "ModerationAction"("subjectId", "createdAt" DESC);

-- CreateIndex
CREATE INDEX "ModerationAction_target_targetId_idx" ON "ModerationAction"("target", "targetId");

-- CreateIndex
CREATE UNIQUE INDEX "Appeal_actionId_key" ON "Appeal"("actionId");

-- CreateIndex
CREATE INDEX "Appeal_status_createdAt_idx" ON "Appeal"("status", "createdAt");

-- CreateIndex
CREATE INDEX "BannedIdentity_actionId_idx" ON "BannedIdentity"("actionId");

-- CreateIndex
CREATE INDEX "Report_reporterId_createdAt_idx" ON "Report"("reporterId", "createdAt" DESC);

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_resolvedById_fkey" FOREIGN KEY ("resolvedById") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_actionId_fkey" FOREIGN KEY ("actionId") REFERENCES "ModerationAction"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ModerationAction" ADD CONSTRAINT "ModerationAction_subjectId_fkey" FOREIGN KEY ("subjectId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ModerationAction" ADD CONSTRAINT "ModerationAction_moderatorId_fkey" FOREIGN KEY ("moderatorId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ModerationAction" ADD CONSTRAINT "ModerationAction_reversedById_fkey" FOREIGN KEY ("reversedById") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appeal" ADD CONSTRAINT "Appeal_actionId_fkey" FOREIGN KEY ("actionId") REFERENCES "ModerationAction"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appeal" ADD CONSTRAINT "Appeal_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appeal" ADD CONSTRAINT "Appeal_reviewerId_fkey" FOREIGN KEY ("reviewerId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;


-- Only the API reads these. Supabase hands every table in public to its anon
-- and authenticated roles unless told otherwise, and a ban record or an
-- appeal is nobody else's business.
REVOKE ALL ON TABLE "ModerationAction" FROM anon, authenticated;
REVOKE ALL ON TABLE "Appeal" FROM anon, authenticated;
REVOKE ALL ON TABLE "BannedIdentity" FROM anon, authenticated;
REVOKE ALL ON SEQUENCE "ModerationAction_number_seq" FROM anon, authenticated;
ALTER TABLE "ModerationAction" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Appeal" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "BannedIdentity" ENABLE ROW LEVEL SECURITY;
