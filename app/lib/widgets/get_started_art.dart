// lib/widgets/get_started_art.dart
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

/// The picture across the top of the get-started screen.
///
/// Drawn rather than shipped as an image, for the same reasons the empty
/// states are: it takes its colours from whichever theme you are in instead of
/// being a pale smear at night, it is right at any size on any screen, and it
/// adds nothing to the download.
///
/// Glass discs over a faint grid, each holding one of the things Kyron is for
/// -- a post, a voice, a clip, a room, a message. Empty discs would have been
/// decoration; these are a contents page. The leaf sits in the largest one
/// because the app is the thing they are all inside.
class GetStartedArt extends StatelessWidget {
  const GetStartedArt({super.key});

  /// Where each disc sits and what it holds. Fractions of the box, so the
  /// arrangement survives whatever height the screen gives it.
  /// Clustered and overlapping rather than spaced out: evenly spread discs of
  /// similar size read as a constellation diagram, and the size step is what
  /// makes one of them the subject.
  ///
  /// The shifts run green rather than either way. The leaf sits at about 169
  /// degrees, which is already teal, so turning that way lands in cyan and
  /// then in blue -- and a screen introducing Kyron has no business being
  /// blue. Going the other way runs green, which is the whole family.
  static const _discs = <_Disc>[
    // The big one, low and left of centre, carrying the mark.
    _Disc(0.44, 0.55, 0.215, hue: 0, weight: 1.00, logo: true),
    _Disc(0.71, 0.35, 0.135, hue: -16, weight: 0.94, icon: Iconsax.play),
    _Disc(0.21, 0.37, 0.115, hue: -32, weight: 0.90, icon: Iconsax.microphone),
    _Disc(0.70, 0.73, 0.100, hue: 6, weight: 0.86, icon: Iconsax.people),
    _Disc(0.19, 0.74, 0.082, hue: -44, weight: 0.80, icon: Iconsax.message),
    // Two with nothing in them, to stop the cluster reading as a toolbar.
    _Disc(0.53, 0.17, 0.048, hue: -24, weight: 0.58),
    _Disc(0.89, 0.55, 0.040, hue: -10, weight: 0.50),
  ];

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return ClipRect(
      child: LayoutBuilder(
        builder: (context, box) {
          final short = math.min(box.maxWidth, box.maxHeight);

          return Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(painter: _Ground(dark: dark)),
              // Back to front, so the big one's glass sits over the rest.
              for (final disc in _discs.reversed)
                Positioned(
                  left: disc.x * box.maxWidth - disc.r * short,
                  top: disc.y * box.maxHeight - disc.r * short,
                  width: disc.r * short * 2,
                  height: disc.r * short * 2,
                  child: _Glass(disc: disc, dark: dark),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// One disc: where it sits and how big, as fractions of the box, how far round
/// the hue wheel from Kyron's green it is tinted, and what it holds.
class _Disc {
  final double x;
  final double y;
  final double r;

  /// Degrees from the leaf's own green. Small numbers: the family holds.
  final double hue;

  /// How solid it reads. The big ones carry the picture.
  final double weight;

  final IconData? icon;
  final bool logo;

  const _Disc(
    this.x,
    this.y,
    this.r, {
    required this.hue,
    required this.weight,
    this.icon,
    this.logo = false,
  });
}

/// Kyron's leaf, in HSL, so a disc can be moved round the wheel from it
/// without leaving the family.
final _leaf = HSLColor.fromColor(const Color(0xFF17D1B0));

Color _tint(_Disc disc, bool dark) => _leaf
    .withHue((_leaf.hue + disc.hue) % 360)
    .withSaturation(dark ? 0.66 : 0.74)
    .withLightness(dark ? 0.42 : 0.52)
    .toColor();

/// The wash and the grid behind the discs.
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
              ? const [Color(0xFF0E1618), Color(0xFF0C1A17), Color(0xFF0D0D0F)]
              : const [Color(0xFFEAF6F1), Color(0xFFDDF0E7), Color(0xFFEDF2F6)],
        ).createShader(rect),
    );

    // Structure rather than pattern: at full strength it competes with the
    // discs and wins.
    const cells = 6;
    final step = size.width / cells;
    final line = Paint()
      ..color = (dark ? Colors.white : const Color(0xFF14312B))
          .withValues(alpha: dark ? 0.05 : 0.06)
      ..strokeWidth = 1;
    for (var x = step; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), line);
    }
    for (var y = step; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    }
  }

  @override
  bool shouldRepaint(_Ground old) => old.dark != dark;
}

/// One glass disc, with whatever it holds inside it.
class _Glass extends StatelessWidget {
  final _Disc disc;
  final bool dark;

  const _Glass({required this.disc, required this.dark});

  @override
  Widget build(BuildContext context) {
    final tint = _tint(disc, dark);

    return LayoutBuilder(
      builder: (context, box) {
        final size = box.maxWidth;

        return DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // Lit from the top left and falling away, which is what makes a
            // flat circle read as a sphere.
            gradient: RadialGradient(
              center: const Alignment(-0.45, -0.55),
              radius: 1.05,
              colors: [
                Color.lerp(tint, Colors.white, dark ? 0.30 : 0.42)!
                    .withValues(alpha: disc.weight * 0.95),
                tint.withValues(alpha: disc.weight * 0.82),
                Color.lerp(tint, const Color(0xFF06231E), dark ? 0.55 : 0.34)!
                    .withValues(alpha: disc.weight * 0.90),
              ],
              stops: const [0, 0.55, 1],
            ),
            // A glass sphere's edge catches more light than its middle;
            // without this they read as painted dots.
            border: Border.all(
              color: Colors.white.withValues(alpha: disc.weight * 0.38),
              width: math.max(0.8, size * 0.012),
            ),
            boxShadow: [
              BoxShadow(
                color: tint.withValues(alpha: dark ? 0.34 : 0.26),
                blurRadius: size * 0.30,
                spreadRadius: size * 0.02,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // The highlight, up and left, where the light comes from.
              Align(
                alignment: const Alignment(-0.38, -0.48),
                child: FractionallySizedBox(
                  widthFactor: 0.46,
                  heightFactor: 0.30,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.52),
                          Colors.white.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (disc.logo)
                SvgPicture.asset(
                  'lib/assets/logo.svg',
                  width: size * 0.46,
                  height: size * 0.46,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                )
              else if (disc.icon != null)
                Icon(
                  disc.icon,
                  size: size * 0.40,
                  color: Colors.white.withValues(alpha: 0.92),
                ),
            ],
          ),
        );
      },
    );
  }
}
