// lib/models/lens.dart
import 'dart:ui';

/// One AR lens: a name, and what it does to the picture.
///
/// A colour matrix rather than a shader, because a matrix is a value -- it can
/// be checked in a test, applied to a live preview and baked into the saved
/// photograph by the same code, and the three cannot disagree. A lens that
/// looks one way in the viewfinder and another in the file is the failure this
/// design is chosen to avoid.
///
/// The matrix is the 4x5 form `dart:ui` takes: four rows of
/// `[r, g, b, a, offset]`, where the offset is added after the multiply and is
/// in 0-255 rather than 0-1.
class Lens {
  final String id;
  final String name;

  /// Null for the lens that does nothing, which is a real choice and not an
  /// absence: "none" has to be selectable or there is no way back.
  final List<double>? matrix;

  const Lens({required this.id, required this.name, this.matrix});

  /// What to wrap a preview or a still in. Null when the lens changes nothing.
  ColorFilter? get filter =>
      matrix == null ? null : ColorFilter.matrix(matrix!);

  /// Every lens the camera offers, in the order they appear.
  static const all = <Lens>[
    Lens(id: 'none', name: 'None'),
    Lens(id: 'mono', name: 'Mono', matrix: _mono),
    Lens(id: 'warm', name: 'Warm', matrix: _warm),
    Lens(id: 'cool', name: 'Cool', matrix: _cool),
    Lens(id: 'faded', name: 'Faded', matrix: _faded),
    Lens(id: 'punch', name: 'Punch', matrix: _punch),
    Lens(id: 'noir', name: 'Noir', matrix: _noir),
  ];

  static Lens byId(String id) =>
      all.firstWhere((lens) => lens.id == id, orElse: () => all.first);

  /// Luminance weights. Not a third each: the eye is far more sensitive to
  /// green than to blue, and an even split makes a grey that reads as muddy.
  static const _lumaR = 0.2126;
  static const _lumaG = 0.7152;
  static const _lumaB = 0.0722;

  static const _mono = <double>[
    _lumaR, _lumaG, _lumaB, 0, 0, //
    _lumaR, _lumaG, _lumaB, 0, 0, //
    _lumaR, _lumaG, _lumaB, 0, 0, //
    0, 0, 0, 1, 0, //
  ];

  /// More red, less blue, and a little lift -- the shape of late-afternoon
  /// light rather than a red tint over everything.
  static const _warm = <double>[
    1.10, 0.02, 0.00, 0, 6, //
    0.00, 1.02, 0.00, 0, 2, //
    0.00, 0.00, 0.88, 0, 0, //
    0, 0, 0, 1, 0, //
  ];

  static const _cool = <double>[
    0.88, 0.00, 0.00, 0, 0, //
    0.00, 1.00, 0.04, 0, 2, //
    0.02, 0.04, 1.14, 0, 8, //
    0, 0, 0, 1, 0, //
  ];

  /// Contrast pulled down and the whole thing lifted off black, which is what
  /// a faded print actually looks like.
  static const _faded = <double>[
    0.78, 0.05, 0.05, 0, 30, //
    0.04, 0.76, 0.06, 0, 30, //
    0.05, 0.05, 0.80, 0, 34, //
    0, 0, 0, 1, 0, //
  ];

  /// Saturation up, around the luminance the pixel already had, so bright
  /// things stay bright rather than clipping to white.
  static const _punch = <double>[
    1.45, -0.32, -0.13, 0, -8, //
    -0.15, 1.28, -0.13, 0, -8, //
    -0.15, -0.32, 1.47, 0, -8, //
    0, 0, 0, 1, 0, //
  ];

  /// Mono, then hard contrast. The offset is what puts the midtones down.
  static const _noir = <double>[
    0.32, 1.07, 0.11, 0, -34, //
    0.32, 1.07, 0.11, 0, -34, //
    0.32, 1.07, 0.11, 0, -34, //
    0, 0, 0, 1, 0, //
  ];
}
