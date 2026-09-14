import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/squircle.dart';

/// How far the outline reaches along the 45-degree diagonal, as a fraction of
/// the distance from the centre to the corner of the box.
///
/// This one number separates the three shapes: a circle inscribed in a square
/// reaches 0.707, the square itself reaches 1.0, and a squircle sits between.
double _diagonalReach(Path path, double side) {
  final corner = Offset(side, side);
  final centre = Offset(side / 2, side / 2);
  var low = 0.0;
  var high = 1.0;
  // Bisection: these outlines are convex, so "inside" is monotonic along the
  // ray out of the centre.
  for (var i = 0; i < 40; i++) {
    final mid = (low + high) / 2;
    if (path.contains(Offset.lerp(centre, corner, mid)!)) {
      low = mid;
    } else {
      high = mid;
    }
  }
  return low;
}

Path _squircle(double side) =>
    SquircleShape.borderFor(side).getOuterPath(Rect.fromLTWH(0, 0, side, side));

void main() {
  group('SquircleShape', () {
    test('is a squircle, not a rounded rectangle', () {
      const side = 100.0;
      const box = Rect.fromLTWH(0, 0, side, side);
      final squircle = _squircle(side);

      // Compared against the rounded rectangle that reaches exactly as far
      // along the diagonal, so the two are the same size and the only thing
      // left to differ is the curve itself.
      final matched = _roundedMatchedAtDiagonal(
        box,
        _diagonalReach(squircle, side),
      );

      // Twenty-five degrees off the horizontal: the rounded rectangle is
      // still perfectly straight here -- its edge is a line until the arc
      // begins -- and the squircle has already started to curve away. That
      // is the shape's whole definition: curvature spread along the edge
      // rather than nothing and then an arc.
      expect(_reachAt(matched, box, 25), closeTo(1.0, 0.001));
      expect(_reachAt(squircle, box, 25), lessThan(0.997));

      // And it is not a circle: one reaches 0.707 along the diagonal.
      expect(_diagonalReach(squircle, side), greaterThan(0.8));
    });

    test('is the same shape at every size', () {
      // A fixed radius reads as a different shape at every size: gentle on a
      // 96-pixel tile, nearly a circle on a 24-pixel one. This is why the
      // radius is derived from the size rather than passed in.
      final small = _diagonalReach(_squircle(24), 24);
      final large = _diagonalReach(_squircle(96), 96);

      expect(small, closeTo(large, 0.02));
    });

    test('scales its radius with the tile', () {
      expect(SquircleShape.radiusFor(48), SquircleShape.radiusFor(24) * 2);
      expect(SquircleShape.radiusFor(0), 0);
    });

    test('stays inside its box', () {
      final bounds = _squircle(64).getBounds();

      expect(bounds.left, closeTo(0, 0.01));
      expect(bounds.top, closeTo(0, 0.01));
      expect(bounds.right, closeTo(64, 0.01));
      expect(bounds.bottom, closeTo(64, 0.01));
    });

    test('is symmetric in all four corners', () {
      const side = 100.0;
      final path = _squircle(side);

      // Just outside each corner. A shape built with the wrong signs in one
      // quadrant passes three of these and fails the fourth.
      for (final corner in [
        const Offset(1, 1),
        const Offset(side - 1, 1),
        const Offset(1, side - 1),
        const Offset(side - 1, side - 1),
      ]) {
        expect(path.contains(corner), isFalse, reason: 'outside at $corner');
      }
    });
  });

  testWidgets('Squircle clips what it is given, at the size it was told',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Squircle(size: 40, child: ColoredBox(color: Colors.red)),
          ),
        ),
      ),
    );

    expect(tester.getSize(find.byType(Squircle)), const Size(40, 40));

    final clipper = tester.widget<ClipPath>(find.byType(ClipPath)).clipper;
    expect(clipper, isA<ShapeBorderClipper>());
    expect(
      (clipper! as ShapeBorderClipper).shape,
      SquircleShape.borderFor(40),
    );
  });
}

/// How far [path] reaches along a ray leaving the centre of [box] at
/// [degrees], as a fraction of the distance to the box's own edge.
double _reachAt(Path path, Rect box, double degrees) {
  final angle = degrees * math.pi / 180;
  final centre = box.center;
  final dx = math.cos(angle);
  final dy = math.sin(angle);
  final t = math.min((box.width / 2) / dx.abs(), (box.height / 2) / dy.abs());
  final edge = centre + Offset(dx * t, dy * t);

  var low = 0.0;
  var high = 1.0;
  for (var i = 0; i < 40; i++) {
    final mid = (low + high) / 2;
    if (path.contains(Offset.lerp(centre, edge, mid)!)) {
      low = mid;
    } else {
      high = mid;
    }
  }
  return low;
}

/// The rounded rectangle in [box] whose diagonal reach is [target], so a
/// comparison against it is about the curve rather than the size.
Path _roundedMatchedAtDiagonal(Rect box, double target) {
  var low = 0.0;
  var high = box.shortestSide / 2;
  for (var i = 0; i < 40; i++) {
    final mid = (low + high) / 2;
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(box, Radius.circular(mid)));
    if (_reachAt(path, box, 45) > target) {
      low = mid;
    } else {
      high = mid;
    }
  }
  return Path()..addRRect(RRect.fromRectAndRadius(box, Radius.circular(low)));
}
