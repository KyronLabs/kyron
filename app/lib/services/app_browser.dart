// lib/services/app_browser.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/browser/browser_route.dart';
import '../widgets/toast.dart';

/// What Kyron should do with a link somebody tapped.
enum LinkDestination {
  /// A web page. Kyron shows it in its own browser and does not leave.
  inApp,

  /// Not a web page: mail, a phone number, a text message, a map. No web view
  /// can answer these -- only the device knows what does.
  handOff,

  /// Nothing on this device can open it, or it is not a link at all.
  refused,
}

/// The one door out of Kyron.
///
/// Every tap that would leave the app goes through here, and web links do not
/// leave at all: they open in Kyron's own browser. The app used to hand a link
/// in a post straight to Chrome or Safari, on the reasoning that somebody
/// else's page should not look like part of Kyron and that the system browser
/// is where you can see where you have really been sent. Both halves of that
/// are worth keeping and neither one needs a different app: [BrowserRoute]
/// frames the page as an obvious guest and shows the origin at all times.
///
/// This file is the only place in the app that may import `url_launcher`, and
/// `test/outbound_links_test.dart` fails if that stops being true. Leaving the
/// app is a decision, and a decision made in twelve places is not one.
class AppBrowser {
  const AppBrowser._();

  /// Schemes a web view renders itself.
  static const _web = {'http', 'https'};

  /// Reads [raw] the way a person means it.
  ///
  /// A bare `example.com` in a post is a link, and `Uri.parse` reads it as a
  /// path with no scheme. Anything that already names a scheme is left alone,
  /// so `mailto:` and `tel:` survive to [destinationOf].
  static Uri? parse(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return null;

    final direct = Uri.tryParse(trimmed);
    if (direct != null && direct.hasScheme) {
      return direct.host.isEmpty && _web.contains(direct.scheme)
          ? null
          : direct;
    }

    final assumed = Uri.tryParse('https://$trimmed');
    return assumed == null || assumed.host.isEmpty ? null : assumed;
  }

  /// Where [uri] is allowed to go.
  static LinkDestination destinationOf(Uri uri) {
    if (_web.contains(uri.scheme)) {
      return uri.host.isEmpty ? LinkDestination.refused : LinkDestination.inApp;
    }
    return uri.scheme.isEmpty
        ? LinkDestination.refused
        : LinkDestination.handOff;
  }

  /// Opens [raw] the way its scheme deserves.
  ///
  /// A web page opens in Kyron's browser -- or, when one is already up, as a
  /// new tab in it rather than a second browser stacked on the first.
  static Future<void> open(
    BuildContext context,
    String raw, {
    String? title,
  }) async {
    final uri = parse(raw);
    if (uri == null) {
      Toast.show(context, 'That link is not one this can open.');
      return;
    }

    switch (destinationOf(uri)) {
      case LinkDestination.inApp:
        BrowserRoute.open(context, uri, title: title);
      case LinkDestination.handOff:
        final gone = await leave(uri);
        if (!gone && context.mounted) {
          Toast.show(
              context, 'No app on this device opens ${uri.scheme} links.');
        }
      case LinkDestination.refused:
        Toast.show(context, 'That link is not one this can open.');
    }
  }

  /// Hands [uri] to whatever the device uses for it, and says whether anything
  /// took it.
  ///
  /// Two callers are legitimate and there are no others: a scheme no web view
  /// renders, and a reader who has explicitly chosen "Open in browser" from
  /// the browser's own page sheet. Leaving because the app could not be
  /// bothered to show something is not on the list.
  static Future<bool> leave(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } on Object {
      // A missing handler throws on some platforms and answers false on
      // others. The caller only ever needs to know that it did not open.
      return false;
    }
  }
}
