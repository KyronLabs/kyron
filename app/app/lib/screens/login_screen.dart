import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/app_input_field.dart';
import '../widgets/password_input_field.dart';
import '../widgets/app_button.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';

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
      Navigator.pushNamedAndRemoveUntil(
        context, 
        Routes.home, 
        (_) => false
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Login failed. Please check your credentials.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in to Kyron')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),

              AppInputField(
                hint: 'Email',
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                validator: (v) => (v?.isEmpty ?? true)
                    ? 'Enter your email'
                    : null,
              ),

              const SizedBox(height: 12),

              PasswordInputField(
                controller: _password,
                validator: (v) =>
                    (v?.length ?? 0) < 6 ? 'Password too short' : null,
              ),

              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Routes.forgot),
                  child: const Text('Forgot password?'),
                ),
              ),

              const SizedBox(height: 12),

              AppButton(
                label: 'Login',
                onTap: _submit,
                isLoading: _isLoading,
              ),

              const SizedBox(height: 12),

              Row(children: [
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: AppTheme.textSecondary.withOpacity(0.3),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'or',
                    style: TextStyle(
                      color: AppTheme.textSecondary.withOpacity(0.6),
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: AppTheme.textSecondary.withOpacity(0.3),
                  ),
                ),
              ]),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(Routes.signup),
                child: const Text('Create account'),
              ),

              const Spacer(),

              // Updated Terms & Privacy section using RichText with tappable spans
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'By continuing you agree to our ',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: 'Terms',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                            color: AppTheme.accent,
                            decoration: TextDecoration.underline,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(
                            context,
                            Routes.webview,
                            arguments: {
                              'url':
                                  'https://kyron-terms-and-privacy.onrender.com/terms.html',
                              'title': 'Terms of Service',
                            },
                          );
                        },
                    ),
                    TextSpan(
                      text: ' and ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                            color: AppTheme.accent,
                            decoration: TextDecoration.underline,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(
                            context,
                            Routes.webview,
                            arguments: {
                              'url':
                                  'https://kyron-terms-and-privacy.onrender.com/privacy.html',
                              'title': 'Privacy Policy',
                            },
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