-- Hardening from the November 2026 security review (#179).

-- 1. A policy nothing uses, added by hand and never recorded: it let anyone
--    holding the anon key upload one named file. Every real upload goes
--    through the API with the service role.
drop policy if exists tmp_one_avatar_upload on storage.objects;

-- 2. Grants that say what the policies mean. anon and authenticated held
--    every privilege, TRUNCATE included, on the three client-facing tables;
--    RLS stopped the writes that matter, but the grants were wider than
--    anything intended.
revoke all on table public.interests, public.user_interests, public.user_profiles
  from anon, authenticated;

-- The interest list is the same for everybody, and onboarding reads it.
grant select on table public.interests to anon, authenticated;

-- Profiles are public pages: name, picture, bio, location, website.
grant select on table public.user_profiles to anon, authenticated;
grant insert, update, delete on table public.user_profiles to authenticated;

-- 3. Somebody's interests are theirs. They shape that person's own feed and
--    are never shown on a profile, so nobody else -- and nobody signed out --
--    reads them. The client does not read this table at all; the API reads
--    it as the owner.
grant select, insert, delete on table public.user_interests to authenticated;
drop policy if exists "user interests are readable by everyone" on public.user_interests;
drop policy if exists "users read their own interests" on public.user_interests;
create policy "users read their own interests"
  on public.user_interests for select to authenticated
  using ((select auth.uid()) = user_id);

-- 4. Replaced by touch_user_profile, used by no trigger, executable by anon,
--    and with a mutable search_path.
drop function if exists public.update_timestamp();

-- 5. A backstop behind the API's own checks: the same ceiling
--    (MediaService.maxBytes, 25 MiB) and the same types it accepts, sniffed
--    from the bytes. A bucket that takes anything is one bug away from
--    hosting anything.
update storage.buckets
   set file_size_limit = 26214400,
       allowed_mime_types = array[
         'image/jpeg', 'image/png', 'image/webp', 'image/heic', 'image/gif',
         'video/mp4', 'video/quicktime', 'video/webm',
         'audio/mp4'
       ]
 where id in ('kyron-media', 'kyron-private');
