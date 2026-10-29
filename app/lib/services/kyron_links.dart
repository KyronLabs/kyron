// lib/services/kyron_links.dart
import 'package:flutter/widgets.dart';

import '../routes.dart';

/// What one of Kyron's own links points at.
enum KyronLinkKind { post, profile, community }

/// Kyron's own addresses: what Share hands out, and what a tap on one opens.
///
/// A link to a post, a profile or a community is a screen in this app, not a
/// web page, so [AppBrowser.open] asks here first and opens the screen. A
/// post sent in a message used to open as a web page -- at an address that
/// serves nothing -- inside the app that has the post.
class KyronLinks {
  const KyronLinks._();

  /// The host every link is written with.
  static const host = 'kyron.so';

  static String post(String id) => 'https://$host/post/$id';

  /// What [uri] points at, or null when it is not one of Kyron's.
  static ({KyronLinkKind kind, String value})? parse(Uri uri) {
    if (uri.scheme != 'https' && uri.scheme != 'http') return null;
    final h = uri.host.toLowerCase();
    if (h != host && h != 'www.$host') return null;
    final parts = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    if (parts.length == 2 && parts[0] == 'post') {
      return (kind: KyronLinkKind.post, value: parts[1]);
    }
    if (parts.length == 2 && parts[0] == 'u') {
      return (kind: KyronLinkKind.profile, value: parts[1]);
    }
    if (parts.length == 2 && parts[0] == 'c') {
      return (kind: KyronLinkKind.community, value: parts[1]);
    }
    if (parts.length == 1 && parts[0].startsWith('@') && parts[0].length > 1) {
      return (kind: KyronLinkKind.profile, value: parts[0].substring(1));
    }
    return null;
  }

  /// Opens [uri]'s screen when it is one of Kyron's, and says whether it was.
  static bool open(BuildContext context, Uri uri) {
    final link = parse(uri);
    if (link == null) return false;
    switch (link.kind) {
      case KyronLinkKind.post:
        Navigator.pushNamed(context, Routes.postDetail, arguments: link.value);
      case KyronLinkKind.profile:
        openProfile(context, username: link.value);
      case KyronLinkKind.community:
        Navigator.pushNamed(context, Routes.community, arguments: link.value);
    }
    return true;
  }
}
