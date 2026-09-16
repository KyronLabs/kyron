// lib/widgets/get_started_art.dart
import 'package:flutter/material.dart';

/// The picture across the top of the get-started screen.
///
/// A meadow: fronds arching in from the top corner, a bank of wildflowers
/// along the bottom with lavender and a tulip standing out of it, and two
/// butterflies over the top. Photographs, cut out of their sheets.
///
/// This replaced a set of drawn glass discs, which were defensible on paper --
/// theme-aware, nothing to download, right at any size -- and were also dull,
/// which is the one thing a first screen cannot be.
///
/// **The pictures are anchored to the edges, not to fractions of the height.**
/// The screen gives this widget anything from 380 logical pixels on a tall
/// phone down to 120 in a short desktop window, and scaling a meadow into a
/// letterbox makes a smear. Everything below is placed a fixed distance from
/// the bottom edge at a scale taken from the *width*, so a short frame crops
/// the sky off the top and keeps the flowers, which is what a shorter picture
/// of a meadow should look like.
class GetStartedArt extends StatelessWidget {
  const GetStartedArt({super.key});

  /// The width the distances below are written for.
  static const _authoredWidth = 390.0;

  /// Drawn back to front. The grass comes last so the stems behind it are
  /// growing out of it rather than standing in front of it.
  static const _plate = <_Specimen>[
    // Mirrored in the asset: the photograph was cropped through its own
    // fronds, and this runs that straight cut off the left of the screen so
    // only the complete fan is in frame.
    _Specimen(
      'palm',
      aspect: 560 / 680,
      width: 278,
      centreX: 0.22,
      fromTop: -34,
      turn: 0.12,
      opacity: 0.94,
      needsHeight: 240,
    ),
    _Specimen(
      'butterfly-red',
      aspect: 260 / 255,
      width: 62,
      centreX: 0.85,
      fromTop: 34,
      turn: 0.2,
      needsHeight: 240,
    ),
    _Specimen(
      'butterfly-green',
      aspect: 420 / 342,
      width: 170,
      centreX: 0.62,
      fromBottom: 150,
      turn: -0.08,
    ),
    _Specimen(
      'lavender',
      aspect: 240 / 371,
      width: 72,
      centreX: 0.13,
      fromBottom: 34,
      turn: 0.05,
    ),
    _Specimen(
      'tulip',
      aspect: 140 / 282,
      width: 50,
      centreX: 0.88,
      fromBottom: 56,
      turn: -0.04,
    ),
    _Specimen(
      'grass',
      aspect: 900 / 580,
      width: 520,
      centreX: 0.5,
      fromBottom: -95,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final ratio = MediaQuery.maybeDevicePixelRatioOf(context) ?? 2.0;

    return ClipRect(
      child: LayoutBuilder(
        builder: (context, box) {
          final w = box.maxWidth;
          final h = box.maxHeight;
          // Wider screens get a bigger meadow rather than more empty paper,
          // but only so far: on a desktop window the fronds would otherwise
          // arrive the size of the window.
          final scale = (w / _authoredWidth).clamp(0.85, 1.45);

          return Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(painter: _Ground(dark: dark)),
              for (final it in _plate)
                if (h >= it.needsHeight)
                  Positioned(
                    left: it.centreX * w - it.width * scale / 2,
                    top: it.fromTop != null
                        ? it.fromTop! * scale
                        : h - it.fromBottom! * scale - it.height * scale,
                    width: it.width * scale,
                    height: it.height * scale,
                    child: Transform.rotate(
                      angle: it.turn,
                      child: Opacity(
                        opacity: it.opacity,
                        child: Image.asset(
                          'lib/assets/nature/${it.name}.webp',
                          fit: BoxFit.fill,
                          // Decoded at the size it is drawn rather than the
                          // size it was authored, so the grass is not held
                          // in memory at 900 pixels to be shown at 520.
                          cacheWidth: (it.width * scale * ratio).round().clamp(
                                1,
                                2048,
                              ),
                          filterQuality: FilterQuality.medium,
                          // A missing asset is a build mistake, not
                          // something a reader should meet as a grey box
                          // with a cross in it.
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        ),
                      ),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}

/// One cut-out and where it goes, in logical pixels at a 390-wide screen.
class _Specimen {
  final String name;

  /// The asset's own width over its own height, so the box drawn for it is
  /// the shape of the picture and [BoxFit.fill] cannot stretch anything.
  final double aspect;

  final double width;
  double get height => width / aspect;

  /// Centre, as a fraction of the frame's width.
  final double centreX;

  /// Distance from one edge to the specimen's own near edge. Exactly one is
  /// set: [fromTop] glues it to the top so a short frame keeps it, and
  /// [fromBottom] glues it to the bottom so a short frame crops the sky.
  /// Negative runs off the edge.
  final double? fromTop;
  final double? fromBottom;

  /// Radians. Small: a specimen sheet is arranged, not scattered.
  final double turn;

  final double opacity;

  /// The shortest frame this is worth drawing in.
  ///
  /// A desktop window can leave this widget 160 pixels, and in a band that
  /// short the fronds and the high butterfly have nowhere to be: they land on
  /// top of the flowers standing out of the meadow and read as debris. A band
  /// of wildflowers is a complete picture; a band of wildflowers with half a
  /// palm tree lying across it is not.
  final double needsHeight;

  const _Specimen(
    this.name, {
    required this.aspect,
    required this.width,
    required this.centreX,
    this.fromTop,
    this.fromBottom,
    this.turn = 0,
    this.opacity = 1,
    this.needsHeight = 0,
  }) : assert(
          (fromTop == null) != (fromBottom == null),
          'a specimen is anchored to exactly one edge',
        );
}

/// What the meadow sits on: paper, in both themes.
///
/// This is the one decision in the file worth defending. Every photograph
/// here was shot on a white sheet and cut out of it, and a cut like that is
/// never perfect at the edges -- at the size the meadow is drawn, each blade
/// of grass is three pixels wide and most of it is part sheet. Over a
/// near-black ground that shows as a white line down both sides of every
/// blade and white speckle in the gaps; over paper it is invisible, because
/// what is still mixed into the picture is the colour of what is behind it.
///
/// So the night theme gets a picture on paper rather than a picture in the
/// dark: a little deeper than the day one so it is not a searchlight above a
/// dark sheet, and still paper. The alternative was correcting each edge
/// pixel from its own photograph, which works until it meets a white daisy --
/// a flower is the same colour as the sheet behind it, and the correction
/// punched holes straight through them.
class _Ground extends CustomPainter {
  final bool dark;

  const _Ground({required this.dark});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: dark
              ? const [Color(0xFFE7E4DB), Color(0xFFCFDACE)]
              : const [Color(0xFFF7F5EF), Color(0xFFE7EEE6)],
        ).createShader(rect),
    );

    // A soft pool of the leaf's own colour, low and right, so the subject has
    // something warmer behind it than flat paper.
    final centre = Offset(size.width * 0.6, size.height * 0.55);
    final radius = size.longestSide * 0.66;
    canvas.drawCircle(
      centre,
      radius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFF17D1B0).withValues(alpha: dark ? 0.14 : 0.17),
            const Color(0xFF17D1B0).withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: centre, radius: radius)),
    );
  }

  @override
  bool shouldRepaint(_Ground old) => old.dark != dark;
}
