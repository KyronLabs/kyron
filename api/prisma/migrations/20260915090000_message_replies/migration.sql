-- Replying to one message in a chat.
--
-- Only the id of what is being answered, never a copy of its text. Direct
-- messages here are sealed before they leave the phone -- the server stores
-- ciphertext it cannot read -- and a reply that carried the quoted words would
-- have written that same text into the database in the clear, undoing the
-- encryption for every message anybody ever replied to. The client already
-- holds the thread decrypted, so it resolves the quote itself.
--
-- ON DELETE SET NULL rather than CASCADE: deleting the message somebody
-- answered must not delete their answer. The reply loses its quote and keeps
-- its words, which is what a reader expects of a conversation.

ALTER TABLE "Message" ADD COLUMN "replyToId" UUID;

ALTER TABLE "Message"
  ADD CONSTRAINT "Message_replyToId_fkey"
  FOREIGN KEY ("replyToId") REFERENCES "Message"("id")
  ON DELETE SET NULL ON UPDATE CASCADE;

-- For "what answered this", which the thread needs when a quote is tapped.
CREATE INDEX "Message_replyToId_idx" ON "Message"("replyToId");
