// lib/widgets/app_input_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class AppInputField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final Widget? prefix;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  // NEW -------------------------------------------------
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? maxLength;
  // -----------------------------------------------------

  const AppInputField({
    super.key,
    this.hint,
    this.controller,
    this.prefix,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.inputFormatters,
    this.onChanged,      // NEW
    this.maxLines,       // NEW
    this.maxLength,      // NEW
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;

    final fillColor   = isDark ? const Color(0xFF1A1A1D) : AppTheme.lightSurface;
    final hintColor   = isDark ? Colors.white.withValues(alpha: 0.6) : AppTheme.lightTextSecondary;
    final hasPrefix   = prefix != null;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatters,
      style: Theme.of(context).textTheme.bodyLarge,
      onChanged: onChanged,                // NEW
      maxLines: maxLines ?? 1,             // NEW
      maxLength: maxLength,                // NEW
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: hintColor),
        prefixIcon: hasPrefix
            ? Padding(
                padding: const EdgeInsets.only(left: 16, right: 0),
                child: prefix,
              )
            : null,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        contentPadding: EdgeInsets.only(
          left: hasPrefix ? 6 : 16,
          right: 16,
          top: 18,
          bottom: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: hintColor.withValues(alpha: 0.3), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.primary, width: 1.4),
        ),
      ),
    );
  }
}
