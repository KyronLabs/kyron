import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_app/screens/main_container.dart';
import '../providers/auth_provider.dart';
import '../screens/home_screen.dart';
import '../screens/welcome_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/onboard_step1_screen.dart';
import '../models/onboarding_model.dart';

class RootScreen extends ConsumerWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    
    print('🔄 RootScreen: authState.status = ${authState.status}, user = ${authState.user?.email}');

    // If we're still determining auth state, show splash
    if (authState.status == AuthStatus.unknown || 
        authState.status == AuthStatus.authenticating) {
      print('📱 RootScreen: Showing SplashScreen (auth state: ${authState.status})');
      return const SplashScreen();
    }

    // If unauthenticated, show welcome
    if (authState.status == AuthStatus.unauthenticated) {
      print('📱 RootScreen: Showing WelcomeScreen (unauthenticated)');
      return const WelcomeScreen();
    }

    // If authenticated, check onboarding
    if (authState.status == AuthStatus.authenticated) {
      final user = authState.user;
      print('📱 RootScreen: User authenticated: ${user?.email}, checking onboarding...');
      
      // Use a FutureBuilder to check onboarding status
      return FutureBuilder<bool>(
        future: _checkOnboardingStatus(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('📱 RootScreen: Checking onboarding status...');
            return const SplashScreen();
          }
          
          final hasCompletedOnboarding = snapshot.data ?? false;
          print('📱 RootScreen: Onboarding complete? $hasCompletedOnboarding');
          
          if (!hasCompletedOnboarding && user != null) {
            print('📱 RootScreen: Showing OnboardStep1Screen');
            return OnboardStep1Screen(
              model: OnboardingModel()
                ..displayName = user.name ?? user.email.split('@')[0]
                ..bio = '',
            );
          }
          
          print('📱 RootScreen: Showing HomeScreen');
          return const MainContainer();
        },
      );
    }

    // Fallback
    print('📱 RootScreen: Fallback to SplashScreen');
    return const SplashScreen();
  }

  Future<bool> _checkOnboardingStatus(WidgetRef ref) async {
    final authRepo = ref.read(authRepositoryProvider);
    try {
      final isComplete = await authRepo.isOnboardingComplete();
      print('✅ RootScreen: Onboarding check result: $isComplete');
      return isComplete;
    } catch (e) {
      print('❌ RootScreen: Error checking onboarding: $e');
      return false;
    }
  }
}