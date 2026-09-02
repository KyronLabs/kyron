import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/feed_provider.dart';
import 'post_card.dart';
import 'media_tile_grid.dart';

/// A scrolling list of posts, with every state it can be in.
///
/// The feed, a profile, your saved posts and your liked posts are the same
/// screen pointed at different endpoints. Written once, so "could not load"
/// and "nothing here yet" look and behave the same wherever you meet them.
class PostListView extends ConsumerStatefulWidget {
  final PostListSource source;

  /// Shown, with [emptyDetail], once a load finishes and finds nothing.
  final String emptyTitle;
  final String emptyDetail;
  final IconData emptyIcon;
  final String errorTitle;

  /// Supplied by a parent that owns the scrolling, as the home screen does to
  /// drive its collapsing top bar.
  final ScrollController? scrollController;

  /// Slivers to render above the posts -- a profile header, say.
  final List<Widget> headerSlivers;

  /// Lay the posts out as a staggered wall of attachments rather than a
  /// column of cards. What the feed's Videos tab uses.
  final bool asTiles;

  /// A hashtag to pick out in every post's body, without its leading #.
  final String? highlightTag;

  final EdgeInsets padding;

  const PostListView({
    super.key,
    required this.source,
    required this.emptyTitle,
    required this.emptyDetail,
    this.emptyIcon = Icons.forum_outlined,
    this.errorTitle = 'Could not load these posts',
    this.scrollController,
    this.headerSlivers = const [],
    this.padding = EdgeInsets.zero,
    this.asTiles = false,
    this.highlightTag,
  });

  @override
  ConsumerState<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends ConsumerState<PostListView> {
  /// How close to the end before the next page is requested.
  static const double _loadMoreThreshold = 600;

  ScrollController? _owned;
  ScrollController get _controller =>
      widget.scrollController ?? (_owned ??= ScrollController());

  @override
  void initState() {
    super.initState();
    _controller.addListener(_maybeLoadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_maybeLoadMore);
    _owned?.dispose();
    super.dispose();
  }

  void _maybeLoadMore() {
    if (!_controller.hasClients) return;
    final position = _controller.position;
    if (position.maxScrollExtent - position.pixels > _loadMoreThreshold) return;
    // The notifier ignores this while a page is in flight or once the end is
    // reached, so firing it on every frame near the bottom is harmless.
    _notifier.loadMore();
  }

  PostListNotifier get _notifier =>
      ref.read(postListProvider(widget.source).notifier);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postListProvider(widget.source));

    return RefreshIndicator(
      onRefresh: _notifier.refresh,
      child: CustomScrollView(
        controller: _controller,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          ...widget.headerSlivers,
          SliverPadding(
            padding: widget.padding,
            sliver: _content(state),
          ),
        ],
      ),
    );
  }

  Widget _content(FeedState state) {
    if (state.isLoadingFirstPage && state.posts.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (state.error != null && state.posts.isEmpty) {
      return _message(
        icon: Icons.cloud_off_outlined,
        title: widget.errorTitle,
        detail: state.error!,
        action: 'Try again',
      );
    }
    if (state.isEmpty) {
      return _message(
        icon: widget.emptyIcon,
        title: widget.emptyTitle,
        detail: widget.emptyDetail,
        action: 'Refresh',
      );
    }

    if (widget.asTiles) {
      return MediaTileGrid(posts: state.posts, videosOnly: true);
    }

    // Builder, not a list of everything: the feed this replaces constructed
    // every post up front whether or not any were on screen.
    return SliverList.builder(
      // One extra slot for the paging spinner at the tail.
      itemCount: state.posts.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= state.posts.length) {
          return const Padding(
            padding: EdgeInsets.all(SpacingTokens.space16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return PostCard(
          post: state.posts[index],
          source: widget.source,
          highlightTag: widget.highlightTag,
        );
      },
    );
  }

  /// Empty and error share a shape: something to read, and something to do.
  Widget _message({
    required IconData icon,
    required String title,
    required String detail,
    required String action,
  }) {
    final scheme = Theme.of(context).colorScheme;

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space32,
          vertical: SpacingTokens.space40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 48, color: scheme.onSurface.withValues(alpha: .35)),
            const SizedBox(height: SpacingTokens.space16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: SpacingTokens.space8),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurface.withValues(alpha: .7),
                  ),
            ),
            const SizedBox(height: SpacingTokens.space20),
            TextButton(onPressed: _notifier.refresh, child: Text(action)),
          ],
        ),
      ),
    );
  }
}
