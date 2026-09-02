// lib/widgets/app_button.dart
import 'package:flutter/material.dart';

import 'action_button.dart';

/// The full-width button at the foot of an auth form.
///
/// Kept as its own name because a dozen call sites use it, but it is now
/// [ActionButton] underneath rather than a fourth hand-rolled button style.
/// The auth screens had their own `ElevatedButton.styleFrom` with a 14-pixel
/// radius while everything else was a stadium, which is part of why they
/// looked untouched by the rest of the design work.
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
    return ActionButton(
      label: label,
      icon: icon,
      kind: isOutlined ? ActionButtonKind.outlined : ActionButtonKind.primary,
      expand: true,
      busy: isLoading,
      onPressed: enabled ? onTap : null,
    );
  }
}
