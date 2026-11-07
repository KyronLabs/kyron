-- A post's words can be changed for a short while after it goes out, and the
-- post says so: editedAt is when they last were.

-- AlterTable
ALTER TABLE "Post" ADD COLUMN "editedAt" TIMESTAMPTZ;
