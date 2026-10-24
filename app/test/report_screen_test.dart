import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/l10n/app_localizations.dart';
import 'package:kyron_app/providers/moderation_provider.dart';
import 'package:kyron_app/repositories/moderation_repository.dart';
import 'package:kyron_app/screens/report_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/app_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Moderation extends ModerationRepository {
  _Moderation() : super(ApiClient());

  final sent = <(ReportTarget, String, ReportReason, String?)>[];

  @override
  Future<void> report({
    required ReportTarget target,
    required String targetId,
    required ReportReason reason,
    String? detail,
  }) async =>
      sent.add((target, targetId, reason, detail));
}

Future<_Moderation> _open(
  WidgetTester tester, {
  ReportTarget target = ReportTarget.post,
  String subject = 'this post',
  Locale? locale,
}) async {
  final repo = _Moderation();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [moderationRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(
        locale: locale,
        supportedLocales: [if (locale != null) locale, const Locale('en')],
        localizationsDelegates: locale == null
            ? null
            : const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
        home: ReportScreen(target: target, targetId: 't1', subject: subject),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('a post, a reply and a message are named by what they are', (
    tester,
  ) async {
    // Not "What is wrong with $subject?": "this post" set into another
    // sentence takes a case in most languages that it does not take alone.
    await _open(tester);
    expect(find.text('What is wrong with this post?'), findsOneWidget);

    await _open(tester, target: ReportTarget.comment, subject: 'ignored');
    expect(find.text('What is wrong with this reply?'), findsOneWidget);

    await _open(
      tester,
      target: ReportTarget.communityMessage,
      subject: '@ada',
    );
    expect(find.text('What is wrong with this message?'), findsOneWidget);
  });

  testWidgets('an account is named by its handle', (tester) async {
    await _open(tester, target: ReportTarget.user, subject: '@ada');
    expect(find.text('What is wrong with @ada?'), findsOneWidget);
  });

  testWidgets('lists every rule with what it covers', (tester) async {
    await _open(tester);
    expect(find.text('Spam'), findsOneWidget);
    expect(
      find.text('Repetitive, misleading, or unwanted promotion.'),
      findsOneWidget,
    );
    await tester.scrollUntilVisible(find.text('Something else'), 200);
    expect(
      find.text('None of the above. Tell us what is wrong.'),
      findsOneWidget,
    );
  });

  testWidgets('reads in the reader\'s language', (tester) async {
    // The rules and their descriptions were English in every language.
    await _open(tester, locale: const Locale('de'));
    expect(find.text('Melden'), findsOneWidget);
    expect(find.text('Was stimmt mit diesem Beitrag nicht?'), findsOneWidget);
    expect(find.text('Hassrede'), findsOneWidget);
    expect(
      find.text('Wiederholte, irreführende oder unerwünschte Werbung.'),
      findsOneWidget,
    );
  });

  testWidgets('sends the reason and says what happens next', (tester) async {
    final repo = await _open(tester);
    await tester.tap(find.text('Spam'));
    await tester.pumpAndSettle();
    expect(find.text('Anything to add? (optional)'), findsOneWidget);

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(repo.sent.single.$3, ReportReason.spam);
    expect(find.text('Thanks for telling us'), findsOneWidget);
    expect(
      find.textContaining('Your report has been received'),
      findsOneWidget,
    );
    // Sending is logged, and the log's flush is a timer the framework would
    // otherwise report as still pending.
    await AppLog.instance.flush();
  });

  testWidgets('"Something else" needs a few words first', (tester) async {
    final repo = await _open(tester);
    await tester.scrollUntilVisible(find.text('Something else'), 200);
    await tester.tap(find.text('Something else'));
    await tester.pumpAndSettle();
    expect(find.text('Tell us what is wrong'), findsOneWidget);

    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    expect(repo.sent, isEmpty);

    await tester.enterText(find.byType(TextField), 'It is a bot.');
    await tester.pump();
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    expect(repo.sent.single.$4, 'It is a bot.');
    await AppLog.instance.flush();
  });
}
