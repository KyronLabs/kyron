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

- The profile screen reads the signed-in account and public profiles from the
  API instead of deriving them from the DID in the route.
- Posts are separated by a hairline rather than boxed in rounded outlines, and
  tapping one opens the post rather than its author.
- Every icon that has an outline variant uses it; a liked heart and a saved
  bookmark stay filled, because an outline one reads as not-yet-done.
- The default text size is Small.

### Fixed

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
