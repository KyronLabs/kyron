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
import 'package:kyron_app/widgets/gift_motion.dart';
import 'package:kyron_app/widgets/gift_sheet.dart';
import 'package:kyron_app/widgets/like_burst.dart';
import 'package:kyron_app/widgets/notification_item.dart';
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
      type: type,
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
    test('a post says which gift you sent it, if any', () {
      expect(
        FeedPost.fromJson(const {'id': 'p', 'viewerGift': 'gem'}).viewerGift,
        'gem',
      );
      expect(FeedPost.fromJson(const {'id': 'p'}).viewerGift, isNull);
      expect(_post.copyWith(viewerGift: 'fire').viewerGift, 'fire');
      expect(
        _post.copyWith(viewerGift: 'fire').copyWith(likes: 2).viewerGift,
        'fire',
      );
    });

    test('a send answers with which gift it was', () {
      final sent = SentGift.fromJson(const {
        'gift': {'id': 'g1', 'type': 'rose'},
        'gifts': 2,
      });
      expect(sent.type, 'rose');
    });

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
        'sent a Fire to your post',
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
      void Function(BuildContext heart)? onGift,
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
      await tester.pumpWidget(row(onGift: (_) {}));

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
        row(onGift: (_) => gifts++, onLike: () => likes++),
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
      await tester.pumpWidget(row(onGift: (_) {}));

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
        row(onGift: (_) => gifts++, onLike: () => likes++),
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
      await tester.pumpWidget(row(onGift: (_) {}));
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
      await tester.pumpWidget(row(onGift: (_) {}));

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
      expect(find.text('Send Fire'), findsOneWidget);
      // The price beside it, with the coin: in the button, not in words.
      expect(
        find.descendant(
          of: find.byType(FilledButton),
          matching: find.byType(CoinIcon),
        ),
        findsOneWidget,
      );
    });

    testWidgets('names no gift by its emoji, before or after sending', (
      tester,
    ) async {
      await _openSheet(tester);
      bool anyEmoji() => find
          .byWidgetPredicate(
            (w) =>
                w is Text &&
                RegExp('[✨🔥👑🎁]')
                    .hasMatch(w.data ?? w.textSpan?.toPlainText() ?? ''),
          )
          .evaluate()
          .isNotEmpty;

      expect(anyEmoji(), isFalse);
      await tester.tap(tile('fire'));
      await tester.pump();
      expect(anyEmoji(), isFalse);
      await tester.tap(find.text('Send Fire'));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Fire sent'), findsOneWidget);
      expect(anyEmoji(), isFalse);
      await afterSending(tester);
    });

    testWidgets('throws sparkles as the gift goes', (tester) async {
      await _openSheet(tester);
      await tester.tap(tile('fire'));
      await tester.pump();
      await tester.tap(find.text('Send Fire'));
      // One frame for the send to answer, then partway into the burst.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(
        find.byWidgetPredicate(
          (w) => w is CustomPaint && w.painter is GiftBurstPainter,
        ),
        findsOneWidget,
      );
      await afterSending(tester);
    });

    testWidgets('moves the gifts while they wait, then lets them rest', (
      tester,
    ) async {
      await _openSheet(tester, coins: 10);

      // Three that can be afforded move; the Crown, at 50, stays still.
      final motions = tester.widgetList<GiftMotion>(find.byType(GiftMotion));
      expect(
        {for (final m in motions) m.type: m.playing},
        {'spark': true, 'fire': true, 'crown': false},
      );
      // _openSheet settled, which it could not have if they moved forever.
      expect(tester.binding.hasScheduledFrame, isFalse);
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
      await tester.tap(find.text('Send Fire'));
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
      await tester.tap(find.text('Send Fire'));
      await tester.pumpAndSettle();

      // Still open, saying why, and nothing answered yet.
      expect(find.text('Send a gift'), findsOneWidget);
      expect(find.text('Fire sent'), findsNothing);
      expect(answers, isEmpty);

      await tester.tap(find.text('Send Fire'));
      await afterSending(tester);

      expect(repo.sends, hasLength(2));
      expect(repo.sends[1], repo.sends[0]);
      expect(answers.single?.giftId, 'g1');
    });

    testWidgets('makes a new request for a different gift', (tester) async {
      final (repo, _) = await _openSheet(tester, failures: 1);

      await tester.tap(tile('fire'));
      await tester.pump();
      await tester.tap(find.text('Send Fire'));
      await tester.pumpAndSettle();

      await tester.tap(tile('spark'));
      await tester.pump();
      await tester.tap(find.text('Send Spark'));
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

    testWidgets('draws a present, never an emoji, for a gift this app predates',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: GiftArt(type: 'unicorn', size: 48)),
      );
      expect(find.byIcon(Iconsax.gift), findsOneWidget);
      expect(find.byType(Text), findsNothing);
      expect(find.byType(Image), findsNothing);
    });
  });

  group('how long the heart is held', () {
    Widget row(void Function(BuildContext heart) onGift) => MaterialApp(
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
      await tester.pumpWidget(row((_) => opened++));

      // Under the platform's 500ms, past this one's 350.
      await hold(tester, const Duration(milliseconds: 400));
      expect(opened, 1);
    });

    testWidgets('does not open on a slow tap', (tester) async {
      var opened = 0;
      await tester.pumpWidget(row((_) => opened++));

      await hold(tester, const Duration(milliseconds: 250));
      expect(opened, 0);
    });
  });

  group('the heart, once a gift is sent', () {
    Widget row(FeedPost post) => MaterialApp(
          home: Scaffold(
            body: PostActionsRow(
              post: post,
              onReply: () {},
              onRepost: () {},
              onLike: () {},
              onSave: () {},
              onShare: () {},
              onGift: (_) {},
            ),
          ),
        );

    Finder art(String type) => find.byWidgetPredicate(
          (w) => w is GiftArt && w.type == type,
        );

    testWidgets('is the gift you sent', (tester) async {
      await tester.pumpWidget(row(_post.copyWith(viewerGift: 'fire')));

      expect(art('fire'), findsOneWidget);
      expect(find.byIcon(Iconsax.heart_copy), findsNothing);
    });

    testWidgets('lands with a gold burst when it changes', (tester) async {
      await tester.pumpWidget(row(_post));
      await tester.pumpWidget(row(_post.copyWith(viewerGift: 'rose')));
      await tester.pump(const Duration(milliseconds: 120));

      final burst = tester.widget<CustomPaint>(
        find.byWidgetPredicate(
          (w) => w is CustomPaint && w.painter is LikeBurstPainter,
        ),
      );
      expect(
        (burst.painter! as LikeBurstPainter).colour,
        const Color(0xFFF2B233),
      );
      await tester.pumpAndSettle();
      expect(art('rose'), findsOneWidget);
    });

    testWidgets('changes without a landing when motion is off', (
      tester,
    ) async {
      // Through the platform, as the phone's setting arrives: MaterialApp
      // builds its MediaQuery from it.
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(
          tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
      await tester.pumpWidget(row(_post));
      await tester.pumpWidget(row(_post.copyWith(viewerGift: 'rose')));
      // Flutter already shortens a controller to 5% of its length with
      // animations off, so the burst would be a 31ms flash: look inside it.
      await tester.pump(const Duration(milliseconds: 10));

      expect(art('rose'), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (w) => w is CustomPaint && w.painter is LikeBurstPainter,
        ),
        findsNothing,
      );
      expect(tester.binding.hasScheduledFrame, isFalse);
    });

    testWidgets('does not land again on a rebuild with the same gift', (
      tester,
    ) async {
      await tester.pumpWidget(row(_post.copyWith(viewerGift: 'rose')));
      await tester.pumpWidget(
        row(_post.copyWith(viewerGift: 'rose', likes: 9)),
      );
      await tester.pump(const Duration(milliseconds: 120));

      expect(
        find.byWidgetPredicate(
          (w) => w is CustomPaint && w.painter is LikeBurstPainter,
        ),
        findsNothing,
      );
    });
  });

  group('sending from the heart', () {
    /// A post row that changes as the feed would when a gift lands.
    Future<(List<String> felt, ValueNotifier<FeedPost> post)> pumpFeed(
      WidgetTester tester, {
      bool still = false,
    }) async {
      final felt = <String>[];
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'HapticFeedback.vibrate') {
            felt.add('${call.arguments}'.replaceAll('HapticFeedbackType.', ''));
          }
          return null;
        },
      );
      final post = ValueNotifier(_post);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [giftsRepositoryProvider.overrideWithValue(_Gifts())],
          child: MaterialApp(
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(disableAnimations: still),
              child: child!,
            ),
            home: Scaffold(
              body: Align(
                alignment: Alignment.topCenter,
                child: ValueListenableBuilder<FeedPost>(
                  valueListenable: post,
                  builder: (context, value, _) => PostActionsRow(
                    post: value,
                    onReply: () {},
                    onRepost: () {},
                    onLike: () {},
                    onSave: () {},
                    onShare: () {},
                    onGift: (heart) => GiftSheet.open(
                      heart,
                      value,
                      onSent: (sent) => post.value = post.value.copyWith(
                        gifts: sent.gifts,
                        viewerGift: sent.type,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      return (felt, post);
    }

    Future<void> send(WidgetTester tester, String type) async {
      await tester.longPress(find.byIcon(Iconsax.heart_copy));
      await tester.pumpAndSettle();
      await tester.tap(
        find.byWidgetPredicate((w) => w is GiftArt && w.type == type).first,
      );
      await tester.pump();
      await tester.tap(find.textContaining('Send ').last);
      await tester.pump();
    }

    testWidgets('flies the gift to the heart, and the heart becomes it', (
      tester,
    ) async {
      final (felt, post) = await pumpFeed(tester);
      await send(tester, 'fire');

      // The celebration, then the sheet lets go of it.
      await tester.pump(const Duration(milliseconds: 950));
      await tester.pump(const Duration(milliseconds: 200));
      // In flight: the heart is still a heart.
      expect(post.value.viewerGift, isNull);
      expect(find.byIcon(Iconsax.heart_copy), findsOneWidget);

      await tester.pumpAndSettle();
      expect(post.value.viewerGift, 'fire');
      expect(post.value.gifts, 4);
      expect(find.byIcon(Iconsax.heart_copy), findsNothing);
      expect(find.text('Send a gift'), findsNothing);
      // Hold, pick, sent, landed: soft each time, and never a buzz.
      expect(felt, [
        'lightImpact',
        'selectionClick',
        'lightImpact',
        'selectionClick',
      ]);
    });

    testWidgets('changes the heart without a flight when motion is off', (
      tester,
    ) async {
      final (_, post) = await pumpFeed(tester, still: true);
      await send(tester, 'spark');
      await tester.pump(const Duration(seconds: 1));
      await tester.pump();

      expect(post.value.viewerGift, 'spark');
      await tester.pumpAndSettle();
    });
  });

  group('a gift notification', () {
    testWidgets('shows the gift itself, not an icon or an emoji', (
      tester,
    ) async {
      final row = NotificationModel.fromJson(const {
        'id': 'gift:g1',
        'kind': 'gift',
        'createdAt': '2026-10-29T10:00:00Z',
        'postId': 'p1',
        'actor': {'id': 'ben', 'name': 'Ben'},
        'gift': {'type': 'fire', 'coins': 5, 'name': 'Fire', 'emoji': '🔥'},
      });
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationItem(notification: row, onTap: () {}),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // On the avatar, and at the end of the row.
      expect(
        find.byWidgetPredicate((w) => w is GiftArt && w.type == 'fire'),
        findsNWidgets(2),
      );
      expect(find.byIcon(Iconsax.gift_copy), findsNothing);
      expect(find.textContaining('🔥'), findsNothing);
      expect(find.textContaining('sent a Fire to your post'), findsOneWidget);
    });
  });

  group('a notification about a post with a picture', () {
    Future<void> pumpRow(WidgetTester tester, Map<String, dynamic> json) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationItem(
              notification: NotificationModel.fromJson(json),
              onTap: () {},
            ),
          ),
        ),
      );
      await tester.pump();
    }

    const base = {
      'createdAt': '2026-10-31T10:00:00Z',
      'postId': 'p1',
      'postSnippet': 'A kingfisher',
      'actor': {'id': 'ben', 'name': 'Ben'},
    };
    Finder picture() => find.byWidgetPredicate(
          (w) =>
              w is Image &&
              w.image is ResizeImage &&
              (w.image as ResizeImage).imageProvider is NetworkImage,
        );

    testWidgets('shows it at the far right, rounded, with the gift on it', (
      tester,
    ) async {
      await pumpRow(tester, {
        ...base,
        'id': 'gift:g1',
        'kind': 'gift',
        'postImage': 'https://cdn.test/kingfisher.jpg',
        'gift': {'type': 'fire', 'coins': 5, 'name': 'Fire'},
      });

      expect(picture(), findsOneWidget);
      final rounded = tester.widget<ClipRRect>(
        find.ancestor(of: picture(), matching: find.byType(ClipRRect)),
      );
      expect(rounded.borderRadius, isNot(BorderRadius.zero));
      // Last in the row: right of the time.
      expect(
        tester.getCenter(picture()).dx,
        greaterThan(
          tester
              .getCenter(
                find.text(
                  NotificationModel.fromJson(const {
                    ...base,
                    'id': 'x',
                    'kind': 'gift',
                  }).displayTimestamp,
                ),
              )
              .dx,
        ),
      );
      // The gift sits on the picture's corner, not in a place of its own.
      final gifts = find.byWidgetPredicate(
        (w) => w is GiftArt && w.type == 'fire',
      );
      final onPicture = tester.getRect(gifts.last);
      final pictureRect = tester.getRect(picture());
      expect(pictureRect.contains(onPicture.topLeft), isTrue);
    });

    testWidgets('shows only the picture for a like', (tester) async {
      await pumpRow(tester, {
        ...base,
        'id': 'like:l1',
        'kind': 'like',
        'postImage': 'https://cdn.test/kingfisher.jpg',
      });

      expect(picture(), findsOneWidget);
      expect(find.byType(GiftArt), findsNothing);
    });

    testWidgets('shows the gift alone on a post of words', (tester) async {
      await pumpRow(tester, {
        ...base,
        'id': 'gift:g2',
        'kind': 'gift',
        'gift': {'type': 'rose', 'coins': 3, 'name': 'Rose'},
      });

      expect(picture(), findsNothing);
      // On the avatar, and at the end of the row.
      expect(
        find.byWidgetPredicate((w) => w is GiftArt && w.type == 'rose'),
        findsNWidgets(2),
      );
    });
  });
}
