// lib/screens/main_container.dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/bottom_nav_v4.dart';
import '../widgets/app_drawer.dart';
import '../widgets/sliding_drawer_content.dart';
import 'home_screen.dart';
import 'explore_screen.dart';
import 'communities_screen.dart';
import 'messages_screen.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _currentIndex = 0;
  final GlobalKey<AppDrawerState> _drawerKey = GlobalKey<AppDrawerState>();

  /// 0.0 = nav visible, 1.0 = hidden.
  ///
  /// A notifier rather than State, because this changes on every scroll frame.
  /// It used to be a field updated with setState, which rebuilt this whole
  /// widget sixty times a second while scrolling -- the drawer, its content,
  /// the Scaffold, and _getCurrentPage(), which constructs a fresh HomeScreen
  /// and with it the entire feed. The nav slides four pixels and the entire
  /// screen was rebuilt to do it. Only the Transform below listens now.
  final ValueNotifier<double> _navHideProgress = ValueNotifier<double>(0.0);

  void _handleScrollProgress(double progress) {
    _navHideProgress.value = progress;
  }

  @override
  void dispose() {
    _navHideProgress.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == 2) return; // Skip FAB
    setState(() => _currentIndex = index);
  }

  Widget _getCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return HomeScreen(
          drawerKey: _drawerKey,
          onScrollProgress: _handleScrollProgress,
        );
      case 1:
        return ExploreScreen(
          drawerKey: _drawerKey,
          onScrollProgress: _handleScrollProgress,
        );
      case 3:
        return CommunitiesScreen(
          drawerKey: _drawerKey,
          onScrollProgress: _handleScrollProgress,
        );
      case 4:
        return MessagesScreen(
          drawerKey: _drawerKey,
          onScrollProgress: _handleScrollProgress,
        );
      default:
        return HomeScreen(
          drawerKey: _drawerKey,
          onScrollProgress: _handleScrollProgress,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppDrawer(
      key: _drawerKey,
      enableGesture: _currentIndex == 0,
      drawerContent: SlidingDrawerContent(
        onCloseDrawer: () {
          _drawerKey.currentState?.closeDrawer();
        },
      ),
      child: Scaffold(
        extendBody: true, // Allow body to extend behind bottom nav
        body: _getCurrentPage(),
        bottomNavigationBar: ValueListenableBuilder<double>(
          valueListenable: _navHideProgress,
          // The nav itself is built once and passed through, so a scroll frame
          // moves an existing subtree instead of rebuilding one.
          child: BottomNavV4(
            currentIndex: _currentIndex,
            onTap: _onNavTap,
          ),
          builder: (context, progress, child) => Transform.translate(
            // Slide down by the nav height plus safe area.
            offset: Offset(0, 80 * progress),
            child: child,
          ),
        ),
      ),
    );
  }
}
