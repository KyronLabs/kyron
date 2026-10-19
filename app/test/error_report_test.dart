import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/providers/feedback_provider.dart';
import 'package:kyron_app/repositories/feedback_repository.dart';
import 'package:kyron_app/screens/about_subscreens.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/app_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// "Send error report" opened a mail to support@kyron.so -- a domain Kyron
/// does not own, so every report bounced, and whoever registered it would
/// have been sent people's logs. It now goes privately to the team, through
/// the API, the way feedback does.
class _Inbox extends FeedbackRepository {
  _Inbox({this.fails = false}) : super(ApiClient());

  final bool fails;
  final sent = <Map<String, Object?>>[];

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<FiledReport> send({
    required FeedbackKind kind,
    required String title,
    required String body,
    String? appVersion,
    String? platform,
    String? log,
  }) async {
    sent.add({'kind': kind, 'title': title, 'body': body, 'log': log});
    if (fails) throw Exception('offline');
    return const FiledReport(number: 7);
  }
}

Future<void> _open(WidgetTester tester, _Inbox inbox) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [feedbackRepositoryProvider.overrideWithValue(inbox)],
      child: const MaterialApp(home: ErrorReportScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _send(WidgetTester tester) async {
  final send = find.text('Send to support');
  await tester.ensureVisible(send);
  await tester.pumpAndSettle();
  await tester.tap(send);
  await tester.pump();
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('sends the report and its log to the team, not to a mail app', (
    tester,
  ) async {
    AppLog.instance.info('e2ee', 'Could not fetch keys');
    final inbox = _Inbox();
    await _open(tester, inbox);

    await tester.enterText(
      find.byType(TextField),
      'It closed when I opened a chat.',
    );
    await _send(tester);

    expect(inbox.sent, hasLength(1));
    final report = inbox.sent.single;
    expect(report['kind'], FeedbackKind.report);
    expect(report['body'], 'It closed when I opened a chat.');
    expect(report['log'] as String?, contains('Could not fetch keys'));
    expect(find.textContaining('report #7'), findsOneWidget);
    await tester.pump(const Duration(seconds: 6));
  });

  testWidgets('leaves the log out when asked to', (tester) async {
    AppLog.instance.info('e2ee', 'Could not fetch keys');
    final inbox = _Inbox();
    await _open(tester, inbox);

    await tester.tap(find.byType(Switch));
    await tester.pump();
    await _send(tester);

    expect(inbox.sent.single['log'], isNull);
    await tester.pump(const Duration(seconds: 6));
  });

  testWidgets('a report with no words still goes, and says so', (
    tester,
  ) async {
    final inbox = _Inbox();
    await _open(tester, inbox);

    await _send(tester);

    expect(inbox.sent.single['body'], startsWith('(no description given)'));
    await tester.pump(const Duration(seconds: 6));
  });

  testWidgets('keeps the screen, and Copy, when sending fails', (tester) async {
    final inbox = _Inbox(fails: true);
    await _open(tester, inbox);

    await tester.enterText(find.byType(TextField), 'It closed again.');
    await _send(tester);
    await tester.pumpAndSettle();

    expect(find.text('It closed again.'), findsOneWidget);
    expect(find.text('Copy report instead'), findsOneWidget);
  });
}
