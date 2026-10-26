import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/providers/moderation_provider.dart';
import 'package:kyron_app/repositories/current_user_repository.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/repositories/moderation_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/post_options_sheet.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// "Not interested in this" and "Show more posts like this" each have an
/// Undo now. "Not interested" had none, and nowhere else to take it back: a
/// slip of the thumb stayed in the ranking.

FeedPost _post(String id) => FeedPost(
      id: id,
      content: 'post $id',
      createdAt: DateTime(2026, 10, 1),
      author: const FeedAuthor(id: 'u1', username: 'ada', name: 'Ada'),
    );

class _Feed extends FeedRepository {
  _Feed() : super(ApiClient());

  @override
  Future<FeedPage> recent({String? cursor, int limit = 20}) async => FeedPage(
        items: [_post('p0'), _post('p1'), _post('p2')],
        nextCursor: null,
      );
}

class _Moderation extends ModerationRepository {
  _Moderation() : super(ApiClient());

  final said = <String>[];
  final cleared = <String>[];

  @override
  Future<void> setInterest(String postId, {required bool more}) async =>
      said.add('${more ? 'more' : 'less'}:$postId');

  @override
  Future<void> clearInterest(String postId) async => cleared.add(postId);
}

class _Me implements CurrentUserRepository {
  @override
  Future<CurrentUser> fetchMe({bool force = false}) async =>
      CurrentUser.fromJson(const {'id': 'me', 'username': 'me'});

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

Future<ProviderContainer> _open(WidgetTester tester, _Moderation repo) async {
  late ProviderContainer container;
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        feedRepositoryProvider.overrideWithValue(_Feed()),
        moderationRepositoryProvider.overrideWithValue(repo),
        currentUserRepositoryProvider.overrideWithValue(_Me()),
      ],
      child: MaterialApp(
        theme: KyronTheme.lightTheme,
        home: Consumer(
          builder: (context, ref, _) {
            container = ProviderScope.containerOf(context);
            ref.watch(postListProvider(PostListSource.recent));
            return Scaffold(
              body: TextButton(
                onPressed: () => PostOptionsSheet.show(
                  context,
                  ref,
                  post: _post('p1'),
                  source: PostListSource.recent,
                ),
                child: const Text('open'),
              ),
            );
          },
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return container;
}

List<String> _ids(ProviderContainer c) => [
      for (final p in c.read(postListProvider(PostListSource.recent)).posts)
        p.id,
    ];

void main() {
  testWidgets(
      '"Not interested" can be undone, and the post comes back '
      'where it was', (tester) async {
    final repo = _Moderation();
    final container = await _open(tester, repo);
    expect(_ids(container), ['p0', 'p1', 'p2']);

    await tester.tap(find.text('Not interested in this'));
    await tester.pumpAndSettle();
    expect(repo.said, ['less:p1']);
    expect(_ids(container), ['p0', 'p2']);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(repo.cleared, ['p1']);
    expect(_ids(container), ['p0', 'p1', 'p2']);
    await tester.pump(const Duration(seconds: 6));
  });

  testWidgets('"Show more" can be undone too', (tester) async {
    final repo = _Moderation();
    await _open(tester, repo);

    await tester.tap(find.text('Show more posts like this'));
    await tester.pumpAndSettle();
    expect(repo.said, ['more:p1']);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(repo.cleared, ['p1']);
    await tester.pump(const Duration(seconds: 6));
  });
}
