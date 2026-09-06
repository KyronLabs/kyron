// lib/widgets/action_sheet.dart
import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import 'hairline.dart';

/// One line in an [ActionSheet].
class SheetAction<T> {
  final T value;
  final String label;
  final IconData icon;

  /// A second line under the label, when the choice needs explaining.
  final String? detail;

  /// Painted in the error colour. For the one that removes something.
  final bool destructive;

  /// Ticked. For a sheet that picks one of a set rather than does something.
  final bool selected;

  const SheetAction({
    required this.value,
    required this.label,
    required this.icon,
    this.detail,
    this.destructive = false,
    this.selected = false,
  });
}

/// The menu Kyron uses.
///
/// A sheet, never a dropdown. A popup menu opens wherever the button happens
/// to be -- against the top edge of the screen on a row near the top, under
/// the reader's hand on one near the bottom -- and its rows are too small to
/// hit accurately on a phone. This always arrives from the same place, at the
/// same size, within reach.
class ActionSheet {
  const ActionSheet._();

  /// Shows [actions] and answers with whichever was chosen, or null.
  static Future<T?> show<T>(
    BuildContext context, {
    required List<SheetAction<T>> actions,
    String? title,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      showDragHandle: true,
      // Tall menus scroll rather than being cut off at the top.
      isScrollControlled: true,
      builder: (context) {
        final scheme = Theme.of(context).colorScheme;

        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.7,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      SpacingTokens.space20,
                      0,
                      SpacingTokens.space20,
                      SpacingTokens.space12,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.4,
                              color: scheme.onSurface.withValues(alpha: 0.55),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Hairline(),
                ],
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      vertical: SpacingTokens.space8,
                    ),
                    children: [
                      for (final action in actions)
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: SpacingTokens.space20,
                          ),
                          leading: Icon(
                            action.icon,
                            size: 21,
                            color: action.destructive ? scheme.error : null,
                          ),
                          title: Text(
                            action.label,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: action.destructive ? scheme.error : null,
                            ),
                          ),
                          subtitle: action.detail == null
                              ? null
                              : Text(
                                  action.detail!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        scheme.onSurface.withValues(alpha: 0.6),
                                  ),
                                ),
                          trailing: action.selected
                              ? Icon(
                                  Icons.check_rounded,
                                  size: 20,
                                  color: scheme.primary,
                                )
                              : null,
                          selected: action.selected,
                          onTap: () => Navigator.pop(context, action.value),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
