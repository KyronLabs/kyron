import '../l10n/app_localizations.dart';

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
import 'post_action_colors.dart';
import 'post_actions_row.dart' show GiftStack, PostAction;
import 'post_text.dart';
import 'toast.dart';
import 'thread.dart' show ThreadGeometry;
import 'voice_post_player.dart';
import 'verified_badge.dart';

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

  /// Keeps it in the reader's saved list, or lets it go.
  final VoidCallback onSave;

  /// Holding the heart: the gift sheet, opened from [heart]. Null on the
  /// reader's own comment, which the server will not let them gift.
  final void Function(BuildContext heart)? onGift;

  /// Larger type and no tap target, for the comment a thread page is about.
  final bool isRoot;

  const CommentTile({
    super.key,
    required this.comment,
    required this.onReply,
    required this.onLike,
    required this.onAction,
    required this.onSave,
    this.onGift,
    this.onOpen,
    this.isRoot = false,
  });

  /// The width each of the two counted actions is given, whatever its count
  /// says. With the gap taken from the count instead, "12" pushed the reply
  /// button further right than "1" did, and down a thread the buttons
  /// wandered from row to row. In slots they line up. A least width, not a
  /// fixed one: a count too long for it at a large text size pushes the next
  /// button along rather than being cut off.
  static const double slot = 60;

  /// A link to this comment's own page, which is what sharing one means.
  static String linkTo(PostComment comment) =>
      'https://kyron.so/c/${comment.id}';

  /// The post's own size. At 16 under 15-point words the buttons read as
  /// footnotes; the hierarchy comes from the post's bigger words and face,
  /// not from shrinking what a reader taps.
  static const double _iconSize = 17;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final visual = comment.media.where((m) => m.isVisual).toList();

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Header(comment: comment, onAction: onAction),
        // A breath between the name and the words, as a post has: run
        // together, the name read as the first word of the reply.
        const SizedBox(height: SpacingTokens.space2),
        if (comment.content.trim().isNotEmpty)
          PostText(
            content: comment.content,
            style: TextStyle(
              fontSize: isRoot
                  ? TypographyTokens.fontSize4
                  : TypographyTokens.fontSize3,
              height: 1.4,
            ),
          ),
        // Split the same way a post's are: a recording is a player, not a
        // picture, and putting one through the grid draws an empty tile.
        for (final voice in comment.media.where((m) => m.isVoice))
          VoicePostPlayer(media: voice),
        if (visual.isNotEmpty) ...[
          const SizedBox(height: SpacingTokens.space8),
          MediaGrid(media: visual, radius: RadiusTokens.radiusSm),
        ],
        // Room between what was said and what can be done about it. At 2
        // the buttons sat on the last line of the reply like an underline,
        // and a thread read as one block of text and glyphs.
        const SizedBox(height: SpacingTokens.space8),
        // Moved left by the buttons' own padding, so the heart's edge sits
        // on the text's edge above it -- and the share icon, at the far
        // end, lands in the column of the menu dots in the header.
        Transform.translate(
          offset: const Offset(-SpacingTokens.space4, 0),
          child: Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: slot),
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: 1,
                  // The post's own heart, so a comment's like is the same
                  // red, throws the same burst, and holds for a gift the
                  // same way -- not a lookalike drifting from it.
                  child: PostAction(
                    icon: comment.liked ? Iconsax.heart : Iconsax.heart_copy,
                    iconSize: _iconSize,
                    labelSize: TypographyTokens.fontSize2,
                    label:
                        comment.likes > 0 ? formatCount(comment.likes) : null,
                    active: comment.liked,
                    activeColor: PostActionColors.like,
                    tooltip: l10n.ui('ui_like', 'Like'),
                    burst: true,
                    onTap: onLike,
                    onLongPress: onGift,
                    longPressHint: onGift == null
                        ? null
                        : l10n.ui('ui_gift_title', 'Send a gift'),
                    topper: comment.topGifts.isEmpty
                        ? null
                        : GiftStack(comment.topGifts),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: slot),
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: 1,
                  child: PostAction(
                    icon: Iconsax.message_copy,
                    iconSize: _iconSize,
                    labelSize: TypographyTokens.fontSize2,
                    label: comment.replies > 0
                        ? formatCount(comment.replies)
                        : null,
                    tooltip: l10n.reply,
                    onTap: onReply,
                  ),
                ),
              ),
              // No repost. A comment cannot be reposted -- there is no
              // endpoint and no model for it -- and a glyph that only ever
              // does nothing is worse than a shorter row.
              const Spacer(),
              // Keeping and passing on, together at the far end, as a post
              // has them: what you do with it, apart from what you say to it.
              PostAction(
                icon: comment.saved
                    ? Iconsax.archive_tick
                    : Iconsax.archive_add_copy,
                iconSize: _iconSize,
                active: comment.saved,
                activeColor: PostActionColors.save,
                tooltip:
                    comment.saved ? l10n.literalremoveFromSaved : l10n.save,
                onTap: onSave,
              ),
              const SizedBox(width: SpacingTokens.space8),
              PostAction(
                icon: Iconsax.export_1_copy,
                iconSize: _iconSize,
                tooltip: l10n.ui('ui_share', 'Share'),
                onTap: () => Share.share(linkTo(comment)),
              ),
              // The menu above is a 40-point button -- Material's least --
              // so its dots are centred 20 in from the edge. This puts the
              // share icon's centre there too: one column down the right.
              const SizedBox(width: SpacingTokens.space4),
            ],
          ),
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
          fontSize: TypographyTokens.fontSize1,
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

  /// How tall the line is: the name's own height, not the menu button's.
  ///
  /// The row used to take its height from the 28-point button at its end and
  /// centre the name in that, which sat the name a few points down from the
  /// top of the avatar beside it -- low enough to read as a second line
  /// rather than the start of the reply.
  static const double height = 20;

  /// Identity takes the only flex.
  ///
  /// The obvious spelling -- Flexible(name), Text(time), Spacer(), button --
  /// is wrong in a way that looks plausible: Flexible and Spacer both default
  /// to flex 1, so they split the free space and the button settles in the
  /// middle of the row rather than at its end.
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final authorLike = comment.authorLike;

    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () => openAuthor(context, comment.author),
                    child: NameWithBadge(
                      name: comment.author.displayName,
                      verified: comment.author.verified,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: TypographyTokens.fontSize2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: SpacingTokens.space8),
                Text(
                  age(comment.createdAt),
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize1,
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
          if (authorLike != null) ...[
            AuthorLikedBadge(author: authorLike),
            const SizedBox(width: SpacingTokens.space4),
          ],
          _Overflow(comment: comment, onAction: onAction),
        ],
      ),
    );
  }
}

/// The post's author liked this reply: their face, with a heart on it.
///
/// Beside the menu rather than in the action row, because it is not
/// something the reader can do -- it is something that happened, and a
/// face in the row of buttons reads as one more button.
class AuthorLikedBadge extends StatelessWidget {
  final FeedAuthor author;

  const AuthorLikedBadge({super.key, required this.author});

  /// 16: at 20 the author's face was nearly the size of the comment's own
  /// name and pulled the eye off it. This is a footnote, not a voice.
  static const double size = 16;

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context)
        .ui('ui_liked_by_author', 'Liked by the author');

    return Tooltip(
      message: label,
      child: Semantics(
        label: label,
        excludeSemantics: true,
        child: SizedBox.square(
          dimension: size,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              PostAvatar(author: author, radius: size / 2),
              // The heart on the face's lower corner, ringed in the page's
              // colour so the two read as stacked rather than overlapping.
              Positioned(
                right: -2.5,
                bottom: -2.5,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Iconsax.heart,
                    size: 8,
                    color: PostActionColors.like,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
        SheetAction(
          value: CommentAction.openThread,
          label: AppLocalizations.of(context).literalopenReply,
          icon: Iconsax.message_text_copy,
        ),
        SheetAction(
          value: CommentAction.copy,
          label: AppLocalizations.of(context).literalcopyText,
          icon: Iconsax.copy_copy,
        ),
        if (!comment.mine)
          SheetAction(
            value: CommentAction.report,
            label: AppLocalizations.of(context).report,
            icon: Iconsax.flag_copy,
          ),
        if (comment.mine)
          SheetAction(
            value: CommentAction.delete,
            label: AppLocalizations.of(context).delete,
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
      // As tall as the line it ends, wider than it is tall so it is still an
      // easy target from the side a thumb comes from. Material makes it 40
      // across whatever this asks; the share icon below is lined up on that.
      constraints: const BoxConstraints(
        minWidth: 32,
        minHeight: _Header.height,
      ),
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

/// The avatar a thread row puts in its leading slot.
class CommentAvatar extends StatelessWidget {
  final PostComment comment;
  final double size;

  const CommentAvatar({
    super.key,
    required this.comment,
    this.size = ThreadGeometry.avatar,
  });

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

  /// Said in place of "Show N replies": the post page's "View more replies",
  /// which opens a conversation's own page rather than unfolding here.
  final String? label;

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
    this.label,
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
              label ??
                  (count == 1
                      ? 'Show 1 reply'
                      : 'Show ${formatCount(count)} replies'),
              style: TextStyle(
                fontSize: TypographyTokens.fontSize1,
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
                child: PostAvatar(author: shown[i], radius: (faceSize - 3) / 2),
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
