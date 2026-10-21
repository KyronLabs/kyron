import 'dart:io';

import 'package:flutter/material.dart';
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
import 'package:kyron_app/widgets/glass_icon_button.dart';
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
            child: PostCard(post: post, source: PostListSource.recent),
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

    testWidgets('stacks the author on the community picture', (tester) async {
      await _card(tester, _post(community: _gardeners));

      expect(find.byType(StackedPostAvatar), findsOneWidget);
      // The author is still there, in front of it.
      expect(find.byType(PostAvatar), findsOneWidget);
    });

    testWidgets('draws the community as a squircle', (tester) async {
      await _card(tester, _post(community: _gardeners));

      expect(find.byType(Squircle), findsOneWidget);
    });

    testWidgets('opens the community when the name is tapped', (tester) async {
      await _card(tester, _post(community: _gardeners));

      await tester.tap(find.text('Gardeners'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // The community's own page, not the post.
      expect(find.byType(CommunityScreen), findsOneWidget);
    });

    testWidgets('opens the community when its picture is tapped', (
      tester,
    ) async {
      // The larger shape in the stack is the place. It used to open the
      // author, which left nothing on the post big enough to hit that led to
      // the community.
      final pushes = _Pushes();
      await _card(tester, _post(community: _gardeners), pushes: pushes);

      // The corner the author's face does not cover.
      final picture = find.byKey(const ValueKey('stacked-avatar-community'));
      await tester.tapAt(tester.getTopLeft(picture) + const Offset(5, 5));
      await tester.pump();

      expect(pushes.names, [Routes.community]);
    });

    testWidgets("opens the author when the author's face is tapped", (
      tester,
    ) async {
      final pushes = _Pushes();
      await _card(tester, _post(community: _gardeners), pushes: pushes);

      await tester.tap(find.byKey(const ValueKey('stacked-avatar-author')));
      await tester.pump();

      expect(pushes.names, [Routes.profile]);
    });

    testWidgets('the whole community line is the target, not just its name', (
      tester,
    ) async {
      // At this size the letters alone are a sliver, and a miss lands on the
      // post behind them and opens the post instead.
      final pushes = _Pushes();
      await _card(tester, _post(community: _gardeners), pushes: pushes);

      final line = find.byType(PostCommunityLine);
      final box = tester.getRect(line);
      await tester.tapAt(Offset(box.right - 8, box.center.dy));
      await tester.pump();

      expect(pushes.names, [Routes.community]);
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

    testWidgets('says which community it was posted in', (tester) async {
      // It said nothing, so the post's own page was a dead end on the way to
      // the place it came from.
      await page(tester);

      expect(find.byType(PostCommunityLine), findsOneWidget);
      expect(find.byType(StackedPostAvatar), findsOneWidget);
    });

    testWidgets('opens the community from its name', (tester) async {
      final pushes = await page(tester);

      await tester.tap(find.text('Gardeners'));
      await tester.pump();

      expect(pushes.names, [Routes.community]);
    });
  });

  group('a post to the wall', () {
    testWidgets('has no community line and no stack', (tester) async {
      await _card(tester, _post());

      expect(find.byType(StackedPostAvatar), findsNothing);
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

    testWidgets('has a see-through bar with only its controls in it', (
      tester,
    ) async {
      // A bar with a colour of its own left a strip of surface between the
      // status bar and the picture, and put the community's name on screen
      // twice. The profile's bar -- clear, controls only -- does neither.
      await pump(tester, community);

      final bar = tester.widget<AppBar>(find.byType(AppBar));
      expect(bar.backgroundColor, Colors.transparent);
      expect(bar.title, isNull);
      expect(find.text('Gardeners'), findsOneWidget);
    });

    testWidgets("its top controls are the profile page's, not bigger", (
      tester,
    ) async {
      // They were 44-pixel discs, a size heavier than the profile's for the
      // same job over the same kind of picture.
      await pump(tester, community);

      expect(find.byType(GlassIconButton), findsNWidgets(3));
      final discs = find.descendant(
        of: find.byType(GlassIconButton),
        matching: find.byWidgetPredicate(
          (w) =>
              w is Container &&
              w.decoration is BoxDecoration &&
              (w.decoration as BoxDecoration).shape == BoxShape.circle &&
              (w.decoration as BoxDecoration).color == const Color(0x59000000),
        ),
      );
      expect(discs, findsNWidgets(3));
      for (final disc in discs.evaluate()) {
        expect(tester.getSize(find.byWidget(disc.widget)), const Size(36, 36));
      }
      // Still easy to hit.
      expect(
        tester.getSize(find.byType(GlassIconButton).first).height,
        greaterThanOrEqualTo(44),
      );
    });

    testWidgets('keeps its chats in a sheet, not between header and posts', (
      tester,
    ) async {
      // A section above the posts pushed every post a screen down, on every
      // visit, for a list most visits do not open.
      await pump(tester, community);
      expect(find.byType(CommunityChatsSection), findsNothing);

      await tester.tap(find.byKey(const ValueKey('community-chats-button')));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('community-chats-sheet')),
        findsOneWidget,
      );
      expect(find.text('Chats'), findsOneWidget);
    });

    testWidgets('puts the banner at the very top of the screen', (
      tester,
    ) async {
      await pump(tester, community);

      final banner = find.byType(Image).first;
      expect(tester.getTopLeft(banner).dy, 0);
    });

    testWidgets('stacks the picture on the banner', (tester) async {
      await pump(tester, community);

      final avatar = find.byType(CommunityAvatar);
      expect(avatar, findsOneWidget);

      // It hangs over the banner's bottom edge rather than sitting under it.
      final bannerBottom = tester.getRect(find.byType(Image).first).bottom;
      final box = tester.getRect(avatar);
      expect(box.top, lessThan(bannerBottom));
      expect(box.bottom, greaterThan(bannerBottom));
    });

    testWidgets('still has a way back out', (tester) async {
      await pump(tester, community);

      expect(find.byType(BackButton), findsNothing);
      expect(
        find.byTooltip(const DefaultMaterialLocalizations().backButtonTooltip),
        findsOneWidget,
      );
    });

    testWidgets('a community with no banner still has one to hang off', (
      tester,
    ) async {
      // Otherwise the picture has nothing behind it and the page jumps by
      // eighty pixels between one community and the next.
      await pump(
        tester,
        const Community(id: 'c2', slug: 'quiet', name: 'Quiet'),
      );

      final avatar = find.byType(CommunityAvatar);
      expect(avatar, findsOneWidget);
      expect(tester.getRect(avatar).top, greaterThan(0));
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

    testWidgets('the picture sits exactly halfway across the banner edge', (
      tester,
    ) async {
      // It hung a third of itself below before, which reads as a picture that
      // slipped rather than one that was placed.
      await pumpPhone(tester, withBanner);

      final banner = tester.getRect(find.byType(Image).first);
      final avatar = tester.getRect(find.byType(CommunityAvatar));

      expect(avatar.center.dy, closeTo(banner.bottom, 0.5));
    });

    testWidgets('the controls over the banner draw their icons', (
      tester,
    ) async {
      // `_GlassButton` took an icon and never drew it: an empty box inside a
      // black disc. The button showed, the tap worked, and there was nothing
      // in it -- reported as "the icons at the top aren't showing, only their
      // backgrounds are, but they work just fine".
      await pumpPhone(tester, withBanner);

      final back = find.byTooltip(
        const DefaultMaterialLocalizations().backButtonTooltip,
      );
      expect(back, findsOneWidget);
      expect(
        find.descendant(of: back, matching: find.byType(Icon)),
        findsOneWidget,
      );
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
