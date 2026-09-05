// lib/widgets/community_tile.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/community.dart';
import '../providers/communities_provider.dart';
import '../utils/api_error_message.dart';
import '../utils/format_count.dart';
import 'action_button.dart';
import 'toast.dart';

/// One community in a list.
///
/// One widget for My Communities and for Discover, rather than each growing
/// its own row -- which is how the two ended up with a chevron on one and a
/// Join button on the other for the same thing.
class CommunityTile extends ConsumerStatefulWidget {
  final Community community;
  final VoidCallback onOpen;

  /// Called with the community as it now stands after a join or a leave.
  final ValueChanged<Community>? onChanged;

  const CommunityTile({
    super.key,
    required this.community,
    required this.onOpen,
    this.onChanged,
  });

  @override
  ConsumerState<CommunityTile> createState() => _CommunityTileState();
}

class _CommunityTileState extends ConsumerState<CommunityTile> {
  bool _busy = false;

  Future<void> _toggle() async {
    final community = widget.community;
    if (community.joined && !(community.role?.canLeave ?? true)) {
      Toast.show(
        context,
        'You started this community, so you cannot leave it.',
      );
      return;
    }

    setState(() => _busy = true);
    unawaited(HapticFeedback.selectionClick());
    try {
      final next = await ref
          .read(communitiesRepositoryProvider)
          .setMembership(community.slug, !community.joined);
      widget.onChanged?.call(next);
    } catch (error) {
      if (!mounted) return;
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final community = widget.community;
    final description = community.description?.trim();

    return InkWell(
      onTap: widget.onOpen,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space16,
          vertical: SpacingTokens.space12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Avatar(community: community),
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
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    // Two real numbers rather than one made-up one.
                    '${_count(community.members, 'member')} · '
                    '${_count(community.posts, 'post')}',
                    style: TextStyle(
                      fontSize: 12,
                      color: scheme.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                  if (description != null && description.isNotEmpty) ...[
                    const SizedBox(height: SpacingTokens.space4),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        color: scheme.onSurface.withValues(alpha: 0.75),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: SpacingTokens.space12),
            SizedBox(
              width: 96,
              child: ActionButton(
                label: community.joined ? 'Joined' : 'Join',
                icon: community.joined ? Iconsax.tick_circle_copy : Iconsax.add,
                kind: community.joined
                    ? ActionButtonKind.outlined
                    : ActionButtonKind.primary,
                busy: _busy,
                onPressed: _toggle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _count(int value, String noun) =>
      '${formatCount(value)} $noun${value == 1 ? '' : 's'}';
}

/// A community's picture, or the first letter of its name.
class _Avatar extends StatelessWidget {
  final Community community;

  const _Avatar({required this.community});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final url = community.avatarUrl;
    final initial =
        community.name.trim().isEmpty ? '#' : community.name.trim()[0];

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        image: url == null
            ? null
            : DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
      alignment: Alignment.center,
      child: url != null
          ? null
          : Text(
              initial.toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: scheme.primary,
              ),
            ),
    );
  }
}
