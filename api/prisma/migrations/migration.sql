-- AlterTable
ALTER TABLE "User" ADD COLUMN "username" TEXT;

-- Create unique index for username (allowing nulls)
CREATE UNIQUE INDEX "User_username_key" ON "User"("username") WHERE "username" IS NOT NULL;
