// lib/models/lens_effect.dart
import 'face_region.dart';

/// Something a lens does to the picture itself, rather than hangs on it.
///
/// A [LensAttachment] is a picture placed on a face. An effect changes what is
/// already there: covering part of a face with the skin sampled from another
/// part of it, or frosting everything except a slot.
///
/// Still declarative, and that remains the point. A lens says *what* it wants
/// -- fill this region, frost everything but that one -- and the app owns
/// every line of code that does it. Nothing downloaded is ever executed, which
/// is the property the whole catalogue rests on. An effect the app does not
/// recognise is refused, not guessed at.
sealed class LensEffect {
  const LensEffect();

  static LensEffect? tryParse(Object? json) {
    if (json is! Map) return null;
    return switch (json['kind']) {
      'fill' => FillEffect.tryParse(json),
      'frost' => FrostEffect.tryParse(json),
      _ => null,
    };
  }

  Map<String, Object?> toJson();

  /// A finite number within a range, or null. Bounds are nonsense limits, not
  /// safety ones -- an effect cannot do anything dangerous, only look wrong.
  static double? number(Object? value, {double min = 0, double max = 1}) {
    if (value is! num) return null;
    final number = value.toDouble();
    if (!number.isFinite || number < min || number > max) return null;
    return number;
  }
}

/// Covers a region of the face with a colour taken from elsewhere on it.
///
/// The colour is sampled from the frame rather than written into the lens:
/// a fixed skin tone is somebody else's skin tone on all but one face, and
/// looks like a sticker on the rest. [SkinSampler] reads it from the
/// forehead and cheeks of whoever is in front of the camera.
class FillEffect extends LensEffect {
  /// What gets covered.
  final FaceRegionKind region;

  /// How far the edge is blurred, in pupil-gaps. Without it the region reads
  /// as a decal rather than as skin.
  final double feather;

  /// How much of the original shading shows through, 0 to 1. Zero is a flat
  /// colour, which looks painted on; a little keeps the shape of the face.
  final double keepShading;

  const FillEffect({
    required this.region,
    this.feather = 0.14,
    this.keepShading = 0.35,
  });

  static FillEffect? tryParse(Map<Object?, Object?> json) {
    final name = json['region'];
    if (name is! String) return null;
    final region = FaceRegionKind.byName(name);
    if (region == null) return null;

    final feather = LensEffect.number(json['feather'] ?? 0.14, max: 2);
    final shading = LensEffect.number(json['keepShading'] ?? 0.35);
    if (feather == null || shading == null) return null;

    return FillEffect(
      region: region,
      feather: feather,
      keepShading: shading,
    );
  }

  @override
  Map<String, Object?> toJson() => {
        'kind': 'fill',
        'region': region.name,
        'feather': feather,
        'keepShading': keepShading,
      };
}

/// Frosts the whole frame, and reveals one region of it.
///
/// Blur alone is not frosted glass -- etched glass also washes the colour out
/// and lifts everything towards white, which is what [desaturate] and [lift]
/// are for.
class FrostEffect extends LensEffect {
  /// How heavy the blur is, in pupil-gaps -- so the frost is the same
  /// strength relative to a face however close somebody holds the camera.
  final double blur;

  /// How much colour is washed out, 0 to 1.
  final double desaturate;

  /// How far everything is lifted towards white, 0 to 1.
  final double lift;

  /// What stays sharp.
  final FaceRegionKind reveal;

  /// How far the edge of the revealed area is blurred, in pupil-gaps.
  final double feather;

  const FrostEffect({
    this.blur = 0.16,
    this.desaturate = 0.3,
    this.lift = 0.16,
    this.reveal = FaceRegionKind.eyes,
    this.feather = 0.05,
  });

  static FrostEffect? tryParse(Map<Object?, Object?> json) {
    final blur = LensEffect.number(json['blur'] ?? 0.16, max: 2);
    final desaturate = LensEffect.number(json['desaturate'] ?? 0.3);
    final lift = LensEffect.number(json['lift'] ?? 0.16);
    final feather = LensEffect.number(json['feather'] ?? 0.05, max: 2);
    if (blur == null || desaturate == null || lift == null || feather == null) {
      return null;
    }
    // A blur of zero is not frost, it is nothing. Said no rather than
    // published as a lens that appears to do something and does not.
    if (blur <= 0) return null;

    final name = json['reveal'];
    final reveal = name == null
        ? FaceRegionKind.eyes
        : (name is String ? FaceRegionKind.byName(name) : null);
    if (reveal == null) return null;

    return FrostEffect(
      blur: blur,
      desaturate: desaturate,
      lift: lift,
      reveal: reveal,
      feather: feather,
    );
  }

  @override
  Map<String, Object?> toJson() => {
        'kind': 'frost',
        'blur': blur,
        'desaturate': desaturate,
        'lift': lift,
        'reveal': reveal.name,
        'feather': feather,
      };
}
