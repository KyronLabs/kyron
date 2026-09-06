-- Attachments on a direct message, and muting a conversation.

-- Media already hangs off a post or a comment; a message is the third place
-- it can hang off, and one nullable column each is what that costs.
ALTER TABLE "Media" ADD COLUMN IF NOT EXISTS "messageId" UUID;

CREATE INDEX IF NOT EXISTS "Media_messageId_position_idx"
    ON "Media"("messageId", "position");

ALTER TABLE "Media"
    ADD CONSTRAINT "Media_messageId_fkey" FOREIGN KEY ("messageId")
    REFERENCES "Message"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- Muting is the member's own setting, not the conversation's: the other side
-- should not be able to see it or undo it.
ALTER TABLE "ConversationMember" ADD COLUMN IF NOT EXISTS "mutedAt" TIMESTAMPTZ;
