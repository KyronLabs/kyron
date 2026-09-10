// lib/screens/browser/browser_engine.dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'browser_tab.dart';

/// What an engine can ask of the browser holding it.
abstract class EngineHost {
  /// A link no web view renders: mail, a phone number, another app.
  void handOff(Uri uri);

  /// A link the page asked to open in a window of its own.
  void openTab(Uri uri);
}

/// Builds the engine that drives one [BrowserTab].
///
/// Injected rather than constructed in place so the chrome can be tested. A
/// `WebViewController` cannot exist without a platform behind it -- it asserts
/// on construction -- which is why the browser this replaced had no tests at
/// all. Everything above this line is now ordinary Flutter.
typedef EngineFactory = BrowserEngine Function(BrowserTab tab, EngineHost host);

/// What the chrome needs a web engine to do.
abstract class BrowserEngine {
  /// The widget that draws the page.
  Widget view();

  Future<void> load(Uri url);
  Future<void> reload();

  /// Halts a load in progress. The page stays as far as it got.
  Future<void> stop();

  Future<void> goBack();
  Future<void> goForward();

  void dispose();
}

/// [BrowserEngine] on a real web view.
class WebViewEngine implements BrowserEngine {
  /// The channel the injected script answers on.
  static const _channel = 'KyronNewTab';

  final BrowserTab tab;
  final EngineHost host;
  late final WebViewController _controller;

  /// Registering the channel is asynchronous and a page must not load before
  /// it exists, or the first page of every tab has no way to ask for one.
  late final Future<void> _ready;

  /// Gives a page a way to open a second tab.
  ///
  /// A web view opens no window of its own unless the host app builds one, so
  /// a `target="_blank"` link does nothing whatever when tapped -- it does not
  /// fail, it does not navigate, the page simply ignores the finger. This
  /// catches those taps on the way down and hands the address back to the
  /// browser, which is where the tab strip's tabs come from.
  ///
  /// `window.open` is shimmed for the same reason. It already returned null in
  /// a web view with no second window to give it, so a page that checks the
  /// answer is no worse off, and one that does not now works.
  ///
  /// Re-injected after every page, because the flag lives on a document that
  /// navigating away throws out.
  static const _catchNewWindows = '''
(function () {
  if (window.__kyronTabs) return;
  window.__kyronTabs = true;
  document.addEventListener('click', function (e) {
    var node = e.target;
    while (node && node.nodeType === 1 && node.tagName !== 'A') {
      node = node.parentNode;
    }
    if (!node || node.nodeType !== 1) return;
    var aim = node.getAttribute('target');
    if (aim !== '_blank' && aim !== '_new') return;
    if (!node.href) return;
    e.preventDefault();
    $_channel.postMessage(node.href);
  }, true);
  window.open = function (url) {
    if (url) {
      try {
        $_channel.postMessage(new URL(url, location.href).href);
      } catch (e) {}
    }
    return null;
  };
})();
''';

  WebViewEngine(this.tab, this.host) {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // Transparent so a page that has not painted yet shows the sheet behind
      // it rather than a white flash against a dark theme.
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: _decide,
          onPageStarted: (url) => tab.started(Uri.tryParse(url) ?? tab.url),
          onProgress: tab.progressed,
          onPageFinished: _settle,
          onWebResourceError: _blame,
        ),
      );
    _ready = _controller.addJavaScriptChannel(
      _channel,
      onMessageReceived: (message) {
        final uri = Uri.tryParse(message.message);
        if (uri != null) host.openTab(uri);
      },
    );
  }

  NavigationDecision _decide(NavigationRequest request) {
    final uri = Uri.tryParse(request.url);
    if (uri == null) return NavigationDecision.prevent;
    if (uri.scheme == 'http' || uri.scheme == 'https') {
      return NavigationDecision.navigate;
    }
    // A page may link to mail, a phone number, a map or another app. The web
    // view renders none of those, and letting it try shows an error page for
    // something that would have worked.
    host.handOff(uri);
    return NavigationDecision.prevent;
  }

  Future<void> _settle(String url) async {
    final title = await _controller.getTitle();
    tab.finished(Uri.tryParse(url) ?? tab.url, title: title);
    // Ordered after finished() so the arrows settle with the rest of the bar
    // rather than a frame later.
    tab.historyChanged(
      back: await _controller.canGoBack(),
      forward: await _controller.canGoForward(),
    );
    await _controller.runJavaScript(_catchNewWindows);
  }

  void _blame(WebResourceError error) {
    // Android reports a failed image or stylesheet through the same callback
    // as a failed page. Blanking a page that rendered because one of its
    // adverts did not is worse than the advert.
    if (error.isForMainFrame == false) return;
    if (!tab.isLoading) return;
    tab.failed(_explain(error));
  }

  /// The failure as a sentence, because it is shown to a reader.
  static String _explain(WebResourceError error) {
    switch (error.errorType) {
      case WebResourceErrorType.hostLookup:
        return 'That address does not resolve to a server.';
      case WebResourceErrorType.connect:
      case WebResourceErrorType.failedSslHandshake:
        return 'The site refused the connection.';
      case WebResourceErrorType.timeout:
        return 'The site took too long to answer.';
      case WebResourceErrorType.unsupportedScheme:
        return 'Kyron cannot open a link of that kind.';
      default:
        final said = error.description.trim();
        return said.isEmpty ? 'The page did not load.' : said;
    }
  }

  @override
  Widget view() => WebViewWidget(controller: _controller);

  @override
  Future<void> load(Uri url) async {
    await _ready;
    await _controller.loadRequest(url);
  }

  @override
  Future<void> reload() => _controller.reload();

  @override
  Future<void> stop() => _controller.runJavaScript('window.stop();');

  @override
  Future<void> goBack() => _controller.goBack();

  @override
  Future<void> goForward() => _controller.goForward();

  @override
  void dispose() {
    // WebViewController holds a platform view that the widget tree releases
    // when WebViewWidget goes. There is nothing of ours to let go of.
  }
}
