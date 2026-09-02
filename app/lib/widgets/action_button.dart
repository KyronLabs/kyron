// lib/widgets/action_button.dart
import 'package:flutter/material.dart';

/// How much visual weight an [ActionButton] carries.
enum ActionButtonKind {
  /// Solid accent. The one thing on the screen you are meant to press.
  primary,

  /// Accent on a tinted ground. A real action, but not the only one.
  tonal,

  /// A hairline outline. Secondary, or destructive-adjacent.
  outlined,
}

/// The app's button.
///
/// Every button in Kyron should be this one. It exists because the buttons had
/// drifted into four shapes: the design system's `OutlinedButton` and
/// `ElevatedButton` themes both set `minimumSize: Size.fromHeight(48)`, which
/// is Flutter's way of writing *infinite width* -- correct for the single
/// full-width call to action at the bottom of an auth screen, and the reason
/// "Edit profile" grew to swallow the whole profile header.
///
/// The proportions here are Material 3's own, which is what the composer's
/// "Write a text post instead" button was already getting by using a plain
/// `FilledButton.icon`: a 40-tall stadium, 18-pixel icon, eight-pixel gap, and
/// asymmetric padding so the icon does not crowd the leading edge.
///
/// Use [expand] for the full-width case rather than reaching back for the
/// 48-tall themes.
class ActionButton extends StatelessWidget {
  final String label;

  /// Null gives a text-only button, at the same height.
  final IconData? icon;

  /// Null disables the button, visibly.
  final VoidCallback? onPressed;

  final ActionButtonKind kind;

  /// Fill the available width and stand 48 tall: the primary call to action at
  /// the foot of a form.
  final bool expand;

  /// Swaps the label for a spinner and stops presses, without the button
  /// changing size.
  final bool busy;

  /// Paints the label, icon and outline in the error colour.
  final bool destructive;

  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.kind = ActionButtonKind.primary,
    this.expand = false,
    this.busy = false,
    this.destructive = false,
  });

  /// The height of a non-[expand] button. Anything placed beside one -- an
  /// icon button in a header row, say -- should match it.
  static const double height = 40;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onPressed = busy ? null : this.onPressed;

    final foreground = destructive
        ? scheme.error
        : switch (kind) {
            ActionButtonKind.primary => scheme.onPrimary,
            ActionButtonKind.tonal => scheme.primary,
            ActionButtonKind.outlined => scheme.onSurface,
          };

    final style = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(
        expand ? const Size.fromHeight(48) : const Size(0, height),
      ),
      // Without this the 48-tall minimum from the theme is still enforced by
      // the tap target, which leaves an invisible band above and below.
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: WidgetStatePropertyAll(
        EdgeInsetsDirectional.only(start: icon == null ? 20 : 16, end: 20),
      ),
      shape: const WidgetStatePropertyAll(StadiumBorder()),
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          fontSize: expand ? 16 : 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      splashFactory: NoSplash.splashFactory,
      foregroundColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.disabled)
            ? foreground.withValues(alpha: 0.38)
            : foreground,
      ),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        final disabled = states.contains(WidgetState.disabled);
        final base = switch (kind) {
          ActionButtonKind.primary =>
            destructive ? scheme.errorContainer : scheme.primary,
          ActionButtonKind.tonal => scheme.primary.withValues(alpha: 0.12),
          ActionButtonKind.outlined => Colors.transparent,
        };
        return disabled && kind == ActionButtonKind.primary
            ? scheme.onSurface.withValues(alpha: 0.12)
            : base;
      }),
      side: kind == ActionButtonKind.outlined
          ? WidgetStatePropertyAll(
              BorderSide(
                color: (destructive ? scheme.error : scheme.outline)
                    .withValues(alpha: 0.4),
              ),
            )
          : const WidgetStatePropertyAll(BorderSide.none),
      elevation: const WidgetStatePropertyAll(0),
      animationDuration: const Duration(milliseconds: 120),
    );

    // A fixed-size spinner in place of the label, rather than shrinking the
    // button to fit one: a control that changes width when pressed moves
    // whatever sits beside it.
    final child = busy
        ? SizedBox.square(
            dimension: 16,
            child: CircularProgressIndicator(strokeWidth: 2, color: foreground),
          )
        : Text(label, maxLines: 1, overflow: TextOverflow.ellipsis);

    final button = icon == null
        ? TextButton(onPressed: onPressed, style: style, child: child)
        : TextButton.icon(
            onPressed: onPressed,
            style: style,
            icon: Icon(icon, size: 18),
            label: child,
          );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// A round icon-only button sized to sit beside an [ActionButton].
///
/// [IconButton] defaults to a 48-pixel tap target, so one placed next to a
/// 40-tall button pushes the row taller than the button it accompanies and
/// looks misaligned. This matches the height and keeps the target square.
class ActionIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  /// Read out by screen readers, and shown on a long press.
  final String tooltip;

  final bool outlined;

  const ActionIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.outlined = true,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: tooltip,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            width: ActionButton.height,
            height: ActionButton.height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: outlined
                  ? Border.all(color: scheme.outline.withValues(alpha: 0.4))
                  : null,
            ),
            child: Icon(icon, size: 18, color: scheme.onSurface),
          ),
        ),
      ),
    );
  }
}
