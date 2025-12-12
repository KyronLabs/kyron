/*
  Warnings:

  - You are about to drop the column `createdAt` on the `UserProfile` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `UserProfile` table. All the data in the column will be lost.
  - Made the column `type` on table `AppSetting` required. This step will fail if there are existing NULL values in that column.
  - Made the column `createdAt` on table `AppSetting` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updatedAt` on table `AppSetting` required. This step will fail if there are existing NULL values in that column.
  - Made the column `createdAt` on table `AuditLog` required. This step will fail if there are existing NULL values in that column.
  - Made the column `createdAt` on table `Follow` required. This step will fail if there are existing NULL values in that column.
  - Made the column `createdAt` on table `PasswordReset` required. This step will fail if there are existing NULL values in that column.
  - Made the column `createdAt` on table `RefreshToken` required. This step will fail if there are existing NULL values in that column.
  - Made the column `enabled` on table `SystemModule` required. This step will fail if there are existing NULL values in that column.
  - Made the column `createdAt` on table `SystemModule` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updatedAt` on table `SystemModule` required. This step will fail if there are existing NULL values in that column.
  - Made the column `createdAt` on table `UserSession` required. This step will fail if there are existing NULL values in that column.
  - Made the column `lastActivity` on table `UserSession` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "AppSetting" ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "type" SET NOT NULL,
ALTER COLUMN "createdAt" SET NOT NULL,
ALTER COLUMN "updatedAt" SET NOT NULL,
ALTER COLUMN "updatedAt" DROP DEFAULT;

-- AlterTable
ALTER TABLE "AuditLog" ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "createdAt" SET NOT NULL;

-- AlterTable
ALTER TABLE "EmailVerification" ALTER COLUMN "id" DROP DEFAULT;

-- AlterTable
ALTER TABLE "Follow" ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "createdAt" SET NOT NULL;

-- AlterTable
ALTER TABLE "Interest" ALTER COLUMN "id" DROP DEFAULT;

-- AlterTable
ALTER TABLE "PasswordReset" ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "createdAt" SET NOT NULL;

-- AlterTable
ALTER TABLE "RefreshToken" ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "createdAt" SET NOT NULL,
ALTER COLUMN "sessionId" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "SystemModule" ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "enabled" SET NOT NULL,
ALTER COLUMN "createdAt" SET NOT NULL,
ALTER COLUMN "updatedAt" SET NOT NULL,
ALTER COLUMN "updatedAt" DROP DEFAULT;

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "emailVerifiedAt" SET DATA TYPE TIMESTAMP(3),
ALTER COLUMN "lockedUntil" SET DATA TYPE TIMESTAMP(3),
ALTER COLUMN "lastLoginAt" SET DATA TYPE TIMESTAMP(3),
ALTER COLUMN "updatedAt" DROP DEFAULT;

-- AlterTable
ALTER TABLE "UserInterest" ALTER COLUMN "id" DROP DEFAULT;

-- AlterTable
ALTER TABLE "UserProfile" DROP COLUMN "createdAt",
DROP COLUMN "updatedAt",
ALTER COLUMN "id" DROP DEFAULT;

-- AlterTable
ALTER TABLE "UserSession" ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "createdAt" SET NOT NULL,
ALTER COLUMN "lastActivity" SET NOT NULL;

-- CreateIndex
CREATE INDEX "Follow_followerId_idx" ON "Follow"("followerId");

-- CreateIndex
CREATE INDEX "Follow_followingId_idx" ON "Follow"("followingId");

-- CreateIndex
CREATE INDEX "UserInterest_userId_idx" ON "UserInterest"("userId");

-- CreateIndex
CREATE INDEX "UserInterest_interestId_idx" ON "UserInterest"("interestId");

-- RenameForeignKey
ALTER TABLE "Follow" RENAME CONSTRAINT "Follow_follower_fkey" TO "Follow_followerId_fkey";

-- RenameForeignKey
ALTER TABLE "Follow" RENAME CONSTRAINT "Follow_following_fkey" TO "Follow_followingId_fkey";

-- RenameForeignKey
ALTER TABLE "UserInterest" RENAME CONSTRAINT "UserInterest_interest_fkey" TO "UserInterest_interestId_fkey";

-- RenameForeignKey
ALTER TABLE "UserInterest" RENAME CONSTRAINT "UserInterest_user_fkey" TO "UserInterest_userId_fkey";

-- RenameIndex
ALTER INDEX "AuditLog_user_idx" RENAME TO "AuditLog_userId_createdAt_idx";

-- RenameIndex
ALTER INDEX "Refresh_user_idx" RENAME TO "RefreshToken_userId_expiresAt_idx";

-- RenameIndex
ALTER INDEX "UserSession_user_idx" RENAME TO "UserSession_userId_expiresAt_idx";
