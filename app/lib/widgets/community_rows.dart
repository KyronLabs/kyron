// lib/widgets/community_rows.dart
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
import 'hairline.dart';
import 'list_controls.dart';
import 'skeleton.dart';
import 'toast.dart';

/// Communities as rows, the way a list of people to follow is laid out: a
/// picture, the name and a line under it, the one action on the right, and
/// what the community is about -- or what was said there last -- across the
/// full width beneath.
///
/// They were rounded cards on a grey ground, which made the Communities tab
/// the one screen in Kyron drawn on a different page from the rest: every
/// other list is rows on the page itself with a hairline between them.

const _rowPadding = EdgeInsets.fromLTRB(
  SpacingTokens.space16,
  14,
  SpacingTokens.space16,
  14,
);
const _tile = 48.0;

/// "Members: 12" -- a label and a number, the way the row's other facts
/// read, rather than "12 members", which needs a plural every language forms
/// differently and so stayed English everywhere.
String _members(AppLocalizations l10n, int count) =>
    '${l10n.ui('ui_community_members', 'Members:')} ${formatCount(count)}';

/// The shape every row shares: picture, name over a quieter line, the action
/// at the right edge level with the name, and a line of its own underneath.
class _Row extends StatelessWidget {
  final Community community;
  final VoidCallback onTap;
  final Widget meta;
  final Widget action;
  final Widget? below;

  const _Row({
    super.key,
    required this.community,
    required this.onTap,
    required this.meta,
    required this.action,
    this.below,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: _rowPadding,
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
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 2),
                      meta,
                    ],
                  ),
                ),
                const SizedBox(width: SpacingTokens.space12),
                action,
              ],
            ),
            if (below != null) ...[
              const SizedBox(height: 10),
              below!,
            ],
          ],
        ),
      ),
    );
  }
}

TextStyle _metaStyle(BuildContext context) => TextStyle(
      fontSize: TypographyTokens.fontSize2,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.55),
    );

/// One of the reader's communities: picture, name, members and the reader's
/// part in it, a button to write there, and the newest post with how many
/// are new. The row itself opens the community.
class CommunityRow extends StatelessWidget {
  final Community community;

  /// Whether the newest post is the reader's own.
  final bool mine;

  /// Whether to say how many posts are new, which the reader can turn off.
  final bool showCount;

  final VoidCallback onOpen;
  final VoidCallback onWrite;

  const CommunityRow({
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
    // Counts off means nothing on the row says how much is new, so nothing
    // on it should shout about it either.
    final loud = community.unread > 0 && showCount;
    final post = community.lastPost;
    final role = switch (community.role) {
      CommunityRole.owner => l10n.ui('ui_community_role_owner', 'Owner'),
      CommunityRole.moderator =>
        l10n.ui('ui_community_role_moderator', 'Moderator'),
      _ => null,
    };

    return _Row(
      key: ValueKey('community-${community.id}'),
      community: community,
      onTap: onOpen,
      meta: Text(
        [
          _members(l10n, community.members),
          if (role != null) role,
        ].join(' · '),
        key: ValueKey('community-meta-${community.id}'),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: _metaStyle(context),
      ),
      action: ActionIconButton(
        key: ValueKey('community-write-${community.id}'),
        icon: Iconsax.edit_2_copy,
        tooltip: l10n.ui('ui_community_write', 'Write a post'),
        filled: true,
        size: ActionButton.compactHeight,
        onPressed: onWrite,
      ),
      below: Row(
        children: [
          Expanded(
            child: Text(
              communityPreview(l10n, post, mine: mine),
              key: ValueKey('community-preview-${community.id}'),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: TypographyTokens.fontSize3,
                height: 1.35,
                fontWeight: loud ? FontWeight.w600 : FontWeight.w400,
                color: post == null
                    ? scheme.onSurface.withValues(alpha: 0.55)
                    : scheme.onSurface.withValues(alpha: loud ? 1 : 0.8),
              ),
            ),
          ),
          if (loud) ...[
            const SizedBox(width: SpacingTokens.space8),
            CountBadge(count: community.unread),
          ],
        ],
      ),
    );
  }
}

/// A community the reader is not in: [CommunityRow]'s shape, with Join where
/// the write button would be -- the Follow button, in all but the word, since
/// that is what joining is -- and what it is for underneath.
class DiscoverCommunityRow extends ConsumerStatefulWidget {
  final Community community;
  final VoidCallback onOpen;

  /// Called with the community as it stands once joined.
  final ValueChanged<Community> onJoined;

  const DiscoverCommunityRow({
    super.key,
    required this.community,
    required this.onOpen,
    required this.onJoined,
  });

  @override
  ConsumerState<DiscoverCommunityRow> createState() =>
      _DiscoverCommunityRowState();
}

class _DiscoverCommunityRowState extends ConsumerState<DiscoverCommunityRow> {
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

    return _Row(
      community: community,
      onTap: widget.onOpen,
      meta: Text(
        _members(l10n, community.members),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: _metaStyle(context),
      ),
      action: ActionButton(
        key: ValueKey('discover-join-${community.id}'),
        compact: true,
        label: l10n.ui('ui_join', 'Join'),
        busy: _busy,
        onPressed: _join,
      ),
      below: description == null || description.isEmpty
          ? null
          : Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: TypographyTokens.fontSize3,
                height: 1.35,
                color: scheme.onSurface.withValues(alpha: 0.85),
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

/// The shape of the rows while they load.
class CommunityRowsSkeleton extends StatelessWidget {
  const CommunityRowsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonGroup(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 5,
        separatorBuilder: (_, __) => const Hairline(),
        itemBuilder: (context, _) => const Padding(
          padding: _rowPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SkeletonBox(
                    width: _tile,
                    height: _tile,
                    radius: _tile * 0.24,
                  ),
                  SizedBox(width: SpacingTokens.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonBox.line(width: 130, height: 15),
                        SizedBox(height: 7),
                        SkeletonBox.line(width: 80, height: 11),
                      ],
                    ),
                  ),
                  SizedBox(width: SpacingTokens.space12),
                  SkeletonBox.circle(size: ActionButton.compactHeight),
                ],
              ),
              SizedBox(height: 12),
              SkeletonBox.line(height: 13),
            ],
          ),
        ),
      ),
    );
  }
}
