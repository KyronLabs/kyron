import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PasswordRequirements extends StatelessWidget {
  final String password;

  const PasswordRequirements({super.key, required this.password});

  bool get hasMinLength => password.length >= 8;
  bool get hasUppercase => password.contains(RegExp(r'[A-Z]'));
  bool get hasLowercase => password.contains(RegExp(r'[a-z]'));
  bool get hasNumber => password.contains(RegExp(r'[0-9]'));
  bool get hasSymbol => password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

  Widget _row(String text, bool ok, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;
    
    // Dynamic colors
    final successColor = const Color(0xFF4CD4B0);
    final inactiveColor = isDark 
        ? const Color(0xFF7E8A9A) 
        : AppTheme.lightTextSecondary;
    final textColor = ok ? (isDark ? Colors.white : scheme.onSurface) : inactiveColor;

    return Row(
      children: [
        Icon(
          ok ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 16,
          color: ok ? successColor : inactiveColor,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(fontSize: 14, color: textColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Minimum 8 characters', hasMinLength, context),
        const SizedBox(height: 6),
        _row('Uppercase letter (A–Z)', hasUppercase, context),
        const SizedBox(height: 6),
        _row('Lowercase letter (a–z)', hasLowercase, context),
        const SizedBox(height: 6),
        _row('At least one number', hasNumber, context),
        const SizedBox(height: 6),
        _row('Symbol (!@#…)', hasSymbol, context),
      ],
    );
  }
}
