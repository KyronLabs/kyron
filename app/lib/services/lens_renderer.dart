// lib/services/lens_renderer.dart
import 'dart:typed_data';
import 'dart:ui' as ui;

import '../models/lens.dart';

/// Bakes a lens into a captured photograph.
///
/// The preview shows the lens by wrapping the camera feed in the same
/// [ColorFilter]; the file has to carry it too, or the picture somebody took
/// is not the picture they saw. Both come from [Lens.matrix], so there is one
/// definition of what a lens is rather than two that can drift.
///
/// Done with `dart:ui` rather than an image library: the filter is applied by
/// the same rasteriser that drew the preview, which is what makes the two
/// match, and it needs no dependency.
class LensRenderer {
  const LensRenderer();

  /// The image with [lens] applied, or the original when it changes nothing.
  Future<ui.Image> apply(ui.Image source, Lens lens) async {
    final filter = lens.filter;
    if (filter == null) return source;

    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    canvas.drawImage(
      source,
      ui.Offset.zero,
      ui.Paint()..colorFilter = filter,
    );

    final picture = recorder.endRecording();
    try {
      return await picture.toImage(source.width, source.height);
    } finally {
      // The recording holds native memory until it is disposed, and one is
      // made per shutter press.
      picture.dispose();
    }
  }

  /// The image as PNG bytes, ready to hand to the composer.
  Future<Uint8List> encode(ui.Image image) async {
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    if (data == null) {
      throw StateError('The captured frame could not be encoded.');
    }
    return data.buffer.asUint8List();
  }
}
