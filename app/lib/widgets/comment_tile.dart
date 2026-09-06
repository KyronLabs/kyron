// lib/widgets/comment_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/post_comment.dart';
import '../utils/format_count.dart';
import 'media_grid.dart';
import 'post_card.dart' show PostAvatar, age, openAuthor;
import 'post_text.dart';
import 'toast.dart';
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
              const SizedBox(width: SpacingTokens.space4),
              Text(
                '· ${age(comment.createdAt)}',
                style: TextStyle(
                  fontSize: 12,
                  color: scheme.onSurface.withValues(alpha: 0.45),
                ),
              ),
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

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return PopupMenuButton<CommentAction>(
      tooltip: 'More',
      padding: EdgeInsets.zero,
      position: PopupMenuPosition.under,
      icon: Icon(
        Iconsax.more,
        size: 16,
        color: scheme.onSurface.withValues(alpha: 0.45),
      ),
      constraints: const BoxConstraints(minWidth: 180),
      iconSize: 16,
      splashRadius: 16,
      onSelected: (action) async {
        if (action == CommentAction.copy) {
          await Clipboard.setData(ClipboardData(text: comment.content));
          if (context.mounted) Toast.show(context, 'Copied');
          return;
        }
        onAction(action);
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: CommentAction.openThread,
          child: _MenuRow(icon: Iconsax.message_text_copy, label: 'Open reply'),
        ),
        const PopupMenuItem(
          value: CommentAction.copy,
          child: _MenuRow(icon: Iconsax.copy_copy, label: 'Copy text'),
        ),
        if (!comment.mine)
          const PopupMenuItem(
            value: CommentAction.report,
            child: _MenuRow(icon: Iconsax.flag_copy, label: 'Report'),
          ),
        if (comment.mine)
          PopupMenuItem(
            value: CommentAction.delete,
            child: _MenuRow(
              icon: Iconsax.trash_copy,
              label: 'Delete',
              tint: scheme.error,
            ),
          ),
      ],
    );
  }
}

class _MenuRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? tint;

  const _MenuRow({required this.icon, required this.label, this.tint});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(icon, size: 17, color: tint),
          const SizedBox(width: SpacingTokens.space12),
          Text(label, style: TextStyle(fontSize: 14, color: tint)),
        ],
      );
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
