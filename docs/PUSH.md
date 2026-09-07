# Push notifications

The server half is finished. The app half is finished apart from one piece
that cannot be written without a Firebase project: where the registration
token comes from.

## What already works

| Piece | Where |
|:--|:--|
| Device token storage | `DeviceToken` in `api/prisma/schema.prisma` |
| Register and forget | `PUT /devices`, `DELETE /devices` |
| Sending | `PushService`, FCM HTTP v1, service-account signed |
| Choosing socket or push | `DeliveryService` — the socket if the reader has the app open, a push if not |
| Client registration | `PushRegistrar`, `DevicesRepository` |

Every path that produces a notification already calls through `DeliveryService`:
a like, a repost, a comment, a reply, a follow, and a direct message.

## What is missing

Nothing supplies a token. `pushTokenSourceProvider` answers `null`, the
registrar logs that this install will not be reachable, and no push is sent.
That is deliberate: a stub that returned a made-up token would look like it
worked.

## Turning it on

**1. Server.** Create a Firebase project, download a service account key from
Project settings → Service accounts, and set it as one line of JSON:

```bash
fly secrets set FCM_SERVICE_ACCOUNT_JSON="$(cat service-account.json | tr -d '\n')"
```

The API logs which project it is sending for at boot, and warns loudly when the
variable is missing. It never silently pretends to send.

**2. App.** Add the dependency and an Android config file:

```bash
cd app && flutter pub add firebase_core firebase_messaging
```

Put `google-services.json` in `app/android/app/` and, for iOS,
`GoogleService-Info.plist` in `app/ios/Runner/` plus an APNs key uploaded to
Firebase. Add the Google services Gradle plugin per the FlutterFire
instructions.

**3. Implement the source.** One class, against the interface that already
exists in `lib/services/push_registrar.dart`:

```dart
class FirebasePushTokens implements PushTokenSource {
  @override
  Future<String?> token() async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.denied) return null;
    return messaging.getToken();
  }

  @override
  Stream<String> get refreshes => FirebaseMessaging.instance.onTokenRefresh;
}
```

**4. Provide it**, by overriding the provider where the app is wrapped:

```dart
ProviderScope(
  overrides: [
    pushTokenSourceProvider.overrideWithValue(FirebasePushTokens()),
  ],
  child: const KyronApp(),
)
```

Then call `pushRegistrarProvider`'s `start()` after sign-in and `stop()` on
sign-out.

## Why it stops here

Adding `firebase_messaging` changes the native Android and iOS builds, and this
repository builds a debug APK on every push to `main`. That change was not made
blind: it needs a Firebase project to configure and an Android build to verify,
and neither was available when the rest of this was written. Everything up to
that line is tested and shipped.
