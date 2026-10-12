// lib/models/message_link_card.dart
import 'dart:convert';
import 'dart:typed_data';

import 'link_preview.dart';

/// The card for a link in a direct message, as its sender's phone made it.
///
/// A post's card comes from the server, which reads the post anyway. A direct
/// message is sealed before it leaves the phone, and asking the server for
/// its card would hand over the one thing in it worth knowing -- the address.
/// So the sender's phone reads the page, keeps a small copy of its picture,
/// and seals the whole card the way it seals the words. Readers draw it from
/// what arrived: they never contact the linked site, which therefore cannot
/// learn who read the message, or when.
class MessageLinkCard {
  /// Where a tap goes. Always one of the links in the message itself; see
  /// [tryDecode].
  final String url;

  final String? title;
  final String? description;
  final String? siteName;

  /// The picture, shrunk and re-encoded on the sender's phone. Never a URL:
  /// a URL would have every reader fetch it from wherever it points.
  final Uint8List? image;

  const MessageLinkCard({
    required this.url,
    this.title,
    this.description,
    this.siteName,
    this.image,
  });

  /// The card in the shape the post card draws, so a message and a post
  /// show a link the same way.
  LinkPreview get asPreview => LinkPreview(
        url: url,
        host: Uri.tryParse(url)?.host ?? '',
        title: title,
        description: description,
        siteName: siteName,
      );

  /// Whether there is anything to draw. A card with neither a title nor a
  /// picture is an empty box.
  bool get isRenderable =>
      (title != null && title!.isNotEmpty) || (image?.isNotEmpty ?? false);

  /// The longest each piece of text is kept, matching the server's reader.
  static const maxTitle = 300;
  static const maxDescription = 600;
  static const maxSiteName = 120;

  /// The largest picture a card may carry, in bytes, once decoded.
  static const maxImageBytes = 48 * 1024;

  String encode() => jsonEncode({
        'v': 1,
        'url': url,
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (siteName != null) 'siteName': siteName,
        if (image != null) 'image': base64Encode(image!),
      });

  /// Reads a card that arrived with a message, or answers null.
  ///
  /// Everything in it was written by whoever sent the message, so nothing is
  /// taken on trust. In particular the card's address has to be one of the
  /// links in the message's own words: otherwise a message reading
  /// "kyron.app" could carry a card for somewhere else entirely, and the tap
  /// that looked like it went to one place would go to another.
  static MessageLinkCard? tryDecode(String raw, {required String body}) {
    try {
      final json = jsonDecode(raw);
      if (json is! Map<String, dynamic>) return null;

      final url = json['url'];
      if (url is! String) return null;
      final parsed = Uri.tryParse(url);
      if (parsed == null ||
          !(parsed.scheme == 'https' || parsed.scheme == 'http') ||
          parsed.host.isEmpty) {
        return null;
      }
      if (!_mentions(body, url)) return null;

      Uint8List? image;
      final encoded = json['image'];
      if (encoded is String && encoded.isNotEmpty) {
        final bytes = base64Decode(encoded);
        if (bytes.length <= maxImageBytes) image = bytes;
      }

      final card = MessageLinkCard(
        url: url,
        title: _text(json['title'], maxTitle),
        description: _text(json['description'], maxDescription),
        siteName: _text(json['siteName'], maxSiteName),
        image: image,
      );
      return card.isRenderable ? card : null;
    } catch (_) {
      return null;
    }
  }

  /// Whether [url] is a link the message itself shows. A bare host in the
  /// words ("kyron.app/about") is read as the https address the composer
  /// would have made of it.
  static bool _mentions(String body, String url) {
    if (body.contains(url)) return true;
    final bare = url.replaceFirst(RegExp(r'^https?://'), '');
    return bare.isNotEmpty && body.contains(bare);
  }

  static String? _text(Object? value, int limit) {
    if (value is! String) return null;
    final trimmed = value.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (trimmed.isEmpty) return null;
    return trimmed.length > limit
        ? '${trimmed.substring(0, limit - 1)}…'
        : trimmed;
  }
}
