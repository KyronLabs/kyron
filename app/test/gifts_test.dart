import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_app/l10n/app_localizations.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/gift.dart';
import 'package:kyron_app/models/notification_model.dart';
import 'package:kyron_app/providers/gifts_provider.dart';
import 'package:kyron_app/repositories/gifts_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/utils/notification_text.dart';
import 'package:kyron_app/widgets/gift_sheet.dart';
import 'package:kyron_app/widgets/post_actions_row.dart';

/// Gifts: a reader spends test coins on somebody else's post.
class _Gifts extends GiftsRepository {
  _Gifts({this.coins = 30}) : super(ApiClient());

  final int coins;

  /// Each send's request id, in order.
  final sends = <String>[];

  /// How many sends fail before one goes through.
  int failures = 0;

  @override
  Future<GiftSheetData> sheet() async => GiftSheetData(
        catalogue: const [
          GiftType(type: 'spark', name: 'Spark', emoji: '✨', coins: 1),
          GiftType(type: 'fire', name: 'Fire', emoji: '🔥', coins: 5),
          GiftType(type: 'crown', name: 'Crown', emoji: '👑', coins: 50),
        ],
        wallet: GiftWallet(
          coins: coins,
          earned: 0,
          weeklyCoins: 100,
          refillsAt: DateTime(2026, 11, 2),
        ),
      );

  @override
  Future<SentGift> send(
    String postId,
    String type, {
    required String requestId,
  }) async {
    sends.add(requestId);
    if (failures > 0) {
      failures--;
      throw DioException(
        requestOptions: RequestOptions(path: '/feed/posts/$postId/gifts'),
        type: DioExceptionType.connectionError,
      );
    }
    return SentGift(
      giftId: 'g1',
      gifts: 4,
      wallet: GiftWallet(coins: coins - 5, earned: 0, weeklyCoins: 100),
    );
  }
}

final _post = FeedPost(
  id: 'p1',
  content: 'Something worth a gift',
  createdAt: DateTime(2026, 10, 29),
  author: FeedAuthor.fromJson(const {'id': 'ada', 'name': 'Ada'}),
  gifts: 3,
);

/// A screen with one button that opens the sheet, and what it answered.
Future<(_Gifts, List<SentGift?>)> _openSheet(
  WidgetTester tester, {
  int coins = 30,
  int failures = 0,
}) async {
  final repo = _Gifts(coins: coins)..failures = failures;
  final answers = <SentGift?>[];
  await tester.pumpWidget(
    ProviderScope(
      overrides: [giftsRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async =>
                  answers.add(await GiftSheet.show(context, _post)),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return (repo, answers);
}

void main() {
  group('reading what the server sends', () {
    test('a post carries its gift count, and none means zero', () {
      expect(FeedPost.fromJson(const {'id': 'p', 'gifts': 7}).gifts, 7);
      expect(FeedPost.fromJson(const {'id': 'p'}).gifts, 0);
      expect(_post.copyWith(gifts: 9).gifts, 9);
      expect(_post.copyWith(likes: 1).gifts, 3);
    });

    test('a gift row says which gift', () {
      final row = NotificationModel.fromJson(const {
        'id': 'gift:g1',
        'kind': 'gift',
        'createdAt': '2026-10-29T10:00:00Z',
        'postId': 'p1',
        'gift': {'type': 'fire', 'coins': 5, 'name': 'Fire', 'emoji': '🔥'},
      });
      expect(row.type, NotificationType.gift);
      expect(row.gift?.name, 'Fire');
      expect(row.fromKyron, isFalse);
    });
  });

  group('what a gift row says', () {
    late AppLocalizations l10n;
    setUpAll(() async {
      l10n = await AppLocalizations.delegate.load(const Locale('en'));
    });

    test('names the gift', () {
      const fire = GiftNote(type: 'fire', name: 'Fire', emoji: '🔥', coins: 5);
      expect(
        notificationAction(l10n, NotificationType.gift, gift: fire),
        'sent a 🔥 Fire to your post',
      );
    });

    test('still makes sense without one', () {
      expect(
        notificationAction(l10n, NotificationType.gift),
        'sent a gift to your post',
      );
    });
  });

  group('request ids', () {
    final shape = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
    );

    test('are version 4 UUIDs, which is what the server accepts', () {
      for (var i = 0; i < 200; i++) {
        expect(GiftsRepository.newRequestId(), matches(shape));
      }
    });

    test('are not repeated', () {
      final random = Random(1);
      final ids = {
        for (var i = 0; i < 1000; i++) GiftsRepository.newRequestId(random),
      };
      expect(ids, hasLength(1000));
    });
  });

  group('holding the heart', () {
    Widget row({
      VoidCallback? onGift,
      VoidCallback? onLike,
      bool showCounts = true,
    }) =>
        MaterialApp(
          home: Scaffold(
            body: PostActionsRow(
              post: _post,
              onReply: () {},
              onRepost: () {},
              onLike: onLike ?? () {},
              onSave: () {},
              onShare: () {},
              onGift: onGift,
              showCounts: showCounts,
            ),
          ),
        );

    final heart = find.byIcon(Iconsax.heart_copy);

    /// Every haptic the platform was asked for, by type.
    List<String> haptics(WidgetTester tester) {
      final calls = <String>[];
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'HapticFeedback.vibrate') {
            calls.add('${call.arguments}');
          }
          return null;
        },
      );
      return calls;
    }

    testWidgets('leaves the row as it was: five actions, no gift button', (
      tester,
    ) async {
      await tester.pumpWidget(row(onGift: () {}));

      expect(find.byIcon(Iconsax.gift_copy), findsNothing);
      expect(find.byIcon(Iconsax.gift), findsNothing);
      expect(find.byType(PostAction), findsNWidgets(5));
      // The post's three gifts are not drawn as a count on the card.
      expect(find.text('3'), findsNothing);
    });

    testWidgets('opens the gifts, with a light tap of haptics, and no like', (
      tester,
    ) async {
      final felt = haptics(tester);
      var gifts = 0;
      var likes = 0;
      await tester.pumpWidget(
        row(onGift: () => gifts++, onLike: () => likes++),
      );

      await tester.longPress(heart);
      await tester.pumpAndSettle();

      expect(gifts, 1);
      expect(likes, 0);
      expect(felt, ['HapticFeedbackType.lightImpact']);
    });

    testWidgets('does not pop up the Like tooltip over the sheet', (
      tester,
    ) async {
      await tester.pumpWidget(row(onGift: () {}));

      await tester.longPress(heart);
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Like'), findsNothing);
    });

    testWidgets('still likes on a tap, with the tick a tap always had', (
      tester,
    ) async {
      final felt = haptics(tester);
      var gifts = 0;
      var likes = 0;
      await tester.pumpWidget(
        row(onGift: () => gifts++, onLike: () => likes++),
      );

      await tester.tap(heart);
      await tester.pumpAndSettle();

      expect(likes, 1);
      expect(gifts, 0);
      expect(felt, ['HapticFeedbackType.selectionClick']);
    });

    testWidgets('lifts the heart and sets it back exactly where it was', (
      tester,
    ) async {
      await tester.pumpWidget(row(onGift: () {}));
      double scale() {
        final transforms = tester.widgetList<Transform>(
          find.ancestor(of: heart, matching: find.byType(Transform)),
        );
        return transforms
            .map((t) => t.transform.getMaxScaleOnAxis())
            .reduce((a, b) => a * b);
      }

      expect(scale(), 1);
      await tester.longPress(heart);
      // longPress has already held for the gesture's timeout; this is
      // partway into the lift that follows.
      await tester.pump(const Duration(milliseconds: 120));
      expect(scale(), greaterThan(1.1));
      await tester.pumpAndSettle();
      expect(scale(), 1);
    });

    test('the lift starts and ends at rest, and peaks in between', () {
      expect(liftCurve(0), 0);
      expect(liftCurve(1), 0);
      expect(liftCurve(0.4), 1);
      for (var t = 0.0; t <= 1; t += 0.05) {
        expect(liftCurve(t), inInclusiveRange(0, 1));
      }
    });

    testWidgets('tells a screen reader that holding sends a gift', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(row(onGift: () {}));

      expect(
        tester.getSemantics(find.byTooltip('Like')),
        matchesSemantics(
          isFocusable: true,
          hasTapAction: true,
          hasLongPressAction: true,
          hasFocusAction: true,
          onLongPressHint: 'Send a gift',
          tooltip: 'Like',
        ),
      );
      semantics.dispose();
    });

    testWidgets('is only a like where gifts cannot be sent', (tester) async {
      var likes = 0;
      await tester.pumpWidget(row(onLike: () => likes++));

      await tester.longPress(heart);
      await tester.pumpAndSettle();

      // No sheet to open, so the long press is the tooltip's again.
      expect(find.text('Like'), findsOneWidget);
      expect(likes, 0);
    });
  });

  group('the sheet', () {
    /// A gift's tile, found by its picture: the tiles carry no names.
    Finder tile(String type) => find.byWidgetPredicate(
          (widget) => widget is GiftArt && widget.type == type,
        );

    /// Lets the sent gift's moment play out and the sheet close.
    Future<void> afterSending(WidgetTester tester) async {
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
    }

    testWidgets('says the coins are test coins, every time', (tester) async {
      await _openSheet(tester);

      expect(find.textContaining('no cash value'), findsOneWidget);
    });

    testWidgets('shows the balance in its top right corner', (tester) async {
      await _openSheet(tester);

      final title = tester.getTopLeft(find.text('Send a gift'));
      final balance = tester.getTopRight(find.text('30'));
      expect(balance.dx, greaterThan(title.dx + 200));
      expect((balance.dy - title.dy).abs(), lessThan(16));
      expect(find.byType(CoinIcon), findsWidgets);
    });

    testWidgets('puts each price, with the coin, under its gift', (
      tester,
    ) async {
      await _openSheet(tester);

      for (final (type, price) in [('spark', '1'), ('fire', '5')]) {
        final art = tester.getCenter(tile(type));
        final label = tester.getCenter(find.text(price));
        expect(label.dy, greaterThan(art.dy));
        expect((label.dx - art.dx).abs(), lessThan(16));
      }
    });

    testWidgets('draws every gift from its artwork, four to a row', (
      tester,
    ) async {
      await _openSheet(tester);

      expect(tile('spark'), findsOneWidget);
      expect(find.text('✨'), findsNothing);
      final rows = {
        for (final type in ['spark', 'fire', 'crown'])
          tester.getCenter(tile(type)).dy.round(),
      };
      expect(rows, hasLength(1));
    });

    testWidgets('sends nothing until a gift is picked and Send is pressed', (
      tester,
    ) async {
      final (repo, _) = await _openSheet(tester);

      final send = find.widgetWithText(FilledButton, 'Pick a gift');
      expect(tester.widget<FilledButton>(send).onPressed, isNull);

      await tester.tap(tile('fire'));
      await tester.pump();
      expect(repo.sends, isEmpty);
      expect(find.text('Send 🔥 Fire · 5 coins'), findsOneWidget);
    });

    testWidgets('will not send what the wallet cannot cover', (tester) async {
      final (repo, _) = await _openSheet(tester);

      await tester.tap(tile('crown'));
      await tester.pump();

      final button = find.widgetWithText(FilledButton, 'Not enough coins');
      expect(tester.widget<FilledButton>(button).onPressed, isNull);
      expect(repo.sends, isEmpty);
    });

    testWidgets('shows the gift going, then closes with what was sent', (
      tester,
    ) async {
      final (repo, answers) = await _openSheet(tester);

      await tester.tap(tile('fire'));
      await tester.pump();
      await tester.tap(find.text('Send 🔥 Fire · 5 coins'));
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Fire sent'), findsOneWidget);
      expect(answers, isEmpty);

      await afterSending(tester);
      expect(repo.sends, hasLength(1));
      expect(answers.single?.gifts, 4);
      expect(find.text('Send a gift'), findsNothing);
    });

    testWidgets(
        'retries a failed send as the same request, never a second gift',
        (tester) async {
      final (repo, answers) = await _openSheet(tester, failures: 1);

      await tester.tap(tile('fire'));
      await tester.pump();
      await tester.tap(find.text('Send 🔥 Fire · 5 coins'));
      await tester.pumpAndSettle();

      // Still open, saying why, and nothing answered yet.
      expect(find.text('Send a gift'), findsOneWidget);
      expect(find.text('Fire sent'), findsNothing);
      expect(answers, isEmpty);

      await tester.tap(find.text('Send 🔥 Fire · 5 coins'));
      await afterSending(tester);

      expect(repo.sends, hasLength(2));
      expect(repo.sends[1], repo.sends[0]);
      expect(answers.single?.giftId, 'g1');
    });

    testWidgets('makes a new request for a different gift', (tester) async {
      final (repo, _) = await _openSheet(tester, failures: 1);

      await tester.tap(tile('fire'));
      await tester.pump();
      await tester.tap(find.text('Send 🔥 Fire · 5 coins'));
      await tester.pumpAndSettle();

      await tester.tap(tile('spark'));
      await tester.pump();
      await tester.tap(find.text('Send ✨ Spark · 1 coin'));
      await afterSending(tester);

      expect(repo.sends, hasLength(2));
      expect(repo.sends[1], isNot(repo.sends[0]));
    });
  });

  group('the artwork', () {
    test('is in the bundle for every gift the app says it draws', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      for (final type in [...GiftArt.drawn, 'coin']) {
        final bytes = await rootBundle.load(GiftArt.pathFor(type));
        expect(bytes.lengthInBytes, greaterThan(1000), reason: type);
      }
    });

    testWidgets('falls back to the emoji for a gift this app predates', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: GiftArt(type: 'unicorn', emoji: '🦄', size: 48),
        ),
      );
      expect(find.text('🦄'), findsOneWidget);
      expect(find.byType(Image), findsNothing);
    });
  });

  group('how long the heart is held', () {
    Widget row(VoidCallback onGift) => MaterialApp(
          home: Scaffold(
            body: PostActionsRow(
              post: _post,
              onReply: () {},
              onRepost: () {},
              onLike: () {},
              onSave: () {},
              onShare: () {},
              onGift: onGift,
            ),
          ),
        );

    Future<void> hold(WidgetTester tester, Duration duration) async {
      final gesture = await tester.startGesture(
        tester.getCenter(find.byIcon(Iconsax.heart_copy)),
      );
      await tester.pump(duration);
      await gesture.up();
      await tester.pumpAndSettle();
    }

    testWidgets('opens the gifts sooner than the platform long press', (
      tester,
    ) async {
      var opened = 0;
      await tester.pumpWidget(row(() => opened++));

      // Under the platform's 500ms, past this one's 350.
      await hold(tester, const Duration(milliseconds: 400));
      expect(opened, 1);
    });

    testWidgets('does not open on a slow tap', (tester) async {
      var opened = 0;
      await tester.pumpWidget(row(() => opened++));

      await hold(tester, const Duration(milliseconds: 250));
      expect(opened, 0);
    });
  });
}
