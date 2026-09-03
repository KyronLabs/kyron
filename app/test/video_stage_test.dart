import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/services/video_stage.dart';

/// The stage settles once per turn rather than once per report, so a scroll
/// that moves every clip on screen only recomputes once.
Future<void> _settle() => Future<void>.microtask(() {});

class _Clip {
  final String name;
  final List<bool> changes = [];

  _Clip(this.name);

  bool get playing => changes.isEmpty ? false : changes.last;

  void report(double fraction, double distance) => VideoStage.instance.report(
        this,
        visibleFraction: fraction,
        distance: distance,
        onChanged: changes.add,
      );

  void withdraw() => VideoStage.instance.withdraw(this);
}

void main() {
  setUp(VideoStage.instance.reset);

  test('plays nothing when nothing is on screen enough', () async {
    _Clip('a').report(0.2, 0);
    await _settle();

    expect(VideoStage.instance.active, isNull);
  });

  test('plays the one clip that is on screen', () async {
    final a = _Clip('a');
    a.report(0.9, 100);
    await _settle();

    expect(a.playing, isTrue);
  });

  test('plays only the most central of several', () async {
    // The complaint this fixes: three clips on screen, all of them started,
    // and the one arriving from the bottom stopping the one being watched.
    final top = _Clip('top');
    final middle = _Clip('middle');
    final bottom = _Clip('bottom');

    top.report(0.8, 400);
    middle.report(0.9, 20);
    bottom.report(0.7, 500);
    await _settle();

    expect(middle.playing, isTrue);
    expect(top.changes, isEmpty, reason: 'never told to play');
    expect(bottom.changes, isEmpty);
  });

  test('a clip arriving from the bottom does not steal the middle', () async {
    final middle = _Clip('middle');
    final bottom = _Clip('bottom');

    middle.report(0.95, 10);
    await _settle();
    expect(middle.playing, isTrue);

    // Scrolled a little: the bottom one is now well on screen, but further
    // from the middle than the clip already playing.
    middle.report(0.9, 60);
    bottom.report(0.8, 300);
    await _settle();

    expect(middle.playing, isTrue);
    expect(bottom.changes, isEmpty);
    expect(VideoStage.instance.active, same(middle));
  });

  test('hands over once the other clip is clearly more central', () async {
    final first = _Clip('first');
    final second = _Clip('second');

    first.report(0.9, 20);
    await _settle();

    first.report(0.7, 300);
    second.report(0.9, 15);
    await _settle();

    expect(first.playing, isFalse);
    expect(second.playing, isTrue);
  });

  test('does not trade the stage over a few pixels', () async {
    // Two clips almost equally central swap on every frame of a slow scroll
    // without a margin, which is worse than either of them playing.
    final a = _Clip('a');
    final b = _Clip('b');

    a.report(0.9, 100);
    await _settle();
    expect(a.playing, isTrue);

    for (var i = 0; i < 10; i++) {
      a.report(0.9, 100 + i.toDouble());
      b.report(0.9, 100 - i.toDouble());
      await _settle();
    }

    // b is 18 pixels closer at the end, inside the margin.
    expect(VideoStage.instance.active, same(a));
    expect(b.changes, isEmpty);
    expect(a.changes, [true], reason: 'told once, never toggled');
  });

  test('stops the clip that scrolls away and starts the next', () async {
    final a = _Clip('a');
    final b = _Clip('b');

    a.report(0.9, 20);
    b.report(0.9, 600);
    await _settle();
    expect(a.playing, isTrue);

    a.report(0.1, 700);
    b.report(0.9, 30);
    await _settle();

    expect(a.playing, isFalse);
    expect(b.playing, isTrue);
  });

  test('withdrawing the playing clip hands the stage on', () async {
    final a = _Clip('a');
    final b = _Clip('b');

    a.report(0.9, 20);
    b.report(0.9, 300);
    await _settle();
    expect(a.playing, isTrue);

    a.withdraw();
    await _settle();

    expect(VideoStage.instance.active, same(b));
    expect(b.playing, isTrue);
  });

  test('never has two clips playing across a handover', () async {
    final a = _Clip('a');
    final b = _Clip('b');

    a.report(0.9, 10);
    await _settle();

    a.report(0.6, 500);
    b.report(0.95, 10);
    await _settle();

    // The one losing the stage is stopped before the one taking it starts.
    expect(a.changes, [true, false]);
    expect(b.changes, [true]);
  });

  test('withdrawing something that was never reported is not an error', () {
    expect(() => VideoStage.instance.withdraw(Object()), returnsNormally);
  });
}
