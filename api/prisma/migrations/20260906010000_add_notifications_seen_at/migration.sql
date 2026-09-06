-- The last time this account opened its notifications.
--
-- Notifications are read straight from the likes, comments, reposts and
-- follows that caused them, so there is no row to mark read; anything newer
-- than this is unread, and opening the screen moves it forward.
ALTER TABLE "User" ADD COLUMN IF NOT EXISTS "notificationsSeenAt" TIMESTAMPTZ;
