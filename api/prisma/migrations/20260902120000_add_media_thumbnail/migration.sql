-- A still from a video, uploaded beside it by the composer.
--
-- Without one, drawing a list of clips means opening a decoder per clip. Phones
-- cap how many can be open at once, and past the cap the surface fails and the
-- tile goes black -- which is what a wall of videos was doing.
--
-- Nullable, and left null on every existing row: clips posted before the
-- composer started sending a still do not have one, and the client falls back
-- to opening a player for those.
ALTER TABLE "Media" ADD COLUMN IF NOT EXISTS "thumbnailUrl" TEXT;
