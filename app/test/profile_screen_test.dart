import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/profile_model.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/providers/profile_provider.dart';
import 'package:kyron_app/screens/profile_screen.dart';
import 'package:kyron_app/widgets/action_button.dart';
import 'package:kyron_app/widgets/hairline.dart';
import 'package:kyron_app/widgets/list_controls.dart';

import 'support/signed_in_as.dart';

const _me = ProfileModel(
  id: 'u1',
  name: 'Epigone',
  username: 'epigone',
  did: 'did:kyron:8f2c19a4b7e34d05',
  bio: 'heh',
  location: 'Lagos',
  website: 'kyron.so',
  followers: 1,
  following: 0,
  posts: 2,
  isOwnProfile: true,
);

class _StubProfile extends ProfileNotifier {
  _StubProfile(super.ref, super.username, [ProfileModel profile = _me]) {
    state = AsyncData(profile);
  }
  @override
  Future<void> load({bool force = false}) async {}
}

class _StubPosts extends PostListNotifier {
  _StubPosts(super.ref, super.source, this._seed);
  final FeedState _seed;
  @override
  Future<void> refresh() async {
    state = _seed;
  }
}

FeedPost _post(String id) => FeedPost(
      id: id,
      content: 'post $id',
      createdAt: DateTime.now(),
      author: const FeedAuthor(id: 'u1', name: 'Epigone', username: 'epigone'),
    );

Widget _app(FeedState seed, {ThemeData? theme}) => ProviderScope(
      overrides: [
        signedInAs(),
        profileProvider.overrideWith(
          (ref, username) => _StubProfile(ref, username),
        ),
        postListProvider.overrideWith(
          (ref, source) => _StubPosts(ref, source, seed),
        ),
      ],
      child: MaterialApp(theme: theme, home: const ProfileScreen()),
    );

void main() {
  testWidgets('the profile screen renders its header', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          profileProvider.overrideWith(
            (ref, username) => _StubProfile(ref, username),
          ),
          postListProvider.overrideWith(
            (ref, source) => _StubPosts(ref, source, const FeedState()),
          ),
        ],
        child: const MaterialApp(home: ProfileScreen()),
      ),
    );
    await tester.pump();
    // Long enough for the system log's debounced write to fire. A timer still
    // pending when the tree is disposed fails the test.
    await tester.pump(const Duration(seconds: 3));

    expect(find.text('Epigone'), findsWidgets);
    // One follower: the fixture's.
    expect(find.text('Follower'), findsOneWidget);
    expect(find.text('Following'), findsOneWidget);
    // Kyron Points sat beside these. Anybody could award any account any
    // number of them, and the programme they belonged to had been withdrawn,
    // so the count was a figure nobody could trust about a thing that did not
    // exist.
    expect(find.text('KP'), findsNothing);
  });

  for (final entry in <String, FeedState>{
    'while its posts are loading': const FeedState(isLoadingFirstPage: true),
    'with no posts': const FeedState(),
    'when its posts fail': const FeedState(error: 'nope'),
  }.entries) {
    testWidgets('the profile screen fits a phone ${entry.key}', (tester) async {
      tester.view.physicalSize = const Size(720, 1600);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(_app(entry.value));
      await tester.pump();
      // Long enough for the system log's debounced write to fire. A timer
      // still pending when the tree is disposed fails the test.
      await tester.pump(const Duration(seconds: 3));

      expect(tester.takeException(), isNull, reason: entry.key);
      expect(find.text('Follower'), findsOneWidget);
    });
  }

  testWidgets('the profile screen fits a phone with posts', (tester) async {
    tester.view.physicalSize = const Size(720, 1600);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_app(FeedState(posts: [_post('a'), _post('b')])));
    await tester.pump();
    // Long enough for the system log's debounced write to fire. A timer still
    // pending when the tree is disposed fails the test.
    await tester.pump(const Duration(seconds: 3));

    expect(tester.takeException(), isNull);
    expect(find.text('post a'), findsOneWidget);
  });

  for (final (count, label) in [(1, 'Follower'), (2, 'Followers')]) {
    testWidgets('$count reads as "$count $label"', (tester) async {
      final profile = ProfileModel(
        id: 'u1',
        name: 'Epigone',
        username: 'epigone',
        followers: count,
        following: 0,
        posts: 0,
        isOwnProfile: true,
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileProvider.overrideWith(
              (ref, username) => _StubProfile(ref, username, profile),
            ),
            postListProvider.overrideWith(
              (ref, source) => _StubPosts(ref, source, const FeedState()),
            ),
          ],
          child: const MaterialApp(home: ProfileScreen()),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 3));

      expect(find.text(label), findsOneWidget);
    });
  }

  for (final own in [true, false]) {
    testWidgets(
        'the round buttons are as tall as the one beside them '
        '(${own ? 'own' : "somebody else's"} profile)', (tester) async {
      final profile = ProfileModel(
        id: 'u1',
        name: 'Epigone',
        username: 'epigone',
        followers: 1,
        following: 0,
        posts: 0,
        isOwnProfile: own,
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileProvider.overrideWith(
              (ref, username) => _StubProfile(ref, username, profile),
            ),
            postListProvider.overrideWith(
              (ref, source) => _StubPosts(ref, source, const FeedState()),
            ),
          ],
          child: const MaterialApp(home: ProfileScreen()),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 3));

      final beside = tester.getSize(find.byType(ActionButton)).height;
      // Follow's size on every profile: your own page's Edit profile used to
      // be a size bigger than anybody else's Follow.
      expect(beside, ActionButton.compactHeight);
      final share = tester.getSize(find.byKey(const ValueKey('profile-share')));
      expect(share.height, beside);
      expect(share.width, share.height, reason: 'a circle');
      if (!own) {
        expect(
          tester.getSize(find.byKey(const ValueKey('profile-message'))).height,
          beside,
        );
      }
    });
  }

  for (final own in [true, false]) {
    testWidgets(
        'Insights sits beside Share on your own profile, and only yours '
        '(${own ? 'own' : "somebody else's"})', (tester) async {
      final profile = ProfileModel(
        id: 'u1',
        name: 'Epigone',
        username: 'epigone',
        followers: 1,
        following: 0,
        posts: 0,
        isOwnProfile: own,
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileProvider.overrideWith(
              (ref, username) => _StubProfile(ref, username, profile),
            ),
            postListProvider.overrideWith(
              (ref, source) => _StubPosts(ref, source, const FeedState()),
            ),
          ],
          child: const MaterialApp(home: ProfileScreen()),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 3));

      expect(
        find.byKey(const ValueKey('profile-insights')),
        own ? findsOneWidget : findsNothing,
      );
    });
  }

  testWidgets('the tabs are the messages list\'s pills, on a rule', (
    tester,
  ) async {
    await tester.pumpWidget(_app(FeedState(posts: [_post('p1')])));
    await tester.pump();

    ListChip chip(String name) =>
        tester.widget<ListChip>(find.byKey(ValueKey('profile-tab-$name')));
    expect(chip('posts').selected, isTrue);
    expect(chip('media').selected, isFalse);

    await tester.tap(find.byKey(const ValueKey('profile-tab-media')));
    await tester.pump();
    expect(chip('media').selected, isTrue);
    expect(chip('posts').selected, isFalse);

    // The strip ends in the rule, under the pills.
    final media =
        tester.getRect(find.byKey(const ValueKey('profile-tab-media')));
    final rules = find.byType(RuleLine).evaluate().map(
          (e) => tester.getRect(find.byWidget(e.widget)),
        );
    expect(rules.any((r) => r.top >= media.bottom && r.top - media.bottom < 12),
        isTrue);
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('in the dark, the tab strip is the page, not a grey band', (
    tester,
  ) async {
    final dark = KyronTheme.darkTheme;
    await tester.pumpWidget(_app(FeedState(posts: [_post('p1')]), theme: dark));
    await tester.pump();

    final strip = tester.widget<Material>(
      find
          .ancestor(
            of: find.byKey(const ValueKey('profile-tab-posts')),
            matching: find.byType(Material),
          )
          // The nearest: the strip's own background, not the page's.
          .first,
    );
    expect(strip.color, dark.scaffoldBackgroundColor);
    expect(dark.scaffoldBackgroundColor, isNot(dark.colorScheme.surface));
    await tester.pump(const Duration(seconds: 3));
  });
}
