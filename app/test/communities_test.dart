import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/community.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/providers/communities_provider.dart';
import 'package:kyron_app/repositories/communities_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/community_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Down implements Exception {}

class _FakeCommunities extends CommunitiesRepository {
  _FakeCommunities({
    this.mineRows = const [],
    this.discoverRows = const [],
    this.fails = false,
  }) : super(ApiClient());

  final List<Community> mineRows;
  final List<Community> discoverRows;
  final bool fails;

  final List<(String, bool)> membership = [];
  final List<String?> searches = [];

  @override
  Future<CommunityPage> mine({String? cursor, int limit = 20}) async {
    if (fails) throw _Down();
    return CommunityPage(items: mineRows);
  }

  @override
  Future<CommunityPage> discover({String? query, int limit = 30}) async {
    searches.add(query);
    if (fails) throw _Down();
    return CommunityPage(items: discoverRows);
  }

  @override
  Future<Community> setMembership(String slug, bool joined) async {
    membership.add((slug, joined));
    if (fails) throw _Down();
    return _community(slug, joined: joined, members: joined ? 2 : 1);
  }

  @override
  Future<Community> bySlug(String slug) async {
    if (fails) throw _Down();
    return _community(slug, joined: false);
  }

  @override
  Future<FeedPost> post(
    String slug,
    String content, {
    List<PendingMedia> media = const [],
  }) async =>
      throw UnimplementedError();
}

Community _community(
  String slug, {
  bool joined = false,
  int members = 1,
  CommunityRole? role,
}) =>
    Community(
      id: 'id-$slug',
      slug: slug,
      name: slug,
      members: members,
      joined: joined,
      role: role,
    );

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  group('the role', () {
    test('lets a member leave', () {
      expect(CommunityRole.member.canLeave, isTrue);
      expect(CommunityRole.moderator.canLeave, isTrue);
    });

    test('does not let the owner leave', () {
      // That would leave nobody able to moderate it.
      expect(CommunityRole.owner.canLeave, isFalse);
    });

    test('reads what the server sends, and nothing it does not', () {
      expect(CommunityRole.fromWire('OWNER'), CommunityRole.owner);
      expect(CommunityRole.fromWire('MEMBER'), CommunityRole.member);
      expect(CommunityRole.fromWire('SOMETHING_NEW'), isNull);
      expect(CommunityRole.fromWire(null), isNull);
    });
  });

  group('who may post', () {
    test('members', () {
      expect(_community('a', joined: true).canPost, isTrue);
    });

    test('not everybody else', () {
      // A community anybody can post into is a feed with a name on it.
      expect(_community('a').canPost, isFalse);
    });
  });

  group('my communities', () {
    test('drops one that has been left', () async {
      final repo = _FakeCommunities(
        mineRows: [
          _community('a', joined: true),
          _community('b', joined: true)
        ],
      );
      final notifier = MyCommunitiesNotifier(repo);
      await pumpEventQueue();

      notifier.remove('id-a');

      expect(notifier.state.items.map((c) => c.slug), ['b']);
    });

    test('shows one that has just been joined without a round trip', () async {
      final repo = _FakeCommunities();
      final notifier = MyCommunitiesNotifier(repo);
      await pumpEventQueue();

      notifier.add(_community('a', joined: true));

      expect(notifier.state.items.single.slug, 'a');
    });

    test('will not show the same one twice', () async {
      final repo = _FakeCommunities(mineRows: [_community('a', joined: true)]);
      final notifier = MyCommunitiesNotifier(repo);
      await pumpEventQueue();

      notifier.add(_community('a', joined: true));

      expect(notifier.state.items, hasLength(1));
    });

    test('says why it could not be read', () async {
      final notifier = MyCommunitiesNotifier(_FakeCommunities(fails: true));
      await pumpEventQueue();
      expect(notifier.state.error, isNotNull);
    });
  });

  group('discover', () {
    test('drops one that has just been joined', () async {
      // Discover is what the reader is not in, so a joined community sitting
      // there with a Joined button is a shelf that never gets shorter.
      final repo = _FakeCommunities(
        discoverRows: [_community('a'), _community('b')],
      );
      final notifier = DiscoverCommunitiesNotifier(repo);
      await pumpEventQueue();

      notifier.joined('id-a');

      expect(notifier.state.items.map((c) => c.slug), ['b']);
    });

    test('passes a search to the server', () async {
      final repo = _FakeCommunities();
      final notifier = DiscoverCommunitiesNotifier(repo);
      await pumpEventQueue();

      await notifier.search('design');

      expect(repo.searches.last, 'design');
      expect(notifier.query, 'design');
    });
  });

  group('one community', () {
    test('joins, and takes the server\'s answer for what it now is', () async {
      final repo = _FakeCommunities();
      final notifier = CommunityNotifier(repo, 'a');
      await pumpEventQueue();

      final error = await notifier.toggleMembership();

      expect(error, isNull);
      expect(repo.membership, [('a', true)]);
      expect(notifier.state.community!.joined, isTrue);
      expect(notifier.state.community!.members, 2);
    });

    test('refuses to let the owner leave, without asking the server', () async {
      final repo = _FakeCommunities();
      final notifier = CommunityNotifier(repo, 'a');
      await pumpEventQueue();
      // Stand the state up as the owner, which is what bySlug would return
      // for a community this account started.
      notifier.state = CommunityState(
        community: _community('a', joined: true, role: CommunityRole.owner),
        loading: false,
      );

      final error = await notifier.toggleMembership();

      expect(error, isNotNull);
      expect(repo.membership, isEmpty);
    });
  });

  group('the tile', () {
    testWidgets('offers Join when the reader is not in it', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: CommunityTile(
                community: _community('design'),
                onOpen: () {},
              ),
            ),
          ),
        ),
      );
      expect(find.text('Join'), findsOneWidget);
      // One line, both numbers, and both of them real.
      expect(find.text('1 member · 0 posts'), findsOneWidget);
    });

    testWidgets('offers Joined when they are', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: CommunityTile(
                community: _community('design', joined: true, members: 12),
                onOpen: () {},
              ),
            ),
          ),
        ),
      );
      expect(find.text('Joined'), findsOneWidget);
      expect(find.textContaining('12 members'), findsOneWidget);
    });
  });
}
