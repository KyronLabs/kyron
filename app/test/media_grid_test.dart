import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/widgets/media_grid.dart';

/// How many tiles a grid draws, and what it says about the rest.
///
/// At most three, everywhere: four photos made a wall in a narrow bubble and
/// came out narrower than the text under a post. The rest are folded into
/// the third tile, darkened, with "+n" -- and that tile opens all of them.
List<PostMedia> _photos(int count) => [
      for (var i = 0; i < count; i++)
        PostMedia(
          id: 'p$i',
          kind: MediaKind.image,
          url: 'https://example.invalid/$i.jpg',
          width: 800,
          height: 600,
        ),
    ];

class _Pushes extends NavigatorObserver {
  int count = 0;
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) => count++;
}

Future<_Pushes> _draw(WidgetTester tester, Widget grid) async {
  final pushes = _Pushes();
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        navigatorObservers: [pushes],
        home: Scaffold(body: SizedBox(width: 300, child: grid)),
      ),
    ),
  );
  pushes.count = 0;
  return pushes;
}

int _tiles(WidgetTester tester) => find.byType(Image).evaluate().length;

void main() {
  testWidgets('three at most, with the rest counted on the third',
      (tester) async {
    await _draw(tester, MediaGrid(media: _photos(5)));

    expect(_tiles(tester), 3);
    expect(find.text('+2'), findsOneWidget);
    // On the bottom right: the last tile drawn.
    final plus = tester.getCenter(find.text('+2'));
    final grid = tester.getRect(find.byType(MediaGrid));
    expect(plus.dx, greaterThan(grid.center.dx));
    expect(plus.dy, greaterThan(grid.center.dy));
  });

  testWidgets('four in a chat is three and "+1"', (tester) async {
    await _draw(tester, MediaGrid(media: _photos(4)));

    expect(_tiles(tester), 3);
    expect(find.text('+1'), findsOneWidget);
  });

  testWidgets('three that fit say nothing about more', (tester) async {
    await _draw(tester, MediaGrid(media: _photos(3)));

    expect(_tiles(tester), 3);
    expect(find.textContaining('+'), findsNothing);
  });

  testWidgets('ten, the most a post carries, is three and "+7"',
      (tester) async {
    await _draw(tester, MediaGrid(media: _photos(10)));

    expect(_tiles(tester), 3);
    expect(find.text('+7'), findsOneWidget);
  });

  testWidgets('the tiles fill the width they are given', (tester) async {
    // The old square of four reused the 16:9 row inside it, so each row
    // shrank and centred itself: narrower than the post, short of the
    // rounded corners.
    for (final count in [2, 3, 4, 7]) {
      await _draw(tester, MediaGrid(media: _photos(count)));
      final grid = tester.getRect(find.byType(MediaGrid));
      final images = find.byType(Image).evaluate().map(
            (e) => tester.getRect(find.byWidget(e.widget)),
          );
      final left = images.map((r) => r.left).reduce((a, b) => a < b ? a : b);
      final right = images.map((r) => r.right).reduce((a, b) => a > b ? a : b);
      expect(left, closeTo(grid.left, 0.5), reason: '$count: left edge');
      expect(right, closeTo(grid.right, 0.5), reason: '$count: right edge');
    }
  });

  testWidgets('the counted tile opens the rest', (tester) async {
    final pushes = await _draw(
      tester,
      MediaGrid(media: _photos(6)),
    );

    // The count itself lets taps through to the tile under it, which is what
    // answers them; so the tap lands where the count is drawn.
    await tester.tapAt(tester.getCenter(find.text('+3')));
    await tester.pump();

    expect(pushes.count, 1);
  });
}
