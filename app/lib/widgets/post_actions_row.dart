// lib/widgets/post_actions_row.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/feed_post.dart';
import '../utils/format_count.dart';
import 'like_burst.dart';
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
          burst: true,
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
///
/// Every one of them gives a little when pressed. The like also bursts, which
/// is the one action people take for pleasure rather than for a purpose --
/// see [LikeBurstPainter]. Taking a like back gets the give and nothing else:
/// firing a celebration in both directions makes a button look like it is
/// congratulating you for changing your mind.
class PostAction extends StatefulWidget {
  final IconData icon;
  final String? label;
  final bool active;
  final Color? activeColor;
  final String tooltip;
  final VoidCallback onTap;

  /// Throw a ring and sparks when this turns on. The like, and nothing else:
  /// a row where every control celebrates has no way left to mark the one
  /// that matters.
  final bool burst;

  const PostAction({
    super.key,
    required this.icon,
    this.label,
    this.active = false,
    this.activeColor,
    required this.tooltip,
    required this.onTap,
    this.burst = false,
  });

  @override
  State<PostAction> createState() => _PostActionState();
}

class _PostActionState extends State<PostAction>
    with SingleTickerProviderStateMixin {
  late final AnimationController _play = AnimationController(
    vsync: this,
    // Long enough for the sparks to travel and go, short enough that a second
    // tap is never waiting on the first.
    duration: const Duration(milliseconds: 620),
  );

  /// Whether the run in progress is a celebration or just a press.
  bool _celebrating = false;

  /// How far past the icon the burst is allowed to spill, each side.
  static const double _reach = 15;

  @override
  void dispose() {
    _play.dispose();
    super.dispose();
  }

  void _tapped() {
    // selectionClick is the lightest thing the platform offers -- the tick of
    // a picker passing a notch, not the thud of a confirmation. Anything
    // heavier on a control people press while reading is intrusive.
    unawaited(HapticFeedback.selectionClick());

    // Read from what it is about to become, not from what it is: the state
    // arrives from the notifier a frame later, and waiting for it puts the
    // animation behind the finger.
    _celebrating = widget.burst && !widget.active;
    _play.forward(from: 0);

    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colour = widget.active
        ? (widget.activeColor ?? scheme.primary)
        : scheme.onSurface.withValues(alpha: 0.55);

    return Tooltip(
      message: widget.tooltip,
      child: InkWell(
        onTap: _tapped,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
        child: Padding(
          padding: const EdgeInsets.all(SpacingTokens.space4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _play,
                builder: (context, child) {
                  final t = _play.value;
                  final scale = t == 0
                      ? 1.0
                      : (_celebrating ? likePunch(t) : unlikePunch(t));

                  return Stack(
                    // So the burst can spill past a 17px icon. Nothing above
                    // this clips either -- the row leaves it the room.
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      if (_celebrating && t > 0 && t < 1)
                        Positioned(
                          left: -_reach,
                          right: -_reach,
                          top: -_reach,
                          bottom: -_reach,
                          child: IgnorePointer(
                            child: CustomPaint(
                              painter: LikeBurstPainter(
                                t: t,
                                colour:
                                    widget.activeColor ?? PostActionColors.like,
                              ),
                            ),
                          ),
                        ),
                      Transform.scale(scale: scale, child: child),
                    ],
                  );
                },
                child: Icon(widget.icon, size: 17, color: colour),
              ),
              if (widget.label != null) ...[
                const SizedBox(width: SpacingTokens.space4),
                // The number changes under a finger, so it moves rather than
                // swapping: up as it grows, down as it shrinks, which is the
                // direction the count itself went.
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  switchInCurve: Curves.easeOutCubic,
                  transitionBuilder: (child, animation) => ClipRect(
                    child: SlideTransition(
                      position: Tween(
                        begin: Offset(0, widget.active ? 0.7 : -0.7),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  child: Text(
                    widget.label!,
                    key: ValueKey(widget.label),
                    style: TextStyle(fontSize: 12, color: colour),
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

/// A count as a sentence: "1 like", "12 likes", "1.2K likes".
///
/// Spelled out rather than shown as a bare number beside an icon, because a
/// post's own screen has the room and "1 likes" is the kind of thing that
/// makes an app look unfinished.
String countLabel(int value, String singular, {String? plural}) {
  final word = value == 1 ? singular : (plural ?? '${singular}s');
  return '${formatCount(value)} $word';
}
