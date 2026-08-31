import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_app/screens/main_container.dart';
import '../providers/auth_provider.dart';
import '../screens/welcome_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/onboard_step1_screen.dart';
import '../models/onboarding_model.dart';

/// Decides what a signed-in person actually sees.
///
/// The single place that chooses between the welcome screen, onboarding and
/// the app, which is why every route into the app comes through here rather
/// than jumping straight to MainContainer.
class RootScreen extends ConsumerStatefulWidget {
  const RootScreen({super.key});

  @override
  ConsumerState<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends ConsumerState<RootScreen> {
  /// The in-flight onboarding check, held so it survives a rebuild.
  ///
  /// This used to be started inside build(), which meant every rebuild fired a
  /// fresh Supabase query and threw away the previous answer -- and while one
  /// was in flight the screen showed the splash, so an unrelated rebuild could
  /// bounce a settled screen back to it.
  Future<bool>? _onboardingCheck;

  /// The account [_onboardingCheck] was started for, so switching account
  /// re-runs it rather than reusing the previous person's answer.
  String? _checkedUserId;

  Future<bool> _onboardingStatusFor(String userId) {
    if (_checkedUserId == userId && _onboardingCheck != null) {
      return _onboardingCheck!;
    }
    _checkedUserId = userId;
    return _onboardingCheck = ref
        .read(authRepositoryProvider)
        .isOnboardingComplete()
        // An unreachable check is not evidence onboarding is done. Sending
        // someone through a flow they may not need is recoverable; dropping
        // them into the app with no profile behind it is not.
        .catchError((_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    switch (authState.status) {
      case AuthStatus.unknown:
      case AuthStatus.authenticating:
        return const SplashScreen();

      case AuthStatus.unauthenticated:
        return const WelcomeScreen();

      case AuthStatus.authenticated:
        final user = authState.user;
        if (user == null) return const SplashScreen();

        return FutureBuilder<bool>(
          future: _onboardingStatusFor(user.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.data ?? false) return const MainContainer();

            return OnboardStep1Screen(
              model: OnboardingModel()
                ..displayName = user.name ?? user.email.split('@').first
                ..bio = '',
            );
          },
        );
    }
  }
}
