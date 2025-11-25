------------------------------------------------------------
-- ENUMS
------------------------------------------------------------

CREATE TYPE "UserRole" AS ENUM ('USER', 'ADMIN', 'MODERATOR');
CREATE TYPE "EmailStatus" AS ENUM ('PENDING', 'VERIFIED', 'BOUNCED');
CREATE TYPE "AccountStatus" AS ENUM ('ACTIVE', 'SUSPENDED', 'DELETED');

------------------------------------------------------------
-- USER TABLE (MAIN)
------------------------------------------------------------

CREATE TABLE "User" (
    "id" TEXT PRIMARY KEY,
    "email" TEXT NOT NULL UNIQUE,
    "username" TEXT UNIQUE,
    "password" TEXT NOT NULL,
    "name" TEXT,
    "role" "UserRole" NOT NULL DEFAULT 'USER',
    "status" "AccountStatus" NOT NULL DEFAULT 'ACTIVE',
    "emailStatus" "EmailStatus" NOT NULL DEFAULT 'PENDING',
    "emailVerifiedAt" TIMESTAMP,
    "failedLoginAttempts" INTEGER NOT NULL DEFAULT 0,
    "lockedUntil" TIMESTAMP,
    "lastLoginAt" TIMESTAMP,
    "deletedAt" TIMESTAMP,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

------------------------------------------------------------
-- USER PROFILE
------------------------------------------------------------

CREATE TABLE "UserProfile" (
    "id" TEXT PRIMARY KEY,
    "userId" TEXT UNIQUE NOT NULL,
    "avatarUrl" TEXT,
    "bio" TEXT,
    "location" TEXT,
    "website" TEXT,
    "dateOfBirth" TIMESTAMP,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

------------------------------------------------------------
-- EMAIL VERIFICATION
------------------------------------------------------------

CREATE TABLE "EmailVerification" (
    "id" TEXT PRIMARY KEY,
    "userId" TEXT NOT NULL UNIQUE,
    "code" TEXT NOT NULL,
    "expiresAt" TIMESTAMP NOT NULL,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "attempts" INTEGER NOT NULL DEFAULT 0
);

------------------------------------------------------------
-- USER SESSIONS
------------------------------------------------------------

CREATE TABLE "UserSession" (
    "id" TEXT PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "token" TEXT NOT NULL UNIQUE,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP NOT NULL,
    "lastActivity" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

------------------------------------------------------------
-- REFRESH TOKENS
------------------------------------------------------------

CREATE TABLE "RefreshToken" (
    "id" TEXT PRIMARY KEY,
    "token" TEXT NOT NULL UNIQUE,
    "userId" TEXT NOT NULL,
    "expiresAt" TIMESTAMP NOT NULL,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "sessionId" TEXT
);

------------------------------------------------------------
-- PASSWORD RESET
------------------------------------------------------------

CREATE TABLE "PasswordReset" (
    "id" TEXT PRIMARY KEY,
    "userId" TEXT NOT NULL UNIQUE,
    "token" TEXT NOT NULL UNIQUE,
    "expiresAt" TIMESTAMP NOT NULL,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "usedAt" TIMESTAMP
);

------------------------------------------------------------
-- AUDIT LOG
------------------------------------------------------------

CREATE TABLE "AuditLog" (
    "id" TEXT PRIMARY KEY,
    "userId" TEXT,
    "action" TEXT NOT NULL,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "details" JSONB,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

------------------------------------------------------------
-- SYSTEM MODULES
------------------------------------------------------------

CREATE TABLE "SystemModule" (
    "id" TEXT PRIMARY KEY,
    "key" TEXT NOT NULL UNIQUE,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "enabled" BOOLEAN NOT NULL DEFAULT FALSE,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

------------------------------------------------------------
-- APP SETTINGS
------------------------------------------------------------

CREATE TABLE "AppSetting" (
    "id" TEXT PRIMARY KEY,
    "key" TEXT NOT NULL UNIQUE,
    "value" TEXT NOT NULL,
    "type" TEXT NOT NULL DEFAULT 'string',
    "description" TEXT,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

------------------------------------------------------------
-- FOREIGN KEYS
------------------------------------------------------------

ALTER TABLE "UserProfile"
ADD CONSTRAINT "UserProfile_userId_fkey"
FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE;

ALTER TABLE "EmailVerification"
ADD CONSTRAINT "EmailVerification_userId_fkey"
FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE;

ALTER TABLE "RefreshToken"
ADD CONSTRAINT "RefreshToken_userId_fkey"
FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE;

ALTER TABLE "PasswordReset"
ADD CONSTRAINT "PasswordReset_userId_fkey"
FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE;

ALTER TABLE "UserSession"
ADD CONSTRAINT "UserSession_userId_fkey"
FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE;

ALTER TABLE "AuditLog"
ADD CONSTRAINT "AuditLog_userId_fkey"
FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL;

------------------------------------------------------------
-- INDEXES
------------------------------------------------------------

CREATE INDEX "User_status_idx" ON "User"("status");
CREATE INDEX "User_emailStatus_idx" ON "User"("emailStatus");
CREATE INDEX "User_username_idx" ON "User"("username");
CREATE INDEX "RefreshToken_userId_idx" ON "RefreshToken"("userId");
CREATE INDEX "UserSession_userId_idx" ON "UserSession"("userId");
CREATE INDEX "AuditLog_userId_idx" ON "AuditLog"("userId");
CREATE INDEX "AuditLog_action_idx" ON "AuditLog"("action");

