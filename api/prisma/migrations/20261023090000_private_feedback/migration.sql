-- Feedback from inside the app, kept privately for the team rather than
-- filed as an issue on the public repository. See Feedback in schema.prisma.
-- CreateEnum
CREATE TYPE "FeedbackType" AS ENUM ('BUG', 'IDEA', 'QUESTION', 'REPORT');
-- CreateTable
CREATE TABLE "Feedback" (
    "id" UUID NOT NULL,
    "number" SERIAL NOT NULL,
    "userId" UUID NOT NULL,
    "kind" "FeedbackType" NOT NULL,
    "title" TEXT NOT NULL,
    "body" TEXT NOT NULL,
    "log" TEXT,
    "appVersion" TEXT,
    "platform" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Feedback_pkey" PRIMARY KEY ("id")
);
-- CreateIndex
CREATE UNIQUE INDEX "Feedback_number_key" ON "Feedback"("number");
-- CreateIndex
CREATE INDEX "Feedback_createdAt_idx" ON "Feedback"("createdAt" DESC);
-- CreateIndex
CREATE INDEX "Feedback_userId_idx" ON "Feedback"("userId");
-- AddForeignKey
ALTER TABLE "Feedback" ADD CONSTRAINT "Feedback_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- Read and written only by the API, as the table owner, which row level
-- security does not apply to. Nobody reaches these through Supabase's own
-- REST or GraphQL endpoints: the grants are revoked and RLS is on with no
-- policies, as on every other table. MessageKeyShare and MediaJob were
-- created without it; neither carried a grant to anon or authenticated, so
-- nothing was reachable, but the second lock belongs on them too.
REVOKE ALL ON TABLE "Feedback" FROM anon, authenticated;
ALTER TABLE "Feedback" ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE "MessageKeyShare" FROM anon, authenticated;
ALTER TABLE "MessageKeyShare" ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE "MediaJob" FROM anon, authenticated;
ALTER TABLE "MediaJob" ENABLE ROW LEVEL SECURITY;
