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
import '../widgets/community_avatar.dart';
import '../widgets/hairline.dart';
import '../widgets/empty_state.dart';
import '../widgets/post_list_view.dart';
import '../widgets/squircle.dart';
import '../widgets/toast.dart';
import 'community_composer_screen.dart';
import 'community_manage_screen.dart';

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
      // No app bar. The banner is the top of this page: a bar above it left a
      // strip of surface colour between the status bar and the picture, and
      // the community's name in two places at once.
      extendBodyBehindAppBar: true,
      // Only for members. A button that answers "join first" is a button that
      // should not have been there.
      floatingActionButton: community == null || !community.canPost
          ? null
          : Padding(
              // Clear of the home indicator. `endFloat` places the button 16
              // above the *body*, and this body runs to the bottom of the
              // screen -- so the button landed 32 up on a phone with a 34-pixel
              // gesture inset, two pixels inside the system's own strip.
              // Adding the inset puts it 16 clear of it, which is where
              // Material puts a floating button.
              padding: EdgeInsets.only(
                bottom: MediaQuery.paddingOf(context).bottom,
              ),
              child: FloatingActionButton(
                onPressed: () => _compose(context, ref, community),
                tooltip: 'Post in ${community.name}',
                // Outlined, like every other glyph in Kyron. `Iconsax.edit_2`
                // is the filled weight; the `_copy` suffix is the outline.
                child: const Icon(Iconsax.edit_2_copy),
              ),
            ),
      body: Stack(
        children: [
          if (state.loading)
            const Center(child: CircularProgressIndicator())
          else if (community == null)
            SafeArea(
              child: EmptyState.failed(
                title: 'Could not open this community',
                detail: state.error,
                onAction: notifier.refresh,
              ).scrollable,
            )
          else
            // The header scrolls with the posts rather than sitting above
            // them. As a Column with the list in an Expanded it was pinned,
            // so the posts slid up behind the banner and stopped -- the
            // banner held a third of the screen no matter how far down the
            // community you had read. PostListView already takes slivers to
            // put above its posts, which is how the profile page does the
            // same thing.
            PostListView(
              source: PostListSource.community(community.slug),
              errorTitle: 'Could not load ${community.name}',
              emptyTitle: 'Nothing posted here yet',
              emptyDetail: community.joined
                  ? 'Be the first to say something.'
                  : 'Join to post in ${community.name}.',
              emptyArt: EmptyArt.communities,
              padding: const EdgeInsets.only(bottom: SpacingTokens.space40),
              headerSlivers: [
                SliverToBoxAdapter(
                  child: Column(
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
                    ],
                  ),
                ),
              ],
            ),

          // Over the banner rather than in a bar above it. Pinned, because a
          // back button that scrolls away leaves a page with no way out of it
          // on a phone with no back gesture.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space8,
                  vertical: SpacingTokens.space4,
                ),
                child: Row(
                  children: [
                    _GlassButton(
                      icon: Iconsax.arrow_left_copy,
                      tooltip:
                          MaterialLocalizations.of(context).backButtonTooltip,
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    // Only for somebody who can act on it. A menu whose every
                    // entry refuses is worse than no menu.
                    if (community != null &&
                        (community.role?.canModerate ?? false))
                      _GlassButton(
                        icon: Iconsax.setting_2_copy,
                        tooltip: 'Manage',
                        onPressed: () async {
                          await Navigator.push<Community>(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CommunityManageScreen(community: community),
                            ),
                          );
                          notifier.refresh();
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
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

  /// The picture itself. Large enough to be the thing you look at first,
  /// which is what a community's identity should be on its own page.
  static const double _avatar = 80;

  /// The ring of page colour around it.
  static const double _ring = 3;

  /// The whole tile, ring included, which is what actually straddles the edge.
  static const double _tile = _avatar + _ring * 2;

  /// Exactly half of it hangs below the banner, so the banner's bottom edge
  /// runs through the middle of the picture. It was 28 of 86 before -- a
  /// third -- which reads as a picture that slipped rather than one placed.
  static const double _overhang = _tile / 2;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final description = community.description?.trim();
    final banner = community.bannerUrl?.trim();

    // Under the status bar: this is the top of the screen now, so the banner
    // has to fill the inset rather than start below it.
    final topInset = MediaQuery.paddingOf(context).top;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            _Banner(url: banner, topInset: topInset),
            // Stacked on the banner, hanging over its bottom edge. Side by
            // side under it, the two pictures read as two unrelated things.
            Positioned(
              left: SpacingTokens.space16,
              bottom: -_overhang,
              child: Container(
                padding: const EdgeInsets.all(_ring),
                decoration: ShapeDecoration(
                  color: scheme.surface,
                  // The ring is the page's own colour in the same shape, so
                  // the picture reads as lifted off the banner rather than
                  // punched through it.
                  shape: SquircleShape.borderFor(_tile),
                ),
                child: CommunityAvatar(
                  avatarUrl: community.avatarUrl,
                  initial: community.name.trim().isEmpty
                      ? '#'
                      : community.name.trim()[0].toUpperCase(),
                  size: _avatar,
                ),
              ),
            ),
          ],
        ),
        // Clear of the overhang.
        const SizedBox(height: _overhang + SpacingTokens.space8),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            SpacingTokens.space16,
            0,
            SpacingTokens.space16,
            SpacingTokens.space16,
          ),
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
                            fontSize: TypographyTokens.fontSize6,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'c/${community.slug}',
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize2,
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
                      compact: true,
                      label: community.joined ? 'Joined' : 'Join',
                      icon: community.joined
                          ? Iconsax.tick_circle_copy
                          : Iconsax.add,
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
                    fontSize: TypographyTokens.fontSize2,
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
        ),
      ],
    );
  }
}

/// The banner, filling the top of the screen including the status bar.
///
/// A community with no banner still gets the same block of height: without it
/// the picture has nothing to hang off, and the page jumps by eighty pixels
/// between one community and the next.
class _Banner extends StatelessWidget {
  final String? url;
  final double topInset;

  const _Banner({required this.url, required this.topInset});

  /// Wide and shallow: a banner is a strip behind the name, and a taller one
  /// pushes the posts off the first screen.
  static const double _ratio = 3;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final width = MediaQuery.sizeOf(context).width;
    final height = width / _ratio + topInset;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: url == null || url!.isEmpty
          ? DecoratedBox(
              // The community's own colour rather than a grey block, so a
              // community with no banner still looks deliberate.
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    scheme.primary.withValues(alpha: 0.35),
                    scheme.tertiary.withValues(alpha: 0.25),
                  ],
                ),
              ),
            )
          : Image.network(
              url!,
              fit: BoxFit.cover,
              // The gradient shows through rather than a broken-image glyph:
              // a banner that will not load is not worth telling anybody
              // about, but the space still has to be filled.
              errorBuilder: (_, __, ___) => DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.2),
                ),
              ),
            ),
    );
  }
}

/// A control that reads over a photograph.
///
/// Filled with a dark scrim rather than left bare: a plain white glyph
/// disappears against a pale banner, and a dark one against a dark banner.
class _GlassButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _GlassButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.black.withValues(alpha: 0.45),
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox.square(
            dimension: 40,
            // The icon. It was declared on this widget and never drawn, so
            // both controls over the banner rendered as a black disc with
            // nothing in it -- pressable, correct, and invisible.
            child: Icon(icon, size: 20, color: Colors.white),
          ),
        ),
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
          style: TextStyle(fontSize: TypographyTokens.fontSize2, color: muted),
        ),
      ],
    );
  }
}
