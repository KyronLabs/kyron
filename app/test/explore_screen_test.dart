import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/models/explore_entry.dart';
import 'package:kyron_app/models/profile_summary.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/providers/explore_provider.dart';
import 'package:kyron_app/repositories/current_user_repository.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/repositories/profile_repository.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/screens/explore_screen.dart';
import 'package:kyron_app/screens/topic_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/app_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Thrown by a fake to stand in for the network being down.
class _Down implements Exception {}

class _FakeFeed extends FeedRepository {
  _FakeFeed({this.tags = const [], this.fails = false}) : super(ApiClient());

  final List<TrendingTag> tags;
  final bool fails;

  @override
  Future<List<TrendingTag>> trendingTags({int limit = 25}) async {
    if (fails) throw _Down();
    return tags;
  }
}

class _FakeProfile extends ProfileRepository {
  _FakeProfile({
    this.topicList = const [],
    this.people = const [],
    this.topicFails = false,
    this.toggleFails = false,
    this.peopleFails = false,
  }) : super(ApiClient());

  final List<Topic> topicList;
  final List<ProfileSummary> people;
  final bool topicFails;
  final bool toggleFails;
  final bool peopleFails;

  /// Every topic follow and unfollow asked for, in order.
  final List<(String, bool)> toggles = [];

  @override
  Future<List<Topic>> topics() async {
    if (topicFails) throw _Down();
    return topicList;
  }

  @override
  Future<int> setTopic(String slug, bool following) async {
    toggles.add((slug, following));
    if (topicFails || toggleFails) throw _Down();
    return following ? 101 : 99;
  }

  @override
  Future<SuggestionPage> suggested({int? cursor, int limit = 20}) async {
    if (peopleFails) throw _Down();
    return SuggestionPage(items: people, nextCursor: null);
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
        trendingProvider.overrideWith((ref) => TrendingNotifier(feedRepo)),
        topicsProvider.overrideWith((ref) => TopicsNotifier(profileRepo)),
        suggestedPeopleProvider
            .overrideWith((ref) => SuggestedPeopleNotifier(profileRepo)),
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
            onScrollProgress: (_) {},
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
}

Future<void> _openTab(WidgetTester tester, String name) async {
  await tester.tap(find.text(name));
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('hides the bottom bar on the way down, not on a tab swipe',
      (tester) async {
    final progress = <double>[];
    lastPush = null;
    final feed = _FakeFeed(tags: [
      for (var i = 0; i < 30; i++) TrendingTag(tag: 'tag$i', posts: i),
    ]);

    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentUserRepositoryProvider.overrideWithValue(_FakeUser()),
          trendingProvider.overrideWith((ref) => TrendingNotifier(feed)),
          topicsProvider.overrideWith((ref) => TopicsNotifier(_FakeProfile())),
          suggestedPeopleProvider
              .overrideWith((ref) => SuggestedPeopleNotifier(_FakeProfile())),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: ExploreScreen(
              drawerKey: GlobalKey<AppDrawerState>(),
              onScrollProgress: progress.add,
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    // Sideways between tabs: the bar has no business moving.
    await tester.drag(find.text('#tag0'), const Offset(-300, 0));
    await tester.pumpAndSettle();
    expect(progress, isEmpty);

    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(progress, contains(1.0));

    await tester.drag(find.byType(ListView), const Offset(0, 200));
    await tester.pumpAndSettle();
    expect(progress.last, 0.0);
  });

  group('Trending', () {
    testWidgets('shows the tags the server ranked, in that order',
        (tester) async {
      await _pump(
        tester,
        feed: _FakeFeed(tags: const [
          TrendingTag(tag: 'kyron', posts: 1284, recent: 96),
          TrendingTag(tag: 'lagos', posts: 3, recent: 3),
        ]),
      );

      expect(find.text('#kyron'), findsOneWidget);
      expect(find.text('#lagos'), findsOneWidget);
      // Two numbers, because they answer different questions: how big the tag
      // is, and why it is on this list at all.
      expect(find.text('1.2K posts · 96 this week'), findsOneWidget);
      expect(find.text('3 posts · 3 this week'), findsOneWidget);
    });

    testWidgets('counts one post as one post', (tester) async {
      await _pump(
        tester,
        feed: _FakeFeed(
          tags: const [TrendingTag(tag: 'kyron', posts: 1, recent: 1)],
        ),
      );
      expect(find.text('1 post · 1 this week'), findsOneWidget);
    });

    testWidgets('opens the tag', (tester) async {
      await _pump(
        tester,
        feed: _FakeFeed(tags: const [TrendingTag(tag: 'kyron', posts: 2)]),
      );

      await tester.tap(find.text('#kyron'));
      await tester.pumpAndSettle();

      expect(lastPush?.name, Routes.hashtag);
      expect(lastPush?.arguments, 'kyron');
    });

    testWidgets('says nothing is trending rather than showing filler',
        (tester) async {
      // The page this replaces showed twenty numbered rows whatever the
      // network held, so an empty one and a busy one looked the same.
      await _pump(tester);
      expect(find.text('Nothing is trending yet'), findsOneWidget);
      expect(find.textContaining('#'), findsNothing);
    });

    testWidgets('says so when it could not be read, and offers a retry',
        (tester) async {
      await _pump(tester, feed: _FakeFeed(fails: true));
      expect(find.text('Try again'), findsOneWidget);
    });
  });

  group('Topics', () {
    _FakeProfile withTopics() => _FakeProfile(topicList: const [
          Topic(
              slug: 'art', name: 'Art & Design', people: 1200, following: true),
          Topic(slug: 'code', name: 'Software', people: 1),
        ]);

    testWidgets('shows real names and how many people are into each',
        (tester) async {
      await _pump(tester, profile: withTopics());
      await _openTab(tester, 'Topics');

      expect(find.text('Art & Design'), findsOneWidget);
      expect(find.text('1.2K people'), findsOneWidget);
      expect(find.text('1 person'), findsOneWidget);
    });

    testWidgets('follows one without touching the others', (tester) async {
      final profile = withTopics();
      await _pump(tester, profile: profile);
      await _openTab(tester, 'Topics');

      await tester.tap(find.byTooltip('Follow Software'));
      await tester.pumpAndSettle();

      expect(profile.toggles, [('code', true)]);
      // Moved on screen at once, then corrected by the server's recount.
      expect(find.byTooltip('Stop following Software'), findsOneWidget);
      expect(find.text('101 people'), findsOneWidget);
    });

    testWidgets('unfollows one it already had', (tester) async {
      final profile = withTopics();
      await _pump(tester, profile: profile);
      await _openTab(tester, 'Topics');

      await tester.tap(find.byTooltip('Stop following Art & Design'));
      await tester.pumpAndSettle();

      expect(profile.toggles, [('art', false)]);
    });

    testWidgets('says so when the catalogue could not be read', (tester) async {
      await _pump(tester, profile: _FakeProfile(topicFails: true));
      await _openTab(tester, 'Topics');
      expect(find.text('Try again'), findsOneWidget);
    });

    testWidgets('the card opens the topic', (tester) async {
      await _pump(tester, profile: withTopics());
      await _openTab(tester, 'Topics');

      await tester.tap(find.text('Software'));
      await tester.pumpAndSettle();

      expect(lastPush?.name, Routes.topic);
      expect((lastPush?.arguments as TopicArgs).slug, 'code');
    });

    testWidgets('says there are none rather than inventing twenty',
        (tester) async {
      await _pump(tester);
      await _openTab(tester, 'Topics');
      expect(find.text('No topics yet'), findsOneWidget);
    });
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

  group('People', () {
    testWidgets('shows the accounts the server ranked', (tester) async {
      await _pump(
        tester,
        profile: _FakeProfile(people: const [
          ProfileSummary(id: 'a', name: 'Ada Bello', username: 'ada'),
        ]),
      );
      await _openTab(tester, 'People');

      expect(find.text('Ada Bello'), findsOneWidget);
      expect(find.text('@ada'), findsOneWidget);
    });

    testWidgets('says so when there is nobody left to suggest', (tester) async {
      await _pump(tester);
      await _openTab(tester, 'People');
      expect(find.text('Nobody left to suggest'), findsOneWidget);
    });

    testWidgets('offers a retry when it could not be read', (tester) async {
      await _pump(tester, profile: _FakeProfile(peopleFails: true));
      await _openTab(tester, 'People');
      expect(find.text('Try again'), findsOneWidget);
    });

    test('drops whoever has just been followed', () async {
      // A suggestion is an account the reader does not follow. Leaving one
      // here with a Following button on it is a list that never gets shorter
      // however much you use it.
      const ada = ProfileSummary(id: 'a', name: 'Ada');
      final notifier = SuggestedPeopleNotifier(
        _FakeProfile(
          people: const [ada, ProfileSummary(id: 'b', name: 'Tunde')],
        ),
      );
      await pumpEventQueue();
      expect(notifier.state.people, hasLength(2));

      notifier.followed(ada.copyWith(isFollowing: true));

      expect(notifier.state.people.map((p) => p.id), ['b']);
    });
  });
}
