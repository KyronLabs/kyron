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

### Fixed

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
