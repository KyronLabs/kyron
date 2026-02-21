// lib/routes.dart
import 'package:flutter/material.dart';
import 'models/onboarding_model.dart';
import 'models/profile_model.dart';
import 'screens/settings_screen.dart';
import 'screens/settings_subscreens.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/signup_verify_email.dart';
import 'screens/main_container.dart';
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
  static const webview = '/webview';
  static const settings = '/settings';
  static const notifications = '/notifications';
  static const postDetail = '/post';
  static const profile = '/profile';
  static const community = '/community';
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
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case '/welcome':
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case '/verify-email':
        final args = settings.arguments as Map<String, String>?;
        return MaterialPageRoute(
          builder: (_) => SignupVerifyEmailScreen(
            email: args?['email'] ?? '',
            userId: args?['userId'] ?? '',
          ),
        );

      case '/onboard/step1':
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => OnboardStep1Screen(
            model: args is OnboardingModel ? args : OnboardingModel(),
          ),
        );

      case '/onboard/step2':
        final args = settings.arguments as OnboardingModel;
        return MaterialPageRoute(builder: (_) => OnboardStep2Screen(model: args));

      case '/onboard/step3':
        final args = settings.arguments as OnboardingModel;
        return MaterialPageRoute(builder: (_) => OnboardStep3Screen(model: args));

      case '/forgot':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      case '/home':
        return MaterialPageRoute(builder: (_) => const MainContainer());

      case '/profile':
        final args = settings.arguments;
  
        if (args is ProfileModel) {
          return MaterialPageRoute(
            builder: (_) => ProfileScreen(
              did: args.did,
              profile: args,
            ),
          );
        } else if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => ProfileScreen(
              did: args['did'] ?? '',
              handle: args['handle'],
            ),
          );
        } else if (args is String) {
          return MaterialPageRoute(
            builder: (_) => ProfileScreen(did: args),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => ProfileScreen(
              did: 'did:plc:currentuser',
              handle: '@current',
            ),
          );
        }
        
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      case '/notifications':
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

      case '/settings/change-email':
        return MaterialPageRoute(builder: (_) => const SettingsChangeEmailScreen());
        
      case '/settings/blocked-users':
        return MaterialPageRoute(builder: (_) => const SettingsBlockedUsersScreen());
        
      case '/settings/password-login':
        return MaterialPageRoute(builder: (_) => const SettingsPasswordLoginScreen());
        
      case '/settings/font-size':
        return MaterialPageRoute(builder: (_) => const SettingsFontSizeScreen());
        
      case '/settings/language':
        return MaterialPageRoute(builder: (_) => const SettingsLanguageScreen());
        
      case '/settings/notifications':
        return MaterialPageRoute(builder: (_) => const SettingsNotificationsScreen());
        
      case '/settings/contact-support':
        return MaterialPageRoute(builder: (_) => const SettingsContactSupportScreen());
        
      case '/settings/feedback':
        return MaterialPageRoute(builder: (_) => const SettingsFeedbackScreen());

      case '/composer':
        return MaterialPageRoute(builder: (_) => const ComposerScreen());

      case '/webview':
        final args = settings.arguments as Map<String, String>?;
        return MaterialPageRoute(
          builder: (_) => WebViewScreen(
            url: args?['url'] ?? '',
            title: args?['title'],
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}