-- Re-encoding a clip, moved off the upload request.
--
-- The upload used to run ffmpeg before it answered, so somebody posting a 4K
-- clip watched a spinner for the length of the encode. It now stores the
-- original, answers, and leaves a row here saying better bytes are owed.
--
-- A table rather than an in-memory queue because a deploy mid-encode would
-- otherwise drop the work silently and the clip would keep its upload bitrate
-- forever, with nothing anywhere recording that it had happened.

CREATE TYPE "MediaJobStatus" AS ENUM ('PENDING', 'RUNNING', 'DONE', 'FAILED', 'SKIPPED');

CREATE TABLE "MediaJob" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    -- Where the original was stored, and where the re-encode is written back.
    -- Unique: one clip is one job, and an upload retried to the same path must
    -- not queue the work twice.
    "path" TEXT NOT NULL,
    "userId" UUID NOT NULL,
    "status" "MediaJobStatus" NOT NULL DEFAULT 'PENDING',
    "attempts" INTEGER NOT NULL DEFAULT 0,
    "lastError" TEXT,
    -- Stale means the worker holding it died; that is how the job is found
    -- again rather than sitting in RUNNING forever.
    "claimedAt" TIMESTAMPTZ,
    "bytesIn" INTEGER NOT NULL,
    "bytesOut" INTEGER,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MediaJob_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "MediaJob_path_key" ON "MediaJob"("path");

-- The claim query orders by createdAt within a status, so this is the index it
-- reads. Without it every claim is a sequential scan of every job ever run.
CREATE INDEX "MediaJob_status_createdAt_idx" ON "MediaJob"("status", "createdAt");
