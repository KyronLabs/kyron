-- The card for a link in a direct message, sealed by the sender.
--
-- A post's card is fetched by the server, which reads the post anyway. A
-- direct message is sealed before it leaves the phone, and a card fetched
-- here would mean reading the address out of a message this server otherwise
-- cannot read. So the sender's phone makes the card -- title, site, a small
-- copy of the picture -- and seals it like the body. Readers draw it without
-- contacting the linked site at all.
--
-- Nullable and unindexed: most messages carry no link, and nothing is ever
-- looked up by it.

ALTER TABLE "Message" ADD COLUMN "linkCard" TEXT;
