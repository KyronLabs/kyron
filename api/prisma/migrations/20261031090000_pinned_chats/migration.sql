-- Chats a reader keeps at the top of their Messages list.
ALTER TABLE "ConversationMember" ADD COLUMN "pinnedAt" TIMESTAMPTZ;
ALTER TABLE "CommunityChatMember" ADD COLUMN "pinnedAt" TIMESTAMPTZ;
