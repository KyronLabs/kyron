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
import '../widgets/app_sheet.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/hairline.dart';
import '../widgets/empty_state.dart';
import '../widgets/post_list_view.dart';
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

    Future<void> toggle() async {
      final error = await notifier.toggleMembership();
      if (!context.mounted) return;
      if (error != null) {
        Toast.show(context, error);
      } else {
        // Both lists on the Communities screen are now out of date about
        // this one.
        ref.invalidate(myCommunitiesProvider);
        ref.invalidate(discoverCommunitiesProvider);
      }
    }

    void about() {
      if (community == null) return;
      _About.show(context, community, onJoin: toggle);
    }

    return Scaffold(
      // One row, pinned, the way a feed's header is: back, the community's
      // picture and name, how many are in it, its chats, More -- and Join
      // for somebody who is not in it. It was a banner a third of the
      // screen tall with an 86-pixel picture hanging off it, then the name,
      // the description and the counts, so the first post started half way
      // down the phone. The banner and the whole description are a tap on
      // the name away.
      appBar: KyronAppBar(
        toolbarHeight: _barHeight,
        titleSpacing: 0,
        // Narrower than Material's 56, and every button after the name the
        // same: each pixel they do not take is one more letter of the name.
        leadingWidth: 48,
        leading: _BarButton(
          icon: Iconsax.arrow_left_copy,
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.maybePop(context),
        ),
        title: community == null
            ? null
            : _Identity(community: community, onTap: about),
        actions: [
          if (community != null) ...[
            _Members(community: community, onTap: about),
            // The chats, in a sheet. They were a section between the header
            // and the posts, which pushed every post a screen down on every
            // visit to show a list most visits do not open. Not offered to
            // somebody outside: the server would refuse them.
            if (community.joined) _ChatsButton(community: community),
            _BarButton(
              icon: Iconsax.more_copy,
              tooltip: AppLocalizations.of(context).literalthisCommunity,
              onPressed: () => _openMenu(context, ref, community, notifier),
            ),
            // Join, and nothing once you have. "Joined" was a button whose
            // only action was to leave; leaving is in the menu, behind a
            // question.
            if (!community.joined)
              Padding(
                padding: const EdgeInsets.only(left: SpacingTokens.space4),
                child: ActionButton(
                  key: const ValueKey('community-join'),
                  compact: true,
                  label: AppLocalizations.of(context).ui('ui_join', 'Join'),
                  busy: state.busy,
                  onPressed: toggle,
                ),
              ),
          ],
          const SizedBox(width: SpacingTokens.space8),
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
                if (community.description?.trim().isNotEmpty ?? false)
                  SliverToBoxAdapter(
                    child: _Description(community: community, onTap: about),
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

/// The bar's height: a 40-pixel picture with room around it.
const double _barHeight = 60;

/// The community's picture and name, with its address under it. Tapping it
/// opens [_About].
class _Identity extends StatelessWidget {
  final Community community;
  final VoidCallback onTap;

  const _Identity({required this.community, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: community.name,
      excludeSemantics: true,
      child: InkWell(
        key: const ValueKey('community-identity'),
        onTap: onTap,
        borderRadius: BorderRadius.circular(RadiusTokens.radius12),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: SpacingTokens.space4,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommunityAvatar(
                avatarUrl: community.avatarUrl,
                initial: _initial(community),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      community.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: TypographyTokens.fontSize4,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                        color: scheme.onSurface,
                      ),
                    ),
                    Text(
                      'c/${community.slug}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: TypographyTokens.fontSize2,
                        height: 1.3,
                        color: scheme.onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _initial(Community community) {
  final name = community.name.trim();
  return name.isEmpty ? '#' : name[0].toUpperCase();
}

/// How many are in it, as a feed's header shows its likes: an icon and a
/// number. Opens [_About], which says the rest.
class _Members extends StatelessWidget {
  final Community community;
  final VoidCallback onTap;

  const _Members({required this.community, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final muted =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);
    final label = AppLocalizations.of(context).ui(
      'ui_community_members',
      'Members:',
    );

    return Tooltip(
      message: '$label ${community.members}',
      child: InkWell(
        key: const ValueKey('community-members'),
        onTap: onTap,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Iconsax.people_copy, size: 18, color: muted),
              const SizedBox(width: SpacingTokens.space4),
              Text(
                formatCount(community.members),
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize2,
                  fontWeight: FontWeight.w600,
                  color: muted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// An icon in the bar, with a dot when something behind it is new.
class _BarButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool dot;

  const _BarButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.dot = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      // 40 across rather than 48: four of them in one row with a name.
      // Still 44 tall, the floor for a thumb.
      constraints: const BoxConstraints.tightFor(width: 40, height: 44),
      padding: EdgeInsets.zero,
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon, size: 22),
          if (dot)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                key: const ValueKey('bar-dot'),
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scheme.primary,
                  border: Border.all(color: scheme.surface, width: 1.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// What the community is for, under the bar, three lines at most; the rest
/// is in [_About].
class _Description extends StatelessWidget {
  final Community community;
  final VoidCallback onTap;

  const _Description({required this.community, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      key: const ValueKey('community-description'),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space16,
          SpacingTokens.space4,
          SpacingTokens.space16,
          SpacingTokens.space12,
        ),
        decoration: BoxDecoration(border: Border(bottom: postRule(scheme))),
        child: Text(
          community.description!.trim(),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: TypographyTokens.fontSize2,
            height: 1.4,
            color: scheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }
}

/// Everything about the community the bar has no room for: its banner, the
/// whole description, how many members and posts -- and Join.
class _About extends StatelessWidget {
  final Community community;
  final Future<void> Function() onJoin;

  const _About({required this.community, required this.onJoin});

  static Future<void> show(
    BuildContext context,
    Community community, {
    required Future<void> Function() onJoin,
  }) =>
      showAppSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (_) => _About(community: community, onJoin: onJoin),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final banner = community.bannerUrl?.trim();
    final description = community.description?.trim();

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        key: const ValueKey('community-about'),
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space16,
          SpacingTokens.space4,
          SpacingTokens.space16,
          SpacingTokens.space16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (banner != null && banner.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(RadiusTokens.radius16),
                child: AspectRatio(
                  aspectRatio: 3,
                  child: Image.network(
                    banner,
                    fit: BoxFit.cover,
                    // A banner that will not load is not worth telling
                    // anybody about; the space is still filled.
                    errorBuilder: (_, __, ___) => ColoredBox(
                      color: scheme.primary.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: SpacingTokens.space16),
            ],
            Row(
              children: [
                CommunityAvatar(
                  avatarUrl: community.avatarUrl,
                  initial: _initial(community),
                  size: 56,
                ),
                const SizedBox(width: SpacingTokens.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        community.name,
                        style: const TextStyle(
                          fontSize: TypographyTokens.fontSize5,
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
              ],
            ),
            if (description != null && description.isNotEmpty) ...[
              const SizedBox(height: SpacingTokens.space12),
              Text(
                description,
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize3,
                  height: 1.4,
                  color: scheme.onSurface.withValues(alpha: 0.85),
                ),
              ),
            ],
            const SizedBox(height: SpacingTokens.space12),
            Row(
              children: [
                _Stat(
                  label: l10n.ui('ui_community_members', 'Members:'),
                  value: community.members,
                  icon: Iconsax.people_copy,
                ),
                const SizedBox(width: SpacingTokens.space16),
                _Stat(
                  label: l10n.ui('ui_community_posts', 'Posts:'),
                  value: community.posts,
                  icon: Iconsax.message_text_copy,
                ),
              ],
            ),
            if (!community.joined) ...[
              const SizedBox(height: SpacingTokens.space16),
              ActionButton(
                key: const ValueKey('community-about-join'),
                expand: true,
                label: l10n.ui('ui_join', 'Join'),
                onPressed: () {
                  Navigator.pop(context);
                  onJoin();
                },
              ),
            ],
          ],
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
    return _BarButton(
      key: const ValueKey('community-chats-button'),
      icon: Iconsax.messages_2_copy,
      tooltip: AppLocalizations.of(context).ui('ui_cchat_heading', 'Chats'),
      dot: fresh,
      onPressed: () => CommunityChatsSheet.show(context, community),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;

  const _Stat({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    final muted =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: muted),
        const SizedBox(width: SpacingTokens.space4),
        // "Members: 12", the way the Communities list says it, rather than
        // "12 members", which needs a plural every language forms
        // differently.
        Text(
          '$label ${formatCount(value)}',
          style: TextStyle(fontSize: TypographyTokens.fontSize2, color: muted),
        ),
      ],
    );
  }
}
