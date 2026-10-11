import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/widgets/media_viewer.dart';

/// The viewer's top bar and what it offers.
///
/// The count sat off to one side: one button on the left, two on the right,
/// and two spacers splitting what was left. And there was no way to keep a
/// photo -- copy link and share were unlabelled icons, saving was not there.
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

Future<void> _open(WidgetTester tester, {int count = 4, int at = 1}) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        home: MediaViewer(media: _photos(count), initialIndex: at),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('the count is at the centre of the bar', (tester) async {
    await _open(tester);

    expect(find.text('2 / 4'), findsOneWidget);
    final screen = tester.getSize(find.byType(MediaViewer)).width;
    expect(tester.getCenter(find.text('2 / 4')).dx, closeTo(screen / 2, 0.5));
  });

  testWidgets('one photo has no count', (tester) async {
    await _open(tester, count: 1, at: 0);

    expect(find.textContaining(' / '), findsNothing);
  });

  testWidgets('the more button offers saving, sharing and the link',
      (tester) async {
    await _open(tester);

    await tester.tap(find.byIcon(Iconsax.more_copy));
    await tester.pumpAndSettle();

    expect(find.text('Save to device'), findsOneWidget);
    expect(find.text('Share'), findsOneWidget);
    expect(find.text('Copy link'), findsOneWidget);
  });
}
