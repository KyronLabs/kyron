# Changelog

Notable changes to Kyron, newest first.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and versions follow [semantic versioning](https://semver.org/spec/v2.0.0.html).

Entries under **Unreleased** are stamped with a version and a date by the
_Create Versioned Release_ workflow, which refuses to cut a release while that
section is empty. The versioned release's notes on GitHub are this file's
section for that version, so what is written here is what people read.

## [Unreleased]

### Fixed

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

[Unreleased]: https://github.com/KyronLabs/kyron/compare/v0.1.0...HEAD
