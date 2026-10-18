// lib/screens/main_container.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_messaging/firebase_messaging.dart' show RemoteMessage;

import '../providers/messages_provider.dart';
import '../providers/notifications_provider.dart';
import '../providers/realtime_provider.dart';
import '../l10n/app_localizations.dart';
import '../services/firebase_push.dart';
import '../services/push_tap.dart';
import '../services/share_inbox.dart';
import '../widgets/toast.dart';
import '../widgets/share_into_kyron_sheet.dart';
import '../utils/layout.dart';
import '../widgets/bottom_nav_v4.dart';
import '../widgets/nav_destinations.dart';
import '../widgets/side_rail.dart';
import '../widgets/app_drawer.dart';
import '../widgets/sliding_drawer_content.dart';
import 'home_screen.dart';
import 'explore_screen.dart';
import 'communities_screen.dart';
import 'messages_screen.dart';

class MainContainer extends ConsumerStatefulWidget {
  const MainContainer({super.key});

  @override
  ConsumerState<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends ConsumerState<MainContainer>
    with WidgetsBindingObserver {
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // A share from another app: the one that opened the app is already
    // waiting; one that arrives later is listened for.
    ref.listenManual<SharedContent?>(
      pendingShareProvider,
      (_, content) => _offer(content),
      fireImmediately: true,
    );
    _inFront = FirebasePushTokens.inFront().listen(_shown);
  }

  StreamSubscription<RemoteMessage>? _inFront;

  /// A notification that arrived with the app in front, which the phone hands
  /// over rather than shows. Only the test is shown: anything else has
  /// already reached the screen over the socket.
  void _shown(RemoteMessage message) {
    if (!mounted || message.data['type'] != 'test') return;
    Toast.show(
      context,
      message.notification?.body ??
          AppLocalizations.of(context)
              .ui('ui_push_working', 'Notifications are working.'),
    );
  }

  /// Opens the share sheet for [content], once the frame it arrived in is
  /// drawn, and forgets it so it is offered only once.
  void _offer(SharedContent? content) {
    if (content == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (ref.read(pendingShareProvider) != content) return;
      ref.read(pendingShareProvider.notifier).state = null;
      unawaited(ShareIntoKyronSheet.show(context, content));
    });
  }

  /// Refreshes the bell's count when the app comes back to the foreground.
  ///
  /// Kyron has no push channel, so nothing tells the running app that
  /// somebody liked a post. Coming back to it is the one moment the count is
  /// worth re-asking for; polling on a timer would spend a request a minute
  /// to move a number nobody is looking at.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Online means the app is in front. Not inactive, which is a phone call
    // sliding over it or the notification shade, and over in a moment.
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(realtimeClientProvider).setAway(false);
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        ref.read(realtimeClientProvider).setAway(true);
      case AppLifecycleState.inactive:
        break;
    }
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(unreadNotificationsProvider);
      // A message that arrived while the app was away came as a push, not
      // over the socket, so nothing has moved the count since.
      ref.invalidate(unreadConversationsProvider);
    }
  }

  @override
  void dispose() {
    _inFront?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _navHideProgress.dispose();
    super.dispose();
  }

  /// What waits behind each tab: unread conversations on Messages, so a
  /// message that arrives while the reader is elsewhere is seen without
  /// going to look. Kept live by the socket (realtime_provider.dart), by
  /// reading a conversation, and by coming back to the app.
  static Map<int, int> _badges(WidgetRef ref) => {
        NavDestinations.messages.index:
            ref.watch(unreadConversationsProvider).value ?? 0,
      };

  void _onNavTap(int index) {
    if (index == NavDestinations.composeIndex) return; // Skip FAB
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

  /// The drawer, wrapped round whatever is being shown.
  ///
  /// Kept on both layouts. On a phone it is the whole navigation; in a window
  /// the rail has taken the four destinations and this is what is left --
  /// you, your saved posts, your settings -- which is what the avatar in the
  /// top corner has always opened.
  Widget _withDrawer({required Widget child, required bool gesture}) {
    return AppDrawer(
      key: _drawerKey,
      enableGesture: gesture,
      drawerContent: SlidingDrawerContent(
        onCloseDrawer: () {
          _drawerKey.currentState?.closeDrawer();
        },
        // Communities is one of these tabs, not a route of its own.
        onSelectTab: _onNavTap,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Measured off the window rather than asked of the platform: a Windows
    // window dragged narrow is a phone-shaped space and gets the phone's
    // layout, and a tablet held wide gets the rail. Which operating system
    // this is was never the question.
    //
    // A tapped notification opens over either: whatever it is about, rather
    // than the feed.
    return PushTapOpener(
      child: Layout.hasRail(context) ? _wide() : _tall(),
    );
  }

  /// A window: navigation down the side, nothing across the bottom.
  Widget _wide() {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer(
            builder: (context, ref, _) => SideRail(
              currentIndex: _currentIndex,
              onSelect: _onNavTap,
              badges: _badges(ref),
            ),
          ),
          // The drawer slides over the page and not over the rail, so the
          // rail stays reachable while it is open.
          Expanded(
            child: _withDrawer(
              // No edge swipe: a pointer does not make one, and on a window
              // the gesture only ever fired by accident.
              gesture: false,
              child: _getCurrentPage(),
            ),
          ),
        ],
      ),
    );
  }

  /// A phone: the bar across the bottom, and the drawer on a swipe.
  Widget _tall() {
    return _withDrawer(
      gesture: _currentIndex == 0,
      child: Scaffold(
        extendBody: true, // Allow body to extend behind bottom nav
        body: _getCurrentPage(),
        bottomNavigationBar: ValueListenableBuilder<double>(
          valueListenable: _navHideProgress,
          // The nav itself is built once and passed through, so a scroll frame
          // moves an existing subtree instead of rebuilding one.
          // Only the bar listens for the count: rebuilding this whole
          // screen rebuilds the feed under it.
          child: Consumer(
            builder: (context, ref, _) => BottomNavV4(
              currentIndex: _currentIndex,
              onTap: _onNavTap,
              badges: _badges(ref),
            ),
          ),
          builder: (context, progress, child) => Transform.translate(
            // Slide down by the whole bar: its own height and the inset
            // under it. This was a flat 80, which covers a 16px gesture bar
            // and nothing taller -- with three-button navigation (48px) a
            // 32px strip of the bar stayed on screen after it "hid".
            offset: Offset(
              0,
              (BottomNavV4.height + MediaQuery.paddingOf(context).bottom) *
                  progress,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
