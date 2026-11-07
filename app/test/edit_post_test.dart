import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_comment.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/screens/post_detail_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/edit_post_sheet.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/signed_in_as.dart';

class _Repo extends FeedRepository {
  _Repo(this.post) : super(ApiClient());

  FeedPost post;
  final edits = <String>[];

  @override
  Future<FeedPost> byId(String postId) async => post;

  @override
  Future<FeedPost> edit(String postId, String content) async {
    edits.add(content);
    return post = FeedPost(
      id: post.id,
      content: content,
      createdAt: post.createdAt,
      author: post.author,
      editedAt: DateTime.now(),
    );
  }

  @override
  Future<CommentPage> comments(
    String postId, {
    String? cursor,
    int limit = 20,
    CommentSort sort = CommentSort.top,
  }) async =>
      const CommentPage(items: []);

  @override
  Future<void> recordView(String postId, {int? dwellMs}) async {}

  @override
  Future<FeedPage> recent({String? cursor, int limit = 20}) async =>
      const FeedPage(items: []);
}

FeedPost _mine({required Duration age}) => FeedPost(
      id: 'p1',
      content: 'Teh fox at dusk',
      createdAt: DateTime.now().subtract(age),
      author: const FeedAuthor(id: 'me', username: 'me', name: 'Me'),
    );

Future<_Repo> _open(WidgetTester tester, FeedPost post) async {
  final repo = _Repo(post);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        signedInAs(),
        feedRepositoryProvider.overrideWithValue(repo),
      ],
      child: const MaterialApp(home: PostDetailScreen(postId: 'p1')),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey('post-detail-menu')));
  await tester.pumpAndSettle();
  return repo;
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('a post can be edited for fifteen minutes', () {
    final made = DateTime(2026, 11, 7, 12);
    final post = FeedPost(
      id: 'p',
      content: 'x',
      createdAt: made,
      author: const FeedAuthor(id: 'me'),
    );
    expect(post.canEditAt(made.add(const Duration(minutes: 14))), isTrue);
    expect(post.canEditAt(made.add(const Duration(minutes: 15))), isFalse);
  });

  testWidgets('your new post: edit it, and it says it was edited', (
    tester,
  ) async {
    final repo = await _open(tester, _mine(age: const Duration(minutes: 2)));

    await tester.tap(find.byKey(const ValueKey('post-option-edit')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('edit-post-field')),
      'The fox at dusk',
    );
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('edit-post-save')));
    await tester.pumpAndSettle();

    expect(repo.edits, ['The fox at dusk']);
    expect(find.text('The fox at dusk'), findsOneWidget);
    expect(find.textContaining('Edited'), findsWidgets);
    // The "Edited" toast's own timer.
    await tester.pump(const Duration(seconds: 6));
  });

  testWidgets('an older post is not offered for editing', (tester) async {
    await _open(tester, _mine(age: const Duration(minutes: 30)));
    expect(find.byKey(const ValueKey('post-option-edit')), findsNothing);
  });

  // Under the app's own theme, whose buttons are full width: in that theme a
  // plain FilledButton in the sheet's heading took the whole row, stood the
  // title on end one letter per line and pushed Save off the sheet.
  testWidgets('the sheet\'s heading reads across, with Save beside it',
      (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 640);
    addTearDown(tester.view.reset);
    final post = _mine(age: const Duration(minutes: 1));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [feedRepositoryProvider.overrideWithValue(_Repo(post))],
        child: MaterialApp(
          theme: KyronTheme.lightTheme,
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () => EditPostSheet.show(context, post),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pump(const Duration(seconds: 1));

    final title = tester.getSize(find.text('Edit post'));
    expect(title.height, lessThan(40), reason: 'one line, not a column');
    expect(title.width, greaterThan(60));
    final save = tester.getRect(find.byKey(const ValueKey('edit-post-save')));
    expect(save.right, lessThanOrEqualTo(360));
    expect(save.width, lessThan(120), reason: 'a button, not the whole row');
    expect(tester.takeException(), isNull);
  });
}
