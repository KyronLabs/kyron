// lib/widgets/feed_canvas.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/feed_provider.dart';
import 'post_list_view.dart';

/// The home feed.
///
/// This used to render twenty hard-coded cards reading "This is a sample post
/// #n". There was no other state: an empty feed, a failed request and a
/// working feed all looked the same, and the placeholder was convincing enough
/// that a broken API looked like a working one.
class FeedCanvas extends ConsumerWidget {
  final ScrollController? scrollController;

  const FeedCanvas({super.key, this.scrollController});

  /// Height of the fade under the tab strip, in logical pixels.
  static const double _topFadeHeight = 16;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        PostListView(
          source: PostListSource.recent,
          scrollController: scrollController,
          errorTitle: 'Could not load your feed',
          emptyTitle: 'Nothing here yet',
          emptyDetail: 'Posts from people you follow will show up here.',
          padding: EdgeInsets.only(
            top: SpacingTokens.space8,
            bottom: MediaQuery.of(context).padding.bottom + 80,
          ),
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
}
