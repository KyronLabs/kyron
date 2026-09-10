// lib/screens/browser/browser_session.dart
import 'package:flutter/foundation.dart';

import 'browser_engine.dart';
import 'browser_tab.dart';

/// Every page the browser currently has open, and which one is being read.
///
/// Owns an engine per tab and keeps them alive while the browser is up, so
/// switching back to a tab shows the page where it was left rather than
/// reloading it and losing the reader's place.
class BrowserSession extends ChangeNotifier implements EngineHost {
  /// How many pages the browser will hold at once.
  ///
  /// Each one is a live web view with its own memory, and this is a browser
  /// for following links out of posts, not a replacement for the phone's. At
  /// the ceiling the least recently read tab makes way, which is the one the
  /// reader is least likely to come back to.
  static const int maxTabs = 8;

  final EngineFactory engineFactory;

  /// What the browser does with a link no web view renders.
  final void Function(Uri uri) onHandOff;

  final List<BrowserTab> _tabs = <BrowserTab>[];
  final Map<BrowserTab, BrowserEngine> _engines = <BrowserTab, BrowserEngine>{};

  /// Tabs oldest-read first. Only read when the ceiling is hit.
  final List<BrowserTab> _byLastRead = <BrowserTab>[];

  int _active = 0;

  BrowserSession({required this.engineFactory, required this.onHandOff});

  @override
  void handOff(Uri uri) => onHandOff(uri);

  /// A page asked for a window of its own. It gets a tab.
  @override
  void openTab(Uri uri) => open(uri);

  List<BrowserTab> get tabs => List<BrowserTab>.unmodifiable(_tabs);

  int get activeIndex => _active;

  bool get isEmpty => _tabs.isEmpty;

  /// The page being read. Only valid while [isEmpty] is false; the browser
  /// closes itself the moment its last tab does.
  BrowserTab get active => _tabs[_active];

  BrowserEngine engineFor(BrowserTab tab) {
    final engine = _engines[tab];
    if (engine == null) {
      throw StateError('No engine for a tab this session does not hold.');
    }
    return engine;
  }

  /// Opens [url], or comes back to it if it is already open.
  ///
  /// Tapping the same link in a thread twice is a slip rather than a request
  /// for two copies of one page, and a duplicate tab loses whatever the first
  /// one had scrolled to.
  void open(Uri url, {String? title}) {
    final existing = _tabs.indexWhere((tab) => tab.opened == url);
    if (existing != -1) {
      select(existing);
      return;
    }

    if (_tabs.length >= maxTabs) {
      final stale = _byLastRead.firstWhere((tab) => tab != active);
      _remove(_tabs.indexOf(stale));
    }

    final tab = BrowserTab(url: url, title: title);
    tab.addListener(notifyListeners);
    _tabs.add(tab);
    _engines[tab] = engineFactory(tab, this);
    _active = _tabs.length - 1;
    _touch(tab);
    notifyListeners();

    // After the frame the widget is built in: an engine has to be in the tree
    // before a load means anything on it.
    _engines[tab]!.load(url);
  }

  void select(int index) {
    if (index < 0 || index >= _tabs.length || index == _active) return;
    _active = index;
    _touch(_tabs[index]);
    notifyListeners();
  }

  /// Closes one tab. Answers whether the browser has any left.
  bool close(int index) {
    if (index < 0 || index >= _tabs.length) return !isEmpty;
    _remove(index);
    notifyListeners();
    return !isEmpty;
  }

  void closeAll() {
    for (var i = _tabs.length - 1; i >= 0; i--) {
      _remove(i);
    }
    notifyListeners();
  }

  void _remove(int index) {
    final tab = _tabs.removeAt(index);
    tab.removeListener(notifyListeners);
    _byLastRead.remove(tab);
    _engines.remove(tab)?.dispose();
    tab.dispose();

    if (_tabs.isEmpty) {
      _active = 0;
    } else if (index < _active) {
      _active -= 1;
    } else if (_active >= _tabs.length) {
      _active = _tabs.length - 1;
    }
  }

  void _touch(BrowserTab tab) {
    _byLastRead
      ..remove(tab)
      ..add(tab);
  }

  @override
  void dispose() {
    for (final tab in _tabs) {
      tab.removeListener(notifyListeners);
      _engines[tab]?.dispose();
      tab.dispose();
    }
    _tabs.clear();
    _engines.clear();
    _byLastRead.clear();
    super.dispose();
  }
}
