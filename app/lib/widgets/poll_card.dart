// lib/widgets/poll_card.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/feed_post.dart';
import '../models/poll.dart';
import '../providers/feed_provider.dart';
import '../repositories/feed_repository.dart';
import '../utils/api_error_message.dart';
import '../utils/format_count.dart';

/// A poll under a post.
///
/// Results are always shown, before and after voting. Hiding them until you
/// answer makes a poll something you have to take part in to read, and nothing
/// stops a client showing them anyway -- the counts are in the same response.
class PollCard extends ConsumerStatefulWidget {
  final String postId;
  final Poll poll;

  /// Called with the post the server returns after a vote, so the list holding
  /// it shows the server's counts rather than a guess.
  final ValueChanged<FeedPost>? onVoted;

  const PollCard({
    super.key,
    required this.postId,
    required this.poll,
    this.onVoted,
  });

  @override
  ConsumerState<PollCard> createState() => _PollCardState();
}

class _PollCardState extends ConsumerState<PollCard> {
  /// Which option is mid-flight, so only that row shows a spinner.
  String? _voting;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final poll = widget.poll;

    return Padding(
      padding: const EdgeInsets.only(top: SpacingTokens.space12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final option in poll.options)
            Padding(
              padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
              child: _Option(
                option: option,
                poll: poll,
                busy: _voting == option.id,
                // Your own answer, tapped again, takes the vote back. A poll
                // with no way out punishes a mistap: the row is written the
                // instant the option is touched and there was nothing to undo
                // it with.
                //
                // Every row is inert while any vote is in flight, so a second
                // tap cannot start a request the first has already lost.
                onVote: _voting != null || poll.closed
                    ? null
                    : poll.votedOptionId == option.id
                        ? () => _retract(option.id)
                        : poll.hasVoted
                            // Not inert, and not a second vote either: a row
                            // that does nothing when tapped is worse than one
                            // that says why it will not.
                            ? _explainSwitch
                            : () => _vote(option.id),
              ),
            ),
          // One line of text rather than three in a row: three of them ran off
          // the edge at a larger text size, because nothing in a Row gives way.
          Text(
            '${formatCount(poll.totalVotes)} '
            '${poll.totalVotes == 1 ? 'vote' : 'votes'}'
            '  \u00b7  ${poll.remaining}',
            style: TextStyle(
              fontSize: 12,
              color: scheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          // Said rather than left to be discovered. Nothing about a filled row
          // suggests it can be tapped again, so without this the way out is a
          // feature only somebody who mistapped twice would ever find.
          if (poll.hasVoted && !poll.closed)
            Padding(
              padding: const EdgeInsets.only(top: SpacingTokens.space4),
              child: Text(
                'Tap your answer again to take your vote back.',
                style: TextStyle(
                  fontSize: 12,
                  color: scheme.onSurface.withValues(alpha: 0.45),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _explainSwitch() {
    unawaited(HapticFeedback.selectionClick());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Take your vote back first to change it.'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> _vote(String optionId) => _run(
        optionId,
        (repo) => repo.voteOnPoll(widget.postId, optionId),
      );

  Future<void> _retract(String optionId) => _run(
        optionId,
        (repo) => repo.retractVote(widget.postId),
      );

  Future<void> _run(
    String optionId,
    Future<FeedPost> Function(FeedRepository repo) action,
  ) async {
    setState(() => _voting = optionId);
    unawaited(HapticFeedback.selectionClick());
    try {
      final post = await action(ref.read(feedRepositoryProvider));
      widget.onVoted?.call(post);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(describeApiError(error, sessionIsLive: true))),
      );
    } finally {
      if (mounted) setState(() => _voting = null);
    }
  }
}

/// One answer, drawn as a bar that fills to its share of the vote.
///
/// A loader, not a tinted box: the fill is a solid block of the theme's
/// strongest colour, running from the left to exactly the share this answer
/// has, so the row reads as a quantity at a glance rather than as a box with a
/// number in the corner.
///
/// It is drawn twice -- once in the colours that read on the track, once in
/// the colours that read on the fill, with the second clipped to the fill's
/// width. Both layers are laid out at the full width, so the words line up
/// exactly and each half of a label that straddles the boundary stays legible.
/// One layer with a single text colour has to be wrong on one side or the
/// other.
class _Option extends StatelessWidget {
  final PollOption option;
  final Poll poll;
  final bool busy;
  final VoidCallback? onVote;

  const _Option({
    required this.option,
    required this.poll,
    required this.busy,
    this.onVote,
  });

  /// Tall enough to read and to press. A minimum rather than a fixed height:
  /// at a larger text size a fixed row crops the answer inside it.
  static const double _minHeight = 52;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final share = option.share(poll.totalVotes).clamp(0.0, 1.0);
    final mine = poll.votedOptionId == option.id;

    final radius = BorderRadius.circular(RadiusTokens.radiusLg);

    return InkWell(
      onTap: onVote,
      borderRadius: radius,
      child: ClipRRect(
        borderRadius: radius,
        child: Stack(
          children: [
            // The track, and the answer as it reads on it.
            //
            // A fill rather than an outline. An outline around every answer
            // draws four boxes and leaves the reader to find the numbers
            // inside them; a filled track reads as an empty bar, which is
            // what it is.
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.onSurface.withValues(alpha: 0.06),
                borderRadius: radius,
              ),
              child: _Row(
                option: option,
                mine: mine,
                busy: busy,
                share: share,
                textColor: scheme.onSurface.withValues(alpha: 0.85),
                mutedColor: scheme.onSurface.withValues(alpha: 0.55),
              ),
            ),

            // The same row again, in the colours that read on a solid fill,
            // clipped to how far the fill reaches.
            Positioned.fill(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(end: share),
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) => ClipRect(
                  clipper: _FillClipper(value),
                  child: child,
                ),
                child: ColoredBox(
                  color: scheme.onSurface,
                  child: _Row(
                    option: option,
                    mine: mine,
                    busy: busy,
                    share: share,
                    textColor: scheme.surface,
                    mutedColor: scheme.surface.withValues(alpha: 0.85),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The contents of an answer row, drawn once per colour scheme.
class _Row extends StatelessWidget {
  final PollOption option;
  final bool mine;
  final bool busy;
  final double share;
  final Color textColor;
  final Color mutedColor;

  const _Row({
    required this.option,
    required this.mine,
    required this.busy,
    required this.share,
    required this.textColor,
    required this.mutedColor,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: _Option._minHeight),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space16,
          vertical: SpacingTokens.space12,
        ),
        child: Row(
          children: [
            if (mine) ...[
              Icon(Iconsax.tick_circle, size: 16, color: textColor),
              const SizedBox(width: SpacingTokens.space8),
            ],
            Expanded(
              child: Text(
                option.text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: mine ? FontWeight.w700 : FontWeight.w500,
                  color: textColor,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(width: SpacingTokens.space12),
            if (busy)
              SizedBox.square(
                dimension: 15,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: mutedColor,
                ),
              )
            else
              Text(
                '${(share * 100).round()}%',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: mutedColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Shows the leftmost [share] of what it wraps.
class _FillClipper extends CustomClipper<Rect> {
  final double share;

  const _FillClipper(this.share);

  @override
  Rect getClip(Size size) =>
      Rect.fromLTWH(0, 0, size.width * share.clamp(0.0, 1.0), size.height);

  @override
  bool shouldReclip(_FillClipper old) => old.share != share;
}
