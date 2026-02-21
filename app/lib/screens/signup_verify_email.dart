import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/gradient_scaffold.dart';
import '../widgets/app_button.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../repositories/auth_repository.dart';
import '../models/onboarding_model.dart';

class SignupVerifyEmailScreen extends StatefulWidget {
  final String email;
  final String userId;

  const SignupVerifyEmailScreen({
    super.key,
    required this.email,
    required this.userId,
  });

  @override
  State<SignupVerifyEmailScreen> createState() => _SignupVerifyEmailScreenState();
}

class _SignupVerifyEmailScreenState extends State<SignupVerifyEmailScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(6, (_) => FocusNode());

  bool _isLoading = false;
  bool _canResend = false;
  int _countdown = 60;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var n in _focusNodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _startCountdown() {
    setState(() => _canResend = false);
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _countdown--;
        if (_countdown > 0) {
          _startCountdown();
        } else {
          _canResend = true;
          _countdown = 60;
        }
      });
    });
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  String get _code => _controllers.map((c) => c.text).join();

  Future<void> _verify() async {
    if (_code.length != 6) return;

    setState(() => _isLoading = true);

    try {
      final repo = AuthRepository();
      await repo.verifyEmail(
        userId: widget.userId,
        code: _code,
      );

      if (!mounted) return;

      // Navigate to onboarding step 1 with the correct model
      Navigator.pushReplacementNamed(
        context,
        Routes.onboardStep1,
        arguments: OnboardingModel()
          ..displayName = widget.email.split('@')[0] // Use email prefix as display name
          ..bio = '',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Verification failed: $e")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _resendCode() {
    _startCountdown();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Verification code resent.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(title: const Text("Verify Email")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Icon(Icons.email_outlined, size: 64, color: AppTheme.accent),

            const SizedBox(height: 24),

            Text(
              "Enter the 6-digit code",
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            Text(
              "We sent it to ${widget.email}",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (i) {
                return SizedBox(
                  width: 56,
                  height: 72,
                  child: TextFormField(
                    controller: _controllers[i],
                    focusNode: _focusNodes[i],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) => _onDigitChanged(i, value),
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 28),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppTheme.lightSurface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppTheme.lightTextSecondary.withValues(alpha: 0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppTheme.accent,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 32),

            AppButton(
              label: "Verify",
              onTap: _verify,
              isLoading: _isLoading,
            ),

            const Spacer(),

            Center(
              child: _canResend
                  ? TextButton(
                      onPressed: _resendCode,
                      child: const Text("Resend code"),
                    )
                  : Text(
                      "Resend code in $_countdown seconds",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppTheme.lightTextSecondary),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
