import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../../providers/composer_provider.dart';

/// How much of the post is used, and how much is left.
class CharCounter extends ConsumerWidget {
  const CharCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final state = ref.watch(composerProvider);
    final over = state.isOverLimit;
    // Warn before the limit, not at it: the bar turning colour with nothing
    // left to type is a report, not a warning.
    final near = state.charProgress > 0.9;
    final color = over
        ? scheme.error
        : near
            ? scheme.tertiary
            : scheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space16,
        vertical: SpacingTokens.space4,
      ),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(RadiusTokens.radius2),
              child: LinearProgressIndicator(
                value: state.charProgress,
                backgroundColor: scheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 4,
              ),
            ),
          ),
          const SizedBox(width: SpacingTokens.space12),
          Text(
            '${state.charCount}/${ComposerState.maxCharacters}',
            style: TextStyle(
              fontSize: 11,
              fontWeight: over ? FontWeight.w700 : FontWeight.w400,
              color:
                  over ? scheme.error : scheme.onSurface.withValues(alpha: .6),
            ),
          ),
        ],
      ),
    );
  }
}
