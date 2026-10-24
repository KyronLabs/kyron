import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/community.dart';
import 'package:kyron_app/models/community_chat.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_comment.dart';
import 'package:kyron_app/providers/communities_provider.dart';
import 'package:kyron_app/providers/community_chats_provider.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/repositories/communities_repository.dart';
import 'package:kyron_app/repositories/current_user_repository.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/screens/community_screen.dart';
import 'package:kyron_app/screens/post_detail_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/community_avatar.dart';
import 'package:kyron_app/widgets/post_card.dart';
import 'package:kyron_app/widgets/squircle.dart';
import 'package:kyron_app/widgets/post_list_view.dart';
import 'package:kyron_app/widgets/community_chats_section.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The community page lists its chats; these tests are about the rest of it.
final _noChats = communityChatsProvider.overrideWith(
  (ref, slug) async => const <CommunityChat>[],
);

const _gardeners = PostCommunity(
  id: 'c1',
  slug: 'gardeners',
  name: 'Gardeners',
);

FeedPost _post({PostCommunity? community}) => FeedPost(
      id: 'p1',
      content: 'the tomatoes are in',
      createdAt: DateTime(2026, 1, 1),
      author: const FeedAuthor(id: 'u1', username: 'ada', name: 'Ada'),
      community: community,
    );

/// Answers with nothing, so no screen here reaches a network. The post card
/// reads the feed provider for its action row, and the community page pages
/// through the community's own posts.
class _Feed extends FeedRepository {
  _Feed() : super(ApiClient());

  @override
  Future<FeedPage> recent({String? cursor, int limit = 20}) async =>
      const FeedPage(items: [], nextCursor: null);

  @override
  Future<FeedPage> byCommunity(
    String slug, {
    String? cursor,
    int limit = 20,
  }) async =>
      const FeedPage(items: [], nextCursor: null);
}

/// Stands in for the app's routes and remembers where each tap went, so a
/// test can say where it led without building the screen at the other end.
class _Pushes {
  final List<String?> names = [];

  Route<dynamic> route(RouteSettings settings) {
    names.add(settings.name);
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => const SizedBox.shrink(),
    );
  }
}

Future<void> _card(
  WidgetTester tester,
  FeedPost post, {
  _Pushes? pushes,
  PostListSource source = PostListSource.recent,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        _noChats,
        feedRepositoryProvider.overrideWithValue(_Feed()),
        // Tapping the community's name opens its page, which loads it.
        communitiesRepositoryProvider.overrideWithValue(
          _OneCommunity(
            const Community(id: 'c1', slug: 'gardeners', name: 'Gardeners'),
          ),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: pushes?.route ?? Routes.onGenerateRoute,
        home: Scaffold(
          body: SingleChildScrollView(
            child: PostCard(post: post, source: source),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

/// One community post, with nobody yet replying to it.
class _OnePost extends _Feed {
  @override
  Future<FeedPost> byId(String postId) async => _post(community: _gardeners);

  @override
  Future<CommentPage> comments(
    String postId, {
    String? cursor,
    int limit = 20,
  }) async =>
      const CommentPage(items: []);

  @override
  Future<void> recordView(String postId, {int? dwellMs}) async {}
}

/// Somebody signed in, without asking a server who.
class _Me implements CurrentUserRepository {
  @override
  Future<CurrentUser> fetchMe({bool force = false}) async =>
      CurrentUser.fromJson(const {'id': 'me', 'username': 'me'});

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _OneCommunity extends CommunitiesRepository {
  _OneCommunity(this.community) : super(ApiClient());

  final Community community;

  @override
  Future<Community> bySlug(String slug) async => community;

  @override
  Future<void> markRead(String slug) async {}
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  group('a post from a community', () {
    testWidgets('says which community it came from', (tester) async {
      // Without it, a post from a place you joined arriving in the home feed
      // reads as somebody posting to everybody.
      await _card(tester, _post(community: _gardeners));

      expect(find.text('Gardeners'), findsOneWidget);
    });

    testWidgets("stacks the author in front of the community's picture", (
      tester,
    ) async {
      // In a feed a post from a place reads as from that place at a glance.
      // It was the author alone for a day, and missed.
      await _card(tester, _post(community: _gardeners));

      final stack = find.byType(StackedPostAvatar);
      expect(stack, findsOneWidget);
      expect(
        find.descendant(of: stack, matching: find.byType(Squircle)),
        findsOneWidget,
      );
      expect(
        find.descendant(of: stack, matching: find.byType(PostAvatar)),
        findsOneWidget,
      );
      // The author is in front, at the lower right.
      final community = tester.getRect(
        find.byKey(const ValueKey('stacked-avatar-community')),
      );
      final author = tester.getRect(
        find.byKey(const ValueKey('stacked-avatar-author')),
      );
      expect(author.right, greaterThan(community.right));
      expect(author.bottom, greaterThan(community.bottom));
    });

    testWidgets('names the community on a line above the author', (
      tester,
    ) async {
      await _card(tester, _post(community: _gardeners));

      final name = tester.getRect(find.text('Ada'));
      final line = tester.getRect(find.byType(PostCommunityLine));
      expect(line.bottom, lessThanOrEqualTo(name.top + 1));
      // So the handle keeps its place beside the name.
      expect(find.text('@ada'), findsOneWidget);
    });

    testWidgets('opens the community from its picture', (tester) async {
      final pushes = _Pushes();
      await _card(tester, _post(community: _gardeners), pushes: pushes);

      // The part of it the author is not in front of.
      await tester.tapAt(
        tester.getTopLeft(
              find.byKey(const ValueKey('stacked-avatar-community')),
            ) +
            const Offset(4, 4),
      );
      await tester.pump();

      expect(pushes.names, [Routes.community]);
    });

    testWidgets("shows the author's whole name when there is room", (
      tester,
    ) async {
      // Name, handle and a Spacer each got a third of the free width, so a
      // name was cut with half the line empty after it.
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      for (final community in [_gardeners, null]) {
        await _card(
          tester,
          FeedPost(
            id: 'p1',
            content: 'hi',
            createdAt: DateTime(2026, 1, 1),
            author:
                const FeedAuthor(id: 'u1', username: 'yo', name: 'Yunnieee'),
            community: community,
          ),
        );
        expect(
          tester
              .renderObject<RenderParagraph>(find.text('Yunnieee'))
              .didExceedMaxLines,
          isFalse,
          reason: community == null ? 'with a handle' : 'with a community',
        );
      }
    });

    testWidgets('opens the community when the name is tapped', (tester) async {
      await _card(tester, _post(community: _gardeners));

      await tester.tap(find.text('Gardeners'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // The community's own page, not the post.
      expect(find.byType(CommunityScreen), findsOneWidget);
    });

    testWidgets("opens the author from the author's picture", (tester) async {
      final pushes = _Pushes();
      await _card(tester, _post(community: _gardeners), pushes: pushes);

      await tester.tap(find.byKey(const ValueKey('stacked-avatar-author')));
      await tester.pump();

      expect(pushes.names, [Routes.profile]);
    });

    testWidgets('the whole line is the target, not just the name', (
      tester,
    ) async {
      // A thumb that lands a little short of the word still gets there,
      // rather than opening the post behind it.
      final pushes = _Pushes();
      await _card(tester, _post(community: _gardeners), pushes: pushes);

      final line = tester.getRect(find.byType(PostCommunityLine));
      await tester.tapAt(Offset(line.left + 3, line.center.dy));
      await tester.pump();

      expect(pushes.names, [Routes.community]);
    });

    testWidgets("says nothing about it on that community's own page", (
      tester,
    ) async {
      // The same word on every post of the page that is that community.
      await _card(
        tester,
        _post(community: _gardeners),
        source: PostListSource.community('Gardeners'),
      );

      // Drawn as any other post: the author's own picture, no line above.
      expect(find.byType(StackedPostAvatar), findsNothing);
      expect(find.byType(PostCommunityLine), findsNothing);
      expect(find.byType(PostAvatar), findsOneWidget);
      expect(find.text('@ada'), findsOneWidget);
    });
  });

  group("a community post's own page", () {
    Future<_Pushes> page(WidgetTester tester) async {
      final pushes = _Pushes();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            _noChats,
            feedRepositoryProvider.overrideWithValue(_OnePost()),
            currentUserRepositoryProvider.overrideWithValue(_Me()),
          ],
          child: MaterialApp(
            onGenerateRoute: pushes.route,
            home: const PostDetailScreen(postId: 'p1'),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();
      return pushes;
    }

    testWidgets('has the header the post has in a feed', (tester) async {
      // The author in front of the community's picture, and the community
      // named above: the same post should not look like a different kind of
      // thing once it is opened.
      await page(tester);

      final stack = find.byType(StackedPostAvatar);
      expect(stack, findsOneWidget);
      expect(
        find.descendant(of: stack, matching: find.byType(Squircle)),
        findsOneWidget,
      );
      final line = tester.getRect(find.byType(PostCommunityLine));
      expect(line.bottom,
          lessThanOrEqualTo(tester.getRect(find.text('Ada')).top + 1));
      expect(find.text('@ada'), findsOneWidget);
    });

    testWidgets('opens the author from the author, in front', (tester) async {
      final pushes = await page(tester);

      await tester.tap(find.byKey(const ValueKey('stacked-avatar-author')));
      await tester.pump();

      expect(pushes.names, [Routes.profile]);
    });

    testWidgets('opens the community from its name', (tester) async {
      final pushes = await page(tester);

      await tester.tap(find.text('Gardeners'));
      await tester.pump();

      expect(pushes.names, [Routes.community]);
    });
  });

  group('a post to the wall', () {
    testWidgets('has no community tag', (tester) async {
      await _card(tester, _post());

      expect(find.byType(PostCommunityLine), findsNothing);
      expect(find.byType(Squircle), findsNothing);
      expect(find.byType(PostAvatar), findsOneWidget);
    });
  });

  group('FeedPost.fromJson', () {
    test('reads the community the server sent', () {
      final post = FeedPost.fromJson({
        'id': 'p1',
        'content': 'hi',
        'createdAt': '2026-01-01T00:00:00.000Z',
        'author': {'id': 'u1'},
        'community': {
          'id': 'c1',
          'slug': 'gardeners',
          'name': 'Gardeners',
          'avatarUrl': 'https://example.test/c.png',
        },
      });

      expect(post.community?.slug, 'gardeners');
      expect(post.community?.name, 'Gardeners');
      expect(post.community?.avatarUrl, 'https://example.test/c.png');
    });

    test('is null on a post to the wall', () {
      final post = FeedPost.fromJson({
        'id': 'p1',
        'content': 'hi',
        'createdAt': '2026-01-01T00:00:00.000Z',
        'author': {'id': 'u1'},
      });

      expect(post.community, isNull);
    });

    test('survives a like, which rebuilds the post', () {
      // copyWith drops anything it forgets to carry, and a post losing its
      // community when somebody likes it would move it out of its place.
      final post = _post(community: _gardeners).copyWith(liked: true);

      expect(post.community?.slug, 'gardeners');
    });

    test('falls back to a hash when the community has no name', () {
      const nameless = PostCommunity(id: 'c1', slug: 's', name: '   ');

      expect(nameless.initial, '#');
      expect(_gardeners.initial, 'G');
    });
  });

  group('the community page', () {
    Future<void> pump(WidgetTester tester, Community community) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            _noChats,
            communitiesRepositoryProvider.overrideWithValue(
              _OneCommunity(community),
            ),
            feedRepositoryProvider.overrideWithValue(_Feed()),
          ],
          child: const MaterialApp(home: CommunityScreen(slug: 'gardeners')),
        ),
      );
      await tester.pump();
      await tester.pump();
    }

    const community = Community(
      id: 'c1',
      slug: 'gardeners',
      name: 'Gardeners',
      bannerUrl: 'https://example.test/banner.png',
      avatarUrl: 'https://example.test/avatar.png',
      members: 4,
      posts: 2,
    );

    final banner = find.byWidgetPredicate(
      (w) =>
          w is Image &&
          w.image is NetworkImage &&
          (w.image as NetworkImage).url == 'https://example.test/banner.png',
    );

    Community described(String description) => Community(
          id: community.id,
          slug: community.slug,
          name: community.name,
          bannerUrl: community.bannerUrl,
          avatarUrl: community.avatarUrl,
          members: community.members,
          posts: community.posts,
          description: description,
        );

    testWidgets('is one pinned row: picture, name and address', (
      tester,
    ) async {
      // Like a feed's header. It was a banner a third of the screen tall
      // with an 86-pixel picture hanging off it, then the name, the
      // description and the counts: the first post half way down the phone.
      await pump(tester, community);

      final bar = find.byType(AppBar);
      expect(
        find.descendant(of: bar, matching: find.byType(CommunityAvatar)),
        findsOneWidget,
      );
      expect(
        find.descendant(of: bar, matching: find.text('Gardeners')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: bar, matching: find.text('c/gardeners')),
        findsOneWidget,
      );
      // How many are in it, as a number beside the name.
      expect(
        find.descendant(
          of: find.byKey(const ValueKey('community-members')),
          matching: find.text('4'),
        ),
        findsOneWidget,
      );
      expect(tester.getSize(bar).height, lessThanOrEqualTo(60));
      // No banner on the page itself.
      expect(banner, findsNothing);
    });

    testWidgets('its buttons are 40 across, and still 44 tall', (
      tester,
    ) async {
      // Four of them share a row with the name; each pixel they do not take
      // is a letter of the name not cut.
      await pump(tester, community.copyWith(joined: true));

      for (final button in [
        find.byTooltip('Chats'),
        find.byTooltip('This community'),
      ]) {
        expect(tester.getSize(button), const Size(40, 44));
      }
      // Back fills the bar's leading slot, which is narrowed to match.
      expect(
        tester
            .getSize(
              find.byTooltip(
                const DefaultMaterialLocalizations().backButtonTooltip,
              ),
            )
            .width,
        48,
      );
    });

    testWidgets('keeps its chats in a sheet, not between header and posts', (
      tester,
    ) async {
      // A section above the posts pushed every post a screen down, on every
      // visit, for a list most visits do not open.
      await pump(tester, community.copyWith(joined: true));
      expect(find.byType(CommunityChatsSection), findsNothing);

      await tester.tap(find.byKey(const ValueKey('community-chats-button')));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('community-chats-sheet')),
        findsOneWidget,
      );
      expect(find.text('Chats'), findsWidgets);
    });

    testWidgets('offers no chats to somebody outside it', (tester) async {
      // The server refuses them; a button that opens a refusal is not one.
      await pump(tester, community);

      expect(
          find.byKey(const ValueKey('community-chats-button')), findsNothing);
      expect(find.byKey(const ValueKey('community-join')), findsOneWidget);
    });

    testWidgets('says what it is for under the bar, three lines at most', (
      tester,
    ) async {
      await pump(
        tester,
        described(List.filled(40, 'Tomatoes.').join(' ')),
      );

      final text = tester.widget<Text>(
        find.descendant(
          of: find.byKey(const ValueKey('community-description')),
          matching: find.byType(Text),
        ),
      );
      expect(text.maxLines, 3);
    });

    testWidgets('the banner and the rest are a tap on the name away', (
      tester,
    ) async {
      await pump(
        tester,
        described('Tomatoes, mostly.'),
      );

      await tester.tap(find.byKey(const ValueKey('community-identity')));
      await tester.pumpAndSettle();

      final about = find.byKey(const ValueKey('community-about'));
      expect(about, findsOneWidget);
      expect(find.descendant(of: about, matching: banner), findsOneWidget);
      expect(
        find.descendant(of: about, matching: find.text('Tomatoes, mostly.')),
        findsOneWidget,
      );
      expect(find.text('Members: 4'), findsOneWidget);
      expect(find.text('Posts: 2'), findsOneWidget);
      // Join, for somebody who is not in it.
      expect(find.byKey(const ValueKey('community-about-join')), findsOne);
    });

    testWidgets('still has a way back out', (tester) async {
      await pump(tester, community);

      expect(find.byType(BackButton), findsNothing);
      expect(
        find.byTooltip(const DefaultMaterialLocalizations().backButtonTooltip),
        findsOneWidget,
      );
    });
  });

  group('the community page, laid out', () {
    /// A phone with a gesture bar, which is what makes the bottom inset
    /// matter. The default test surface has none.
    Future<void> pumpPhone(WidgetTester tester, Community community) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      tester.view.padding = const FakeViewPadding(top: 47, bottom: 34);
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            _noChats,
            communitiesRepositoryProvider.overrideWithValue(
              _OneCommunity(community),
            ),
            feedRepositoryProvider.overrideWithValue(_Feed()),
          ],
          child: MaterialApp(
            theme: KyronTheme.lightTheme,
            home: const CommunityScreen(slug: 'gardeners'),
          ),
        ),
      );
      await tester.pump();
      // The Scaffold scales its floating button in; measured mid-animation it
      // is a rect of zero size around the resting centre.
      await tester.pump(const Duration(seconds: 1));
    }

    const withBanner = Community(
      id: 'c1',
      slug: 'gardeners',
      name: 'Gardeners',
      bannerUrl: 'https://example.test/banner.png',
      avatarUrl: 'https://example.test/avatar.png',
      joined: true,
      role: CommunityRole.member,
    );

    testWidgets('the bar draws its icons', (tester) async {
      // A button over the old banner took an icon and never drew it: an
      // empty box inside a black disc, reported as "the icons at the top
      // aren't showing, only their backgrounds are".
      await pumpPhone(tester, withBanner);

      for (final tip in [
        const DefaultMaterialLocalizations().backButtonTooltip,
        'Chats',
        'This community',
      ]) {
        expect(
          find.descendant(of: find.byTooltip(tip), matching: find.byType(Icon)),
          findsOneWidget,
          reason: tip,
        );
      }
    });

    testWidgets('starts the posts right under the bar', (tester) async {
      await pumpPhone(tester, withBanner);

      final bar = tester.getRect(find.byType(AppBar));
      final post = tester.getRect(find.byType(PostListView));
      expect(post.top, bar.bottom);
    });

    testWidgets(
      'the floating button is in the bottom-right corner, clear of the inset',
      (tester) async {
        // In the corner, where a thumb is and a create button is expected.
        // Centred, it sat over the middle of every post, where the words are.
        //
        // Vertically it still has to clear the gesture inset. A floating button
        // is placed 16 above the *body*, and this body runs to the bottom of
        // the screen -- so on a 34-pixel inset it landed 32 up, two pixels
        // inside the system's own strip.
        await pumpPhone(tester, withBanner);

        final screen = tester.getSize(find.byType(CommunityScreen));
        final fab = tester.getRect(find.byType(FloatingActionButton));
        const inset = 34.0;

        expect(
          screen.height - fab.bottom,
          greaterThan(inset),
          reason: 'the button is inside the gesture inset',
        );
        expect(
          screen.width - fab.right,
          closeTo(16, 1),
          reason: 'the button is not in the corner: $fab on a $screen screen',
        );
      },
    );

    testWidgets('the floating button can be seen against the page', (
      tester,
    ) async {
      // It was #FFFFFF on #F7F7F7, at 1.06:1. The theme is the fix; this
      // holds the app to a theme that has one.
      await pumpPhone(tester, withBanner);

      final material = tester.widget<Material>(
        find
            .descendant(
              of: find.byType(FloatingActionButton),
              matching: find.byType(Material),
            )
            .first,
      );
      expect(material.color, isNot(const Color(0xFFF7F7F7)));
      expect(material.color, isNot(Colors.white));
    });
  });

  group('the floating buttons are outlined', () {
    /// Iconsax ships each glyph twice: the bare name is the filled weight and
    /// the `_copy` suffix is the outline. Kyron's are outlined, and these two
    /// were the filled ones -- on the Communities tab, directly above a
    /// create button drawing the same plus in the other weight.
    test('both community screens use the outline weight', () {
      final community =
          File('lib/screens/community_screen.dart').readAsStringSync();
      final communities =
          File('lib/screens/communities_screen.dart').readAsStringSync();

      expect(community, contains('Iconsax.edit_2_copy'));
      expect(community, isNot(contains('Icon(Iconsax.edit_2)')));

      // The create button moved from a floating disc to the bar at the top,
      // beside settings, the way Messages has it; still the outline weight.
      expect(communities, contains('Iconsax.add_square_copy'));
      expect(communities, isNot(contains('Iconsax.add_square,')));
      expect(communities, isNot(contains('FloatingActionButton')));
    });
  });
}
