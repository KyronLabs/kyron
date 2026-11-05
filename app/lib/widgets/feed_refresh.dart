import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

/// The home feed's pull to refresh: the gap it opens, the mark that answers
/// it, and the leaves that fall while the feed reloads.
///
/// The platform's RefreshIndicator drops a spinner in a disc over the list.
/// Here the list itself comes down under the finger, the Kyron mark at the top
/// winds up as it does, and when it lets go the mark sways like a leaf on a
/// branch and sheds maple leaves over the screen until the new posts land.
///
/// Three parts, kept apart so each can be tested on its own:
///
///  * [FeedRefreshController] owns the state: how far the list is pulled
///    down, which phase it is in, and where the mark is.
///  * [FeedPullPhysics] feeds it. A drag at the top of the list is handed to
///    the controller instead of the list, and handed back as soon as the
///    finger turns round, so pulling and scrolling are one gesture.
///  * [RefreshLogo] and [FallingLeaves] draw it.
///
/// Only the mark moves in the top bar. The avatar, search and bell beside it
/// stay exactly where they are: the bar is still the bar.
class FeedRefreshController extends ChangeNotifier {
  FeedRefreshController({
    required TickerProvider vsync,
    required this.onRefresh,
  }) {
    _ticker = vsync.createTicker(_tick);
  }

  /// Loads whatever "refresh" means for the screen. The animation holds until
  /// it completes, for at least [minimumRefresh].
  Future<void> Function() onRefresh;

  /// How far the list has to come down, after resistance, before letting go
  /// refreshes. Felt rather than seen: a light tick when it is crossed.
  static const double threshold = 72;

  /// How far it rests while the feed reloads.
  static const double hold = 64;

  /// The furthest a pull can go. Resistance grows towards it, so the list
  /// never runs away from the finger and never stops dead either.
  static const double maxPull = 150;

  /// The least time the refresh is shown for. A feed that answers in 80 ms
  /// would otherwise flash the leaves up and away, which reads as a glitch
  /// rather than as the feed having been fetched.
  static const Duration minimumRefresh = Duration(milliseconds: 1100);

  late final Ticker _ticker;
  Duration _last = Duration.zero;

  /// Seconds the ticker has run, across stops and starts.
  double _clock = 0;

  FeedRefreshPhase _phase = FeedRefreshPhase.idle;
  FeedRefreshPhase get phase => _phase;

  /// Whether it is reloading, or settling back from having done so.
  bool get busy =>
      _phase == FeedRefreshPhase.refreshing ||
      _phase == FeedRefreshPhase.settling;

  /// Set by the screen: no swaying, spinning or popping, only the list moving
  /// with the finger, which is the gesture itself rather than decoration.
  bool reduceMotion = false;

  // The finger's travel, before resistance. [extent] is derived from it while
  // dragging and springs on its own once released.
  double _raw = 0;
  bool _dragging = false;
  bool _armed = false;

  double _extent = 0;
  double _extentVelocity = 0;
  double _extentTarget = 0;

  /// How far the list is shown below where it would be, in logical pixels.
  double get extent => _extent;

  /// How far through a pull, 0 to 1 at [threshold]. Past it while held.
  double get progress => (_extent / threshold).clamp(0.0, 1.5);

  /// The mark's pose: a turn in radians, a scale, and a drop in pixels.
  final _Spring _angle = _Spring(stiffness: 190, damping: 13);
  final _Spring _scale = _Spring(stiffness: 260, damping: 15, value: 1);
  final _Spring _drop = _Spring(stiffness: 220, damping: 17);

  double get logoAngle => _angle.value;
  double get logoScale => _scale.value;
  double get logoDrop => _drop.value;

  double _refreshStarted = 0;
  int _generation = 0;

  /// Bumped each time a refresh starts, so a listener can tell one from the
  /// next without watching every frame.
  int get generation => _generation;

  // ---------------------------------------------------------------- input --

  /// A drag of [delta] pixels down at the top of the list. Returns how much of
  /// it was taken: the rest belongs to the list.
  double pull(double delta) {
    if (busy || delta <= 0) return 0;
    _dragging = true;
    _raw += delta;
    _setFromRaw();
    if (_phase == FeedRefreshPhase.idle) _phase = FeedRefreshPhase.pulling;
    _start();
    _notify();
    return delta;
  }

  /// A drag of [delta] pixels back up. Closes the gap before the list moves:
  /// changing your mind halfway is part of the gesture, not a scroll.
  double push(double delta) {
    if (delta <= 0 || _extent <= 0) return 0;
    if (_phase == FeedRefreshPhase.refreshing) {
      // Scrolling away from a refresh still in flight closes the gap and
      // leaves the reload running.
      final taken = math.min(delta, _extent);
      _extent -= taken;
      _extentTarget = 0;
      _extentVelocity = 0;
      _notify();
      return taken;
    }
    if (busy) return 0;
    _dragging = true;
    // Resistance makes pixels on screen worth more finger than pixels pulled,
    // so the way back is measured on screen: the gap closes as fast as the
    // finger rises, no faster and no slower.
    final shown = math.max(0.0, _extent - delta);
    final taken = _extent - shown;
    _raw = _rawFor(shown);
    _setFromRaw();
    _notify();
    return taken;
  }

  /// The finger lifted, or the drag was cancelled.
  void release() {
    if (!_dragging) return;
    _dragging = false;
    if (_phase != FeedRefreshPhase.pulling) return;
    if (_extent >= threshold) {
      _begin(fromPull: true);
    } else {
      _phase = FeedRefreshPhase.settling;
      _extentTarget = 0;
      _raw = 0;
      _armed = false;
      _start();
      _notify();
    }
  }

  /// Refreshes as if pulled: the list comes down, the mark sways, the leaves
  /// fall. What tapping the mark does once the list is back at the top.
  Future<void> refresh() {
    if (busy) return _running ?? Future.value();
    _raw = 0;
    _begin(fromPull: false);
    return _running!;
  }

  Future<void>? _running;

  void _begin({required bool fromPull}) {
    _phase = FeedRefreshPhase.refreshing;
    _generation++;
    _extentTarget = hold;
    _armed = false;
    _refreshStarted = _clock;
    _start();
    _notify();
    _running = _load();
  }

  Future<void> _load() async {
    final started = DateTime.now();
    try {
      await onRefresh();
    } catch (_) {
      // Whoever loads reports its own failure -- the feed shows it in place.
      // The animation's job is only to finish either way.
    }
    final shown = DateTime.now().difference(started);
    if (shown < minimumRefresh) {
      await Future<void>.delayed(minimumRefresh - shown);
    }
    if (_disposed) return;
    _phase = FeedRefreshPhase.settling;
    _extentTarget = 0;
    _raw = 0;
    _start();
    _notify();
    _running = null;
  }

  // --------------------------------------------------------------- motion --

  /// Resistance: the first pixels follow the finger almost one for one, and
  /// each one after costs a little more, approaching [maxPull].
  static double _resist(double raw) => maxPull * (1 - math.exp(-raw / maxPull));

  static double _rawFor(double shown) =>
      -maxPull * math.log(1 - (shown / maxPull).clamp(0.0, 0.999));

  void _setFromRaw() {
    _extent = _resist(_raw);
    _extentTarget = _extent;
    _extentVelocity = 0;
    final armed = _extent >= threshold;
    if (armed && !_armed) {
      // Crossing the line, felt: letting go now will refresh.
      HapticFeedback.selectionClick();
    }
    _armed = armed;
  }

  bool get armed => _armed;

  void _start() {
    if (!_ticker.isActive) {
      _last = Duration.zero;
      _ticker.start();
    }
  }

  void _tick(Duration elapsed) {
    var dt = (elapsed - _last).inMicroseconds / 1e6;
    _last = elapsed;
    _clock += dt;
    // A frame that took a quarter of a second must not fling a spring across
    // the screen: step it in pieces no longer than a 120 Hz frame.
    dt = math.min(dt, 0.05);

    var moving = false;

    if (!_dragging) {
      // The list itself: a critically damped spring, so it arrives without
      // bouncing. A list that wobbles at the top feels broken, not lively.
      var left = dt;
      while (left > 0) {
        final h = math.min(left, 1 / 240);
        const k = 230.0;
        final c = 2 * math.sqrt(k);
        final a = -k * (_extent - _extentTarget) - c * _extentVelocity;
        _extentVelocity += a * h;
        _extent += _extentVelocity * h;
        left -= h;
      }
      if ((_extent - _extentTarget).abs() < 0.25 && _extentVelocity.abs() < 2) {
        _extent = _extentTarget;
        _extentVelocity = 0;
      } else {
        moving = true;
      }
      if (_extent < 0) {
        _extent = 0;
        _extentVelocity = 0;
      }
    }

    // The mark. Its springs chase a target that depends on the phase, so a
    // change of phase is a change of target and never a jump.
    final t = _clock - _refreshStarted;
    double angle = 0, scale = 1, drop = 0;
    if (!reduceMotion) {
      switch (_phase) {
        case FeedRefreshPhase.pulling:
          final p = (_extent / threshold).clamp(0.0, 1.0);
          // Winds back against the pull, like a leaf held by its stem, and
          // leans into the gap. Armed, it swells: the release will be worth
          // it.
          angle = -0.55 * Curves.easeOut.transform(p);
          drop = 5 * p;
          scale = _armed ? 1.16 : 1 + 0.08 * p;
        case FeedRefreshPhase.refreshing:
          // A pendulum on a breeze: a slow sway with a quicker flutter on
          // top, never quite the same twice. Starting it at zero phase means
          // it swings out from wherever the wind-up left it.
          const period = 1.6;
          final w = 2 * math.pi / period;
          angle = 0.30 * math.sin(w * t) + 0.05 * math.sin(2.7 * w * t + 1.1);
          drop = 2.5 + 2.0 * math.sin(2 * w * t - math.pi / 2);
          scale = 1.06 + 0.02 * math.sin(w * t);
        case FeedRefreshPhase.idle:
        case FeedRefreshPhase.settling:
          break;
      }
    }
    for (final (s, target) in [
      (_angle, angle),
      (_scale, scale),
      (_drop, drop)
    ]) {
      s.target = target;
      if (s.step(dt)) moving = true;
    }

    if (_phase == FeedRefreshPhase.settling && !moving) {
      _phase = FeedRefreshPhase.idle;
    }
    if (_phase == FeedRefreshPhase.refreshing) moving = true;
    if (_dragging) moving = true;

    _notify();
    if (!moving) _ticker.stop();
  }

  bool _disposed = false;

  void _notify() {
    if (_disposed) return;
    // The physics hands drags over from inside the scrollable, which can be
    // in the middle of laying out. Rebuilding then is an error, so it waits
    // for the frame to finish.
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      if (_notifyQueued) return;
      _notifyQueued = true;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _notifyQueued = false;
        if (!_disposed) notifyListeners();
      });
      return;
    }
    notifyListeners();
  }

  bool _notifyQueued = false;

  @override
  void dispose() {
    _disposed = true;
    _ticker.dispose();
    super.dispose();
  }
}

enum FeedRefreshPhase {
  /// At rest.
  idle,

  /// A finger is pulling the list down.
  pulling,

  /// Released past the line, or the mark was tapped: the feed is reloading.
  refreshing,

  /// Done, or let go too soon: everything is going back to rest.
  settling,
}

/// A damped spring, stepped by hand so several can share one ticker.
class _Spring {
  _Spring({required this.stiffness, required this.damping, this.value = 0})
      : target = value;

  final double stiffness;
  final double damping;
  double value;
  double target;
  double velocity = 0;

  /// Advances by [dt] seconds. Whether it is still moving.
  bool step(double dt) {
    var left = dt;
    while (left > 0) {
      final h = math.min(left, 1 / 240);
      final a = -stiffness * (value - target) - damping * velocity;
      velocity += a * h;
      value += velocity * h;
      left -= h;
    }
    if ((value - target).abs() < 1e-3 && velocity.abs() < 1e-2) {
      value = target;
      velocity = 0;
      return false;
    }
    return true;
  }
}

/// Scroll physics that hand a drag at the top of the list to [controller].
///
/// Drags go through here before they reach the list, which is what lets the
/// gap close before the list scrolls when the finger turns back up. Watching
/// scroll notifications instead -- which is what RefreshIndicator does --
/// sees the list move first and can only react to it after.
///
/// Above the top, the list is clamped on every platform: the pull is the
/// overscroll there, and a bounce underneath it would be two things moving
/// for one finger. Everywhere else the platform's own physics apply.
class FeedPullPhysics extends ScrollPhysics {
  final FeedRefreshController controller;

  const FeedPullPhysics({required this.controller, super.parent});

  @override
  FeedPullPhysics applyTo(ScrollPhysics? ancestor) =>
      FeedPullPhysics(controller: controller, parent: buildParent(ancestor));

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // offset > 0: the finger moved down, towards the top of the list.
    if (offset < 0 && controller.extent > 0) {
      final taken = controller.push(-offset);
      final rest = offset + taken;
      if (rest == 0) return 0;
      return super.applyPhysicsToUserOffset(position, rest);
    }
    if (offset > 0 && position.pixels <= position.minScrollExtent) {
      final taken = controller.pull(offset);
      final rest = offset - taken;
      if (rest == 0) return 0;
      return super.applyPhysicsToUserOffset(position, rest);
    }
    return super.applyPhysicsToUserOffset(position, offset);
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    // ClampingScrollPhysics' own rule for the top edge, and only that edge.
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      return value - position.pixels;
    }
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) {
      return value - position.minScrollExtent;
    }
    return super.applyBoundaryConditions(position, value);
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    // Called when a drag ends or is cancelled -- the release.
    controller.release();
    return super.createBallisticSimulation(position, velocity);
  }
}

/// The Kyron mark, posed by [controller]. Wraps the mark and nothing else, so
/// it can move while everything beside it in the bar stays still.
class RefreshLogo extends StatelessWidget {
  final FeedRefreshController controller;
  final Widget child;

  const RefreshLogo({super.key, required this.controller, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: child,
      builder: (context, child) => Transform(
        // Turns about the base of the stem, as a leaf hanging from a branch
        // would -- not about its middle, which reads as a spinner.
        alignment: const Alignment(0, 0.55),
        transform: Matrix4.identity()
          ..translateByDouble(0, controller.logoDrop, 0, 1)
          ..rotateZ(controller.logoAngle)
          ..scaleByDouble(controller.logoScale, controller.logoScale, 1, 1),
        child: child,
      ),
    );
  }
}

/// Maple leaves falling over the screen while [controller] refreshes.
///
/// Drawn on top of everything (the mark sheds them, so they start in the
/// top bar) and touches nothing: the screen underneath stays fully usable.
/// Its ticker runs only while there are leaves to draw.
class FallingLeaves extends StatefulWidget {
  final FeedRefreshController controller;

  /// Where the mark is, in this widget's coordinates. Leaves are shed from
  /// there.
  final Offset origin;

  /// Leaves start falling from here down. Above it is the status bar.
  final double top;

  /// A fixed seed for tests. Random otherwise.
  final int? seed;

  const FallingLeaves({
    super.key,
    required this.controller,
    required this.origin,
    this.top = 0,
    this.seed,
  });

  /// The most leaves on screen at once. Each is a path and two vein strokes;
  /// sixty of them is nothing for the GPU and plenty for the eye.
  static const int maxLeaves = 56;

  @override
  State<FallingLeaves> createState() => FallingLeavesState();
}

@visibleForTesting
class FallingLeavesState extends State<FallingLeaves>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker = createTicker(_tick);
  late math.Random _random = math.Random(widget.seed);
  final List<_Leaf> _leaves = [];
  final ValueNotifier<int> _frame = ValueNotifier(0);

  Duration _last = Duration.zero;
  double _clock = 0;
  double _spawnDebt = 0;
  int _seenGeneration = 0;
  bool _shedThisPull = false;
  FeedRefreshPhase _lastPhase = FeedRefreshPhase.idle;

  /// How many leaves are on screen. For tests.
  int get count => _leaves.length;

  @override
  void initState() {
    super.initState();
    _seenGeneration = widget.controller.generation;
    widget.controller.addListener(_changed);
  }

  @override
  void didUpdateWidget(FallingLeaves oldWidget) {
    final old = oldWidget;
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      old.controller.removeListener(_changed);
      widget.controller.addListener(_changed);
    }
    if (old.seed != widget.seed) _random = math.Random(widget.seed);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_changed);
    _ticker.dispose();
    _frame.dispose();
    super.dispose();
  }

  bool get _still => MediaQuery.maybeDisableAnimationsOf(context) ?? false;

  void _changed() {
    if (!mounted || _still) return;
    final c = widget.controller;

    // Pulled past the line: the mark lets go of a leaf or two, a hint of
    // what releasing will do.
    if (c.phase == FeedRefreshPhase.pulling && c.armed && !_shedThisPull) {
      _shedThisPull = true;
      for (var i = 0; i < 2; i++) {
        _add(_Leaf.shed(_random, widget.origin, gentle: true));
      }
    }
    if (c.phase == FeedRefreshPhase.idle) _shedThisPull = false;

    // A new refresh: a gust. A handful burst from the mark, then the rain
    // takes over in _tick.
    if (c.generation != _seenGeneration) {
      _seenGeneration = c.generation;
      _shedThisPull = false;
      for (var i = 0; i < 9; i++) {
        _add(_Leaf.shed(_random, widget.origin, gentle: false));
      }
      final size = context.size ?? Size.zero;
      for (var i = 0; i < 6; i++) {
        _add(
          _Leaf.drift(
            _random,
            size.width,
            widget.top,
            at: widget.top + size.height * 0.45 * _random.nextDouble(),
          ),
        );
      }
    }

    // Done: the wind picks up and carries what is left away.
    if (_lastPhase == FeedRefreshPhase.refreshing &&
        c.phase != FeedRefreshPhase.refreshing) {
      for (final leaf in _leaves) {
        leaf.leaving ??= _clock;
      }
    }
    _lastPhase = c.phase;
  }

  void _add(_Leaf leaf) {
    if (_leaves.length >= FallingLeaves.maxLeaves) return;
    leaf.born = _clock;
    _leaves.add(leaf);
    if (!_ticker.isActive) {
      _last = Duration.zero;
      _ticker.start();
    }
  }

  void _tick(Duration elapsed) {
    final dt = math.min((elapsed - _last).inMicroseconds / 1e6, 0.05);
    _last = elapsed;
    _clock += dt;
    final size = context.size ?? Size.zero;

    // Rain across the width while the feed reloads, thickening over the
    // first second as a gust would rather than starting at full strength.
    if (widget.controller.phase == FeedRefreshPhase.refreshing) {
      final since = _clock - (_leaves.isEmpty ? _clock : _leaves.first.born);
      final rate = 4 + 6 * math.min(1.0, since);
      _spawnDebt += rate * dt;
      while (_spawnDebt >= 1) {
        _spawnDebt -= 1;
        _add(_Leaf.drift(_random, size.width, widget.top));
      }
    } else {
      _spawnDebt = 0;
    }

    for (final leaf in _leaves) {
      leaf.step(dt, _clock);
    }
    _leaves.removeWhere((leaf) => leaf.gone(_clock, size.height));

    _frame.value++;
    if (_leaves.isEmpty &&
        widget.controller.phase != FeedRefreshPhase.refreshing) {
      _ticker.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _LeavesPainter(_leaves, _frame, () => _clock),
          size: Size.infinite,
        ),
      ),
    );
  }
}

/// The autumn the video showed: deep crimson through scarlet and orange to
/// amber and gold, with the odd brown one that fell a week ago.
const List<Color> _autumn = [
  Color(0xFF8E1B16),
  Color(0xFFB3261E),
  Color(0xFFD2381F),
  Color(0xFFE5671C),
  Color(0xFFEE8A1E),
  Color(0xFFE9A823),
  Color(0xFFE8BE2C),
  Color(0xFF9A4A1C),
];

class _Leaf {
  _Leaf({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.colour,
    required this.depth,
    required this.fall,
    required this.swayAmp,
    required this.swayRate,
    required this.swayPhase,
    required this.spin,
    required this.turn,
    required this.flipRate,
    required this.flipPhase,
  });

  /// From the mark: thrown out sideways and a little up, as if the stem had
  /// snapped, then caught by the air.
  factory _Leaf.shed(math.Random r, Offset origin, {required bool gentle}) {
    final depth = 0.55 + 0.45 * r.nextDouble();
    final side = r.nextBool() ? 1 : -1;
    // Mostly sideways: thrown upwards they would fly into the status bar,
    // which is the one place they cannot be seen.
    final speed = gentle ? 40 + 50 * r.nextDouble() : 80 + 160 * r.nextDouble();
    final lift = gentle ? -10 - 25 * r.nextDouble() : -30 - 80 * r.nextDouble();
    return _Leaf._random(
      r,
      depth: depth,
      x: origin.dx + side * 6 * r.nextDouble(),
      y: origin.dy,
      vx: side * speed,
      vy: lift,
    );
  }

  /// From above the top edge, anywhere across it -- or, for the first gust,
  /// already in the air somewhere below it, so the screen fills at once
  /// rather than waiting for the first leaves to arrive from the top.
  factory _Leaf.drift(
    math.Random r,
    double width,
    double top, {
    double? at,
  }) {
    // A few large and near, most small and far: that spread is what makes
    // a flat screen read as air with depth in it.
    final depth = math.pow(r.nextDouble(), 1.6).toDouble();
    return _Leaf._random(
      r,
      depth: depth,
      x: -20 + (width + 40) * r.nextDouble(),
      y: at ?? top - 24,
      vx: (r.nextDouble() - 0.35) * 30,
      vy: 40,
    );
  }

  factory _Leaf._random(
    math.Random r, {
    required double depth,
    required double x,
    required double y,
    required double vx,
    required double vy,
  }) {
    return _Leaf(
      x: x,
      y: y,
      vx: vx,
      vy: vy,
      depth: depth,
      size: lerpDouble(10, 26, depth)! * (0.9 + 0.2 * r.nextDouble()),
      // Fast enough to cross a phone in two or three seconds, so a refresh
      // shows leaves falling through the feed and not just hanging in the
      // bar. Near ones fall faster, which is most of the sense of depth.
      fall: lerpDouble(150, 320, depth)! * (0.85 + 0.3 * r.nextDouble()),
      colour: _autumn[r.nextInt(_autumn.length)],
      swayAmp: lerpDouble(18, 58, r.nextDouble())!,
      swayRate: lerpDouble(0.55, 1.35, r.nextDouble())!,
      swayPhase: r.nextDouble() * 2 * math.pi,
      spin: (r.nextDouble() - 0.5) * 2.2,
      turn: r.nextDouble() * 2 * math.pi,
      flipRate: lerpDouble(0.5, 1.6, r.nextDouble())!,
      flipPhase: r.nextDouble() * 2 * math.pi,
    );
  }

  double x, y, vx, vy;
  final double size, depth, fall;
  final Color colour;
  final double swayAmp, swayRate, swayPhase, spin, flipRate, flipPhase;
  double turn;
  double born = 0;
  double? leaving;

  // Drawn values, worked out in step().
  double drawX = 0, drawY = 0, angle = 0, flip = 1, alpha = 0;

  void step(double dt, double now) {
    final age = now - born;
    final hurry = leaving == null ? 1.0 : 1.5;

    // Edge on, a leaf slices down; face down, it floats. Tying the fall to
    // the flip is most of what makes these look like leaves and not confetti.
    final phase = flipPhase + flipRate * 2 * math.pi * age;
    flip = math.cos(phase);
    final terminal = fall * (0.7 + 0.6 * (1 - flip.abs())) * hurry;

    // Air takes the throw out of a shed leaf quickly; gravity hands it to
    // the terminal speed less quickly.
    vx *= math.exp(-2.4 * dt);
    vy += (terminal - vy) * math.min(1.0, 2.2 * dt);
    x += vx * dt;
    y += vy * dt;

    // The sway comes in as the throw dies away, and the leaf rocks with it:
    // tilted into the direction it is drifting, as a falling leaf is.
    final settle = math.min(1.0, age / 0.9);
    final w = swayRate * 2 * math.pi;
    final sway = math.sin(swayPhase + w * age);
    drawX = x + swayAmp * settle * sway;
    drawY = y;
    turn += spin * dt;
    angle = turn + 0.6 * settle * math.cos(swayPhase + w * age);

    final fadeIn = math.min(1.0, age / 0.25);
    final fadeOut = leaving == null
        ? 1.0
        : (1 - (now - leaving!) / _fadeOut).clamp(0.0, 1.0);
    alpha = lerpDouble(0.7, 1.0, depth)! * fadeIn * fadeOut;
  }

  bool gone(double now, double height) =>
      drawY - size > height + 8 ||
      (leaving != null && now - leaving! >= _fadeOut);

  /// How long the last leaves take to go once the feed has landed.
  static const double _fadeOut = 1.4;
}

class _LeavesPainter extends CustomPainter {
  _LeavesPainter(this.leaves, Listenable frame, this.clock)
      : super(repaint: frame);

  final List<_Leaf> leaves;
  final double Function() clock;

  /// A maple leaf a unit tall, centred on its middle, stem down. Measured
  /// against the Kyron mark so the leaves read as its family: five lobes,
  /// the middle one tallest, the lower two swept back.
  static final Path _leaf = _buildLeaf();
  static final Path _veins = _buildVeins();

  static const List<(double, double)> _outline = [
    (0.00, -1.00),
    (0.10, -0.64),
    (0.30, -0.80),
    (0.25, -0.38),
    (0.60, -0.58),
    (0.53, -0.30),
    (0.96, -0.30),
    (0.72, -0.08),
    (0.86, 0.06),
    (0.46, 0.07),
    (0.55, 0.28),
    (0.14, 0.15),
    (0.05, 0.42),
    (0.03, 0.42),
    (0.025, 0.74),
  ];

  static Path _buildLeaf() {
    final path = Path();
    final right = _outline;
    final left = [for (final (x, y) in right.reversed) (-x, y)];
    final all = [...right, ...left];
    path.moveTo(all.first.$1 * 0.5, all.first.$2 * 0.5);
    for (final (x, y) in all.skip(1)) {
      path.lineTo(x * 0.5, y * 0.5);
    }
    path.close();
    return path;
  }

  static Path _buildVeins() {
    final path = Path();
    const base = (0.0, 0.25);
    for (final (x, y) in [
      (0.0, -0.9),
      (0.5, -0.5),
      (-0.5, -0.5),
      (0.82, -0.22),
      (-0.82, -0.22),
    ]) {
      path.moveTo(base.$1 * 0.5, base.$2 * 0.5);
      path.lineTo(x * 0.5, y * 0.5);
    }
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (leaves.isEmpty) return;
    final fill = Paint()..isAntiAlias = true;
    final vein = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Far leaves first, so near ones pass in front of them.
    final ordered = [...leaves]..sort((a, b) => a.depth.compareTo(b.depth));
    for (final leaf in ordered) {
      if (leaf.alpha <= 0.01) continue;
      // The back of a leaf is paler and duller than its face.
      final back = leaf.flip < 0;
      final base = back
          ? Color.lerp(leaf.colour, const Color(0xFF6B4A2A), 0.32)!
          : leaf.colour;
      // A leaf seen edge-on is a sliver, and it catches less light.
      final light = 0.78 + 0.22 * leaf.flip.abs();
      fill.color = Color.lerp(const Color(0xFF000000), base, light)!
          .withValues(alpha: leaf.alpha);

      canvas.save();
      canvas.translate(leaf.drawX, leaf.drawY);
      canvas.rotate(leaf.angle);
      // Never quite zero across: a leaf has thickness, and a zero scale
      // makes a degenerate path that some backends draw as a hairline.
      final across = math.max(0.06, leaf.flip.abs()) * leaf.size;
      canvas.scale(across, leaf.size);
      canvas.drawPath(_leaf, fill);
      if (leaf.size * leaf.flip.abs() > 11) {
        vein
          ..strokeWidth = 1.1 / leaf.size
          ..color = Color.lerp(base, const Color(0xFF3A0E06), 0.35)!
              .withValues(alpha: leaf.alpha * 0.55);
        canvas.drawPath(_veins, vein);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_LeavesPainter old) => old.leaves != leaves;
}
