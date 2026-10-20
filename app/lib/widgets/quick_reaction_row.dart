// lib/widgets/quick_reaction_row.dart
import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// The reactions a long press offers before anything else: the six every
/// messenger has settled on.
const List<String> quickReactions = ['❤️', '😂', '😮', '😢', '😡', '👍'];

/// The quick reactions in a row, above a message's actions.
class QuickReactionRow extends StatelessWidget {
  const QuickReactionRow({
    super.key,
    required this.selected,
    required this.onPick,
  });

  /// The reader's current reaction, drawn picked so choosing it again reads
  /// as taking it back.
  final String? selected;
  final void Function(String emoji) onPick;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // As wide as the six of them and no wider: a pill over the message, not
    // a toolbar across the screen.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final emoji in quickReactions)
            InkResponse(
              onTap: () => onPick(emoji),
              radius: 26,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: emoji == selected
                      ? scheme.primary.withValues(alpha: 0.15)
                      : null,
                ),
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: TypographyTokens.fontSize6),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
