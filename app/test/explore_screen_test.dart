import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/community.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/models/explore_entry.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/models/profile_summary.dart';
import 'package:kyron_app/providers/communities_provider.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/providers/explore_provider.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/providers/profile_provider.dart';
import 'package:kyron_app/repositories/communities_repository.dart';
import 'package:kyron_app/repositories/current_user_repository.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/repositories/profile_repository.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/screens/explore_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/app_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Explore, on one page: a search box, people and communities to find, the
/// tags actually in use, and a grid of what people post.
///
/// It was three tabs, and all three were thin: a topic catalogue nobody had
/// filled, a "trending" list of tags used once each, and the people a tab
/// away -- while two posts in three carry a picture and Explore showed none.

/// Thrown by a fake to stand in for the network being down.
class _Down implements Exception {}

FeedPost _photo(String id, {int pictures = 1}) => FeedPost(
      id: id,
      content: 'post $id',
      createdAt: DateTime(2026, 10, 14),
      author: const FeedAuthor(id: 'someone', name: 'Someone'),
      media: [
        for (var i = 0; i < pictures; i++)
          PostMedia(
            id: '$id-$i',
            kind: MediaKind.image,
            url: 'https://cdn.invalid/$id-$i.jpg',
            width: 1000,
            height: 800,
          ),
      ],
    );

class _FakeFeed extends FeedRepository {
  _FakeFeed({this.tags = const [], this.posts = const [], this.fails = false})
      : super(ApiClient());

  final List<TrendingTag> tags;
  final List<FeedPost> posts;
  final bool fails;

  @override
  Future<List<TrendingTag>> trendingTags({int limit = 25}) async => tags;

  @override
  Future<FeedPage> explore({String? cursor, int limit = 30}) async {
    if (fails) throw _Down();
    return FeedPage(items: posts);
  }
}

class _FakeProfile extends ProfileRepository {
  _FakeProfile({
    this.topicList = const [],
    this.people = const [],
    this.toggleFails = false,
  }) : super(ApiClient());

  final List<Topic> topicList;
  final List<ProfileSummary> people;
  final bool toggleFails;

  final List<String> followed = [];

  @override
  Future<List<Topic>> topics() async => topicList;

  @override
  Future<int> setTopic(String slug, bool following) async {
    if (toggleFails) throw _Down();
    return following ? 101 : 99;
  }

  @override
  Future<SuggestionPage> suggested({int? cursor, int limit = 20}) async =>
      SuggestionPage(items: people);

  @override
  Future<void> follow(String userId) async => followed.add(userId);
}

class _FakeCommunities extends CommunitiesRepository {
  _FakeCommunities(this.discoverable) : super(ApiClient());

  final List<Community> discoverable;
  final List<String> joined = [];

  @override
  Future<CommunityPage> discover({String? query, int limit = 30}) async =>
      CommunityPage(items: discoverable);

  @override
  Future<CommunityPage> mine({
    String? cursor,
    int limit = 20,
    CommunityFilter filter = CommunityFilter.all,
  }) async =>
      const CommunityPage();

  @override
  Future<Community> setMembership(String slug, bool join) async {
    joined.add(slug);
    final c = discoverable.firstWhere((c) => c.slug == slug);
    return Community(
      id: c.id,
      slug: c.slug,
      name: c.name,
      members: c.members + 1,
      posts: c.posts,
      joined: true,
      role: CommunityRole.member,
    );
  }
}

/// The app-bar avatar reads the signed-in account, which is a request.
class _FakeUser implements CurrentUserRepository {
  @override
  Future<CurrentUser> fetchMe({bool force = false}) async =>
      CurrentUser.fromJson(const {'id': 'me', 'username': 'me'});
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

/// The route the screen last pushed, and what it carried.
RouteSettings? lastPush;

Future<void> _pump(
  WidgetTester tester, {
  _FakeFeed? feed,
  _FakeProfile? profile,
  _FakeCommunities? communities,
  void Function(double)? onScrollProgress,
}) async {
  lastPush = null;
  final feedRepo = feed ?? _FakeFeed();
  final profileRepo = profile ?? _FakeProfile();

  tester.view.physicalSize = const Size(1080, 2340);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentUserRepositoryProvider.overrideWithValue(_FakeUser()),
        feedRepositoryProvider.overrideWithValue(feedRepo),
        profileRepositoryProvider.overrideWithValue(profileRepo),
        trendingProvider.overrideWith((ref) => TrendingNotifier(feedRepo)),
        topicsProvider.overrideWith((ref) => TopicsNotifier(profileRepo)),
        suggestedPeopleProvider.overrideWith(
          (ref) => SuggestedPeopleNotifier(profileRepo),
        ),
        communitiesRepositoryProvider.overrideWithValue(
          communities ?? _FakeCommunities(const []),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: (settings) {
          lastPush = settings;
          return MaterialPageRoute<void>(
            builder: (_) => const Scaffold(body: Text('pushed')),
          );
        },
        home: Scaffold(
          body: ExploreScreen(
            drawerKey: GlobalKey<AppDrawerState>(),
            onScrollProgress: onScrollProgress ?? (_) {},
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
}

const _ada = ProfileSummary(id: 'a', name: 'Ada Bello', username: 'ada');
const _chess = Community(
  id: 'c1',
  slug: 'chess',
  name: 'Lagos Chess',
  members: 48,
  posts: 3,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('is one page: no tabs, and no Topics', (tester) async {
    // The topic catalogue was empty and nobody could use it.
    await _pump(tester);
    expect(find.byType(TabBar), findsNothing);
    expect(find.text('Topics'), findsNothing);
  });

  testWidgets('the search box opens search', (tester) async {
    await _pump(tester);
    await tester.tap(find.byKey(const ValueKey('explore-search')));
    await tester.pumpAndSettle();
    expect(lastPush?.name, Routes.search);
  });

  group('people', () {
    testWidgets('are cards to follow, and a followed one leaves', (
      tester,
    ) async {
      final profile = _FakeProfile(people: const [_ada]);
      await _pump(tester, profile: profile);

      expect(find.text('Ada Bello'), findsOneWidget);
      expect(find.text('@ada'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('explore-follow-a')));
      await tester.pumpAndSettle();

      expect(profile.followed, ['a']);
      // Not a suggestion once followed.
      expect(find.text('Ada Bello'), findsNothing);
    });

    testWidgets('a card opens the profile', (tester) async {
      await _pump(tester, profile: _FakeProfile(people: const [_ada]));
      await tester.tap(find.text('Ada Bello'));
      await tester.pumpAndSettle();
      expect(lastPush?.name, Routes.profile);
    });

    testWidgets('no heading over nobody', (tester) async {
      await _pump(tester);
      expect(find.text('Discover people'), findsNothing);
    });
  });

  group('communities', () {
    testWidgets('are cards to join, and a joined one leaves', (tester) async {
      final communities = _FakeCommunities(const [_chess]);
      await _pump(tester, communities: communities);

      expect(find.text('Communities to join'), findsOneWidget);
      expect(find.text('Lagos Chess'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('explore-join-c1')));
      await tester.pumpAndSettle();

      expect(communities.joined, ['chess']);
      expect(find.text('Lagos Chess'), findsNothing);
    });

    testWidgets('a card opens the community', (tester) async {
      await _pump(tester, communities: _FakeCommunities(const [_chess]));
      await tester.tap(find.text('Lagos Chess'));
      await tester.pumpAndSettle();
      expect(lastPush?.name, Routes.community);
      expect(lastPush?.arguments, 'chess');
    });
  });

  group('trending tags', () {
    testWidgets('only the ones in use, and only once there are a few', (
      tester,
    ) async {
      // Almost every tag here has been used once. A ranking of those is a
      // list in no order.
      await _pump(
        tester,
        feed: _FakeFeed(
          tags: const [
            TrendingTag(tag: 'birds', posts: 9, recent: 4),
            TrendingTag(tag: 'lagos', posts: 3, recent: 2),
            TrendingTag(tag: 'once', posts: 1, recent: 1),
          ],
        ),
      );
      expect(find.text('Trending now'), findsNothing);
      expect(find.text('#birds'), findsNothing);
    });

    testWidgets('shows them, and a tag opens its posts', (tester) async {
      await _pump(
        tester,
        feed: _FakeFeed(
          tags: const [
            TrendingTag(tag: 'birds', posts: 9, recent: 4),
            TrendingTag(tag: 'lagos', posts: 3, recent: 3),
            TrendingTag(tag: 'film', posts: 5, recent: 2),
            TrendingTag(tag: 'once', posts: 1, recent: 1),
          ],
        ),
      );
      expect(find.text('Trending now'), findsOneWidget);
      expect(find.text('#birds'), findsOneWidget);
      expect(find.text('#once'), findsNothing);

      await tester.tap(find.text('#lagos'));
      await tester.pumpAndSettle();
      expect(lastPush?.name, Routes.hashtag);
      expect(lastPush?.arguments, 'lagos');
    });

    test('the rule, on its own', () {
      expect(
        trendingNow(const [
          TrendingTag(tag: 'a', posts: 5, recent: 2),
          TrendingTag(tag: 'b', posts: 5, recent: 1),
        ]).map((t) => t.tag),
        ['a'],
      );
    });
  });

  group('the grid', () {
    testWidgets('shows what people post, three across', (tester) async {
      await _pump(
        tester,
        feed: _FakeFeed(
          posts: [for (var i = 0; i < 6; i++) _photo('p$i')],
        ),
      );
      expect(find.text('Photos and clips'), findsOneWidget);
      expect(find.byKey(const ValueKey('explore-grid')), findsOneWidget);

      final first = tester.getSize(find.byType(Image).first);
      // A third of a 360-wide screen, less the gaps.
      expect(first.width, lessThan(125));
    });

    testWidgets('a tile opens its post', (tester) async {
      await _pump(tester, feed: _FakeFeed(posts: [_photo('p0')]));
      await tester.tap(find.byType(Image).first);
      await tester.pumpAndSettle();
      expect(lastPush?.name, Routes.postDetail);
      expect(lastPush?.arguments, 'p0');
    });

    testWidgets('says so when there is nothing yet', (tester) async {
      await _pump(tester);
      expect(find.text('Nothing to look at yet'), findsOneWidget);
    });

    testWidgets('offers a retry when it could not be read', (tester) async {
      await _pump(tester, feed: _FakeFeed(fails: true));
      expect(find.text('Try again'), findsOneWidget);
    });
  });

  testWidgets('hides the bottom bar on the way down, not on a sideways strip', (
    tester,
  ) async {
    final progress = <double>[];
    await _pump(
      tester,
      profile: _FakeProfile(
        people: [
          for (var i = 0; i < 8; i++)
            ProfileSummary(id: 'p$i', name: 'Person $i', username: 'p$i'),
        ],
      ),
      feed: _FakeFeed(posts: [for (var i = 0; i < 30; i++) _photo('g$i')]),
      onScrollProgress: progress.add,
    );

    await tester.drag(
      find.byKey(const ValueKey('explore-people')),
      const Offset(-300, 0),
    );
    await tester.pumpAndSettle();
    expect(progress, isEmpty);

    await tester.drag(
      find.byKey(const ValueKey('explore-scroll')),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    expect(progress, contains(1.0));

    await tester.drag(
      find.byKey(const ValueKey('explore-scroll')),
      const Offset(0, 200),
    );
    await tester.pumpAndSettle();
    expect(progress.last, 0.0);
  });

  group('the topic toggle', () {
    test('puts the tick and the count back when the request fails', () async {
      // Moved on screen before the round trip, so a tap is answered at once.
      // Which means a failure has to put it back, or the card says the reader
      // follows something they do not.
      final repo = _FakeProfile(
        topicList: const [Topic(slug: 'code', name: 'Software', people: 40)],
        toggleFails: true,
      );
      final notifier = TopicsNotifier(repo);
      await pumpEventQueue();

      final before = notifier.state.items.single;
      final error = await notifier.toggle(before);

      expect(error, isNotNull);
      expect(notifier.state.items.single.following, isFalse);
      expect(notifier.state.items.single.people, 40);
    });

    test('takes the server\'s recount over its own guess', () async {
      final repo = _FakeProfile(
        topicList: const [Topic(slug: 'code', name: 'Software', people: 40)],
      );
      final notifier = TopicsNotifier(repo);
      await pumpEventQueue();

      await notifier.toggle(notifier.state.items.single);

      // Not 41: other people are choosing topics too.
      expect(notifier.state.items.single.people, 101);
    });
  });

  group('suggested people', () {
    test('drops whoever has just been followed', () async {
      // A suggestion is an account the reader does not follow. Leaving one
      // here with a Following button on it is a list that never gets shorter
      // however much you use it.
      const ada = ProfileSummary(id: 'a', name: 'Ada');
      final notifier = SuggestedPeopleNotifier(
        _FakeProfile(
          people: const [
            ada,
            ProfileSummary(id: 'b', name: 'Tunde'),
          ],
        ),
      );
      await pumpEventQueue();
      expect(notifier.state.people, hasLength(2));

      notifier.followed(ada.copyWith(isFollowing: true));

      expect(notifier.state.people.map((p) => p.id), ['b']);
    });
  });
}
