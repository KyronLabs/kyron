import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/profile_model.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/providers/profile_provider.dart';
import 'package:kyron_app/screens/profile_screen.dart';

const _me = ProfileModel(
  id: 'u1',
  name: 'Epigone',
  username: 'epigone',
  did: 'did:kyron:8f2c19a4b7e34d05',
  kyronPoints: 12,
  bio: 'heh',
  location: 'Lagos',
  website: 'kyron.so',
  followers: 1,
  following: 0,
  posts: 2,
  isOwnProfile: true,
);

class _StubProfile extends ProfileNotifier {
  _StubProfile(super.ref, super.username) {
    state = const AsyncData(_me);
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

Widget _app(FeedState seed) => ProviderScope(
      overrides: [
        profileProvider
            .overrideWith((ref, username) => _StubProfile(ref, username)),
        postListProvider
            .overrideWith((ref, source) => _StubPosts(ref, source, seed)),
      ],
      child: const MaterialApp(home: ProfileScreen()),
    );

void main() {
  testWidgets('the profile screen renders its header', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          profileProvider
              .overrideWith((ref, username) => _StubProfile(ref, username)),
          postListProvider.overrideWith(
              (ref, source) => _StubPosts(ref, source, const FeedState())),
        ],
        child: const MaterialApp(home: ProfileScreen()),
      ),
    );
    await tester.pump();
    // Long enough for the system log's debounced write to fire. A timer still
    // pending when the tree is disposed fails the test.
    await tester.pump(const Duration(seconds: 3));

    expect(find.text('Epigone'), findsWidgets);
    expect(find.text('Followers'), findsOneWidget);
    expect(find.text('Following'), findsOneWidget);
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
      expect(find.text('Followers'), findsOneWidget);
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
}
