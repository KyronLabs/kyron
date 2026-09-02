// lib/widgets/app_input_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A text field on the auth screens.
///
/// Everything about how it looks now comes from the shared
/// `InputDecorationTheme`. It used to set its own fill colour, its own
/// 18-pixel vertical padding and its own outline at rest -- which is why the
/// sign-in and sign-up screens kept the old bulky look after every other
/// screen had moved on: they never read the theme at all.
///
/// What is left here is what is genuinely specific to a field: its hint, its
/// keyboard, its validator, and an optional prefix.
class AppInputField extends StatelessWidget {
  final String? hint;

  /// Shown above the field. Auth screens previously relied on the hint alone,
  /// which vanishes the moment anyone starts typing.
  final String? label;

  final TextEditingController? controller;
  final Widget? prefix;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final bool autocorrect;

  const AppInputField({
    super.key,
    this.hint,
    this.label,
    this.controller,
    this.prefix,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.inputFormatters,
    this.onChanged,
    this.maxLines,
    this.maxLength,
    this.textInputAction,
    this.autocorrect = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      textInputAction: textInputAction,
      autocorrect: autocorrect,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefix,
        // Sized to the theme's own density rather than Material's default,
        // which reserves a 48-wide box and pushes the text off centre.
        prefixIconConstraints: prefix == null
            ? null
            : const BoxConstraints(minWidth: 42, minHeight: 0),
        // The screens that use this show their own count where they want one;
        // the built-in counter rendered a second, differently formatted one.
        counterText: '',
      ),
    );
  }
}
