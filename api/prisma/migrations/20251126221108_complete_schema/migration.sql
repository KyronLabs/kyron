-- ============================================================
-- KYRON COMPLETE SCHEMA MIGRATION
-- ============================================================

-- ENUMS -------------------------------------------------------
CREATE TYPE "UserRole" AS ENUM ('USER', 'ADMIN', 'MODERATOR');
CREATE TYPE "EmailStatus" AS ENUM ('PENDING', 'VERIFIED', 'BOUNCED');
CREATE TYPE "AccountStatus" AS ENUM ('ACTIVE', 'SUSPENDED', 'DELETED');

-- USER --------------------------------------------------------
CREATE TABLE "User" (
  "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "email" TEXT UNIQUE NOT NULL,
  "username" TEXT UNIQUE,
  "password" TEXT NOT NULL,
  "name" TEXT,
  "role" "UserRole" NOT NULL DEFAULT 'USER',
  "status" "AccountStatus" NOT NULL DEFAULT 'ACTIVE',

  "emailStatus" "EmailStatus" NOT NULL DEFAULT 'PENDING',
  "emailVerifiedAt" TIMESTAMPTZ,

  "failedLoginAttempts" INT NOT NULL DEFAULT 0,
  "lockedUntil" TIMESTAMPTZ,
  "lastLoginAt" TIMESTAMPTZ,

  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updatedAt" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "deletedAt" TIMESTAMPTZ
);

CREATE INDEX "User_email_idx" ON "User" ("email");
CREATE INDEX "User_username_idx" ON "User" ("username");
CREATE INDEX "User_status_idx" ON "User" ("status");

-- USER PROFILE ------------------------------------------------
CREATE TABLE "UserProfile" (
  "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "userId" UUID UNIQUE NOT NULL,
  "avatarUrl" TEXT,
  "coverUrl" TEXT,
  "bio" TEXT,
  "location" TEXT,
  "website" TEXT,
  "dateOfBirth" DATE,

  "createdAt" TIMESTAMPTZ DEFAULT NOW(),
  "updatedAt" TIMESTAMPTZ DEFAULT NOW(),

  CONSTRAINT "UserProfile_userId_fkey"
    FOREIGN KEY ("userId") REFERENCES "User" ("id")
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "UserProfile_userId_idx" ON "UserProfile" ("userId");

-- EMAIL VERIFICATION -----------------------------------------
CREATE TABLE "EmailVerification" (
  "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "userId" UUID UNIQUE NOT NULL,
  "code" TEXT NOT NULL,
  "expiresAt" TIMESTAMPTZ NOT NULL,
  "createdAt" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "attempts" INT NOT NULL DEFAULT 0,

  CONSTRAINT "EmailVerification_userId_fkey"
    FOREIGN KEY ("userId") REFERENCES "User" ("id")
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- USER SESSIONS ----------------------------------------------
CREATE TABLE "UserSession" (
  "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "userId" UUID NOT NULL,
  "token" TEXT UNIQUE NOT NULL,
  "ipAddress" TEXT,
  "userAgent" TEXT,
  "createdAt" TIMESTAMPTZ DEFAULT NOW(),
  "expiresAt" TIMESTAMPTZ NOT NULL,
  "lastActivity" TIMESTAMPTZ DEFAULT NOW(),

  CONSTRAINT "UserSession_userId_fkey"
    FOREIGN KEY ("userId") REFERENCES "User" ("id")
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "UserSession_user_idx"
  ON "UserSession" ("userId", "expiresAt");

-- REFRESH TOKENS ---------------------------------------------
CREATE TABLE "RefreshToken" (
  "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "token" TEXT UNIQUE NOT NULL,
  "userId" UUID NOT NULL,
  "expiresAt" TIMESTAMPTZ NOT NULL,
  "createdAt" TIMESTAMPTZ DEFAULT NOW(),
  "sessionId" UUID,

  CONSTRAINT "RefreshToken_userId_fkey"
    FOREIGN KEY ("userId") REFERENCES "User" ("id")
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "Refresh_user_idx"
  ON "RefreshToken" ("userId", "expiresAt");

-- PASSWORD RESET ---------------------------------------------
CREATE TABLE "PasswordReset" (
  "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "userId" UUID UNIQUE NOT NULL,
  "token" TEXT UNIQUE NOT NULL,
  "expiresAt" TIMESTAMPTZ NOT NULL,
  "createdAt" TIMESTAMPTZ DEFAULT NOW(),
  "usedAt" TIMESTAMPTZ,

  CONSTRAINT "PasswordReset_userId_fkey"
    FOREIGN KEY ("userId") REFERENCES "User" ("id")
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- AUDIT LOG ---------------------------------------------------
CREATE TABLE "AuditLog" (
  "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "userId" UUID,
  "action" TEXT NOT NULL,
  "ipAddress" TEXT,
  "userAgent" TEXT,
  "details" JSONB,
  "createdAt" TIMESTAMPTZ DEFAULT NOW(),

  CONSTRAINT "AuditLog_userId_fkey"
    FOREIGN KEY ("userId") REFERENCES "User" ("id")
    ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE INDEX "AuditLog_user_idx" ON "AuditLog" ("userId", "createdAt");
CREATE INDEX "AuditLog_action_idx" ON "AuditLog" ("action");

-- INTERESTS ---------------------------------------------------
CREATE TABLE "Interest" (
  "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "slug" TEXT UNIQUE NOT NULL,
  "name" TEXT NOT NULL
);

CREATE INDEX "Interest_slug_idx" ON "Interest" ("slug");

CREATE TABLE "UserInterest" (
  "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "userId" UUID NOT NULL,
  "interestId" UUID NOT NULL,

  CONSTRAINT "UserInterest_user_fkey"
    FOREIGN KEY ("userId") REFERENCES "User" ("id")
    ON DELETE CASCADE ON UPDATE CASCADE,

  CONSTRAINT "UserInterest_interest_fkey"
    FOREIGN KEY ("interestId") REFERENCES "Interest" ("id")
    ON DELETE CASCADE ON UPDATE CASCADE,

  UNIQUE ("userId", "interestId")
);

-- FOLLOW -------------------------------------------------------
CREATE TABLE "Follow" (
  "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "followerId" UUID NOT NULL,
  "followingId" UUID NOT NULL,
  "createdAt" TIMESTAMPTZ DEFAULT NOW(),

  CONSTRAINT "Follow_follower_fkey"
    FOREIGN KEY ("followerId") REFERENCES "User" ("id")
    ON DELETE CASCADE ON UPDATE CASCADE,

  CONSTRAINT "Follow_following_fkey"
    FOREIGN KEY ("followingId") REFERENCES "User" ("id")
    ON DELETE CASCADE ON UPDATE CASCADE,

  UNIQUE ("followerId", "followingId")
);

-- SYSTEM MODULES ---------------------------------------------
CREATE TABLE "SystemModule" (
  "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "key" TEXT UNIQUE NOT NULL,
  "name" TEXT NOT NULL,
  "description" TEXT,
  "enabled" BOOLEAN DEFAULT false,
  "createdAt" TIMESTAMPTZ DEFAULT NOW(),
  "updatedAt" TIMESTAMPTZ DEFAULT NOW()
);

-- APP SETTINGS ------------------------------------------------
CREATE TABLE "AppSetting" (
  "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "key" TEXT UNIQUE NOT NULL,
  "value" TEXT NOT NULL,
  "type" TEXT DEFAULT 'string',
  "description" TEXT,
  "createdAt" TIMESTAMPTZ DEFAULT NOW(),
  "updatedAt" TIMESTAMPTZ DEFAULT NOW()
);
