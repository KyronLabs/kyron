-- Create enum types if they don't exist
DO main BEGIN
  CREATE TYPE \"AccountStatus\" AS ENUM ('ACTIVE', 'SUSPENDED', 'DELETED');
EXCEPTION
  WHEN duplicate_object THEN null;
END main;

DO main BEGIN
  CREATE TYPE \"EmailStatus\" AS ENUM ('PENDING', 'VERIFIED', 'BOUNCED');
EXCEPTION
  WHEN duplicate_object THEN null;
END main;

-- Add all missing columns safely
ALTER TABLE \"User\" 
  ADD COLUMN IF NOT EXISTS \"status\" \"AccountStatus\" NOT NULL DEFAULT 'ACTIVE',
  ADD COLUMN IF NOT EXISTS \"emailStatus\" \"EmailStatus\" NOT NULL DEFAULT 'PENDING',
  ADD COLUMN IF NOT EXISTS \"failedLoginAttempts\" INTEGER NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS \"lockedUntil\" TIMESTAMP(3),
  ADD COLUMN IF NOT EXISTS \"lastLoginAt\" TIMESTAMP(3),
  ADD COLUMN IF NOT EXISTS \"deletedAt\" TIMESTAMP(3);

-- Create indexes
CREATE INDEX IF NOT EXISTS \"User_status_idx\" ON \"User\"(\"status\");
CREATE INDEX IF NOT EXISTS \"User_emailStatus_idx\" ON \"User\"(\"emailStatus\");
