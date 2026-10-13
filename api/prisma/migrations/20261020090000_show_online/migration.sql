-- Whether the people an account talks to see it as online. On by default,
-- like read receipts; off is mutual (see MessagesService / PresenceService).
ALTER TABLE "User" ADD COLUMN "showOnline" BOOLEAN NOT NULL DEFAULT true;
