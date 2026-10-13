import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/conversation.dart';
import 'package:kyron_app/providers/messages_provider.dart';
import 'package:kyron_app/repositories/keys_repository.dart';
import 'package:kyron_app/repositories/messages_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/message_vault.dart';
import 'package:kyron_app/widgets/bottom_nav_v4.dart';
import 'package:kyron_app/widgets/nav_destinations.dart';
import 'package:kyron_app/widgets/side_rail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Something new in Messages shows on its tab.
///
/// The count of unread conversations was fetched, kept fresh by the socket,
/// and drawn nowhere: the only way to find a new message was to go to
/// Messages and look.
class _Repo extends MessagesRepository {
  _Repo() : super(ApiClient()..dio.interceptors.clear());

  int marked = 0;

  @override
  Future<MessagePage> messages(
    String id, {
    String? cursor,
    int limit = 40,
  }) async =>
      const MessagePage(items: []);

  @override
  Future<void> markRead(String id) async => marked++;
}

void main() {
  Future<void> bar(WidgetTester tester, int unread) => tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: BottomNavV4(
              currentIndex: 0,
              onTap: (_) {},
              badges: {NavDestinations.messages.index: unread},
            ),
          ),
        ),
      );

  testWidgets('the Messages tab carries a count of unread conversations', (
    tester,
  ) async {
    await bar(tester, 3);

    final badge = find.byKey(const ValueKey('nav-badge'));
    expect(badge, findsOneWidget);
    expect(
      find.descendant(of: badge, matching: find.text('3')),
      findsOneWidget,
    );
    // On Messages, and nowhere else.
    expect(
      tester.getCenter(badge).dx,
      greaterThan(tester.getCenter(find.text('Communities')).dx),
    );
    // Red: the colour a phone has taught everybody a waiting count is.
    final box = tester.widget<Container>(badge).decoration! as BoxDecoration;
    expect(box.color, NavBadge.red);
  });

  testWidgets('past nine it says 9+, and at none it is not there', (
    tester,
  ) async {
    await bar(tester, 14);
    expect(find.text('9+'), findsOneWidget);

    await bar(tester, 0);
    expect(find.byKey(const ValueKey('nav-badge')), findsNothing);
  });

  testWidgets('the side rail carries it too', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                SideRail(
                  currentIndex: 0,
                  onSelect: (_) {},
                  badges: {NavDestinations.messages.index: 2},
                ),
              ],
            ),
          ),
        ),
      ),
    );
    expect(find.byKey(const ValueKey('nav-badge')), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
  });

  test('reading a conversation tells the badge', () async {
    // It used to sit where it was until something else refreshed it.
    final repo = _Repo();
    var told = 0;
    ThreadNotifier(
      repo,
      MessageVault(KeysRepository(ApiClient())),
      'c1',
      onRead: () => told++,
    );
    await pumpEventQueue();

    expect(repo.marked, 1);
    expect(told, 1);
  });
}
