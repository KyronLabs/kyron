// lib/services/google_sign_in_flow.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import 'app_log.dart';
import 'google_sign_in_service.dart';

/// The native account sheet, as a provider so a test can stand one in.
///
/// Read once per tap: the service keeps the reason for the attempt it made,
/// and nothing about it is worth keeping between taps.
final googleSignInServiceProvider =
    Provider.autoDispose<GoogleSignInService>((ref) => GoogleSignInService());

/// How a tap on a Google button ended.
enum GoogleFlowEnd {
  /// A session exists. main.dart adopts it and takes the app to its root,
  /// whichever screen the tap was on.
  signedIn,

  /// The sheet reported a dismissal and the service kept it as one.
  dismissed,

  /// The browser has it, and the session comes back over the redirect.
  inBrowser,
}

/// "Continue with Google", from tap to session: the device's own account
/// sheet first, and the browser when the sheet cannot do it.
///
/// Shared by the welcome screen and the log-in screen. It was the welcome
/// screen's alone, so somebody who had made their account with Google and
/// came back through "Already on Kyron? Log in" found an email and a password
/// field, and no way to use the account they had.
///
/// Throws when the browser could not be opened either; the caller says so.
Future<GoogleFlowEnd> continueWithGoogle(WidgetRef ref) async {
  final google = ref.read(googleSignInServiceProvider);
  switch (await google.signIn()) {
    case GoogleOutcome.signedIn:
      return GoogleFlowEnd.signedIn;
    case GoogleOutcome.cancelled:
      return GoogleFlowEnd.dismissed;
    case GoogleOutcome.useBrowser:
      break;
  }

  // No sheet here, or Google would not use it for this build. The browser
  // still works when Google's side is configured, so it is the fallback
  // rather than a dead end -- and the reason is in the log, because "nothing
  // happened" is the worst thing this could report.
  AppLog.instance.info(
    'auth',
    'Falling back to the browser for Google: ${google.reason}',
  );
  await ref.read(authNotifierProvider.notifier).startGoogleSignIn();
  return GoogleFlowEnd.inBrowser;
}
