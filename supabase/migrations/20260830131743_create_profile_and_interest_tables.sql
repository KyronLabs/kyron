-- The API has been writing to user_profiles, user_interests and interests
-- since it was written, but none of them existed, so every call failed into the
-- try/catch around the dual-write and the interests feature no-opped.
-- Shapes mirror the Prisma models the API dual-writes from.
--
-- user_id references auth.users: Supabase is now the identity provider, and the
-- API provisions its own row under the same uuid, so the two stay aligned and a
-- deleted account takes its profile with it.
--
-- MUST BE APPLIED TO THE PROJECT THE API ACTUALLY USES. This was first run
-- against the wrong Supabase project, back when the app and the API named
-- different ones, so the tables exist there and not where they are needed. The
-- API's upsertProfileRow throws on a missing table and updateProfile wraps it
-- in Promise.all, so PATCH /profile answers 500 until this is applied -- which
-- is the "Create your profile" screen refusing to continue. GET /health does
-- not cover this: it reports whether the database is reachable, not whether it
-- holds these tables.
--
-- Every statement tolerates a second run, so applying it to a project holding
-- part of this schema is safe.

create table if not exists public.user_profiles (
  user_id      uuid primary key references auth.users (id) on delete cascade,
  display_name text,
  avatar_url   text,
  cover_url    text,
  bio          text,
  location     text,
  website      text,
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now()
);

create table if not exists public.interests (
  id   uuid primary key default gen_random_uuid(),
  slug text not null unique,
  name text not null
);

create table if not exists public.user_interests (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null references auth.users (id) on delete cascade,
  interest_id uuid not null references public.interests (id) on delete cascade,
  created_at  timestamptz not null default now(),
  unique (user_id, interest_id)
);

create index if not exists user_interests_user_id_idx     on public.user_interests (user_id);
create index if not exists user_interests_interest_id_idx on public.user_interests (interest_id);
create index if not exists interests_slug_idx             on public.interests (slug);

-- Keeps updated_at honest even when a writer forgets to set it. Mirrors the
-- existing touch_news_reaction: SECURITY INVOKER with an empty search_path.
create or replace function public.touch_user_profile()
returns trigger
language plpgsql
set search_path to ''
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

drop trigger if exists user_profiles_touch on public.user_profiles;
create trigger user_profiles_touch
  before update on public.user_profiles
  for each row execute function public.touch_user_profile();

-- Trigger functions are never called over REST; leaving EXECUTE granted is what
-- the security advisor flagged on the existing ones.
revoke execute on function public.touch_user_profile() from public, anon, authenticated;

alter table public.user_profiles  enable row level security;
alter table public.interests      enable row level security;
alter table public.user_interests enable row level security;

-- Policies are dropped before being created so this file can be applied more
-- than once. Everything else here already tolerates that -- create table if
-- not exists, create or replace function, on conflict do nothing -- but
-- create policy does not, and this migration has to be applied by hand to a
-- project the tooling cannot reach.
-- Profiles are the public face of an account -- display name, avatar, bio --
-- so they read like news_posts do: visible to everyone, writable only by the
-- owner. The API reaches these with the service role and bypasses RLS entirely;
-- these policies govern any direct client access.
drop policy if exists "profiles are readable by everyone" on public.user_profiles;
create policy "profiles are readable by everyone"
  on public.user_profiles for select using (true);
drop policy if exists "users insert their own profile" on public.user_profiles;
create policy "users insert their own profile"
  on public.user_profiles for insert to authenticated
  with check ((select auth.uid()) = user_id);
drop policy if exists "users update their own profile" on public.user_profiles;
create policy "users update their own profile"
  on public.user_profiles for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
drop policy if exists "users delete their own profile" on public.user_profiles;
create policy "users delete their own profile"
  on public.user_profiles for delete to authenticated
  using ((select auth.uid()) = user_id);

-- Reference data. Readable by all, written only by the service role.
drop policy if exists "interests are readable by everyone" on public.interests;
create policy "interests are readable by everyone"
  on public.interests for select using (true);

-- Readable so shared-interest suggestions can be computed; owner-writable only.
drop policy if exists "user interests are readable by everyone" on public.user_interests;
create policy "user interests are readable by everyone"
  on public.user_interests for select using (true);
drop policy if exists "users add their own interests" on public.user_interests;
create policy "users add their own interests"
  on public.user_interests for insert to authenticated
  with check ((select auth.uid()) = user_id);
drop policy if exists "users remove their own interests" on public.user_interests;
create policy "users remove their own interests"
  on public.user_interests for delete to authenticated
  using ((select auth.uid()) = user_id);

-- Same 15 rows the Prisma seed creates, so both databases agree on slugs.
insert into public.interests (slug, name) values
  ('tech',     'Technology'),
  ('music',    'Music'),
  ('sports',   'Sports'),
  ('gaming',   'Gaming'),
  ('movies',   'Movies & TV'),
  ('business', 'Business'),
  ('finance',  'Finance'),
  ('science',  'Science'),
  ('ai',       'Artificial Intelligence'),
  ('crypto',   'Crypto & Web3'),
  ('art',      'Art & Design'),
  ('fashion',  'Fashion & Style'),
  ('food',     'Food & Cooking'),
  ('travel',   'Travel'),
  ('health',   'Health & Fitness')
on conflict (slug) do nothing;
