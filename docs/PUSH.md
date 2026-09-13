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
calls, and its CMake downloads the ~1 GB Firebase C++ SDK to do it. Nothing in
the app's control switches that off — Flutter includes every plugin in the
dependency graph that declares a platform. If the Windows build time becomes a
problem, the supported escape hatch is the `FIREBASE_CPP_SDK_DIR` environment
variable, which points the plugin's CMake at an already-extracted SDK instead
of downloading one.

## iOS

Configured but not turned on, and it will not build as it stands.

`GoogleService-Info.plist` is in `ios/Runner` and `PlatformSupport.mobile.push`
is true, so the Dart side is ready. Four things are not:

1. **`IPHONEOS_DEPLOYMENT_TARGET` is 13.0**, and `firebase_messaging` 16.6
   requires 15.0. `pod install` fails on that before anything is compiled.
   Raising it drops iOS 13 and 14 devices, which is a product decision rather
   than a build fix, so it has been left alone. Nothing catches it today —
   there is no iOS job in CI.
2. An **APNs key** uploaded to Firebase.
3. The **Push Notifications capability** on the App ID.
4. **Background Modes → Remote notifications** in the entitlements.

None of 2 to 4 can be done from here: they need the Apple developer account.
