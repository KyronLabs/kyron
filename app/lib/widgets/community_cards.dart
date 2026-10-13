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
import 'action_button.dart';
import 'list_controls.dart';
import 'skeleton.dart';
import 'toast.dart';

/// Communities as cards: a picture in a tile, the name and what it is, and
/// the newest post.
///
/// Cards rather than rows so the Communities list reads as places, not as a
/// second inbox. They were bigger: an 84-pixel picture, then a rule, then a
/// footer saying when the last post was in type larger than the post itself,
/// and two big buttons, one of which -- Open -- did what tapping the card
/// already did. About 170 pixels for three facts. Now it is the three facts
/// and the one action that is not opening it.

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

const _cardRadius = 20.0;
const _cardPadding = EdgeInsets.all(SpacingTokens.space12);
const _tile = 56.0;

/// "Members: 12" -- a label and a number, the way the card's other facts
/// read, rather than "12 members", which needs a plural every language forms
/// differently and so stayed English everywhere.
String _members(AppLocalizations l10n, int count) =>
    '${l10n.ui('ui_community_members', 'Members:')} ${formatCount(count)}';

/// One of the reader's communities: picture, name, members and the reader's
/// part in it, the newest post with how many are new, and a button to write
/// there. The card itself opens the community.
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
    // Counts off means nothing on the card says how much is new, so nothing
    // on it should shout about it either.
    final loud = community.unread > 0 && showCount;
    final post = community.lastPost;
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
          padding: _cardPadding,
          child: Row(
            children: [
              CommunityPictureTile(community: community, size: _tile),
              const SizedBox(width: SpacingTokens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      community.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: TypographyTokens.fontSize4,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      [
                        _members(l10n, community.members),
                        if (role != null) role,
                      ].join(' · '),
                      key: ValueKey('community-meta-${community.id}'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: TypographyTokens.fontSize1,
                        color: muted,
                      ),
                    ),
                    const SizedBox(height: SpacingTokens.space4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            communityPreview(l10n, post, mine: mine),
                            key: ValueKey('community-preview-${community.id}'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: TypographyTokens.fontSize2,
                              height: 1.3,
                              fontWeight:
                                  loud ? FontWeight.w600 : FontWeight.w400,
                              color: post == null
                                  ? muted
                                  : scheme.onSurface.withValues(
                                      alpha: loud ? 1 : 0.75,
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
              const SizedBox(width: SpacingTokens.space12),
              ActionIconButton(
                key: ValueKey('community-write-${community.id}'),
                icon: Iconsax.edit_2_copy,
                tooltip: l10n.ui('ui_community_write', 'Write a post'),
                filled: true,
                size: ActionButton.compactHeight,
                onPressed: onWrite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A community the reader is not in.
///
/// The header is the same as a [CommunityCard]'s -- picture, name, members --
/// so the two lists read as one kind of thing, with Join where the write
/// button would be: the Follow button, in all but the word, since that is
/// what joining is. What it is for runs the width of the card under them,
/// rather than squeezed beside the picture, where a long description made
/// one card twice the height of the next and left the Join button floating
/// at whatever height the words stopped.
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
          padding: _cardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CommunityPictureTile(community: community, size: _tile),
                  const SizedBox(width: SpacingTokens.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          community.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: TypographyTokens.fontSize4,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _members(l10n, community.members),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize1,
                            color: scheme.onSurface.withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: SpacingTokens.space12),
                  ActionButton(
                    key: ValueKey('discover-join-${community.id}'),
                    compact: true,
                    label: l10n.ui('ui_join', 'Join'),
                    icon: Iconsax.add,
                    busy: _busy,
                    onPressed: _join,
                  ),
                ],
              ),
              if (description != null && description.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize2,
                    height: 1.4,
                    color: scheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
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
      borderRadius: BorderRadius.circular(size * 0.24),
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

/// The shape of the cards while they load.
class CommunityCardsSkeleton extends StatelessWidget {
  const CommunityCardsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonGroup(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(SpacingTokens.space16),
        itemCount: 4,
        separatorBuilder: (_, __) =>
            const SizedBox(height: SpacingTokens.space8),
        itemBuilder: (context, _) => Container(
          padding: _cardPadding,
          decoration: BoxDecoration(
            color: _cardColor(context),
            borderRadius: BorderRadius.circular(_cardRadius),
          ),
          child: const Row(
            children: [
              SkeletonBox(width: _tile, height: _tile, radius: _tile * 0.24),
              SizedBox(width: SpacingTokens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonBox.line(width: 130, height: 15),
                    SizedBox(height: 7),
                    SkeletonBox.line(width: 80, height: 11),
                    SizedBox(height: 9),
                    SkeletonBox.line(height: 13),
                  ],
                ),
              ),
              SizedBox(width: SpacingTokens.space12),
              SkeletonBox.circle(size: ActionButton.compactHeight),
            ],
          ),
        ),
      ),
    );
  }
}
