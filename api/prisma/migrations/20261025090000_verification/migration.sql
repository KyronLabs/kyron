-- The verified badge: User.verifiedAt, and the requests for it with their
-- answers. See docs/VERIFICATION.md.
-- CreateEnum
CREATE TYPE "VerificationCategory" AS ENUM ('CREATOR', 'PUBLIC_FIGURE', 'JOURNALIST', 'ORGANISATION', 'OTHER');

-- CreateEnum
CREATE TYPE "VerificationStatus" AS ENUM ('PENDING', 'APPROVED', 'DENIED', 'WITHDRAWN');

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "verifiedAt" TIMESTAMPTZ;

-- CreateTable
CREATE TABLE "VerificationRequest" (
    "id" UUID NOT NULL,
    "number" SERIAL NOT NULL,
    "userId" UUID NOT NULL,
    "category" "VerificationCategory" NOT NULL,
    "about" TEXT NOT NULL,
    "links" TEXT[],
    "status" "VerificationStatus" NOT NULL DEFAULT 'PENDING',
    "reviewerId" UUID,
    "response" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "decidedAt" TIMESTAMPTZ,

    CONSTRAINT "VerificationRequest_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "VerificationRequest_number_key" ON "VerificationRequest"("number");

-- CreateIndex
CREATE INDEX "VerificationRequest_status_createdAt_idx" ON "VerificationRequest"("status", "createdAt");

-- CreateIndex
CREATE INDEX "VerificationRequest_userId_createdAt_idx" ON "VerificationRequest"("userId", "createdAt" DESC);

-- AddForeignKey
ALTER TABLE "VerificationRequest" ADD CONSTRAINT "VerificationRequest_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VerificationRequest" ADD CONSTRAINT "VerificationRequest_reviewerId_fkey" FOREIGN KEY ("reviewerId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;


-- Only the API reads it.
REVOKE ALL ON TABLE "VerificationRequest" FROM anon, authenticated;
REVOKE ALL ON SEQUENCE "VerificationRequest_number_seq" FROM anon, authenticated;
ALTER TABLE "VerificationRequest" ENABLE ROW LEVEL SECURITY;
