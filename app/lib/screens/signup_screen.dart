import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../widgets/app_input_field.dart';
import '../widgets/password_input_field.dart';
import '../widgets/app_button.dart';
import '../widgets/password_requirements.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../repositories/auth_repository.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    try {
      final repo = AuthRepository();

      final res = await repo.register(
        email: _email.text.trim(),
        password: _password.text.trim(),
        username: _username.text.trim().isEmpty ? null : _username.text.trim(),
      );

      // backend now returns `userId` explicitly
      final userId = (res.data as Map<String, dynamic>)['userId'] as String?;

      if (userId == null) {
        // If backend didn't return it, show a helpful message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup succeeded but server did not return userId')),
        );
        return;
      }

      if (!mounted) return;

      Navigator.pushNamed(
        context,
        Routes.signupVerifyEmail,
        arguments: {
          'email': _email.text.trim(),
          'userId': userId,
        },
      );
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: $err')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create your account')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),

              // USERNAME
              AppInputField(
                hint: 'Username',
                prefix: const Text('@', style: TextStyle(color: Color(0xFF7E8A9A))),
                controller: _username,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9_]')),
                ],
                validator: (v) {
                  if (v?.isEmpty ?? true) return null; // allow empty username
                  if (!RegExp(r'^[a-z0-9_]+$').hasMatch(v!)) {
                    return 'Username must be lowercase (a-z, 0-9, _)';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // EMAIL
              AppInputField(
                hint: 'Email',
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v?.isEmpty ?? true) return 'Enter email';
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // PASSWORD
              PasswordInputField(
                controller: _password,
                validator: (v) =>
                    (v?.length ?? 0) < 8 ? 'Password too short' : null,
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 12),

              PasswordRequirements(password: _password.text),

              const SizedBox(height: 16),

              AppButton(
                label: 'Continue',
                onTap: _submit,
                isLoading: _isLoading,
              ),

              const Spacer(),

              // TERMS + PRIVACY
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "By signing up you agree to our ",
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: "Terms",
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
                              "url":
                                  "https://kyron-terms-and-privacy.onrender.com/terms.html",
                              "title": "Terms of Service",
                            },
                          );
                        },
                    ),
                    TextSpan(
                      text: " and ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: "Privacy Policy",
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
                              "url":
                                  "https://kyron-terms-and-privacy.onrender.com/privacy.html",
                              "title": "Privacy Policy",
                            },
                          );
                        },
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
