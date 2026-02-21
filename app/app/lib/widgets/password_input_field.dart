import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const PasswordInputField({
    super.key,
    this.controller,
    this.hint = 'Password',
    this.validator,
    this.onChanged,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;
    
    // Dynamic colors based on theme
    final fillColor = isDark ? const Color(0xFF1A1A1D) : AppTheme.lightSurface;
    final hintColor = isDark ? Colors.white.withValues(alpha: 0.6) : AppTheme.lightTextSecondary;
    final iconColor = isDark ? const Color(0xFF7E8A9A) : AppTheme.lightTextSecondary;

    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      validator: widget.validator,
      onChanged: widget.onChanged,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: widget.hint,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: hintColor),
        
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        
        // Theme-aware borders
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: hintColor.withValues(alpha: 0.3), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.error, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
        
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(
            _obscure ? Icons.visibility_off : Icons.visibility,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
