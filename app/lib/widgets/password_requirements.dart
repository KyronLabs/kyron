import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
    final inactiveColor =
        isDark ? const Color(0xFF7E8A9A) : KyronTheme.lightTextSecondary;
    final textColor =
        ok ? (isDark ? Colors.white : scheme.onSurface) : inactiveColor;

    return Row(
      children: [
        Icon(
          ok ? Iconsax.tick_circle : Iconsax.record_copy,
          size: 16,
          color: ok ? successColor : inactiveColor,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: TypographyTokens.fontSize2,
            color: textColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row(
          l10n.ui('ui_pw_rule_length', 'Minimum 8 characters'),
          hasMinLength,
          context,
        ),
        const SizedBox(height: 6),
        _row(
          l10n.ui('ui_pw_rule_upper', 'Uppercase letter (A–Z)'),
          hasUppercase,
          context,
        ),
        const SizedBox(height: 6),
        _row(
          l10n.ui('ui_pw_rule_lower', 'Lowercase letter (a–z)'),
          hasLowercase,
          context,
        ),
        const SizedBox(height: 6),
        _row(
          l10n.ui('ui_pw_rule_number', 'At least one number'),
          hasNumber,
          context,
        ),
        const SizedBox(height: 6),
        _row(l10n.ui('ui_pw_rule_symbol', 'Symbol (!@#…)'), hasSymbol, context),
      ],
    );
  }
}
