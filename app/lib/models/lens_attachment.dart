// lib/models/lens_attachment.dart
import 'dart:math' as math;
import 'dart:ui';

import 'face_anchor.dart';

/// Something a lens hangs on a face.
///
/// Declarative on purpose, and that is the whole design rather than a detail.
/// The catalogue works because a lens is *data* -- there is nothing to
/// execute, so one can be downloaded from a URL and pointed at somebody's
/// camera without asking whether it is safe. A picture placed by arithmetic
/// keeps that true. A lens that could run a script would not, and a script is
/// exactly what a Lens Studio lens contains.
///
/// So there is no behaviour here. Only: which picture, where on the face, how
/// big, and which way round.
class LensAttachment {
  /// The picture to draw. HTTPS only -- see [tryParse].
  final String asset;

  /// Where on the face it sits.
  final FaceAnchorPoint anchor;

  /// How wide, as a multiple of the gap between the pupils.
  ///
  /// Faces rather than pixels, so it is right at any distance from the camera,
  /// on any face, at any resolution. Glasses are about 2.6.
  final double width;

  /// Nudged from the anchor, also in pupil-gaps, before the head's tilt is
  /// applied -- so a hat pushed "up" stays up as the head leans.
  final Offset offset;

  /// Turned this much further, in degrees, on top of the head's own tilt.
  final double rotation;

  const LensAttachment({
    required this.asset,
    required this.anchor,
    required this.width,
    this.offset = Offset.zero,
    this.rotation = 0,
  });

  /// Ceilings, so a mistake is a bad-looking lens rather than an attachment
  /// the size of the county or one that vanishes to a point.
  static const maxWidth = 12.0;
  static const maxOffset = 8.0;

  static LensAttachment? tryParse(Object? json) {
    if (json is! Map) return null;

    final asset = json['asset'];
    // HTTPS only. A lens is data the app fetches, and `file://` or `http://`
    // in a published catalogue is either a mistake or somebody testing what
    // this will load.
    if (asset is! String || !asset.startsWith('https://')) return null;
    if (asset.length > 500) return null;
    if (Uri.tryParse(asset) == null) return null;

    final anchorName = json['anchor'];
    if (anchorName is! String) return null;
    final anchor = FaceAnchorPoint.byName(anchorName);
    if (anchor == null) return null;

    final width = _finite(json['width']);
    if (width == null || width <= 0 || width > maxWidth) return null;

    final dx = _finite(json['offsetX'] ?? 0);
    final dy = _finite(json['offsetY'] ?? 0);
    if (dx == null || dy == null) return null;
    if (dx.abs() > maxOffset || dy.abs() > maxOffset) return null;

    final rotation = _finite(json['rotation'] ?? 0);
    if (rotation == null || rotation.abs() > 360) return null;

    return LensAttachment(
      asset: asset,
      anchor: anchor,
      width: width,
      offset: Offset(dx, dy),
      rotation: rotation,
    );
  }

  static double? _finite(Object? value) {
    if (value is! num) return null;
    final number = value.toDouble();
    return number.isFinite ? number : null;
  }

  Map<String, Object?> toJson() => {
        'asset': asset,
        'anchor': anchor.name,
        'width': width,
        if (offset.dx != 0) 'offsetX': offset.dx,
        if (offset.dy != 0) 'offsetY': offset.dy,
        if (rotation != 0) 'rotation': rotation,
      };

  /// Where this lands on a face, in frame pixels.
  ///
  /// The offset is rotated with the head, so "above the eyes" stays above the
  /// eyes when somebody tilts their head rather than sliding off sideways.
  Rect placeOn(FaceAnchor face, double aspectRatio) {
    final scale = face.interpupillary;
    final w = width * scale;
    final h = aspectRatio <= 0 ? w : w / aspectRatio;

    final nudge = Offset(offset.dx * scale, offset.dy * scale);
    final turned = _rotate(nudge, face.rollRadians);
    final centre = face.centre + turned;

    return Rect.fromCenter(center: centre, width: w, height: h);
  }

  static Offset _rotate(Offset point, double radians) {
    if (radians == 0) return point;
    final c = math.cos(radians);
    final s = math.sin(radians);
    return Offset(point.dx * c - point.dy * s, point.dx * s + point.dy * c);
  }
}
