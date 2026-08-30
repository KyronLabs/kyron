import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscure;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const InputField({
    super.key,
    required this.controller,
    required this.label,
    this.obscure = false,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;
    final hintColor = isDark 
        ? AppTheme.darkTextSecondary.withOpacity(0.6)
        : AppTheme.lightTextSecondary;
    
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.circularadius12),
          borderSide: BorderSide(color: hintColor.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.circularadius12),
          borderSide: const BorderSide(color: AppTheme.accent, width: 1.4),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppTheme.space16,
          horizontal: AppTheme.space16,
        ),
        hintStyle: TextStyle(color: hintColor),
      ),
    );
  }
}
