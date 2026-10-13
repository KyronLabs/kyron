// lib/widgets/rooster_art.dart
import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The picture across the top of the welcome screen: a rooster in big,
/// rounded pixels, looking left, cropped at the shoulder.
///
/// The artwork itself, pixel for pixel, rather than a drawing of it. Its look
/// is a mosaic run through a median filter -- similar neighbours fuse, odd
/// ones round off against them -- and every attempt to rebuild that from the
/// colours with rounded rectangles came out noisier than the original. The
/// colours are the artwork's, including the off-white it is painted on, and
/// the same in both themes: this is a picture, not a surface.
///
/// What is drawn is a loop. The squares come in from the eye outward, each
/// a rounded tile of the picture growing into place, and the whole settles
/// into the exact image. It holds there, long enough to be a picture rather
/// than a screensaver; then the squares go back the way they came, from the
/// edges in, the eye last, and after a breath the bird arrives again. The
/// return is the arrival played backwards, so there is no frame anywhere in
/// the loop that jumps.
///
/// docs/ROUNDED_PIXEL_ART.md is how the picture was made and how to make
/// another one like it.
class RoosterArt extends StatefulWidget {
  const RoosterArt({super.key});

  static const asset = 'lib/assets/rooster.webp';

  /// The off-white the rooster is painted on, which fills the frame wherever
  /// the picture does not reach.
  static const ground = Color(0xFFF6F7F4);

  /// The artwork's size, in its own pixels.
  static const imageSize = Size(1121, 1403);

  /// Its grid: the size of a square and where the first one starts, in the
  /// artwork's pixels. Measured from the image, not chosen.
  static const pitch = Size(56.2, 55.7);
  static const gridOrigin = Offset(-10.04, 14.9);

  /// Which squares hold part of the bird, row by row.
  static const squares = <String>[
    '.......##.##........',
    '.....########.......',
    '....###########.....',
    '....###########.....',
    '...############.....',
    '...############.....',
    '..###########.......',
    '..###########.......',
    '..############......',
    '.##############.....',
    '.###############....',
    '.################...',
    '....#############...',
    '...###############..',
    '...###############..',
    '...################.',
    '....###############.',
    '.....##############.',
    '.....##############.',
    '....################',
    '....################',
    '....################',
    '....################',
    '....################',
    '....################',
  ];

  /// The eye: where the squares arrive from.
  static const eye = (row: 8, column: 8);

  /// How long each part of the loop takes. The arrival is the part people
  /// liked, so it keeps its pace; leaving is a little quicker, because
  /// nobody is waiting for it.
  static const arriving = Duration(milliseconds: 1400);
  static const holding = Duration(milliseconds: 4200);
  static const leaving = Duration(milliseconds: 1100);
  static const resting = Duration(milliseconds: 300);

  /// How far down the artwork the frame always reaches: to the foot of the
  /// eighteenth row of squares, where the wattles end. A row boundary rather
  /// than the wattles' own edge, so that when this is what limits the size
  /// the frame stops between two rows of squares instead of through one.
  static final _headDepth = gridOrigin.dy + 18 * pitch.height;

  /// The scale from the artwork's pixels to the frame's, and where the
  /// artwork's top left corner goes, in a frame of [size] with [topInset]
  /// under the status bar.
  ///
  /// Anchored to the top right, the way the artwork is composed: the bird
  /// faces into the space on the left and is cropped by the right edge and
  /// the bottom. As wide as the frame, and never so big that the comb, head
  /// and wattles do not fit -- so a wide, short window gets a smaller rooster
  /// on the right rather than a close-up of its comb.
  static ({double scale, Offset origin}) layout(Size size, double topInset) {
    final room = math.max(0.0, size.height - topInset);
    final scale = math.min(
      math.max(size.width / imageSize.width, room / imageSize.height),
      room / _headDepth,
    );
    return (
      scale: scale,
      origin: Offset(size.width - imageSize.width * scale, topInset),
    );
  }

  /// The tallest frame no taller than [size] whose foot is the foot of a row
  /// of squares.
  ///
  /// Whatever sits under the picture cuts it with a straight edge, and an
  /// edge through the middle of a row leaves a line of half-squares along
  /// it, which reads as a mistake. Between two rows it reads as the end of
  /// the picture.
  static double fitHeight(Size size, double topInset) {
    final (:scale, :origin) = layout(size, topInset);
    if (scale <= 0) return size.height;
    final rowHeight = pitch.height * scale;
    final firstRow = origin.dy + gridOrigin.dy * scale;
    // A hair of slack, so that a frame already on a boundary is not taken
    // for one a fraction of a pixel short of it.
    final rows = ((size.height - firstRow) / rowHeight + 1e-6).floor();
    if (rows >= squares.length) return size.height;
    return math.min(size.height, firstRow + rows * rowHeight);
  }

  @override
  State<RoosterArt> createState() => _RoosterArtState();
}

class _RoosterArtState extends State<RoosterArt>
    with SingleTickerProviderStateMixin {
  /// 0 is no squares, 1 the exact picture. Forwards is the arrival and
  /// backwards the leaving, so the two are the same motion.
  late final AnimationController _arrival = AnimationController(
    vsync: this,
    duration: RoosterArt.arriving,
    reverseDuration: RoosterArt.leaving,
  )..addStatusListener(_next);

  /// The hold, and the breath between leaving and arriving again. A timer
  /// rather than a longer animation, so the picture is not repainted sixty
  /// times a second for the four seconds it is standing still.
  Timer? _pause;

  ImageStream? _stream;
  late final ImageStreamListener _listener = ImageStreamListener(_loaded);
  ui.Image? _image;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final stream = const AssetImage(RoosterArt.asset)
        .resolve(createLocalImageConfiguration(context));
    if (stream.key == _stream?.key) return;
    _stream?.removeListener(_listener);
    _stream = stream..addListener(_listener);
  }

  bool get _still => MediaQuery.disableAnimationsOf(context);

  void _loaded(ImageInfo info, bool synchronousCall) {
    if (!mounted) return;
    final first = _image == null;
    setState(() => _image = info.image);
    if (!first) return;
    // Not before the picture is here: arriving over nothing would be the
    // animation playing to an empty frame. All at once, and then still, for
    // anybody who has asked their phone not to animate.
    if (_still) {
      _arrival.value = 1;
    } else {
      _arrival.forward();
    }
  }

  void _next(AnimationStatus status) {
    _pause?.cancel();
    switch (status) {
      case AnimationStatus.completed:
        _pause = Timer(RoosterArt.holding, () {
          if (mounted && !_still) _arrival.reverse();
        });
      case AnimationStatus.dismissed:
        _pause = Timer(RoosterArt.resting, () {
          if (mounted) _arrival.forward();
        });
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        break;
    }
  }

  @override
  void dispose() {
    _pause?.cancel();
    _stream?.removeListener(_listener);
    _arrival.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Dark status bar icons over the light ground, in either theme: light
      // ones would be white on off-white.
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: ExcludeSemantics(
        child: RepaintBoundary(
          child: CustomPaint(
            painter: _RoosterPainter(
              image: _image,
              arrival: _arrival,
              topInset: MediaQuery.paddingOf(context).top,
            ),
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}

class _RoosterPainter extends CustomPainter {
  final ui.Image? image;
  final Animation<double> arrival;
  final double topInset;

  _RoosterPainter({
    required this.image,
    required this.arrival,
    required this.topInset,
  }) : super(repaint: arrival);

  /// Each square's tile: its corner radius, and a little bleed so tiles that
  /// have landed meet with no seam between them.
  static const _round = 0.36;
  static const _bleed = 1.06;

  /// Of the whole arrival, how long any one square takes to land; the rest is
  /// the spread from the eye to the farthest square.
  static const _landing = 0.45;

  /// The last part of the arrival, over which the tiles give way to the
  /// exact picture, outline and all.
  static const _settle = 0.15;

  static final List<({int row, int column, double at})> _tiles = () {
    final far = math.sqrt(
      math.pow(RoosterArt.squares.length, 2) +
          math.pow(RoosterArt.squares.first.length, 2),
    );
    return [
      for (var r = 0; r < RoosterArt.squares.length; r++)
        for (var c = 0; c < RoosterArt.squares[r].length; c++)
          if (RoosterArt.squares[r][c] == '#')
            (
              row: r,
              column: c,
              at: math.sqrt(
                    math.pow(r - RoosterArt.eye.row, 2) +
                        math.pow(c - RoosterArt.eye.column, 2),
                  ) /
                  far,
            ),
    ];
  }();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = RoosterArt.ground);
    final picture = image;
    if (picture == null) return;

    final (:scale, :origin) = RoosterArt.layout(size, topInset);
    if (scale <= 0) return;
    final where = origin & (RoosterArt.imageSize * scale);
    final source =
        Offset.zero & Size(picture.width.toDouble(), picture.height.toDouble());
    final quality = Paint()..filterQuality = FilterQuality.high;

    final t = arrival.value;
    if (t >= 1) {
      canvas.drawImageRect(picture, source, where, quality);
      return;
    }

    // The tiles: rounded squares of the picture, each growing into place
    // from the eye outward. Drawn as a mask, and the picture through it.
    canvas.saveLayer(where, Paint());
    final tile = Paint()..isAntiAlias = true;
    final pitch = RoosterArt.pitch * scale;
    for (final square in _tiles) {
      final local = ((t - square.at * (1 - _landing - _settle)) / _landing)
          .clamp(0.0, 1.0);
      if (local <= 0) continue;
      final grown = Curves.easeOutCubic.transform(local);
      final centre = origin +
          RoosterArt.gridOrigin * scale +
          Offset(
            (square.column + 0.5) * pitch.width,
            (square.row + 0.5) * pitch.height,
          );
      final side = (0.55 + 0.45 * grown) * _bleed;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: centre,
            width: pitch.width * side,
            height: pitch.height * side,
          ),
          Radius.circular(_round * pitch.width * side),
        ),
        tile..color = Color.fromRGBO(0, 0, 0, grown),
      );
    }
    canvas.drawImageRect(
      picture,
      source,
      where,
      Paint()
        ..filterQuality = FilterQuality.high
        ..blendMode = BlendMode.srcIn,
    );
    canvas.restore();

    // And the exact picture over the tiles at the end, so the soft outline
    // the tiles cut off comes in rather than appearing with a jump.
    final settle = ((t - (1 - _settle)) / _settle).clamp(0.0, 1.0);
    if (settle > 0) {
      canvas.drawImageRect(
        picture,
        source,
        where,
        quality..color = Color.fromRGBO(0, 0, 0, settle),
      );
    }
  }

  @override
  bool shouldRepaint(_RoosterPainter old) =>
      old.image != image || old.topInset != topInset || old.arrival != arrival;
}
