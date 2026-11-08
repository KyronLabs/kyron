import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/link_preview.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/widgets/link_preview_card.dart';
import 'package:kyron_app/widgets/post_card.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/signed_in_as.dart';

/// A tool, not a test: the gift pill on each kind of post -- words that run
/// to the edge, a photo, a pair, a voice note, a link card -- and a post with
/// no gifts beside them, light and dark.
///
/// Pictures come from a local server: start one in a folder holding fox.png,
/// fox2.png and teddy.png, and pass its address.
///
///     flutter test test/render_gift_pill.dart \\
///       --dart-define=shots=/tmp/x --dart-define=media=http://127.0.0.1:8765
const out = String.fromEnvironment('shots', defaultValue: '/tmp/kyron-shots');
const media = String.fromEnvironment('media', defaultValue: '');

FeedPost _post(
  String id,
  String text, {
  List<PostMedia> media = const [],
  int gifts = 0,
  List<String> top = const [],
  String? mine,
  String name = 'Gremlin',
}) =>
    FeedPost(
      id: id,
      content: text,
      createdAt: DateTime.now().subtract(const Duration(minutes: 35)),
      author: FeedAuthor(id: 'a-$id', name: name, username: name.toLowerCase()),
      likes: 3,
      comments: 1,
      media: media,
      gifts: gifts,
      topGifts: top,
      viewerGift: mine,
    );

void main() {
  testWidgets('render', (tester) async {
    HttpOverrides.global = null;
    SharedPreferences.setMockInitialValues({});
    Directory(out).createSync(recursive: true);
    for (final family in ['Inter', 'Roboto']) {
      final loader = FontLoader(family);
      for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold']) {
        loader.addFont(rootBundle.load('assets/fonts/Inter-$weight.ttf'));
      }
      await loader.load();
    }
    final icons = FontLoader('packages/iconsax_flutter/FlutterIconsax');
    icons.addFont(
      rootBundle.load('packages/iconsax_flutter/fonts/FlutterIconsax.ttf'),
    );
    await icons.load();

    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 2300);
    addTearDown(tester.view.reset);

    final posts = [
      _post(
        'p1',
        "@shards The older I get, the more I see why it's important to keep "
            'people around who have the same morals, manners, and sense of '
            "consideration as you. It's not being picky, it's protecting "
            'your peace.',
        gifts: 12,
        top: const ['crown', 'gem', 'rose'],
        mine: 'rose',
      ),
      _post(
        'p2',
        'Arabian fox in Kuwait desert',
        name: 'Kyron',
        gifts: 3,
        top: const ['rose'],
        media: const [
          PostMedia(
            id: 'm1',
            kind: MediaKind.image,
            url: '$media/fox.png',
            width: 1200,
            height: 800,
          ),
        ],
      ),
      _post(
        'p3',
        '',
        name: 'Archieee',
        gifts: 2,
        top: const ['star', 'spark'],
        media: const [
          PostMedia(
            id: 'v1',
            kind: MediaKind.voice,
            url: '$media/none.m4a',
            duration: Duration(seconds: 8),
            waveform: [
              20, 40, 60, 80, 50, 30, 70, 90, 60, 40, 20, 50, 80, 60, 30, 40, //
              70, 50, 30, 60, 80, 40, 20, 50, 70, 90, 60, 30, 40, 50, 20, 30,
            ],
          ),
        ],
      ),
      _post(
        'p4',
        'Read more from this investigation, via @bbcnews: bbc.in/3X8RB3q',
        gifts: 1500,
        top: const ['rocket', 'crown', 'fire'],
      ),
      _post('p5', 'No gifts on this one, so no pill.', name: 'Willow'),
      _post(
        'p6',
        'Two from the walk',
        name: 'Sharrrd',
        gifts: 1,
        top: const ['cake'],
        media: const [
          PostMedia(id: 'm2', kind: MediaKind.image, url: '$media/fox.png'),
          PostMedia(id: 'm3', kind: MediaKind.image, url: '$media/fox2.png'),
        ],
      ),
    ];

    Future<void> shoot(String name) async {
      for (var i = 0; i < 10; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 150)),
        );
        await tester.pump(const Duration(milliseconds: 50));
      }
      final boundary = tester.renderObject<RenderRepaintBoundary>(
        find.byKey(const ValueKey('shot')),
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
          key: const ValueKey('shot'),
          child: ProviderScope(
            key: ValueKey(dark),
            overrides: [
              signedInAs(),
              linkPreviewProvider.overrideWith(
                (ref, url) async => const LinkPreview(
                  url: 'https://bbc.in/3X8RB3q',
                  host: 'bbc.co.uk',
                  siteName: 'BBC News',
                  title: "AI teddy makes unprompted 'I can't help with "
                      "killing you' remark",
                  description: 'MPs and peers have urged retailers to remove '
                      'AI toys from sale ahead of Black Friday and Christmas.',
                  imageUrl: '$media/teddy.png',
                ),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
              home: Scaffold(
                body: ListView(
                  children: [
                    for (final post in posts) ...[
                      PostCard(post: post, source: PostListSource.recent),
                      const Divider(height: 1, thickness: 0.5),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      await shoot('gift-pill-${dark ? 'dark' : 'light'}');
    }
    exit(0);
  });
}
