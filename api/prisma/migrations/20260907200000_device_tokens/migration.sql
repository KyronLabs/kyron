-- Where to push a notification for one person.
--
-- One row per install rather than per account: a handset signed into a second
-- account is issued a new token, and a token that outlived a sign-out would
-- deliver somebody else's messages to whoever holds the phone now. The unique
-- index on the token is what enforces that -- registering a token that already
-- belongs to another account moves it rather than duplicating it.
CREATE TABLE "DeviceToken" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "userId" UUID NOT NULL,
    "token" TEXT NOT NULL,
    "platform" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "DeviceToken_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "DeviceToken_token_key" ON "DeviceToken"("token");
CREATE INDEX "DeviceToken_userId_idx" ON "DeviceToken"("userId");

ALTER TABLE "DeviceToken"
  ADD CONSTRAINT "DeviceToken_userId_fkey"
  FOREIGN KEY ("userId") REFERENCES "User"("id")
  ON DELETE CASCADE ON UPDATE CASCADE;

-- Shut to the anon key, like every other table the API owns.
REVOKE ALL ON TABLE "DeviceToken" FROM anon, authenticated;
ALTER TABLE "DeviceToken" ENABLE ROW LEVEL SECURITY;
