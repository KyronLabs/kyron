// lib/screens/browser/browser_tab.dart
import 'package:flutter/material.dart' show Color, HSLColor;
import 'package:flutter/foundation.dart';

/// What one open page is doing.
///
/// The engine writes into this and the chrome reads it, so the bar, the strip
/// and the tab sheet all show the same page state rather than three guesses at
/// it. Nothing here knows what a web view is; see [BrowserEngine].
class BrowserTab extends ChangeNotifier {
  BrowserTab({required Uri url, String? title})
      : _url = url,
        _title = title,
        _opened = url;

  /// Where the tab was told to go. Kept so a tab that failed on its first
  /// page still knows what it was trying to show.
  final Uri _opened;

  Uri _url;
  String? _title;
  int _progress = 0;
  bool _loading = true;
  String? _failure;
  bool _canGoBack = false;
  bool _canGoForward = false;

  /// Where the reader actually is, which stops being where they arrived the
  /// moment a page redirects or they follow a link.
  Uri get url => _url;

  Uri get opened => _opened;

  /// What the page calls itself, once it has said.
  String? get title => _title;

  /// 0 to 100. Only meaningful while [isLoading].
  int get progress => _progress;

  bool get isLoading => _loading;

  /// Non-null when the page did not load, and then it is the reason in words.
  String? get failure => _failure;

  bool get canGoBack => _canGoBack;
  bool get canGoForward => _canGoForward;

  /// The host, without the `www.` that is noise in every browser that shows it.
  String get host {
    final host = _url.host;
    return host.startsWith('www.') ? host.substring(4) : host;
  }

  /// Whether the connection is one the reader can trust.
  bool get isSecure => _url.scheme == 'https';

  /// Whether the page has said what it is called yet.
  bool get hasTitle => _title != null && _title!.trim().isNotEmpty;

  /// Something to call the tab in a strip two words wide.
  String get label =>
      hasTitle ? _title!.trim() : (host.isEmpty ? _url.toString() : host);

  // -- what the engine reports ------------------------------------------

  void started(Uri url) {
    _url = url;
    _progress = 0;
    _loading = true;
    _failure = null;
    notifyListeners();
  }

  void progressed(int percent) {
    final clamped = percent < 0 ? 0 : (percent > 100 ? 100 : percent);
    if (clamped == _progress) return;
    _progress = clamped;
    notifyListeners();
  }

  void finished(Uri url, {String? title}) {
    _url = url;
    _progress = 100;
    _loading = false;
    if (title != null && title.trim().isNotEmpty) _title = title.trim();
    notifyListeners();
  }

  /// The page did not load. [reason] is shown to the reader, so it has to read
  /// as a sentence rather than as an error code.
  void failed(String reason) {
    _loading = false;
    _progress = 0;
    _failure = reason;
    notifyListeners();
  }

  void historyChanged({required bool back, required bool forward}) {
    if (back == _canGoBack && forward == _canGoForward) return;
    _canGoBack = back;
    _canGoForward = forward;
    notifyListeners();
  }

  /// Clears a failure so the page area shows the engine again. Called when a
  /// retry starts, ahead of whatever the engine reports next.
  void retrying() {
    if (_failure == null && _loading) return;
    _failure = null;
    _loading = true;
    _progress = 0;
    notifyListeners();
  }
}

/// The stand-in for a favicon.
///
/// A real one is a network request per tab that can be slow, can 404, and on a
/// page that failed to load will never arrive at all -- three ways for a tab
/// to sit there blank. A colour and a letter taken from the host are none of
/// those things, are the same on every launch, and tell two tabs apart at the
/// size a strip gives them.
abstract final class OriginMark {
  /// Deterministic hue for [host], via FNV-1a so neighbouring domains do not
  /// land on neighbouring colours.
  static Color colour(String host, {required bool dark}) {
    var hash = 0x811c9dc5;
    for (final unit in host.codeUnits) {
      hash ^= unit;
      hash = (hash * 0x01000193) & 0xFFFFFFFF;
    }
    final hue = (hash % 360).toDouble();
    // Held away from both ends of lightness so the letter on top stays legible
    // in either theme.
    return HSLColor.fromAHSL(1, hue, dark ? 0.42 : 0.52, dark ? 0.52 : 0.46)
        .toColor();
  }

  /// The letter to draw in it.
  static String letter(String host) {
    for (final rune in host.runes) {
      final char = String.fromCharCode(rune);
      if (RegExp(r'[A-Za-z0-9]').hasMatch(char)) return char.toUpperCase();
    }
    return '?';
  }
}
