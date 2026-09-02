// lib/widgets/post_actions_row.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/feed_post.dart';
import '../utils/format_count.dart';
import 'post_action_colors.dart';

/// The engagement row under a post.
///
/// Presentational, and shared: the feed card and the post's own screen both
/// draw this one, so the two cannot end up with a different set of buttons in
/// a different order -- which they had, down to the post screen having no
/// reply and no share at all. Each screen passes its own callbacks, because
/// each keeps the post in a different place.
class PostActionsRow extends StatelessWidget {
  final FeedPost post;

  final VoidCallback onReply;
  final VoidCallback onRepost;
  final VoidCallback onLike;
  final VoidCallback onSave;
  final VoidCallback onShare;

  /// Draw the counts beside the icons. False on a post's own screen, where
  /// they are already spelled out in full above the row.
  final bool showCounts;

  const PostActionsRow({
    super.key,
    required this.post,
    required this.onReply,
    required this.onRepost,
    required this.onLike,
    required this.onSave,
    required this.onShare,
    this.showCounts = true,
  });

  @override
  Widget build(BuildContext context) {
    // The three that are about the post -- reply, repost, like -- sit
    // together on the left with their counts. Save and share are about what
    // *you* do with it afterwards and carry no count, so they go to the right
    // rather than being strung along the same evenly spaced row where a bare
    // icon reads as a number that happens to be missing.
    return Row(
      children: [
        PostAction(
          icon: Iconsax.message_text_copy,
          label: showCounts && post.comments > 0
              ? formatCount(post.comments)
              : null,
          tooltip: 'Reply',
          onTap: onReply,
        ),
        const SizedBox(width: SpacingTokens.space20),
        PostAction(
          // Outline until you act on it, filled once you have -- so the state
          // reads at a glance instead of only by colour.
          icon:
              post.reposted ? Iconsax.repeat_circle_copy : Iconsax.repeat_copy,
          label:
              showCounts && post.reposts > 0 ? formatCount(post.reposts) : null,
          active: post.reposted,
          activeColor: PostActionColors.repost,
          tooltip: 'Repost',
          onTap: onRepost,
        ),
        const SizedBox(width: SpacingTokens.space20),
        PostAction(
          icon: post.liked ? Iconsax.heart : Iconsax.heart_copy,
          label: showCounts && post.likes > 0 ? formatCount(post.likes) : null,
          active: post.liked,
          activeColor: PostActionColors.like,
          tooltip: post.liked ? 'Unlike' : 'Like',
          onTap: onLike,
        ),
        const Spacer(),
        PostAction(
          icon: post.saved ? Iconsax.archive_tick : Iconsax.archive_add_copy,
          active: post.saved,
          activeColor: PostActionColors.save,
          tooltip: post.saved ? 'Remove from saved' : 'Save',
          onTap: onSave,
        ),
        const SizedBox(width: SpacingTokens.space12),
        PostAction(
          icon: Iconsax.export_1_copy,
          tooltip: 'Share',
          onTap: onShare,
        ),
      ],
    );
  }
}

/// One button in the engagement row.
class PostAction extends StatelessWidget {
  final IconData icon;
  final String? label;
  final bool active;
  final Color? activeColor;
  final String tooltip;
  final VoidCallback onTap;

  const PostAction({
    super.key,
    required this.icon,
    this.label,
    this.active = false,
    this.activeColor,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = active
        ? (activeColor ?? scheme.primary)
        : scheme.onSurface.withValues(alpha: 0.55);

    return Tooltip(
      message: tooltip,
      child: InkWell(
        // selectionClick is the lightest thing the platform offers -- the tick
        // of a picker passing a notch, not the thud of a confirmation. Anything
        // heavier on a control people press while reading is intrusive.
        onTap: () {
          unawaited(HapticFeedback.selectionClick());
          onTap();
        },
        borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
        child: Padding(
          padding: const EdgeInsets.all(SpacingTokens.space4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 17, color: color),
              if (label != null) ...[
                const SizedBox(width: SpacingTokens.space4),
                Text(label!, style: TextStyle(fontSize: 12, color: color)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// A count as a sentence: "1 like", "12 likes", "1.2K likes".
///
/// Spelled out rather than shown as a bare number beside an icon, because a
/// post's own screen has the room and "1 likes" is the kind of thing that
/// makes an app look unfinished.
String countLabel(int value, String singular, {String? plural}) {
  final word = value == 1 ? singular : (plural ?? '${singular}s');
  return '${formatCount(value)} $word';
}
