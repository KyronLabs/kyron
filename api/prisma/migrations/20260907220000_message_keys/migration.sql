-- Somebody's public half, so other people can write to them in private.
--
-- Public by design: this is what anyone needs to seal a message only the
-- holder of the matching secret can open. The secret half never reaches this
-- server, which is the point -- what Message then carries is ciphertext
-- nobody here has a key for.
CREATE TABLE "MessageKey" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "userId" UUID NOT NULL,
    "publicKey" TEXT NOT NULL,
    "deviceId" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "MessageKey_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "MessageKey_publicKey_key" ON "MessageKey"("publicKey");
-- One key per install, so a device replaces its own without disturbing the
-- others a person has.
CREATE UNIQUE INDEX "MessageKey_userId_deviceId_key" ON "MessageKey"("userId", "deviceId");
CREATE INDEX "MessageKey_userId_idx" ON "MessageKey"("userId");

ALTER TABLE "MessageKey"
  ADD CONSTRAINT "MessageKey_userId_fkey"
  FOREIGN KEY ("userId") REFERENCES "User"("id")
  ON DELETE CASCADE ON UPDATE CASCADE;

-- Shut to the anon key, like every other table the API owns. These keys are
-- public in the cryptographic sense, not a public listing of who uses Kyron.
REVOKE ALL ON TABLE "MessageKey" FROM anon, authenticated;
ALTER TABLE "MessageKey" ENABLE ROW LEVEL SECURITY;
