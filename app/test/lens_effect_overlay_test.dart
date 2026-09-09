// test/lens_effect_overlay_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/lens_effect_layer.dart';

/// Where an effect lands, rather than what it looks like.
///
/// None of this is checked by pumping a widget, and that is not laziness:
/// [LensEffectLayer] is built on [BackdropFilter], which does not run under
/// `RepaintBoundary.toImage` and which wedges a headless test run outright
/// when pumped. So the two things that can be wrong about placement were made
/// into arithmetic that stands on its own -- a matrix and a clip rectangle --
/// and those are what is checked. Appearance is covered against
/// [LensEffectBaker] in `lens_effect_test.dart`, which draws into a canvas
/// and needs no backdrop.
///
/// The bug this exists for: region paths are in **camera frame** pixels,
/// while widgets are laid out in **preview box** pixels. A phone draws a
/// 720-wide stream into a 360-wide preview, and taking the layout size left
/// the frost covering a quarter of the screen while the paths carried on past
/// the edge of it.
void main() {
  // Twice the box in each direction, which is the ordinary case rather than a
  // contrived one: cameras stream bigger frames than phones draw previews in.
  const frame = Size(720, 1280);
  const box = Size(360, 640);

  Offset onScreen(Offset framePoint, {bool mirrored = false}) {
    return MatrixUtils.transformPoint(
      LensEffectOverlay.mapping(frame: frame, box: box, mirrored: mirrored),
      framePoint,
    );
  }

  group('frame to preview', () {
    test('puts the far corner of the frame at the far corner of the box', () {
      expect(onScreen(Offset.zero), Offset.zero);
      expect(
        onScreen(const Offset(720, 1280)),
        const Offset(360, 640),
        reason: 'anything less leaves part of the preview unreachable',
      );
      expect(onScreen(const Offset(360, 640)), const Offset(180, 320));
    });

    test('mirrors across the middle for the front camera', () {
      // CameraPreview flips the front preview. A region built from raw
      // landmarks has to be flipped with it, or it sits beside a face rather
      // than on it.
      expect(onScreen(Offset.zero, mirrored: true), const Offset(360, 0));
      expect(
        onScreen(const Offset(720, 1280), mirrored: true),
        const Offset(0, 640),
      );
      // The centre line is the one point the mirror leaves alone.
      expect(
        onScreen(const Offset(360, 640), mirrored: true),
        const Offset(180, 320),
      );
    });

    test('keeps the two axes on the same scale', () {
      // A blur is specified in frame pixels and this transform scales it, so
      // an uneven scale would smear a round blur into an ellipse. The preview
      // is drawn at the camera's own aspect ratio so that they agree; this
      // fails loudly if that stops being true.
      final matrix = LensEffectOverlay.mapping(
        frame: frame,
        box: box,
        mirrored: false,
      );
      expect(matrix.entry(0, 0), closeTo(matrix.entry(1, 1), 1e-9));
    });
  });

  group('the frost cut-out', () {
    test('covers the whole frame, not the size it was laid out at', () {
      final clip = const EverythingBut(null, frame).getClip(box);

      // getClip is handed the *box*; the answer must still be the frame. That
      // one substitution is the entire bug.
      expect(clip.getBounds(), const Rect.fromLTWH(0, 0, 720, 1280));
      expect(clip.contains(const Offset(700, 1200)), isTrue);
    });

    test('leaves the revealed region out of it', () {
      final hole = Path()..addOval(const Rect.fromLTWH(300, 500, 120, 60));
      final clip = EverythingBut(hole, frame).getClip(box);

      expect(clip.contains(const Offset(360, 530)), isFalse,
          reason: 'the middle of the slot is what stays sharp');
      expect(clip.contains(const Offset(700, 1200)), isTrue,
          reason: 'and everything else is still frosted');
    });

    test('reclips when the frame changes, not only the region', () {
      final hole = Path()..addOval(const Rect.fromLTWH(0, 0, 10, 10));
      expect(
        const EverythingBut(null, frame)
            .shouldReclip(const EverythingBut(null, Size(640, 480))),
        isTrue,
        reason: 'a camera switched to another resolution moves everything',
      );
      expect(
        EverythingBut(hole, frame).shouldReclip(EverythingBut(hole, frame)),
        isFalse,
      );
    });
  });
}
