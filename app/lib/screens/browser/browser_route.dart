// lib/screens/browser/browser_route.dart
import 'package:flutter/material.dart';

import 'browser_engine.dart';
import 'browser_session.dart';
import 'browser_sheet.dart';

/// How the browser gets on screen, and how a second link finds the first.
///
/// There is one browser at a time, so this holds one reference to it. A link
/// tapped while it is up becomes a tab in it; a link tapped with nothing open
/// pushes it.
abstract final class BrowserRoute {
  /// The session currently on screen, if any.
  static BrowserSession? _live;

  /// What builds a tab's engine.
  ///
  /// A test swaps this for something that does not need a platform web view
  /// behind it. Nothing else has any business changing it.
  @visibleForTesting
  static EngineFactory engineFactory = WebViewEngine.new;

  @visibleForTesting
  static BrowserSession? get live => _live;

  /// Drops the reference to a browser that has gone.
  ///
  /// A sheet clears only its own session. Clearing whatever happens to be
  /// there would, the day a second browser can exist, have the first one's
  /// closing silently orphan the second: links would push a third sheet on
  /// top of a live one.
  static void _track(BrowserSession session, {required bool open}) {
    if (open) {
      _live = session;
    } else if (identical(_live, session)) {
      _live = null;
    }
  }

  /// Forgets the live browser without one having closed.
  ///
  /// Only for tests: `testWidgets` leaves the last tree standing after a test
  /// ends, so the sheet's dispose has not run by the time the next one starts.
  @visibleForTesting
  static void forget() => _live = null;

  /// Shows [url]: as a new tab when the browser is already up, otherwise as
  /// the browser.
  static void open(BuildContext context, Uri url, {String? title}) {
    final live = _live;
    if (live != null) {
      live.open(url, title: title);
      return;
    }
    // The root navigator, so the browser covers the bottom bar rather than
    // opening inside whichever tab the reader happened to be on.
    Navigator.of(context, rootNavigator: true).push(route(url, title: title));
  }

  static Route<void> route(Uri url, {String? title}) {
    return _BrowserRoute(url: url, title: title);
  }
}

/// A route that does not paint over what is behind it.
///
/// The sheet stops short of the top of the screen and the app shows through,
/// dimmed. That gap is the point: it is what says the page is a guest rather
/// than a screen of Kyron's.
class _BrowserRoute extends PageRouteBuilder<void> {
  _BrowserRoute({required Uri url, String? title})
      : super(
          opaque: false,
          barrierColor: Colors.black.withValues(alpha: 0.45),
          barrierDismissible: false,
          transitionDuration: const Duration(milliseconds: 320),
          reverseTransitionDuration: const Duration(milliseconds: 240),
          pageBuilder: (context, animation, secondary) => BrowserSheet(
            url: url,
            title: title,
            engineFactory: BrowserRoute.engineFactory,
            onLifecycle: BrowserRoute._track,
          ),
          transitionsBuilder: (context, animation, secondary, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                  reverseCurve: Curves.easeInCubic,
                ),
              ),
              child: child,
            );
          },
        );
}
