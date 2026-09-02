// lib/widgets/feed_canvas.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import 'interest_tabs.dart';
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

  static String _emptyTitle(String tab) => switch (tab) {
        'Following' => 'Nothing from the people you follow',
        'Videos' => 'No videos yet',
        _ => 'Nothing here yet',
      };

  static String _emptyDetail(String tab) => switch (tab) {
        'Following' =>
          'Follow a few accounts and their posts will show up here.',
        'Videos' => 'Posts carrying a clip will show up here.',
        'For You' => 'Posts will show up here as people write them.',
        _ => 'Nothing has been posted under #$tab yet.',
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(selectedFeedTabProvider);

    return Stack(
      children: [
        PostListView(
          // Whatever the top bar's selected tab reads. It was pinned to the
          // everyone-newest-first feed, so Following and Videos recoloured a
          // pill and showed the same posts.
          source: feedSourceForTab(tab),
          // Videos are a wall of tiles: a column of full-width players is
          // unreadable, and the point of the tab is seeing what is there.
          asTiles: tab == 'Videos',
          scrollController: scrollController,
          errorTitle: 'Could not load your feed',
          emptyTitle: _emptyTitle(tab),
          emptyDetail: _emptyDetail(tab),
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
