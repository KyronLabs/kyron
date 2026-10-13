// lib/widgets/list_controls.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import 'action_button.dart';
import 'hairline.dart';

/// The controls over Messages and Communities: a search box, a row of chips,
/// a filter menu under one of them, and the count a row carries.
///
/// One set for both, so the two lists read as the same kind of place rather
/// than each growing its own search box a few pixels different.

/// The search box over a list.
class ListSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  /// The key on the text field itself, for whoever has to find it.
  final Key? fieldKey;

  const ListSearchField({
    super.key,
    required this.controller,
    required this.hint,
    this.fieldKey,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(RadiusTokens.radius20),
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.search_normal_1_copy,
            size: 18,
            color: scheme.onSurface.withValues(alpha: 0.5),
          ),
          const SizedBox(width: SpacingTokens.space8),
          Expanded(
            child: TextField(
              key: fieldKey,
              controller: controller,
              textInputAction: TextInputAction.search,
              style: const TextStyle(fontSize: TypographyTokens.fontSize3),
              decoration: InputDecoration(
                hintText: hint,
                isDense: true,
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A rounded chip, outlined with the hairline, filled when it is in force.
///
/// The size of the Follow button on a profile -- [ActionButton.compactHeight]
/// tall, its 13-point semibold label and 18-point icon, the same padding --
/// so every small pill in the app is one size. These were 36 tall with a
/// lighter, smaller label, between Follow and the full-size buttons, and
/// looked like neither.
class ListChip extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;
  final String? label;
  final String? tooltip;

  const ListChip({
    super.key,
    required this.selected,
    required this.onTap,
    this.icon,
    this.label,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ink = scheme.onSurface;
    final padding = switch ((icon != null, label != null)) {
      // Icon alone: as near round as a pill gets without being a circle,
      // which would read as a different kind of control.
      (true, false) => const EdgeInsets.symmetric(horizontal: 11),
      (true, true) => const EdgeInsetsDirectional.only(start: 10, end: 14),
      _ => const EdgeInsets.symmetric(horizontal: 14),
    };
    Widget chip = Material(
      color: selected ? scheme.surfaceContainerHighest : Colors.transparent,
      shape: StadiumBorder(side: postRule(scheme)),
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: SizedBox(
          height: ActionButton.compactHeight,
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) Icon(icon, size: 18, color: ink),
                if (icon != null && label != null)
                  const SizedBox(width: SpacingTokens.space4),
                if (label != null)
                  Text(
                    label!,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: ink,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
    if (tooltip != null) chip = Tooltip(message: tooltip!, child: chip);
    return Semantics(selected: selected, button: true, child: chip);
  }
}

/// The row of [ListChip]s under a list's search box: one chip high, scrolling
/// sideways when the chips do not fit.
class ListChipRow extends StatelessWidget {
  final List<Widget> children;

  const ListChipRow({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ActionButton.compactHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space16),
        children: children,
      ),
    );
  }
}

/// A filter menu under the chip that opened it, with a heading and the
/// choice in force ticked. Answers with the one picked, or null.
Future<T?> showListFilterMenu<T>({
  required BuildContext context,
  required BuildContext anchor,
  required String title,
  required List<T> options,
  required T current,
  required String Function(T option) label,
  required Key Function(T option) keyOf,
}) async {
  final box = anchor.findRenderObject() as RenderBox?;
  final overlay = Overlay.of(context).context.findRenderObject() as RenderBox?;
  if (box == null || overlay == null) return null;
  final topLeft = box.localToGlobal(
    Offset(0, box.size.height + SpacingTokens.space4),
    ancestor: overlay,
  );
  final scheme = Theme.of(context).colorScheme;

  return showMenu<T>(
    context: context,
    position: RelativeRect.fromLTRB(
      topLeft.dx,
      topLeft.dy,
      overlay.size.width - topLeft.dx,
      0,
    ),
    color: scheme.surfaceContainerLow,
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(RadiusTokens.radius16),
    ),
    constraints: const BoxConstraints(minWidth: 220),
    items: [
      PopupMenuItem<T>(
        enabled: false,
        height: 32,
        child: Text(
          title,
          style: TextStyle(
            fontSize: TypographyTokens.fontSize1,
            color: scheme.onSurface.withValues(alpha: 0.55),
          ),
        ),
      ),
      for (final option in options)
        PopupMenuItem<T>(
          key: keyOf(option),
          value: option,
          child: Row(
            children: [
              SizedBox(
                width: 24,
                child: option == current
                    ? Icon(
                        Iconsax.tick_circle_copy,
                        size: 18,
                        color: scheme.onSurface,
                      )
                    : null,
              ),
              Text(
                label(option),
                style: const TextStyle(fontSize: TypographyTokens.fontSize3),
              ),
            ],
          ),
        ),
    ],
  );
}

/// How many of something are new, in the accent.
class CountBadge extends StatelessWidget {
  final int count;

  const CountBadge({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      constraints: const BoxConstraints(minWidth: 20),
      height: 20,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
      ),
      child: Text(
        count > 99 ? '99+' : '$count',
        style: TextStyle(
          fontSize: TypographyTokens.fontSize1,
          fontWeight: FontWeight.w700,
          color: scheme.onPrimary,
        ),
      ),
    );
  }
}
