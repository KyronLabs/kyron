// lib/models/lens.dart
import 'dart:ui';

import 'lens_attachment.dart';
import 'lens_effect.dart';

/// One AR lens: a name, and what it does to the picture.
///
/// A lens is a 4x5 colour matrix and nothing else. That constraint was
/// originally about honesty -- a matrix is a value, so it can be checked in a
/// test, applied to a live preview and baked into the saved photograph by the
/// same code, and the three cannot disagree.
///
/// It turns out to be what makes lenses shippable as *data*. A lens is twenty
/// numbers, so one can be downloaded and used without downloading any code:
/// there is no shader to compile, nothing to execute, and the worst a hostile
/// file can do is look ugly. Had lenses been fragment shaders -- which is what
/// blur or warp would need -- serving them from a catalogue would mean running
/// a stranger's program on somebody's phone.
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

  /// Who made it, for a lens that came from the catalogue. Null for the ones
  /// built into the app.
  final String? author;

  /// Things hung on the face: glasses, a hat, a moustache.
  ///
  /// Empty for a colour-only lens, which is every lens bundled with the app.
  /// A lens may have both -- tint the picture *and* put glasses on.
  final List<LensAttachment> attachments;

  /// Things done to the picture: covering part of a face with its own skin,
  /// frosting everything but the eyes.
  final List<LensEffect> effects;

  const Lens({
    required this.id,
    required this.name,
    this.matrix,
    this.author,
    this.attachments = const [],
    this.effects = const [],
  });

  /// Whether this one needs a face before it can do anything.
  bool get needsFace => attachments.isNotEmpty || effects.isNotEmpty;

  /// What to wrap a preview or a still in. Null when the lens changes nothing.
  ColorFilter? get filter =>
      matrix == null ? null : ColorFilter.matrix(matrix!);

  /// Whether this one came with the app rather than over the network.
  bool get isBuiltIn => builtIn.any((lens) => lens.id == id);

  // -------------------------------------------------------------------------
  // The wire format
  // -------------------------------------------------------------------------

  /// The newest lens shape this build understands.
  ///
  /// A lens declares the shape it needs; anything newer is dropped rather than
  /// half-rendered. Without this an older app meets a lens made of
  /// attachments, finds no matrix, and shows it as the do-nothing lens -- a
  /// chip that is there and does not work, which is worse than a chip that is
  /// not there.
  ///
  /// 1: a colour matrix. 2: attachments on a tracked face. 3: effects that
  /// change the picture itself rather than adding to it.
  static const supportedSchema = 3;

  /// How many numbers a colour matrix has. Four rows of five.
  static const matrixLength = 20;

  /// The widest a coefficient may be.
  ///
  /// Not a safety limit -- a colour matrix cannot do anything dangerous, and
  /// the worst an absurd one produces is a solid white frame. It is a
  /// nonsense limit: a value outside this is a bug, a truncated file or
  /// somebody poking, and none of those should reach the renderer. Punch, the
  /// most aggressive lens here, peaks at 1.47.
  static const maxCoefficient = 8.0;

  /// The widest an offset may be. Offsets are in 0-255, so a whole channel's
  /// range in either direction is already more than any real lens needs.
  static const maxOffset = 255.0;

  /// A lens read from JSON, or null when the JSON is not one.
  ///
  /// Null rather than throwing, and never a partially-built lens: a catalogue
  /// with one bad entry should lose that entry, not the catalogue. The caller
  /// logs what it dropped -- silently ignoring a malformed lens is how you get
  /// a lens that never appears and nobody can say why.
  static Lens? tryParse(Object? json) {
    if (json is! Map) return null;

    final id = json['id'];
    final name = json['name'];
    if (id is! String || !_isSafeId(id)) return null;
    if (name is! String || name.trim().isEmpty || name.length > 40) return null;

    final author = json['author'];
    if (author != null && (author is! String || author.length > 80)) {
      return null;
    }

    // Absent means 1: every lens published before attachments existed.
    final schema = json['schema'] ?? 1;
    if (schema is! int || schema < 1 || schema > supportedSchema) return null;

    final attachments = <LensAttachment>[];
    final raw = json['attachments'];
    if (raw != null) {
      if (raw is! List || raw.length > 8) return null;
      for (final entry in raw) {
        final attachment = LensAttachment.tryParse(entry);
        // One unreadable attachment makes the whole lens wrong rather than
        // partly there: half a pair of glasses is not a lens with a bit
        // missing, it is a lens nobody meant to publish.
        if (attachment == null) return null;
        attachments.add(attachment);
      }
      if (attachments.isNotEmpty && schema < 2) return null;
    }

    final effects = <LensEffect>[];
    final rawEffects = json['effects'];
    if (rawEffects != null) {
      if (rawEffects is! List || rawEffects.length > 4) return null;
      for (final entry in rawEffects) {
        final effect = LensEffect.tryParse(entry);
        // An effect the app cannot do makes the whole lens wrong. Drawing the
        // rest would be a lens that half-works, which nobody published.
        if (effect == null) return null;
        effects.add(effect);
      }
      if (effects.isNotEmpty && schema < 3) return null;
    }

    // The identity lens carries no matrix. Anything else must carry a whole
    // valid one -- a matrix with nineteen numbers is not a lens with a missing
    // number, it is a file that cannot be trusted about anything.
    final rawMatrix = json['matrix'];
    if (rawMatrix == null) {
      return Lens(
        id: id,
        name: name,
        author: author as String?,
        attachments: attachments,
        effects: effects,
      );
    }
    final matrix = _readMatrix(rawMatrix);
    if (matrix == null) return null;

    return Lens(
      id: id,
      name: name,
      matrix: matrix,
      author: author as String?,
      attachments: attachments,
      effects: effects,
    );
  }

  static List<double>? _readMatrix(Object? raw) {
    if (raw is! List || raw.length != matrixLength) return null;

    final values = <double>[];
    for (var i = 0; i < raw.length; i++) {
      final value = raw[i];
      if (value is! num) return null;
      final number = value.toDouble();
      // NaN and infinity both survive JSON round-trips through some encoders
      // and both poison every pixel they touch.
      if (!number.isFinite) return null;

      // The fifth of each row is the offset, in 0-255; the rest are
      // coefficients.
      final limit = i % 5 == 4 ? maxOffset : maxCoefficient;
      if (number.abs() > limit) return null;

      values.add(number);
    }
    return values;
  }

  /// Ids end up as cache keys and in log lines, so they are kept to something
  /// that cannot be mistaken for a path or an escape.
  static bool _isSafeId(String id) =>
      id.isNotEmpty &&
      id.length <= 40 &&
      RegExp(r'^[a-z0-9][a-z0-9_-]*$').hasMatch(id);

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        if (effects.isNotEmpty)
          'schema': 3
        else if (attachments.isNotEmpty)
          'schema': 2,
        if (matrix != null) 'matrix': matrix,
        if (author != null) 'author': author,
        if (attachments.isNotEmpty)
          'attachments': [for (final a in attachments) a.toJson()],
        if (effects.isNotEmpty)
          'effects': [for (final e in effects) e.toJson()],
      };

  // -------------------------------------------------------------------------
  // The lenses that ship with the app
  // -------------------------------------------------------------------------

  /// Bundled, so the camera has lenses with no network and on first launch.
  /// The catalogue adds to these; it never replaces them.
  static const builtIn = <Lens>[
    Lens(id: 'none', name: 'None'),
    Lens(id: 'mono', name: 'Mono', matrix: _mono),
    Lens(id: 'warm', name: 'Warm', matrix: _warm),
    Lens(id: 'cool', name: 'Cool', matrix: _cool),
    Lens(id: 'faded', name: 'Faded', matrix: _faded),
    Lens(id: 'punch', name: 'Punch', matrix: _punch),
    Lens(id: 'noir', name: 'Noir', matrix: _noir),
  ];

  static Lens byId(String id) =>
      builtIn.firstWhere((lens) => lens.id == id, orElse: () => builtIn.first);

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
