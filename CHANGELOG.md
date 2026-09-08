# Changelog

Notable changes to Kyron, newest first.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and versions follow [semantic versioning](https://semver.org/spec/v2.0.0.html).

Entries under **Unreleased** are stamped with a version and a date by the
_Create Versioned Release_ workflow, which refuses to cut a release while that
section is empty. The versioned release's notes on GitHub are this file's
section for that version, so what is written here is what people read.

## [Unreleased]

### Added

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

[Unreleased]: https://github.com/KyronLabs/kyron/compare/v0.1.0...HEAD
