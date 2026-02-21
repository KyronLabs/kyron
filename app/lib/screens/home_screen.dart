// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/top_edge.dart';
import '../widgets/interest_tabs.dart';
import '../widgets/feed_canvas.dart';
import '../widgets/app_drawer.dart';

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

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
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
        final newValue = (_topEdgeAnimController.value + (delta / _liveScrollRangePx)).clamp(0.0, 1.0);
        _topEdgeAnimController.value = newValue;
        _lastScrollOffset = offset;
      }
    } else if (direction == ScrollDirection.forward) {
      // Scrolling UP - show TopEdge
      final delta = _lastScrollOffset - offset;
      if (delta > 0) {
        final newValue = (_topEdgeAnimController.value - (delta / _liveScrollRangePx)).clamp(0.0, 1.0);
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

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final topEdgeContentHeight = 56.0; // TopEdge content height (without status bar)
    
    return Stack(
      children: [
        // Feed Canvas - extends full screen
        Column(
          children: [
            // Spacer for status bar + TopEdge + InterestTabs
            AnimatedBuilder(
              animation: _topEdgeAnimController,
              builder: (context, child) {
                // TopEdge visible height (decreases as it hides)
                final topEdgeVisible = topEdgeContentHeight * (1.0 - _topEdgeAnimController.value);
                final tabsHeight = 44.0;
                return SizedBox(height: statusBarHeight + topEdgeVisible + tabsHeight);
              },
            ),
            
            // Feed Canvas
            Expanded(
              child: FeedCanvas(
                scrollController: _scrollController,
              ),
            ),
          ],
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
              logoPath: 'lib/assets/logo.svg',
              onProfileTap: () {
                widget.drawerKey.currentState?.toggleDrawer();
              },
              onLogoTap: _scrollToTop,
              onSearchTap: () => debugPrint('Search'),
              onNotificationTap: () =>
                  Navigator.pushNamed(context, '/notifications'),
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