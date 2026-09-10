// lib/screens/browser/browser_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:share_plus/share_plus.dart';

import '../../services/app_browser.dart';
import '../../widgets/toast.dart';
import 'browser_chrome.dart';
import 'browser_engine.dart';
import 'browser_palette.dart';
import 'browser_session.dart';
import 'browser_sheets.dart';
import 'browser_tab.dart';

/// Kyron's browser.
///
/// A card lifted over the app rather than a screen pushed on top of it: the
/// feed stays visible along the top edge, dimmed, and the page sits inside a
/// rounded frame with somebody else's address across it. That framing is the
/// whole argument. Links used to be handed to Chrome so a stranger's page
/// would not read as part of Kyron and so the reader could see where they had
/// been sent -- and both of those are true of a page that is obviously a guest
/// in a window that never stops naming its host. Leaving was never the part
/// that did the work.
class BrowserSheet extends StatefulWidget {
  final Uri url;
  final String? title;

  /// Swapped in tests. A real web view cannot be built without a platform
  /// behind it, so injecting this is what makes the chrome testable at all.
  final EngineFactory engineFactory;

  /// Told when this browser's session opens and when it goes, so a link
  /// tapped while the browser is up adds a tab instead of stacking a second
  /// browser on the first.
  final void Function(BrowserSession session, {required bool open}) onLifecycle;

  const BrowserSheet({
    super.key,
    required this.url,
    required this.engineFactory,
    required this.onLifecycle,
    this.title,
  });

  @override
  State<BrowserSheet> createState() => _BrowserSheetState();
}

class _BrowserSheetState extends State<BrowserSheet> {
  /// How far a drag on the rail has pulled the sheet down.
  double _drag = 0;

  /// Past this, letting go closes it. Roughly a thumb's travel.
  static const double _dismissAt = 104;

  late final BrowserSession _session;

  @override
  void initState() {
    super.initState();
    _session = BrowserSession(
      engineFactory: widget.engineFactory,
      onHandOff: _handOff,
    )..addListener(_onSession);
    _session.open(widget.url, title: widget.title);
    widget.onLifecycle(_session, open: true);
  }

  @override
  void dispose() {
    widget.onLifecycle(_session, open: false);
    _session
      ..removeListener(_onSession)
      ..dispose();
    super.dispose();
  }

  void _onSession() {
    if (mounted) setState(() {});
  }

  /// A link the page holds that no web view renders: mail, a phone number,
  /// another app. Refusing silently would look like a dead link.
  Future<void> _handOff(Uri uri) async {
    final gone = await AppBrowser.leave(uri);
    if (!gone && mounted) {
      Toast.show(context, 'No app on this device opens ${uri.scheme} links.');
    }
  }

  BrowserTab get _tab => _session.active;

  BrowserEngine get _engine => _session.engineFor(_tab);

  // -- what the chrome does ---------------------------------------------

  Future<void> _openPageSheet() async {
    final tab = _tab;
    final choice = await PageSheet.show(context, tab);
    if (choice == null || !mounted) return;

    switch (choice) {
      case PageChoice.copy:
        await Clipboard.setData(ClipboardData(text: tab.url.toString()));
        if (mounted) Toast.show(context, 'Link copied');
      case PageChoice.share:
        await Share.share(tab.url.toString());
      case PageChoice.leave:
        await _leave(tab);
    }
  }

  /// The escape hatch, and the only one: a reader who has asked for the phone's
  /// own browser gets it.
  Future<void> _leave(BrowserTab tab) async {
    final gone = await AppBrowser.leave(tab.url);
    if (!gone && mounted) {
      Toast.show(context, 'No browser on this device took that link.');
    }
  }

  Future<void> _openTabSheet() async {
    final choice = await TabSheet.show(
      context,
      tabs: _session.tabs,
      activeIndex: _session.activeIndex,
    );
    if (choice == null || !mounted) return;

    switch (choice) {
      case ReadTab(:final index):
        _session.select(index);
      case ShutTab(:final index):
        if (!_session.close(index) && mounted) Navigator.pop(context);
      case ShutEveryTab():
        _session.closeAll();
        if (mounted) Navigator.pop(context);
    }
  }

  void _closeTab(int index) {
    if (!_session.close(index)) Navigator.pop(context);
  }

  Future<void> _reloadOrStop() async {
    final tab = _tab;
    if (tab.isLoading && tab.failure == null) {
      await _engine.stop();
      // The engine reports no more progress once stopped, so the bar would sit
      // where it got to for ever. Saying the load ended is the truth.
      tab.finished(tab.url);
      return;
    }
    tab.retrying();
    await _engine.reload();
  }

  // -- leaving ----------------------------------------------------------

  /// Android's back gesture, in the order a browser makes it mean something:
  /// back through the page's own history first, then out of this tab, then out
  /// of the browser.
  void _back(bool didPop, Object? result) {
    if (didPop || !mounted) return;

    if (_tab.canGoBack) {
      _engine.goBack();
      return;
    }
    if (_session.tabs.length > 1) {
      _closeTab(_session.activeIndex);
      return;
    }
    Navigator.pop(context);
  }

  void _onDrag(DragUpdateDetails details) {
    // Downwards only. Dragging up would lift the sheet off the bottom of the
    // screen and show the wallpaper under it.
    setState(() => _drag = (_drag + details.delta.dy).clamp(0, 600));
  }

  void _onDragEnd(DragEndDetails details) {
    final flung = details.velocity.pixelsPerSecond.dy > 700;
    if (_drag > _dismissAt || flung) {
      Navigator.pop(context);
      return;
    }
    setState(() => _drag = 0);
  }

  @override
  Widget build(BuildContext context) {
    // The session empties itself only through paths that pop, so a build with
    // no tabs would mean a bug rather than a state to draw.
    if (_session.isEmpty) return const SizedBox.shrink();

    final palette = BrowserPalette.of(context);
    final tabs = _session.tabs;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _back,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + SpacingTokens.space8,
        ),
        child: Transform.translate(
          offset: Offset(0, _drag),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: palette.chrome,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(26),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.32),
                  blurRadius: 30,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(26),
              ),
              child: Column(
                // Every band across the sheet takes the full width, so nothing
                // inside one is laid out against a width it has to guess.
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onVerticalDragUpdate: _onDrag,
                    onVerticalDragEnd: _onDragEnd,
                    child: _Chrome(
                      tab: _tab,
                      tabs: tabs,
                      activeIndex: _session.activeIndex,
                      onClose: () => Navigator.pop(context),
                      onAddress: _openPageSheet,
                      onTabs: _openTabSheet,
                      onSelectTab: _session.select,
                      onCloseTab: _closeTab,
                    ),
                  ),
                  Expanded(
                    child: IndexedStack(
                      sizing: StackFit.expand,
                      index: _session.activeIndex,
                      children: [
                        for (final tab in tabs)
                          _Page(
                            key: ValueKey<BrowserTab>(tab),
                            tab: tab,
                            engine: _session.engineFor(tab),
                            onRetry: () {
                              tab.retrying();
                              _session.engineFor(tab).reload();
                            },
                            onLeave: () => _leave(tab),
                          ),
                      ],
                    ),
                  ),
                  BrowserFoot(
                    tab: _tab,
                    onBack: _tab.canGoBack ? _engine.goBack : null,
                    onForward: _tab.canGoForward ? _engine.goForward : null,
                    onReloadOrStop: _reloadOrStop,
                    onShare: () => Share.share(_tab.url.toString()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Rail, bar, tab strip and progress: everything above the page.
class _Chrome extends StatelessWidget {
  final BrowserTab tab;
  final List<BrowserTab> tabs;
  final int activeIndex;
  final VoidCallback onClose;
  final VoidCallback onAddress;
  final VoidCallback onTabs;
  final ValueChanged<int> onSelectTab;
  final ValueChanged<int> onCloseTab;

  const _Chrome({
    required this.tab,
    required this.tabs,
    required this.activeIndex,
    required this.onClose,
    required this.onAddress,
    required this.onTabs,
    required this.onSelectTab,
    required this.onCloseTab,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: BrowserPalette.of(context).chrome,
      child: Column(
        children: [
          const BrowserRail(),
          // Which page, then where that page is, then how far it has got --
          // in that order down the sheet, so the address always sits directly
          // above the thing it is the address of.
          if (tabs.length > 1)
            TabStrip(
              tabs: tabs,
              activeIndex: activeIndex,
              onSelect: onSelectTab,
              onClose: onCloseTab,
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              SpacingTokens.space4,
              0,
              SpacingTokens.space4,
              SpacingTokens.space8,
            ),
            child: Row(
              children: [
                BrowserButton(
                  icon: Iconsax.close_square,
                  label: 'Close the browser',
                  onTap: onClose,
                ),
                Expanded(child: AddressPill(tab: tab, onTap: onAddress)),
                TabCountButton(count: tabs.length, onTap: onTabs),
              ],
            ),
          ),
          LoadBar(tab: tab),
        ],
      ),
    );
  }
}

/// One tab's page.
///
/// The engine stays in the tree behind a failure rather than being replaced by
/// it, so "Try again" is a reload of the view that is already there instead of
/// a new web view that has to start from nothing.
class _Page extends StatelessWidget {
  final BrowserTab tab;
  final BrowserEngine engine;
  final VoidCallback onRetry;
  final VoidCallback onLeave;

  const _Page({
    super.key,
    required this.tab,
    required this.engine,
    required this.onRetry,
    required this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Behind the engine, so a page that has not painted yet is Kyron's
        // paper rather than whatever the platform view leaves there.
        Positioned.fill(
          child: ColoredBox(color: BrowserPalette.of(context).paper),
        ),
        Positioned.fill(child: engine.view()),
        if (tab.failure != null)
          Positioned.fill(
            child: ColoredBox(
              color: BrowserPalette.of(context).paper,
              child: PageFailure(
                tab: tab,
                onRetry: onRetry,
                onLeave: onLeave,
              ),
            ),
          ),
      ],
    );
  }
}
