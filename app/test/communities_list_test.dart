import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/action_button.dart';
import 'package:kyron_app/widgets/hairline.dart';
import 'package:kyron_app/l10n/app_localizations.dart';
import 'package:kyron_app/models/community.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/providers/communities_provider.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/repositories/communities_repository.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/screens/communities_screen.dart';
import 'package:kyron_app/screens/community_settings_screen.dart';
import 'package:kyron_app/screens/new_community_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/utils/conversation_text.dart';
import 'package:kyron_app/widgets/app_drawer.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Communities laid out like Messages: a row per community saying what was
/// posted last and how much is new, a filter menu and a Discover chip in
/// place of two tabs, and New community and settings at the top.
final _l10n = AppLocalizations();

CommunityLastPost _post({
  String authorId = 'ada',
  String? authorName = 'Ada',
  String body = 'the light this morning',
  List<MediaKind> media = const [],
  DateTime? at,
}) =>
    CommunityLastPost(
      id: 'p',
      authorId: authorId,
      authorName: authorName,
      body: body,
      media: media,
      createdAt: at ?? DateTime(2026, 10, 12, 9, 41),
    );

Community _community(
  String slug, {
  CommunityLastPost? last,
  int unread = 0,
  CommunityRole role = CommunityRole.member,
  bool joined = true,
}) =>
    Community(
      id: 'id-$slug',
      slug: slug,
      name: slug[0].toUpperCase() + slug.substring(1),
      members: 3,
      joined: joined,
      role: joined ? role : null,
      lastPost: last,
      unread: unread,
      lastActivityAt: last?.createdAt ?? DateTime(2026, 10, 1),
    );

class _Repo extends CommunitiesRepository {
  _Repo({
    Map<CommunityFilter, List<Community>> mine = const {},
    this.discoverRows = const [],
  })  : mineRows = {...mine},
        super(ApiClient()..dio.interceptors.clear());

  final Map<CommunityFilter, List<Community>> mineRows;
  final List<Community> discoverRows;

  final List<CommunityFilter> asked = [];
  final List<String> searches = [];
  final List<String> read = [];
  final List<String> created = [];
  final List<bool> homeChanges = [];
  bool inHome = true;
  bool failHome = false;

  @override
  Future<CommunityPage> mine({
    String? cursor,
    int limit = 20,
    CommunityFilter filter = CommunityFilter.all,
  }) async {
    asked.add(filter);
    return CommunityPage(items: mineRows[filter] ?? const []);
  }

  @override
  Future<CommunityPage> discover({String? query, int limit = 30}) async {
    searches.add(query ?? '');
    final q = (query ?? '').toLowerCase();
    return CommunityPage(
      items: [
        for (final c in discoverRows)
          if (q.isEmpty || c.slug.contains(q)) c,
      ],
    );
  }

  @override
  Future<Community> create(String name, {String? description}) async {
    created.add(name);
    return _community(name.toLowerCase(), role: CommunityRole.owner);
  }

  @override
  Future<Community> bySlug(String slug) async => _community(slug);

  @override
  Future<void> markRead(String slug) async => read.add(slug);

  final List<String> joined = [];

  @override
  Future<Community> setMembership(String slug, bool join) async {
    joined.add(slug);
    return _community(slug);
  }

  @override
  Future<bool> postsInHome() async => inHome;

  @override
  Future<bool> setPostsInHome(bool on) async {
    if (failHome) throw StateError('down');
    homeChanges.add(on);
    return inHome = on;
  }
}

class _Me extends CurrentUserNotifier {
  _Me(super.ref);

  @override
  Future<void> load({bool force = false}) async {
    state = const AsyncData(
      CurrentUser(id: 'me', name: 'Me', followers: 0, following: 0, posts: 0),
    );
  }
}

Future<_Repo> _pump(
  WidgetTester tester,
  Widget home, {
  _Repo? repo,
  List<RouteSettings>? routes,
}) async {
  tester.view.physicalSize = const Size(1170, 2532);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final r = repo ?? _Repo();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentUserProvider.overrideWith((ref) => _Me(ref)),
        communitiesRepositoryProvider.overrideWithValue(r),
      ],
      child: MaterialApp(
        theme: KyronTheme.lightTheme,
        home: home,
        onGenerateRoute: (settings) {
          routes?.add(settings);
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (_) => Scaffold(body: Text('route ${settings.name}')),
          );
        },
      ),
    ),
  );
  await tester.pumpAndSettle();
  return r;
}

Widget _communities() => Scaffold(
      body: CommunitiesScreen(
        drawerKey: GlobalKey<AppDrawerState>(),
        onScrollProgress: (_) {},
      ),
    );

String _text(WidgetTester tester, String key) =>
    tester.widget<Text>(find.byKey(ValueKey(key))).data!;

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
  });

  group('a community’s newest post, in a line', () {
    test('says who wrote it, and "You:" for the reader’s own', () {
      expect(
        communityPreview(_l10n, _post(), mine: false),
        'Ada: the light this morning',
      );
      expect(
        communityPreview(_l10n, _post(), mine: true),
        'You: the light this morning',
      );
    });

    test('says what a post with no words carries', () {
      expect(
        communityPreview(
          _l10n,
          _post(body: '', media: [MediaKind.image, MediaKind.image]),
          mine: false,
        ),
        'Ada: Photos',
      );
    });

    test('on one line, and someone when there is no name', () {
      expect(
        communityPreview(
          _l10n,
          _post(body: 'two\nlines', authorName: ' '),
          mine: false,
        ),
        'Someone: two lines',
      );
    });

    test('says so when nothing has been posted', () {
      expect(communityPreview(_l10n, null, mine: false), 'No posts yet');
    });
  });

  test('reads what the server sends about a community’s activity', () {
    final community = Community.fromJson({
      'id': 'c1',
      'slug': 'gardeners',
      'name': 'Gardeners',
      'joined': true,
      'unread': 4,
      'lastActivityAt': '2026-10-12T09:00:00.000Z',
      'lastPost': {
        'id': 'p1',
        'authorId': 'ada',
        'authorName': 'Ada',
        'body': 'tomatoes',
        'media': ['IMAGE', 'VIDEO'],
        'createdAt': '2026-10-12T09:00:00.000Z',
      },
    });

    expect(community.unread, 4);
    expect(community.lastActivityAt, isNotNull);
    expect(community.lastPost!.media, [MediaKind.image, MediaKind.video]);
    // An older server sends none of it, and that is no posts and nothing new.
    final old = Community.fromJson({'id': 'c', 'slug': 'c', 'name': 'C'});
    expect(old.lastPost, isNull);
    expect(old.unread, 0);
  });

  group('opening a community', () {
    test('clears its count, and takes it off the New posts list', () async {
      final repo = _Repo(
        mine: {
          CommunityFilter.all: [_community('a', unread: 3)],
          CommunityFilter.unread: [_community('a', unread: 3)],
        },
      );
      final all = MyCommunitiesNotifier(repo);
      final fresh = MyCommunitiesNotifier(repo, filter: CommunityFilter.unread);
      await pumpEventQueue();

      all.seen('id-a');
      fresh.seen('id-a');

      expect(all.state.items.single.unread, 0);
      expect(fresh.state.items, isEmpty);
    });

    test('tells the server, for a member only', () async {
      final opened = <String>[];
      CommunityNotifier(_Repo(), 'a', onOpened: (c) => opened.add(c.slug));
      await pumpEventQueue();
      expect(opened, ['a']);
    });
  });

  group('the list', () {
    testWidgets('says what was posted last, when, and how much is new', (
      tester,
    ) async {
      final today = DateTime.now();
      await _pump(
        tester,
        _communities(),
        repo: _Repo(
          mine: {
            CommunityFilter.all: [
              _community(
                'gardeners',
                last: _post(
                  at: DateTime(today.year, today.month, today.day, 9, 41),
                ),
                unread: 3,
              ),
              _community(
                'design',
                last: _post(authorId: 'me', body: 'shipped it'),
              ),
              _community('quiet'),
            ],
          },
        ),
      );

      expect(
        _text(tester, 'community-preview-id-gardeners'),
        'Ada: the light this morning',
      );
      expect(_text(tester, 'community-preview-id-design'), 'You: shipped it');
      expect(_text(tester, 'community-preview-id-quiet'), 'No posts yet');
      expect(find.text('3'), findsOneWidget);
      // No time on the card: it was the loudest thing on it, and the order
      // of the list already says which community moved last.
      expect(find.text('Last post'), findsNothing);
      expect(find.textContaining('9:41'), findsNothing);
      // No tabs, and no floating button: the bar at the top does that job.
      expect(find.byType(TabBar), findsNothing);
      expect(find.byType(FloatingActionButton), findsNothing);
    });

    testWidgets('a row is the row: no Open button, no footer, no card', (
      tester,
    ) async {
      // Open did what tapping the card did, and the footer under a rule said
      // when the last post was in type bigger than the post. Then the cards
      // themselves went: rows on the page, like every other list in Kyron.
      await _pump(
        tester,
        _communities(),
        repo: _Repo(
          mine: {
            CommunityFilter.all: [
              _community('busy', last: _post(), unread: 2),
              _community('calm', last: _post()),
            ],
          },
        ),
      );

      expect(find.text('Open'), findsNothing);
      expect(find.text('Catch up'), findsNothing);
      expect(find.text('None yet'), findsNothing);
      expect(
        tester
            .widget<Text>(find.byKey(const ValueKey('community-meta-id-busy')))
            .data,
        'Members: 3',
      );
      // Writing is the one thing worth a button, at Follow's size.
      expect(
        tester.getSize(find.byKey(const ValueKey('community-write-id-busy'))),
        const Size.square(ActionButton.compactHeight),
      );
      // The full width of the screen, on the page, a hairline between two.
      final row = find.byKey(const ValueKey('community-id-busy'));
      expect(
        tester.getSize(row).width,
        tester.getSize(find.byType(Scaffold)).width,
      );
      expect(
        find.ancestor(
          of: row,
          matching: find.byWidgetPredicate(
            (w) => w is Material && w.borderRadius != null,
          ),
        ),
        findsNothing,
      );
      expect(
        find.descendant(
          of: find.byType(ListView),
          matching: find.byType(Hairline),
        ),
        findsOneWidget,
      );
      // Two lines of the newest post at most under the name.
      expect(tester.getSize(row).height, lessThan(140));
    });

    testWidgets('names the reader’s role beside the members', (tester) async {
      await _pump(
        tester,
        _communities(),
        repo: _Repo(
          mine: {
            CommunityFilter.all: [
              _community('mine', role: CommunityRole.owner),
            ],
          },
        ),
      );

      expect(_text(tester, 'community-meta-id-mine'), 'Members: 3 · Owner');
    });

    testWidgets('leaves the count off when the reader asked for that', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({'pref_community_counts': false});
      await _pump(
        tester,
        _communities(),
        repo: _Repo(
          mine: {
            CommunityFilter.all: [_community('a', last: _post(), unread: 3)],
          },
        ),
      );

      expect(find.text('3'), findsNothing);
    });

    testWidgets(
        'the filter menu asks the server for New posts, then Yours to '
        'run', (tester) async {
      final repo = await _pump(
        tester,
        _communities(),
        repo: _Repo(
          mine: {
            CommunityFilter.all: [_community('a'), _community('b')],
            CommunityFilter.unread: [_community('b', unread: 1)],
            CommunityFilter.running: [
              _community('a', role: CommunityRole.owner),
            ],
          },
        ),
      );

      await tester.tap(find.byKey(const ValueKey('communities-filter')));
      await tester.pumpAndSettle();
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Yours to run'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('community-filter-unread')));
      await tester.pumpAndSettle();

      expect(repo.asked, contains(CommunityFilter.unread));
      expect(find.byKey(const ValueKey('community-id-b')), findsOneWidget);
      expect(find.byKey(const ValueKey('community-id-a')), findsNothing);
      // The chip says which is in force.
      expect(find.text('New posts'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('communities-filter')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('community-filter-running')));
      await tester.pumpAndSettle();

      expect(repo.asked, contains(CommunityFilter.running));
      expect(find.byKey(const ValueKey('community-id-a')), findsOneWidget);
    });

    testWidgets('the search box narrows the list by name', (tester) async {
      await _pump(
        tester,
        _communities(),
        repo: _Repo(
          mine: {
            CommunityFilter.all: [
              _community('gardeners'),
              _community('design'),
            ],
          },
        ),
      );

      await tester.enterText(
        find.byKey(const ValueKey('communities-search')),
        'gard',
      );
      await tester.pumpAndSettle();

      expect(
          find.byKey(const ValueKey('community-id-gardeners')), findsOneWidget);
      expect(find.byKey(const ValueKey('community-id-design')), findsNothing);
    });

    testWidgets(
        'Discover offers what the reader is not in, searched on the '
        'server', (tester) async {
      final repo = await _pump(
        tester,
        _communities(),
        repo: _Repo(
          discoverRows: [
            _community('runners', joined: false),
            _community('bakers', joined: false),
          ],
        ),
      );

      await tester.tap(find.byKey(const ValueKey('communities-discover')));
      await tester.pumpAndSettle();
      expect(find.text('Join'), findsNWidgets(2));

      await tester.enterText(
        find.byKey(const ValueKey('communities-search')),
        'bak',
      );
      // A frame for the list to hear of the new words, then the pause before
      // it asks: not a request per keystroke.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pumpAndSettle();

      expect(repo.searches.last, 'bak');
      expect(find.byKey(const ValueKey('discover-id-bakers')), findsOneWidget);
      expect(find.byKey(const ValueKey('discover-id-runners')), findsNothing);
    });

    testWidgets(
        'Join on a Discover card joins, and moves it to the reader’s '
        'list', (tester) async {
      final repo = await _pump(
        tester,
        _communities(),
        repo: _Repo(discoverRows: [_community('runners', joined: false)]),
      );

      await tester.tap(find.byKey(const ValueKey('communities-discover')));
      await tester.pumpAndSettle();
      // The filter only ever applied to the reader's own communities, so it
      // is not offered here.
      expect(find.byKey(const ValueKey('communities-filter')), findsNothing);
      // Join is the Follow button: same size, same weight.
      expect(
        tester
            .getSize(find.byKey(const ValueKey('discover-join-id-runners')))
            .height,
        ActionButton.compactHeight,
      );
      await tester.tap(find.byKey(const ValueKey('discover-join-id-runners')));
      await tester.pumpAndSettle();

      expect(repo.joined, ['runners']);
      expect(find.byKey(const ValueKey('discover-id-runners')), findsNothing);

      await tester.tap(find.byKey(const ValueKey('communities-discover')));
      await tester.pumpAndSettle();
      expect(
          find.byKey(const ValueKey('community-id-runners')), findsOneWidget);
    });

    testWidgets('the bar starts a community and opens community settings', (
      tester,
    ) async {
      final routes = <RouteSettings>[];
      await _pump(tester, _communities(), routes: routes);

      await tester.tap(find.byKey(const ValueKey('communities-new')));
      await tester.pumpAndSettle();
      expect(routes.last.name, Routes.newCommunity);

      Navigator.of(tester.element(find.text('route ${Routes.newCommunity}')))
          .pop();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('communities-settings')));
      await tester.pumpAndSettle();
      expect(routes.last.name, Routes.communitySettings);
    });

    testWidgets('a row opens its community', (tester) async {
      final routes = <RouteSettings>[];
      await _pump(
        tester,
        _communities(),
        routes: routes,
        repo: _Repo(mine: {
          CommunityFilter.all: [_community('gardeners')]
        }),
      );

      await tester.tap(find.byKey(const ValueKey('community-id-gardeners')));
      await tester.pumpAndSettle();

      expect(routes.last.name, Routes.community);
      expect(routes.last.arguments, 'gardeners');
    });
  });

  group('a new community', () {
    testWidgets(
        'shows its address as the name is typed, and opens it once '
        'made', (tester) async {
      final routes = <RouteSettings>[];
      final repo =
          await _pump(tester, const NewCommunityScreen(), routes: routes);

      expect(
        _text(tester, 'new-community-address'),
        'Its address is made from the name.',
      );
      await tester.enterText(
        find.byKey(const ValueKey('new-community-name')),
        'Lagos Design',
      );
      await tester.pump();
      expect(
        _text(tester, 'new-community-address'),
        'People will find it at c/lagos-design',
      );

      await tester.tap(find.byKey(const ValueKey('new-community-create')));
      await tester.pumpAndSettle();

      expect(repo.created, ['Lagos Design']);
      expect(routes.last.name, Routes.community);
      expect(routes.last.arguments, 'lagos design');
    });

    testWidgets('cannot be made without a name', (tester) async {
      await _pump(tester, const NewCommunityScreen());

      final button = tester.widget<FilledButton>(
        find.byKey(const ValueKey('new-community-create')),
      );
      expect(button.onPressed, isNull);
    });
  });

  group('community settings', () {
    testWidgets(
        'whether posts appear in Home is the server’s, and a refusal '
        'puts the switch back', (tester) async {
      final repo = await _pump(tester, const CommunitySettingsScreen());

      await tester.tap(find.byKey(const ValueKey('setting-community-home')));
      await tester.pumpAndSettle();
      expect(repo.homeChanges, [false]);

      repo.failHome = true;
      await tester.tap(find.byKey(const ValueKey('setting-community-home')));
      await tester.pumpAndSettle();
      final tile = tester.widget<SwitchListTile>(
        find.byKey(const ValueKey('setting-community-home')),
      );
      expect(tile.value, isFalse);
      // The toast that said why goes on its own.
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('new-post counts are kept on this phone', (tester) async {
      await _pump(tester, const CommunitySettingsScreen());

      await tester.tap(find.byKey(const ValueKey('setting-community-counts')));
      await tester.pumpAndSettle();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('pref_community_counts'), isFalse);
    });

    testWidgets('lists the communities the reader runs', (tester) async {
      await _pump(
        tester,
        const CommunitySettingsScreen(),
        repo: _Repo(
          mine: {
            CommunityFilter.running: [
              _community('gardeners', role: CommunityRole.owner),
              _community('design', role: CommunityRole.moderator),
            ],
          },
        ),
      );

      expect(find.byKey(const ValueKey('setting-run-id-gardeners')),
          findsOneWidget);
      expect(find.text('Owner'), findsOneWidget);
      expect(find.text('Moderator'), findsOneWidget);
    });
  });
}
