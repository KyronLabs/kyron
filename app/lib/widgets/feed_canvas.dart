// lib/widgets/feed_canvas.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/feed_post.dart';
import '../providers/feed_provider.dart';

/// The home feed.
///
/// This used to render twenty hard-coded cards reading "This is a sample post
/// #n". There was no other state: an empty feed, a failed request and a
/// working feed all looked the same, and the placeholder was convincing enough
/// that a broken API looked like a working one.
class FeedCanvas extends ConsumerStatefulWidget {
  final ScrollController? scrollController;

  const FeedCanvas({super.key, this.scrollController});

  @override
  ConsumerState<FeedCanvas> createState() => _FeedCanvasState();
}

class _FeedCanvasState extends ConsumerState<FeedCanvas> {
  /// Height of the fade under the tab strip, in logical pixels.
  static const double _topFadeHeight = 16;

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
    ref.read(feedProvider.notifier).loadMore();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(feedProvider);

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => ref.read(feedProvider.notifier).refresh(),
          child: _body(context, state),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: _topFadeHeight,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).scaffoldBackgroundColor,
                    Theme.of(context)
                        .scaffoldBackgroundColor
                        .withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _body(BuildContext context, FeedState state) {
    if (state.isLoadingFirstPage && state.posts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.error != null && state.posts.isEmpty) {
      return _message(
        context,
        icon: Icons.cloud_off_outlined,
        title: 'Could not load your feed',
        detail: state.error!,
        action: 'Try again',
      );
    }
    if (state.isEmpty) {
      return _message(
        context,
        icon: Icons.forum_outlined,
        title: 'Nothing here yet',
        detail: 'Posts from people you follow will show up here.',
        action: 'Refresh',
      );
    }
    return _list(state);
  }

  Widget _list(FeedState state) {
    // Builder, not a Column of everything: the list used to construct every
    // post up front whether or not any were on screen.
    return ListView.builder(
      controller: _controller,
      padding: EdgeInsets.only(
        top: SpacingTokens.space8,
        bottom: MediaQuery.of(context).padding.bottom + 80,
      ),
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      // One extra slot for the paging spinner at the tail.
      itemCount: state.posts.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= state.posts.length) {
          return const Padding(
            padding: EdgeInsets.all(SpacingTokens.space16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return _PostCard(post: state.posts[index]);
      },
    );
  }

  /// Empty and error share a shape: something to read, and something to do.
  Widget _message(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String detail,
    required String action,
  }) {
    final scheme = Theme.of(context).colorScheme;
    // Scrollable so pull-to-refresh still works with nothing on screen.
    return ListView(
      controller: _controller,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.18),
        Icon(icon, size: 48, color: scheme.onSurface.withValues(alpha: .35)),
        const SizedBox(height: SpacingTokens.space16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: SpacingTokens.space8),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingTokens.space32,
          ),
          child: Text(
            detail,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface.withValues(alpha: .7),
                ),
          ),
        ),
        const SizedBox(height: SpacingTokens.space20),
        Center(
          child: TextButton(
            onPressed: () => ref.read(feedProvider.notifier).refresh(),
            child: Text(action),
          ),
        ),
      ],
    );
  }
}

class _PostCard extends StatelessWidget {
  final FeedPost post;

  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final handle = post.author.handle;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space16,
        vertical: SpacingTokens.space8,
      ),
      padding: const EdgeInsets.all(SpacingTokens.space16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: scheme.primary.withValues(alpha: 0.2),
                foregroundImage: post.author.avatarUrl == null
                    ? null
                    : NetworkImage(post.author.avatarUrl!),
                child: Icon(Icons.person, color: scheme.primary, size: 20),
              ),
              const SizedBox(width: SpacingTokens.space12),
              Expanded(
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
                    // Only when the account actually has a handle. The old
                    // feed printed "@user" for everyone.
                    if (handle != null)
                      Text(
                        handle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: scheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                  ],
                ),
              ),
              Text(
                _age(post.createdAt),
                style: TextStyle(
                  fontSize: 13,
                  color: scheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: SpacingTokens.space12),
          Text(
            post.content,
            style: const TextStyle(fontSize: 15, height: 1.4),
          ),
        ],
      ),
    );
  }

  /// Compact relative age. Deliberately coarse: a feed does not need seconds,
  /// and a rebuild per second to keep them honest is not worth it.
  static String _age(DateTime at) {
    final d = DateTime.now().difference(at);
    if (d.inMinutes < 1) return 'now';
    if (d.inHours < 1) return '${d.inMinutes}m';
    if (d.inDays < 1) return '${d.inHours}h';
    if (d.inDays < 7) return '${d.inDays}d';
    return '${(d.inDays / 7).floor()}w';
  }
}
