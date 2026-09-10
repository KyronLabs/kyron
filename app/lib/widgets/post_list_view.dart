import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/feed_provider.dart';
import '../routes.dart';
import '../screens/video_feed_screen.dart';
import 'post_card.dart';
import 'empty_state.dart';
import 'media_tile_grid.dart';
import 'skeleton.dart';
import '../utils/layout.dart';

/// A scrolling list of posts, with every state it can be in.
///
/// The feed, a profile, your saved posts and your liked posts are the same
/// screen pointed at different endpoints. Written once, so "could not load"
/// and "nothing here yet" look and behave the same wherever you meet them.
class PostListView extends ConsumerStatefulWidget {
  final PostListSource source;

  /// Shown, with [emptyDetail] and [emptyArt], once a load finishes and
  /// finds nothing.
  final String emptyTitle;
  final String emptyDetail;
  final EmptyArt emptyArt;
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

  /// How much of this list's own box is covered by something opaque above it.
  ///
  /// The home feed runs full height with its top bar laid over it, so the
  /// first [topInset] pixels of this box are behind that bar. Two things have
  /// to know: the padding, so the first post starts below it, and the refresh
  /// indicator, which otherwise drops its spinner at the top of the box --
  /// which is to say behind the bar, where pulling to refresh looks like
  /// nothing happening at all. It is one number for both so they cannot drift
  /// apart, which is how the spinner got lost in the first place.
  final double topInset;

  const PostListView({
    super.key,
    required this.source,
    required this.emptyTitle,
    required this.emptyDetail,
    this.emptyArt = EmptyArt.posts,
    this.errorTitle = 'Could not load these posts',
    this.scrollController,
    this.headerSlivers = const [],
    this.padding = EdgeInsets.zero,
    this.topInset = 0,
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

  /// Pulls the view back inside the content when the content gets shorter.
  ///
  /// Hiding, muting or blocking drops a post out of the list. Doing that near
  /// the bottom leaves the position past the new end, and the reader is left
  /// looking at blank space below it.
  void _clampScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_controller.hasClients) return;
      final position = _controller.position;
      // Only while nothing is moving. Being past the end is the normal state
      // during an overscroll and for every frame of a fling that runs off it,
      // and jumping the position there stops the gesture dead -- which is what
      // turned a flick into something that had to be shoved.
      if (position.isScrollingNotifier.value) return;
      if (position.pixels > position.maxScrollExtent) {
        _controller.jumpTo(position.maxScrollExtent);
      }
    });
  }

  /// The widest a grid of tiles gets. Higher than a reading column because
  /// a picture is not a sentence: room means more of them per row rather
  /// than a longer line to track back along.
  static const double _tileWidth = 1100;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postListProvider(widget.source));
    _clampScroll();

    // A column of posts as wide as a maximised window is harder to read, not
    // easier: the eye loses the start of the next line coming back from the
    // end of the last. So the list keeps its measure and the extra width
    // becomes margin. Tiles are the exception -- a grid of pictures is better
    // for having room -- so they get a wider ceiling rather than this one.
    final width = MediaQuery.sizeOf(context).width;
    final measure = widget.asTiles ? _tileWidth : Layout.readingWidth;
    final gutter = Layout.gutter(width, measure);

    return RefreshIndicator(
      // Measured: with a 124px bar over the list and no offset, the spinner
      // settles at y=84 -- inside the bar, invisible. This puts it below.
      edgeOffset: widget.topInset,
      onRefresh: _notifier.refresh,
      child: CustomScrollView(
        controller: _controller,
        // The platform's own, through AlwaysScrollable so pulling to refresh
        // still works on a list too short to scroll. Bouncing was iOS physics
        // on an Android build: a flick carried further than the finger and
        // came back, which reads as the list arguing with you.
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          ...widget.headerSlivers,
          SliverPadding(
            // The gutter is added to whatever the screen already asked for,
            // so a screen with its own margins keeps them.
            padding: widget.padding.copyWith(
              top: widget.padding.top + widget.topInset,
              left: widget.padding.left + gutter,
              right: widget.padding.right + gutter,
            ),
            sliver: _content(state),
          ),
        ],
      ),
    );
  }

  Widget _content(FeedState state) {
    if (state.isLoadingFirstPage && state.posts.isEmpty) {
      // The shape of what is coming, not a spinner in the middle of
      // nothing: the page fills in rather than rearranging itself when
      // it lands.
      return SliverToBoxAdapter(child: SkeletonList.posts());
    }
    if (state.error != null && state.posts.isEmpty) {
      return EmptyState.failed(
        title: widget.errorTitle,
        detail: state.error!,
        onAction: _notifier.refresh,
      ).sliver;
    }
    if (state.isEmpty) {
      return EmptyState(
        art: widget.emptyArt,
        title: widget.emptyTitle,
        detail: widget.emptyDetail,
        action: 'Refresh',
        onAction: _notifier.refresh,
      ).sliver;
    }

    if (widget.asTiles) {
      return MediaTileGrid(
        posts: state.posts,
        videosOnly: true,
        onOpen: (post) => Navigator.pushNamed(
          context,
          Routes.videoFeed,
          arguments: VideoFeedArgs(source: widget.source, postId: post.id),
        ),
      );
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
        final post = state.posts[index];
        return PostCard(
          // Keyed by the post, so a scrolled-away card's element is reused
          // for the same post rather than for whichever one lands in that
          // slot -- which handed a video's player to a different clip.
          key: ValueKey(post.id),
          post: post,
          source: widget.source,
          highlightTag: widget.highlightTag,
        );
      },
    );
  }
}
