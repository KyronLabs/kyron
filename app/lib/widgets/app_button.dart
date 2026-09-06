// lib/widgets/app_button.dart
import 'package:flutter/material.dart';

/// The full-width button at the foot of an auth form.
///
/// A plain [FilledButton] and an [OutlinedButton] under the name, so it is
/// whatever the theme says a button is. It was an ActionButton before, which
/// forces a 48-pixel height -- eight taller than the same button on the
/// settings screens, and the reason the auth screens read as heavier than the
/// rest of the app.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isOutlined;
  final bool isLoading;

  /// When false the button is visibly inert. Screens used to fake this by
  /// returning early from onTap, which is indistinguishable from a broken
  /// button: it depresses and nothing happens.
  final bool enabled;

  /// An optional leading icon, at the 18-pixel size the rest of the app uses.
  final IconData? icon;

  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isOutlined = false,
    this.isLoading = false,
    this.enabled = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final onPressed = (enabled && !isLoading) ? onTap : null;
    final child = isLoading
        ? const SizedBox.square(
            dimension: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(label);
    // Full width without a fixed height: the height is the theme's, and the
    // width comes from the stretch the auth forms already put it in.
    final style = ButtonStyle(
      minimumSize: WidgetStateProperty.all(const Size.fromHeight(_height)),
      shape: const WidgetStatePropertyAll(StadiumBorder()),
    );

    if (isOutlined) {
      return icon == null
          ? OutlinedButton(onPressed: onPressed, style: style, child: child)
          : OutlinedButton.icon(
              onPressed: onPressed,
              style: style,
              icon: Icon(icon, size: 18),
              label: child,
            );
    }
    return icon == null
        ? FilledButton(onPressed: onPressed, style: style, child: child)
        : FilledButton.icon(
            onPressed: onPressed,
            style: style,
            icon: Icon(icon, size: 18),
            label: child,
          );
  }

  /// What a FilledButton is under this theme. Named rather than left to the
  /// framework's default so the outlined variant cannot drift away from it.
  static const double _height = 40;
}
