// lib/screens/post_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/current_user.dart';
import '../models/feed_post.dart';
import '../models/post_comment.dart';
import '../providers/current_user_provider.dart';
import '../providers/feed_provider.dart';
import '../providers/post_detail_provider.dart';
import '../routes.dart';
import '../utils/format_count.dart';
import '../widgets/link_preview_card.dart';
import '../widgets/media_grid.dart';
import '../widgets/media_tray.dart';
import '../widgets/poll_card.dart';
import '../widgets/post_actions_row.dart';
import '../widgets/post_card.dart';
import '../widgets/post_options_sheet.dart';
import '../widgets/post_text.dart';
import '../widgets/quoted_post_card.dart';
import '../widgets/repost_sheet.dart';
import '../widgets/share_post_sheet.dart';
import '../widgets/voice_post_player.dart';

/// One post, with its comments and their replies.
///
/// Tapping a post used to open its author's profile, which is not what anyone
/// means by tapping a post.
class PostDetailScreen extends ConsumerStatefulWidget {
  final String postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  final _controller = TextEditingController();
  final _focus = FocusNode();
  final _scroll = ScrollController();

  /// The comment being replied to, or null to comment on the post itself.
  PostComment? _replyingTo;

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    _scroll.dispose();
    super.dispose();
  }

  PostDetailNotifier get _notifier =>
      ref.read(postDetailProvider(widget.postId).notifier);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postDetailProvider(widget.postId));
    final post = state.post;
    final me = ref.watch(currentUserProvider).asData?.value;
    final mine = post != null && me != null && post.author.id == me.id;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: const Text('Post'),
        actions: [
          if (mine)
            IconButton(
              icon: const Icon(Iconsax.chart_2_copy, size: 20),
              tooltip: 'Post analytics',
              onPressed: () => Navigator.pushNamed(
                context,
                Routes.postAnalytics,
                arguments: post.id,
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _body(state, me)),
            if (post != null) _composer(state),
          ],
        ),
      ),
    );
  }

  Widget _body(PostDetailState state, CurrentUser? me) {
    if (state.isLoading && state.post == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final post = state.post;
    if (post == null) {
      return _Failed(
        message: state.error ?? 'That post is no longer here.',
        onRetry: _notifier.load,
      );
    }

    return RefreshIndicator(
      onRefresh: _notifier.load,
      child: ListView.builder(
        controller: _scroll,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: SpacingTokens.space16),
        itemCount: state.comments.length + 2 + (state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _Post(
              post: post,
              notifier: _notifier,
              onReply: () => _replyTo(null),
            );
          }
          if (index == 1) return _ThreadHeading(count: post.comments);

          final commentIndex = index - 2;
          if (commentIndex >= state.comments.length) {
            return _MoreButton(onTap: _notifier.loadMore);
          }

          final comment = state.comments[commentIndex];
          return _Comment(
            comment: comment,
            replies: state.replies[comment.id] ?? const [],
            expanded: state.expanded.contains(comment.id),
            onToggleReplies: () => _notifier.toggleReplies(comment.id),
            onReply: () => _replyTo(comment),
            onDelete: (target) => report(
              context,
              _notifier.deleteComment(target),
            ),
          );
        },
      ),
    );
  }

  Widget _composer(PostDetailState state) {
    final scheme = Theme.of(context).colorScheme;
    final replyingTo = _replyingTo;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: scheme.outline.withValues(alpha: 0.15),
            width: 0.5,
          ),
        ),
      ),
      padding: EdgeInsets.only(
        left: SpacingTokens.space12,
        right: SpacingTokens.space8,
        top: SpacingTokens.space8,
        bottom: MediaQuery.of(context).viewInsets.bottom > 0
            ? SpacingTokens.space8
            : SpacingTokens.space12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (replyingTo != null)
            Padding(
              padding: const EdgeInsets.only(bottom: SpacingTokens.space4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Replying to ${replyingTo.author.displayName}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: scheme.primary,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Iconsax.close_circle_copy, size: 16),
                    tooltip: 'Cancel reply',
                    visualDensity: VisualDensity.compact,
                    onPressed: () => setState(() => _replyingTo = null),
                  ),
                ],
              ),
            ),
          MediaTray(
            media: state.media,
            height: 84,
            onRemove: _notifier.detach,
            onRetry: _notifier.retryAttachment,
            onDescribe: (item) async {
              final alt = await askForAltText(context, item.alt);
              if (alt != null && mounted) {
                _notifier.describeAttachment(item.path, alt);
              }
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Iconsax.gallery_copy, size: 20),
                tooltip: 'Add a photo',
                onPressed: state.canAttach ? () => _attach(video: false) : null,
              ),
              IconButton(
                icon: const Icon(Iconsax.video_copy, size: 20),
                tooltip: 'Add a video',
                onPressed: state.canAttach ? () => _attach(video: true) : null,
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focus,
                  minLines: 1,
                  maxLines: 4,
                  maxLength: 500,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText:
                        replyingTo == null ? 'Add a comment' : 'Write a reply',
                    border: InputBorder.none,
                    counterText: '',
                    isDense: true,
                  ),
                ),
              ),
              IconButton(
                icon: state.isSending
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Iconsax.send_1_copy, size: 20),
                tooltip: 'Send',
                // A picture with no words is a reply; an empty box is not.
                onPressed:
                    (_controller.text.trim().isEmpty && state.media.isEmpty) ||
                            state.isSending ||
                            state.isUploading
                        ? null
                        : _send,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _attach({required bool video}) async {
    final message = await _notifier.attach(video: video);
    if (message != null && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  /// Puts the cursor in the box. A null comment replies to the post itself,
  /// which is what the post's own reply button does.
  void _replyTo(PostComment? comment) {
    setState(() => _replyingTo = comment);
    _focus.requestFocus();
  }

  Future<void> _send() async {
    final text = _controller.text;
    final parent = _replyingTo;

    final message = await _notifier.comment(text, parentId: parent?.id);
    if (!mounted) return;

    if (message != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
      return;
    }

    HapticFeedback.lightImpact();
    _controller.clear();
    setState(() => _replyingTo = null);
  }
}

class _Post extends ConsumerWidget {
  final FeedPost post;
  final PostDetailNotifier notifier;

  /// Puts the cursor in the box at the bottom of this screen. Reply is the one
  /// action here that does not need to go anywhere.
  final VoidCallback onReply;

  const _Post({
    required this.post,
    required this.notifier,
    required this.onReply,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final handle = post.author.handle;
    final visual = post.media.where((m) => m.isVisual).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space16,
        SpacingTokens.space12,
        SpacingTokens.space16,
        SpacingTokens.space8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => openAuthor(context, post.author),
                child: PostAvatar(author: post.author, radius: 20),
              ),
              const SizedBox(width: SpacingTokens.space12),
              Expanded(
                child: GestureDetector(
                  onTap: () => openAuthor(context, post.author),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.author.displayName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      if (handle != null)
                        Text(
                          handle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: scheme.onSurface.withValues(alpha: 0.55),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              _Overflow(post: post),
            ],
          ),
          const SizedBox(height: SpacingTokens.space12),

          // Bigger than in the feed: on a screen showing one post, the post is
          // the content rather than one row of a list.
          if (post.content.trim().isNotEmpty)
            PostText(
              content: post.content,
              style: const TextStyle(fontSize: 17, height: 1.4),
            ),

          // Everything a card shows, in the order a card shows it. This screen
          // used to hand the whole media list to the grid -- so a voice post
          // was a tile with nothing in it -- and drew neither a poll nor a
          // link preview at all.
          for (final voice in post.media.where((m) => m.isVoice))
            VoicePostPlayer(media: voice),
          if (visual.isNotEmpty) ...[
            const SizedBox(height: SpacingTokens.space12),
            MediaGrid(media: visual),
          ],
          if (post.poll != null)
            PollCard(
              postId: post.id,
              poll: post.poll!,
              onVoted: notifier.replacePost,
            ),
          if (post.media.isEmpty &&
              post.quotedPost == null &&
              post.firstLink != null)
            LinkPreviewCard(url: post.firstLink!),
          if (post.quotedPost != null) ...[
            const SizedBox(height: SpacingTokens.space12),
            QuotedPostCard(post: post.quotedPost!),
          ],

          const SizedBox(height: SpacingTokens.space12),
          Text(
            _stamp(post.createdAt),
            style: TextStyle(
              fontSize: 13,
              color: scheme.onSurface.withValues(alpha: 0.5),
            ),
          ),

          // Counts spelled out, which is what the room on this screen is for:
          // "1 like" rather than a bare 1 beside a heart, and never "1 likes".
          if (post.likes > 0 || post.reposts > 0 || post.comments > 0) ...[
            const _Hairline(),
            Wrap(
              spacing: SpacingTokens.space16,
              runSpacing: SpacingTokens.space4,
              children: [
                if (post.reposts > 0)
                  _Tally(text: countLabel(post.reposts, 'repost')),
                if (post.likes > 0)
                  _Tally(text: countLabel(post.likes, 'like')),
                if (post.comments > 0)
                  _Tally(
                    text: countLabel(post.comments, 'reply', plural: 'replies'),
                  ),
              ],
            ),
          ],

          const _Hairline(),
          // The same row as the card, from the same widget -- so the two
          // cannot drift apart again. Counts are off here because they are
          // spelled out above.
          PostActionsRow(
            post: post,
            showCounts: false,
            onReply: onReply,
            onRepost: () => RepostSheet.show(
              context,
              post: post,
              onRepost: notifier.toggleRepost,
            ),
            onLike: () => report(context, notifier.toggleLike()),
            onSave: () => report(context, notifier.toggleSave()),
            onShare: () => SharePostSheet.show(context, post),
          ),
        ],
      ),
    );
  }

  /// The full date and time. A post's own screen is the one place "6m" is not
  /// enough -- it is where you go to find out exactly when.
  static String _stamp(DateTime at) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour = at.hour % 12 == 0 ? 12 : at.hour % 12;
    final minute = at.minute.toString().padLeft(2, '0');
    final meridiem = at.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $meridiem \u00b7 ${at.day} ${months[at.month - 1]} ${at.year}';
  }
}

/// The separator this screen uses, matching the one between posts in a feed:
/// a half-pixel hairline the full width of the content, not a Material
/// Divider with its own inset and its own idea of how much space to take.
class _Hairline extends StatelessWidget {
  const _Hairline();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space12),
      child: Container(
        height: 0.5,
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.15),
      ),
    );
  }
}

/// One spelled-out count under a post.
class _Tally extends StatelessWidget {
  final String text;

  const _Tally({required this.text});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 13,
          color: scheme.onSurface.withValues(alpha: 0.6),
        ),
        children: [
          TextSpan(
            text: text.split(' ').first,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
          TextSpan(text: ' ${text.split(' ').sublist(1).join(' ')}'),
        ],
      ),
    );
  }
}

/// The overflow menu, top right of the post.
class _Overflow extends ConsumerWidget {
  final FeedPost post;

  const _Overflow({required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return IconButton(
      icon: Icon(
        Iconsax.more_copy,
        size: 18,
        color: scheme.onSurface.withValues(alpha: 0.6),
      ),
      tooltip: 'More',
      onPressed: () => PostOptionsSheet.show(
        context,
        ref,
        post: post,
        source: PostListSource.recent,
      ),
    );
  }
}

class _ThreadHeading extends StatelessWidget {
  final int count;

  const _ThreadHeading({required this.count});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space16,
        SpacingTokens.space8,
        SpacingTokens.space16,
        SpacingTokens.space4,
      ),
      child: Text(
        count == 0
            ? 'No comments yet'
            : count == 1
                ? '1 comment'
                : '${formatCount(count)} comments',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
          color: scheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

class _Comment extends StatelessWidget {
  final PostComment comment;
  final List<PostComment> replies;
  final bool expanded;
  final VoidCallback onToggleReplies;
  final VoidCallback onReply;
  final void Function(PostComment) onDelete;

  const _Comment({
    required this.comment,
    required this.replies,
    required this.expanded,
    required this.onToggleReplies,
    required this.onReply,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CommentRow(
          comment: comment,
          onReply: onReply,
          onDelete: () => onDelete(comment),
        ),
        if (comment.replies > 0)
          Padding(
            padding: const EdgeInsets.only(left: 56),
            child: TextButton(
              onPressed: onToggleReplies,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space8,
                ),
                visualDensity: VisualDensity.compact,
              ),
              child: Text(
                expanded
                    ? 'Hide replies'
                    : comment.replies == 1
                        ? '1 reply'
                        : '${formatCount(comment.replies)} replies',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        if (expanded)
          for (final reply in replies)
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: _CommentRow(
                comment: reply,
                // One level of replies. A reply to a reply lands in the same
                // thread, so there is nothing deeper to open.
                onReply: onReply,
                onDelete: () => onDelete(reply),
              ),
            ),
      ],
    );
  }
}

class _CommentRow extends StatelessWidget {
  final PostComment comment;
  final VoidCallback onReply;
  final VoidCallback onDelete;

  const _CommentRow({
    required this.comment,
    required this.onReply,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space16,
        SpacingTokens.space8,
        SpacingTokens.space8,
        SpacingTokens.space4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => openAuthor(context, comment.author),
            child: PostAvatar(author: comment.author, radius: 14),
          ),
          const SizedBox(width: SpacingTokens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
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
                const SizedBox(height: SpacingTokens.space2),
                if (comment.content.trim().isNotEmpty)
                  PostText(
                    content: comment.content,
                    style: const TextStyle(fontSize: 14, height: 1.35),
                  ),
                // Split the same way a post's are: a recording is a player,
                // not a picture, and putting one through the grid draws a
                // tile with nothing in it.
                for (final voice in comment.media.where((m) => m.isVoice))
                  VoicePostPlayer(media: voice),
                if (comment.media.any((m) => m.isVisual)) ...[
                  const SizedBox(height: SpacingTokens.space8),
                  MediaGrid(
                    media: comment.media.where((m) => m.isVisual).toList(),
                    radius: RadiusTokens.radiusSm,
                  ),
                ],
                Row(
                  children: [
                    TextButton(
                      onPressed: onReply,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SpacingTokens.space8,
                        ),
                        visualDensity: VisualDensity.compact,
                        foregroundColor:
                            scheme.onSurface.withValues(alpha: 0.6),
                      ),
                      child:
                          const Text('Reply', style: TextStyle(fontSize: 12)),
                    ),
                    if (comment.mine)
                      TextButton(
                        onPressed: () => _confirmDelete(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SpacingTokens.space8,
                          ),
                          visualDensity: VisualDensity.compact,
                          foregroundColor: scheme.error,
                        ),
                        child: const Text('Delete',
                            style: TextStyle(fontSize: 12)),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete this comment?'),
        content: const Text('It will be removed from the thread.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(dialogContext).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) onDelete();
  }
}

class _MoreButton extends StatelessWidget {
  final VoidCallback onTap;

  const _MoreButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(onPressed: onTap, child: const Text('Load more')),
    );
  }
}

class _Failed extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _Failed({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_outlined,
                size: 44, color: scheme.onSurface.withValues(alpha: .35)),
            const SizedBox(height: SpacingTokens.space16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: SpacingTokens.space16),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
