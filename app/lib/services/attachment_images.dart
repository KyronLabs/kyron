// lib/services/attachment_images.dart
import 'dart:ui' as ui;

import 'package:http/http.dart' as http;

import '../models/lens.dart';
import '../models/lens_attachment.dart';
import '../widgets/face_attachment_painter.dart';
import 'app_log.dart';

/// Fetches and decodes the pictures a lens hangs on a face.
///
/// These come from a published catalogue, so they are somebody else's bytes
/// arriving over the network. That is the same trust as any avatar the app
/// already loads -- and unlike the colour matrices, which are twenty numbers
/// that cannot do anything, an image is a decoder's worth of attack surface.
/// Hence the ceiling below, and hence HTTPS being required by
/// [LensAttachment.tryParse] rather than here, where it would be too late.
class AttachmentImages {
  final http.Client _http;

  AttachmentImages({http.Client? client}) : _http = client ?? http.Client();

  /// What one attachment picture may weigh. Generous for a PNG that covers a
  /// face; nowhere near enough to be a way of filling somebody's phone.
  static const maxBytes = 4 * 1024 * 1024;

  /// The most pictures kept decoded at once. A lens strip somebody scrolls
  /// through would otherwise hold every attachment it ever drew.
  static const maxCached = 24;

  final _decoded = <String, ui.Image>{};
  final _failed = <String>{};

  /// Everything a lens needs to draw, in order. Missing pictures are left out
  /// rather than waited for: a lens that is half loaded draws the half it has
  /// and completes on a later frame.
  List<ResolvedAttachment> ready(Lens lens) => [
        for (final attachment in lens.attachments)
          if (_decoded[attachment.asset] case final image?)
            ResolvedAttachment(attachment, image),
      ];

  /// Whether everything this lens needs is decoded.
  bool isReady(Lens lens) =>
      lens.attachments.every((a) => _decoded.containsKey(a.asset));

  /// Fetches whatever this lens is missing. Answers true if anything new
  /// arrived, so the caller knows whether a repaint is worth it.
  Future<bool> load(Lens lens) async {
    var changed = false;
    for (final attachment in lens.attachments) {
      if (_decoded.containsKey(attachment.asset)) continue;
      // Tried once. A 404 in a published catalogue is not going to become a
      // 200 by asking again every frame.
      if (_failed.contains(attachment.asset)) continue;

      if (await _fetch(attachment.asset)) changed = true;
    }
    return changed;
  }

  Future<bool> _fetch(String url) async {
    try {
      final response =
          await _http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        _failed.add(url);
        AppLog.instance.error(
          'ar',
          'A lens attachment answered ${response.statusCode}: $url',
        );
        return false;
      }
      if (response.bodyBytes.length > maxBytes) {
        _failed.add(url);
        AppLog.instance.error(
          'ar',
          'A lens attachment is ${response.bodyBytes.length} bytes, over the '
              '$maxBytes ceiling: $url',
        );
        return false;
      }

      final codec = await ui.instantiateImageCodec(response.bodyBytes);
      final frame = await codec.getNextFrame();
      _evictIfFull();
      _decoded[url] = frame.image;
      return true;
    } catch (error) {
      // Offline, or bytes that are not a picture. Either way this lens draws
      // nothing rather than the camera failing.
      _failed.add(url);
      AppLog.instance.error('ar', 'A lens attachment would not load: $error');
      return false;
    }
  }

  void _evictIfFull() {
    while (_decoded.length >= maxCached) {
      final oldest = _decoded.keys.first;
      _decoded.remove(oldest)?.dispose();
    }
  }

  void dispose() {
    for (final image in _decoded.values) {
      image.dispose();
    }
    _decoded.clear();
    _failed.clear();
  }
}
