// lib/widgets/chat_wallpaper_view.dart
import 'package:flutter/material.dart';

import '../models/chat_wallpaper.dart';

/// Draws a conversation's wallpaper, filling whatever it is given.
///
/// Behind the thread, and as the swatches in the picker, so what is chosen
/// is exactly what is drawn.
class ChatWallpaperView extends StatelessWidget {
  final ChatWallpaper wallpaper;

  /// Decodes an image at about this width rather than its full size. The
  /// picker's swatches are small, and a 3000-pixel photo decoded for each of
  /// them is memory spent on pixels nobody sees.
  final int? decodeWidth;

  const ChatWallpaperView({
    super.key,
    required this.wallpaper,
    this.decodeWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final page = theme.scaffoldBackgroundColor;

    final url = wallpaper.imageUrl;
    if (url != null) {
      final width = decodeWidth;
      // Assigned in two steps: as one conditional, the two kinds of provider
      // meet at Object, which is not an image.
      ImageProvider<Object> image = NetworkImage(url);
      if (width != null) image = ResizeImage(image, width: width);
      return DecoratedBox(
        decoration: BoxDecoration(
          color: page,
          image: DecorationImage(image: image, fit: BoxFit.cover),
        ),
        // A veil in the page's colour, so a busy photo does not fight the
        // words on top of it. Heavier in the dark, where a bright photo
        // glares against everything around it.
        child: ColoredBox(
          color: page.withValues(alpha: dark ? 0.45 : 0.18),
        ),
      );
    }

    final builtIn = wallpaper.builtIn;
    if (builtIn == null) return ColoredBox(color: page);

    if (builtIn == BuiltInWallpaper.dots) {
      return CustomPaint(
        painter: _DotsPainter(
          ground: page,
          dot: theme.colorScheme.onSurface.withValues(alpha: dark ? 0.1 : 0.08),
        ),
        child: const SizedBox.expand(),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: dark ? builtIn.dark : builtIn.light,
        ),
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _DotsPainter extends CustomPainter {
  const _DotsPainter({required this.ground, required this.dot});

  final Color ground;
  final Color dot;

  /// The distance between dots, and how big each is.
  static const double gap = 18;
  static const double radius = 1.1;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = ground);
    final paint = Paint()..color = dot;
    // Every other row offset by half a gap: a straight grid reads as graph
    // paper, a staggered one as texture.
    var row = 0;
    for (var y = gap / 2; y < size.height; y += gap, row++) {
      final shift = row.isOdd ? gap / 2 : 0.0;
      for (var x = gap / 2 + shift; x < size.width; x += gap) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotsPainter old) =>
      old.ground != ground || old.dot != dot;
}
