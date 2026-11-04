import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/widgets/post_actions_row.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// A tool, not a test: draws the gifts on a post's heart, light and dark,
/// as the feed card lays the row out -- words above, 8pt, then the row -- so
/// what crowds what is in the shot.
///
///     flutter test test/render_gift_stack.dart --dart-define=shots=/tmp/x
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
    // The action icons are Iconsax glyphs: without the font they are boxes.
    final icons = FontLoader('packages/iconsax_flutter/FlutterIconsax');
    icons.addFont(
      rootBundle.load('packages/iconsax_flutter/fonts/FlutterIconsax.ttf'),
    );
    await icons.load();

    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 520);
    addTearDown(tester.view.reset);

    FeedPost post(List<String> gifts, {bool liked = false}) => FeedPost(
          id: 'p${gifts.length}',
          content: '',
          createdAt: DateTime(2026, 10, 30),
          author: FeedAuthor.fromJson(const {'id': 'ada', 'name': 'Ada'}),
          likes: 128,
          comments: 14,
          reposts: 3,
          liked: liked,
          topGifts: gifts,
        );

    Widget card(FeedPost p) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Golden hour on the harbour wall. Nobody else out, just the '
                'gulls and a very confused dog.',
              ),
              const SizedBox(height: SpacingTokens.space8),
              PostActionsRow(
                post: p,
                onReply: () {},
                onRepost: () {},
                onLike: () {},
                onSave: () {},
                onShare: () {},
              ),
            ],
          ),
        );

    for (final dark in [false, true]) {
      await tester.pumpWidget(
        RepaintBoundary(
          child: MaterialApp(
            key: ValueKey(dark),
            debugShowCheckedModeBanner: false,
            theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
            home: Scaffold(
              body: Column(
                children: [
                  card(post(const [])),
                  const Divider(height: 1),
                  card(post(const ['gem'])),
                  const Divider(height: 1),
                  card(post(const ['crown', 'rose'])),
                  const Divider(height: 1),
                  card(post(const ['rocket', 'gem', 'rose'], liked: true)),
                  const Divider(height: 1),
                  card(post(const ['crown', 'cake', 'fire'])),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.runAsync(() async {
        for (final element in find.byType(Image).evaluate()) {
          await precacheImage((element.widget as Image).image, element);
        }
      });
      await tester.pumpAndSettle();
      final boundary = tester.renderObject<RenderRepaintBoundary>(
        find.byType(RepaintBoundary).first,
      );
      final bytes = await tester.runAsync(() async {
        final image = await boundary.toImage(pixelRatio: 3);
        final data = await image.toByteData(format: ui.ImageByteFormat.png);
        image.dispose();
        return data!.buffer.asUint8List();
      });
      File('$out/gift-stack-${dark ? 'dark' : 'light'}.png')
          .writeAsBytesSync(bytes!);
    }
    exit(0);
  });
}
