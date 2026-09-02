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
          Row(
            children: [
              Text(
                '${formatCount(poll.totalVotes)} '
                '${poll.totalVotes == 1 ? 'vote' : 'votes'}',
                style: TextStyle(
                  fontSize: 12,
                  color: scheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              Text(
                '  ·  ',
                style: TextStyle(
                  fontSize: 12,
                  color: scheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
              Text(
                poll.remaining,
                style: TextStyle(
                  fontSize: 12,
                  color: scheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
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

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final share = option.share(poll.totalVotes);
    final mine = poll.votedOptionId == option.id;
    // Once the poll is decided, the leader is worth marking -- but only when
    // it is actually ahead, not when everything is tied at zero.
    final leading = poll.totalVotes > 0 &&
        option.votes ==
            poll.options.map((o) => o.votes).reduce((a, b) => a > b ? a : b);

    return InkWell(
      onTap: onVote,
      borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
          border: Border.all(
            color:
                mine ? scheme.primary : scheme.outline.withValues(alpha: 0.3),
            width: mine ? 1.4 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // The filled bar. A FractionallySizedBox rather than a computed
            // width: the row's width is not known here, and measuring it would
            // mean a LayoutBuilder per option.
            if (poll.hasVoted || poll.closed)
              Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: share.clamp(0.0, 1.0),
                  heightFactor: 1,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 260),
                    color: (mine || leading ? scheme.primary : scheme.onSurface)
                        .withValues(alpha: mine ? 0.22 : 0.1),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SpacingTokens.space12,
              ),
              child: Row(
                children: [
                  if (mine) ...[
                    Icon(Iconsax.tick_circle, size: 15, color: scheme.primary),
                    const SizedBox(width: SpacingTokens.space4),
                  ],
                  Expanded(
                    child: Text(
                      option.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: mine ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                  if (busy)
                    const SizedBox.square(
                      dimension: 14,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  else
                    Text(
                      '${(share * 100).round()}%',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface.withValues(alpha: 0.75),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
