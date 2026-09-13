// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/top_edge.dart';
import '../widgets/interest_tabs.dart';
import '../widgets/feed_canvas.dart';
import '../widgets/app_drawer.dart';
import '../routes.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<AppDrawerState> drawerKey;
  final Function(double scrollProgress) onScrollProgress;

  const HomeScreen({
    super.key,
    required this.drawerKey,
    required this.onScrollProgress,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late AnimationController _topEdgeAnimController;
  double _lastScrollOffset = 0.0;
  ScrollDirection _lastDirection = ScrollDirection.idle;

  // Tunable constants
  static const double _liveScrollRangePx = 120.0;

  @override
  void initState() {
    super.initState();

    // Animation for TopEdge collapse (controls size from 0.0 to 1.0)
    // 0.0 = fully visible, 1.0 = fully hidden
    _topEdgeAnimController = AnimationController(
      vsync: this,
      duration: Duration.zero, // NO automatic animation
      value: 0.0, // Start fully visible
    );

    _scrollController.addListener(_handleScrollLive);
  }

  void _handleScrollLive() {
    if (!_scrollController.hasClients) return;

    final offset = _scrollController.offset;
    final direction = _scrollController.position.userScrollDirection;

    // Detect direction change - if direction changes, allow animation to resume
    if (direction != ScrollDirection.idle && direction != _lastDirection) {
      _lastScrollOffset = offset;
      _lastDirection = direction;
    }

    // Only animate when actively scrolling in a direction
    if (direction == ScrollDirection.reverse) {
      // Scrolling DOWN - hide TopEdge
      final delta = offset - _lastScrollOffset;
      if (delta > 0) {
        final newValue =
            (_topEdgeAnimController.value + (delta / _liveScrollRangePx))
                .clamp(0.0, 1.0);
        _topEdgeAnimController.value = newValue;
        _lastScrollOffset = offset;
      }
    } else if (direction == ScrollDirection.forward) {
      // Scrolling UP - show TopEdge
      final delta = _lastScrollOffset - offset;
      if (delta > 0) {
        final newValue =
            (_topEdgeAnimController.value - (delta / _liveScrollRangePx))
                .clamp(0.0, 1.0);
        _topEdgeAnimController.value = newValue;
        _lastScrollOffset = offset;
      }
    }

    // Notify parent for bottom nav animation
    widget.onScrollProgress(_topEdgeAnimController.value);
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScrollLive);
    _scrollController.dispose();
    _topEdgeAnimController.dispose();
    super.dispose();
  }

  /// TopEdge content height, without the status bar.
  static const double _topEdgeContentHeight = 56.0;

  /// The tab strip below it.
  static const double _tabsHeight = 44.0;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    const topEdgeContentHeight = _topEdgeContentHeight;
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        // The feed fills the whole screen and the chrome sits over it.
        //
        // It used to be the second child of a Column, beside a spacer whose
        // height shrank as the top bar hid. That made the feed's scroll
        // viewport resize on every frame of a drag -- measured over a 120px
        // drag, twelve different viewport heights and twelve different
        // maxScrollExtents, one per frame. Two things came of it: the whole
        // visible list re-laid-out every frame, and, worse, the content did
        // not track the finger, because the viewport was growing underneath
        // it as it moved. That is what made the feed feel like hard work
        // rather than merely slow.
        //
        // The padding below is constant for the same reason: it is inside
        // the scrollable, so it costs nothing to keep at the open height.
        // Once the bar has hidden, the reader has scrolled past that space
        // anyway.
        Positioned.fill(
          child: FeedCanvas(
            scrollController: _scrollController,
            topInset: statusBarHeight + topEdgeContentHeight + _tabsHeight,
          ),
        ),

        // Something opaque behind the bar while it fades out. The tab strip
        // and the status bar cover their own bands; this is the one between
        // them, where a half-faded TopEdge would otherwise have the feed
        // showing through it.
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AnimatedBuilder(
            animation: _topEdgeAnimController,
            builder: (context, child) => SizedBox(
              height: statusBarHeight +
                  topEdgeContentHeight * (1.0 - _topEdgeAnimController.value),
              child: ColoredBox(color: scheme.surface),
            ),
          ),
        ),

        // TopEdge - scrolls UNDER status bar
        Positioned(
          top: statusBarHeight,
          left: 0,
          right: 0,
          child: AnimatedBuilder(
            animation: _topEdgeAnimController,
            builder: (context, child) {
              final hideProgress = _topEdgeAnimController.value;
              return Transform.translate(
                offset: Offset(0, -topEdgeContentHeight * hideProgress),
                child: Opacity(
                  opacity: 1.0 - hideProgress,
                  child: child,
                ),
              );
            },
            child: TopEdge(
              onProfileTap: () {
                widget.drawerKey.currentState?.toggleDrawer();
              },
              onLogoTap: _scrollToTop,
              onSearchTap: () => Navigator.pushNamed(context, Routes.search),
              onNotificationTap: () =>
                  Navigator.pushNamed(context, Routes.notifications),
            ),
          ),
        ),

        // Interest Tabs - STOPS at status bar bottom, never crosses into it
        Positioned(
          top: statusBarHeight,
          left: 0,
          right: 0,
          child: AnimatedBuilder(
            animation: _topEdgeAnimController,
            builder: (context, child) {
              final hideProgress = _topEdgeAnimController.value;
              // Tabs move up ONLY as much as TopEdge hides, stopping at status bar
              final maxMove = topEdgeContentHeight * hideProgress;
              return Transform.translate(
                offset: Offset(0, topEdgeContentHeight - maxMove),
                child: child,
              );
            },
            child: InterestTabs(
              scrollController: _scrollController,
            ),
          ),
        ),

        // A soft edge under the tab strip, where posts now pass beneath it.
        // It used to live inside FeedCanvas at its top, which worked when the
        // list began below the chrome; with the list running full height that
        // position is behind the bar and invisible, and a fixed one would come
        // adrift from a strip that moves.
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AnimatedBuilder(
            animation: _topEdgeAnimController,
            builder: (context, child) => Padding(
              padding: EdgeInsets.only(
                top: statusBarHeight +
                    topEdgeContentHeight *
                        (1.0 - _topEdgeAnimController.value) +
                    _tabsHeight,
              ),
              child: child,
            ),
            child: IgnorePointer(
              child: SizedBox(
                height: FeedCanvas.topFadeHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        scheme.surface,
                        scheme.surface.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // STICKY Status Bar Overlay - always on top
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: statusBarHeight,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ],
    );
  }
}
