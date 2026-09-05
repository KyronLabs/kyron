// lib/utils/route_watch.dart
import 'package:flutter/material.dart';

/// Registered on the app's navigator so a screen can be told when another one
/// covers it.
///
/// Pushing a route neither rebuilds nor disposes the screen underneath, so a
/// screen that is doing something -- playing a clip, say -- carries on doing it
/// out of sight. Nothing else in Flutter reports that.
final RouteObserver<PageRoute<dynamic>> routeObserver =
    RouteObserver<PageRoute<dynamic>>();

/// Tells a [State] when its screen is covered by another, and uncovered again.
///
/// Only full screens count. A sheet or a dialog over a clip is still a clip
/// being watched, and those are not [PageRoute]s.
mixin RouteCoverAware<T extends StatefulWidget> on State<T>
    implements RouteAware {
  PageRoute<dynamic>? _route;

  /// Another screen has been pushed over this one.
  void onCovered();

  /// That screen has gone, and this one is on top again.
  void onUncovered();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    final page = route is PageRoute<dynamic> ? route : null;
    if (identical(page, _route)) return;
    if (_route != null) routeObserver.unsubscribe(this);
    _route = page;
    if (page != null) routeObserver.subscribe(this, page);
  }

  @override
  void dispose() {
    if (_route != null) routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPushNext() => onCovered();

  @override
  void didPopNext() => onUncovered();

  @override
  void didPush() {}

  @override
  void didPop() {}
}
