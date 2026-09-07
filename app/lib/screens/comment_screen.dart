// lib/screens/comment_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/post_comment.dart';
import '../providers/comment_thread_provider.dart';
import '../providers/feed_provider.dart' show feedRepositoryProvider;
import '../repositories/moderation_repository.dart' show ReportTarget;
import '../routes.dart';
import 'report_screen.dart';
import '../utils/thread_layout.dart';
import '../utils/media_basket.dart';
import '../widgets/comment_tile.dart';
import '../widgets/empty_state.dart';
import '../widgets/hairline.dart';
import '../widgets/jump_to_end.dart';
import '../widgets/media_tray.dart';
import '../widgets/thread.dart';
import '../widgets/toast.dart';
import '../widgets/skeleton.dart';

/// One comment, and the conversation under it.
///
/// A reply used to be reachable only by expanding it in place on the post,
/// which meant a long exchange was read through a keyhole and could not be
/// linked to. This is that exchange on its own page, threaded, with the
/// comment it is about at the top.
class CommentScreen extends ConsumerStatefulWidget {
  final String commentId;

  const CommentScreen({super.key, required this.commentId});

  @override
  ConsumerState<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  final _box = TextEditingController();
  final _focus = FocusNode();
  final _scroll = ScrollController();
  PostComment? _replyingTo;
  bool _sending = false;

  /// The same basket the post composer and the chat use, so a reply can carry
  /// a picture without this screen growing its own upload code.
  late final MediaBasket _media = MediaBasket(ref.read(feedRepositoryProvider))
    ..addListener(_onMedia);

  @override
  void dispose() {
    _box.dispose();
    _focus.dispose();
    _scroll.dispose();
    _media.removeListener(_onMedia);
    _media.dispose();
    super.dispose();
  }

  void _onMedia() {
    if (mounted) setState(() {});
  }

  Future<void> _attach({required bool video}) async {
    final message = await _media.attach(video: video);
    if (message != null && mounted) Toast.show(context, message);
  }

  CommentThreadNotifier get _notifier =>
      ref.read(commentThreadProvider(widget.commentId).notifier);

  void _replyTo(PostComment comment) {
    setState(() => _replyingTo = comment);
    _focus.requestFocus();
  }

  Future<void> _act(CommentAction action, PostComment comment) async {
    switch (action) {
      case CommentAction.openThread:
        if (comment.id != widget.commentId) _open(comment);
      case CommentAction.report:
        await ReportScreen.open(
          context,
          target: ReportTarget.comment,
          targetId: comment.id,
          subject: 'this comment',
        );
      case CommentAction.delete:
        final gone = await _confirmDelete();
        if (!gone) return;
        final error = await _notifier.delete(comment);
        if (!mounted) return;
        if (error != null) {
          Toast.show(context, error);
        } else if (comment.id == widget.commentId) {
          Navigator.pop(context);
        }
      case CommentAction.copy:
        break; // Handled inside the tile, which owns the clipboard.
    }
  }

  Future<bool> _confirmDelete() async =>
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete this comment?'),
          content: const Text('It will be removed from the thread.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        ),
      ) ??
      false;

  void _open(PostComment comment) => Navigator.pushNamed(
        context,
        Routes.comment,
        arguments: comment.id,
      );

  /// Whether there is something to send. A picture on its own is a reply;
  /// an empty box is not, and neither is one whose upload is still running.
  bool get _canSend =>
      (_box.text.trim().isNotEmpty || _media.ready.isNotEmpty) &&
      !_media.isUploading &&
      !_sending;

  Future<void> _send() async {
    final text = _box.text.trim();
    final state = ref.read(commentThreadProvider(widget.commentId));
    final postId = state.postId;
    final parent = _replyingTo ?? state.root;
    if (!_canSend || postId == null || parent == null) return;

    setState(() => _sending = true);
    try {
      final reply = await ref.read(feedRepositoryProvider).addComment(
            postId,
            text,
            parentId: parent.id,
            media: _media.ready,
          );
      _box.clear();
      _media.clear();
      setState(() => _replyingTo = null);
      _notifier.added(reply);
    } catch (error) {
      if (mounted) Toast.show(context, 'Could not post that reply.');
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commentThreadProvider(widget.commentId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: const Text('Reply'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(child: _body(state)),
                  // Upwards here: the comment this page is about is at the
                  // top, and a long argument buries it.
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
            const Hairline(),
            _composer(state),
          ],
        ),
      ),
    );
  }

  Widget _body(CommentThreadState state) {
    if (state.loading && state.root == null) {
      return SkeletonList.comments();
    }
    if (state.error != null && state.root == null) {
      return EmptyState.failed(
        title: 'Could not load this reply',
        detail: state.error,
        onAction: _notifier.load,
      ).scrollable;
    }
    final root = state.root;
    if (root == null) {
      return const EmptyState(
        art: EmptyArt.messages,
        title: 'This reply is gone',
        detail: 'It was deleted, or the post it was on was.',
      ).scrollable;
    }

    // The root goes through the layout with everything else rather than being
    // drawn above it. Rendered separately it had no avatar and no rail, so its
    // text started a whole avatar's width left of every reply under it -- the
    // page read as a paragraph with an unrelated thread beneath.
    final layout = buildThreadLayout(
      [root, ...state.replies],
      expanded: state.expanded,
      // Everything, on the page that exists to show everything. Folding here
      // would mean tapping into a reply and being shown one line of it.
      collapseAfter: 1 << 30,
    );

    return RefreshIndicator(
      onRefresh: _notifier.load,
      child: ListView.builder(
        controller: _scroll,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space16,
          SpacingTokens.space12,
          SpacingTokens.space16,
          SpacingTokens.space24,
        ),
        itemCount: layout.rows.length,
        itemBuilder: (context, index) {
          final row = layout.rows[index];
          final comment = row.comment;
          final isRoot = comment.id == root.id;

          return ThreadItem(
            depth: row.depth,
            ancestorRails: row.ancestorRails,
            hasChildrenBelow: row.hasChildrenBelow,
            isLastChild: row.isLastChild,
            // The first row starts at the list's own top padding; every other
            // one carries its own gap so the rails stay unbroken across it.
            topGap: index == 0 ? 0 : SpacingTokens.space12,
            avatar: CommentAvatar(comment: comment),
            child: CommentTile(
              comment: comment,
              isRoot: isRoot,
              onOpen: isRoot ? null : () => _open(comment),
              onReply: () => _replyTo(comment),
              onLike: () => _like(comment),
              onAction: (action) => _act(action, comment),
            ),
          );
        },
      ),
    );
  }

  Future<void> _like(PostComment comment) async {
    final error = await _notifier.toggleLike(comment);
    if (error != null && mounted) Toast.show(context, error);
  }

  Widget _composer(CommentThreadState state) {
    final scheme = Theme.of(context).colorScheme;
    final to = _replyingTo ?? state.root;

    return Padding(
      padding: EdgeInsets.only(
        left: SpacingTokens.space8,
        right: SpacingTokens.space8,
        top: SpacingTokens.space8,
        bottom: MediaQuery.viewInsetsOf(context).bottom + SpacingTokens.space8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_media.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                left: SpacingTokens.space8,
                bottom: SpacingTokens.space8,
              ),
              child: MediaTray(
                media: _media.items,
                height: 84,
                onRemove: _media.remove,
                onRetry: _media.retry,
                onDescribe: (item) =>
                    _media.describe(item.path, item.alt ?? ''),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                tooltip: 'Add a photo',
                onPressed: _media.hasRoom ? () => _attach(video: false) : null,
                icon: const Icon(Iconsax.gallery_copy, size: 20),
              ),
              IconButton(
                tooltip: 'Add a clip',
                onPressed: _media.hasRoom ? () => _attach(video: true) : null,
                icon: const Icon(Iconsax.video_copy, size: 20),
              ),
              Expanded(
                child: TextField(
                  controller: _box,
                  focusNode: _focus,
                  minLines: 1,
                  maxLines: 4,
                  maxLength: 500,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: to == null
                        ? 'Write a reply'
                        : 'Reply to ${to.author.displayName}',
                    border: InputBorder.none,
                    counterText: '',
                    isDense: true,
                    constraints: const BoxConstraints(),
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Send',
                icon: _sending
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(Iconsax.send_1_copy,
                        size: 20, color: scheme.primary),
                onPressed: _canSend ? _send : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
