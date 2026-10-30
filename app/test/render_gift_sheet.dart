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
import 'package:kyron_app/widgets/gift_sheet.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// A tool, not a test: draws the gift sheet, light and dark, to PNGs.
///
///     flutter test test/render_gift_sheet.dart --dart-define=shots=/tmp/x
///
/// See test/render_browser.dart for the two things worth knowing: wrap
/// toImage in runAsync, and load a font. The font here is the app's own
/// Inter, so the shot reads as the app does.
const out = String.fromEnvironment('shots', defaultValue: '/tmp/kyron-shots');

/// The catalogue as the API serves it, and a wallet part-spent, so the shot
/// has gifts that cost more than is left.
class _Gifts extends GiftsRepository {
  _Gifts() : super(ApiClient());

  @override
  Future<SentGift> send(String postId, String type,
          {required String requestId}) async =>
      SentGift(
        giftId: 'g',
        type: type,
        gifts: 1,
        wallet: const GiftWallet(coins: 88, earned: 0, weeklyCoins: 100),
      );

  @override
  Future<GiftSheetData> sheet() async => GiftSheetData(
        catalogue: const [
          GiftType(type: 'spark', name: 'Spark', emoji: '✨', coins: 1),
          GiftType(type: 'rose', name: 'Rose', emoji: '🌹', coins: 3),
          GiftType(type: 'fire', name: 'Fire', emoji: '🔥', coins: 5),
          GiftType(type: 'star', name: 'Star', emoji: '⭐', coins: 10),
          GiftType(type: 'gem', name: 'Gem', emoji: '💎', coins: 20),
          GiftType(type: 'cake', name: 'Cake', emoji: '🎂', coins: 30),
          GiftType(type: 'crown', name: 'Crown', emoji: '👑', coins: 50),
          GiftType(type: 'rocket', name: 'Rocket', emoji: '🚀', coins: 100),
        ],
        wallet: GiftWallet(
          coins: 93,
          earned: 0,
          weeklyCoins: 100,
          refillsAt: DateTime(2026, 11, 2),
        ),
      );
}

void main() {
  testWidgets('render', (tester) async {
    Directory(out).createSync(recursive: true);
    // Under Roboto too: that is the family a test falls back to, and with
    // nothing registered under it every word draws as a row of boxes.
    for (final family in ['Inter', 'Roboto']) {
      final loader = FontLoader(family);
      for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold']) {
        loader.addFont(rootBundle.load('assets/fonts/Inter-$weight.ttf'));
      }
      await loader.load();
    }

    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 600);
    addTearDown(tester.view.reset);

    final post = FeedPost(
      id: 'p1',
      content: '',
      createdAt: DateTime(2026, 10, 30),
      author: FeedAuthor.fromJson(const {'id': 'ada', 'name': 'Ada'}),
    );

    Future<void> shoot(String name, {bool settle = true}) async {
      if (settle) await tester.pumpAndSettle();
      await tester.runAsync(() async {
        for (final element in find.byType(Image).evaluate()) {
          await precacheImage((element.widget as Image).image, element);
        }
      });
      if (settle) await tester.pumpAndSettle();
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
            // Keyed by theme, so the dark pass starts from a closed sheet
            // rather than inheriting the light pass's open one.
            child: MaterialApp(
              key: ValueKey(dark),
              debugShowCheckedModeBanner: false,
              theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
              home: Builder(
                builder: (context) => Scaffold(
                  body: Center(
                    child: TextButton(
                      onPressed: () => GiftSheet.show(context, post),
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
      await shoot('gift-sheet-${dark ? 'dark' : 'light'}');
      await tester.tap(find.byType(GiftArt).at(2));
      await shoot('gift-sheet-picked-${dark ? 'dark' : 'light'}');
      if (!dark) {
        await tester.tap(find.text('Send Fire'));
        await tester.pump();
        for (final ms in [120, 200, 300]) {
          await tester.pump(Duration(milliseconds: ms));
          await shoot('gift-sent-$ms', settle: false);
        }
      }
    }
    exit(0);
  });
}
