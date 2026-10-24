# Push notifications

Both halves are built. What is left is configuration, in two places, and
neither of them is code.

## How it runs

```
 something happens          DeliveryService              this handset
 (like, reply, DM)                 │
        │                          ├──► the socket, if the app is open
        └──────────────────────────┤
                                   └──► PushService, always
                                                          │
                                                    FCM HTTP v1
                                                          │
                                            the token DeviceToken holds
                                                          │
                                                  ┌───────┴────────┐
                                                  │  notification  │
                                                  └────────────────┘
```

The push goes whether or not a socket is open. A socket says nothing about
whether the app is in front: one left open behind the lock screen used to
swallow every push. The app decides what to do with a push that arrives
while it is in front.

| Piece | Where |
|:--|:--|
| Device token storage | `DeviceToken` in `api/prisma/schema.prisma` |
| Register and forget | `PUT /devices`, `DELETE /devices` |
| Sending | `PushService`, FCM HTTP v1, service-account signed |
| Fanning out | `DeliveryService` — the socket for an open app, and a push |
| Client registration | `PushRegistrar`, `DevicesRepository` |
| The token itself | `FirebasePushTokens` in `lib/services/firebase_push.dart` |

Every path that produces a notification already calls through `DeliveryService`:
a like, a repost, a comment, a reply, a follow, and a direct message.

The registrar starts on sign-in and on every launch with a session — a token
can rotate while the app is closed, and a server holding the old one pushes
into nothing — and stops on sign-out, because a token left registered delivers
this account's notifications to whoever holds the handset next.

Permission is asked for at sign-in rather than at launch. The question would
otherwise land before anybody had seen a screen, and "no" from a stranger is
permanent on both platforms.

## What a push says

A like, a reply, a repost or a follow is pushed the way Threads pushes it:
who did it is the title, what they did is the body, and their picture rides
along.

| Kind | Title | Body |
|:--|:--|:--|
| Like | Ada Obi | Liked your post: “first few words…” |
| Reply | Ada Obi | Replied: “what they wrote…” |
| Repost | Ada Obi | Reposted your post: “first few words…” |
| Follow | Ada Obi | Followed you |

- **The name** is the display name, else the @handle. When whoever did it
  is gone, banned, or blocked by or blocking the reader, no push goes at
  all.
- **"and 2 others"** counts the others who did the same to the same post
  since the reader last opened Notifications (90 days if they never have),
  leaving out the reader and anybody blocked either way. A newer push of a
  kind replaces the older one on the handset (below), so the count keeps the
  replaced ones from vanishing.
- **Snippets** are 80 characters at most, cut at a word.
- **The picture** is the actor's avatar, sent as FCM's `notification.image`
  when it is an `https` URL. Android shows it beside the text, and as a large
  picture when the notification is pulled open. iOS shows nothing without a
  notification service extension, which the app does not have yet.
- **One per kind per post on the handset.** The tag is `like-post-<id>`,
  `comment-post-<id>` or `repost-post-<id>`, and `follows` for follows, so a
  like no longer replaces a reply about the same post.
- The words are built off the request (`ActivityPushService`, called from
  `DeliveryService.tellActivity`): the socket event goes first, and a like is
  never slowed down by working out who else liked it.
- **In the phone's language.** The app sends its language with the token
  (`DeviceToken.locale`) and again whenever the reader changes it, and each
  push is worded per device from `api/src/modules/push/copy/`: one catalog
  for each language the app has. Callers build a `PushText` with `say()`
  rather than a string, and it is rendered per device at send time. An app
  from before this sends no language, and gets English; so does a language
  with no catalog. Names, post snippets and the team's own words go as
  written.
- **Adding a phrase** means adding it to `copy/en.ts`. Every other catalog is
  typed against it, so the build fails until each one has it too.

## Configuring it

**1. The server.** From the Firebase console, Project settings → Service
accounts, generate a private key **for the same Firebase project as
`google-services.json`** (a key from any other project is refused by FCM for
every token the app registers). Set it on Render, Environment, as
`FCM_SERVICE_ACCOUNT_JSON`, the whole file on one line:

```bash
tr -d '\n' < service-account.json   # paste the output as the value
```

A Render **secret file** holding the key works too, under any name, when the
variable is not set. The value may be the file as downloaded (many lines),
one line, base64, or still in the quotes from a command line.

At boot the API reads the key and asks Google for an access token with it, so
a key Google refuses shows straight away rather than at the first
notification. It never silently pretends to send. `GET /health` says
`"push": "configured"` or `"push": "off"`, and when it is off, `pushProblem`
says why in plain words:

| `pushProblem` starts | Means |
|:--|:--|
| `FCM_SERVICE_ACCOUNT_JSON is not set on this service` | Not on this service, under a different name (named if so), or set with *Save only* and never redeployed |
| `... stops after N characters, so it was cut off` | Pasted through a `.env` import, which keeps only a value's first line |
| `... holds google-services.json` | The app's config file, not the server's key |
| `... holds an OAuth client` | The Google sign-in client, not the server's key |
| `Google refused the service account key` | Deleted or disabled key: generate a new one |

`pushLastFailure` is what Google last said when it would not deliver one;
`SENDER_ID_MISMATCH` there means the key is from a different Firebase project
than `google-services.json`. None of this repeats any part of the key.

**Checking it end to end.** Settings → Notifications → *Send a test
notification* asks the server (`POST /devices/test`) to push to every phone
this account has registered, and says which part failed: the server has no
key, this phone has no token, or FCM refused it. A test that reports *Sent*
and never shows up is the phone's side: notifications blocked for Kyron, or
battery settings holding it back.

**Android channels.** Messages arrive on the `messages` channel (high
importance: heads-up and sound), everything else on `activity`.
`MainActivity` creates both at launch, so a push that arrives before Flutter
has started still has a channel to land in, and the manifest names
`ic_stat_kyron` as the small icon: without it Android draws the launcher
icon as a white square.

**2. The app.** `app/android/app/google-services.json`, from Project settings →
Your apps → Android. Nothing else: no `firebase_options.dart`, because the
Google services Gradle plugin puts the same values in Android's resources and
`Firebase.initializeApp()` reads them from there. A generated options file
would be a third copy of the same numbers, kept in step by hand.

**3. CI.** The file is gitignored, so the workflows write it out of a secret.
Add the whole contents of `google-services.json` as the repository secret
`GOOGLE_SERVICES_JSON` (Settings → Secrets and variables → Actions).

A **release refuses to build without it**, by design: the plugin is skipped
when the file is absent, the APK builds perfectly cleanly, and every install
from it is unreachable while the app is closed — with nothing in the build
output saying so. A release is the wrong place to discover that. A development
build tolerates the absence and says which it is.

## Why the config files are gitignored

`google-services.json`, `GoogleService-Info.plist` and any generated
`firebase_options.dart` name the Firebase project, its sender id and its app
ids. The API key in them is designed to ship inside an app and is not a secret
in the way the service account key is — but this repository is public, and
handing out the project's identifiers invites someone else to point their own
build at it. Every machine that needs push supplies its own copy: locally by
dropping the file in, in CI from the secret above.

## Where push is not

`PlatformSupport.push` is true on Android and iOS and false everywhere else,
and `FirebasePushTokens.start` checks it before touching Firebase.

- **Windows and Linux** — `firebase_messaging` ships neither.
- **macOS** — `firebase_messaging` does ship it, but nothing has configured it:
  no `GoogleService-Info.plist` in `macos/Runner` and no APNs entitlement.
- **The web** — needs a service worker and a VAPID key, neither of which
  exists here.

One wrinkle worth knowing: `firebase_core` *does* ship a Windows
implementation, so the Windows build compiles a Firebase plugin the app never
calls. Its CMake downloads the Firebase C++ SDK to do it — **962 MB**, on
every build, with `FATAL_ERROR` if the download fails. Nothing in the app's
control switches that off: Flutter includes every plugin in the dependency
graph that declares a platform.

What it actually costs, measured on the CI run that introduced it rather than
estimated:

| `flutter build windows --release` | Time |
|:--|--:|
| Before Firebase (`8cae18b`) | 2m 28s |
| With Firebase (`8667239`) | 3m 34s |
| | **+1m 06s** |

A minute, because a GitHub runner's link to `dl.google.com` is fat. That is
cheap enough to leave alone — cheaper, probably, than restoring a gigabyte
from the Actions cache would be, which is why no caching was added. If it ever
stops being cheap, the supported escape hatch is the `FIREBASE_CPP_SDK_DIR`
environment variable: the plugin's CMake checks it first and skips both the
download and the extraction when it points at a matching SDK.

## iOS

Configured and buildable; not yet switched on at Apple's end.

`GoogleService-Info.plist` is in `ios/Runner`, `PlatformSupport.mobile.push` is
true, and the deployment target is **iOS 15.0** — raised from 13.0, because
`firebase_core` and `firebase_messaging` both require 15 and CocoaPods refuses
the combination before a line is compiled. **That drops iOS 13 and 14
devices**, which was a deliberate call rather than a build fix.

Three things still need the Apple developer account, and none can be done from
here:

1. An **APNs key** uploaded to Firebase.
2. The **Push Notifications capability** on the App ID.
3. **Background Modes → Remote notifications** in the entitlements.

### Keeping the deployment target honest

Nothing in CI builds iOS — no runner, no signing identity — so a wrong
deployment target would otherwise surface at somebody's `pod install`.
`test/ios_deployment_target_test.dart` runs on Linux with everything else and
reads the same sources Xcode and CocoaPods do: every
`IPHONEOS_DEPLOYMENT_TARGET` in the Xcode project, `MinimumOSVersion` in
`AppFrameworkInfo.plist`, and the `ios.deployment_target` of every podspec in
the packages this app actually resolved. It fails if the configurations
disagree with each other, if the framework minimum drifts from the project, or
if any plugin asks for more than the project offers — naming the plugins that
do. A plugin that raises its floor in a routine upgrade shows up there rather
than on a Mac.
