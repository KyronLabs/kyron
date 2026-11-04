import 'dart:async';

import '../l10n/app_localizations.dart';

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
import '../widgets/post_action_colors.dart';
import '../providers/follow_provider.dart';
import '../providers/post_detail_provider.dart';
import '../routes.dart';
import '../utils/format_count.dart';
import '../widgets/jump_to_end.dart';
import '../widgets/link_preview_card.dart';
import '../widgets/media_grid.dart';
import '../widgets/media_tray.dart';
import '../widgets/poll_card.dart';
import '../widgets/post_actions_row.dart';
import '../widgets/community_avatar.dart';
import '../widgets/post_card.dart';
import '../models/post_media.dart' show MediaKind;
import '../widgets/gif_picker_sheet.dart';
import '../widgets/gift_sheet.dart';
import '../widgets/reply_bar.dart';
import '../widgets/post_options_sheet.dart';
import '../widgets/post_text.dart';
import '../widgets/quoted_post_card.dart';
import '../widgets/repost_sheet.dart';
import '../widgets/share_post_sheet.dart';
import '../widgets/voice_post_player.dart';
import '../widgets/toast.dart';
import '../widgets/empty_state.dart';
import '../widgets/hairline.dart';
import '../utils/thread_layout.dart';
import '../widgets/comment_tile.dart';
import '../widgets/thread.dart';
import '../repositories/moderation_repository.dart' show ReportTarget;
import 'report_screen.dart';
import '../widgets/skeleton.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/verified_badge.dart';

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

class _PostDetailScreenState extends ConsumerState<PostDetailScreen>
    with WidgetsBindingObserver {
  final _controller = TextEditingController();
  final _focus = FocusNode();
  final _scroll = ScrollController();

  /// The post's own header -- avatar, name, handle -- so the bar knows when
  /// it has scrolled out from under it.
  final _header = GlobalKey();

  /// Whether the bar is showing who wrote the post, which it does once their
  /// header has gone past the top of the screen.
  bool _authorInBar = false;

  /// The comment being replied to, or null to comment on the post itself.
  PostComment? _replyingTo;

  /// Held rather than read from [ref] on demand, because [dispose] needs it
  /// after this widget has already been taken off the tree.
  late final PostDetailNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = ref.read(postDetailProvider(widget.postId).notifier);
    WidgetsBinding.instance.addObserver(this);
    _notifier.enter();
    _scroll.addListener(_onScroll);
  }

  /// Swaps "Post" in the bar for the author once their header is gone, and
  /// back once it returns.
  ///
  /// Measured off the header itself rather than a guessed offset: a
  /// community post's header is taller -- the community line and the stacked
  /// avatars -- and a fixed number brought the name into the bar while the
  /// real one was still on screen, so it showed twice.
  void _onScroll() {
    final box = _header.currentContext?.findRenderObject() as RenderBox?;
    // The header sits under the post's top padding.
    final bottom = SpacingTokens.space12 + (box?.size.height ?? 48);
    final show = _scroll.hasClients && _scroll.offset > bottom;
    if (show != _authorInBar) setState(() => _authorInBar = show);
  }

  /// Ends the read when the app goes away, and starts a new one when it
  /// returns.
  ///
  /// Without this, every read that finishes by switching apps or locking the
  /// phone is lost: the process can be killed while it is in the background,
  /// and the time is never reported. That is a large share of all reads.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _notifier.enter();
    } else if (state == AppLifecycleState.paused) {
      _notifier.leave();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _notifier.leave();
    _controller.dispose();
    _focus.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postDetailProvider(widget.postId));
    final post = state.post;
    final me = ref.watch(currentUserProvider).asData?.value;
    final mine = post != null && me != null && post.author.id == me.id;

    return Scaffold(
      appBar: KyronAppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        // Who wrote it, once the header that says so has scrolled away: a
        // long thread otherwise leaves the reader with no idea whose post
        // they are answering. Rises into place, the way the header left.
        title: AnimatedSwitcher(
          duration: MotionTokens.fast,
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.35),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          layoutBuilder: (current, previous) => Stack(
            alignment: Alignment.centerLeft,
            children: [...previous, if (current != null) current],
          ),
          child: _authorInBar && post != null
              ? _BarAuthor(
                  key: const ValueKey('post-detail-bar-author'),
                  author: post.author,
                )
              : Text(
                  AppLocalizations.of(context).post,
                  key: const ValueKey('post-detail-bar-title'),
                ),
        ),
        // The menu is always the last thing on the right, where a reader
        // looks for it; your own post's analytics sit just inside it.
        actions: [
          if (mine)
            IconButton(
              icon: const Icon(Iconsax.chart_2_copy, size: 20),
              tooltip: AppLocalizations.of(context).postAnalytics,
              onPressed: () => Navigator.pushNamed(
                context,
                Routes.postAnalytics,
                arguments: post.id,
              ),
            ),
          if (post != null) _Overflow(post: post),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(child: _body(state, me)),
                  // Upwards: the post is at the top, and a long comment
                  // thread leaves the reader nowhere to get back to it.
                  Positioned(
                    right: SpacingTokens.space12,
                    top: SpacingTokens.space12,
                    child: JumpToEnd(
                      controller: _scroll,
                      direction: JumpDirection.top,
                    ),
                  ),
                ],
              ),
            ),
            if (post != null) _composer(state),
          ],
        ),
      ),
    );
  }

  Widget _body(PostDetailState state, CurrentUser? me) {
    if (state.isLoading && state.post == null) {
      return SkeletonList.posts(count: 1);
    }

    final post = state.post;
    if (post == null) {
      return _Failed(
        message: state.error ?? 'That post is no longer here.',
        onRetry: _notifier.load,
      );
    }

    // Once for the build, not once per row: this was rebuilding the whole
    // thread for every comment drawn.
    final rows = _thread(state).rows;

    return RefreshIndicator(
      onRefresh: _notifier.load,
      child: ListView.builder(
        controller: _scroll,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: SpacingTokens.space16),
        // Post, heading, then either the comments or the one line saying
        // there are none. The empty case used to render the heading and
        // then nothing at all, which reads as a list still loading.
        itemCount: state.comments.isEmpty
            ? 3
            : rows.length + 2 + (state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _Post(
              headerKey: _header,
              post: post,
              notifier: _notifier,
              onReply: () => _replyTo(null),
            );
          }
          if (index == 1) return _ThreadHeading(count: post.comments);
          if (state.comments.isEmpty) {
            return EmptyState(
              compact: true,
              art: EmptyArt.messages,
              title: AppLocalizations.of(context).literalnoRepliesYet,
              detail: 'Be the first to say something.',
            );
          }

          final rowIndex = index - 2;
          if (rowIndex >= rows.length) {
            return _MoreButton(onTap: _notifier.loadMore);
          }

          final row = rows[rowIndex];
          final comment = row.comment;
          final expanded = state.expanded.contains(comment.id);
          // Replies are fetched only when asked for, so an unexpanded comment
          // simply has no children in the flat list. The affordance is driven
          // by the count the server sent, not by what happens to be loaded.
          //
          // At every depth, not just the top: a reply now keeps the parent it
          // was written under, so a nested comment has answers of its own and
          // gating this on depth 0 hid them behind nothing at all.
          // The row stays put while its replies are on their way, carrying a
          // spinner beside its faces. Taking it away and putting nothing in
          // its place reads as the branch having been deleted.
          final fetching = state.loadingReplies.contains(comment.id);
          final foldedReplies = comment.replies > 0 && !expanded;

          // A hairline closes a top-level comment together with everything
          // hanging off it. The rule is [endsBranch], so it can be tested.
          final closesBranch = endsBranch(rows, rowIndex);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // The rows carry the same inset as the post and the heading
              // above them. Without it a comment began at the very edge of
              // the screen while everything else on the page was indented.
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ThreadItem(
                      depth: row.depth,
                      ancestorRails: row.ancestorRails,
                      // The rail under a folded comment has to reach the
                      // button that opens it, or the two read as unrelated.
                      hasChildrenBelow: row.hasChildrenBelow || foldedReplies,
                      isLastChild: row.isLastChild,
                      topGap: SpacingTokens.space12,
                      avatar: CommentAvatar(comment: comment),
                      child: CommentTile(
                        comment: comment,
                        onOpen: () => _openComment(comment),
                        onReply: () => _replyTo(comment),
                        onLike: () => _likeComment(comment),
                        onSave: () => report(
                          context,
                          _notifier.toggleCommentSave(comment),
                        ),
                        onGift: comment.mine
                            ? null
                            : (heart) => GiftSheet.openFor(
                                  heart,
                                  GiftTarget.comment(comment.id),
                                  onSent: (sent) =>
                                      _notifier.commentGiftsChanged(
                                    comment.id,
                                    sent.gifts,
                                    type: sent.type,
                                  ),
                                ),
                        onAction: (action) => _commentAction(action, comment),
                      ),
                    ),
                    // A row of the thread rather than a button beside it, so
                    // the rail from the comment above runs down into it
                    // instead of stopping at a band of padding the strip
                    // never covers.
                    if (foldedReplies)
                      Builder(
                        builder: (context) {
                          final marker = ThreadMoreReplies(
                            faces: comment.replyFaces,
                            count: comment.replies,
                            busy: fetching,
                            onTap: () => _notifier.toggleReplies(comment.id),
                          );
                          return ThreadItem(
                            depth: row.depth + 1,
                            ancestorRails: [
                              ...row.ancestorRails,
                              !row.isLastChild,
                            ],
                            hasChildrenBelow: false,
                            isLastChild: true,
                            avatarSize: ThreadMoreReplies.faceSize,
                            avatarWidth: ThreadMoreReplies.widthFor(
                              comment.replyFaces.length,
                              busy: fetching,
                            ),
                            avatar: marker.leading(context),
                            child: marker,
                          );
                        },
                      ),
                  ],
                ),
              ),
              // Outside the inset, because a rule that stops short of both
              // edges reads as part of the comment above it rather than as
              // the boundary between two conversations.
              if (closesBranch) const ThreadDivider(),
            ],
          );
        },
      ),
    );
  }

  Widget _composer(PostDetailState state) {
    final replyingTo = _replyingTo;

    return ReplyBar(
      controller: _controller,
      focus: _focus,
      hintText: replyingTo == null ? 'Add a comment' : 'Write a reply',
      replyingTo: replyingTo?.author.displayName,
      onCancelReply: () => setState(() => _replyingTo = null),
      onChanged: (_) => setState(() {}),
      // A picture with no words is a reply; an empty box is not.
      canSend: !(_controller.text.trim().isEmpty && state.media.isEmpty) &&
          !state.isSending &&
          !state.isUploading,
      sending: state.isSending,
      onSend: _send,
      canAttach: state.canAttach,
      onAddMedia: _attachFromGallery,
      onAddGif: _attachGif,
      media: state.media,
      onRemoveMedia: _notifier.detach,
      onRetryMedia: _notifier.retryAttachment,
      onDescribeMedia: (item) async {
        final alt = await askForAltText(context, item.alt);
        if (alt != null && mounted) {
          _notifier.describeAttachment(item.path, alt);
        }
      },
    );
  }

  Future<void> _attachFromGallery() async {
    final choice = await pickReplyAttachment(context);
    if (choice == null || !mounted) return;
    final message = switch (choice) {
      ReplyAttachment.photo => await _notifier.attach(video: false),
      ReplyAttachment.camera => await _notifier.capture(),
      ReplyAttachment.video => await _notifier.attach(video: true),
    };
    if (message != null && mounted) Toast.show(context, message);
  }

  Future<void> _attachGif() async {
    final path = await GifPickerSheet.show(context);
    if (path == null || !mounted) return;
    final message = await _notifier.attachFile(path, MediaKind.gif);
    if (message != null && mounted) Toast.show(context, message);
  }

  /// The rows to draw, from the comments loaded plus whichever reply runs
  /// have been opened.
  ///
  /// Nothing folds here: the list only ever holds what has been fetched, and
  /// the "show replies" button below a comment is what pulls the rest in.
  ///
  /// The assembly is [assembleThread]: a pure function, so the rule that a
  /// run only enters once its parent has can be tested.
  ThreadLayout _thread(PostDetailState state) => buildThreadLayout(
        assembleThread(
          comments: state.comments,
          replies: state.replies,
          expanded: state.expanded,
        ),
        collapseAfter: 1 << 30,
      );

  void _openComment(PostComment comment) =>
      Navigator.pushNamed(context, Routes.comment, arguments: comment.id);

  Future<void> _likeComment(PostComment comment) async {
    // The post's author liking a reply is the author's like, and its badge
    // should be there the moment they make it.
    final post = ref.read(postDetailProvider(widget.postId)).post;
    final me = ref.read(currentUserProvider).asData?.value;
    final asAuthor = post != null && me != null && post.author.id == me.id
        ? post.author
        : null;
    final error =
        await _notifier.toggleCommentLike(comment, asAuthor: asAuthor);
    if (error != null && mounted) Toast.show(context, error);
  }

  Future<void> _commentAction(CommentAction action, PostComment comment) async {
    switch (action) {
      case CommentAction.openThread:
        _openComment(comment);
      case CommentAction.report:
        await ReportScreen.open(
          context,
          target: ReportTarget.comment,
          targetId: comment.id,
          subject: 'this comment',
        );
      case CommentAction.delete:
        if (!mounted) return;
        report(context, _notifier.deleteComment(comment));
      case CommentAction.copy:
        break; // The tile owns the clipboard.
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
      Toast.show(context, message);
      return;
    }

    HapticFeedback.lightImpact();
    _controller.clear();
    setState(() => _replyingTo = null);
  }
}

class _Post extends ConsumerWidget {
  final FeedPost post;

  /// On the author's header row, for the bar to measure.
  final Key headerKey;
  final PostDetailNotifier notifier;

  /// Puts the cursor in the box at the bottom of this screen. Reply is the one
  /// action here that does not need to go anywhere.
  final VoidCallback onReply;

  const _Post({
    required this.headerKey,
    required this.post,
    required this.notifier,
    required this.onReply,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final handle = post.author.handle;
    final community = post.community;
    final visual = post.media.where((m) => m.isVisual).toList();
    final me = ref.watch(currentUserProvider).asData?.value;
    final mine = me != null && me.id == post.author.id;
    final tallied = post.likes > 0 ||
        post.reposts > 0 ||
        post.comments > 0 ||
        post.gifts > 0;

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
            key: headerKey,
            children: [
              // The same header a community post has in a feed: the author
              // in front of the community's picture, and the community named
              // above. Two targets, as it is two things.
              community == null
                  ? GestureDetector(
                      onTap: () => openAuthor(context, post.author),
                      child: PostAvatar(author: post.author, radius: 20),
                    )
                  : StackedPostAvatar(
                      community: community,
                      size: 48,
                      author: PostAvatar(author: post.author, radius: 13),
                      onCommunityTap: () => openCommunity(context, community),
                      onAuthorTap: () => openAuthor(context, post.author),
                    ),
              const SizedBox(width: SpacingTokens.space12),
              Expanded(
                child: GestureDetector(
                  onTap: () => openAuthor(context, post.author),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (community != null)
                        PostCommunityLine(community: community),
                      NameWithBadge(
                        name: post.author.displayName,
                        verified: post.author.verified,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: TypographyTokens.fontSize3,
                        ),
                      ),
                      if (handle != null)
                        Text(
                          handle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize2,
                            color: scheme.onSurface.withValues(alpha: 0.55),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // Where the menu used to be: the one thing you might want to do
              // about the person rather than the post. Not on your own.
              if (!mine && me != null) _FollowAuthor(post: post),
            ],
          ),
          const SizedBox(height: SpacingTokens.space12),

          // Bigger than in the feed: on a screen showing one post, the post is
          // the content rather than one row of a list.
          if (post.content.trim().isNotEmpty)
            PostText(
              content: post.content,
              style: const TextStyle(
                fontSize: TypographyTokens.fontSize4,
                height: 1.4,
              ),
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
              fontSize: TypographyTokens.fontSize2,
              color: scheme.onSurface.withValues(alpha: 0.5),
            ),
          ),

          // Counts spelled out, which is what the room on this screen is for:
          // "1 like" rather than a bare 1 beside a heart, and never "1 likes".
          if (tallied) ...[
            const _Rule.solid(),
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
                if (post.gifts > 0)
                  _Tally(text: countLabel(post.gifts, 'gift')),
              ],
            ),
          ],

          // Broken under the counts: the counts and the buttons are one
          // block about this post. Solid when there are no counts, because
          // then this is the line that ends the post's body.
          if (tallied) const _Rule.broken() else const _Rule.solid(),
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
            onGift: mine
                ? null
                : (heart) => GiftSheet.open(
                      heart,
                      post,
                      onSent: (sent) =>
                          notifier.giftsChanged(sent.gifts, type: sent.type),
                    ),
          ),
          // The end of the post: what follows is the conversation about it.
          // A little room first, so the line closes the row of buttons
          // rather than underlining it.
          const Padding(
            padding: EdgeInsets.only(top: SpacingTokens.space8),
            child: RuleLine(),
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

/// A rule across the post, with the room it needs above and below.
///
/// Solid where something ends -- the post's words and pictures, then the
/// block of its counts and actions -- and broken inside that block, between
/// the counts and the row of buttons, which are two halves of one thing.
/// See [BrokenRuleLine] for the rule.
class _Rule extends StatelessWidget {
  final bool broken;

  const _Rule.solid() : broken = false;
  const _Rule.broken() : broken = true;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space12),
        child: broken ? const BrokenRuleLine() : const RuleLine(),
      );
}

/// One spelled-out count under a post.
class _Tally extends StatelessWidget {
  final String text;

  const _Tally({required this.text});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // Text.rich, not RichText: RichText starts from no style at all, so the
    // counts were drawn in the platform's font rather than the app's Inter.
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: TypographyTokens.fontSize2,
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

/// The post's menu, in the header's top right corner.
class _Overflow extends ConsumerWidget {
  final FeedPost post;

  const _Overflow({required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      key: const ValueKey('post-detail-menu'),
      icon: const Icon(Iconsax.more_copy, size: 20),
      tooltip: AppLocalizations.of(context).ui('ui_more', 'More'),
      onPressed: () => PostOptionsSheet.show(
        context,
        ref,
        post: post,
        source: PostListSource.recent,
      ),
    );
  }
}

/// Follow, beside the author of somebody else's post.
///
/// Red with white words, the one solid colour in the header, because it is
/// the one thing in it that asks for something. Not shown at all if you
/// already follow them: a "Following" on every post of everybody you follow
/// is a label, not a button. Once you press it, it says so -- "Following",
/// with a tick, quiet -- for as long as you are on the post, so the press
/// visibly did something. Unfollowing is on their profile.
class _FollowAuthor extends ConsumerStatefulWidget {
  final FeedPost post;

  const _FollowAuthor({required this.post});

  @override
  ConsumerState<_FollowAuthor> createState() => _FollowAuthorState();
}

class _FollowAuthorState extends ConsumerState<_FollowAuthor> {
  /// The design system's Small button (frontend/components/buttons.md): its
  /// 13.1-point words and 8 of padding over and under them make a 30-point
  /// pill, and the 8 around it here make the 46-point target past its
  /// 40-point least. It was the Tiny button's words -- 11.3 on a 24-point
  /// pill -- which beside a 15-point name and a 40-point avatar read as a
  /// label stuck on the row rather than a button. The words are set at
  /// height 1, so the pill centres the letters themselves rather than a line
  /// box with Inter's extra room under it.
  static const double _height = 30;

  /// Pressed here, on this visit: show the quiet "Following" rather than
  /// nothing.
  bool _pressed = false;

  Future<void> _follow() async {
    unawaited(HapticFeedback.selectionClick());
    setState(() => _pressed = true);
    final error = await ref
        .read(followOverridesProvider.notifier)
        .follow(widget.post.author.id);
    if (!mounted || error == null) return;
    setState(() => _pressed = false);
    Toast.show(context, error);
  }

  @override
  Widget build(BuildContext context) {
    final author = widget.post.author;
    final following = ref.watch(
          followOverridesProvider.select((m) => m[author.id]),
        ) ??
        widget.post.followingAuthor;
    if (following && !_pressed) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final done = following;

    return Semantics(
      button: !done,
      label: done
          ? l10n.ui('ui_following', 'Following')
          : l10n
              .ui('follow_author', 'Follow {name}')
              .replaceAll('{name}', author.displayName),
      excludeSemantics: true,
      child: GestureDetector(
        key: const ValueKey('post-detail-follow'),
        behavior: HitTestBehavior.opaque,
        onTap: done ? null : _follow,
        // A lean pill, and a touch target taller than it: what is drawn and
        // what a thumb has to hit are different sizes.
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space8),
          child: AnimatedContainer(
            duration: MotionTokens.fast,
            curve: Curves.easeOutCubic,
            height: _height,
            padding:
                const EdgeInsets.symmetric(horizontal: SpacingTokens.space16),
            decoration: BoxDecoration(
              color: done
                  ? scheme.onSurface.withValues(alpha: 0.08)
                  : PostActionColors.like,
              borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
            ),
            alignment: Alignment.center,
            child: AnimatedSwitcher(
              duration: MotionTokens.fast,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween(begin: 0.85, end: 1.0).animate(animation),
                  child: child,
                ),
              ),
              child: done
                  ? Row(
                      key: const ValueKey('following'),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Iconsax.tick_circle_copy,
                          size: 14,
                          color: scheme.onSurface.withValues(alpha: 0.7),
                        ),
                        const SizedBox(width: SpacingTokens.space4),
                        Text(
                          l10n.ui('ui_following', 'Following'),
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize2,
                            height: 1,
                            fontWeight: FontWeight.w600,
                            color: scheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    )
                  : Text(
                      l10n.ui('ui_follow', 'Follow'),
                      key: const ValueKey('follow'),
                      style: const TextStyle(
                        fontSize: TypographyTokens.fontSize2,
                        height: 1,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The author, small, in the bar: what the header said, once it has gone.
///
/// The name over the handle at the bar's two sizes, beside a face a little
/// smaller than the back button's target, so the bar keeps its height.
class _BarAuthor extends StatelessWidget {
  final FeedAuthor author;

  const _BarAuthor({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final handle = author.handle;

    return Semantics(
      button: true,
      label: author.displayName,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => openAuthor(context, author),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PostAvatar(author: author, radius: 15),
            const SizedBox(width: SpacingTokens.space8),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NameWithBadge(
                    name: author.displayName,
                    verified: author.verified,
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize3,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      color: scheme.onSurface,
                    ),
                  ),
                  if (handle != null)
                    Text(
                      handle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: TypographyTokens.fontSize1,
                        height: 1.2,
                        color: scheme.onSurface.withValues(alpha: 0.55),
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
          fontSize: TypographyTokens.fontSize1,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
          color: scheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

class _MoreButton extends StatelessWidget {
  final VoidCallback onTap;

  const _MoreButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onTap,
        child: Text(AppLocalizations.of(context).loadMore),
      ),
    );
  }
}

class _Failed extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _Failed({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: EmptyState.failed(
          title: AppLocalizations.of(context).literalcouldNotLoadThisPost,
          detail: message,
          onAction: onRetry,
        ),
      ),
    );
  }
}
