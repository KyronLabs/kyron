import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/gift.dart';
import 'package:kyron_app/providers/gifts_provider.dart';
import 'package:kyron_app/repositories/gifts_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/gift_givers_sheet.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// A tool, not a test: the list the gift pill opens, light and dark.
///
///     flutter test test/render_gift_givers.dart --dart-define=shots=/tmp/x
const out = String.fromEnvironment('shots', defaultValue: '/tmp/kyron-shots');

class _Gifts extends GiftsRepository {
  _Gifts() : super(ApiClient());

  @override
  Future<PostGifts> givers(String postId) async => PostGifts.fromJson({
        'total': 12,
        'senders': [
          {
            'user': {'id': 'w', 'name': 'Weaver', 'verified': true},
            'coins': 158,
            'gifts': [
              {'type': 'rocket', 'name': 'Rocket', 'count': 1},
              {'type': 'crown', 'name': 'Crown', 'count': 1},
              {'type': 'rose', 'name': 'Rose', 'count': 2},
              {'type': 'spark', 'name': 'Spark', 'count': 2},
            ],
          },
          {
            'user': {'id': 'g', 'name': 'Gremlin', 'verified': true},
            'coins': 25,
            'gifts': [
              {'type': 'gem', 'name': 'Gem', 'count': 1},
              {'type': 'fire', 'name': 'Fire', 'count': 1},
            ],
          },
          {
            'user': {'id': 's', 'name': 'Sharrrd'},
            'coins': 9,
            'gifts': [
              {'type': 'rose', 'name': 'Rose', 'count': 3},
            ],
          },
          {
            'user': {'id': 't', 'name': 'Tester'},
            'coins': 1,
            'gifts': [
              {'type': 'spark', 'name': 'Spark', 'count': 1},
            ],
          },
        ],
      });
}

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
    final icons = FontLoader('packages/iconsax_flutter/FlutterIconsax');
    icons.addFont(
      rootBundle.load('packages/iconsax_flutter/fonts/FlutterIconsax.ttf'),
    );
    await icons.load();

    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 640);
    addTearDown(tester.view.reset);

    final post = FeedPost(
      id: 'p1',
      content: '',
      createdAt: DateTime(2026, 11, 8),
      author: FeedAuthor.fromJson(const {'id': 'k', 'name': 'Kyron'}),
      gifts: 12,
    );

    Future<void> shoot(String name) async {
      for (var i = 0; i < 30; i++) {
        await tester.pump(const Duration(milliseconds: 32));
      }
      await tester.runAsync(() async {
        for (final element in find.byType(Image).evaluate()) {
          await precacheImage((element.widget as Image).image, element);
        }
      });
      await tester.pump();
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
            overrides: [giftsRepositoryProvider.overrideWithValue(_Gifts())],
            child: MaterialApp(
              key: ValueKey(dark),
              debugShowCheckedModeBanner: false,
              theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
              home: Builder(
                builder: (context) => Scaffold(
                  body: Center(
                    child: TextButton(
                      onPressed: () => GiftGiversSheet.show(context, post),
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
      await shoot('givers-${dark ? 'dark' : 'light'}');
    }
    exit(0);
  });
}
