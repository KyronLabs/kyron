import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';
import '../widgets/google_button.dart';
import '../widgets/app_button.dart';
import '../widgets/app_language_selector.dart';
import '../routes.dart';
import '../widgets/gradient_scaffold.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppLogo(size: 96),
                const SizedBox(height: 20),
                Text('Welcome back.', style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(height: 12),
                Text("Let's get started.", style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 28),
                GoogleButton(onTap: () {/* connect google */}),
                const SizedBox(height: 12),
                AppButton(
                  label: 'Login', 
                  onTap: () => Navigator.of(context).pushReplacementNamed(Routes.login), // ✅ FIXED
                ),
                const SizedBox(height: 12),
                AppButton(
                  label: 'Create Account', 
                  onTap: () => Navigator.of(context).pushReplacementNamed(Routes.signup), // ✅ FIXED
                  isOutlined: true,
                ),
                const SizedBox(height: 20),
                AppLanguageSelector(selected: 'English', onChanged: (v) {/* ui only */}),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.webview, arguments: {
                          'url': 'https://kyron-terms-and-privacy.onrender.com/terms.html',
                          'title': 'Terms of Service',
                        });
                      },
                      child: Text(
                        'Terms of Service',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.accent,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.webview, arguments: {
                          'url': 'https://kyron-terms-and-privacy.onrender.com/privacy.html',
                          'title': 'Privacy Policy',
                        });
                      },
                      child: Text(
                        'Privacy Policy',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.accent,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}