// lib/widgets/list_message.dart
import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// What a list says when it has nothing to show.
///
/// One widget for empty and for failed, because the two are the same shape and
/// were drifting apart: the feed's version had a title, a detail line and a
/// 48px icon, the follow lists' had one line of text and a 40px one, and
/// anything new got a third.
class ListMessage extends StatelessWidget {
  final IconData icon;
  final String title;

  /// The line under the title. Omitted when the title says it all.
  final String? detail;

  /// The button under it, and what it does. Both or neither.
  final String? action;
  final VoidCallback? onAction;

  const ListMessage({
    super.key,
    required this.icon,
    required this.title,
    this.detail,
    this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final detail = this.detail;
    final action = this.action;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space32,
        vertical: SpacingTokens.space40,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: scheme.onSurface.withValues(alpha: 0.35)),
          const SizedBox(height: SpacingTokens.space16),
          Text(title,
              textAlign: TextAlign.center, style: theme.textTheme.titleMedium),
          if (detail != null) ...[
            const SizedBox(height: SpacingTokens.space8),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
          if (action != null && onAction != null) ...[
            const SizedBox(height: SpacingTokens.space20),
            TextButton(onPressed: onAction, child: Text(action)),
          ],
        ],
      ),
    );
  }

  /// The same thing, filling what is left of a scroll view.
  ///
  /// [AlwaysScrollableScrollPhysics] on the list around it is what keeps
  /// pull-to-refresh working when there is nothing to scroll.
  Widget get sliver => SliverFillRemaining(hasScrollBody: false, child: this);
}
