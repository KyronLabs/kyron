import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/repositories/current_user_repository.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/account_avatar.dart';
import 'package:kyron_app/widgets/post_list_view.dart';
import 'package:kyron_app/widgets/skeleton.dart';
import 'package:kyron_app/widgets/sliding_drawer_content.dart';

/// A profile request that never comes back, which is what every one of these
/// is about: what the screen shows in the meantime.
class _NeverAnswers extends CurrentUserRepository {
  _NeverAnswers() : super(ApiClient());

  final _held = Completer<CurrentUser>();

  @override
  Future<CurrentUser> fetchMe({bool force = false}) => _held.future;
}

/// A feed request that never comes back.
class _SilentFeed extends FeedRepository {
  _SilentFeed() : super(ApiClient());

  final _held = Completer<FeedPage>();

  @override
  Future<FeedPage> videos({String? cursor, int limit = 20}) => _held.future;

  @override
  Future<FeedPage> recent({String? cursor, int limit = 20}) => _held.future;
}

/// A profile that lands immediately.
class _Answers extends CurrentUserRepository {
  final CurrentUser user;

  _Answers(this.user) : super(ApiClient());

  @override
  Future<CurrentUser> fetchMe({bool force = false}) async => user;
}

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  CurrentUserRepository? repository,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentUserRepositoryProvider.overrideWithValue(
          repository ?? _NeverAnswers(),
        ),
      ],
      child: MaterialApp(home: Scaffold(body: child)),
    ),
  );
  await tester.pump();
}

const _me = CurrentUser(
  id: 'u1',
  name: 'Ada Lovelace',
  username: 'ada',
  kyronPoints: 40,
  followers: 12,
  following: 3,
  posts: 7,
);

void main() {
  group('the top-bar avatar', () {
    testWidgets('shimmers rather than claiming the account has no picture', (
      tester,
    ) async {
      // The fallback glyph is what Kyron shows an account with no picture, so
      // drawing it while the profile is still being read told everyone they
      // had none -- on every launch, on every screen with a top bar.
      await _pump(tester, const AccountAvatar());

      expect(find.byType(SkeletonBox), findsOneWidget);
      expect(find.byType(CircleAvatar), findsNothing);
    });

    testWidgets('gives way to the real avatar once the profile lands', (
      tester,
    ) async {
      await _pump(tester, const AccountAvatar(), repository: _Answers(_me));
      await tester.pump();

      expect(find.byType(SkeletonBox), findsNothing);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('is the size the avatar will be', (tester) async {
      await _pump(tester, const AccountAvatar(radius: 21));

      expect(tester.getSize(find.byType(SkeletonBox)), const Size(42, 42));
    });
  });

  group('the sidebar header', () {
    testWidgets('shimmers, down to the follower counts', (tester) async {
      await _pump(tester, SlidingDrawerContent(onCloseDrawer: () {}));

      // Avatar, name, handle, and the three stats -- the row that used to pop
      // in after the rest and shove the navigation down.
      expect(find.byType(SkeletonBox), findsNWidgets(6));
      expect(find.byType(SkeletonGroup), findsOneWidget);
    });

    testWidgets('is a shimmer, not the three still blocks it replaced', (
      tester,
    ) async {
      await _pump(tester, SlidingDrawerContent(onCloseDrawer: () {}));
      await tester.pump(const Duration(milliseconds: 200));

      // SkeletonBox paints a gradient only when a group is driving it; with no
      // ticker above it, it is a flat block.
      final box = tester.element(find.byType(SkeletonBox).first);
      expect(SkeletonGroup.of(box), isNotNull);
    });

    testWidgets('gives way to the real header once the profile lands', (
      tester,
    ) async {
      await _pump(
        tester,
        SlidingDrawerContent(onCloseDrawer: () {}),
        repository: _Answers(_me),
      );
      await tester.pump();

      expect(find.byType(SkeletonBox), findsNothing);
      expect(find.text('Ada Lovelace'), findsOneWidget);
      expect(find.text('Followers'), findsOneWidget);
    });
  });

  group('the Videos wall', () {
    testWidgets('loads behind tiles, not behind a column of post rows', (
      tester,
    ) async {
      // It used to load behind SkeletonList.posts: avatars, paragraphs and an
      // engagement row, none of which is what a wall of clips looks like.
      await tester.pumpWidget(
        ProviderScope(
          overrides: [feedRepositoryProvider.overrideWithValue(_SilentFeed())],
          child: const MaterialApp(
            home: Scaffold(
              body: PostListView(
                source: PostListSource.videos,
                asTiles: true,
                emptyTitle: 'No clips',
                emptyDetail: 'Nothing here yet.',
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(SkeletonTileWall), findsOneWidget);
      expect(find.byType(SkeletonList), findsNothing);
    });

    testWidgets('a column of posts still loads behind post rows', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [feedRepositoryProvider.overrideWithValue(_SilentFeed())],
          child: const MaterialApp(
            home: Scaffold(
              body: PostListView(
                source: PostListSource.recent,
                emptyTitle: 'No posts',
                emptyDetail: 'Nothing here yet.',
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(SkeletonList), findsOneWidget);
      expect(find.byType(SkeletonTileWall), findsNothing);
    });
  });

  group('SkeletonTileWall', () {
    /// The sliver it actually loads in, so the height it is given here is the
    /// unbounded one the real screen gives it.
    Future<void> show(WidgetTester tester, Widget child) => tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body:
                  CustomScrollView(slivers: [SliverToBoxAdapter(child: child)]),
            ),
          ),
        );

    testWidgets('lays out two columns, not a run of rows', (tester) async {
      await show(tester, const SkeletonTileWall(count: 6));

      final boxes = find.byType(SkeletonBox);
      expect(boxes, findsNWidgets(6));

      final lefts = boxes
          .evaluate()
          .map((e) => tester.getTopLeft(find.byWidget(e.widget)).dx)
          .toSet();
      expect(lefts.length, 2, reason: 'a wall of tiles has two columns');
    });

    testWidgets('staggers: its tiles are not all one height', (tester) async {
      await show(tester, const SkeletonTileWall(count: 6));

      // A stagger whose tiles are all the same height is a grid, and what
      // replaces this is not one.
      final heights = find
          .byType(SkeletonBox)
          .evaluate()
          .map((e) => tester.getSize(find.byWidget(e.widget)).height)
          .toSet();
      expect(heights.length, greaterThan(1));
    });

    testWidgets('takes real height rather than laying out as nothing', (
      tester,
    ) async {
      await show(tester, const SkeletonTileWall(count: 4));

      expect(
        tester.getSize(find.byType(SkeletonTileWall)).height,
        greaterThan(200),
      );
    });
  });

  group('SkeletonClip', () {
    testWidgets('draws the rail and the caption, visibly on black', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          // Light theme on purpose: this screen is black in either one, and a
          // skeleton drawn from a light scheme's onSurface is near-black.
          theme: ThemeData(brightness: Brightness.light),
          home: const Scaffold(
            backgroundColor: Colors.black,
            body: SkeletonClip(),
          ),
        ),
      );

      // Seven rail buttons, an avatar, a handle and two caption lines.
      expect(find.byType(SkeletonBox), findsNWidgets(11));

      final box = tester.element(find.byType(SkeletonBox).first);
      expect(Theme.of(box).colorScheme.onSurface, Colors.white);
    });
  });
}
