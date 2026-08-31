// lib/routes.dart
import 'package:flutter/material.dart';
import 'config/legal_links.dart';
import 'models/onboarding_model.dart';
import 'models/profile_model.dart';
import 'screens/about_screen.dart';
import 'screens/about_subscreens.dart';
import 'screens/coming_soon_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/help_screen.dart';
import 'screens/post_analytics_screen.dart';
import 'screens/post_collection_screen.dart';
import 'screens/post_detail_screen.dart';
import 'screens/search_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/settings_subscreens.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/signup_verify_email.dart';
import 'screens/root_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/webview_screen.dart';
import 'screens/composer_screen.dart';
import 'screens/onboard_step1_screen.dart';
import 'screens/onboard_step2_screen.dart';
import 'screens/onboard_step3_screen.dart';

class Routes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const signup = '/signup';
  static const signupVerifyEmail = '/verify-email';
  static const signupComplete = '/signup-complete';
  static const onboardStep1 = '/onboard/step1';
  static const onboardStep2 = '/onboard/step2';
  static const onboardStep3 = '/onboard/step3';
  static const forgot = '/forgot';
  static const home = '/home';
  static const composer = '/composer';
  static const createArLens = '/create/ar-lens';
  static const createPoll = '/create/poll';
  static const createSpace = '/create/space';
  static const webview = '/webview';
  static const settings = '/settings';
  static const notifications = '/notifications';
  static const postDetail = '/post';
  static const postAnalytics = '/post/analytics';
  static const profile = '/profile';
  static const editProfile = '/profile/edit';
  static const search = '/search';
  static const savedPosts = '/saved';
  static const likedPosts = '/liked';
  static const community = '/community';
  static const help = '/help';
  static const terms = '/terms';
  static const privacy = '/privacy';
  static const about = '/about';
  static const aboutStatus = '/about/status';
  static const aboutSystemLog = '/about/system-log';
  static const aboutErrorReport = '/about/error-report';
  static const settingsChangeEmail = '/settings/change-email';
  static const settingsBlockedUsers = '/settings/blocked-users';
  static const settingsPasswordLogin = '/settings/password-login';
  static const settingsFontSize = '/settings/font-size';
  static const settingsLanguage = '/settings/language';
  static const settingsNotifications = '/settings/notifications';
  static const settingsContactSupport = '/settings/contact-support';
  static const settingsFeedback = '/settings/feedback';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _page(const SplashScreen());

      case welcome:
        return _page(const WelcomeScreen());

      case login:
        return _page(const LoginScreen());

      case signup:
        return _page(const SignupScreen());

      case signupVerifyEmail:
        final args = settings.arguments as Map<String, String>?;
        return _page(SignupVerifyEmailScreen(email: args?['email'] ?? ''));

      case onboardStep1:
        final args = settings.arguments;
        return _page(OnboardStep1Screen(
          model: args is OnboardingModel ? args : OnboardingModel(),
        ));

      case onboardStep2:
        return _page(
          OnboardStep2Screen(model: settings.arguments as OnboardingModel),
        );

      case onboardStep3:
        return _page(
          OnboardStep3Screen(model: settings.arguments as OnboardingModel),
        );

      case forgot:
        return _page(const ForgotPasswordScreen());

      // The gate, not the app shell. Every way into the app arrives here --
      // sign-in, sign-up, and the end of onboarding -- and RootScreen is the
      // single place that chooses between the welcome screen, onboarding and
      // MainContainer. Pointing this straight at MainContainer is what let
      // sign-up drop people into a half-configured app: the onboarding check
      // only ran on a cold start, so the launch right after signing up looked
      // fine and the next one demanded a profile.
      case home:
        return _page(const RootScreen());

      // A handle, or nothing at all for your own profile. The old route also
      // accepted a DID and a ProfileModel and, given neither, invented an
      // account called "@current" with the DID "did:plc:currentuser".
      case profile:
        return _page(
            ProfileScreen(username: usernameFromArguments(settings.arguments)));

      case editProfile:
        return _page(const EditProfileScreen());

      case search:
        return _page(const SearchScreen());

      case savedPosts:
        return _page(const PostCollectionScreen.saved());

      case likedPosts:
        return _page(const PostCollectionScreen.liked());

      case Routes.settings:
        return _page(const SettingsScreen());

      case notifications:
        return _page(const NotificationsScreen());

      case postDetail:
        final id = settings.arguments;
        return _page(
          id is String && id.isNotEmpty
              ? PostDetailScreen(postId: id)
              : const _UnknownRoute(name: postDetail),
        );

      case postAnalytics:
        final id = settings.arguments;
        return _page(
          id is String && id.isNotEmpty
              ? PostAnalyticsScreen(postId: id)
              : const _UnknownRoute(name: postAnalytics),
        );

      case help:
        return _page(const HelpScreen());

      case about:
        return _page(const AboutScreen());

      case aboutStatus:
        return _page(const ServiceStatusScreen());

      case aboutSystemLog:
        return _page(const SystemLogScreen());

      case aboutErrorReport:
        return _page(const ErrorReportScreen());

      // The drawer linked to these two by name. Nothing answered, so both
      // fell through to the default and opened the splash screen.
      case terms:
        return _page(const WebViewScreen(
          url: LegalLinks.terms,
          title: LegalLinks.termsTitle,
        ));

      case privacy:
        return _page(const WebViewScreen(
          url: LegalLinks.privacy,
          title: LegalLinks.privacyTitle,
        ));

      case settingsChangeEmail:
        return _page(const SettingsChangeEmailScreen());

      case settingsBlockedUsers:
        return _page(const SettingsBlockedUsersScreen());

      case settingsPasswordLogin:
        return _page(const SettingsPasswordLoginScreen());

      case settingsFontSize:
        return _page(const SettingsFontSizeScreen());

      case settingsLanguage:
        return _page(const SettingsLanguageScreen());

      case settingsNotifications:
        return _page(const SettingsNotificationsScreen());

      case settingsContactSupport:
        return _page(const SettingsContactSupportScreen());

      case settingsFeedback:
        return _page(const SettingsFeedbackScreen());

      case composer:
        return _page(const ComposerScreen());

      case createArLens:
        return _page(const ComingSoonScreen.arLens());

      case createPoll:
        return _page(const ComingSoonScreen.poll());

      case createSpace:
        return _page(const ComingSoonScreen.space());

      case webview:
        final args = settings.arguments as Map<String, String>?;
        return _page(WebViewScreen(
          url: args?['url'] ?? '',
          title: args?['title'],
        ));

      // An unknown name is a bug in the caller, and sending it to the splash
      // screen hid that: the app appeared to hang on a logo. It now says which
      // route was asked for.
      default:
        return _page(_UnknownRoute(name: settings.name));
    }
  }

  static MaterialPageRoute<dynamic> _page(Widget child) =>
      MaterialPageRoute<dynamic>(builder: (_) => child);

  /// The handle a profile route was asked for, without its leading @.
  ///
  /// Null means the signed-in account, which is what the drawer's avatar and
  /// the app bar pass.
  static String? usernameFromArguments(Object? arguments) {
    String? raw;
    if (arguments is String) {
      raw = arguments;
    } else if (arguments is ProfileModel) {
      raw = arguments.username;
    } else if (arguments is Map) {
      final value = arguments['username'] ?? arguments['handle'];
      if (value is String) raw = value;
    }

    final handle = raw?.replaceFirst('@', '').trim();
    return (handle == null || handle.isEmpty) ? null : handle;
  }
}

class _UnknownRoute extends StatelessWidget {
  final String? name;

  const _UnknownRoute({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page not found')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            name == null
                ? 'That screen does not exist.'
                : 'No screen is registered for "$name".',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
