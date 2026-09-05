// lib/widgets/topic_picker.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/composer_provider.dart';
import '../providers/explore_provider.dart';

/// Files the post being written under up to three topics.
///
/// The author's choice, from the same catalogue people pick from when they say
/// what they are into -- not something read out of the text. A hashtag is
/// whatever somebody typed; filing a post under a topic is a deliberate act,
/// which is the whole reason it is worth more than the hashtags.
///
/// Nothing at all when the catalogue is empty or could not be read: an
/// interactive row that cannot do anything is worse than no row.
class TopicPicker extends ConsumerWidget {
  const TopicPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogue = ref.watch(topicsProvider);
    final chosen = ref.watch(composerProvider).topics;

    if (catalogue.loading || catalogue.items.isEmpty) {
      return const SizedBox.shrink();
    }

    final scheme = Theme.of(context).colorScheme;
    final full = chosen.length >= ComposerState.maxTopics;

    // The chosen ones first, so a picked topic never scrolls out of sight
    // behind forty others.
    final ordered = [
      ...catalogue.items.where((t) => chosen.contains(t.slug)),
      ...catalogue.items.where((t) => !chosen.contains(t.slug)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: SpacingTokens.space12),
        Row(
          children: [
            Icon(
              Iconsax.category_copy,
              size: 15,
              color: scheme.onSurface.withValues(alpha: 0.55),
            ),
            const SizedBox(width: SpacingTokens.space4),
            Text(
              chosen.isEmpty
                  ? 'Add a topic'
                  : 'Filed under ${chosen.length} of '
                      '${ComposerState.maxTopics}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ],
        ),
        const SizedBox(height: SpacingTokens.space8),
        SizedBox(
          height: 34,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: ordered.length,
            separatorBuilder: (_, __) =>
                const SizedBox(width: SpacingTokens.space8),
            itemBuilder: (context, index) {
              final topic = ordered[index];
              final on = chosen.contains(topic.slug);
              return _TopicChip(
                label: topic.name,
                selected: on,
                // Past the limit the remaining chips go inert rather than
                // taking a tap and answering with a message. A rule you can
                // see beats one you find out about.
                enabled: on || !full,
                onTap: () {
                  HapticFeedback.selectionClick();
                  ref.read(composerProvider.notifier).toggleTopic(topic.slug);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TopicChip extends StatelessWidget {
  final String label;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  const _TopicChip({
    required this.label,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(RadiusTokens.radiusFull);

    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: Material(
        color: selected
            ? scheme.primary.withValues(alpha: 0.14)
            : scheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: enabled ? onTap : null,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(
                color: selected
                    ? scheme.primary.withValues(alpha: 0.6)
                    : scheme.outline.withValues(alpha: 0.2),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space12,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selected) ...[
                  Icon(Iconsax.tick_circle, size: 15, color: scheme.primary),
                  const SizedBox(width: SpacingTokens.space4),
                ],
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: selected ? scheme.primary : scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
