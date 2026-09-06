// lib/screens/community_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/community.dart';
import '../providers/communities_provider.dart';
import '../providers/feed_provider.dart';
import '../utils/format_count.dart';
import '../widgets/action_button.dart';
import '../widgets/hairline.dart';
import '../widgets/empty_state.dart';
import '../widgets/post_list_view.dart';
import '../widgets/toast.dart';
import 'community_composer_screen.dart';

/// One community: what it is, who is in it, and what has been posted into it.
class CommunityScreen extends ConsumerWidget {
  final String slug;

  const CommunityScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(communityProvider(slug));
    final notifier = ref.read(communityProvider(slug).notifier);
    final community = state.community;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(community?.name ?? 'Community'),
      ),
      // Only for members. A button that answers "join first" is a button that
      // should not have been there.
      floatingActionButton: community == null || !community.canPost
          ? null
          : FloatingActionButton(
              onPressed: () => _compose(context, ref, community),
              tooltip: 'Post in ${community.name}',
              child: const Icon(Iconsax.edit_2),
            ),
      body: SafeArea(
        child: state.loading
            ? const Center(child: CircularProgressIndicator())
            : community == null
                ? EmptyState.failed(
                    title: 'Could not open this community',
                    detail: state.error,
                    onAction: notifier.refresh,
                  ).scrollable
                : Column(
                    children: [
                      _Header(
                        community: community,
                        busy: state.busy,
                        onToggle: () async {
                          final error = await notifier.toggleMembership();
                          if (!context.mounted) return;
                          if (error != null) {
                            Toast.show(context, error);
                          } else {
                            // Both tabs of the Communities screen are now out
                            // of date about this one.
                            ref.invalidate(myCommunitiesProvider);
                            ref.invalidate(discoverCommunitiesProvider);
                          }
                        },
                      ),
                      const Hairline(),
                      Expanded(
                        child: PostListView(
                          source: PostListSource.community(community.slug),
                          errorTitle: 'Could not load ${community.name}',
                          emptyTitle: 'Nothing posted here yet',
                          emptyDetail: community.joined
                              ? 'Be the first to say something.'
                              : 'Join to post in ${community.name}.',
                          emptyArt: EmptyArt.communities,
                          padding: const EdgeInsets.only(
                            bottom: SpacingTokens.space40,
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Future<void> _compose(
    BuildContext context,
    WidgetRef ref,
    Community community,
  ) async {
    final posted = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => CommunityComposerScreen(community: community),
      ),
    );
    if (posted == true) {
      ref
          .read(postListProvider(PostListSource.community(community.slug))
              .notifier)
          .refresh();
    }
  }
}

class _Header extends StatelessWidget {
  final Community community;
  final bool busy;
  final VoidCallback onToggle;

  const _Header({
    required this.community,
    required this.busy,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final description = community.description?.trim();

    return Padding(
      padding: const EdgeInsets.all(SpacingTokens.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      community.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'c/${community.slug}',
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: SpacingTokens.space12),
              SizedBox(
                width: 112,
                child: ActionButton(
                  label: community.joined ? 'Joined' : 'Join',
                  icon:
                      community.joined ? Iconsax.tick_circle_copy : Iconsax.add,
                  kind: community.joined
                      ? ActionButtonKind.outlined
                      : ActionButtonKind.primary,
                  busy: busy,
                  onPressed: onToggle,
                ),
              ),
            ],
          ),
          if (description != null && description.isNotEmpty) ...[
            const SizedBox(height: SpacingTokens.space12),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: scheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ],
          const SizedBox(height: SpacingTokens.space12),
          Row(
            children: [
              _Stat(
                value: community.members,
                noun: 'member',
                icon: Iconsax.people_copy,
              ),
              const SizedBox(width: SpacingTokens.space16),
              _Stat(
                value: community.posts,
                noun: 'post',
                icon: Iconsax.message_text_copy,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final int value;
  final String noun;
  final IconData icon;

  const _Stat({required this.value, required this.noun, required this.icon});

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurface.withValues(
          alpha: 0.6,
        );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: muted),
        const SizedBox(width: SpacingTokens.space4),
        Text(
          '${formatCount(value)} $noun${value == 1 ? '' : 's'}',
          style: TextStyle(fontSize: 13, color: muted),
        ),
      ],
    );
  }
}
