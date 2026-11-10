-- Take the API's tables away from the anon and authenticated roles.
--
-- Supabase grants both roles full access to every new table in `public`, and
-- Prisma creates its tables there. The result was that every table the API
-- owns was readable and writable over PostgREST and pg_graphql by anyone
-- holding the anon key -- which is public by design, and is compiled into the
-- Flutter app and the committed web bundle. Verified before writing this:
--
--   GET /rest/v1/Message?select=id&limit=1   -> 200, one row
--   GET /rest/v1/User?select=id&limit=1      -> 200, one row
--
-- Direct messages, accounts, refresh tokens and password resets were all in
-- reach. Nothing in the app reads these through the anon key: the client only
-- touches user_profiles and interests, and the API connects as the owner over
-- DATABASE_URL, so revoking costs nothing.
--
-- Revoking rather than enabling RLS with no policies. Both shut the door;
-- this one cannot be reopened by somebody adding a permissive policy later,
-- and it does not depend on every future table remembering to turn RLS on.
-- The three Supabase-native tables are left alone -- they already have RLS,
-- and the client genuinely reads them.

REVOKE ALL ON TABLE public."AppSetting" FROM anon, authenticated;
REVOKE ALL ON TABLE public."AuditLog" FROM anon, authenticated;
REVOKE ALL ON TABLE public."Block" FROM anon, authenticated;
REVOKE ALL ON TABLE public."Comment" FROM anon, authenticated;
REVOKE ALL ON TABLE public."CommentLike" FROM anon, authenticated;
REVOKE ALL ON TABLE public."Community" FROM anon, authenticated;
REVOKE ALL ON TABLE public."CommunityBan" FROM anon, authenticated;
REVOKE ALL ON TABLE public."CommunityMember" FROM anon, authenticated;
REVOKE ALL ON TABLE public."Conversation" FROM anon, authenticated;
REVOKE ALL ON TABLE public."ConversationMember" FROM anon, authenticated;
REVOKE ALL ON TABLE public."EmailVerification" FROM anon, authenticated;
REVOKE ALL ON TABLE public."Follow" FROM anon, authenticated;
REVOKE ALL ON TABLE public."Hashtag" FROM anon, authenticated;
REVOKE ALL ON TABLE public."HiddenPost" FROM anon, authenticated;
REVOKE ALL ON TABLE public."Interest" FROM anon, authenticated;
REVOKE ALL ON TABLE public."InterestSignal" FROM anon, authenticated;
REVOKE ALL ON TABLE public."KyronPointEvent" FROM anon, authenticated;
REVOKE ALL ON TABLE public."LinkPreview" FROM anon, authenticated;
REVOKE ALL ON TABLE public."Media" FROM anon, authenticated;
REVOKE ALL ON TABLE public."Message" FROM anon, authenticated;
REVOKE ALL ON TABLE public."Mute" FROM anon, authenticated;
REVOKE ALL ON TABLE public."PasswordReset" FROM anon, authenticated;
REVOKE ALL ON TABLE public."Poll" FROM anon, authenticated;
REVOKE ALL ON TABLE public."PollOption" FROM anon, authenticated;
REVOKE ALL ON TABLE public."PollVote" FROM anon, authenticated;
REVOKE ALL ON TABLE public."Post" FROM anon, authenticated;
REVOKE ALL ON TABLE public."PostHashtag" FROM anon, authenticated;
REVOKE ALL ON TABLE public."PostLike" FROM anon, authenticated;
REVOKE ALL ON TABLE public."PostSave" FROM anon, authenticated;
REVOKE ALL ON TABLE public."PostTopic" FROM anon, authenticated;
REVOKE ALL ON TABLE public."PostView" FROM anon, authenticated;
REVOKE ALL ON TABLE public."RefreshToken" FROM anon, authenticated;
REVOKE ALL ON TABLE public."Report" FROM anon, authenticated;
REVOKE ALL ON TABLE public."Repost" FROM anon, authenticated;
REVOKE ALL ON TABLE public."SystemModule" FROM anon, authenticated;
REVOKE ALL ON TABLE public."User" FROM anon, authenticated;
REVOKE ALL ON TABLE public."UserInterest" FROM anon, authenticated;
REVOKE ALL ON TABLE public."UserProfile" FROM anon, authenticated;
REVOKE ALL ON TABLE public."UserSession" FROM anon, authenticated;
REVOKE ALL ON TABLE public._prisma_migrations FROM anon, authenticated;

-- And stop the next Prisma migration handing the next table straight back.
--
-- Without this the fix lasts until somebody adds a model: Supabase's default
-- privileges apply to whatever creates the table, so a new one arrives
-- readable by anon and nobody finds out until the advisor is read again.
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  REVOKE ALL ON TABLES FROM anon, authenticated;

-- Belt as well as braces. RLS with no policies denies everything by default,
-- so on these tables -- which no client should reach anyway -- it is a second
-- lock rather than a change of behaviour. Deliberately not applied to
-- user_profiles, interests or user_interests, which have policies and are
-- read by the app.
ALTER TABLE public."AppSetting" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."AuditLog" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."Block" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."Comment" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."CommentLike" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."Community" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."CommunityBan" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."CommunityMember" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."Conversation" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."ConversationMember" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."EmailVerification" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."Follow" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."Hashtag" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."HiddenPost" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."Interest" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."InterestSignal" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."KyronPointEvent" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."LinkPreview" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."Media" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."Message" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."Mute" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."PasswordReset" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."Poll" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."PollOption" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."PollVote" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."Post" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."PostHashtag" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."PostLike" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."PostSave" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."PostTopic" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."PostView" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."RefreshToken" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."Report" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."Repost" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."SystemModule" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."User" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."UserInterest" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."UserProfile" ENABLE ROW LEVEL SECURITY;
ALTER TABLE public."UserSession" ENABLE ROW LEVEL SECURITY;
