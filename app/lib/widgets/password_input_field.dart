// lib/widgets/password_input_field.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

/// A password field, with a reveal toggle.
///
/// Like [AppInputField], everything about how it looks comes from the shared
/// `InputDecorationTheme` now. It used to carry its own fill, padding and four
/// separate `OutlineInputBorder`s, which is why the auth screens never picked
/// up the theme the rest of the app uses.
class PasswordInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;

  /// Set on a sign-in field so the keyboard does not offer to generate a new
  /// password over an existing one.
  final bool isNew;

  const PasswordInputField({
    super.key,
    this.controller,
    this.hint,
    this.label = 'Password',
    this.validator,
    this.onChanged,
    this.textInputAction,
    this.onSubmitted,
    this.isNew = false,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      textInputAction: widget.textInputAction,
      autocorrect: false,
      enableSuggestions: false,
      autofillHints: [
        widget.isNew ? AutofillHints.newPassword : AutofillHints.password,
      ],
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 0,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 6),
          child: IconButton(
            onPressed: () => setState(() => _obscure = !_obscure),
            iconSize: 18,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            visualDensity: VisualDensity.compact,
            tooltip: _obscure ? 'Show password' : 'Hide password',
            icon: Icon(
              _obscure ? Iconsax.eye_slash_copy : Iconsax.eye_copy,
              color: scheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
        ),
      ),
    );
  }
}
