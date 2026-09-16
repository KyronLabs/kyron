import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/app_input_field.dart';
import '../widgets/password_input_field.dart';
import '../widgets/app_button.dart';
import '../routes.dart';

import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/auth_provider.dart';
import '../config/legal_links.dart';
import '../services/app_browser.dart';
import '../utils/validators.dart';
import '../widgets/kyron_app_bar.dart';
import '../l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    // Use authNotifier instead of AuthRepository directly
    final authNotifier = ref.read(authNotifierProvider.notifier);
    final success = await authNotifier.login(
      _email.text.trim(),
      _password.text.trim(),
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      // CRITICAL FIX: Navigate to home with cleared stack
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (_) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).loginFailed,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KyronAppBar(
        title: Text(AppLocalizations.of(context).signInToKyron),
      ),
      body: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),

              AppInputField(
                hint: AppLocalizations.of(context).email,
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email,
              ),

              const SizedBox(height: 12),

              PasswordInputField(
                controller: _password,
                validator: (v) => (v?.length ?? 0) < 6
                    ? AppLocalizations.of(context).passwordTooShort
                    : null,
              ),

              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Routes.forgot),
                  child: Text(AppLocalizations.of(context).forgotPassword),
                ),
              ),

              const SizedBox(height: 12),

              AppButton(
                label: AppLocalizations.of(context).login,
                onTap: _submit,
                isLoading: _isLoading,
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: KyronTheme.darkTextSecondary.withOpacity(0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      AppLocalizations.of(context).or,
                      style: TextStyle(
                        color: KyronTheme.darkTextSecondary.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: KyronTheme.darkTextSecondary.withOpacity(0.3),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () => Navigator.of(context).pushNamed(Routes.signup),
                child: Text(AppLocalizations.of(context).createAccount),
              ),

              const Spacer(),

              // Updated Terms & Privacy section using RichText with tappable spans
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      '${AppLocalizations.of(context).byContinuingAgreeTerms} ',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context).terms,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: KyronTheme.accent,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          AppBrowser.open(
                            context,
                            LegalLinks.terms,
                            title: LegalLinks.termsTitle,
                          );
                        },
                    ),
                    TextSpan(
                      text: ' ${AppLocalizations.of(context).and} ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).privacyPolicy,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: KyronTheme.accent,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          AppBrowser.open(
                            context,
                            LegalLinks.privacy,
                            title: LegalLinks.privacyTitle,
                          );
                        },
                    ),
                    TextSpan(
                      text: '.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
