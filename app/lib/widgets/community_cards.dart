// lib/widgets/community_cards.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/community.dart';
import '../providers/communities_provider.dart';
import '../utils/api_error_message.dart';
import '../utils/conversation_text.dart';
import '../utils/format_count.dart';
import 'hairline.dart';
import 'list_controls.dart';
import 'skeleton.dart';
import 'toast.dart';

/// Communities as cards: a picture in a tile, the name and what it is, the
/// newest post, and what to do about it at the foot.
///
/// Cards rather than rows so the Communities list reads as places, not as a
/// second inbox: Messages is a list of conversations, one line each, and this
/// was laid out the same way until the two were hard to tell apart.

/// The ground the cards sit on: a shade under the page in light, so white
/// cards stand off it; the page itself in dark, where the cards are the
/// lighter thing.
Color communityPageColor(BuildContext context) {
  final theme = Theme.of(context);
  return theme.brightness == Brightness.dark
      ? theme.scaffoldBackgroundColor
      : theme.colorScheme.surfaceContainerHighest;
}

Color _cardColor(BuildContext context) {
  final theme = Theme.of(context);
  return theme.brightness == Brightness.dark
      ? theme.colorScheme.surfaceContainerLow
      : theme.colorScheme.surface;
}

const _cardRadius = 22.0;

/// "Members: 12" -- a label and a number, the way the card's other facts
/// read, rather than "12 members", which needs a plural every language forms
/// differently and so stayed English everywhere.
String _members(AppLocalizations l10n, int count) =>
    '${l10n.ui('ui_community_members', 'Members:')} ${formatCount(count)}';

/// One of the reader's communities.
///
/// The foot carries the two things worth doing from the list -- reading it,
/// and writing in it -- filled when there is something new, outlined when
/// there is not, so the communities with news stand out down the page.
class CommunityCard extends StatelessWidget {
  final Community community;

  /// Whether the newest post is the reader's own.
  final bool mine;

  /// Whether to say how many posts are new, which the reader can turn off.
  final bool showCount;

  final VoidCallback onOpen;
  final VoidCallback onWrite;

  const CommunityCard({
    super.key,
    required this.community,
    required this.mine,
    required this.showCount,
    required this.onOpen,
    required this.onWrite,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final muted = scheme.onSurface.withValues(alpha: 0.55);
    final fresh = community.unread > 0;
    // Counts off means nothing on the card says how much is new, so nothing
    // on it should shout about it either.
    final loud = fresh && showCount;
    final post = community.lastPost;
    final when = post?.createdAt;
    final role = switch (community.role) {
      CommunityRole.owner => l10n.ui('ui_community_role_owner', 'Owner'),
      CommunityRole.moderator =>
        l10n.ui('ui_community_role_moderator', 'Moderator'),
      _ => null,
    };

    return Material(
      key: ValueKey('community-${community.id}'),
      color: _cardColor(context),
      borderRadius: BorderRadius.circular(_cardRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(SpacingTokens.space12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommunityPictureTile(community: community, size: 84),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: SpacingTokens.space4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            community.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: TypographyTokens.fontSize5,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            [
                              _members(l10n, community.members),
                              if (role != null) role,
                            ].join(' · '),
                            key: ValueKey('community-meta-${community.id}'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: TypographyTokens.fontSize2,
                              color: muted,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  communityPreview(l10n, post, mine: mine),
                                  key: ValueKey(
                                    'community-preview-${community.id}',
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: TypographyTokens.fontSize3,
                                    fontWeight: loud
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: post == null
                                        ? muted
                                        : scheme.onSurface.withValues(
                                            alpha: loud ? 1 : 0.8,
                                          ),
                                  ),
                                ),
                              ),
                              if (loud) ...[
                                const SizedBox(width: SpacingTokens.space8),
                                CountBadge(count: community.unread),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SpacingTokens.space12),
              Divider(
                height: 1,
                thickness: 0.5,
                color: postRule(scheme).color,
              ),
              const SizedBox(height: SpacingTokens.space12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.ui('ui_community_last_post', 'Last post'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize2,
                            color: muted,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          when == null
                              ? l10n.ui('ui_community_none_yet', 'None yet')
                              : conversationTime(
                                  l10n,
                                  when,
                                  locale: Localizations.maybeLocaleOf(context)
                                      ?.toLanguageTag(),
                                ),
                          key: ValueKey('community-when-${community.id}'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: TypographyTokens.fontSize5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: SpacingTokens.space8),
                  CardPill(
                    key: ValueKey('community-open-${community.id}'),
                    label: loud
                        ? l10n.ui('ui_community_catch_up', 'Catch up')
                        : l10n.ui('ui_community_open', 'Open'),
                    filled: loud,
                    onPressed: onOpen,
                  ),
                  const SizedBox(width: SpacingTokens.space8),
                  CardRoundButton(
                    key: ValueKey('community-write-${community.id}'),
                    icon: Iconsax.edit_2_copy,
                    tooltip: l10n.ui('ui_community_write', 'Write a post'),
                    filled: loud,
                    onPressed: onWrite,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A community the reader is not in, with a Join pill at its foot.
class DiscoverCommunityCard extends ConsumerStatefulWidget {
  final Community community;
  final VoidCallback onOpen;

  /// Called with the community as it stands once joined.
  final ValueChanged<Community> onJoined;

  const DiscoverCommunityCard({
    super.key,
    required this.community,
    required this.onOpen,
    required this.onJoined,
  });

  @override
  ConsumerState<DiscoverCommunityCard> createState() =>
      _DiscoverCommunityCardState();
}

class _DiscoverCommunityCardState extends ConsumerState<DiscoverCommunityCard> {
  bool _busy = false;

  Future<void> _join() async {
    if (_busy) return;
    setState(() => _busy = true);
    unawaited(HapticFeedback.selectionClick());
    try {
      final joined = await ref
          .read(communitiesRepositoryProvider)
          .setMembership(widget.community.slug, true);
      widget.onJoined(joined);
    } catch (error) {
      if (!mounted) return;
      setState(() => _busy = false);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final community = widget.community;
    final description = community.description?.trim();

    return Material(
      color: _cardColor(context),
      borderRadius: BorderRadius.circular(_cardRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: widget.onOpen,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommunityPictureTile(community: community, size: 72),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      community.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: TypographyTokens.fontSize5,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    if (description != null && description.isNotEmpty) ...[
                      const SizedBox(height: SpacingTokens.space4),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize2,
                          height: 1.35,
                          color: scheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _members(l10n, community.members),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: TypographyTokens.fontSize2,
                              fontWeight: FontWeight.w600,
                              color: scheme.onSurface.withValues(alpha: 0.65),
                            ),
                          ),
                        ),
                        CardPill(
                          key: ValueKey('discover-join-${community.id}'),
                          label: l10n.ui('ui_join', 'Join'),
                          icon: Iconsax.add_copy,
                          filled: true,
                          compact: true,
                          busy: _busy,
                          onPressed: _join,
                        ),
                      ],
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

/// A community's picture in a rounded tile, or the first letter of its name
/// on a quiet ground when it has none.
class CommunityPictureTile extends StatelessWidget {
  final Community community;
  final double size;

  const CommunityPictureTile({
    super.key,
    required this.community,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final url = community.avatarUrl?.trim();
    final name = community.name.trim();
    // A shade off the card in either theme, the way a product sits on its
    // own ground inside a white card.
    final ground = scheme.surfaceContainerHighest;

    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.22),
      child: SizedBox.square(
        dimension: size,
        child: ColoredBox(
          color: ground,
          child: url == null || url.isEmpty
              ? Center(
                  child: Text(
                    name.isEmpty ? '#' : name[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: size * 0.4,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                )
              : Image.network(
                  url,
                  fit: BoxFit.cover,
                  // The ground shows rather than a broken-image glyph.
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
        ),
      ),
    );
  }
}

/// A pill-shaped button: filled in the text colour when it is the thing to
/// do, outlined when it is only there.
class CardPill extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool filled;
  final bool compact;
  final bool busy;
  final VoidCallback onPressed;

  const CardPill({
    super.key,
    required this.label,
    required this.filled,
    required this.onPressed,
    this.icon,
    this.compact = false,
    this.busy = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ink =
        filled ? scheme.surface : scheme.onSurface.withValues(alpha: 0.7);
    final height = compact ? 36.0 : 44.0;

    return Material(
      color: filled ? scheme.onSurface : Colors.transparent,
      shape: StadiumBorder(
        side: filled
            ? BorderSide.none
            : BorderSide(color: scheme.outline.withValues(alpha: 0.35)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: busy ? null : onPressed,
        child: SizedBox(
          height: height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: compact ? 14 : 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (busy)
                  SizedBox.square(
                    dimension: 14,
                    child:
                        CircularProgressIndicator(strokeWidth: 2, color: ink),
                  )
                else if (icon != null)
                  Icon(icon, size: 16, color: ink),
                if (busy || icon != null) const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: compact
                        ? TypographyTokens.fontSize2
                        : TypographyTokens.fontSize3,
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
  }
}

/// The round button beside a [CardPill], in the same weight.
class CardRoundButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final bool filled;
  final VoidCallback onPressed;

  const CardRoundButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.filled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Tooltip(
      message: tooltip,
      child: Material(
        color: filled ? scheme.onSurface : Colors.transparent,
        shape: CircleBorder(
          side: filled
              ? BorderSide.none
              : BorderSide(color: scheme.outline.withValues(alpha: 0.35)),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox.square(
            dimension: 44,
            child: Icon(
              icon,
              size: 18,
              color: filled
                  ? scheme.surface
                  : scheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
      ),
    );
  }
}

/// The shape of the cards while they load.
class CommunityCardsSkeleton extends StatelessWidget {
  const CommunityCardsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonGroup(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(SpacingTokens.space16),
        itemCount: 3,
        separatorBuilder: (_, __) =>
            const SizedBox(height: SpacingTokens.space12),
        itemBuilder: (context, _) => Container(
          padding: const EdgeInsets.all(SpacingTokens.space12),
          decoration: BoxDecoration(
            color: _cardColor(context),
            borderRadius: BorderRadius.circular(_cardRadius),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBox(width: 84, height: 84, radius: 18),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: SpacingTokens.space8),
                        SkeletonBox.line(width: 140, height: 16),
                        SizedBox(height: 10),
                        SkeletonBox.line(width: 90),
                        SizedBox(height: 14),
                        SkeletonBox.line(height: 14),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonBox.line(width: 60),
                        SizedBox(height: 6),
                        SkeletonBox.line(width: 80, height: 16),
                      ],
                    ),
                  ),
                  SkeletonBox(width: 88, height: 44, radius: 22),
                  SizedBox(width: SpacingTokens.space8),
                  SkeletonBox.circle(size: 44),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
