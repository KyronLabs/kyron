-- When the app was last open, and where in the day it was for the person:
-- what the "while you were away" and "your coins are back" pushes go by.
-- And whether they want those at all, and when each last went.

-- AlterTable
ALTER TABLE "User" ADD COLUMN "lastActiveAt" TIMESTAMPTZ,
ADD COLUMN "utcOffsetMinutes" INTEGER,
ADD COLUMN "reminderPushes" BOOLEAN NOT NULL DEFAULT true,
ADD COLUMN "awayPushAt" TIMESTAMPTZ,
ADD COLUMN "refillPushAt" TIMESTAMPTZ;

-- The scheduled job looks for people by when they were last here.
CREATE INDEX "User_lastActiveAt_idx" ON "User"("lastActiveAt");
