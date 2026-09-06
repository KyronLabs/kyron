// lib/widgets/thread.dart
//
// The shape of a threaded conversation: one row per comment, with the rails
// and elbows on the left that say which reply answers which.
//
// A thread row is three columns of one row:
//
//   ┌────────┬──────────────────────────────────────────┬───────┐
//   │ avatar │ name · time                              │  ···  │
//   │   │    │ body                                     │       │
//   │   │    │ ♡ n   💬 n                               │       │
//   │   ●    │ (rail continues to the next sibling)     │       │
//   └────────┴──────────────────────────────────────────┴───────┘
//
// The left rail -- the line running down from an avatar to the replies under
// it -- is what makes a conversation read as one thread rather than a list of
// separate cards, and it is the part every quick implementation leaves out.
//
// Ported from the news thread in Omnia-Wallet, which is where the geometry was
// worked out; the comments there explain the cases that are easy to get wrong
// and impossible to see in a smoke test.
import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart';

import 'hairline.dart';

/// Geometry shared by the connectors, so the painter and the widgets laid out
/// around it cannot drift apart.
class ThreadGeometry {
  ThreadGeometry._();

  /// How far each nesting level indents. Also how far an elbow travels
  /// sideways, so the curve keeps its proportions at any depth.
  static const double indent = 28;

  /// Rail thickness. Deliberately 2: a 1-pixel line is indistinguishable from
  /// the hairlines between rows and stops reading as a connector at all.
  static const double thickness = 2;

  /// Radius of the elbow's corner, about half the indent, which is what makes
  /// the turn read as a quarter circle rather than a clipped corner.
  static const double corner = 11;

  /// Deepest level that still indents. Past this replies keep threading but
  /// stop marching rightward, or a long argument runs out of screen.
  static const int maxIndent = 4;

  /// The avatar size every rail column is measured from.
  ///
  /// Columns belong to the thread, not to the row being painted. A row with a
  /// smaller leading element -- the stacked faces of a "show replies" marker
  /// -- still has to put its rails in the same columns as the rows above and
  /// below it. Measuring from that row's own size drew them several points to
  /// the left: a line beside the thread rather than a continuation of it.
  static const double avatar = 34;

  static double indentFor(int depth) => indent * depth.clamp(0, maxIndent);

  /// Centre of the rail column at [depth]. Every row agrees on this.
  static double columnFor(int depth) => indentFor(depth) + avatar / 2;
}

/// The quarter circle turning out of a parent's rail into a reply's avatar.
///
/// This is the piece that says "this answers the thing above". Without the
/// turn, a nested reply reads as a new top-level comment that happens to be
/// indented.
class ThreadElbow {
  final double x;
  final double turnY;
  final double endX;
  final double radius;

  const ThreadElbow({
    required this.x,
    required this.turnY,
    required this.endX,
    required this.radius,
  });

  Path toPath() => Path()
    ..moveTo(x, 0)
    ..lineTo(x, turnY - radius)
    ..arcToPoint(
      Offset(x + radius, turnY),
      radius: Radius.circular(radius),
      clockwise: false,
    )
    ..lineTo(endX, turnY);

  @override
  bool operator ==(Object other) =>
      other is ThreadElbow &&
      other.x == x &&
      other.turnY == turnY &&
      other.endX == endX &&
      other.radius == radius;

  @override
  int get hashCode => Object.hash(x, turnY, endX, radius);
}

/// Everything drawn in one row's connector strip, worked out before anything
/// is painted.
///
/// Separating the geometry from the painting is what makes it testable: a
/// connector that runs to the wrong place still paints without complaint, so
/// the only way to catch it is to assert on the numbers.
class ThreadConnectorPlan {
  /// Full-height verticals for ancestors whose threads continue past this row.
  final List<double> railXs;

  /// The turn out of the immediate parent, or null at top level.
  final ThreadElbow? elbow;

  /// The parent's rail carrying on below this row. Set only for a middle
  /// child, since the last child is where a parent's thread ends.
  final double? parentRailBelowX;

  /// This row's own rail, drawn only when replies are rendered beneath it.
  /// Null for a childless comment -- otherwise two unrelated comments end up
  /// stitched together by a rail belonging to neither.
  final double? ownRailX;

  /// Where that rail starts: just under the avatar, not at its centre.
  final double ownRailTop;

  const ThreadConnectorPlan({
    required this.railXs,
    required this.elbow,
    required this.parentRailBelowX,
    required this.ownRailX,
    required this.ownRailTop,
  });

  static ThreadConnectorPlan forRow({
    required int depth,
    required List<bool> ancestorRails,
    required bool hasChildrenBelow,
    required bool isLastChild,
    required double avatarSize,
    double topGap = 0,
  }) {
    const centreOf = ThreadGeometry.columnFor;
    final turnY = topGap + avatarSize / 2;
    final ownLeft = ThreadGeometry.indentFor(depth);

    // `ancestorRails[level]` says the ancestor at `level` has a later sibling.
    // That sibling is drawn one step further left than the ancestor is,
    // because its own elbow starts from *its* parent's column -- so the rail
    // running down to meet it belongs at `centreOf(level - 1)`.
    //
    // A column too far right showed as a line hanging under a reply's avatar
    // and running down to that reply's aunt, as though the two were related.
    // Index 0 is never drawn: a later sibling of a top-level comment has no
    // elbow at all, because top-level comments are separate conversations.
    //
    // De-duplicated and kept left of this row's avatar: past maxIndent several
    // levels resolve to one column, and the deepest would be painted over the
    // avatar, repeatedly.
    final rails = <double>{
      for (var level = 1; level < depth; level++)
        if (level < ancestorRails.length && ancestorRails[level])
          if (centreOf(level - 1) < ownLeft) centreOf(level - 1),
    }.toList();

    ThreadElbow? elbow;
    double? parentBelow;
    if (depth > 0) {
      final parentX = centreOf(depth - 1);
      // Past the indent cap the parent sits in the same column as the child,
      // so there is no gap for an elbow to cross. Drawing one anyway hooks out
      // to the right and back left through the avatar; the parent's own rail
      // already runs into this row, and a straight thread is what a depth cap
      // is supposed to look like.
      if (ownLeft > parentX) {
        // Never let the corner exceed the space available, or the arc inverts.
        final radius = ThreadGeometry.corner
            .clamp(0.0, ownLeft - parentX)
            .clamp(0.0, turnY)
            .toDouble();
        elbow = ThreadElbow(
          x: parentX,
          turnY: turnY,
          endX: ownLeft,
          radius: radius,
        );
        if (!isLastChild) parentBelow = parentX;
      }
    }

    return ThreadConnectorPlan(
      railXs: List.unmodifiable(rails),
      elbow: elbow,
      parentRailBelowX: parentBelow,
      ownRailX: hasChildrenBelow ? centreOf(depth) : null,
      ownRailTop: topGap + avatarSize + 4,
    );
  }
}

/// Draws the rails and elbows to the left of one thread row.
class ThreadConnectorPainter extends CustomPainter {
  final int depth;

  /// Per ancestor level (0 … depth-1): does that ancestor have a later
  /// sibling, so its rail passes this row rather than ending above it?
  final List<bool> ancestorRails;

  final bool hasChildrenBelow;

  /// Whether this row is its parent's last child. If so the parent's rail
  /// terminates in this row's elbow instead of carrying on down.
  final bool isLastChild;

  final double avatarSize;
  final Color color;

  /// Blank space above this row's leading element that the strip still covers.
  final double topGap;

  const ThreadConnectorPainter({
    required this.depth,
    required this.ancestorRails,
    required this.hasChildrenBelow,
    required this.isLastChild,
    required this.avatarSize,
    required this.color,
    this.topGap = 0,
  });

  ThreadConnectorPlan get plan => ThreadConnectorPlan.forRow(
        depth: depth,
        ancestorRails: ancestorRails,
        hasChildrenBelow: hasChildrenBelow,
        isLastChild: isLastChild,
        avatarSize: avatarSize,
        topGap: topGap,
      );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = ThreadGeometry.thickness
      ..strokeCap = StrokeCap.round;

    final p = plan;

    for (final x in p.railXs) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    final elbow = p.elbow;
    if (elbow != null) canvas.drawPath(elbow.toPath(), paint);

    final below = p.parentRailBelowX;
    if (below != null) {
      // Full height, not from the turn down. This rail is set only when the
      // parent has another answer still to come, so it runs straight past the
      // row -- and by the height of the turn the elbow's arc has curved out of
      // this column, leaving a notch the size of the corner radius in a line
      // meant to be unbroken. Overlapping the elbow's vertical costs nothing:
      // same colour, same column.
      canvas.drawLine(Offset(below, 0), Offset(below, size.height), paint);
    }

    final own = p.ownRailX;
    if (own != null) {
      canvas.drawLine(
        Offset(own, p.ownRailTop),
        Offset(own, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(ThreadConnectorPainter old) =>
      old.depth != depth ||
      old.hasChildrenBelow != hasChildrenBelow ||
      old.isLastChild != isLastChild ||
      old.avatarSize != avatarSize ||
      old.topGap != topGap ||
      old.color != color ||
      !listEquals(old.ancestorRails, ancestorRails);
}

/// One row of a thread: connectors and avatar on the left, content on the
/// right.
///
/// The connector strip is painted behind the row rather than laid out beside
/// it, so an elbow can reach across the gutter into the avatar without any
/// widget having to know the geometry.
class ThreadItem extends StatelessWidget {
  final int depth;
  final List<bool> ancestorRails;
  final bool hasChildrenBelow;
  final bool isLastChild;
  final Widget avatar;
  final Widget child;

  /// Height of the leading slot, and what the elbow turns into: the connector
  /// arrives at its vertical centre.
  final double avatarSize;

  /// Width of that slot when it is not square -- a row of overlapping faces is
  /// wider than one avatar but should still be met at the same place.
  final double? avatarWidth;

  /// Breathing room above the row, given to the row rather than taken as an
  /// outer Padding.
  ///
  /// The distinction is the whole point: an outer padding leaves a band the
  /// connector strip does not cover, and every ancestor rail crossing it comes
  /// out dashed -- one gap per row boundary, all the way down. Handing the gap
  /// to the row lets the strip paint full height while the elbow shifts down
  /// to stay on the avatar.
  final double topGap;

  const ThreadItem({
    super.key,
    required this.depth,
    required this.ancestorRails,
    required this.hasChildrenBelow,
    required this.isLastChild,
    required this.avatar,
    required this.child,
    this.avatarSize = ThreadGeometry.avatar,
    this.avatarWidth,
    this.topGap = 0,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final indent = ThreadGeometry.indentFor(depth);

    return IntrinsicHeight(
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: ThreadConnectorPainter(
                depth: depth,
                ancestorRails: ancestorRails,
                hasChildrenBelow: hasChildrenBelow,
                isLastChild: isLastChild,
                avatarSize: avatarSize,
                topGap: topGap,
                color: scheme.outline.withValues(alpha: 0.28),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: indent, top: topGap),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: avatarWidth ?? avatarSize,
                  height: avatarSize,
                  child: avatar,
                ),
                const SizedBox(width: 10),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The line under a top-level comment and the whole branch beneath it.
///
/// Drawn between conversations rather than between rows: a hairline inside a
/// thread would compete with the rails and cut the branch into pieces.
class ThreadDivider extends StatelessWidget {
  const ThreadDivider({super.key});

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Hairline(),
      );
}
