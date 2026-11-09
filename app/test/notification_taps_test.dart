import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/notification_model.dart';
import 'package:kyron_app/widgets/notification_item.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

NotificationModel _row({String? commentId}) => NotificationModel.fromJson({
      'id': 'comment:c1',
      'kind': 'comment',
      'createdAt':
          DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
      'actor': {'id': 'u2', 'name': 'Weaver', 'username': 'weaver'},
      'postId': 'p1',
      'postSnippet': 'psst.. did you watch yesterday\'s spacewalk?',
      'postImage': 'https://example.invalid/p.png',
      'content': 'Cool!',
      if (commentId != null) 'commentId': commentId,
    });

void main() {
  late List<String> opened;

  Future<void> pump(WidgetTester tester, NotificationModel row) async {
    opened = [];
    await tester.pumpWidget(
      MaterialApp(
        theme: KyronTheme.lightTheme,
        home: Scaffold(
          body: NotificationItem(
            notification: row,
            onTap: () => opened.add('row'),
            onActor: () => opened.add('profile'),
            onPost: () => opened.add('post'),
            onContent: row.commentId == null ? null : () => opened.add('reply'),
          ),
        ),
      ),
    );
  }

  testWidgets('the face and the name open the person', (tester) async {
    await pump(tester, _row(commentId: 'c1'));
    await tester
        .tap(find.byKey(const ValueKey('notification-actor-comment:c1')));
    await tester.tapOnText(find.textRange.ofSubstring('Weaver'));
    expect(opened, ['profile', 'profile']);
  });

  testWidgets('the picture opens the post, a reply\'s words the reply', (
    tester,
  ) async {
    await pump(tester, _row(commentId: 'c1'));
    await tester
        .tap(find.byKey(const ValueKey('notification-post-comment:c1')));
    await tester.tap(find.text('Cool!'));
    expect(opened, ['post', 'reply']);
  });

  testWidgets('the rest of the row opens what the row is about', (
    tester,
  ) async {
    await pump(tester, _row());
    // The action's own words, after the name.
    await tester.tapOnText(find.textRange.ofSubstring('replied'));
    // Words that are the post's, not a reply's, fall through to the row.
    await tester.tap(find.text('Cool!'));
    expect(opened, ['row', 'row']);
  });

  test('the reply a row is about comes from the API', () {
    expect(_row(commentId: 'c9').commentId, 'c9');
    expect(_row().commentId, isNull);
  });
}
