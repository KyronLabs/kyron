import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/community.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/providers/communities_provider.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/repositories/communities_repository.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/screens/community_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// Leaving a community was one tap on a button in its header, labelled
/// "Joined". No question, nothing to say it had happened, and the button then
/// read "Join" -- which looks like it failed rather than like it worked.
///
/// These hold the two halves of the fix: the one-tap button is gone, and the
/// way out that replaced it asks first.
class _Repo extends CommunitiesRepository {
  _Repo(this._community) : super(ApiClient()..dio.interceptors.clear());

  Community _community;
  int memberships = 0;

  @override
  Future<Community> bySlug(String slug) async => _community;

  @override
  Future<Community> setMembership(String slug, bool joined) async {
    memberships++;
    return _community = _community.copyWith(joined: joined);
  }
}

class _Feed extends FeedRepository {
  _Feed() : super(ApiClient()..dio.interceptors.clear());
  @override
  Future<FeedPage> byCommunity(
    String slug, {
    String? cursor,
    int limit = 20,
  }) async =>
      const FeedPage(items: [], nextCursor: null);
}

const _joined = Community(
  id: 'c1',
  slug: 'gardeners',
  name: 'Gardeners',
  members: 1240,
  posts: 318,
  joined: true,
  role: CommunityRole.member,
);

void main() {
  Future<_Repo> open(WidgetTester tester, {bool joined = true}) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    tester.view.padding = const FakeViewPadding(top: 47, bottom: 34);
    addTearDown(tester.view.reset);

    final repo = _Repo(_joined.copyWith(joined: joined));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          communitiesRepositoryProvider.overrideWithValue(repo),
          feedRepositoryProvider.overrideWithValue(_Feed()),
        ],
        child: MaterialApp(
          theme: KyronTheme.lightTheme,
          home: const CommunityScreen(slug: 'gardeners'),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    return repo;
  }

  testWidgets('a member is offered no one-tap way out', (tester) async {
    await open(tester);
    expect(
      find.text('Joined'),
      findsNothing,
      reason: 'the button whose only action was to leave is back',
    );
    expect(
      find.text('Join'),
      findsNothing,
      reason: 'a member is being offered Join',
    );
  });

  testWidgets('somebody who is not a member can still join', (tester) async {
    final repo = await open(tester, joined: false);

    expect(find.text('Join'), findsOneWidget);
    await tester.tap(find.text('Join'));
    await tester.pumpAndSettle();

    expect(repo.memberships, 1, reason: 'Join did not join');
  });

  testWidgets('leaving is in the menu, and asks first', (tester) async {
    final repo = await open(tester);

    await tester.tap(find.byTooltip('This community'));
    await tester.pumpAndSettle();
    expect(find.text('Leave'), findsOneWidget);

    await tester.tap(find.text('Leave'));
    await tester.pumpAndSettle();

    // The question, not the deed.
    expect(find.text('Leave Gardeners?'), findsOneWidget);
    expect(repo.memberships, 0, reason: 'it left before asking');

    await tester.tap(find.text('Stay'));
    await tester.pumpAndSettle();
    expect(repo.memberships, 0, reason: 'Stay left anyway');
  });

  testWidgets('and leaves when the answer is yes', (tester) async {
    final repo = await open(tester);

    await tester.tap(find.byTooltip('This community'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Leave'));
    await tester.pumpAndSettle();
    // The dialog's button, not the sheet row that opened it -- both say
    // "Leave".
    await tester.tap(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.widgetWithText(TextButton, 'Leave'),
      ),
    );
    await tester.pumpAndSettle();

    expect(repo.memberships, 1, reason: 'saying Leave did not leave');

    // The toast that says so runs on a timer, and a timer still pending when
    // the tree comes down fails the test after it has already passed.
    await tester.pump(const Duration(seconds: 6));
    await tester.pumpAndSettle();
  });

  testWidgets('the menu is there for somebody who has not joined', (
    tester,
  ) async {
    // Share and Copy link are useful to anybody; only Leave is for members.
    await open(tester, joined: false);

    await tester.tap(find.byTooltip('This community'));
    await tester.pumpAndSettle();

    expect(find.text('Share this community'), findsOneWidget);
    expect(find.text('Leave'), findsNothing);
  });
}
