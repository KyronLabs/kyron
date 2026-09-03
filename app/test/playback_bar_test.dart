import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/playback_bar.dart';

const _total = Duration(seconds: 100);

/// Puts a bar exactly 300 logical pixels wide on screen, so a tap at x reads
/// as x/300 of the clip.
Future<List<Duration>> _pump(
  WidgetTester tester, {
  Duration position = Duration.zero,
  Duration buffered = Duration.zero,
  Duration total = _total,
}) async {
  final seeks = <Duration>[];
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 300,
            child: PlaybackBar(
              position: position,
              buffered: buffered,
              total: total,
              onSeek: seeks.add,
            ),
          ),
        ),
      ),
    ),
  );
  return seeks;
}

/// The x on screen for a fraction along the bar.
double _x(WidgetTester tester, double fraction) {
  final box = tester.getRect(find.byType(PlaybackBar));
  return box.left + box.width * fraction;
}

void main() {
  testWidgets('a tap seeks to where it landed', (tester) async {
    final seeks = await _pump(tester);

    final centre = tester.getCenter(find.byType(PlaybackBar));
    await tester.tapAt(Offset(_x(tester, 0.25), centre.dy));
    await tester.pump();

    expect(seeks, hasLength(1));
    expect(seeks.single.inSeconds, 25);
  });

  testWidgets('a tap at the very start seeks to the start', (tester) async {
    final seeks = await _pump(tester, position: const Duration(seconds: 50));

    final centre = tester.getCenter(find.byType(PlaybackBar));
    await tester.tapAt(Offset(_x(tester, 0), centre.dy));
    await tester.pump();

    expect(seeks.single, Duration.zero);
  });

  testWidgets('a drag seeks once, when it is let go', (tester) async {
    // The bar follows the finger while it is down; seeking on every frame of
    // a drag asks the player to jump around while somebody is still choosing.
    final seeks = await _pump(tester);
    final centre = tester.getCenter(find.byType(PlaybackBar));

    final gesture = await tester.startGesture(
      Offset(_x(tester, 0.1), centre.dy),
    );
    await tester.pump();
    await gesture.moveTo(Offset(_x(tester, 0.4), centre.dy));
    await tester.pump();
    await gesture.moveTo(Offset(_x(tester, 0.8), centre.dy));
    await tester.pump();
    expect(seeks, isEmpty, reason: 'nothing while the finger is down');

    await gesture.up();
    await tester.pump();

    expect(seeks, hasLength(1));
    expect(seeks.single.inSeconds, 80);
  });

  testWidgets('dragging past the end stops at the end', (tester) async {
    final seeks = await _pump(tester);
    final centre = tester.getCenter(find.byType(PlaybackBar));

    final gesture = await tester.startGesture(
      Offset(_x(tester, 0.5), centre.dy),
    );
    await tester.pump();
    await gesture.moveTo(Offset(_x(tester, 1.9), centre.dy));
    await tester.pump();
    await gesture.up();
    await tester.pump();

    expect(seeks.single, _total);
  });

  testWidgets('a clip with no duration yet does not divide by zero',
      (tester) async {
    final seeks = await _pump(tester, total: Duration.zero);

    final centre = tester.getCenter(find.byType(PlaybackBar));
    await tester.tapAt(Offset(_x(tester, 0.5), centre.dy));
    await tester.pump();

    expect(seeks.single, Duration.zero);
    expect(tester.takeException(), isNull);
  });

  testWidgets('is tall enough for a thumb, whatever the bar looks like',
      (tester) async {
    // The bar it draws is four pixels; what you have to hit is not.
    await _pump(tester);
    expect(
      tester.getSize(find.byType(PlaybackBar)).height,
      greaterThanOrEqualTo(24),
    );
  });

  testWidgets('draws without complaint at every stage of a clip',
      (tester) async {
    for (final at in [0, 1, 50, 99, 100]) {
      await _pump(
        tester,
        position: Duration(seconds: at),
        buffered: Duration(seconds: (at + 20).clamp(0, 100)),
      );
      await tester.pump();
      expect(tester.takeException(), isNull, reason: 'at $at seconds');
    }
  });
}
