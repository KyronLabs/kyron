// lib/services/link_card_reader.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io' show InternetAddress, InternetAddressType;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;

import '../models/message_link_card.dart';

/// Makes the card for a link in a direct message, on the sender's phone.
///
/// The post composer asks the server for its card, and says why: a card read
/// on the device tells the linked site who is writing about it. A direct
/// message turns that around. It is sealed before it leaves the phone, and
/// asking the server would hand it the address out of a message it cannot
/// otherwise read. So here the page is read where the message is written --
/// the one request the linked site sees is the sender's, who is sharing the
/// link anyway -- and the card is sealed with the words. Readers never
/// contact the site at all; see [MessageLinkCard].
///
/// Its own HTTP client, never the app's API client: that one carries the
/// session token, and a page somebody linked to must never be sent it.
class LinkCardReader {
  final Dio _http;

  LinkCardReader({Dio? http})
      : _http = http ??
            Dio(
              BaseOptions(
                connectTimeout: _timeout,
                receiveTimeout: _timeout,
                sendTimeout: _timeout,
                followRedirects: true,
                maxRedirects: 3,
                responseType: ResponseType.bytes,
                headers: const {
                  'Accept': 'text/html,application/xhtml+xml',
                  // Plenty of sites serve their card only to a client that
                  // says what it is.
                  'User-Agent': 'Mozilla/5.0 (compatible; KyronLinkCard/1.0)',
                },
              ),
            );

  static const _timeout = Duration(seconds: 5);

  /// A card lives in the head; anything past this is body.
  static const maxPageBytes = 512 * 1024;

  /// The largest picture worth fetching to shrink.
  static const maxImageBytes = 4 * 1024 * 1024;

  /// The card's picture, as the bubble draws it: 1.91 to 1, what og:image is
  /// made for, and no wider than a bubble on a large phone needs.
  static const imageWidth = 480;
  static const imageHeight = 252;

  /// The card for [url], or null when the page has none, cannot be reached,
  /// or is somewhere a phone has no business fetching on its own.
  Future<MessageLinkCard?> read(String url) async {
    final page = Uri.tryParse(url);
    if (page == null || !isFetchable(page)) return null;

    try {
      final html = await _get(page, maxPageBytes, html: true);
      if (html == null) return null;
      final card = parseCard(
        utf8.decode(html, allowMalformed: true),
        page,
      );

      Uint8List? image;
      final imageUrl = card.imageUrl == null ? null : Uri.parse(card.imageUrl!);
      if (imageUrl != null && isFetchable(imageUrl)) {
        final bytes = await _get(imageUrl, maxImageBytes, html: false);
        if (bytes != null) image = await shrink(bytes);
      }

      final made = MessageLinkCard(
        url: url,
        title: card.title,
        description: card.description,
        siteName: card.siteName,
        image: image,
      );
      return made.isRenderable ? made : null;
    } catch (_) {
      // A link that will not load is a message without a card, never a
      // message that will not send.
      return null;
    }
  }

  /// Whether [uri] is a public web address.
  ///
  /// The phone reads pages because somebody typed or pasted a link, which
  /// may have come from anywhere. A link to the router, or to this phone
  /// itself, is not something to request just because it was pasted.
  static bool isFetchable(Uri uri) {
    if (uri.scheme != 'https' && uri.scheme != 'http') return false;
    final host = uri.host.toLowerCase();
    if (host.isEmpty || host == 'localhost' || host.endsWith('.local')) {
      return false;
    }
    final address = InternetAddress.tryParse(host);
    if (address == null) return !host.endsWith('.localhost');
    if (address.isLoopback || address.isLinkLocal) return false;
    final bytes = address.rawAddress;
    if (address.type == InternetAddressType.IPv4) {
      return !(bytes[0] == 10 ||
          bytes[0] == 0 ||
          (bytes[0] == 172 && bytes[1] >= 16 && bytes[1] < 32) ||
          (bytes[0] == 192 && bytes[1] == 168) ||
          (bytes[0] == 100 && bytes[1] >= 64 && bytes[1] < 128));
    }
    // fc00::/7, the IPv6 private range.
    return (bytes[0] & 0xfe) != 0xfc;
  }

  /// The body of [uri], up to [limit] bytes, or null when it is not what was
  /// asked for or is larger.
  Future<Uint8List?> _get(Uri uri, int limit, {required bool html}) async {
    final response = await _http.getUri<ResponseBody>(
      uri,
      options: Options(responseType: ResponseType.stream),
    );
    final body = response.data;
    if (body == null) return null;

    final type = response.headers.value(Headers.contentTypeHeader) ?? '';
    final wanted = html
        ? type.contains('html')
        : type.startsWith('image/') && !type.contains('svg');
    if (!wanted) return null;

    final bytes = BytesBuilder(copy: false);
    await for (final chunk in body.stream) {
      bytes.add(chunk);
      if (bytes.length > limit) {
        // A page's head is all a card needs: stop reading the rest. A
        // picture past the limit is not worth shrinking.
        if (html) break;
        return null;
      }
    }
    return bytes.takeBytes();
  }

  /// [bytes] cut to the card's shape and re-encoded as a small JPEG, or null
  /// when it is not a picture this phone can decode.
  ///
  /// Decoded at a reduced size by the engine, which is fast, then encoded on
  /// another isolate, which is not. Re-encoded rather than passed through:
  /// the copy that travels is a few tens of kilobytes whatever the site
  /// served, and carries none of the original's metadata.
  static Future<Uint8List?> shrink(Uint8List bytes) async {
    try {
      final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
      final descriptor = await ui.ImageDescriptor.encoded(buffer);
      final width = descriptor.width;
      final height = descriptor.height;
      if (width < 32 || height < 32) {
        descriptor.dispose();
        buffer.dispose();
        return null;
      }

      // The largest 1.91:1 piece of the middle of the picture.
      const aspect = imageWidth / imageHeight;
      final cropW = width / height > aspect ? height * aspect : width * 1.0;
      final cropH = cropW / aspect;
      final scale = (imageWidth / cropW).clamp(0.0, 1.0);

      final codec = await descriptor.instantiateCodec(
        targetWidth: (width * scale).round().clamp(1, width),
        targetHeight: (height * scale).round().clamp(1, height),
      );
      final frame = await codec.getNextFrame();
      final decoded = frame.image;

      final outW = (cropW * scale).round().clamp(1, imageWidth);
      final outH = (cropH * scale).round().clamp(1, imageHeight);
      final left = (decoded.width - outW) / 2;
      final top = (decoded.height - outH) / 2;

      final recorder = ui.PictureRecorder();
      ui.Canvas(recorder).drawImageRect(
        decoded,
        ui.Rect.fromLTWH(left, top, outW.toDouble(), outH.toDouble()),
        ui.Rect.fromLTWH(0, 0, outW.toDouble(), outH.toDouble()),
        ui.Paint()..filterQuality = ui.FilterQuality.medium,
      );
      final cropped = await recorder.endRecording().toImage(outW, outH);
      final rgba = await cropped.toByteData();

      decoded.dispose();
      cropped.dispose();
      codec.dispose();
      descriptor.dispose();
      buffer.dispose();
      if (rgba == null) return null;

      final jpeg = await compute(
        _encodeJpeg,
        (rgba.buffer.asUint8List(), outW, outH),
      );
      return jpeg.length <= MessageLinkCard.maxImageBytes ? jpeg : null;
    } catch (_) {
      return null;
    }
  }
}

/// JPEG at a quality that keeps a card's picture to a few tens of
/// kilobytes, stepping down once if the first try is too large.
Uint8List _encodeJpeg((Uint8List, int, int) input) {
  final (rgba, width, height) = input;
  final picture = img.Image.fromBytes(
    width: width,
    height: height,
    bytes: rgba.buffer,
    numChannels: 4,
    order: img.ChannelOrder.rgba,
  );
  var jpeg = img.encodeJpg(picture, quality: 72);
  if (jpeg.length > MessageLinkCard.maxImageBytes) {
    jpeg = img.encodeJpg(picture, quality: 50);
  }
  return jpeg;
}

/// The fields a link card needs, however the page chose to declare them.
typedef PageCard = ({
  String? title,
  String? description,
  String? imageUrl,
  String? siteName,
});

/// Pulls a card out of a page's HTML.
///
/// The same reading the server does for a post's card (api/src/modules/links/
/// open-graph.ts), so a link looks the same in a message as in a post: a
/// scan of the head rather than a full parse, Open Graph first, then
/// Twitter's tags, then plain HTML.
PageCard parseCard(String html, Uri pageUrl) {
  final head = _headOf(html);
  final meta = _metaTags(head);

  final title = meta['og:title'] ?? meta['twitter:title'] ?? _titleTag(head);
  final description = meta['og:description'] ??
      meta['twitter:description'] ??
      meta['description'];
  final image = meta['og:image:secure_url'] ??
      meta['og:image:url'] ??
      meta['og:image'] ??
      meta['twitter:image'] ??
      meta['twitter:image:src'];

  return (
    title: _clean(title, MessageLinkCard.maxTitle),
    description: _clean(description, MessageLinkCard.maxDescription),
    // Resolved against the page, because og:image is routinely a path.
    imageUrl: image == null ? null : _absolute(image, pageUrl),
    siteName: _clean(meta['og:site_name'], MessageLinkCard.maxSiteName),
  );
}

String _headOf(String html) {
  final end = html.toLowerCase().indexOf('</head>');
  if (end != -1) return html.substring(0, end);
  return html.length > 128 * 1024 ? html.substring(0, 128 * 1024) : html;
}

final _metaTag = RegExp(r'<meta\s+([^>]*)>', caseSensitive: false);

Map<String, String> _metaTags(String head) {
  final found = <String, String>{};
  for (final match in _metaTag.allMatches(head)) {
    final attributes = match.group(1)!;
    final key =
        _attribute(attributes, 'property') ?? _attribute(attributes, 'name');
    final value = _attribute(attributes, 'content');
    if (key == null || value == null) continue;
    found.putIfAbsent(key.trim().toLowerCase(), () => value);
  }
  return found;
}

String? _attribute(String attributes, String name) {
  final quoted = RegExp(
    '\\b$name\\s*=\\s*("([^"]*)"|\'([^\']*)\')',
    caseSensitive: false,
  ).firstMatch(attributes);
  if (quoted != null) return quoted.group(2) ?? quoted.group(3) ?? '';
  final bare = RegExp(
    '\\b$name\\s*=\\s*([^\\s"\'>]+)',
    caseSensitive: false,
  ).firstMatch(attributes);
  return bare?.group(1);
}

String? _titleTag(String head) => RegExp(
      r'<title[^>]*>([\s\S]*?)</title>',
      caseSensitive: false,
    ).firstMatch(head)?.group(1);

const _named = {
  'amp': '&',
  'lt': '<',
  'gt': '>',
  'quot': '"',
  'apos': "'",
  'nbsp': ' ',
};

/// Decodes the entities that actually turn up in titles, collapses
/// whitespace, and truncates.
String? _clean(String? value, int limit) {
  if (value == null) return null;
  final decoded = value
      .replaceAllMapped(
        RegExp(r'&(#\d+|#x[0-9a-f]+|[a-z]+);', caseSensitive: false),
        (m) {
          final entity = m.group(1)!.toLowerCase();
          final named = _named[entity];
          if (named != null) return named;
          if (entity.startsWith('#')) {
            final code = entity.startsWith('#x')
                ? int.tryParse(entity.substring(2), radix: 16)
                : int.tryParse(entity.substring(1));
            if (code != null && code > 0 && code <= 0x10ffff) {
              return String.fromCharCode(code);
            }
          }
          return m.group(0)!;
        },
      )
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  if (decoded.isEmpty) return null;
  return decoded.length > limit
      ? '${decoded.substring(0, limit - 1)}…'
      : decoded;
}

String? _absolute(String value, Uri base) {
  try {
    final resolved = base.resolve(value.trim());
    if (resolved.scheme != 'http' && resolved.scheme != 'https') return null;
    return resolved.toString();
  } catch (_) {
    return null;
  }
}

final linkCardReaderProvider = Provider<LinkCardReader>(
  (ref) => LinkCardReader(),
);

/// The card for a link being written into a message, read once per link.
///
/// Kept for a few minutes after the composer stops asking, so deleting a
/// character and typing it back does not read the page again.
final messageLinkCardProvider =
    FutureProvider.autoDispose.family<MessageLinkCard?, String>((
  ref,
  url,
) async {
  final link = ref.keepAlive();
  final timer = Timer(const Duration(minutes: 5), link.close);
  ref.onDispose(timer.cancel);
  return ref.read(linkCardReaderProvider).read(url);
});
