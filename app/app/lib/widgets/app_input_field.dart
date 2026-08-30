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
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? maxLength;

  const AppInputField({
    super.key,
    this.hint,
    this.controller,
    this.prefix,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.inputFormatters,
    this.onChanged,
    this.maxLines,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;
    final fillColor = isDark ? AppTheme.darkSurface : AppTheme.lightSurface;
    final hintColor = isDark 
        ? AppTheme.darkTextSecondary.withOpacity(0.6)
        : AppTheme.lightTextSecondary;
    final hasPrefix = prefix != null;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatters,
      style: Theme.of(context).textTheme.bodyLarge,
      onChanged: onChanged,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: hintColor,
          letterSpacing: 0,
        ),
        prefixIcon: hasPrefix
            ? Padding(
                padding: const EdgeInsets.only(left: AppTheme.space16, right: 0),
                child: prefix,
              )
            : null,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        contentPadding: EdgeInsets.only(
          left: hasPrefix ? AppTheme.space8 : AppTheme.space16,
          right: AppTheme.space16,
          top: AppTheme.space16,
          bottom: AppTheme.space16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          borderSide: BorderSide(color: hintColor.withOpacity(0.3), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          borderSide: BorderSide(color: scheme.primary, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          borderSide: const BorderSide(color: AppTheme.errorPink, width: 1.4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          borderSide: const BorderSide(color: AppTheme.errorPink, width: 1.4),
        ),
      ),
    );
  }
}
