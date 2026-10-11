-- Reactions to direct messages.
--
-- One per person per message: the primary key is the pair, so reacting
-- again replaces what was there rather than stacking a second.
--
-- The emoji is stored readable. The message it is attached to is sealed on
-- the sender's phone and this server cannot read it; the reaction is not.
-- That was decided, not overlooked -- it is the same trade attachments make
-- today, and docs/E2EE.md lists both under what is not sealed.
--
-- Additive only: a new table, nothing existing touched.

CREATE TABLE "MessageReaction" (
    "messageId" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "emoji" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "MessageReaction_pkey" PRIMARY KEY ("messageId","userId")
);

-- For "everything this account reacted to", which deleting an account walks.
CREATE INDEX "MessageReaction_userId_idx" ON "MessageReaction"("userId");

-- Gone with the message or the account, never left pointing at nothing.
ALTER TABLE "MessageReaction" ADD CONSTRAINT "MessageReaction_messageId_fkey"
  FOREIGN KEY ("messageId") REFERENCES "Message"("id")
  ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "MessageReaction" ADD CONSTRAINT "MessageReaction_userId_fkey"
  FOREIGN KEY ("userId") REFERENCES "User"("id")
  ON DELETE CASCADE ON UPDATE CASCADE;

-- Shut to the anon key, like every other table the API owns.
REVOKE ALL ON TABLE "MessageReaction" FROM anon, authenticated;
ALTER TABLE "MessageReaction" ENABLE ROW LEVEL SECURITY;
