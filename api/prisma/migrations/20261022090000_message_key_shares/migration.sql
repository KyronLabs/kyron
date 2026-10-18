-- A message's key sealed again for a device it was not sealed for when it was
-- sent. A row with no sealed value is a request; an answer fills it in. See
-- MessageKeyShare in schema.prisma and docs/E2EE.md.
CREATE TABLE "MessageKeyShare" (
    "id" UUID NOT NULL,
    "messageId" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "publicKey" TEXT NOT NULL,
    "sealed" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "answeredAt" TIMESTAMPTZ,

    CONSTRAINT "MessageKeyShare_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "MessageKeyShare_messageId_publicKey_key" ON "MessageKeyShare"("messageId", "publicKey");
CREATE INDEX "MessageKeyShare_userId_idx" ON "MessageKeyShare"("userId");

ALTER TABLE "MessageKeyShare" ADD CONSTRAINT "MessageKeyShare_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES "Message"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "MessageKeyShare" ADD CONSTRAINT "MessageKeyShare_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
