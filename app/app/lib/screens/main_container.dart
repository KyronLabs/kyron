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
  
  double _navHideProgress = 0.0; // 0.0 = visible, 1.0 = hidden

  void _handleScrollProgress(double progress) {
    // Update nav hide progress in real-time
    setState(() {
      _navHideProgress = progress;
    });
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
        bottomNavigationBar: Transform.translate(
          offset: Offset(0, 80 * _navHideProgress), // Slide down 80px (nav height + safe area)
          child: BottomNavV4(
            currentIndex: _currentIndex,
            onTap: _onNavTap,
          ),
        ),
      ),
    );
  }
}