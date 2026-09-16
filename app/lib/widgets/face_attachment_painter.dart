// lib/widgets/face_attachment_painter.dart
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../models/face_anchor.dart';
import '../models/lens_attachment.dart';

/// One attachment, and the picture to draw for it.
class ResolvedAttachment {
  final LensAttachment attachment;
  final ui.Image image;

  const ResolvedAttachment(this.attachment, this.image);
}

/// Draws a lens's attachments onto a tracked face.
///
/// Used twice, deliberately: once over the live preview and once over the
/// captured still. The picture somebody takes has to be the picture they saw,
/// and the surest way to guarantee that is for both to be the same code
/// reading the same numbers.
class FaceAttachmentPainter extends CustomPainter {
  final List<ResolvedAttachment> attachments;

  /// Where the face is, in the coordinates of the thing being painted.
  final FaceAnchor face;

  /// Whether the image beneath is flipped, as a front-camera preview is.
  ///
  /// Without this the head's tilt is read backwards and an attachment leans
  /// the wrong way -- subtly enough to look like bad tracking rather than a
  /// sign convention.
  final bool mirrored;

  const FaceAttachmentPainter({
    required this.attachments,
    required this.face,
    this.mirrored = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final roll = mirrored ? -face.rollRadians : face.rollRadians;

    for (final resolved in attachments) {
      final image = resolved.image;
      if (image.width <= 0 || image.height <= 0) continue;

      final where = resolved.attachment.placeOn(
        mirrored ? _mirror(face, size) : face,
        image.width / image.height,
      );
      if (where.isEmpty || !where.isFinite) continue;

      canvas.save();
      // Turn about the attachment's own centre, so it pivots where it sits
      // rather than swinging around the middle of the frame.
      canvas.translate(where.center.dx, where.center.dy);
      canvas.rotate(roll + resolved.attachment.rotation * math.pi / 180);
      canvas.translate(-where.center.dx, -where.center.dy);

      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        where,
        Paint()..filterQuality = FilterQuality.medium,
      );
      canvas.restore();
    }
  }

  /// The same face, seen in a flipped image.
  static FaceAnchor _mirror(FaceAnchor face, Size size) => FaceAnchor(
        centre: Offset(size.width - face.centre.dx, face.centre.dy),
        interpupillary: face.interpupillary,
        rollDegrees: -face.rollDegrees,
      );

  @override
  bool shouldRepaint(FaceAttachmentPainter old) =>
      old.face.centre != face.centre ||
      old.face.interpupillary != face.interpupillary ||
      old.face.rollDegrees != face.rollDegrees ||
      old.mirrored != mirrored ||
      old.attachments.length != attachments.length;
}
