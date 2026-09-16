// lib/utils/clip_page_physics.dart
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Page snapping for a screen where one page is the whole screen.
///
/// [PageScrollPhysics] commits to the next page on any flick, or once a drag
/// without one has passed halfway. Half a page is a sensible ask when a page is
/// a panel in a carousel; when a page is the entire screen it is four hundred
/// pixels of thumb travel, and swiping to the next clip becomes a shove. The
/// apps this is measured against -- TikTok, Shorts, Reels -- commit within the
/// first inch and settle immediately.
///
/// The three things changed, and nothing else:
///  * a drag counts as a flick sooner ([minFlingVelocity], [minFlingDistance]),
///  * a drag that is not a flick commits after [commitFraction] of a page
///    rather than half of one,
///  * the settle is a stiff spring rather than the drifting default.
class ClipPageScrollPhysics extends ScrollPhysics {
  const ClipPageScrollPhysics({super.parent});

  /// How far into a page a drag has to travel before letting go moves on
  /// rather than snapping back. A sixth of the screen: far enough that resting
  /// a thumb on a clip does not move it, short enough to be one flick.
  static const double commitFraction = 0.16;

  @override
  ClipPageScrollPhysics applyTo(ScrollPhysics? ancestor) =>
      ClipPageScrollPhysics(parent: buildParent(ancestor));

  /// The velocity below which a drag is not treated as a flick at all, and
  /// [commitFraction] alone decides. The stock 50px/s is a deliberate shove;
  /// a clip is swiped with the side of the thumb.
  @override
  double get minFlingVelocity => 20;

  /// How far the finger has to have moved, over the window the velocity is
  /// measured across, for the same. The stock value is the touch slop, which
  /// is already spent getting the drag started.
  @override
  double get minFlingDistance => 8;

  /// Stiff, and a hair over critically damped: it arrives quickly and does not
  /// bounce the next clip when it gets there. The default spring is tuned for
  /// a list settling a few pixels; asked to cross a whole screen it drifts in
  /// over about half a second, which is most of what makes the swipe feel
  /// heavy.
  static final SpringDescription _spring = SpringDescription.withDampingRatio(
    mass: 0.4,
    stiffness: 260,
    ratio: 1.05,
  );

  @override
  SpringDescription get spring => _spring;

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    // Out of range and not heading back: the parent's ballistics put it back
    // in range, which is where the platform's overscroll lives.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }

    final tolerance = toleranceFor(position);
    final target = targetPixels(position, velocity);
    if ((target - position.pixels).abs() < tolerance.distance) return null;
    return ScrollSpringSimulation(
      spring,
      position.pixels,
      target,
      velocity,
      tolerance: tolerance,
    );
  }

  /// Where the page settles when the finger leaves at [velocity].
  ///
  /// Separate from [createBallisticSimulation] so the thresholds can be read
  /// off without running a gesture.
  double targetPixels(ScrollMetrics position, double velocity) {
    final extent = position.viewportDimension;
    if (extent <= 0) return position.pixels;

    final page = position.pixels / extent;
    final tolerance = toleranceFor(position);

    final double target;
    if (velocity > tolerance.velocity) {
      // Flicked towards the next page. One page, however hard: the clip after
      // the next one is a clip nobody has looked at.
      target = page.floorToDouble() + 1;
    } else if (velocity < -tolerance.velocity) {
      target = page.ceilToDouble() - 1;
    } else {
      // Let go rather than flicked. Which page this started from is not in the
      // metrics, but the scroll position knows which way the finger was going,
      // and it has not been cleared yet when this is asked.
      final from = switch (_direction(position)) {
        ScrollDirection.reverse => page.floorToDouble(),
        ScrollDirection.forward => page.ceilToDouble(),
        ScrollDirection.idle => page.roundToDouble(),
      };
      final travelled = page - from;
      target = travelled.abs() >= commitFraction ? from + travelled.sign : from;
    }

    return (target * extent).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );
  }

  /// Which way the finger was moving the content.
  ///
  /// [ScrollMetrics] does not carry it, but what is handed to the physics at
  /// the end of a drag is the live [ScrollPosition], which does.
  static ScrollDirection _direction(ScrollMetrics position) =>
      position is ScrollPosition
          ? position.userScrollDirection
          : ScrollDirection.idle;
}
