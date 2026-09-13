// lib/services/firebase_push.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'app_log.dart';
import 'platform_support.dart';
import 'push_registrar.dart';

/// Firebase Cloud Messaging, as the token source [PushRegistrar] asks for.
///
/// The seam this fills was left empty on purpose for two releases: a stub that
/// returned a made-up token would have looked exactly like push working, and
/// the server half -- `PushService`, FCM HTTP v1, `DeliveryService` choosing
/// between the socket and a push -- was finished and waiting behind it.
///
/// Nothing here is reachable unless [start] succeeded, so a build with no
/// Firebase configuration behaves exactly as it did before: the registrar says
/// once, in the log, that this install will not be reachable while the app is
/// closed, and sends nothing.
class FirebasePushTokens implements PushTokenSource {
  FirebasePushTokens._();

  /// Starts Firebase and hands back a token source, or null when there is not
  /// one to be had.
  ///
  /// Null rather than a throw, and null on every one of the ways this can go
  /// wrong: Firebase is not built for this platform at all (Windows, Linux),
  /// `google-services.json` was never dropped in, or the reader said no to
  /// notifications. None of those is an error in the app -- they are all
  /// "no push here" -- and the one thing that must not happen is the app
  /// failing to start because a notification channel could not be opened.
  static Future<PushTokenSource?> start() async {
    // Checked before Firebase is touched. firebase_core ships a Windows
    // implementation, so `Firebase.initializeApp()` there does not fail
    // helpfully -- it fails obscurely, inside a C++ SDK that has no project
    // to read. firebase_messaging has no Windows implementation at all.
    if (!PlatformSupport.current.push) {
      AppLog.instance.info(
        'push',
        'Push is not available on ${PlatformSupport.current.name}, so this '
            'install will not be reachable while Kyron is closed.',
      );
      return null;
    }

    try {
      // No options: the Google services Gradle plugin puts them in Android's
      // resources and the plist carries them on iOS, so passing a generated
      // firebase_options.dart would be a third copy of the same values, kept
      // in step by hand.
      await Firebase.initializeApp();
    } catch (error) {
      // Almost always the missing config file. Said plainly, because the
      // symptom otherwise is silence: no notification ever arrives and
      // nothing anywhere says why.
      AppLog.instance.error(
        'push',
        'Firebase would not start, so this install cannot receive '
            'notifications. Is google-services.json in android/app? $error',
      );
      return null;
    }

    final messaging = FirebaseMessaging.instance;
    try {
      final settings = await messaging.requestPermission();
      final status = settings.authorizationStatus;
      if (status == AuthorizationStatus.denied) {
        // A decision, not a failure. Recorded so that "why am I getting
        // nothing" has an answer in the log.
        AppLog.instance.info(
          'push',
          'Notifications were declined, so none will be delivered.',
        );
        return null;
      }
    } catch (error) {
      AppLog.instance
          .error('push', 'Could not ask about notifications: $error');
      return null;
    }

    return FirebasePushTokens._();
  }

  @override
  Future<String?> token() => FirebaseMessaging.instance.getToken();

  @override
  Stream<String> get refreshes => FirebaseMessaging.instance.onTokenRefresh;
}
