import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/notification_model.dart';
import 'package:kyron_app/providers/notifications_provider.dart';
import 'package:kyron_app/repositories/notifications_repository.dart';
import 'package:kyron_app/screens/notifications_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/notification_item.dart';

/// Somebody writing @you, as a row. Before this nothing recorded a mention,
/// so being named in a post or a reply told you nothing at all.
final _mention = NotificationModel.fromJson({
  'id': 'mention:m1',
  'kind': 'mention',
  'createdAt': DateTime.now().toIso8601String(),
  'unread': true,
  'actor': {'id': 'u1', 'name': 'Ada', 'username': 'ada'},
  'postId': 'p1',
  'postSnippet': 'the whole post',
  'content': 'what do you think @me',
});

class _Repo extends NotificationsRepository {
  _Repo() : super(ApiClient());
  final asked = <NotificationType?>[];

  @override
  Future<NotificationPage> list({
    String? cursor,
    int limit = 30,
    NotificationType? kind,
  }) async {
    asked.add(kind);
    return NotificationPage(
      items: kind == null || kind == NotificationType.mention
          ? [_mention]
          : const [],
    );
  }

  @override
  Future<int> unreadCount() async => 0;

  @override
  Future<void> markSeen() async {}
}

void main() {
  test('a mention is read as a mention, not a like', () {
    expect(_mention.type, NotificationType.mention);
    expect(_mention.content, 'what do you think @me');
  });

  test('the app asks for mentions, which an older one would misread', () {
    expect(NotificationsRepository.include.split(','), contains('mentions'));
    expect(NotificationsRepository.include.split(','), contains('moderation'));
  });

  testWidgets('says who named you, and the words they named you in', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NotificationItem(notification: _mention, onTap: () {}),
        ),
      ),
    );
    expect(find.textContaining('mentioned you'), findsOneWidget);
    expect(find.textContaining('what do you think @me'), findsOneWidget);
  });

  testWidgets('has a tab of its own', (tester) async {
    final repo = _Repo();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [notificationsRepositoryProvider.overrideWithValue(repo)],
        child: const MaterialApp(home: NotificationsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Mentions'));
    await tester.pumpAndSettle();
    expect(repo.asked, contains(NotificationType.mention));
    expect(find.byType(NotificationItem), findsWidgets);
  });
}
