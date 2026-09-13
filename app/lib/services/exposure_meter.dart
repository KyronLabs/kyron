// lib/services/exposure_meter.dart
import 'dart:math' as math;
import 'dart:ui';

import 'skin_sampler.dart' show ReadPixel;

/// Decides how far to open the camera up so the face in front of it is
/// actually exposed.
///
/// This exists because of a report that the face tracking "isn't capturing my
/// face well" from somebody with dark skin, and because the first place to
/// look was not the detector.
///
/// A phone's automatic exposure meters the whole scene. Point one at a face
/// with anything bright behind it -- a window, a lamp, a pale wall -- and the
/// meter brings the *average* down to mid grey, which puts the face below
/// that. On light skin the face still lands in the middle of the sensor's
/// range with contrast to spare. On dark skin the same scene puts it in the
/// bottom stop or two, where there is little contrast left and most of what is
/// there is sensor noise.
///
/// The detector is then being asked to find a face in a near-black, noisy
/// patch, and it does worse. That reads as the model being worse at dark
/// skin -- and the model *is* measurably worse at dark skin, which is a real
/// and documented thing -- but on a phone most of the gap arrives before the
/// model does, in the exposure. This is the part that can be fixed outright
/// rather than mitigated.
///
/// So: measure the light on the face itself, and ask the camera for the
/// exposure compensation that would put it where a face belongs.
class ExposureMeter {
  ExposureMeter({
    this.target = 0.46,
    this.tolerance = 0.07,
    this.maxStep = 0.7,
    this.settle = const Duration(milliseconds: 700),
  });

  /// Where a face should sit, as relative luminance from 0 to 1.
  ///
  /// A little under half. Photographic practice puts skin around a stop over
  /// mid grey; this is lower than that on purpose, because the cost of asking
  /// for too much is a blown-out window behind somebody and the cost of asking
  /// for too little is the thing being fixed.
  final double target;

  /// How far off [target] is close enough. Without a dead band the meter
  /// hunts: every correction changes the reading, which asks for another.
  final double tolerance;

  /// The most exposure compensation to add at once, in stops. A camera that
  /// jumps two stops in one frame is visibly a camera doing something, rather
  /// than a viewfinder.
  final double maxStep;

  /// How long to leave a change alone before making another.
  ///
  /// The camera's own automatic exposure reacts to the compensation, and it
  /// takes a few hundred milliseconds to settle. Measuring during that is
  /// measuring the last correction rather than the scene.
  final Duration settle;

  double _applied = 0;
  DateTime? _changedAt;

  /// The compensation currently asked for, in stops.
  double get applied => _applied;

  /// The compensation to ask the camera for now, or null to leave it alone.
  ///
  /// [luma] is the light on the face, 0 to 1. [min] and [max] are what the
  /// camera says it will accept -- they are not symmetric on every device, and
  /// on some they are both zero, which means the camera does not take
  /// compensation at all and this answers null every time.
  double? offsetFor({
    required double luma,
    required double min,
    required double max,
    required DateTime now,
  }) {
    if (!(max > min)) return null;

    final since = _changedAt;
    if (since != null && now.difference(since) < settle) return null;

    if ((luma - target).abs() <= tolerance) return null;

    // Exposure is logarithmic: one stop is twice the light. Asking for "twice
    // as bright" is +1, not +0.5, and a linear correction here would badly
    // under-ask in exactly the dark case this is for -- a face at 0.12 is
    // nearly two stops under, and linear would offer it a third of one.
    //
    // A frame of pure black -- a covered lens, a camera still opening -- makes
    // this infinite, and the clamp on the next line is what makes that safe
    // rather than a guard of its own.
    final stops = _log2(target / luma);
    final step = stops.clamp(-maxStep, maxStep);
    final wanted = (_applied + step).clamp(min, max);

    // Below this the camera would quantise it away on most devices, and the
    // call would cost a round trip to change nothing.
    if ((wanted - _applied).abs() < 0.1) return null;

    _applied = wanted.toDouble();
    _changedAt = now;
    return _applied;
  }

  /// Forgets what it asked for. Call this when the camera is swapped: the
  /// front and back cameras have their own compensation, and carrying one
  /// over as the other's starting point exposes for the wrong scene.
  void reset() {
    _applied = 0;
    _changedAt = null;
  }

  /// The mean light over a region of a frame, 0 to 1, or null when the region
  /// is off the picture.
  ///
  /// Sampled on a grid rather than averaged over every pixel: this runs on
  /// every camera frame, and forty-nine reads answer the same question as
  /// forty thousand.
  static double? luma({
    required ReadPixel read,
    required Rect region,
    int grid = 7,
  }) {
    if (region.isEmpty || grid < 2) return null;

    var total = 0.0;
    var seen = 0;
    for (var row = 0; row < grid; row++) {
      for (var column = 0; column < grid; column++) {
        final x = region.left + region.width * (column + 0.5) / grid;
        final y = region.top + region.height * (row + 0.5) / grid;
        final pixel = read(x.round(), y.round());
        if (pixel == null) continue;
        // Rec. 709, which is what the sensor's output is encoded against.
        total += (0.2126 * ((pixel >> 16) & 0xFF) +
                0.7152 * ((pixel >> 8) & 0xFF) +
                0.0722 * (pixel & 0xFF)) /
            255.0;
        seen++;
      }
    }
    if (seen == 0) return null;
    return total / seen;
  }

  /// Where to meter, given a face: the face itself, a little wider than the
  /// eyes to take in both cheeks and the forehead without the background.
  ///
  /// A face is about 2.3 pupil-gaps across and 3.2 tall, so this stays inside
  /// it. Metering on a box that includes the wall behind somebody is how the
  /// camera got this wrong in the first place.
  static Rect regionAround(Offset centre, double interpupillary) =>
      Rect.fromCenter(
        center: centre,
        width: interpupillary * 1.9,
        height: interpupillary * 2.5,
      );

  /// Where to meter before a face has been found: the middle of the frame,
  /// which is where somebody holding a phone at arm's length puts their head.
  static Rect regionForSelfie(Size frame) => Rect.fromCenter(
        center: Offset(frame.width / 2, frame.height * 0.45),
        width: frame.width * 0.42,
        height: frame.height * 0.34,
      );

  static double _log2(double value) => math.log(value) / math.ln2;
}
