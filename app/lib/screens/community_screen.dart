import '../l10n/app_localizations.dart';

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
import '../providers/community_chats_provider.dart';
import '../widgets/community_chats_section.dart';
import '../widgets/glass_icon_button.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/hairline.dart';
import '../widgets/empty_state.dart';
import '../widgets/post_list_view.dart';
import '../widgets/squircle.dart';
import '../widgets/toast.dart';
import 'community_composer_screen.dart';
import 'community_manage_screen.dart';
import '../widgets/create_fab.dart';
import '../widgets/action_sheet.dart';

import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

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
      // The banner is the top of this page, under a bar with nothing in it
      // but the controls, as on a profile: a bar with a colour of its own
      // left a strip of surface between the status bar and the picture, and
      // the community's name in two places at once.
      extendBodyBehindAppBar: true,
      appBar: KyronAppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: const GlassBackButton(),
        actions: [
          if (community != null) ...[
            // The chats, in a sheet. They were a section between the header
            // and the posts, which pushed every post a screen down on every
            // visit to show a list most visits do not open.
            _ChatsButton(community: community),
            GlassIconButton(
              icon: Iconsax.more_copy,
              tooltip: AppLocalizations.of(context).literalthisCommunity,
              onPressed: () => _openMenu(context, ref, community, notifier),
            ),
          ],
          const SizedBox(width: SpacingTokens.space4),
        ],
      ),
      // Only for members. A button that answers "join first" is a button that
      // should not have been there.
      //
      // In the bottom-right corner, where a thumb is and where a create
      // button is expected. It was centred, to match the bottom bar's: in
      // the middle of the screen it sat over the middle of every post, which
      // is where the words are.
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: community == null || !community.canPost
          ? null
          : Padding(
              // Clear of the home indicator. A floating button is placed 16
              // above the *body*, and this body runs to the bottom of the
              // screen -- so it landed 32 up on a phone with a 34-pixel
              // gesture inset, two pixels inside the system's own strip.
              padding: EdgeInsets.only(
                bottom: MediaQuery.paddingOf(context).bottom,
              ),
              child: SizedBox.square(
                dimension: 56,
                child: CreateFab.of(
                  icon: Iconsax.edit_2_copy,
                  tooltip: 'Post in ${community.name}',
                  heroTag: 'compose-${community.slug}',
                  onPressed: () => _compose(context, ref, community),
                ),
              ),
            ),
      body: Stack(
        children: [
          if (state.loading)
            const Center(child: CircularProgressIndicator())
          else if (community == null)
            SafeArea(
              child: EmptyState.failed(
                title: AppLocalizations.of(context)
                    .literalcouldNotOpenThisCommunity,
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
              // The create button in the corner is what to do here.
              emptyRefresh: !community.canPost,
              // Room to scroll the last post -- and the empty page's own
              // button -- clear of the create button in the corner: its 56,
              // the 16 it floats at, and a little air.
              padding: const EdgeInsets.only(bottom: 96),
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
        ],
      ),
    );
  }

  /// What a member of this community needs, in one place.
  ///
  /// The banner used to carry a Manage gear and nothing else, and only for
  /// moderators -- so for everybody else the top right of the page was empty
  /// and leaving was a one-tap button in the header. Both are here now.
  ///
  /// Only what works is offered. There is no "report this community": the
  /// moderation API takes a post, a comment or a person, and an entry that
  /// refuses is worse than no entry.
  Future<void> _openMenu(
    BuildContext context,
    WidgetRef ref,
    Community community,
    CommunityNotifier notifier,
  ) async {
    final url = 'https://kyron.so/c/${community.slug}';
    final moderator = community.role?.canModerate ?? false;

    final chosen = await ActionSheet.show<String>(
      context,
      title: community.name,
      actions: [
        SheetAction(
          value: 'share',
          label: AppLocalizations.of(context).literalshareThisCommunity,
          icon: Iconsax.export_copy,
        ),
        SheetAction(
          value: 'copy',
          label: AppLocalizations.of(context).literalcopyLink,
          icon: Iconsax.link_copy,
        ),
        if (moderator)
          SheetAction(
            value: 'manage',
            label: 'Manage',
            icon: Iconsax.setting_2_copy,
            detail: 'Members, bans, and what this community says about itself',
          ),
        if (community.joined)
          SheetAction(
            value: 'leave',
            label: AppLocalizations.of(context).leave,
            icon: Iconsax.logout_copy,
            detail: 'You will stop seeing its posts in your feed',
            destructive: true,
          ),
      ],
    );
    if (chosen == null || !context.mounted) return;

    switch (chosen) {
      case 'share':
        await Share.share(url, subject: '${community.name} on Kyron');

      case 'copy':
        await Clipboard.setData(ClipboardData(text: url));
        if (context.mounted)
          Toast.show(context, AppLocalizations.of(context).literallinkCopied);

      case 'manage':
        await Navigator.push<Community>(
          context,
          MaterialPageRoute(
            builder: (_) => CommunityManageScreen(community: community),
          ),
        );
        notifier.refresh();

      case 'leave':
        // Asked, not assumed. This is the step the old button skipped.
        final sure = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text('Leave ${community.name}?'),
            content: Text(
              'Its posts will stop appearing in your feed. You can join '
              'again at any time.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text(AppLocalizations.of(context).stay),
              ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text(AppLocalizations.of(context).leave),
              ),
            ],
          ),
        );
        if (sure != true || !context.mounted) return;

        final error = await notifier.toggleMembership();
        if (!context.mounted) return;
        if (error != null) {
          Toast.show(context, error);
        } else {
          Toast.show(context, 'You have left ${community.name}');
          ref.invalidate(myCommunitiesProvider);
          ref.invalidate(discoverCommunitiesProvider);
        }
    }
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
          .read(
            postListProvider(PostListSource.community(community.slug)).notifier,
          )
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
                  // Join, and nothing once you have.
                  //
                  // "Joined" was a button, and the only thing it did was leave.
                  // One stray tap in the header of a community somebody reads
                  // every day dropped them out of it, with no warning and
                  // nothing to say it had happened -- and the button then read
                  // "Join", which looks like it failed rather than like it
                  // worked. Leaving is in the menu at the top of the banner
                  // now, behind a question.
                  if (!community.joined) ...[
                    const SizedBox(width: SpacingTokens.space12),
                    SizedBox(
                      width: 112,
                      child: ActionButton(
                        compact: true,
                        label: 'Join',
                        icon: Iconsax.add_copy,
                        busy: busy,
                        onPressed: onToggle,
                      ),
                    ),
                  ],
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

/// The community's chats, beside More. A dot when one the reader joined
/// has something new.
class _ChatsButton extends ConsumerWidget {
  final Community community;

  const _ChatsButton({required this.community});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only asked for by a member: the server refuses anybody else.
    final fresh = community.joined &&
        (ref.watch(communityChatsProvider(community.slug)).value ?? const [])
            .any((chat) => chat.joined && !chat.muted && chat.unread > 0);
    return GlassIconButton(
      key: const ValueKey('community-chats-button'),
      icon: Iconsax.messages_2_copy,
      tooltip: AppLocalizations.of(context).ui('ui_cchat_heading', 'Chats'),
      dot: fresh,
      onPressed: () => CommunityChatsSheet.show(context, community),
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
    final muted =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);

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
