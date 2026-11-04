// lib/widgets/saved_comments_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/gift.dart' show withGift;
import '../models/post_comment.dart';
import '../providers/feed_provider.dart' show feedRepositoryProvider;
import '../repositories/moderation_repository.dart' show ReportTarget;
import '../routes.dart';
import '../screens/report_screen.dart';
import '../utils/api_error_message.dart';
import 'comment_tile.dart';
import 'empty_state.dart';
import 'gift_sheet.dart';
import 'hairline.dart';
import 'skeleton.dart';
import 'thread.dart';
import 'toast.dart';

/// The comments the reader saved, newest save first.
///
/// Each row is the comment as a thread draws it, under one quiet line saying
/// whose post it answers -- a reply lifted out of its thread is otherwise a
/// sentence with no idea what it was about. Tapping it opens its own page,
/// with the conversation around it.
///
/// Held here rather than in a provider: nothing else reads this list, and it
/// is thrown away with the tab.
class SavedCommentsList extends ConsumerStatefulWidget {
  const SavedCommentsList({super.key});

  @override
  ConsumerState<SavedCommentsList> createState() => _SavedCommentsListState();
}

class _SavedCommentsListState extends ConsumerState<SavedCommentsList> {
  final _items = <PostComment>[];
  String? _cursor;
  bool _loading = true;
  bool _more = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load({bool next = false}) async {
    final repo = ref.read(feedRepositoryProvider);
    setState(() {
      _loading = true;
      if (!next) _error = null;
    });
    try {
      final page = await repo.savedComments(cursor: next ? _cursor : null);
      if (!mounted) return;
      setState(() {
        if (!next) _items.clear();
        _items.addAll(page.items);
        _cursor = page.nextCursor;
        _more = page.nextCursor != null;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = describeApiError(e, sessionIsLive: true);
      });
    }
  }

  void _replace(PostComment updated) {
    final at = _items.indexWhere((c) => c.id == updated.id);
    if (at >= 0) setState(() => _items[at] = updated);
  }

  Future<void> _like(PostComment comment) async {
    final wanted = !comment.liked;
    _replace(comment.withLike(wanted));
    try {
      final likes = await ref
          .read(feedRepositoryProvider)
          .setCommentLike(comment.id, wanted);
      _replace(comment.withLike(wanted, likes: likes));
    } catch (e) {
      _replace(comment);
      if (mounted) {
        Toast.show(context, describeApiError(e, sessionIsLive: true));
      }
    }
  }

  /// Unsaving takes it off this list at once -- that is what unsaving here
  /// means -- and puts it back where it was if the server refuses.
  Future<void> _unsave(PostComment comment) async {
    final at = _items.indexWhere((c) => c.id == comment.id);
    if (at < 0) return;
    setState(() => _items.removeAt(at));
    try {
      await ref.read(feedRepositoryProvider).setCommentSaved(comment.id, false);
    } catch (e) {
      if (!mounted) return;
      setState(() => _items.insert(at.clamp(0, _items.length), comment));
      Toast.show(context, describeApiError(e, sessionIsLive: true));
    }
  }

  Future<void> _act(CommentAction action, PostComment comment) async {
    switch (action) {
      case CommentAction.openThread:
        await Navigator.pushNamed(
          context,
          Routes.comment,
          arguments: comment.id,
        );
      case CommentAction.report:
        await ReportScreen.open(
          context,
          target: ReportTarget.comment,
          targetId: comment.id,
          subject: 'this comment',
        );
      case CommentAction.delete:
        try {
          await ref.read(feedRepositoryProvider).deleteComment(comment.id);
          if (!mounted) return;
          setState(() => _items.removeWhere((c) => c.id == comment.id));
        } catch (e) {
          if (mounted) {
            Toast.show(context, describeApiError(e, sessionIsLive: true));
          }
        }
      case CommentAction.copy:
        break; // The tile owns the clipboard.
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    // In a scroll view that does not scroll: three skeleton posts are taller
    // than a short phone's tab, and in a bare column they overflowed it.
    if (_loading && _items.isEmpty) {
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SkeletonList.posts(count: 3),
      );
    }
    if (_error != null && _items.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          child: EmptyState.failed(
            title: l10n.ui(
              'ui_could_not_load_saved_comments',
              'Could not load your saved comments',
            ),
            detail: _error,
            onAction: _load,
          ),
        ),
      );
    }
    if (_items.isEmpty) {
      return RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            EmptyState(
              art: EmptyArt.saved,
              title: l10n.ui('ui_no_saved_comments', 'No saved comments'),
              detail: l10n.ui(
                'ui_no_saved_comments_detail',
                'Tap the archive icon under a comment to keep it here. Only '
                    'you can see what you save.',
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: SpacingTokens.space40),
        itemCount: _items.length + (_more ? 1 : 0),
        // Solid: each saved comment is a thing of its own, not part of the
        // one above it.
        separatorBuilder: (_, __) => const Hairline(),
        itemBuilder: (context, index) {
          if (index >= _items.length) {
            if (!_loading) _load(next: true);
            return const Padding(
              padding: EdgeInsets.all(SpacingTokens.space16),
              child: Center(
                child: SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 1.6),
                ),
              ),
            );
          }
          final comment = _items[index];
          return _SavedRow(
            comment: comment,
            onLike: () => _like(comment),
            onUnsave: () => _unsave(comment),
            onAction: (action) => _act(action, comment),
            onGift: comment.mine
                ? null
                : (heart) => GiftSheet.openFor(
                      heart,
                      GiftTarget.comment(comment.id),
                      onSent: (sent) {
                        final now = _items.firstWhere(
                          (c) => c.id == comment.id,
                          orElse: () => comment,
                        );
                        _replace(
                          now.copyWith(
                            gifts: sent.gifts,
                            topGifts: withGift(now.topGifts, sent.type),
                          ),
                        );
                      },
                    ),
          );
        },
      ),
    );
  }
}

class _SavedRow extends StatelessWidget {
  final PostComment comment;
  final VoidCallback onLike;
  final VoidCallback onUnsave;
  final void Function(CommentAction) onAction;
  final void Function(BuildContext heart)? onGift;

  const _SavedRow({
    required this.comment,
    required this.onLike,
    required this.onUnsave,
    required this.onAction,
    this.onGift,
  });

  void _open(BuildContext context) =>
      Navigator.pushNamed(context, Routes.comment, arguments: comment.id);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final to = comment.onPostBy;
    final whose = to == null ? null : (to.handle ?? to.displayName);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space16,
        SpacingTokens.space12,
        SpacingTokens.space16,
        SpacingTokens.space4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (whose != null)
            Padding(
              // In the text's column, past the avatar, so it reads as part
              // of the comment rather than a heading over the list.
              padding: const EdgeInsets.only(
                left: ThreadGeometry.avatar + ThreadGeometry.gutter,
                bottom: SpacingTokens.space4,
              ),
              child: Text(
                l10n
                    .ui('ui_replying_to', r'Replying to $name')
                    .replaceAll(r'$name', whose),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize1,
                  color: scheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ),
          ThreadItem(
            depth: 0,
            ancestorRails: const [],
            hasChildrenBelow: false,
            isLastChild: true,
            avatar: CommentAvatar(comment: comment),
            child: CommentTile(
              comment: comment,
              onOpen: () => _open(context),
              onReply: () => _open(context),
              onLike: onLike,
              onSave: onUnsave,
              onGift: onGift,
              onAction: onAction,
            ),
          ),
        ],
      ),
    );
  }
}
