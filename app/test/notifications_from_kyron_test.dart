import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/account_standing.dart';
import 'package:kyron_app/models/notification_model.dart';
import 'package:kyron_app/providers/notifications_provider.dart';
import 'package:kyron_app/repositories/moderation_repository.dart';
import 'package:kyron_app/repositories/notifications_repository.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/screens/notifications_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/notification_item.dart';

/// Decisions about the account and what came of its reports, as rows in
/// Notifications. They were pushed and then only to be found under
/// Settings; a push missed left nothing in the app to find them by.
NotificationModel _parse(Map<String, dynamic> json) =>
    NotificationModel.fromJson({
      'id': 'x',
      'createdAt': DateTime.now().toIso8601String(),
      'unread': true,
      ...json,
    });

final _decision = _parse({
  'id': 'account:decision:a1',
  'kind': 'account',
  'actor': null,
  'postSnippet': 'buy followers cheap',
  'account': {
    'event': 'decision',
    'actionId': 'a1',
    'number': 12,
    'kind': 'REMOVE',
    'rule': 'SPAM',
    'target': 'POST',
    'endsAt': null,
  },
});

final _report = _parse({
  'id': 'report:r1',
  'kind': 'report',
  'actor': null,
  'postSnippet': 'you are awful',
  'report': {
    'outcome': 'DISMISSED',
    'target': 'COMMENT',
    'reason': 'HARASSMENT',
  },
});

class _Repo extends NotificationsRepository {
  _Repo(this.rows) : super(ApiClient());
  final List<NotificationModel> rows;

  @override
  Future<NotificationPage> list({
    String? cursor,
    int limit = 30,
    NotificationType? kind,
  }) async =>
      NotificationPage(items: kind == null ? rows : const []);

  @override
  Future<int> unreadCount() async => 0;

  @override
  Future<void> markSeen() async {}
}

Future<void> _row(WidgetTester tester, NotificationModel row) =>
    tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NotificationItem(notification: row, onTap: () {}),
        ),
      ),
    );

void main() {
  group('a row from Kyron', () {
    test('reads what the server sent, with nobody named', () {
      expect(_decision.type, NotificationType.account);
      expect(_decision.actor, isNull);
      expect(_decision.fromKyron, isTrue);
      expect(_decision.account!.kind, ModerationKind.remove);
      expect(_decision.account!.rule, ReportReason.spam);
      expect(_decision.account!.number, 12);
      expect(_report.report!.actioned, isFalse);
      expect(_report.report!.target, ReportTarget.comment);
    });

    testWidgets('says what was decided, the case and the rule', (
      tester,
    ) async {
      await _row(tester, _decision);
      expect(find.text('Your post was removed'), findsOneWidget);
      expect(
        find.text('Case 12 · Spam · buy followers cheap'),
        findsOneWidget,
      );
    });

    testWidgets('says until when a suspension runs', (tester) async {
      await _row(
        tester,
        _parse({
          'kind': 'account',
          'account': {
            'event': 'decision',
            'number': 3,
            'kind': 'SUSPEND',
            'rule': 'SPAM',
            'endsAt': '2026-10-28T12:00:00.000Z',
          },
        }),
      );
      expect(
        find.text('Your account is suspended until Oct 28, 2026'),
        findsOneWidget,
      );
    });

    testWidgets('says an appeal was accepted, or that it stands', (
      tester,
    ) async {
      Map<String, dynamic> appeal(bool overturned) => {
            'kind': 'account',
            'account': {
              'event': 'appeal',
              'number': 7,
              'kind': 'WARN',
              'rule': 'SPAM',
              'overturned': overturned,
            },
          };
      await _row(tester, _parse(appeal(true)));
      expect(find.text('Your appeal on case 7 was accepted'), findsOneWidget);
      await _row(tester, _parse(appeal(false)));
      expect(find.textContaining('the decision stands'), findsOneWidget);
    });

    testWidgets('says what came of a report, and what it was about', (
      tester,
    ) async {
      await _row(tester, _report);
      expect(find.textContaining('did not find that it broke'), findsOneWidget);
      expect(
        find.text('Reported for: Harassment or bullying · you are awful'),
        findsOneWidget,
      );
    });
  });

  group('in the list', () {
    Future<List<String?>> open(WidgetTester tester) async {
      final routes = <String?>[];
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationsRepositoryProvider.overrideWithValue(
              _Repo([_decision, _report]),
            ),
          ],
          child: MaterialApp(
            home: const NotificationsScreen(),
            onGenerateRoute: (settings) {
              routes.add(settings.name);
              return MaterialPageRoute<void>(
                settings: settings,
                builder: (_) => const Scaffold(),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      return routes;
    }

    testWidgets('a decision opens Account status', (tester) async {
      final routes = await open(tester);
      await tester.tap(
        find.byKey(const ValueKey('notification-kyron-account:decision:a1')),
      );
      await tester.pumpAndSettle();
      expect(routes, [Routes.accountStatus]);
    });

    testWidgets("a report's outcome opens Your reports", (tester) async {
      final routes = await open(tester);
      await tester.tap(
        find.byKey(const ValueKey('notification-kyron-report:r1')),
      );
      await tester.pumpAndSettle();
      expect(routes, [Routes.yourReports]);
    });
  });
}
