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
import '../utils/format_count.dart';
import '../utils/thread_layout.dart';
import '../widgets/comment_tile.dart';
import '../widgets/empty_state.dart';
import '../widgets/hairline.dart';
import '../widgets/thread.dart';
import '../widgets/toast.dart';

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
  PostComment? _replyingTo;
  bool _sending = false;

  @override
  void dispose() {
    _box.dispose();
    _focus.dispose();
    super.dispose();
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

  Future<void> _send() async {
    final text = _box.text.trim();
    final state = ref.read(commentThreadProvider(widget.commentId));
    final postId = state.postId;
    final parent = _replyingTo ?? state.root;
    if (text.isEmpty || postId == null || parent == null || _sending) return;

    setState(() => _sending = true);
    try {
      final reply = await ref
          .read(feedRepositoryProvider)
          .addComment(postId, text, parentId: parent.id);
      _box.clear();
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
            Expanded(child: _body(state)),
            const Hairline(),
            _composer(state),
          ],
        ),
      ),
    );
  }

  Widget _body(CommentThreadState state) {
    if (state.loading && state.root == null) {
      return const Center(child: CircularProgressIndicator());
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

    final layout = buildThreadLayout(
      state.replies,
      expanded: state.expanded,
      // Everything, on the page that exists to show everything. Folding here
      // would mean tapping into a reply and being shown one line of it.
      collapseAfter: 1 << 30,
    );

    return RefreshIndicator(
      onRefresh: _notifier.load,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space16,
          SpacingTokens.space12,
          SpacingTokens.space16,
          SpacingTokens.space24,
        ),
        itemCount: layout.rows.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            // The comment the page is about, drawn as a row with no
            // connectors: nothing above it to connect to.
            return CommentTile(
              comment: root,
              isRoot: true,
              onReply: () => _replyTo(root),
              onLike: () => _like(root),
              onAction: (action) => _act(action, root),
            );
          }
          if (index == 1) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SpacingTokens.space8,
              ),
              child: Row(
                children: [
                  Text(
                    root.replies == 0
                        ? 'No replies yet'
                        : root.replies == 1
                            ? '1 reply'
                            : '${formatCount(root.replies)} replies',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(width: SpacingTokens.space12),
                  const Expanded(child: Hairline()),
                ],
              ),
            );
          }

          final row = layout.rows[index - 2];
          return ThreadItem(
            depth: row.depth,
            ancestorRails: row.ancestorRails,
            hasChildrenBelow: row.hasChildrenBelow,
            isLastChild: row.isLastChild,
            topGap: SpacingTokens.space12,
            avatar: CommentAvatar(comment: row.comment),
            child: CommentTile(
              comment: row.comment,
              onOpen: () => _open(row.comment),
              onReply: () => _replyTo(row.comment),
              onLike: () => _like(row.comment),
              onAction: (action) => _act(action, row.comment),
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
        left: SpacingTokens.space16,
        right: SpacingTokens.space8,
        top: SpacingTokens.space8,
        bottom: MediaQuery.viewInsetsOf(context).bottom + SpacingTokens.space8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
                : Icon(Iconsax.send_1_copy, size: 20, color: scheme.primary),
            onPressed: _box.text.trim().isEmpty || _sending ? null : _send,
          ),
        ],
      ),
    );
  }
}
