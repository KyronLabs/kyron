// lib/widgets/empty_artwork.dart
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

/// The mark on the front card of an empty state's artwork.
///
/// Deliberately a small set. Every empty state in the app is the same stack of
/// cards from the same angle; what changes is this, and the icon on the chip.
/// Eighteen different pictures is eighteen things to keep in style with each
/// other, and the old set proved it -- a doughnut, a UFO, crossed swords and a
/// tin of salt, sharing nothing but a purple gradient.
enum EmptyMark {
  /// Lines of writing. A post, a draft, a reply.
  lines,

  /// A face and a name. Anything about people.
  person,

  /// A play triangle. Clips.
  play,

  /// Two overlapping rounded squares. A group, a community.
  group,

  /// A single round token, centred. Saved, liked, one thing kept.
  token,

  /// An empty frame with a slash. Nothing found, nothing there.
  none,
}

/// The picture above an empty state's sentence.
///
/// Three cards fanned out, a pane of glass across them, and one accent. The
/// shape is doing all the work: the cards are near-white with long soft
/// shadows, so the drawing reads as depth rather than as an illustration, and
/// nothing in it is a colour that has to be chosen.
///
/// Drawn rather than shipped as an image, and that is the point. A stack of
/// pale cards is a white smear on a dark theme, and PNGs cannot know which
/// theme they are in -- the set this replaces was eighteen images at three
/// scales, each one a fixed colour, none of which changed at night. Everything
/// here takes its colours from the scheme, sharpens at any size, and weighs
/// nothing.
class EmptyArtwork extends StatelessWidget {
  final EmptyMark mark;

  /// The glyph on the chip. The one place a state says what it is *about*
  /// rather than what shape its contents are.
  final IconData chip;

  /// The side of the square box this is drawn in.
  final double size;

  const EmptyArtwork({
    super.key,
    required this.mark,
    required this.chip,
    this.size = 108,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;

    // A card is lighter than what it sits on in either theme -- that is what
    // makes it read as lifted. On a dark theme white would glare, so it is a
    // raised surface rather than a bright one.
    final card = dark
        ? Color.alphaBlend(Colors.white.withValues(alpha: 0.09), scheme.surface)
        : Colors.white;
    final edge = dark
        ? Colors.white.withValues(alpha: 0.10)
        : Colors.black.withValues(alpha: 0.07);
    // The shadows are the drawing.
    //
    // A white card on the light theme's surface is a 3% difference in
    // lightness -- #FFFFFF against #F8FAFC -- so nothing separates the cards
    // from their ground or from each other except what they cast. At half
    // this strength the two behind read as faint outlines rather than as
    // objects, which is what the first pass looked like.
    final shade = Colors.black.withValues(alpha: dark ? 0.50 : 0.22);
    final ink = scheme.onSurface;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // The two behind, fanned. Turned by different amounts and sitting
          // at different heights on purpose: mirrored exactly they merge into
          // one wide shape behind the front card rather than reading as two.
          _card(
            card: card,
            edge: edge,
            shade: shade,
            angle: -0.30,
            offset: Offset(-size * 0.27, size * 0.05),
            scale: 0.84,
            depth: 1,
          ),
          _card(
            card: card,
            edge: edge,
            shade: shade,
            angle: 0.21,
            offset: Offset(size * 0.28, size * 0.01),
            scale: 0.88,
            depth: 1,
          ),
          _card(
            card: card,
            edge: edge,
            shade: shade,
            angle: -0.035,
            offset: Offset(0, -size * 0.11),
            child: _Mark(mark: mark, ink: ink, size: size),
          ),

          // The pane, across the bottom of the stack. A gradient rather than a
          // real blur: at this size the two are indistinguishable, and a
          // BackdropFilter costs a layer on every empty screen in the app.
          Positioned(
            left: size * 0.10,
            right: size * 0.04,
            bottom: size * 0.05,
            child: _Pane(
              card: card,
              edge: edge,
              shade: shade,
              chip: chip,
              scheme: scheme,
              dark: dark,
              size: size,
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({
    required Color card,
    required Color edge,
    required Color shade,
    required double angle,
    required Offset offset,
    double scale = 1,

    /// 0 for the card in front, 1 for the two behind it.
    ///
    /// They are stepped down in value, not only in size and shadow. Three
    /// cards all at the same white read as three outlines on a white ground
    /// however hard the shadows work -- the first pass proved that. Something
    /// further away is dimmer, and the eye reads depth from that before it
    /// reads anything else.
    int depth = 0,
    Widget? child,
  }) {
    final w = size * 0.40 * scale;
    final h = size * 0.62 * scale;
    final face = depth == 0
        ? card
        : Color.alphaBlend(Colors.black.withValues(alpha: 0.055), card);

    return Transform.translate(
      offset: offset,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            color: face,
            borderRadius: BorderRadius.circular(size * 0.085),
            border: Border.all(color: edge, width: 0.7),
            boxShadow: [
              // The long one, for depth.
              // The long one, thrown down and out.
              BoxShadow(
                color: shade,
                blurRadius: size * 0.20,
                offset: Offset(0, size * 0.09),
                spreadRadius: -size * 0.025,
              ),
              // And a tight one where it meets what is under it. Without the
              // contact shadow a card floats rather than rests.
              BoxShadow(
                color: shade.withValues(alpha: shade.a * 0.55),
                blurRadius: size * 0.035,
                offset: Offset(0, size * 0.012),
                spreadRadius: -size * 0.01,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

/// The pane across the stack, and the chip on it.
class _Pane extends StatelessWidget {
  final Color card;
  final Color edge;
  final Color shade;
  final IconData chip;
  final ColorScheme scheme;
  final bool dark;
  final double size;

  const _Pane({
    required this.card,
    required this.edge,
    required this.shade,
    required this.chip,
    required this.scheme,
    required this.dark,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size * 0.29,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.11),
        border: Border.all(color: edge, width: 0.7),
        // Denser at the top where it crosses the cards, thinning towards the
        // bottom -- which is what a pane of glass over something does.
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            card.withValues(alpha: dark ? 0.92 : 0.86),
            card.withValues(alpha: dark ? 0.99 : 0.99),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: shade,
            blurRadius: size * 0.18,
            offset: Offset(0, size * 0.06),
            spreadRadius: -size * 0.02,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size * 0.09),
        child: Row(
          children: [
            // Two rules standing in for whatever the state would have listed.
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _rule(scheme, width: size * 0.30, alpha: 0.30),
                  SizedBox(height: size * 0.05),
                  _rule(scheme, width: size * 0.20, alpha: 0.16),
                ],
              ),
            ),
            // The one thing in the drawing with any weight to it. Everything
            // else is a shade of the surface, so this is where the eye lands.
            Container(
              width: size * 0.19,
              height: size * 0.19,
              decoration: BoxDecoration(
                color: scheme.onSurface,
                shape: BoxShape.circle,
              ),
              child: Icon(
                chip,
                size: size * 0.10,
                color: scheme.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rule(ColorScheme scheme,
      {required double width, required double alpha}) {
    return Container(
      width: width,
      height: size * 0.035,
      decoration: BoxDecoration(
        color: scheme.onSurface.withValues(alpha: alpha),
        borderRadius: BorderRadius.circular(size * 0.02),
      ),
    );
  }
}

/// What is on the front card.
class _Mark extends StatelessWidget {
  final EmptyMark mark;
  final Color ink;
  final double size;

  const _Mark({required this.mark, required this.ink, required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size * 0.06),
      child: CustomPaint(painter: _MarkPainter(mark: mark, ink: ink)),
    );
  }
}

class _MarkPainter extends CustomPainter {
  final EmptyMark mark;
  final Color ink;

  const _MarkPainter({required this.mark, required this.ink});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = ink.withValues(alpha: 0.22);
    final faint = Paint()..color = ink.withValues(alpha: 0.12);
    final w = size.width;
    final h = size.height;
    final r = Radius.circular(w * 0.06);

    void bar(double top, double width, Paint p) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(w * 0.14, h * top, width, h * 0.055),
          r,
        ),
        p,
      );
    }

    switch (mark) {
      case EmptyMark.lines:
        bar(0.22, w * 0.62, paint);
        bar(0.38, w * 0.72, faint);
        bar(0.54, w * 0.44, faint);

      case EmptyMark.person:
        canvas.drawCircle(Offset(w / 2, h * 0.34), w * 0.15, paint);
        bar(0.58, w * 0.72, faint);
        bar(0.72, w * 0.46, faint);

      case EmptyMark.play:
        final centre = Offset(w / 2, h * 0.42);
        final side = w * 0.20;
        canvas.drawPath(
          Path()
            ..moveTo(centre.dx - side * 0.5, centre.dy - side)
            ..lineTo(centre.dx + side, centre.dy)
            ..lineTo(centre.dx - side * 0.5, centre.dy + side)
            ..close(),
          paint,
        );
        bar(0.70, w * 0.58, faint);

      case EmptyMark.group:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(w * 0.16, h * 0.24, w * 0.40, h * 0.30),
            Radius.circular(w * 0.10),
          ),
          faint,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(w * 0.40, h * 0.36, w * 0.40, h * 0.30),
            Radius.circular(w * 0.10),
          ),
          paint,
        );

      case EmptyMark.token:
        canvas.drawCircle(Offset(w / 2, h * 0.40), w * 0.20, faint);
        canvas.drawCircle(Offset(w / 2, h * 0.40), w * 0.09, paint);
        bar(0.72, w * 0.58, faint);

      case EmptyMark.none:
        final box = Rect.fromLTWH(w * 0.18, h * 0.26, w * 0.64, h * 0.42);
        canvas.drawRRect(
          RRect.fromRectAndRadius(box, Radius.circular(w * 0.08)),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = w * 0.045
            ..color = ink.withValues(alpha: 0.16),
        );
        // The slash, at the angle a "no" always takes.
        canvas.save();
        canvas.translate(box.center.dx, box.center.dy);
        canvas.rotate(-math.pi / 4);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(
              center: Offset.zero,
              width: w * 0.62,
              height: w * 0.045,
            ),
            Radius.circular(w * 0.03),
          ),
          paint,
        );
        canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_MarkPainter old) => old.mark != mark || old.ink != ink;
}

/// The chip glyphs, kept together so the set can be read at a glance rather
/// than gathered from eighteen scattered constants.
abstract final class EmptyChips {
  static const post = Iconsax.document_text_copy;
  static const video = Iconsax.video_copy;
  static const message = Iconsax.message_copy;
  static const people = Iconsax.profile_2user_copy;
  static const community = Iconsax.people_copy;
  static const topic = Iconsax.hashtag;
  static const trending = Iconsax.chart_copy;
  static const search = Iconsax.search_normal_copy;
  static const saved = Iconsax.archive_copy;
  static const like = Iconsax.heart_copy;
  static const draft = Iconsax.edit_2_copy;
  static const muted = Iconsax.volume_slash_copy;
  static const lens = Iconsax.magicpen_copy;
  static const live = Iconsax.radar_copy;
  static const poll = Iconsax.chart_2_copy;
  static const offline = Iconsax.cloud_cross_copy;
  static const done = Iconsax.tick_circle_copy;
}
