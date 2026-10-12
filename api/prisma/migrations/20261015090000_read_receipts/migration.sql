-- Read receipts, as a setting.
--
-- On by default, which is what everyone has had so far. Off stops the people
-- an account writes to seeing "Seen" under their messages to it -- and, the
-- way every messenger with this switch works, stops it seeing theirs.

ALTER TABLE "User" ADD COLUMN "readReceipts" BOOLEAN NOT NULL DEFAULT true;
