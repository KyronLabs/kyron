import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/widgets/edit_post_sheet.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// A tool, not a test: draws the edit-post sheet, light and dark, as it
/// opens and once the words have changed, to PNGs.
///
///     flutter test test/render_edit_sheet.dart --dart-define=shots=/tmp/x
const out = String.fromEnvironment('shots', defaultValue: '/tmp/kyron-shots');

void main() {
  testWidgets('render', (tester) async {
    Directory(out).createSync(recursive: true);
    for (final family in ['Inter', 'Roboto']) {
      final loader = FontLoader(family);
      for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold']) {
        loader.addFont(rootBundle.load('assets/fonts/Inter-$weight.ttf'));
      }
      await loader.load();
    }

    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 640);
    addTearDown(tester.view.reset);

    final post = FeedPost(
      id: 'p1',
      content: 'The most dangerous form of blindness, is believing that your '
          'perspective is the only reality.\n\n— Friedrich Nietzsche',
      createdAt: DateTime.now(),
      author: FeedAuthor.fromJson(const {'id': 'g', 'name': 'Gremlin'}),
    );

    // Not pumpAndSettle: the sheet focuses its field, and a blinking cursor
    // never settles. Frame by frame instead -- one long pump draws every
    // animation at its first frame, the sheet still below the screen and
    // Save's label still its disabled grey.
    Future<void> shoot(String name) async {
      for (var i = 0; i < 30; i++) {
        await tester.pump(const Duration(milliseconds: 32));
      }
      final boundary = tester.renderObject<RenderRepaintBoundary>(
        find.byType(RepaintBoundary).first,
      );
      final bytes = await tester.runAsync(() async {
        final image = await boundary.toImage(pixelRatio: 2);
        final data = await image.toByteData(format: ui.ImageByteFormat.png);
        image.dispose();
        return data!.buffer.asUint8List();
      });
      File('$out/$name.png').writeAsBytesSync(bytes!);
    }

    for (final dark in [false, true]) {
      await tester.pumpWidget(
        RepaintBoundary(
          child: ProviderScope(
            child: MaterialApp(
              key: ValueKey(dark),
              debugShowCheckedModeBanner: false,
              theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
              home: Builder(
                builder: (context) => Scaffold(
                  body: Center(
                    child: TextButton(
                      onPressed: () => EditPostSheet.show(context, post),
                      child: const Text('open'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      final mode = dark ? 'dark' : 'light';
      await shoot('edit-sheet-$mode');
      await tester.enterText(
        find.byKey(const ValueKey('edit-post-field')),
        '${post.content}\n\nRead it twice.',
      );
      await shoot('edit-sheet-changed-$mode');
    }
    exit(0);
  });
}
