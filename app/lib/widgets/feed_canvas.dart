// lib/widgets/feed_canvas.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import 'empty_state.dart';
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

  /// How far down the screen the first post starts, in logical pixels.
  ///
  /// The chrome overlays this list rather than pushing it down, so the space
  /// under it is padding *inside* the scrollable. That is the whole reason it
  /// arrives as a number rather than as a widget above: a sibling whose height
  /// changed with the collapse resized this list's viewport on every frame of
  /// a drag, and the content stopped tracking the finger.
  final double topInset;

  const FeedCanvas({
    super.key,
    this.scrollController,
    this.topInset = 0,
  });

  /// Height of the fade under the tab strip, in logical pixels.
  ///
  /// Drawn by whoever owns the chrome, since only they know where the strip
  /// has currently slid to.
  static const double topFadeHeight = 16;

  static String _emptyTitle(String tab) => switch (tab) {
        'Following' => 'Nothing from the people you follow',
        'Videos' => 'No videos yet',
        _ => 'Nothing here yet',
      };

  static EmptyArt _emptyArt(String tab) => switch (tab) {
        'Following' => EmptyArt.people,
        'Videos' => EmptyArt.videos,
        'For You' => EmptyArt.posts,
        _ => EmptyArt.tag,
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

    return PostListView(
      // Whatever the top bar's selected tab reads. It was pinned to the
      // everyone-newest-first feed, so Following and Videos recoloured a
      // pill and showed the same posts.
      source: feedSourceForTab(tab),
      // Videos are a wall of tiles: a column of full-width players is
      // unreadable, and the point of the tab is seeing what is there.
      asTiles: tab == 'Videos',
      scrollController: scrollController,
      errorTitle: 'Could not load your feed',
      emptyArt: _emptyArt(tab),
      emptyTitle: _emptyTitle(tab),
      emptyDetail: _emptyDetail(tab),
      padding: EdgeInsets.only(
        top: topInset + SpacingTokens.space8,
        bottom: MediaQuery.of(context).padding.bottom + 80,
      ),
    );
  }
}
