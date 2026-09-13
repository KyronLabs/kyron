# Push notifications

Both halves are built. What is left is configuration, in two places, and
neither of them is code.

## How it runs

```
 something happens          DeliveryService              this handset
 (like, reply, DM)                 │
        │                          ├── app open?  ──► the socket
        └──────────────────────────┤
                                   └── app closed? ──► PushService
                                                          │
                                                    FCM HTTP v1
                                                          │
                                            the token DeviceToken holds
                                                          │
                                                  ┌───────┴────────┐
                                                  │  notification  │
                                                  └────────────────┘
```

| Piece | Where |
|:--|:--|
| Device token storage | `DeviceToken` in `api/prisma/schema.prisma` |
| Register and forget | `PUT /devices`, `DELETE /devices` |
| Sending | `PushService`, FCM HTTP v1, service-account signed |
| Choosing socket or push | `DeliveryService` — the socket if the reader has the app open, a push if not |
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

## Configuring it

**1. The server.** From the Firebase console, Project settings → Service
accounts, download a service account key and set it as one line of JSON:

```bash
fly secrets set FCM_SERVICE_ACCOUNT_JSON="$(cat service-account.json | tr -d '\n')"
```

The API logs which project it is sending for at boot, and warns loudly when the
variable is missing. It never silently pretends to send.

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
