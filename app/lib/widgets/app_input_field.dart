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

  /// Sits inline with the text, not in an icon slot. An `@` in front of a
  /// handle is part of the value being typed; as a prefixIcon it was given a
  /// 42-wide box of its own and left a gap the width of a word between it and
  /// the hint.
  final String? prefixText;
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
    this.prefixText,
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
      // No size of its own. Overriding this to 15 is what made every auth
      // field two pixels shorter than the identical field on a settings
      // screen, which is the sort of difference you feel without seeing.
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixText: prefixText,
        // The screens that use this show their own count where they want one;
        // the built-in counter rendered a second, differently formatted one.
        counterText: '',
      ),
    );
  }
}
