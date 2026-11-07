import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_comment.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/providers/profile_provider.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/repositories/profile_repository.dart';
import 'package:kyron_app/screens/post_detail_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/hairline.dart';
import 'package:kyron_app/widgets/post_action_colors.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/signed_in_as.dart';

/// The top of a post's own page: Follow beside somebody else's name, and the
/// post's menu in the header, last on the right.
class _OnePost extends FeedRepository {
  _OnePost(this.post) : super(ApiClient());

  final FeedPost post;

  @override
  Future<FeedPost> byId(String postId) async => post;

  @override
  Future<CommentPage> comments(
    String postId, {
    String? cursor,
    int limit = 20,
    CommentSort sort = CommentSort.top,
  }) async =>
      const CommentPage(items: []);

  @override
  Future<void> recordView(String postId, {int? dwellMs}) async {}

  @override
  Future<FeedPage> recent({String? cursor, int limit = 20}) async =>
      const FeedPage(items: []);
}

class _Profiles extends ProfileRepository {
  _Profiles({this.fail = false}) : super(ApiClient());

  final bool fail;
  final followed = <String>[];

  @override
  Future<void> follow(String userId) async {
    if (fail) throw Exception('offline');
    followed.add(userId);
  }
}

FeedPost _post({String author = 'ada', bool following = false}) => FeedPost(
      id: 'p1',
      content: 'Autumn colours, fresh catch',
      createdAt: DateTime(2026, 10, 30),
      author: FeedAuthor(id: author, username: author, name: 'Ada'),
      followingAuthor: following,
    );

Future<_Profiles> _page(
  WidgetTester tester,
  FeedPost post, {
  bool fail = false,
}) async {
  final profiles = _Profiles(fail: fail);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        signedInAs(),
        feedRepositoryProvider.overrideWithValue(_OnePost(post)),
        profileRepositoryProvider.overrideWithValue(profiles),
      ],
      child: const MaterialApp(home: PostDetailScreen(postId: 'p1')),
    ),
  );
  await tester.pump();
  await tester.pump();
  return profiles;
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  final follow = find.byKey(const ValueKey('post-detail-follow'));
  final menu = find.byKey(const ValueKey('post-detail-menu'));
  final analytics = find.byIcon(Iconsax.chart_2_copy);

  group("somebody else's post", () {
    testWidgets('offers Follow, red with white words, beside the author', (
      tester,
    ) async {
      await _page(tester, _post());

      expect(follow, findsOneWidget);
      final pill = tester.widget<AnimatedContainer>(
        find.descendant(of: follow, matching: find.byType(AnimatedContainer)),
      );
      expect(
        (pill.decoration! as BoxDecoration).color,
        PostActionColors.like,
      );
      expect(
          tester.widget<Text>(find.text('Follow')).style?.color, Colors.white);
      // In the author's row, level with the name.
      expect(
        (tester.getCenter(follow).dy - tester.getCenter(find.text('Ada')).dy)
            .abs(),
        lessThan(24),
      );
    });

    testWidgets('puts the menu in the header, with no analytics', (
      tester,
    ) async {
      await _page(tester, _post());

      expect(menu, findsOneWidget);
      expect(analytics, findsNothing);
      // In the header, not the post: above the author.
      expect(tester.getCenter(menu).dy,
          lessThan(tester.getTopLeft(find.text('Ada')).dy));
    });

    testWidgets('follows, with a tick of haptics, and says so', (
      tester,
    ) async {
      final felt = <String>[];
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'HapticFeedback.vibrate') {
            felt.add('${call.arguments}');
          }
          return null;
        },
      );
      final profiles = await _page(tester, _post());

      await tester.tap(follow);
      await tester.pumpAndSettle();

      expect(profiles.followed, ['ada']);
      expect(find.text('Following'), findsOneWidget);
      expect(find.text('Follow'), findsNothing);
      expect(felt, ['HapticFeedbackType.selectionClick']);
    });

    testWidgets('puts Follow back if the follow fails', (tester) async {
      await _page(tester, _post(), fail: true);

      await tester.tap(follow);
      await tester.pumpAndSettle();

      expect(find.text('Follow'), findsOneWidget);
      expect(find.text('Following'), findsNothing);
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('offers nothing for somebody you already follow', (
      tester,
    ) async {
      await _page(tester, _post(following: true));

      expect(follow, findsNothing);
      expect(find.text('Following'), findsNothing);
      expect(menu, findsOneWidget);
    });
  });

  group('your own post', () {
    testWidgets('has analytics, then the menu, last on the right', (
      tester,
    ) async {
      await _page(tester, _post(author: 'me'));

      expect(follow, findsNothing);
      expect(analytics, findsOneWidget);
      expect(menu, findsOneWidget);
      expect(
        tester.getCenter(menu).dx,
        greaterThan(tester.getCenter(analytics).dx),
      );
      expect(
        (tester.getCenter(menu).dy - tester.getCenter(analytics).dy).abs(),
        lessThan(1),
      );
    });
  });

  group('the page around the post', () {
    testWidgets("puts the author in the bar once their header is gone", (
      tester,
    ) async {
      final long = FeedPost(
        id: 'p1',
        content:
            List.filled(60, 'A long walk along the harbour wall.').join(' '),
        createdAt: DateTime(2026, 10, 30),
        author: const FeedAuthor(id: 'ada', username: 'ada', name: 'Ada'),
        likes: 3,
      );
      await _page(tester, long);
      final inBar = find.byKey(const ValueKey('post-detail-bar-author'));
      expect(inBar, findsNothing);

      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pumpAndSettle();
      expect(inBar, findsOneWidget);
      expect(
        find.descendant(of: inBar, matching: find.text('@ada')),
        findsOneWidget,
      );

      // And gives the bar back once the header returns.
      await tester.drag(find.byType(ListView), const Offset(0, 600));
      await tester.pumpAndSettle();
      expect(inBar, findsNothing);
    });

    testWidgets('the bar changes at its own pace, however hard the scroll', (
      tester,
    ) async {
      final long = FeedPost(
        id: 'p1',
        content:
            List.filled(60, 'A long walk along the harbour wall.').join(' '),
        createdAt: DateTime(2026, 10, 30),
        author: const FeedAuthor(id: 'ada', username: 'ada', name: 'Ada'),
      );
      await _page(tester, long);
      final title = find.byKey(const ValueKey('post-detail-bar-title'));
      final author = find.byKey(const ValueKey('post-detail-bar-author'));
      final list = tester.state<ScrollableState>(
        find
            .descendant(
              of: find.byType(ListView),
              matching: find.byType(Scrollable),
            )
            .first,
      );

      // As abrupt as a scroll gets: straight past the header in one frame.
      list.position.jumpTo(600);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 60));
      // Not slammed in: the change has only begun, on its own clock.
      expect(title, findsOneWidget);
      expect(tester.widget<Opacity>(title).opacity, greaterThan(0));

      await tester.pumpAndSettle();
      expect(author, findsOneWidget);
      expect(title, findsNothing);
      expect(tester.widget<IgnorePointer>(author).ignoring, isFalse);

      // Back again: it runs back, from where it is, to "Post".
      list.position.jumpTo(0);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 60));
      expect(author, findsOneWidget, reason: 'on its way out, not gone');
      await tester.pumpAndSettle();
      expect(author, findsNothing);
      expect(tester.widget<Opacity>(title).opacity, 1);
    });

    testWidgets('changing direction mid-change turns it round smoothly', (
      tester,
    ) async {
      final long = FeedPost(
        id: 'p1',
        content:
            List.filled(60, 'A long walk along the harbour wall.').join(' '),
        createdAt: DateTime(2026, 10, 30),
        author: const FeedAuthor(id: 'ada', username: 'ada', name: 'Ada'),
      );
      await _page(tester, long);
      final title = find.byKey(const ValueKey('post-detail-bar-title'));
      final list = tester.state<ScrollableState>(
        find
            .descendant(
              of: find.byType(ListView),
              matching: find.byType(Scrollable),
            )
            .first,
      );

      list.position.jumpTo(600);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 80));
      final partway = tester.widget<Opacity>(title).opacity;
      list.position.jumpTo(0);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 16));
      // No jump back to the start: it carries on from where it was.
      expect(
        tester.widget<Opacity>(title).opacity,
        closeTo(partway, 0.25),
      );
      await tester.pumpAndSettle();
      expect(tester.widget<Opacity>(title).opacity, 1);
    });

    testWidgets('the title sits beside the back button, not across the bar', (
      tester,
    ) async {
      await _page(tester, _post());
      // From the arrow you see, not the button around it.
      final arrow = tester.getRect(find.byIcon(Iconsax.arrow_left_copy));
      final post = tester.getRect(find.text('Post'));
      expect(post.left - arrow.right, lessThanOrEqualTo(SpacingTokens.space16));
    });

    testWidgets(
        'a broken line between the counts and the buttons, solid around them',
        (tester) async {
      await _page(
        tester,
        FeedPost(
          id: 'p1',
          content: 'Autumn colours',
          createdAt: DateTime(2026, 10, 30),
          author: const FeedAuthor(id: 'ada', username: 'ada', name: 'Ada'),
          likes: 2,
        ),
      );

      final dots = find.byType(BrokenRuleLine);
      expect(dots, findsOneWidget);
      final counts = tester.getRect(find.textContaining('like'));
      final heart = tester.getRect(find.byIcon(Iconsax.heart_copy).first);
      final line = tester.getRect(dots);
      expect(line.top, greaterThan(counts.bottom));
      expect(line.bottom, lessThan(heart.top));
      // A solid line above the counts and one under the buttons.
      final solid = find.byType(RuleLine).evaluate().map(
            (e) => tester.getRect(find.byWidget(e.widget)),
          );
      expect(solid.where((r) => r.bottom < counts.top), isNotEmpty);
      expect(solid.where((r) => r.top > heart.bottom), isNotEmpty);
      // The reply box's own line: half a point, not a heavier bar.
      expect(tester.getSize(find.byType(RuleLine).first).height, 0.5);
      expect(tester.getSize(dots).height, 0.5);
    });

    testWidgets('with no counts, the buttons have solid lines only', (
      tester,
    ) async {
      await _page(tester, _post());
      expect(find.byType(BrokenRuleLine), findsNothing);
    });

    testWidgets('Follow is a 30-point pill with 13-point words', (
      tester,
    ) async {
      await _page(tester, _post());

      final pill = find.descendant(
        of: follow,
        matching: find.byType(AnimatedContainer),
      );
      expect(tester.getSize(pill).height, 30);
      final words = tester.widget<Text>(
        find.descendant(of: follow, matching: find.text('Follow')),
      );
      expect(words.style?.fontSize, TypographyTokens.fontSize2);
    });
  });
}
