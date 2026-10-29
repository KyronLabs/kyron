# Changelog

Notable changes to Kyron, newest first.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and versions follow [semantic versioning](https://semver.org/spec/v2.0.0.html).

Entries under **Unreleased** are stamped with a version and a date by the
_Create Versioned Release_ workflow, which refuses to cut a release while that
section is empty. The versioned release's notes on GitHub are this file's
section for that version, so what is written here is what people read.

## [Unreleased]

## [0.1.19] - 2026-10-29
### Added

- **Send a post to somebody on Kyron.** Share on a post now starts with
  "Send in a message": pick one or more people -- the ones you talk to, or
  anybody by searching -- add a line if you like, and Send. It arrives as a
  card with whose post it is and how it starts, and tapping it opens the
  post in Kyron. Every way to share used to lead out of the app.
- **Kyron's own links open in Kyron.** A link to a post, a profile or a
  community -- in a message, a post or anywhere else -- opens that screen,
  rather than a web page.
- **You're told when somebody mentions you.** Writing @yourhandle in a post
  or a reply now sends you a notification -- "Ada mentioned you: …" with
  the words they wrote -- and puts it in Notifications, under a new
  Mentions tab. Before, nothing recorded a mention at all. Not for the
  writer themselves, nobody blocked either way, and not twice for a reply
  you are already told about.

## [0.1.18] - 2026-10-29
### Fixed

- **Following somebody from their profile now sticks.** The profile said
  "Follow" again every time it was reopened or refreshed, although the
  follow had been saved: the server never looked at who was asking, so it
  told everybody they followed nobody.
- **The follow button on a post's picture is a small solid + sitting on the
  edge of the face**, not a white blob in a ring hanging off its corner.
- **"Edit profile" and every other outlined button are ringed by a hairline**,
  one device pixel like the app's other lines, instead of a border three
  times as heavy.

## [0.1.17] - 2026-10-29
### Added

- **Insights for your account.** The chart button beside Share on your own
  profile opens them: how many people your posts reached over the last 7, 30
  or 90 days against the period before, new followers, opens, likes,
  replies, reposts and saves, a day-by-day chart and your top posts.
- **Who your audience is**: how many already follow you, their ages, the
  topics they follow, the communities they are in, and when they are
  around, in your time zone, and which countries they are in. Shown only
  once 20 people have been reached, and never a group smaller than 5, so
  it cannot point at anybody. Kyron does not collect cities or genders,
  and the screen says so.
- **How to grow**: up to four tips worked out from your own numbers --
  replies you have not answered, posts without topics, a post that did far
  better than the rest, the community your audience is in -- each with a
  way to act on it, and none unless it applies to you.
- **A country on your profile, picked from a list.** Edit profile and
  sign-up offer every country, named in your own language and searchable
  in it, in English or by code, with the ones your phone's settings point
  at first. It shows on your profile and under your posts. Location used to
  be a box you typed anything into; what people had typed is carried over
  where it plainly names one country ("Lagos, Nigeria"), and otherwise left
  for them to pick.
- **Follow from the post.** A post by somebody you do not follow has a +
  on their picture. Tap it to follow without leaving the feed; it ticks,
  and every other post of theirs on screen stops offering.

## [0.1.16] - 2026-10-26
### Changed

- **"Not interested in this" now means posts like this, not this person.**
  It used to take most of the author out of your feed for good, even if
  you followed them, and did nothing about what the post was about. Now it
  shows you fewer posts on the same topics and hashtags from anyone, and
  only a little less of the author. To see much less of somebody, mute
  them.
- **"Show more posts like this" does something you can see**: more posts
  on the same topics and hashtags, and more from that author.
- **Both now fade.** Each counts for half as much after a month and stops
  counting after six. Both also shape Explore, not only Home.

### Added

- **Undo** on the message after "Not interested" or "Show more". Undoing
  "Not interested" brings the post back.
- **Settings → Your feed signals** lists everything those two buttons are
  telling your feeds, how much each still counts, and lets you remove any
  of them.

### Fixed

- **"Not interested" used to wear off silently** once you had given 200
  newer signals, while promising to last. It now fades on a schedule the
  app tells you about.

## [0.1.15] - 2026-10-25
### Fixed

- **Messages on a new phone no longer wait forever** while your old phone is
  signed in. Your other phones now answer for the new one as soon as they
  can: when they are asked, when they come back to the front, and without
  being crowded out by requests nobody can answer. Messages sent to you in
  your first minutes on a new phone are also sealed for it, rather than only
  for the phones you had before. Your old phone still has to open Kyron once
  for older messages to arrive. Needs this version of the app and the
  server.
- **Face lenses track straight away.** A face lens could do nothing until a
  colour lens had been picked first -- after the notification shade, a call,
  flipping the camera, or picking the face lens before the camera had opened.
- **The lens camera comes back** after the notification shade or a call,
  rather than leaving the viewfinder spinning.

## [0.1.14] - 2026-10-24
### Added

- **Pin chats to the top of Messages.** Press and hold a conversation, a
  group or a community chat and choose Pin to the top. Up to five stay
  above everything else, whenever they were last talked in, and follow you
  to your other phones.
- **Pushes in your phone's language.** Likes, replies, messages, decisions
  about your account and the rest arrive in the language the app is set to,
  whichever of its languages that is. This needs this version of the app;
  older ones get English.

### Changed

- **A community post's own page** shows the author in front of the
  community's picture, the way it looks in your feeds.
- **Account status, the appeal form and the report form are in your
  language**, dates included. A suspension says until when, and the appeal
  form says how much to write before it can be sent.

### Fixed

- **Yoruba, Hausa, Igbo, Xhosa and Somali** no longer break the app's
  screens. Flutter has no words of its own in these, so its buttons and
  menus are in English while Kyron's are in yours.

## [0.1.13] - 2026-10-23
### Changed

- **A community's page opens on one row**, like a feed's header: back, the
  community's picture and name, how many are in it, its chats, More, and
  Join if you are not in it. What it is for sits under it. The banner, the
  whole description and the counts are a tap on the name away. The first
  post is no longer half way down the screen.
- **Communities is a list of rows** on the page, like a list of people to
  follow: picture, name, members, the button on the right, and the
  description or newest post underneath.
- **Community posts in your feeds** show the author in front of the
  community's picture again, with the community's name above. On the
  community's own page they look like any other post.
- **The bell on the home screen** counts with the same red badge as
  Messages, sitting on the bell.
- **Every sheet's handle** has less space above and below it.

### Fixed

- **YouTube links in posts get a preview** — title, channel and thumbnail —
  and so do TikTok videos. Links that failed before are tried again within
  15 minutes.

## [0.1.12] - 2026-10-22
### Added

- **Notifications about your account.** A warning, a removal, a suspension
  or a ban, an appeal decided, and a decision reversed are rows in
  Notifications, from Kyron rather than from a person, and open Account
  status.
- **Your reports**, in Settings: everything you reported in the last 90
  days, what it was about and where it stands — in review, action taken, or
  no rule broken. When the team decides you get a push and a row in
  Notifications, and both open it. The confirmation after you send a report
  says so and links there.
- **Groups in Messages**, beside Hidden: the groups you are in and the
  community chats you joined.

### Changed

- **Notifications say who and what**, like Threads: the person's name as the
  title ("Ada and 2 others"), what they did with the start of the post or
  reply ("Liked your post: “…”"), and their picture on Android. A like no
  longer replaces a reply about the same post on your phone.
- **A community's page**: smaller back, chats and More buttons at the top,
  the same as a profile's; its chats open in a sheet from the chats button,
  which shows a dot when one has something new; **new post** is a button in
  the bottom right corner.
- **Community posts are as compact as any other post**: the author's own
  picture, and the community's name in place of the @handle, left out inside
  the community itself. Long names are no longer cut short.

## [0.1.11] - 2026-10-21
### Added

- **Community chats in the Messages list**, among conversations by when each
  was last spoken in, with a count of what is new. The Messages count
  includes them.
- **Notifications for community chats**: one when something new arrives
  after you last read a chat, not one per message, and one for a reply to
  you. **Mute** a chat from its menu to stop them and leave it out of the
  count.
- **Photos, clips and voice notes in community chats**, up to four pictures
  or clips in a message, or one voice note. They are kept in private storage
  behind links that last an hour.
- **Polls in community chats**: two to ten answers, one or several each.
  Everybody sees how many chose each answer, never who. The asker or a
  moderator closes it.
- **Edit your message** in a community chat for 15 minutes; it shows
  "edited". **Search a chat** and jump to where something was said.
- **Moderation**: a reported chat message's pictures and voice notes are
  shown on its case, and earlier versions of an edited message are kept.

### Changed

- **Choosing people for a group** looks like a list of people: a "To:" line
  with the people chosen as small chips, suggested people with their
  pictures, and the group's name at the top. The name is still required.
  The "everyone added joins as a spectator" switch is in the group's info.
- **A view-once message is one line** — an icon and what it is ("Photo",
  "Opened") — about the height of a line of text, instead of a tall card.

## [0.1.10] - 2026-10-21
### Added

- **Community chats, several to a community.** A community's page lists its
  chats above its posts — up to 20, opened and run by its owner and
  moderators. Anybody in the community can read a chat and react as a
  spectator; joining it is what lets them write. A chat can be kept for
  announcements, so only moderators write and everyone else reads and
  reacts. Moderators can pin a message, set a slow mode, and delete
  members' messages; the owner can delete anybody's. Any message can be
  reported to Kyron. **Community chats are not end-to-end encrypted**, and
  each one says so: the community's moderators and Kyron can read them.
  Direct messages and groups are still end-to-end encrypted.
  docs/MESSAGING.md has the rules and what is not built yet (chats in the
  Messages inbox, push notifications, photos and voice notes).

## [0.1.9] - 2026-10-20
### Added

- **Group chats.** Start one from New message → Create group chat: up to 32
  people, end-to-end encrypted like any other conversation. A group has an
  owner, admins, members and **spectators** — people who can read and react
  but not write, and who can raise a hand to ask to. Admins add and remove
  people, rename the group, answer raised hands, and can have everyone added
  from then on join as a spectator. The owner makes admins and can hand the
  group on. Changes show as a line in the conversation ("Ada added Ben").
  Somebody added later sees what is said from then on, not before.
- **View once, for photos, clips and voice notes.** In a conversation or a
  group, + → Send view once, or the switch on a recorded voice note. Each
  person it went to can open it once; then it is deleted from Kyron's
  storage, and anything unopened goes after 14 days. On Android the screen
  cannot be captured while it is open. On iPhone it can, and no phone can
  stop another camera — docs/MESSAGING.md says what view once does and does
  not promise.

### Fixed

- **Buttons were drawn in the phone's own font, not Inter.** Their labels
  named a size and a weight but no typeface, and a button's label does not
  inherit one.

## [0.1.8] - 2026-10-20
### Changed

- **The verified badge is the size of the name beside it.** It was drawn at
  a full em or more, chosen by hand in each place, and looked larger than
  the letters. It is now sized from the name's own text everywhere.
- **The sidebar is shorter.** Saved and Liked share a row. The "Get
  verified" stamp has moved below Help & Support, and is shown only to
  accounts without the badge: the badge beside your name already says
  you have it.

### Added

- **Choose your handle.** Accounts made with Google never had a handle,
  because Google does not send one and nothing asked, and neither did an
  email sign-up that left the box empty or asked for one already taken. An
  account with no handle is now asked for one once, after onboarding, with a
  suggestion made from its name and a live check that it is free. Handles
  are stored lowercase, so "Ada" and "ada" can no longer be two accounts,
  and names like `kyron`, `admin` and `support` are reserved.

### Fixed

- **For You showed the same nineteen posts and then ended.** It only ever
  considered posts from the last fourteen days, which on a network as quiet
  as Kyron's was about twenty. It now ranks the newest 400 posts whatever
  their age, and freshness fades with how fast people are posting rather
  than by the clock.
- **For You kept opening on the same posts.** It only knew about posts you
  had opened, not ones you had scrolled past. The app now tells it what was
  on screen, and the next session moves on to what you have not seen; what
  you have seen comes back after a few days. Paging stays in order while
  this is being recorded. See `docs/FEED.md`.
- **The app now uses its own typeface.** The design asks for Inter, but the
  font was declared in the wrong place and never shipped, so every screen
  used the phone's default. Inter is about 4% wider, so a long name may
  shorten a little sooner in tight places.


## [0.1.7] - 2026-10-19
### Added

- **Verification.** An account can ask for the verified badge from a new
  stamp at the top of the sidebar. The badge says one thing: somebody on the
  Kyron team checked the account is who it says it is. It gives no extra
  reach and is not for sale. To ask, an account needs a photo, a name, a
  bio, a week behind it and a clean record for the last 90 days, and it
  sends links to pages it controls that name its Kyron account. Kyron never
  asks for identity documents.
- **The badge beside verified names**, wherever a name is shown: posts,
  replies, profiles, people lists, notifications, messages and the sidebar.
- **A Badges tab for the team**, in Settings → Moderation. Each request
  shows the account, what it says, the links to check, and the requirements
  as they stand now. Nobody answers their own request, and a "no" says why.
  The team can also give or remove the badge from an account's record, with
  a reason that goes on the record. See `docs/VERIFICATION.md`.

### Changed

- **Changing your name removes the badge**, because the badge vouches for
  the name. You are told why and can ask again.

## [0.1.6] - 2026-10-19
### Security

- **Account details could be read without signing in.** `GET /users/:id`
  answered anybody, with no sign-in, and returned the whole account row for
  any id -- including the email address -- while every post carries its
  author's id. `POST /users`, beside it, created accounts with any role the
  request named, administrator included. Neither was used by any client;
  both are gone. A test now lists every route that answers without a
  sign-in and fails when one appears that is not on its list, and a sign-in
  matched to an existing account by email address alone can no longer
  inherit a staff role.
- **A suspended account could do everything.** The account status column
  was set by nothing and checked only by a password sign-in no client uses.
  Suspensions and bans are now enforced on every request and on the realtime
  connection.

### Fixed

- **Releases go to closed testing, where the testers are.** 0.1.5 was sent
  to Play's internal testing track, which nobody tests on; Kyron's testers,
  and Google's reviews, are on Closed testing - Alpha. Releases now go there
  by default, and the `PLAY_TRACK` repository variable picks another testing
  track. The release notes are written in the store listing's own default
  language rather than always US English, which a listing in another
  language would not have shown. When Play will not send a release for
  review by itself, the run now says so and what to press, instead of
  reporting it as delivered. Production is refused outright.
- **Feedback can be sent.** Send Feedback said "Feedback cannot be sent
  right now" to everybody: it filed issues on the public GitHub repository
  through a token the server never had, and would have published what
  people wrote, with their account, if it had. It is now kept privately for
  the Kyron team, tied to the account so we can answer by email, and
  deleted with the account. The form offers a problem, an idea or a
  question, and says the report number to quote.
- **Error reports arrive.** Send error report opened a mail to
  support@kyron.so, a domain Kyron does not own. It now sends the report,
  and the app's log if you leave that on, to the same private inbox.
- **Contact support has somewhere to go.** It said to "open an issue" and
  linked nowhere. It now offers asking a question, reporting a problem, an
  error report and the service status inside the app, and the safety and
  privacy addresses the privacy policy names. The Help Centre rows are gone
  until there is a Help Centre: help.kyron.so never loaded.
- **Muted words can be added.** The field to type a word into did not
  appear, so the screen said "add a word or a tag above" over nothing.
- **Muted and blocked accounts are tabs**, in the same style as the rest of
  the app, and say how to mute or block somebody when the list is empty.

### Added

- **Reports are acted on, and decisions can be appealed.** The report button
  had nothing behind it: reports were stored and never read. Now:
  - **The team** (moderators and admins, appointed with
    `npm run account:role`) gets a notification for each report, and works
    from Settings > Moderation. Reports are grouped by what was reported,
    urgent ones first. Each decision removes the post or reply, warns,
    suspends for 1 to 365 days, or bans, with a message to the account in
    the reviewer's own words.
  - **The account** is always told. Settings > Account status lists every
    decision with the rule, the message and what the post said. Each
    decision can be appealed once, for six months, and somebody other than
    whoever decided hears the appeal.
  - **Suspended** accounts can read but not post. **Banned** accounts see
    only why, the appeal, support and account deletion; their posts
    disappear for everybody else, and come back if the ban is overturned.
  - **Whoever reported** is told whether action was taken.
  - **Deleting a banned account** does not lift the ban: a new account at
    the same email address starts banned, and can appeal.
  - docs/MODERATION.md has the policy, how to appoint the team, and what the
    team must do outside the app.
- **A written plan for message backups.** Not built yet: docs/E2EE.md now
  describes the Kyron Vault, which would keep every message key an account
  has had, sealed under a key that only the account's own passkey, another
  of its devices, a written-down recovery code or Android's Block Store can
  open -- so a new phone reads the whole history at once, and Kyron still
  cannot. It waits on a domain for passkeys.

## [0.1.5] - 2026-10-19
### Added

- **"Waiting for this message" instead of "cannot be read".** A message is
  sealed for the devices that existed when it was sent, so a new phone or a
  reinstall could never read what came before it. Now the new device asks,
  and the sender's phone -- or another of the reader's own -- seals the
  message's key again for it the next time it is online; the message opens
  then. The server carries the request and the answer and can read neither.
  Messages from the last 30 days only; docs/E2EE.md says why, and what it
  costs against a malicious server.
- **Releases go to Play by themselves.** Once a Play service account is set
  up (README.md, Google Play), each versioned release's bundle is sent to
  the internal testing track by CI once it has been checked, with the
  release's changelog section as the notes. Uploading to Play Console by
  hand was the only way. Development builds are not sent: testers get what
  was cut as a version, not every merge. The upload goes through Play's API
  directly from a script in this repository, so the key is handled by
  nothing from outside it.

### Fixed

- **Message keys belong to the account, and survive sign-out.** There was
  one key per install, deleted on every sign-out, so switching accounts on a
  phone -- or signing out and back in -- made a new key, and every message
  sent to the old one could never be opened there again. Each account now
  has its own key on each phone, kept across sign-out and erased only when
  the account is deleted; another account signing in on the same phone never
  reads it. The update moves a phone's existing key to whoever is signed in,
  so nothing already sent to it is lost. The verifiable identifier (DID) had
  the same fault, and changed on every sign-in; it is kept the same way.
- **One layout on every Android version.** Targeting SDK 35 and later,
  Android 15 draws apps edge to edge whatever they ask for; before 15 they
  only are if they say so. Kyron didn't, so it was edge to edge on new
  phones and not on older ones -- and became edge to edge on older ones
  partway through a session, the first time the photo viewer closed. It now
  asks for it from the start (`enableEdgeToEdge()`), which is also what
  Play's "edge-to-edge may not display for all users" warning asks for.
- **Sheets no longer sit under the navigation bar.** Flutter keeps a bottom
  sheet clear of the status bar but not of the navigation bar, so on an
  edge-to-edge screen eight of Kyron's sheets ran their last row under it --
  with three-button navigation, most of the sign-out sheet's "Log Out"
  button. They make room for it now.
- **The tab bar hides all the way.** Scrolling hid it by a fixed 80 pixels,
  enough for a gesture bar and not for three-button navigation, which left a
  32-pixel strip of it on screen.

## [0.1.4] - 2026-10-18
### Fixed

- **An account made with Google had no way in from "Log in".** "Already on
  Kyron? Log in" led to an email and a password field and nothing else, and
  an account made with "Continue with Google" has no password. The log-in
  screen now has "Sign in with Google", the same flow as the welcome
  screen's, and a password that fails there points to it.
- **A refused Google sheet left no trace of why.** Since 0.1.3 the app goes
  to the browser whenever the account sheet closes, which signs people in
  but hid the reason the sheet failed. The System log now records Google's
  own words, and says plainly when they mean this install's signing
  certificate is not registered -- the reason the sheet fails on Play
  installs. docs/AUTH_GOOGLE.md has the fix.

## [0.1.3] - 2026-10-16
### Fixed

- **Google sign-in could stop without an explanation.** Failed browser launches
  now show an error, and Android account-picker cancellations fall back to the
  browser sign-in flow instead of silently clearing the loading state.

## [0.1.2] - 2026-10-15
### Added

- **Delete your account.** Settings → Delete account says what goes -- your
  profile, posts, replies, likes and reposts, your messages including the ones
  you sent, your followers and settings, and everything you uploaded -- asks
  once more, and deletes it, sign-in included (`DELETE /account`). Communities
  you started go to their longest-serving moderator or member rather than being
  left with nobody to run them, and one with nobody else in it is closed; bans
  you made as a moderator stay in force; other people's posts are recounted so
  their likes and replies stop counting yours. What is left under the account's
  id is an empty row marked deleted, so a phone still signed in cannot
  quietly be given a new account by its unexpired session. For a request made
  without the app, `npm run account:delete -- <email>` does the same from the
  server, and the terms-and-privacy site has a page saying how to ask. Google
  Play requires both.
- **"Deleted account" in Messages.** A conversation whose other side deleted
  their account says so, in the list and the thread, and the message box gives
  way to a line saying nothing more can be sent there -- the server refuses it
  too, rather than storing a message nobody would ever read.
- **Every development build has a Play bundle.** Only versioned releases used
  to build an `.aab`, so the newest `main` could reach Play's internal testers
  only by cutting a version. Each development build now carries
  `kyron-X.Y.Z+N.aab`, signed with the upload key and checked before it is
  published. Its APKs are still signed with the development key, so nothing
  changes on phones that have them.

### Fixed

- **Development and release bundles would have collided in Play.** Each
  workflow numbered builds with its own run counter -- development builds were
  at 119 when the first release ran as 1 -- so one development bundle uploaded
  to Play would have left every release after it below the version code Play
  requires. Both now number a build by the commits behind it, one sequence that
  only rises along `main`; the next build is above every number already
  published. Release bundles are now checked for the upload key's signature and
  their version code too, and the signing passwords are no longer written
  through a shell heredoc that would have mangled a `$` or a backtick in one.
- **"Latest" on GitHub was a development build.** Development builds were
  published as full releases so that "Latest" pointed somewhere while no
  versioned release existed. One does now, so they are prereleases again, and
  "Latest" is the version that shipped.

## [0.1.1] - 2026-10-14
### Fixed

- **Cutting a release would have built nothing.** Create Versioned Release
  pushed its tag with the workflow's own token, and GitHub starts no workflow
  for a push made with that token -- so the version would have been bumped and
  tagged, and Release would never have run. It now starts Release on the tag
  by name, and `scripts/check-workflows.py` fails a pull request that loses
  that. It also checks the signing secrets before it changes anything (that
  each is set, that the keystore opens, that the key's own password unlocks
  it, and that the Firebase file is for this app), so a missing one stops it
  before a version is spent rather than after. Release notes too long for a
  GitHub release are cut between entries with a link to the rest, instead of
  failing the publish after every platform has built. Development builds no
  longer fall back to the release key: adding it, to publish to Play, would
  have re-signed them and every installed copy would have refused the next.

- **A message notification opened the feed.** The tap was listened for by
  the signed-in screen itself, which a cold start builds only after the
  splash and the onboarding check, so a tap that arrived first had nobody to
  hear it. It is now caught from launch and held until the app is there to
  open it, over the tab it starts on. Activity notifications open what they
  are about: a like, reply or repost opens the post, and a follow opens the
  follower's profile (the server now sends which), rather than the
  notifications page. Repeat notifications about one post replace each
  other instead of stacking, which also keeps Android from bundling them
  under a summary whose tap goes nowhere in particular.

- **"Continue with Google" always opened the browser.** The phone's own
  account sheet was never shown: the app left Google's web client id to be
  found in the Firebase configuration, which comes from a different Google
  Cloud project and has never carried it, so Android refused before a sheet
  could open. The app names the client itself now. It also no longer takes an
  instant "dismissal" at face value -- that is how Android reports an app it
  does not recognise -- and goes to the browser instead of doing nothing.
  The sheet needs an Android OAuth client in the same project as the web
  client; docs/AUTH_GOOGLE.md has the one step.
- **Tapping Google made the email button vanish.** The other ways in were
  switched off, and a switched-off filled button is drawn as a pale smudge.
  They now fade back and stop taking taps, and the Google mark turns into a
  spinner while the label stays.

- **Push said "off" and nothing else.** Every way of getting the server's
  Firebase key wrong looked the same from outside. `/health` now carries
  `pushProblem`, which says which: not set or set without a redeploy, set
  under a nearly-right name, cut off at its first line, the app's
  google-services.json or the sign-in OAuth client pasted in its place, or a
  key Google refuses. The key is checked with Google at boot rather than at
  the first notification, and `pushLastFailure` names a key from the wrong
  Firebase project. A Render secret file, a multi-line paste, base64 and a
  value still in its shell quotes are all read.
- **No push notification had ever arrived.** The server had no Firebase key,
  so every push was dropped before it left; `GET /health` said `push: off`.
  That is configuration (docs/PUSH.md), but the app had its own gaps: no
  Android channels, so Android 8+ put every push in a silent default; no
  small icon, so the one that did show was a white square; nothing happened
  on tapping one; and the Notifications switch in Settings did nothing.
  Messages now come on a high-importance channel with sound, others on an
  activity channel; a tap opens the conversation or the notifications page;
  the switch registers and unregisters this phone; and *Send a test
  notification* says which part is broken: the server, this phone's token,
  or delivery. A phone's token is forgotten only when FCM says it is gone,
  not on any 400, which also covers a malformed request.
- **A short voice note drew a short waveform.** The bars were one per
  recorded level, so a two-second note was a stub and a minute was a solid
  block. Every note now draws the same width, resampled to fit; only the
  speed of the fill differs.
- **"+ALT" on photos attached to a message.** Descriptions are a post
  feature; the message composer no longer offers one.
- **The conversation list said "You:" and nothing else.** It was never sent
  a message's attachments, so a voice note or a photo was blank. It reads
  "Voice note", "Photo", "Photos", "Video" or "GIF" now. Times read as a time
  today, "Yesterday", a weekday this week and a date after that, in the
  phone's language. Your own last message says "Sent" or "Seen" beside it.
- **A link pasted and sent at once went without its card.** The card is
  read on the sender's phone, and the message left before it was ready. Send
  now waits up to four seconds for it, with the message already showing, and
  the composer shows the link being read. The page is asked for as a link
  previewer, which more sites answer.

- **A link card with no picture broke the feed.** The card's picture-less
  row was stretched to the height it was given, and a scrolling list gives
  none, so every title-only card failed to lay out. It is as tall as its
  words now.
- **"1 followers" and "1 Followers".** Explore, the mention picker,
  community tiles and the profile all say one follower, member or post in
  the singular. The profile's label is in all 69 catalogs.
- **Dates and labels were unreadable on a chat wallpaper, and replies had a
  white ring.** Times, "You replied", receipts, the encryption notice and
  "New messages" sit on a small pill of the page's colour when there is a
  wallpaper behind them. The ring that set a reply apart from its quote is
  drawn only on the plain page, where it is the page's colour.
- **A voice post was taller than the reply box, and its fill moved in
  steps.** The player is now the reply box's height, with the play icon
  alone in the text colour. The fill is clipped at exactly how far playback
  has got and read every frame, so it runs through the middle of a bar like
  a progress bar instead of jumping a bar at a time. In a chat bubble it is
  held to 48 points.
- **The picture and clip buttons sat far apart.** Every IconButton reserves
  a 48-point target around itself; side by side that was the gap. Both
  composers shrink-wrap their buttons now, and the reply box has one gallery
  button (photos and clips in one picker) and a GIF button, which replies
  could not carry before.
- **A reply's name sat low beside its avatar**, centred in the menu button's
  height. The header is the height of its own line.
- **Scrolling near the top of a chat could jump the view** by however much
  the list's length estimate changed, whether or not older messages were
  being loaded. It only makes room when a load has actually started.

- **Every toast underlined its words in double yellow, in the wrong font.**
  Toasts are drawn on the root overlay, above every screen's Scaffold, where
  nothing supplies a text style, so Flutter fell back to its debug one. The
  toast now carries its own (transparent) Material. A test reads the style
  the words are drawn in.
- **A community post in the feed only led to its author.** The community's
  picture in the stacked avatar opened the author's profile, and the
  community line above the name was a target the size of its letters. The
  picture now opens the community and the author's face opens the author;
  the whole community line is the target, with a chevron saying it goes
  somewhere. The post's own page now shows the same header, which it never
  did, so it is no longer a dead end on the way to the community.
- **The community composer was a form with a screen of nothing in it.** The
  field took the theme's filled box and blue focus ring at four lines tall,
  and attachments were pinned to the foot of the screen, far from the words.
  It is writing on the page now: who will see it at the top, the words, the
  pictures right under them, and the tools on a toolbar behind a hairline. A
  tap anywhere on the blank page puts the caret in the box.
- **The reply boxes under a post and a comment were twice the size of what
  they hold.** Two full-size icon buttons stood in front of a form field
  with a 44-point floor and a focus ring. Both screens now share one reply
  bar built like the chat composer: a one-line pill, the picture and clip
  buttons inside it until something is typed, and Send at the end.

- **The Android release build still failed, on a manifest it could not
  parse.** The comment explaining the SDK 28 cap contained a double hyphen,
  which XML forbids inside a comment, so the manifest merger rejected the
  whole file. The comment is reworded. A test now checks every comment in
  the Android and iOS XML and plist files, and the fix was checked against
  the real merger (`:app:processReleaseMainManifest`): it fails on the old
  manifest and passes on the new one.
- **The Android release build failed after "Save to device" was added.**
  The app declared WRITE_EXTERNAL_STORAGE up to SDK 29 and
  camera_android_camerax declares it up to 28; the manifest merger refuses
  two values. 28 is all saving needs: gal asks for no permission on Android
  10 and later unless it is saving into an album, and the app names none.
  The legacy-storage flag, likewise only for albums, is gone. A test now
  holds the app's permission caps to every plugin's, so this fails in
  `flutter test` instead of only in the APK build.

- **"Nothing matched" sat a third of the way across the screen.** Every empty
  state was placed at the left edge, as wide as its widest line, so one whose
  detail wrapped looked centred and a short one did not. They are centred
  across their width now, wherever they appear.

- **Photos under a post were narrower than the post, off-centre, with square
  corners.** The four-photo square reused the two-across row, which keeps its
  own 16:9 shape, so inside the square each row shrank and centred itself.
  Every grid -- posts, the post page, quotes, comments, messages -- now shows
  at most three tiles, the third darkened with "+n" for the rest, and fills
  its width. A post or a message can carry ten attachments (was four); a
  comment stays at four.

- **The composer said attachments had failed the moment one was added.**
  "Those attachments did not upload" was shown whenever nothing had finished
  uploading, which includes a photo still on its way. It now waits until
  every attachment has actually failed.

- **After an update every message read "This message cannot be read on this
  device", and new ones went out unencrypted.** Opening the app more than an
  hour after last using it -- which an update does -- finds the access token
  expired; the launch refreshes the session and was marked signed in without
  reading the message key, so nothing could be opened and nothing sealed.
  The key had been in storage the whole time. Every way into a signed-in app
  now starts the same things (the message key, the identifier, the push
  token, which that path also skipped), and the vault reads the stored key
  itself if nothing has unlocked it -- reading only, never making one.
  Messages already sent in the clear on that path stay as they were.

- **Photos in a chat came framed in the bubble's colour, four to a square.**
  A message's pictures are now their own rounded block, above any words, with
  at most three tiles; past three, the third is darkened with "+n" for how
  many more there are, and opens all of them. Posts keep their grid of four.
  A message of photos alone no longer carries the open lock: there is nothing
  in it to seal.

- **A deploy could hang at boot with nothing in the log.** On 11 October the
  API deploy printed nothing after `start.sh` began and was killed by Render
  eighteen minutes later; the database logs show the new instance never
  connected. `start.sh` promised the server would start whatever happened, but
  nothing bounded the migration step. Migrations now get `MIGRATE_TIMEOUT`
  seconds (default 180) before the server starts without them, Prisma runs
  from `node_modules` instead of through `npx`, and each step says it is
  starting, so the next hang names its step.

- **Messages arrived as "This message cannot be read on this device."** Each
  message was sealed under whichever single key the server listed first, and
  the list included the sender's own key and had no order. When the sender's
  came first, the message was sealed with a secret only the sender could
  compute: they read everything they sent, and the person they sent it to read
  none of it. Messages are now sealed once and the key wrapped for every
  device in the conversation — the other person's and your own — in a new
  `k2` format that also opens without a network request. Messages already
  sealed the wrong way stay unreadable to their recipient; the key that would
  open them exists only on the sender's phone. `docs/E2EE.md` has the detail.

- **No notification while the app was in the background.** A push was sent
  only to people with no socket open, but Android keeps a backgrounded app's
  socket alive for minutes, so a message that arrived with the screen off went
  to a socket nobody was looking at. Every push is sent now, and the phone —
  which hands a notification to an app that is in front instead of showing it
  — decides. `GET /health` also says whether push is configured at all, since
  without `FCM_SERVICE_ACCOUNT_JSON` nothing is delivered and the only symptom
  is silence.

- **The conversation list showed sealed messages as ciphertext** — `k2.` and
  a few hundred characters of base64 under the person's name. Each preview is
  now opened on the device, without fetching anybody's keys; one that cannot
  be opened reads "Encrypted message". The key is also waited for while it
  loads after sign-in, where previews and messages opened in that moment used
  to be drawn as unreadable.

- **Long messages in Japanese, Hindi, Arabic and other scripts would not
  send.** The 4,000-character limit was applied to the sealed body, which is
  several times longer than what was typed when a character takes three bytes.
  The limit is now on what is typed, and sealed bodies have their own ceiling.

### Added

- **How the rooster was made, and how to make another.**
  docs/ROUNDED_PIXEL_ART.md is the style written down -- the rooster's
  measurements, the design rules for choosing and framing a subject, how
  to put a new picture in the app with the same arrival -- and
  `scripts/rounded_pixels.py` turns a cut-out into one, with each step
  available to look at.

- **See who is online.** A green dot on the picture of anybody you message
  who has Kyron open, in the conversation list and at the top of the
  conversation, where "Online" takes the place of their handle. Online
  means the app is open and in front: the app tells the server when it goes
  to the background, because a phone keeps its connection for minutes after
  that. Only the people you have a conversation with can see it, never
  across a block, and leaving takes fifteen seconds to show, so changing
  networks does not make the dot blink. **Show when you're online** in
  Messages settings turns it off, and off is mutual, as with read receipts:
  you see nobody's either. A reconnecting app is sent who is online now
  rather than trusting what it last heard.

- **Toasts that open what they are about.** "Posted" (from the composer
  and from a community) has **View**, which opens the post; "Draft saved"
  has **Drafts**; a conversation restored from Hidden, or a share sent to
  one person, has **Open**; a filed report has **View**, which opens it.
  A toast with a button stays five seconds rather than two and a half, so
  there is time to reach it. The others -- copied, muted, hidden, failures --
  are about something already in front of you, or nothing, and stay as they
  were.

- **New messages show on the Messages tab.** A red count of unread
  conversations sits on its icon, in the bottom bar and the side rail. It
  was fetched and kept fresh by the socket all along, and drawn nowhere, so
  the only way to know was to go and look. Reading a conversation brings it
  down, and coming back to the app re-asks, since anything that arrived
  meanwhile came as a push rather than over the socket.

- **Community settings.** A gear on Communities opens them: whether posts from
  your communities also appear in Home (held by the server, and it governs
  both Home tabs; a new `User.communityPostsInHome` column, `GET` and
  `PUT /communities/settings`), whether the list shows new-post counts, and
  the communities you run, each one tap from managing it.
- **New community as a page of its own**, opened from the bar at the top of
  Communities, showing the address while the name is typed. It was a sheet
  behind a floating button that the keyboard pushed half off the screen.

- **Message settings.** A gear on Messages opens them: read receipts (held by
  the server and reciprocal: off means nobody sees yours and you see nobody's),
  whether the other person sees you typing, and link previews. A new
  `User.readReceipts` column; `GET` and `PUT /messages/settings`.
- **A new message button.** Messages had no way to start a conversation; it
  took finding the person's profile first. The new screen offers the people
  you already talk to and searches everyone else.

- **Link previews in messages, without the server seeing the link.** A post's
  card is read by the server; a direct message is sealed before it leaves the
  phone, so its card is made on the sender's phone instead: the page is read
  there, its picture cut to the card and shrunk to a small JPEG, and the whole
  card sealed beside the words in a new `Message.linkCard` column. Readers
  never contact the linked site. A card only draws for a link that appears in
  the message's own words, the sender can take it off before sending, and the
  server refuses an open card beside sealed words. Documented in
  docs/E2EE.md.
- **Sharing into Kyron from other apps (Android).** Kyron is in the share
  sheet for text, links and pictures. A sheet like Threads' opens: what is
  being shared, a search, then Post and the people most recently talked to,
  ticked as they are tapped, with a line of one's own and Send. Post opens
  the composer with the share in it; Send writes to everybody ticked, sealed
  like any message, with a link card for a shared link. People not talked to
  yet are found by searching. iOS needs a share extension target and is not
  built.
- **A long-pressed message floats.** The chat blurs behind it, the message
  stays sharp where it was, the quick reactions sit above it and Reply, Copy
  and Delete below. A message near the bottom moves up to make room. This
  replaces the sheet that covered the message it was about.
- **Voice notes in direct messages.** With the box empty, the button where
  Send goes is a microphone: it opens the recorder already listening, and
  the note is sent as its own message, answering whatever was being
  answered. The bubble appears at once and plays from the phone while it
  uploads; a failed one retries with the recording rather than as an empty
  message. Like photos, voice notes are stored unencrypted (docs/E2EE.md).
- **A tap on a quoted message goes to it.** The thread pages back until the
  original is loaded, scrolls it into view and points it out -- it swells a
  little and settles under a tint that fades. A quote of a deleted message
  says it is gone.
- **A conversation details page**, from the menu in the chat's header: the
  person, Profile / Mute / Wallpaper, the photos, clips and voice notes
  shared in the conversation (with a full page of them), mute, report, block
  and remove. Blocking or removing there closes the thread as well.
  `GET /messages/:id/media` pages the shared attachments by message.
- **Chat wallpapers**, per conversation and per phone: five built in (four
  quiet washes with light and dark versions, and a dot texture) and any
  image dropped into the `wallpapers/` folder of the media bucket, listed by
  `GET /messages/wallpapers` without a release. The picker previews the
  choice on two sample bubbles.
- **The post author's like on a reply** shows as their face with a heart
  beside the reply's menu. Comments carry `authorLike`, read for a whole page
  in one query; the author sees it the moment they like a reply.

- **Uptime history on the service status screen.** The API checks itself
  every five minutes while it runs -- that it is up, that the database
  answers, that Supabase Auth answers -- and keeps a count per component per
  day, with an incident for each run of failures (`GET /health/history`).
  The screen opens with one line on whether everything works (amber, naming
  what is failing, when an incident is open even though /health is fine),
  then a bar a day for the last sixty days per component with its uptime,
  the recent incidents, and the details it showed before. A day with no
  checks -- the service asleep or down, which it cannot tell apart -- is
  grey, never green. In all 68 catalogs.

- **Save to device, from the media viewer.** A ⋯ button in the viewer's top
  bar opens a sheet with Save to device, Share and Copy link. Saving
  downloads the photo, GIF or clip and adds it to the phone's photos (`gal`;
  no permission on Android 10 and later, storage on 9 and below, add-only
  library access on iOS). The count -- now "2 / 4" -- sits at the exact
  centre of the bar; it was pushed to one side by one button on the left
  and two on the right. In all 68 catalogs.

- **A camera in a chat's attachments.** "Take a photo" opens the camera and
  sends what it takes, scaled to 2048 px at 85% quality rather than the
  4–12 MB a phone's sensor produces. In all 68 catalogs.

### Changed

- **Explore is one page, and shows what people post.** It was three tabs --
  hashtags, a topic catalogue, people -- and all three were thin: the
  catalogue had never been filled, almost every "trending" tag had been used
  once, and the people were a tab away. Meanwhile two posts in three carry a
  picture or a clip, and Explore showed none of them. Now: a search box;
  people to follow and communities to join, as short sideways strips you can
  act on without leaving; the tags actually in use lately, shown only once
  there are three used at least twice; and below, an endless three-column
  grid of photos and clips from across Kyron (new `GET /feed/explore`), with
  people you don't follow yet first and the best of the last few days ahead
  of the rest. Topics are gone from Explore until there are topics to show.

- **Community cards are calmer.** About half the height: a smaller picture,
  the name, members and your role, the newest post with how many are new,
  and a Follow-sized button to write there. The "Last post" time at the foot
  is gone, and so is Open, which did what tapping the card does. Discover
  cards share the same header, with a Join button that is the Follow button
  in all but the word, and what the community is for under it across the
  card's width -- so a long description no longer makes one card twice the
  height of the next and leaves Join floating. The filter chip is hidden in
  Discover, where it filtered nothing.
- **One size for small buttons.** The chips over Messages and Communities
  (filter, Hidden, Discover) and Edit profile and Share on your own profile
  are the size of the Follow button on anybody else's.

- **The welcome screen's buttons and edge.** The Google button is a solid
  pill -- black on the light screen, light on the dark one, in Google's own
  colours -- at the same height as the email button under it. The rounded
  card with a shadow under the picture is gone: the ways in sit on the
  picture's own off-white, meeting it at a straight edge between two rows of
  the rooster's squares. On a wide window they keep a phone's width.
- **The rooster loops.** It arrives from the eye outward, holds for four
  seconds, leaves the way it came and arrives again; still, as before, for
  anybody who has asked their phone not to animate.

- **The welcome screen's picture is a rooster in big rounded pixels.** The
  meadow of cut-out photographs -- fronds, grass, lavender, a tulip and two
  butterflies -- is gone, with its six images and the script that cut them.
  The rooster is the artwork itself, shipped losslessly so its colours are
  exactly the artist's, on its own off-white in both themes, anchored top
  right so the bird looks into the space on the left and the comb, head and
  wattles always fit. The first time it shows, it arrives square by square
  from the eye outward and settles into the exact picture; all at once for
  anybody whose phone asks for less motion. The status bar icons go dark over
  it in either theme.

- **Communities is a page of cards.** Each community you are in is a card:
  its picture in a tile, the name, "Members: 12" and your role, the newest
  post ("Ada: ...", "You: ...", or "Photo" for a post with no words) with a
  count of what is new since you last opened it, and at the foot when the
  last post was, a Catch up / Open button and a button to write in it --
  filled when there is something new, outlined when there is not. Discover is
  a shelf of smaller cards with a description and a Join pill. The busiest
  community is at the top; a filter menu (All, New posts, Yours to run) and a
  Discover chip replace the two tabs, with a search box over both. Opening a
  community clears its count (`PUT /communities/:slug/read`, a new
  `CommunityMember.lastReadAt` column). Previews follow the same blocks,
  mutes and hidden posts as the community's page. There is no separate feed
  of community posts: Home already carries them, and the cards say what is
  new. Names that would collide with the app's own routes (mine, discover,
  settings) can no longer be taken.

- **Messages has a filter menu and a Hidden chip instead of All and Unread
  tabs.** The menu picks All, Unread or Unanswered (the conversations whose
  last word is the other person's), and there is a search box. Hidden lists
  the conversations you removed from your list, and a swipe puts one back
  (`PUT /messages/:id/restore`). Filters go to the server as `filter`;
  `unreadOnly` still works for older builds.

- **The wallpaper picker previews before it changes anything.** The
  preview stays at the top while the choices scroll; tapping one previews it,
  ringed in the accent, and Apply at the top right is what sets it. The one
  in use carries a "Current" tag, so the two are never confused. The folder's
  wallpapers load behind skeletons, and files named by a machine have no
  caption.
- **The chat composer has room round it.** Twelve points on every side and
  sixteen below, and eight between the box and its buttons.
- **Profile share and message buttons are filled circles** with the hairline
  outline, the height of the Follow button beside them.
- **A voice note's played bars are the text colour**, black in light mode,
  rather than the accent.
- **Outlines inside a post are hairlines.** A quoted post, a link card and a
  voice post were outlined a full logical pixel at a darker tone -- heavier
  than the rule between whole posts. They now share that rule, from one
  definition (`postRule`), so a card can never outweigh the line between
  posts again.
- **A voice post is a card, not a pill.** The same corner as a post's
  pictures and the same hairline as its quotes, a solid play button the
  size of the other small controls, and a waveform as tall as the button. In
  a message bubble it draws no card of its own, since the bubble is the
  frame, and in your own accent-filled bubble it is drawn in the bubble's
  ink rather than in the accent it sits on.

- **The chat screen is laid out the way Threads and Instagram lay one out.**
  Bubbles are pills; one person's messages with no pause between them stack
  tight and tuck their corners in where they meet, so a run reads as one
  column; the time is a centred line above a turn after a pause of fifteen
  minutes or a change of day, instead of under every run; "Sent", "Seen" or
  "Sending…" appears once, under your newest message. The box is one line of
  text tall, with no focus outline and no heart beside it — Send is always
  there, dimmed until there is something to send — and stops at the 4,000
  characters the server takes. A message that cannot be opened says so in
  italics. A message of emoji alone is drawn larger: one is four times body
  text. The lock under every run is gone; the thread says once, where
  encryption starts, that messages are end-to-end encrypted, and marks any
  later message that was not. New strings are in all 68 catalogs.

### Added

- **Reactions, "is typing", and "New messages" in chats.** Double-tap a
  message to heart it, double-tap again to take it back; long-press for six
  quick reactions above the usual actions, where choosing your current one
  again removes it. Reactions sit on the bubble's lower corner as one small
  pill — "😂 2" when you both chose the same one — and a tap on your own
  takes it back. One reaction each per message, replaced rather than stacked.
  They are on screen at once and put back with a message if the server
  refuses. Reactions are stored readable on the server, unlike the messages
  they sit on — a decided trade, in `docs/E2EE.md`.

  While the other person writes, three dots appear at the foot of the
  thread. They go when the message arrives or a few seconds after the typing
  stops, with no "stopped typing" signal to lose, and hold still for anyone
  who has asked their phone for less motion. Your own typing is sent at most
  every three seconds. Neither reactions nor typing ever cause a push.

  Opening a thread with unread messages draws "New messages" above the
  first one, and it stays where it was after the thread is marked read.

- **Chats that work the way people already chat.** Pull a message sideways
  to answer it: it follows the finger, the phone ticks at the point where
  letting go replies, and short of that nothing happens. A reply is drawn the
  way the messaging apps people use draw it — "Ada replied" above, the message
  being answered muted behind, and the answer over its lower edge — through
  a small render object, because no stock layout can overlap two things and
  be the height of both. A message of one to three emoji and nothing else is
  drawn large and without a bubble, counted in grapheme clusters so 👩🏽‍💻 and
  🇳🇬 are one each and © is not one at all; emoji among words stay the size of
  the words. A run of messages from one person shares one avatar and one time,
  instead of a timestamp under every line. An empty conversation shows the two
  of you and offers a one-tap wave instead of the app's generic empty state.
  The composer puts every attachment behind one button, keeps a photo and a
  GIF a tap away inside the box while it is empty, and stands a heart where
  Send goes until there is something to send. GIFs can be sent in messages
  for the first time, through the same picker posts use. Every new label in
  the chat is translated into all 68 languages the app ships a catalog for.

- **A language system: App language, Primary language and Content
  languages.** One searchable sheet serves all three and the get-started
  screen, over a catalogue of 69 languages that each carry their own endonym
  — Kiswahili, Yorùbá, isiZulu, 日本語 — and know whether they are read
  right to left. Search matches the endonym, the English name and the code
  alike, so "German", "Deutsch" and "de" all find the same row. **The list is
  a starter set, not a finished one:** adding a language is one line, and
  nothing depends on its length or order.

- **The App language setting now changes something.** It was a stored code
  and nothing else — no localization delegates, no `supportedLocales`, no
  `locale`, and not one `.arb` file in the tree — so the picker moved and the
  app stayed in English whatever it said. Flutter's own strings now follow
  the choice in every locale it ships, dates and numbers are formatted for
  it, and the whole layout mirrors for Arabic, Hebrew, Persian and Urdu.
  Kyron's own words still need a translator; the screen says so rather than
  implying otherwise.

### Removed

- **Kyron Points.** `POST /profile/kp/award` took an account id and an amount
  from the request body and checked only that the caller was signed in, so
  any account could give any account — itself included — any number of
  points. That would have been a curiosity if the number did nothing, but
  people search ranked by it, so the top of every search was for sale at no
  price. The programme behind it had already been withdrawn in public. The
  award route, the history and the unauthenticated leaderboard are gone; no
  profile, list or search response carries a count any more; and the app no
  longer shows one on profiles, in the drawer or beside people in lists.
  The `kyronPoints` column and the `KyronPointEvent` table are still in the
  schema, unread and unwritten: dropping them is a migration, and migrations
  run against production on boot.

- **`bullmq`, which nothing imported.** It appeared once in `package.json`
  and nowhere else in the repository. The media queue is a Postgres table
  claimed with `FOR UPDATE SKIP LOCKED`, deliberately: an encode runs for
  tens of seconds, a deploy lands in the middle of one regularly, and work
  held in memory would vanish with nothing recording that it had. A
  dependency that implies infrastructure the project does not run is worse
  than a missing one.


### Fixed

- **Encrypted messages arrived on the lock screen as ciphertext.** The push
  for a new message carried the message body, and the phone's notification
  system shows a push without asking the app — so every sealed message was
  announced as `k1.Zx9f…`, and every unsealed one went through Google's
  servers in the clear. `docs/E2EE.md` had described only the second half.
  A message push now says who it is from and "Sent you a message" or "Sent
  an attachment", and nothing else.

- **A fresh install could not get through its own quickstart.** Two
  separate faults, the second hidden behind the first, and neither visible
  on the deployed database because that one is Supabase's and was created
  from the schema rather than from the migrations. First, two migrations
  revoke access from Supabase's `anon` and `authenticated` roles, which a
  plain Postgres does not have, so `prisma migrate deploy` stopped at
  `20260907200000_device_tokens`; the quickstart's Docker database now
  creates both, empty and unable to log in, from
  `infra/postgres/init/01-supabase-roles.sql`. Second, the migrations had
  only ever created `User.password` as NOT NULL while the schema and the
  auth guard both treat it as optional, so on such a database every sign-up
  failed with "Your sign-in is valid, but Kyron could not set up your
  account on this server." A migration relaxes it — a no-op on the deployed
  database. Both reproduced on a Postgres with no Supabase roles, and both
  checked fixed there by provisioning an account through the guard's own
  code.

- **People search did not do what it said.** The comment above the query
  promised an exact handle first and then the most-followed matches; the
  query sorted by Kyron Points and nothing else. Type a whole handle now and
  that account comes first, even when better-followed near-misses would have
  filled the page without it; everyone after it is in order of followers.
  Checked against a real Postgres, where an account with no followers and a
  million self-awarded points had been coming first.

- **The interest chips, the other person's chat bubbles and the post
  analytics tiles were too loud.** The fix that made them visible at all
  overshot: measured against a reference, a container sits about 2.4 L\* off
  its page, and the top of the ramp that shipped was 8.24 L\* below white in
  a blue-grey of its own. Two things were wrong with it — it got *bluer* as
  it got darker, because the steps were a slate scale rather than equal
  moves in lightness; and every step was roughly three times too big. The
  ramp is rebuilt in the design system (KyronLabs/design-system#13), and the
  three places named here now take `surfaceContainer` — the quietest step
  that still gives a shape an edge — rather than the top of the ramp. A
  chat bubble is the most repeated shape in the app; `Highest` is for
  something there is one of.


### Added

- **Send Feedback files a real issue.** The screen used to say "Feedback has
  nowhere to go yet", which was honest and useless. A bug or an idea written
  in the app now opens an issue on the repository, and the reply gives the
  issue number. The GitHub token lives on the API and never reaches the
  phone — a token shipped inside an installed application is one anybody can
  read out of it, and this one carries write access. The form says, above it,
  that the issue is **public**; nothing identifying is added to what gets
  written — no account id, no handle, no email. Set `GITHUB_ISSUE_REPO` and
  `GITHUB_ISSUE_TOKEN` to turn it on; without them the app asks the API first
  and says so on the screen, rather than taking a report and dropping it.

- **An Appearance setting that works.** Light, Dark, Dim, or whatever the
  phone is set to, in a sheet. It replaces a "Dark Mode" switch that sat next
  to a `// TODO: Apply theme change immediately` while `main.dart` passed a
  hard-coded `ThemeMode.system` — so the switch moved, remembered nothing, and
  changed nothing. Dim is the design system's third palette, a blue-grey dark
  rather than a black one, and had never been reachable from the app at all.

- **Data Saver stops videos playing by themselves.** It is remembered across
  launches and it takes effect on whatever is already on screen, not at the
  next scroll. Tapping a clip still opens and plays it: the setting holds back
  the traffic nobody asked for, not the traffic they did.

### Changed

- **The GIF picker is on GIPHY.** Tenor has stopped taking new sign-ups, so a
  `TENOR_API_KEY` cannot be obtained any more and the picker would have been
  permanently off in every build made from here on. Pass `GIPHY_API_KEY` at
  build time instead. GIPHY's free tier requires its mark to be shown wherever
  its results are, so the picker draws **Powered by GIPHY** under the grid.

- **Leaving a community is behind a question.** "Joined" was a button whose
  only action was to leave, in the header of a page somebody reads every day —
  one stray tap dropped them out, with no warning, and the button then read
  "Join", which looks like a failure rather than like it worked. It is in a
  menu at the top of the banner now, with share, copy link and Manage, and it
  asks first. Join is unchanged for anybody who has not joined.

- **A community's compose button is the one from the page before it** — the
  black disc the Communities page carries, centred, rather than a stock blue
  Material button in the bottom-right corner over the last post in the list.

### Removed

- **Three settings switches that could not have done anything.** Each was a
  `bool` the settings screen kept to itself, described in its own code as
  "local state for toggles (batch save on exit)" with no save on exit — so
  every one of them reset on the way out, and nothing anywhere read any of
  them.

  - **Private Account** ("Only followers can see your posts") — there is no
    such field on the account, in the schema or in the API, and no code path
    that checks one. Every post stayed exactly as public as it had been. A
    privacy promise the system cannot keep is worse than no promise, so it is
    gone rather than left looking like protection.
  - **Location** ("Allow location access") — there is no geolocation package
    in the app and no location permission in the manifest. It granted nothing
    and denied nothing.
  - **Auto-Download** — the same concern as Data Saver under the opposite
    name, with no answer at all for a phone that had both switched on. Data
    Saver is the one that survives, and now does something.

- **A hidden gesture that announced a reset and reset nothing.** Every
  settings row answered a horizontal swipe with "Reset <row> to default" in a
  snackbar — including the rows that only navigate, so it claimed to have
  reset your login settings. It also swallowed the swipe that goes back.
  (Its comment said "swipe left"; the condition it shipped was a swipe right.)

### Fixed

- **A report could be lost to a version lookup.** Sending feedback waited on
  `PackageInfo.fromPlatform()` before it sent anything, so a platform that was
  slow to answer, or a plugin that was not registered, took somebody's three
  paragraphs with it. The version is read while the form is being filled in
  now, and is best-effort: a report filed without a version number is worth
  less to whoever reads it, and one not filed at all is worth nothing.

- **The GIPHY key was not passed to any build.** `GIPHY_API_KEY` is read with
  `String.fromEnvironment`, which means it has to be given at build time, and
  no workflow gave it — so the picker would have shipped switched off in every
  release and debug build. Both workflows pass it now, on Android and Windows,
  from a `GIPHY_API_KEY` secret.

- **Sending feedback is capped at five reports an hour per account.** The
  API's own limit is 100 requests a minute, which is the right order for
  reading a feed and the wrong one for opening issues on a public repository.
  Hitting the cap says so plainly and says nothing was sent, rather than
  reading as a failure that invites writing the same report again.

- **Every top bar turned faintly blue when a list scrolled under it, and only
  then.** `elevation: 0` does not cover it: Material 3 keeps a *second*
  elevation for the scrolled-under state and washes the bar in `surfaceTint`
  — the primary colour — at anything above zero. Both are off now, and a
  hairline appears under the bar in the tint's place.

- **The interest chips, the other person's chat bubbles and the post analytics
  tiles had no colour of their own.** Measured at **1.00:1** against the page
  behind them — identical, not close. Flutter falls all four Material 3
  container roles back to `surface` when a ColorScheme is built without them,
  and all three of Kyron's were, so *every* container in the app was drawing in
  the background colour.

- **The composer had no Post button, and Drafts sat on top of the close
  button.** One cause for both: the design system's button themes set
  `minimumSize: Size.fromHeight(40)`, which is Flutter's way of writing
  *infinite width*. An app bar's actions row hands its children an unbounded
  width, so the button asked for an infinite one, failed
  `BoxConstraints.debugAssertIsValid`, and was never drawn — and the toolbar it
  broke put everything else in the wrong place. The community composer's Post
  button had the identical defect.

- **The in-app browser's icons are outlines.** All eleven were the filled
  weight, in an interface drawn entirely in outlines. The add-new-interest
  button and the topic picker's tick follow. Icons that are filled to mean a
  *state* — a liked post, the selected tab, a playing video — are left alone.

- **The floating action buttons were a white glyph on a white disc.** Measured
  at **1.06:1** on the light theme. Material 3 draws a `FloatingActionButton`
  in `primaryContainer` on `onPrimaryContainer`; the design system set the
  first and left the second unset, and an unset `on*` is not derived from its
  pair — it comes back pure white. Fixed at the source, with contrast tests
  and the CI that repository had never had; the app now pins that commit.
  Kyron's accent with a white glyph, 3.14:1.

- **The icons on the community page's banner controls were never drawn.**
  `_GlassButton` took an `icon` and rendered an empty 40-pixel box inside a
  black disc — so back and Manage showed, worked, and were invisible.

- **The community picture now sits exactly halfway across the banner's
  bottom edge.** It hung 28 of its 86 pixels below — a third — which reads as
  a picture that slipped rather than one that was placed.

- **The community page's floating button was inside the home indicator.**
  `endFloat` places it 16 above the *body*, and that body runs to the bottom
  of the screen, so on a 34-pixel gesture inset it landed 32 up — two pixels
  into the system's own strip. It is 16 clear of it now, and 16 from the right
  rather than 24.

- **Both community buttons drew filled glyphs.** Kyron's are outlined. On the
  Communities tab the button sat directly above the bar's own create button,
  the two showing the same plus in two different weights.

- **The README and the ROADMAP called the AR camera unbuilt.** It sat under
  *Not built yet* in one and *Stubs shipped as if finished* in the other,
  while the cell beside each heading described lenses that work: colour
  lenses, attachments that follow a face, effects that change one. Seven ship
  in the app, four more in the catalogue across all three schema versions, and
  208 tests cover them. Both entries were written before the AR work landed
  and nobody moved them.

  That is the same staleness as an overclaim and harder to notice, because a
  document that undersells itself does not read as a lie. The ROADMAP has a
  section about the README once overclaiming; it now records this, pointing
  the other way.

- **The README said the API is deployed to Fly.io.** It runs on Render.
  `api_client.dart` points every phone at `kyron-47r6.onrender.com`, that host
  answers `/health`, and `kyron.fly.dev` does not resolve. `api/fly.toml` is
  still in the tree and is what `docs/OBSERVABILITY.md` and
  `docs/PERFORMANCE.md` reason about when they say "one process" — worth
  knowing before trusting either.

- **The ROADMAP's test counts were 667 and 443.** They are 851 and 458.

- **The home feed carries posts from the communities you are in.** It filtered
  every community post out, so joining one meant remembering to go and look at
  it. Posts from communities you are *not* in are still left out -- pushing
  them at everybody is what makes people stop posting in them.

  A post from a community says so: the community's picture with the author's
  avatar stacked in front of it, and its name above the author's, tappable
  through to the community. Without that, a post from a place you joined
  arriving in the home feed reads as somebody posting to everybody.

- **A community is a squircle now, everywhere.** It was drawn three different
  ways -- a rounded square in the list, a circle on its own page, nothing at
  all in the feed -- so the same place looked like a different kind of thing
  depending on which screen you met it on. One `CommunityAvatar`, one shape.

  The shape is `ContinuousRectangleBorder`, which is a superellipse. A
  hand-rolled one was written first and measured against it: sampling how far
  each outline reaches along the diagonal, the two agree to within 0.4% at
  every radius, so there was nothing to gain from carrying a second
  implementation of the same curve. What is kept is the radius rule, which is
  the part that was wrong -- `ContinuousRectangleBorder` rounds visibly less
  than a `BorderRadius` of the same value, and passing the tokens straight
  through is what made a "squircle" come out looking like a rounded rectangle
  with the corners shaved.

- **The community page has no top bar.** The banner is the top of the page
  now, filling the status bar rather than starting below a bar that carried
  the community's name a second time. The picture is stacked on the banner's
  bottom edge instead of sitting in a row underneath it, back and Manage
  float over the banner, and a community with no banner gets a gradient of
  its own rather than nothing -- without it the picture had nothing to hang
  off and the page jumped by eighty pixels between one community and the next.

- **You can tag somebody in a post.** The composer's tag button inserted a
  bare `@` and left the writer to remember a handle exactly, character for
  character -- and a handle that does not match an account is not a tag, it is
  grey text. It now opens a sheet that searches real accounts and writes the
  handle in, replacing a half-typed `@ad` rather than appending to it. Only
  accounts that have a handle are offered, because a mention is read back by
  resolving one. The community composer has the same button, which it did not
  have at all.

- **The community composer's box is four lines, not the whole screen.**
  `expands: true` inside an `Expanded` made the field the entire page, so the
  tools and the counter sat at the bottom edge a long way from the words.

- **A like turns red the moment it is pressed.** On a post's own page the
  animation played and then the heart sat grey for a second or two, until the
  server came back and the state was replaced wholesale -- so the one part of
  the gesture that says it worked arrived last. The page now shows the
  outcome immediately, reconciles it with the count the server returns, and
  puts the post back exactly as it was if the request fails. Save and repost
  worked the same way and were changed with it.

- **Loading no longer says you have no avatar.** Every top bar with a picture
  in it -- Home, Explore, Communities, Messages -- drew the fallback person
  glyph while `/profile/me` was in flight. That glyph is what Kyron shows an
  account with *no* picture, so on every launch it told everybody they had
  none until the request landed. It shimmers instead.

- **The sidebar's counts no longer pop in.** Its loading header was three
  still grey blocks that stopped at the handle, so the followers row arrived
  afterwards and shoved the navigation down. It is now the real header's own
  shape -- avatar, name, handle and all three stats -- shimmering.

- **The Videos wall loads behind tiles, not post rows.** The clips tab is a
  staggered two-column wall, and it loaded behind a column of paragraphs with
  avatars and engagement rows, then threw every bit of it away. New
  `SkeletonTileWall` draws the same two columns, gutters and corner radius as
  the grid that replaces it.

- **The full-screen clip feed shows a clip while it loads.** It showed the
  word "Loading" in the middle of a black screen, which is indistinguishable
  from a clip that never arrives. New `SkeletonClip` puts the rail and the
  caption where they are about to be, in tones that are visible on black in
  either theme.

- **The create-profile screen has the shape of Edit profile.** The two edit
  the same two pictures and the same two fields, and looked nothing alike:
  this one drew a 200-pixel banner with a 128-pixel avatar straddling it -- a
  profile header, on a form, taking most of the screen before a word could be
  typed -- over inputs whose only label was a hint that vanished the moment
  anybody typed into them.

  It uses the same `ImagesField` now, which grew an `avatarFile`/`coverFile`
  so it can show a photograph picked on the device before there is anything
  uploaded to point at, and the same labelled fields.

  The cover has two sources, so it asks in a sheet -- *Choose from gallery* or
  *Use one of ours* -- rather than the tooltip menu it had, which opened
  wherever the button happened to be with rows too small to hit on a phone.
  `widgets/camera_tooltip_menu.dart` is gone with it.

  So is **Generate AI**, which sat beside the camera button and called
  `debugPrint`. A control that does nothing is worse than no control: it is a
  promise. There was never anything behind it.

- **Google sign-in opened a browser instead of the account picker**, and then
  answered `Error 401: deleted_client`. One cause: the Firebase project
  `kyron-1` has no OAuth clients at all -- its `google-services.json` carries
  no `oauth_client` entries, so there is no web client for an ID token's
  audience and no Android client tying the signing certificate to the package
  name. `deleted_client` is Google saying the client id Supabase hands it no
  longer exists. Supabase's own end is fine; its settings endpoint reports
  Google enabled.

  Nothing in this repository can create those clients, so `docs/AUTH_GOOGLE.md`
  says exactly what to do in which console, including the SHA-1 of the
  committed development signing key and why a Play-signed build needs a
  different one.

  What this repository can do is stop reaching for a browser first.
  `lib/services/google_sign_in_service.dart` uses the platform's own picker --
  Credential Manager on Android, the sheet listing the accounts already on the
  phone -- and exchanges the Google ID token it returns for a Supabase session
  directly. No redirect, so nothing depends on `so.kyron.app://` being
  registered. A nonce binds the token to the attempt: Google is given the
  SHA-256 and Supabase the original, so the value never crosses the network.

  Where there is no picker, or where Google refuses for a configuration
  reason, it falls back to the browser flow and writes the reason to the log
  that About → System log shows. The browser at least ends on Google's own
  error page, which says something; a sheet that closes with nothing does not.

- **A new account could get stuck on the create-profile screen**, told only
  that "Kyron could not verify your sign-in (error 401). That is a problem on
  our end, not with your account." It was, and the message could not say which
  problem, because three quite different faults reach the client as 401 and
  the client threw the server's own explanation away.

  The one that bricks an account: the API mirrors every Supabase account as a
  local row so the rest of the schema has a `User` to relate to, and
  `username` on that row is unique. Sign-up puts the handle somebody chose
  into the token's metadata, so if another account already holds it the
  `INSERT` fails, the recovery read finds nothing, and the guard answered 401.
  There is no way forward from there: the handle is fixed in the token, so
  every retry fails identically. A handle is optional and can be changed from
  Edit profile; an account is not, so provisioning now drops the handle and
  says so in the log rather than refusing the sign-in.

  What is left after that is this server failing to write a row, which is not
  something wrong with the caller's credentials. It answers 500 now, with a
  sentence saying the sign-in is valid and the account setup is not -- rather
  than a 401 that sends somebody back to a login screen that cannot help them.

  And the client shows what the server said. "Missing or invalid token",
  "Invalid or expired token" and "Could not resolve account" are three
  different problems with three different fixes, and all three used to arrive
  as the same sentence about error 401.

- **`GET /health` now reports whether the API's JWT secret is the one the
  project actually signs with.** A wrong `SUPABASE_JWT_SECRET` leaves the
  issuer right, the algorithm accepted and the key set reachable, and refuses
  every sign-in anyway -- one 401 per request, which on a phone reads as the
  account being rejected. Nothing anywhere could see it.

  A Supabase project's own API keys are themselves JWTs signed with that same
  secret, and the API already holds one, so it can check its configuration
  against a key it has rather than waiting for a token from a user. The
  verdict is on `/health` and in the boot log, and names the setting and where
  to copy it from. Neither the secret nor the key appears in either.

- The development APKs could not be installed. Android answered "App not
  installed as package appears to be invalid", which sounds like a corrupt
  download and was not: the file was a valid, correctly signed, correctly
  aligned APK. Two things were wrong with it, and both came from its being a
  **debug** build.

  It carried `android:debuggable="true"`. ColorOS, MIUI, Funtouch and several
  other OEM skins refuse a debuggable APK from an unknown source outright, and
  the message they show points at the file rather than at the flag.

  And it was enormous -- 114 MB for arm64, 190 MB universal -- because a
  Flutter debug APK carries the Dart kernel for the JIT (87 MB of
  `kernel_blob.bin`), the debug engine (39 MB of `libflutter.so`) and 15 MB of
  Vulkan validation layers that exist only in debug. Over a phone connection
  that is a download long enough to be interrupted, and a truncated APK fails
  with the same message.

  Both halves of the development build are release builds now, which is what
  the Windows half had been all along and for the same reason: a development
  build has to be one the people it is for can actually run. The comment next
  to the Windows build used to end "Android has no equivalent problem, so its
  APKs stay debug"; Android had exactly the equivalent problem. There is no
  `key.properties` on this path, so the APKs are signed with the development
  key rather than the store one -- which means a build from here and a store
  build cannot sit side by side, and that is deliberate.

  The APKs are renamed from `-debug-` to `-dev-` to stop the filename saying
  something untrue.

  Then the same six words came back, from a different cause. With no
  `key.properties`, `buildTypes.release` falls back to `signingConfigs.debug`,
  and a CI runner has no `~/.android/debug.keystore` -- so Gradle mints one.
  Four development builds, four certificates, each created minutes before it
  signed its own APK:

      build 74   CN=Android Debug   c718ffd874…   notBefore 12:48:15
      build 75   CN=Android Debug   d7c5155197…   notBefore 18:12:08
      build 76   CN=Android Debug   e44a62f0f6…   notBefore 19:14:26

  Android refuses an update whose signature is not the one already installed
  -- `INSTALL_FAILED_UPDATE_INCOMPATIBLE` -- and the OEM installers report
  that as "package appears to be invalid" too. It strikes on the *second*
  install rather than the first, which is why it read as intermittent. The
  workflow now takes a secret keystore when one exists and otherwise the key
  committed at `app/android/dev-signing/`, which is the state this repository
  is actually in. There is always a key: a build signed with one nobody has
  seen before is a build nobody can install, and "set a secret first" is not
  an answer a fork can use. `app/android/dev-signing/README.md` is the
  argument for committing it, including why it is safe and why that does not
  generalise.

  Checking what gets published is `scripts/check-apks.sh`, and both the
  development and the release workflow call it before they upload anything --
  a check that guards development builds and not releases is one that will be
  missing the day it matters. It fails a build that is debuggable, one whose
  signature no longer covers the file, one signed with a debug key or with
  anything other than the key it is pinned to, one where the four APKs out of
  a single build disagree with each other, and one past a size ceiling.

  And a third cause, found by reading the four APKs of build 78 rather than
  by guessing: they carried four different version numbers.

      armeabi-v7a  1078
      arm64-v8a    2078
      x86_64       4078
      universal      78

  `--split-per-abi` makes the Flutter Gradle Plugin rewrite each split's
  versionCode to `abi * 1000 + build`, and leaves the universal APK on the
  plain build number -- the lowest of the four. Android refuses a package
  whose versionCode is below the one already installed, so somebody who took
  the arm64 APK, hit the signature problem above, and then tried the universal
  one instead was refused a second time and told, again, that the package
  appears to be invalid. The scheme is for uploading several APKs to the Play
  Store, which this project does not do: it ships an `.aab` there and these
  APKs are sideloaded.

  Both workflows now build one `--target-platform` at a time, which produces
  the same four APKs at the same sizes, all carrying one version number.
  Keeping the sizes took a second fix, and two attempts. `--target-platform`
  restricts Flutter's own `libapp.so` and `libflutter.so` and nothing else, so
  every plugin's `.so` arrived for all three architectures: an arm64 APK
  carrying `libtensorflowlite_c.so` for x86_64. `ndk.abiFilters` is the
  obvious answer and is the wrong one to reach for, because the Flutter Gradle
  Plugin writes that field itself and where it writes it moved between
  versions. On `defaultConfig` it reported the right value at the end of
  configuration and changed nothing. On the build type it worked on Flutter
  3.35.5 and did nothing on 3.47.4 -- which is what CI resolves from the
  stable channel, so build 79 shipped four APKs 7 to 12 MB heavier than they
  should have been. Flutter is not pinned by this repository; the Android
  Gradle Plugin is, at 8.11.1, so the filtering is stated as a packaging
  exclusion in its terms instead, which no Flutter version touches and which
  therefore behaves the same locally and in CI.

  `check-apks.sh` reads the architectures back out of every APK and fails when
  a file does not carry what its name says. Against build 79's artifacts it
  refuses them by name.
  Undoing the rewrite afterwards is not possible -- the Android Gradle Plugin
  has finalised the property by then, and says so -- so
  `app/android/app/build.gradle.kts` refuses `--split-per-abi` outright with
  that explanation, `check-workflows.py` refuses it on the pull request, and
  `check-apks.sh` reads the versionCode back out of every APK before anything
  is published. The numbers are offset by 100000, so that the first uniform
  build is still above the 4078 already on anybody's phone rather than being
  a downgrade caused by the fix.

  It reads the signing certificate out of the APK Signing Block, which
  Android specifies, rather than out of `apksigner verify --print-certs`,
  which is prose. Reading the prose is how the first version of this check was
  written and it lasted one build: the runner image gained build-tools 37.0.0,
  which renamed `Signer #1 certificate SHA-256 digest:` to `V2 Signer:
  certificate SHA-256 digest:`, the pattern stopped matching, and a correctly
  signed APK failed with "got" followed by nothing. `scripts/apk-certificate.py`
  is the reader, and `scripts/test_apk_certificate.py` holds it to APKs signed
  all three of the ways Android defines.

### Added

- **Kyron now requires iOS 15.** It was 13, and `firebase_core` and
  `firebase_messaging` both require 15 -- CocoaPods refuses that combination
  before a line is compiled, so push on iOS was not a matter of configuration
  but of a build that could not start. Raised in all three Xcode
  configurations and in the framework's `MinimumOSVersion`. **iOS 13 and 14
  devices can no longer install Kyron**, which is the cost of it and was
  chosen rather than discovered.

  Nothing in CI builds iOS -- no runner, no signing identity -- so the number
  is guarded from Linux instead. `test/ios_deployment_target_test.dart` reads
  the same sources Xcode and CocoaPods do: every
  `IPHONEOS_DEPLOYMENT_TARGET` in the project, `MinimumOSVersion` in
  `AppFrameworkInfo.plist`, and the `ios.deployment_target` of every podspec
  in the packages this app resolved. It fails when the configurations
  disagree, when the framework minimum drifts from the project, or when a
  plugin asks for more than the project offers -- naming the plugins that do,
  so the next one to raise its floor in a routine upgrade is caught here
  rather than on somebody's Mac.

- Push notifications, end to end. The server half has been finished and
  shipped for two releases -- `PushService`, FCM HTTP v1, and a
  `DeliveryService` that picks the socket when the app is open and a push when
  it is not -- behind a token source that deliberately answered `null`,
  because a stub returning a made-up token would have looked exactly like push
  working. The source is now real: `FirebasePushTokens`, over
  `firebase_messaging`.

  It registers on sign-in and on every launch with a session, because a token
  can rotate while the app is closed and a server holding the old one pushes
  into nothing. Permission is asked for at sign-in rather than at launch: the
  question would otherwise land before anybody had seen a screen, and "no"
  from a stranger is permanent on both platforms.

  Every way this can come to nothing -- no Firebase on this platform, no
  `google-services.json`, a reader who declined -- answers null rather than
  throwing, and is said once in the log. None of them can stop the app
  starting, and none of them makes it behave as though this install were
  reachable when it is not.

  The configuration files are gitignored, so CI writes `google-services.json`
  out of a `GOOGLE_SERVICES_JSON` secret. A release **refuses to build without
  it**: the Gradle plugin is skipped when the file is absent, the APK builds
  perfectly cleanly, and every install from it is unreachable while the app is
  closed -- with nothing in the build output saying so. A development build
  tolerates the absence and says which it is.

### Fixed

- A push token stayed live after signing out. `PushRegistrar.stop()` withdrew
  the registered token but never cancelled its subscription to the platform's
  token-refresh stream, so the next rotation registered the handset again --
  against an account nobody was signed in to. The person holding that handset
  next would have received the previous account's notifications.

- Signing in with Google. The button on the get-started screen had a comment
  where the sign-in should have been -- it depressed, and nothing happened --
  and the mark on it was not Google's: three greys out of a file whose own
  metadata called it `search.svg`. There is now a real flow, over Supabase's
  Google provider, drawn to Google's published specification down to the
  border colour and the 18-pixel logo that is never recoloured. The session is
  caught in `main.dart` rather than on the screen that started it, because
  Android is free to kill the process while the consent screen is in front of
  it. See [`docs/GOOGLE_SIGN_IN.md`](docs/GOOGLE_SIGN_IN.md) for the three
  dashboard steps that switch it on.

  Not offered where it cannot work. Only the Android and iOS builds register
  `so.kyron.app://`, so on Windows the consent screen's answer would have
  nowhere to go; there the button says so and points at the way through that
  does work, rather than opening a browser on a journey with no end.

- A get-started screen. The first thing anybody saw was "Welcome back." --
  addressed to somebody who had never been here -- over a dead Google button
  and two identical grey buttons. It is now a picture across the top with the
  ways in on a sheet lifted over it. The picture is drawn rather than shipped:
  glass discs holding the things Kyron is for, coloured from the theme, so it
  is right in both and adds nothing to the download.

- The terms, as a sheet, before the first sign-in. Two links under a button is
  the usual way to do this, and it is the usual way because it works for the
  company rather than the reader: nobody has ever read a document they had to
  leave the screen to find. Kyron now asks once, before the first way in is
  taken, and says the three things that actually matter in a sentence each,
  with both documents a tap away. The decision is pinned to the bottom of the
  sheet and the reading scrolls above it, so the Agree button can never end up
  under the fold.

### Fixed

- Asking for a password reset did nothing. The screen validated the address
  and then ran `// Your reset logic here`, silently, for ever -- while
  `AuthRepository.sendPasswordReset` sat finished behind it, wired to nothing.
  It now sends, and then says what happens next: which inbox, why it may be in
  spam, that the link is good for an hour and one use, what to do if nothing
  arrives, and -- on a desktop, where the link cannot open the app -- that the
  mail has to be opened on the phone. Failures are shown in place, in
  Supabase's own words, with a cooldown on Resend so the limiter is not the
  thing saying no.

- The mark at the top of the home screen was blue. It was drawn under a
  `ColorFilter.mode(scheme.primary, srcIn)`, which flattened a leaf that runs
  teal into green down to one flat `#4C8FFF`. The filter is gone and the app
  bar draws `AppLogo`, so there is one place that knows what Kyron's mark
  looks like.

- The splash screen's mark is a silhouette: near-black in daylight, and at
  night barely a shade off the background it sits on. A splash is a held
  breath, not a billboard.

- An email address on a top-level domain longer than four letters was refused
  everywhere it was checked. The pattern ended `{2,4}`, so nobody on a
  `.online`, `.digital` or `.photography` address could sign up, sign in or
  ask for a password reset. Sign-in and sign-up were not checking at all --
  both accepted any non-empty string, which is how a typo became a reset mail
  sent into nothing.

- Firebase's `google-services.json`, `GoogleService-Info.plist` and the
  generated `firebase_options.dart` are in `.gitignore`. The API key inside
  them is meant to ship inside an app, but together they name the project, its
  sender id and its app ids, and this repository is public.

- Every build ships Windows and Android together. The release workflow built
  Android and nothing else, so the Windows app existed but there was no way to
  get one without a Windows machine and a toolchain. A tag now runs its checks
  once, builds both platforms in parallel, and publishes a single release
  carrying the zipped Windows app beside the APKs -- per architecture, the
  universal one, and the Play Store bundle. Pushes to `main` do the same as a
  development build.

  The publish step waits for both and refuses to publish if either is missing,
  because a download that returns nothing is not an error and would otherwise
  have produced an Android-only release under a version that promised both.
  The Windows half of a development build is compiled in release mode on
  purpose: a debug Windows build links against the Visual C++ debug runtime,
  which ships with Visual Studio rather than with Windows, so a debug zip does
  not start on the machine of anyone it was built for.

  Both platforms take their build number from the same place, so one tag
  cannot ship Android as `+41` and Windows as `+42`. `scripts/check-workflows.py`
  checks that, and the rest of the shape, on every pull request -- a release
  workflow that has quietly lost a platform still parses and still runs, so
  nothing else would have caught it.

- A Windows build you can download from any pull request. CI already compiled
  the Windows app; it now packages it with the same script the release uses and
  attaches the zip to the run. Trying a branch on Windows no longer needs a
  Windows machine, and the packaging a release depends on has already run on
  every pull request by the time a release needs it.

- Kyron runs on Windows. It did not, quite: the app opened, showed its loading
  spinner and stayed there. Six of its features are native code somebody else
  wrote, none of the six ships every platform Flutter builds for, and the app
  asked for all of them regardless -- the draft database first, with an await
  in front of it, during start-up. sqflite has no Windows implementation at
  all, so that throw escaped, the flag saying "ready" was never set, and there
  was nothing after the spinner. Nothing failed loudly. It just never arrived.

  Now there is one list of what a platform can do, and everything reads it.
  Where a feature is missing the surface says which and why instead of
  crashing: a clip says it needs a player Kyron does not have on Windows yet,
  a voice post says the same about audio, the lens screen says it about the
  camera. A link opens your own browser rather than the in-app one, which on a
  desktop is where you expected it to go anyway. Drafts are the one real loss
  -- they need a database that is not there -- and the composer works without
  them rather than falling over on the way out.

- Navigation down the side, in a window. Above about nine hundred points wide
  the bar across the bottom becomes a rail down the left: the same four places
  with their names beside them, at a size a pointer aims at, and a Post button
  that opens the menu the round one always did. Below that width nothing
  changes, and it is measured off the window rather than the operating system
  -- a Windows window dragged narrow gets the phone's layout, which is the
  right one for that shape.

- A feed that stops widening. A column of posts as wide as a maximised monitor
  is harder to read, not easier: the eye loses the start of the next line
  coming back from the end of the last. The column keeps its measure and the
  rest of the window becomes margin. Grids of pictures are the exception and
  get more room, because a picture is not a sentence.

- Kyron has a proper browser. It arrives as a card over the app rather than a
  screen in front of it -- the feed stays visible along the top, dimmed --
  with the page's own title across the bar and, underneath it, a padlock and
  the host it is really on. Follow a redirect and the bar follows with you.
  Land on something served over plain http and the line turns red and says
  *Not private* before it says the host. Tap the bar for the address in full,
  spelled out, with the connection explained in a sentence, because a host
  alone cannot tell you that the login page you are looking at is on somebody
  else's domain.

  It has tabs, and they come from the pages themselves: a link asking to open
  in a new window used to do nothing at all in an in-app browser -- no error,
  no navigation, the page just ignored your finger -- and now opens a tab. The
  strip along the top only appears once there is more than one, and each tab
  carries a colour and a letter taken from its host, so three of them are
  three different things at a glance.

  Back, forward, reload and share sit along the bottom where a thumb is. The
  system back gesture unwinds the page's history first, then the tab, then the
  browser. A page that fails to load says which host failed and why, and
  offers to try again -- instead of the blank white nothing a web view leaves
  behind, which looks exactly like a page still coming.

  Leaving is still there, once, as a choice you make: *Open in browser* on the
  page sheet hands it to the phone. It is the only way out, and there is now
  one place in the whole app that can take it.

### Changed

- New artwork on every empty screen. It used to be a set of rendered 3D
  objects -- a doughnut, a UFO, crossed swords, a tin of salt -- sharing a
  purple gradient and not much else. Each one is now the same small stack of
  cards seen from the same angle, with a pane of glass across it, and it is
  drawn rather than shipped as a picture: it takes its colours from whichever
  theme you are in, so it is right at night instead of being a pale smear.

### Added

- The like button celebrates. A ring goes out, six sparks follow it, and the
  heart gives before it swells -- the way something soft behaves when you
  press it. Every button in the row gives a little; only the like bursts, and
  only when a like goes on. Taking one back is quiet, because a button that
  congratulates you for changing your mind is a strange thing to build. The
  count slides rather than swapping, up as it grows and down as it shrinks.

### Fixed

- The Windows build is Kyron's rather than the template's. The window was
  titled "app", the executable said `com.example` in its version block and was
  called `app.exe`, and the taskbar showed the Flutter logo -- since the day
  the folder was created. None of that fails a build, which is why it lasted:
  the app's own CI runs on Linux and checks Dart, and none of those three is
  Dart. It now says Kyron, ships the leaf on the same grey the Android
  launcher uses, and will not let you drag the window narrower than the layout
  has anywhere to go. CI builds it on Windows on every change, so the next one
  of these is caught the day it is written.

- Tapping a link in a post no longer throws you out of Kyron. A link in
  somebody's post, and the website card under it, went straight to Chrome or
  Safari: you left the app, lost your place in the feed, and came back through
  the task switcher if you came back at all. It was deliberate, and the
  reasoning was that a stranger's page should not read as part of Kyron and
  that a real browser is where you can see where you have been sent. Both of
  those are still true and neither one needed another app. Every web link in
  Kyron now opens in Kyron's own browser, which frames the page as an obvious
  guest and never stops showing whose it is.

- The bottom navigation no longer needs an accurate thumb. On a phone with
  gesture navigation the bar was giving its own height away to the system's
  inset, leaving each tab answering over 29 pixels of the 64 it looked like it
  owned -- and only responding where the icon and the label actually painted.
  The whole of a tab is now the target.

- Pull to refresh is visible on the feed again. It never stopped working --
  the spinner was landing behind the top bar, so pulling down looked like
  nothing happening. It now comes down below the bar where you can see it.

- Video posts no longer make the feed stutter as they arrive. A clip's player
  was being started the moment the clip reached the middle of the screen --
  which is while your thumb is still moving -- and starting one is not free.
  It now waits for the list to stop, so a clip begins when you have stopped to
  look at it rather than while you are on your way past.

- The feed scrolls properly. Hiding the top bar was shrinking a spacer beside
  the list, which resized the list's own scroll area on every frame of a drag
  -- so the posts did not travel with your thumb, and the whole visible list
  was laid out again for each frame. It read as a feed that took effort to
  push around. The bar now slides over the posts instead of pushing them, and
  nothing under it moves.

### Added

- An AR lens camera, with lenses that follow a face. A face mesh runs on the
  device, and a lens states its sizes as multiples of the distance between the
  pupils rather than in pixels -- so one written once is right at any distance
  from the camera, on any face, on any phone. Two lenses arrive with it: Blank
  takes your nose and mouth out under skin the colour of the rest of your face,
  and Frosted etches the whole picture and leaves only your eyes. Tracking runs
  only while a lens actually needs it, and the picture you take is the picture
  you saw -- the effects are drawn into the saved file, not just the preview.
- New lenses no longer need an app release. The camera fetches its catalogue
  from [kyron-lenses](https://github.com/KyronLabs/kyron-lenses); merging one
  there publishes it. A lens is data rather than code and there is nothing in
  it to execute, so it names things the app already knows how to do -- a
  colour, an anchor, a region -- and one the app does not understand is
  dropped rather than half-drawn.
- Read receipts arrive as they happen: opening a thread fills in the other
  side's ticks without either of you refreshing, and a message somebody
  withdraws leaves your screen rather than sitting there until you reopen the
  conversation. Neither sends a push -- a phone that buzzes because somebody
  read a message is a phone nobody wants.
- A comment or reply written by the post's own author carries an Author badge.
  In a long thread those are the answers people are looking for.
- Clips are normalised on upload and get a poster cut from them. Anything over
  720p or 2.5 Mbps is re-encoded to H.264 with the index moved to the front, so
  playback starts before the file has finished arriving, and every list drawing
  the post has a still to show before anybody presses play. A clip longer than
  five minutes is refused rather than quietly truncated.
- Direct messages are encrypted end to end. Every install makes an X25519
  keypair, keeps the secret half on the device and publishes the public half;
  the text is sealed with XChaCha20-Poly1305 under a key derived from both
  sides, so the server carries ciphertext it has no key for. A bubble carries a
  lock when the message was sealed, because a conversation is only encrypted
  when both sides have a key and the reader should be told which they got.
  `docs/E2EE.md` is mostly about what this does not cover -- one key per
  install, no forward secrecy, no key verification, attachments still in the
  clear -- because a half-understood encryption feature is worse than none.
- Loading skeletons in the shape of what is coming, on the feed, a post, a
  chat, the conversation list, the comment pages and Explore's people. A
  centred spinner says something is happening and nothing else; a skeleton says
  how much is coming and roughly what it looks like, so the page fills in
  rather than rearranging itself the moment it lands.
- Push notifications, server side and app side both. A like, a repost, a
  comment, a reply, a follow or a message reaches whoever it is about: over the
  socket if they have the app open, as a push to their phone if they do not,
  decided per person rather than per event. Turning it on needs a Firebase
  project -- see `docs/PUSH.md`. Without one the API says so at boot and sends
  nothing, rather than reporting a delivery it never made.
- Messages and notifications arrive as they happen. The app holds one
  authenticated socket open and the server says what changed; the app then
  fetches it through the same endpoints as before, so a dropped connection
  costs freshness and never correctness. A chat that is open appends the new
  message without the screen blinking.
- A reply can carry pictures and a clip, over the same basket the post composer
  and the chat already use.
- "Show N replies" carries the faces of the people who actually answered, sent
  with the comment rather than fetched a row at a time, and never padded out: a
  face there is a claim that a particular person is in the conversation.
- A jump-to-end button on the chat, the post and the comment page. Downwards
  where the newest thing is, upwards where the subject is, and only once the
  list has moved far enough that there is somewhere to go.
- Voice posts. Record up to ten minutes in the composer and the post carries a
  waveform you can play and scrub. The waveform is sampled while the microphone
  is open, because that is the only place the signal exists -- reading it back
  would mean decoding the audio again, and doing it on the server would mean
  decoding every upload to draw a picture of it.
- A hashtag you searched for is highlighted in the body of every post carrying
  it, so a post with five tags does not make you read all five.

- Link previews. A post carrying a link shows the page's card, fetched and
  cached by the API rather than by each reader's device -- which is both
  faster and the difference between one request per link and one per reader.
  The fetch refuses private and link-local addresses, follows redirects by
  hand so every hop is checked, caps what it reads, and remembers a failure so
  a dead link is not retried on every scroll past it.
- Polls. Two to four answers, five minutes to seven days, written under the
  question in the composer rather than on a screen of their own. Results are
  always visible, before and after voting. One vote per person is enforced by
  a database constraint, not by a check two taps can race past.
- A share action on every post: the system share sheet, copy link, copy text,
  or quote it.
- A tab pager on the profile -- Posts, Media, Videos, and Likes on your own --
  and screens for who follows an account and who it follows, each with a
  Follow button that works from the list.
- Videos as a staggered wall of tiles, each keeping its own shape rather than
  being cropped square.
- Search filters, behind a button at the end of the search field: an account,
  a date range, and what a post carries. Search now covers posts as well as
  people.

- Attachments on posts and comments: up to four images, GIFs or clips each,
  with a full-screen viewer that pinch-zooms, swipes between attachments,
  swipes down to dismiss, plays video with a scrubber, and shares or copies a
  link. Each attachment can carry a description for screen readers.
- Reposting, and quoting with your own words above the original.
- An overflow menu on every post: translate, copy the text or a link, show
  more or fewer posts like it, hide it, mute the thread, mute words or tags,
  mute or block the author, and report the post or the account.
- A report flow with twelve reasons, which keeps one report per person and
  copies the reported content so it stays reviewable after deletion.
- Muted words and tags, and a screen listing muted and blocked accounts.
- Hashtags are indexed, highlighted, and open a screen of everything carrying
  them. Mentions and links are picked out too.
- An interaction setting on the composer -- who can reply -- enforced by the
  server rather than shown and ignored.
- Drafts: closing the composer with something written offers to save, discard
  or keep editing, and a drafts screen lists what is waiting.
- A GIF picker, when the build carries a `TENOR_API_KEY`.
- A post has its own screen: the post in full, its comments, and one level of
  replies under each, with a composer that can reply to a specific comment.
- Post analytics for the author of a post — viewers, likes, saves, comments,
  viewers per day and an engagement rate. A viewer is counted once rather than
  once per open, and the author's own opens are not counted.
- Saved and liked posts, both backed by real tables rather than a drawer entry
  pointing at a route that did not exist.
- People search, behind the top bar's search icon.
- An About page carrying the terms, the privacy policy, live service status, a
  system log of what the app has actually been doing, an error report that
  sends it, and the running build read from the bundle.
- Editing your own profile: name, bio, location, website, avatar and cover.
- Android release and debug builds now publish a per-architecture APK
  (`arm64-v8a`, `armeabi-v7a`, `x86_64`) alongside the universal one.

### Changed

- One loading language across the app. The notifications screen had its own
  shimmer, from its own library, in hardcoded hex that ignored the theme; it
  now uses the same skeletons as everything else, and the extra dependency is
  gone.
- No dropdown menus anywhere. The conversation menu, the comment overflow, the
  community member row and the language picker are bottomsheets now, off one
  shared sheet. A popup opens against the top of the screen on a row near the
  top and under your hand on one near the bottom, and its rows are too small to
  hit accurately on a phone. The conversation sheet offers Mute or Unmute
  rather than both, which needed the server to say which one you are in.
- The overflow glyph is the outlined weight rather than the bold one, which was
  the heaviest thing in a comment.
- Thread rails are a hair rather than two points, and the root comment on a
  reply page threads with everything under it instead of being drawn above it.
- "Space" was one word covering two different things. Recording your voice and
  broadcasting live are separate entries now, and the one that is not built
  says so when you open it rather than sharing a name with the one that is.
- Poll is gone from the create menu: a poll is written in the text composer,
  under the question it belongs to, so a second door into the same screen did
  nothing the first did not.
- Videos are a wall of tiles in the feed rather than on the profile, and the
  profile's Media tab is the tiled one.
- Post actions: reply, repost and like sit together on the left with their
  counts; save and share, which carry no count, go to the right. Repost turns
  green, a like red and a save amber, and each gives the lightest haptic the
  platform has.
- Picking a search date is three scrolling wheels in a sheet rather than a
  calendar grid, with a tick as each item passes. The day wheel follows the
  month and year, so the 30th of February cannot be picked.

- One button. The design system's outlined and elevated themes both set an
  infinite minimum width, which is right for the call to action at the foot of
  a form and is why "Edit profile" grew to swallow the profile header. Every
  button is now the proportions the composer's own already had.
- The profile: the cover runs to the top of the screen under the bar, the
  display name is larger with the handle beneath it, the post count is gone
  from above a tab called Posts, and Edit profile is joined by a share button.
- The composer's link preview no longer fetches the page on the device. Six
  hundred lines -- an isolate, an HTML parse and three URL-guessing strategies
  -- became a request to the same endpoint readers use, so what the author
  sees while writing is what the post will actually carry.

- The Android application id is `so.kyron.app`. It was still the Flutter
  template's `com.example.app`, which Google Play rejects outright. An
  installed build will not update over one carrying the old id.

- The profile screen reads the signed-in account and public profiles from the
  API instead of deriving them from the DID in the route.
- Posts are separated by a hairline rather than boxed in rounded outlines, and
  tapping one opens the post rather than its author.
- Every icon that has an outline variant uses it; a liked heart and a saved
  bookmark stay filled, because an outline one reads as not-yet-done.
- The default text size is Small.
- Text fields are slimmer: one shared input theme across the three modes,
  denser padding, and no outline ring by default -- the accent border appears
  on focus. Screens that drew their own outline no longer override it.
- The app resolves the design system at the commit carrying that input theme,
  rather than the one before it.
- Text fields stand 40 tall, the same height as a button, so a field and a
  button beside each other line up. Labels and hints come down from Material's
  16 to 14, which was larger than the body text around them.
- Search results carry an avatar, a two-line bio, follower and Kyron Point
  counts, and a Follow button that works from the list, separated by hairlines
  rather than stacked as bare rows.
- A post's author gets their own section in its overflow menu: analytics, who
  can reply, and delete.

### Fixed

- Tapping "show replies" made the branch disappear for as long as the request
  took. The comment was marked open the moment it was tapped, which took its
  own row away before the replies existed. The row stays now, with a spinner
  beside its faces.
- A photograph could be uploaded at twenty-five megabytes, which is the ceiling
  a video needs. Each kind has its own now.
- A post's dimensions were whatever the client said they were, and the feed
  lays a post out from them before the picture has loaded. They are read from
  the file's own header, so a wrong pair cannot make the feed jump.
- A small, highly compressible image could decode to hundreds of megabytes on
  every phone that opened the post. Refused above fifty megapixels.
- A community's banner held the top of the screen however far down the
  community you had read. The header sat above the posts rather than scrolling
  with them, so the posts slid up behind it and stopped. It scrolls away now,
  the way a profile's does.
- A community's picture and banner asked for a URL. Nobody has a URL for a
  photograph on their phone, so the only thing those two boxes could do was
  paste a link to somebody else's image. They are the same gallery pickers the
  profile uses -- one widget now, drawn by both.
- Comments on a post began at the very edge of the screen while the post above
  them was inset. They carry the same margin as everything else on the page.
- The rule under a comment fell in the wrong place. It was drawn on whichever
  row was the last top-level comment, so on a post with one comment it landed
  between that comment and its own reply, and two comments got no rule between
  them at all. It closes a comment and everything hanging off it now.
- A reply went to the wrong person. Every reply to a reply was re-hung on that
  reply's own parent, so answering somebody halfway down a thread filed the
  answer beside them under the top comment, addressed to whoever wrote that. A
  reply now keeps the parent it was written under.
- A band of empty screen sat between the tab strip and the first row in
  Explore, Messages and Communities. Those pages draw their own top chrome
  inside a SafeArea, but that SafeArea is a sibling of the tab body rather than
  its parent, so the status bar inset was still on the MediaQuery below it --
  and a list built without an explicit padding quietly adopts it.
- The newest message in a chat had moved to the top. The provider already hands
  the screen oldest-first and the screen reversed it again.
- The Bio field's icon hung halfway down the box, pointing at nothing. It sits
  on the first line now, at any text scale.
- "Open in Browser" in the browser sheet closed the sheet and did nothing. It
  opens the browser, and says so when no app can.
- Videos were poured into a box of a fixed shape, so a portrait clip -- which
  is most of them -- came out letterboxed with a black bar down each side, and
  a tall one was cropped. A clip is now drawn at its own dimensions.
- Pulling to refresh the profile dragged the whole page, cover and all, away
  from the top of the screen. Bouncing physics did that; clamping holds the
  content still and lets the spinner come down over it.
- The avatar sat below the cover instead of straddling its lower edge.
- "m.facebook.com" got no link preview: the detector required a scheme nobody
  types. Bare hosts are matched now, without conjuring links out of "1.5",
  "e.g." or "8.30".
- A poll showed no results until you had voted, which contradicts what the card
  is for -- the counts are in the same response either way.

- Video posts rendered as a blank grey rectangle until the attachment was
  opened. The tile drew a play glyph with no player behind it. A clip now
  plays in place -- which is also what paints its first frame as the poster --
  with a real play/pause control, a scrubber, a mute toggle, and autoplay,
  muted, once half of it is on screen.
- The Following and Videos tabs in the top bar recoloured a pill and changed
  nothing: every tab read the same everyone-newest-first feed. Each now reads
  its own, and an interest tab you add reads that topic's.
- The sign-in and sign-up screens never picked up the shared input theme --
  both field widgets set their own fill, their own 18-pixel padding and their
  own resting outline, so every other screen moved on without them.

- Video attachments always failed with a bare 413. The multipart plugin capped
  uploads at 5 MB while the media service advertised 25, and the plugin rejects
  a request before any handler runs, so the service's own limit was
  unreachable. One limit now, named by the service that owns the rule, and an
  oversize upload comes back with a message that says the size.
- The composer's Post button stayed enabled when every attachment had failed to
  upload, so pressing it sent an empty post and the API answered "A post needs
  text or an attachment". It now counts uploaded attachments, not chosen ones,
  and says when the only attachments are failed ones.
- Muting a word broke the whole feed with a 500. The muted-phrase filter put
  Prisma's `mode: 'insensitive'` inside a nested `not`, where it is not a valid
  field; it belongs on the clause.
- A post's overflow menu drifted inward on a long display name, because it sat
  inside the same row as the name. It is a sibling of the avatar now, so it
  pins to the card's right edge whatever the name is.
- The profile screen is rebuilt without the collapsing app bar and without any
  flexible child in a row that can overflow -- the counts wrap instead. It also
  records each stage it reaches in the system log, so a blank page names itself
  rather than having to be reproduced.

- The API would not start: MediaModule injected SupabaseService without
  importing SupabaseModule, which type-checks, builds, and passes every unit
  test, then fails at boot. AppModule's whole dependency graph is now compiled
  in a test, so a module that forgets an import fails in CI instead of on
  Render.
- `POST /media/transcode` took two paths from an unauthenticated request body
  and interpolated both into a shell command, so any caller could run
  arbitrary commands on the API container.
- The system log read "Nothing logged yet" however much had gone wrong. Every
  API request and profile load is recorded now.
- Typing in the composer fired a haptic on every keystroke.
- The settings screen had a close button beside its back button, and its DID
  row showed and copied the same invented identifier for everyone.
- The selected bottom-navigation tab is filled again, rather than relying on
  colour alone.

- A blank profile page, caused by a `Spacer` in a row that overflowed by 157
  logical pixels on a 360-wide phone.
- The drawer's last item was cut in half, because the navigation list and the
  gap beneath it split the leftover space between them.
- Service status called every healthy deployment broken: it compared the
  reported database state against a word the endpoint has never used.
- The composer's Post button reported success without writing anything.
- Logging out did not stick across a relaunch.
- `GET /profile/interests` and `GET /profile/suggested` answered "User not
  found", because a catch-all route was declared above them.
- Follower and following counts were derived from the wrong side of the follow
  relation.

### Removed

- The composer's AI Assist panel, privacy selector, scheduler and media picker.
  The API accepts none of them: an attachment was dropped on send and a
  scheduled post went out immediately.

[Unreleased]: https://github.com/KyronLabs/kyron/compare/v0.1.19...HEAD
[0.1.19]: https://github.com/KyronLabs/kyron/compare/v0.1.18...v0.1.19
[0.1.18]: https://github.com/KyronLabs/kyron/compare/v0.1.17...v0.1.18
[0.1.17]: https://github.com/KyronLabs/kyron/compare/v0.1.16...v0.1.17
[0.1.16]: https://github.com/KyronLabs/kyron/compare/v0.1.15...v0.1.16
[0.1.15]: https://github.com/KyronLabs/kyron/compare/v0.1.14...v0.1.15
[0.1.14]: https://github.com/KyronLabs/kyron/compare/v0.1.13...v0.1.14
[0.1.13]: https://github.com/KyronLabs/kyron/compare/v0.1.12...v0.1.13
[0.1.12]: https://github.com/KyronLabs/kyron/compare/v0.1.11...v0.1.12
[0.1.11]: https://github.com/KyronLabs/kyron/compare/v0.1.10...v0.1.11
[0.1.10]: https://github.com/KyronLabs/kyron/compare/v0.1.9...v0.1.10
[0.1.9]: https://github.com/KyronLabs/kyron/compare/v0.1.8...v0.1.9
[0.1.8]: https://github.com/KyronLabs/kyron/compare/v0.1.7...v0.1.8
[0.1.7]: https://github.com/KyronLabs/kyron/compare/v0.1.6...v0.1.7
[0.1.6]: https://github.com/KyronLabs/kyron/compare/v0.1.5...v0.1.6
[0.1.5]: https://github.com/KyronLabs/kyron/compare/v0.1.4...v0.1.5
[0.1.4]: https://github.com/KyronLabs/kyron/compare/v0.1.3...v0.1.4
[0.1.3]: https://github.com/KyronLabs/kyron/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/KyronLabs/kyron/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/KyronLabs/kyron/releases/tag/v0.1.1
