// lib/widgets/rooster_art.dart
import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'welcome_cast.dart';

export 'welcome_cast.dart' show CastMember, welcomeCast;

/// The picture across the top of the welcome screen: a rooster in big,
/// rounded pixels, looking left, cropped at the shoulder -- and then the rest
/// of the cast, one after another, each turning up tile by tile out of the
/// last.
///
/// The rooster is the artwork itself, pixel for pixel, rather than a drawing
/// of it. Its look is a mosaic run through a median filter -- similar
/// neighbours fuse, odd ones round off against them -- and every attempt to
/// rebuild that from the colours with rounded rectangles came out noisier
/// than the original. The colours are the artwork's, including the off-white
/// it is painted on, and the same in both themes: this is a picture, not a
/// surface.
///
/// What is drawn is a loop:
///
/// 1. **The arrival.** The rooster's squares come in from its eye outward,
///    each a rounded tile of the picture growing into place, and the whole
///    settles into the exact image.
/// 2. **A hold**, long enough to be a picture rather than a screensaver.
/// 3. **A flip.** Every tile turns over like a card, in a wave out from the
///    next picture's eye, and its back is that picture: a cat, a watermelon,
///    a butterfly, and the rest of [welcomeCast].
///    Each one is drawn on the rooster's exact grid, so a tile always turns
///    into the square in the same place.
/// 4. Hold, flip, and so on round the cast back to the rooster.
///
/// docs/ROUNDED_PIXEL_ART.md is how the pictures were made, and how to add
/// another.
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

  /// Which squares hold the bird, row by row.
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

  /// The rooster as a member of its own cast, first in the loop.
  static const member = CastMember(
    name: 'rooster',
    asset: asset,
    eye: eye,
    squares: squares,
  );

  /// Everyone, in order: the rooster, then [welcomeCast], then round again.
  static const cast = [member, ...welcomeCast];

  /// How long each part of the loop takes. The arrival is the part people
  /// liked first, so it keeps its pace. The rooster holds a little longer
  /// than the others: it is who the screen is, and they are visiting.
  static const arriving = Duration(milliseconds: 1400);
  static const holding = Duration(milliseconds: 4200);
  static const visiting = Duration(milliseconds: 3000);
  static const flipping = Duration(milliseconds: 1500);

  /// How long a picture stays before the next flips in.
  static Duration holdFor(CastMember who) =>
      identical(who, member) ? holding : visiting;

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

class _RoosterArtState extends State<RoosterArt> with TickerProviderStateMixin {
  /// 0 is no squares, 1 the exact rooster. Only ever played once: after it,
  /// the loop is holds and flips.
  late final AnimationController _arrival = AnimationController(
    vsync: this,
    duration: RoosterArt.arriving,
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) _hold();
    });

  /// One picture turning, tile by tile, into the next.
  late final AnimationController _flip = AnimationController(
    vsync: this,
    duration: RoosterArt.flipping,
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) _landed();
    });

  /// Which of [RoosterArt.cast] is showing, and which flips in next.
  int _now = 0;
  int get _next => (_now + 1) % RoosterArt.cast.length;

  /// The hold. A timer rather than a longer animation, so the picture is not
  /// repainted sixty times a second while it stands still.
  Timer? _pause;

  /// Decoded pictures, by cast index. Only the one showing and the one about
  /// to flip in are kept: each is six megabytes decoded, and ten of them on
  /// a sign-in screen would be most of a phone's image cache.
  final _images = <int, ui.Image>{};
  final _streams = <int, (ImageStream, ImageStreamListener)>{};

  /// Set while a hold has run out but the next picture has not decoded.
  bool _waitingForNext = false;

  bool get _still => MediaQuery.disableAnimationsOf(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _load(_now);
  }

  void _load(int index) {
    if (_streams.containsKey(index)) return;
    final stream = AssetImage(RoosterArt.cast[index].asset)
        .resolve(createLocalImageConfiguration(context));
    late final ImageStreamListener listener;
    listener = ImageStreamListener((info, _) {
      if (!mounted) return;
      final first = index == 0 && _images.isEmpty && _arrival.value == 0;
      setState(() => _images[index] = info.image);
      if (first) _begin();
      if (index == _next && _waitingForNext) {
        _waitingForNext = false;
        _turn();
      }
    });
    stream.addListener(listener);
    _streams[index] = (stream, listener);
  }

  /// Lets go of a picture nobody is about to see again for a while, and of
  /// its place in the image cache.
  void _drop(int index) {
    final held = _streams.remove(index);
    _images.remove(index);
    if (held == null) return;
    held.$1.removeListener(held.$2);
    final config = createLocalImageConfiguration(context);
    AssetImage(RoosterArt.cast[index].asset)
        .obtainKey(config)
        .then((key) => PaintingBinding.instance.imageCache.evict(key));
  }

  void _begin() {
    // Not before the picture is here: arriving over nothing would be the
    // animation playing to an empty frame. All at once, and then still -- the
    // rooster, no cast -- for anybody who has asked their phone not to
    // animate.
    if (_still) {
      _arrival.value = 1;
      return;
    }
    _arrival.forward();
  }

  void _hold() {
    if (!mounted || _still) return;
    _load(_next);
    _pause?.cancel();
    _pause = Timer(RoosterArt.holdFor(RoosterArt.cast[_now]), _turn);
  }

  void _turn() {
    if (!mounted || _still) return;
    if (!_images.containsKey(_next)) {
      // Still decoding: wait for it rather than flip into an empty frame.
      _waitingForNext = true;
      _load(_next);
      return;
    }
    _flip.forward(from: 0);
  }

  void _landed() {
    if (!mounted) return;
    final gone = _now;
    setState(() => _now = _next);
    _flip.value = 0;
    if (gone != _now) _drop(gone);
    _hold();
  }

  @override
  void dispose() {
    _pause?.cancel();
    for (final held in _streams.values) {
      held.$1.removeListener(held.$2);
    }
    _arrival.dispose();
    _flip.dispose();
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
            painter: _CastPainter(
              now: RoosterArt.cast[_now],
              next: RoosterArt.cast[_next],
              nowImage: _images[_now],
              nextImage: _images[_next],
              arrival: _arrival,
              flip: _flip,
              topInset: MediaQuery.paddingOf(context).top,
            ),
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}

class _CastPainter extends CustomPainter {
  final CastMember now;
  final CastMember next;
  final ui.Image? nowImage;
  final ui.Image? nextImage;
  final Animation<double> arrival;
  final Animation<double> flip;
  final double topInset;

  _CastPainter({
    required this.now,
    required this.next,
    required this.nowImage,
    required this.nextImage,
    required this.arrival,
    required this.flip,
    required this.topInset,
  }) : super(repaint: Listenable.merge([arrival, flip]));

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

  /// Of the whole flip, how long any one tile takes to turn over. The rest
  /// is the wave crossing the picture.
  static const _turning = 0.24;

  /// The flip's first and last moments, over which the exact pictures give
  /// way to tiles and back: a tile cuts off the soft halo around it, and
  /// cutting it all at once would be a visible jump.
  static const _into = 0.08;
  static const _outOf = 0.14;

  static final _far = math.sqrt(
    math.pow(RoosterArt.squares.length, 2) +
        math.pow(RoosterArt.squares.first.length, 2),
  );

  /// How far [row], [column] is from [who]'s eye, 0 to 1.
  static double _distance(CastMember who, int row, int column) =>
      math.sqrt(
        math.pow(row - who.eye.row, 2) + math.pow(column - who.eye.column, 2),
      ) /
      _far;

  /// How far [row], [column] is from [who]'s eye, as a share of the way to
  /// the farthest corner a phone shows (the first 18 rows): so the wave
  /// takes the whole flip to cross what is on screen, wherever the eye is.
  static double _reach(CastMember who, int row, int column) {
    double from(int r, int c) => math.sqrt(
          math.pow(r - who.eye.row, 2) + math.pow(c - who.eye.column, 2),
        );
    final columns = RoosterArt.squares.first.length - 1;
    final farthest = [
      from(0, 0),
      from(0, columns),
      from(17, 0),
      from(17, columns),
    ].reduce(math.max);
    return from(row, column) / farthest;
  }

  /// A little disorder in the wave, the same every time for each square, so
  /// it ripples rather than marching in rings.
  static double _jitter(int row, int column) {
    final h = math.sin(row * 12.9898 + column * 78.233) * 43758.5453;
    return h - h.floorToDouble();
  }

  static bool _holds(CastMember who, int row, int column) =>
      who.squares[row][column] == '#';

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = RoosterArt.ground);
    final (:scale, :origin) = RoosterArt.layout(size, topInset);
    if (scale <= 0) return;
    final where = origin & (RoosterArt.imageSize * scale);
    final pitch = RoosterArt.pitch * scale;
    Offset centreOf(int row, int column) =>
        origin +
        RoosterArt.gridOrigin * scale +
        Offset((column + 0.5) * pitch.width, (row + 0.5) * pitch.height);

    final t = flip.value;
    if (t > 0 && t < 1 && nowImage != null && nextImage != null) {
      _paintFlip(canvas, where, pitch, centreOf, t);
      return;
    }

    final picture = nowImage;
    if (picture == null) return;
    if (arrival.value < 1 && identical(now, RoosterArt.member)) {
      _paintArrival(canvas, picture, where, pitch, centreOf);
      return;
    }
    _draw(canvas, picture, where, 1);
  }

  void _paintArrival(
    Canvas canvas,
    ui.Image picture,
    Rect where,
    Size pitch,
    Offset Function(int, int) centreOf,
  ) {
    final t = arrival.value;
    // The tiles: rounded squares of the picture, each growing into place
    // from the eye outward. Drawn as a mask, and the picture through it.
    canvas.saveLayer(where, Paint());
    final tile = Paint()..isAntiAlias = true;
    for (var r = 0; r < now.squares.length; r++) {
      for (var c = 0; c < now.squares[r].length; c++) {
        if (!_holds(now, r, c)) continue;
        final at = _distance(now, r, c);
        final local =
            ((t - at * (1 - _landing - _settle)) / _landing).clamp(0.0, 1.0);
        if (local <= 0) continue;
        final grown = Curves.easeOutCubic.transform(local);
        final side = (0.55 + 0.45 * grown) * _bleed;
        canvas.drawRRect(
          _tile(centreOf(r, c), pitch, side, side),
          tile..color = Color.fromRGBO(0, 0, 0, grown),
        );
      }
    }
    _draw(canvas, picture, where, 1, blend: BlendMode.srcIn);
    canvas.restore();

    // And the exact picture over the tiles at the end, so the soft outline
    // the tiles cut off comes in rather than appearing with a jump.
    final settle = ((t - (1 - _settle)) / _settle).clamp(0.0, 1.0);
    if (settle > 0) _draw(canvas, picture, where, settle);
  }

  void _paintFlip(
    Canvas canvas,
    Rect where,
    Size pitch,
    Offset Function(int, int) centreOf,
    double t,
  ) {
    // Each tile turns about its own vertical axis: its front narrows to an
    // edge, and its back -- the next picture's square -- widens out of it.
    // Cards lift a little as they turn and shade as they go edge-on, which
    // is what makes a row of squares read as things turning over rather
    // than as squares changing colour.
    final fronts = <({
      Offset centre,
      double width,
      double lift,
      double shade,
      bool flat
    })>[];
    final backs = <({
      Offset centre,
      double width,
      double lift,
      double shade,
      bool flat
    })>[];
    for (var r = 0; r < RoosterArt.squares.length; r++) {
      for (var c = 0; c < RoosterArt.squares[r].length; c++) {
        final was = _holds(now, r, c);
        final will = _holds(next, r, c);
        if (!was && !will) continue;
        final at =
            math.min(1.0, _reach(next, r, c)) * 0.9 + 0.1 * _jitter(r, c);
        final local = ((t - at * (1 - _turning)) / _turning).clamp(0.0, 1.0);
        final angle = Curves.easeInOutCubic.transform(local) * math.pi;
        final lift = 1 + 0.16 * math.sin(angle);
        final shade = math.sin(angle);
        final card = (
          centre: centreOf(r, c),
          width: math.cos(angle).abs(),
          lift: lift,
          shade: shade,
          // Lying flat, not turning: drawn square, so tiles that have not
          // moved yet or have finished meet edge to edge, as the picture
          // does. Rounded corners there left a white cross at every corner
          // for the whole flip.
          flat: local <= 0 || local >= 1,
        );
        if (angle < math.pi / 2) {
          if (was) fronts.add(card);
        } else if (will) {
          backs.add(card);
        }
      }
    }

    void side(
      ui.Image picture,
      List<
              ({
                Offset centre,
                double width,
                double lift,
                double shade,
                bool flat
              })>
          cards,
    ) {
      if (cards.isEmpty) return;
      canvas.saveLayer(where, Paint());
      final mask = Paint()..isAntiAlias = true;
      for (final card in cards) {
        if (card.flat) {
          canvas.drawRect(
            Rect.fromCenter(
              center: card.centre,
              width: pitch.width + 1,
              height: pitch.height + 1,
            ),
            mask,
          );
          continue;
        }
        canvas.drawRRect(
          _tile(
            card.centre,
            pitch,
            _bleed * card.lift * card.width,
            _bleed * card.lift,
          ),
          mask,
        );
      }
      _draw(canvas, picture, where, 1, blend: BlendMode.srcIn);
      // Edge-on is darker: light falls across a card that is turning away.
      final shading = Paint()..blendMode = BlendMode.srcATop;
      for (final card in cards) {
        if (card.shade <= 0.01) continue;
        canvas.drawRRect(
          _tile(
            card.centre,
            pitch,
            _bleed * card.lift * card.width,
            _bleed * card.lift,
          ),
          shading..color = Color.fromRGBO(20, 12, 8, 0.32 * card.shade),
        );
      }
      canvas.restore();
    }

    side(nowImage!, fronts);
    side(nextImage!, backs);

    // The exact pictures at either end, so neither the outgoing halo nor the
    // incoming one is cut off with a jump.
    final leaving = 1 - (t / _into).clamp(0.0, 1.0);
    if (leaving > 0) _draw(canvas, nowImage!, where, leaving);
    final settling = ((t - (1 - _outOf)) / _outOf).clamp(0.0, 1.0);
    if (settling > 0) _draw(canvas, nextImage!, where, settling);
  }

  RRect _tile(Offset centre, Size pitch, double across, double down) {
    final width = pitch.width * across;
    final height = pitch.height * down;
    return RRect.fromRectAndRadius(
      Rect.fromCenter(center: centre, width: width, height: height),
      Radius.elliptical(
        math.min(_round * pitch.width * down, width / 2),
        _round * pitch.height * down,
      ),
    );
  }

  void _draw(
    Canvas canvas,
    ui.Image picture,
    Rect where,
    double opacity, {
    BlendMode blend = BlendMode.srcOver,
  }) {
    canvas.drawImageRect(
      picture,
      Offset.zero & Size(picture.width.toDouble(), picture.height.toDouble()),
      where,
      Paint()
        ..filterQuality = FilterQuality.high
        ..blendMode = blend
        ..color = Color.fromRGBO(0, 0, 0, opacity),
    );
  }

  @override
  bool shouldRepaint(_CastPainter old) =>
      old.nowImage != nowImage ||
      old.nextImage != nextImage ||
      old.now != now ||
      old.topInset != topInset;
}
