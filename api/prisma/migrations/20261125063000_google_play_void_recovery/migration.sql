-- Server-only, restart-safe provider recovery cursor. No user foreign keys.
CREATE TABLE "GooglePlayRecoveryCheckpoint" (
  "packageName" VARCHAR(255) NOT NULL,
  "revision" INTEGER NOT NULL DEFAULT 0,
  "coveredThrough" TIMESTAMPTZ,
  "windowStart" TIMESTAMPTZ,
  "windowEnd" TIMESTAMPTZ,
  "encryptedPageToken" TEXT,
  "pagesInWindow" INTEGER NOT NULL DEFAULT 0,
  "lastAttemptAt" TIMESTAMPTZ,
  "lastSuccessAt" TIMESTAMPTZ,
  "lastError" VARCHAR(80),
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatedAt" TIMESTAMPTZ NOT NULL,
  CONSTRAINT "GooglePlayRecoveryCheckpoint_pkey" PRIMARY KEY ("packageName"),
  CONSTRAINT "GooglePlayRecoveryCheckpoint_revision_nonnegative" CHECK ("revision" >= 0),
  CONSTRAINT "GooglePlayRecoveryCheckpoint_pages_nonnegative" CHECK ("pagesInWindow" >= 0),
  CONSTRAINT "GooglePlayRecoveryCheckpoint_window_valid" CHECK (
    ("windowStart" IS NULL AND "windowEnd" IS NULL AND
      "encryptedPageToken" IS NULL AND "pagesInWindow" = 0)
    OR
    ("windowStart" IS NOT NULL AND "windowEnd" IS NOT NULL AND
      "windowStart" < "windowEnd")
  )
);
ALTER TABLE "GooglePlayRecoveryCheckpoint" ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE "GooglePlayRecoveryCheckpoint"
  FROM PUBLIC, anon, authenticated, service_role;
