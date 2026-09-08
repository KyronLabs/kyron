// lib/widgets/comment_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:share_plus/share_plus.dart';

import '../models/feed_post.dart' show FeedAuthor;
import '../models/post_comment.dart';
import 'action_sheet.dart';
import '../utils/format_count.dart';
import 'media_grid.dart';
import 'post_card.dart' show PostAvatar, age, openAuthor;
import 'post_text.dart';
import 'toast.dart';
import 'thread.dart' show ThreadGeometry;
import 'voice_post_player.dart';

/// What a comment offers besides reading it.
enum CommentAction { copy, report, delete, openThread }

/// One comment's content: who wrote it, what it says, and what you can do
/// about it.
///
/// The avatar and the connector lines are not in here -- they belong to the
/// [ThreadItem] this sits inside, which is what lets a rail run behind the
/// whole row rather than stopping at the edge of a card.
class CommentTile extends StatelessWidget {
  final PostComment comment;

  /// Tapping the body opens this comment's own page. Null on the page that is
  /// already showing it.
  final VoidCallback? onOpen;

  final VoidCallback onReply;
  final VoidCallback onLike;
  final void Function(CommentAction) onAction;

  /// Larger type and no tap target, for the comment a thread page is about.
  final bool isRoot;

  const CommentTile({
    super.key,
    required this.comment,
    required this.onReply,
    required this.onLike,
    required this.onAction,
    this.onOpen,
    this.isRoot = false,
  });

  /// A link to this comment's own page, which is what sharing one means.
  static String linkTo(PostComment comment) =>
      'https://kyron.so/c/${comment.id}';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final visual = comment.media.where((m) => m.isVisual).toList();

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Header(comment: comment, onAction: onAction),
        if (comment.content.trim().isNotEmpty)
          PostText(
            content: comment.content,
            style: TextStyle(fontSize: isRoot ? 16 : 14, height: 1.35),
          ),
        // Split the same way a post's are: a recording is a player, not a
        // picture, and putting one through the grid draws an empty tile.
        for (final voice in comment.media.where((m) => m.isVoice))
          VoicePostPlayer(media: voice),
        if (visual.isNotEmpty) ...[
          const SizedBox(height: SpacingTokens.space8),
          MediaGrid(media: visual, radius: RadiusTokens.radiusSm),
        ],
        const SizedBox(height: SpacingTokens.space2),
        Row(
          children: [
            _Action(
              icon: comment.liked ? Iconsax.heart : Iconsax.heart_copy,
              label: 'Like',
              count: comment.likes,
              tint: comment.liked ? const Color(0xFFE0245E) : null,
              onTap: () {
                HapticFeedback.selectionClick();
                onLike();
              },
            ),
            const SizedBox(width: SpacingTokens.space20),
            _Action(
              icon: Iconsax.message_copy,
              label: 'Reply',
              count: comment.replies,
              onTap: onReply,
            ),
            const SizedBox(width: SpacingTokens.space20),
            // No repost beside these. A comment cannot be reposted -- there is
            // no endpoint and no model for it -- and a glyph that only ever
            // does nothing is worse than a row of three.
            _Action(
              icon: Iconsax.send_2_copy,
              label: 'Share',
              count: 0,
              onTap: () => Share.share(linkTo(comment)),
            ),
          ],
        ),
      ],
    );

    if (onOpen == null) return body;

    return InkWell(
      onTap: onOpen,
      // Transparent rather than a tint: a highlight here would fight the rail
      // running behind the row.
      splashFactory: NoSplash.splashFactory,
      highlightColor: scheme.onSurface.withValues(alpha: 0.03),
      child: body,
    );
  }
}

/// Says a comment was written by whoever wrote the post.
///
/// Worth a badge rather than a colour: in a long thread the author's own
/// answers are the ones people are looking for, and a tint alone does not
/// survive being read quickly or being colour-blind.
class AuthorBadge extends StatelessWidget {
  const AuthorBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
      ),
      child: Text(
        'Author',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: scheme.primary,
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final PostComment comment;
  final void Function(CommentAction) onAction;

  const _Header({required this.comment, required this.onAction});

  /// Identity takes the only flex.
  ///
  /// The obvious spelling -- Flexible(name), Text(time), Spacer(), button --
  /// is wrong in a way that looks plausible: Flexible and Spacer both default
  /// to flex 1, so they split the free space and the button settles in the
  /// middle of the row rather than at its end.
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () => openAuthor(context, comment.author),
                  child: Text(
                    comment.author.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: SpacingTokens.space8),
              Text(
                age(comment.createdAt),
                style: TextStyle(
                  fontSize: 12,
                  color: scheme.onSurface.withValues(alpha: 0.45),
                ),
              ),
              if (comment.byAuthor) ...[
                const SizedBox(width: SpacingTokens.space8),
                const AuthorBadge(),
              ],
            ],
          ),
        ),
        _Overflow(comment: comment, onAction: onAction),
      ],
    );
  }
}

/// The horizontal three-dot menu.
class _Overflow extends StatelessWidget {
  final PostComment comment;
  final void Function(CommentAction) onAction;

  const _Overflow({required this.comment, required this.onAction});

  Future<void> _open(BuildContext context) async {
    final action = await ActionSheet.show<CommentAction>(
      context,
      actions: [
        const SheetAction(
          value: CommentAction.openThread,
          label: 'Open reply',
          icon: Iconsax.message_text_copy,
        ),
        const SheetAction(
          value: CommentAction.copy,
          label: 'Copy text',
          icon: Iconsax.copy_copy,
        ),
        if (!comment.mine)
          const SheetAction(
            value: CommentAction.report,
            label: 'Report',
            icon: Iconsax.flag_copy,
          ),
        if (comment.mine)
          const SheetAction(
            value: CommentAction.delete,
            label: 'Delete',
            icon: Iconsax.trash_copy,
            destructive: true,
          ),
      ],
    );
    if (action == null) return;

    if (action == CommentAction.copy) {
      await Clipboard.setData(ClipboardData(text: comment.content));
      if (context.mounted) Toast.show(context, 'Copied');
      return;
    }
    onAction(action);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return IconButton(
      tooltip: 'More',
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
      iconSize: 16,
      icon: Icon(
        Iconsax.more_copy,
        size: 16,
        color: scheme.onSurface.withValues(alpha: 0.45),
      ),
      onPressed: () => _open(context),
    );
  }
}

/// One action under a comment: a glyph, and its count when there is one.
class _Action extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final Color? tint;
  final VoidCallback onTap;

  const _Action({
    required this.icon,
    required this.label,
    required this.count,
    required this.onTap,
    this.tint,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colour = tint ?? scheme.onSurface.withValues(alpha: 0.5);

    return Semantics(
      button: true,
      label: count == 0 ? label : '$label, $count',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: colour),
              if (count > 0) ...[
                const SizedBox(width: SpacingTokens.space4),
                Text(
                  formatCount(count),
                  style: TextStyle(fontSize: 12, color: colour),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// The avatar a thread row puts in its leading slot.
class CommentAvatar extends StatelessWidget {
  final PostComment comment;
  final double size;

  const CommentAvatar({super.key, required this.comment, this.size = 34});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => openAuthor(context, comment.author),
        child: PostAvatar(author: comment.author, radius: size / 2),
      );
}

/// The row that opens a folded run of replies.
///
/// The faces are the people who actually answered, sent with the comment.
/// Where there are none the row is just its label -- a stack of blank circles
/// would say somebody is there when nobody is.
///
/// Sized to sit in a [ThreadItem]'s leading slot, so its rail lands in the
/// same column as the avatars above and below it rather than beside them.
class ThreadMoreReplies extends StatelessWidget {
  final List<FeedAuthor> faces;
  final int count;
  final bool busy;
  final VoidCallback onTap;

  /// Diameter of one face. Smaller than a comment's avatar: this row is a
  /// signpost, not a voice in the conversation.
  static const double faceSize = 20;

  /// How far each face is tucked under the one before it.
  static const double overlap = 7;

  const ThreadMoreReplies({
    super.key,
    required this.faces,
    required this.count,
    required this.onTap,
    this.busy = false,
  });

  /// How wide the spinner is, and the gap before it.
  static const double spinnerSize = 14;
  static const double spinnerGap = 6;

  /// The leading slot this needs, so the caller and the painter agree.
  ///
  /// Wider while loading, because the spinner sits beside the faces rather
  /// than replacing them: a row whose leading element changes size mid-fetch
  /// shifts the rail it is supposed to hang from.
  static double widthFor(int faceCount, {bool busy = false}) {
    final faces = faceCount == 0
        ? ThreadGeometry.avatar
        : faceSize + (faceCount - 1) * (faceSize - overlap);
    return busy ? faces + spinnerGap + spinnerSize : faces;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: busy ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space4),
        child: Row(
          children: [
            // The label stays while the replies are fetched. Swapping it for a
            // spinner loses the one thing the row was saying, and a reader who
            // tapped it already knows something is happening.
            Text(
              count == 1
                  ? 'Show 1 reply'
                  : 'Show ${formatCount(count)} replies',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface.withValues(alpha: busy ? 0.4 : 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The stack of faces, and the spinner beside them, for the leading slot.
  Widget leading(BuildContext context) {
    final shown = faces.take(3).toList();
    if (shown.isEmpty && !busy) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final facesWidth = widthFor(shown.length);

    return SizedBox(
      width: widthFor(shown.length, busy: busy),
      height: faceSize,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          for (var i = 0; i < shown.length; i++)
            Positioned(
              left: i * (faceSize - overlap),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // A ring in the page colour, so overlapping faces read as
                  // separate people rather than one smudge.
                  border: Border.all(color: scheme.surface, width: 1.5),
                ),
                child: PostAvatar(
                  author: shown[i],
                  radius: (faceSize - 3) / 2,
                ),
              ),
            ),
          // Beside the faces, not over them: the point is that these are the
          // people whose replies are on their way.
          if (busy)
            Positioned(
              left: facesWidth + spinnerGap,
              child: SizedBox.square(
                dimension: spinnerSize,
                child: CircularProgressIndicator(
                  strokeWidth: 1.6,
                  color: scheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
