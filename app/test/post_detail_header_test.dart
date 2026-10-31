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
import 'package:kyron_app/widgets/post_action_colors.dart';
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
}
