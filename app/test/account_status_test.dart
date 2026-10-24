import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/l10n/app_localizations.dart';
import 'package:kyron_app/models/account_standing.dart';
import 'package:kyron_app/models/moderation_case.dart';
import 'package:kyron_app/providers/enforcement_provider.dart';
import 'package:kyron_app/repositories/enforcement_repository.dart';
import 'package:kyron_app/repositories/moderation_repository.dart';
import 'package:kyron_app/screens/account_status_screen.dart';
import 'package:kyron_app/screens/your_reports_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/push_tap.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/utils/api_error_message.dart';

/// The account's side of enforcement. Kyron had a report button and nothing
/// behind it; now an account the team acts against is always told why, and
/// can appeal from the same place.
class _Enforcement extends EnforcementRepository {
  _Enforcement(this.standingNow) : super(ApiClient());

  AccountStanding standingNow;
  final appeals = <(String, String)>[];
  int seen = 0;

  @override
  Future<AccountStanding> standing() async => standingNow;

  @override
  Future<void> markSeen() async => seen++;

  @override
  Future<ModerationNotice> appeal(String actionId, String statement) async {
    appeals.add((actionId, statement));
    final notice = standingNow.notices.firstWhere((n) => n.id == actionId);
    return ModerationNotice(
      id: notice.id,
      number: notice.number,
      kind: notice.kind,
      rule: notice.rule,
      message: notice.message,
      createdAt: notice.createdAt,
      target: notice.target,
      snapshot: notice.snapshot,
      appeal: AppealView(
        status: AppealStatus.open,
        statement: statement,
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<List<ReportCase>> reportQueue() async => const [];
}

final _removed = ModerationNotice(
  id: 'a1',
  number: 12,
  kind: ModerationKind.remove,
  rule: ReportReason.spam,
  message: 'This post sells followers, which is spam on Kyron.',
  target: ReportTarget.post,
  snapshot: 'buy followers cheap',
  createdAt: DateTime(2026, 10, 18),
  seen: false,
  appealBy: DateTime(2027, 4, 16),
);

Future<_Enforcement> _open(
  WidgetTester tester,
  AccountStanding standing, {
  Widget home = const AccountStatusScreen(),
  Locale? locale,
}) async {
  final repo = _Enforcement(standing);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [enforcementRepositoryProvider.overrideWithValue(repo)],
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
        home: home,
      ),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

void main() {
  testWidgets('says the account is in good standing when it is', (
    tester,
  ) async {
    await _open(tester, const AccountStanding(status: StandingStatus.active));
    expect(find.text('Your account is in good standing'), findsOneWidget);
    expect(find.textContaining('Nothing has been decided'), findsOneWidget);
  });

  testWidgets('lists a decision, and marks the page read', (tester) async {
    final repo = await _open(
      tester,
      AccountStanding(status: StandingStatus.active, notices: [_removed]),
    );
    expect(find.text('Post removed'), findsOneWidget);
    expect(find.textContaining('Can be appealed'), findsOneWidget);
    expect(repo.seen, 1);
  });

  testWidgets('says until when a suspension runs', (tester) async {
    await _open(
      tester,
      AccountStanding(
        status: StandingStatus.suspended,
        until: DateTime(2026, 10, 26, 12),
      ),
    );
    // In the reader's way of writing a date, and their clock.
    expect(
      find.textContaining('Suspended until Oct 26, 2026'),
      findsOneWidget,
    );
    expect(
        find.textContaining('Reporting, blocking and muting'), findsOneWidget);
  });

  testWidgets('Your reports shows what came of each', (tester) async {
    // It was a section at the foot of Account status, which is about
    // decisions against the account -- not where anybody looks.
    await _open(
      tester,
      home: const YourReportsScreen(),
      AccountStanding(
        status: StandingStatus.active,
        reports: [
          ReportUpdate(
            id: 'r1',
            target: ReportTarget.post,
            reason: ReportReason.harassment,
            about: 'you are awful',
            createdAt: DateTime(2026, 10, 17),
            outcome: ReportOutcome.actioned,
          ),
          ReportUpdate(
            id: 'r2',
            target: ReportTarget.user,
            reason: ReportReason.spam,
            createdAt: DateTime(2026, 10, 16),
            outcome: ReportOutcome.dismissed,
          ),
        ],
      ),
    );
    expect(find.text('Action taken'), findsOneWidget);
    expect(find.text('No rule broken'), findsOneWidget);
    expect(find.text('A post · Harassment or bullying'), findsOneWidget);
    expect(find.text('An account · Spam'), findsOneWidget);
    expect(find.text('“you are awful”'), findsOneWidget);
  });

  testWidgets('Your reports says when there is nothing in it', (tester) async {
    await _open(
      tester,
      home: const YourReportsScreen(),
      const AccountStanding(status: StandingStatus.active),
    );
    expect(find.text('Nothing reported'), findsOneWidget);
  });

  testWidgets('Account status leads to Your reports instead of listing them', (
    tester,
  ) async {
    await _open(
      tester,
      AccountStanding(
        status: StandingStatus.active,
        reports: [
          ReportUpdate(
            id: 'r1',
            target: ReportTarget.post,
            reason: ReportReason.spam,
            createdAt: DateTime(2026, 10, 17),
            outcome: ReportOutcome.pending,
          ),
        ],
      ),
    );
    expect(
      find.byKey(const ValueKey('account-status-your-reports')),
      findsOneWidget,
    );
    expect(find.text('In review'), findsNothing);
  });

  testWidgets('a decision shows why, what it was about, and the appeal', (
    tester,
  ) async {
    final repo = await _open(
      tester,
      AccountStanding(status: StandingStatus.active, notices: [_removed]),
    );
    await tester.tap(find.text('Post removed'));
    await tester.pumpAndSettle();

    expect(find.text('Case 12'), findsOneWidget);
    expect(find.text(_removed.message), findsOneWidget);
    expect(find.text('buy followers cheap'), findsOneWidget);

    final appeal = find.text('Appeal this decision');
    await tester.ensureVisible(appeal);
    await tester.tap(appeal);
    await tester.pumpAndSettle();

    // Not until there is something for the reviewer to weigh.
    await tester.enterText(find.byType(TextField), 'Unfair.');
    await tester.pump();
    await tester.tap(find.text('Send appeal'));
    await tester.pump();
    expect(repo.appeals, isEmpty);

    await tester.enterText(
      find.byType(TextField),
      'I was quoting the scam to warn people about it.',
    );
    await tester.pump();
    await tester.tap(find.text('Send appeal'));
    await tester.pumpAndSettle();

    expect(repo.appeals, [
      ('a1', 'I was quoting the scam to warn people about it.'),
    ]);
    // Back on the decision, which now says it is being looked at.
    expect(find.text('Appeal under review'), findsOneWidget);
    expect(find.text('Appeal this decision'), findsNothing);
    await tester.pump(const Duration(seconds: 6));
  });

  testWidgets('a reversed decision says so and offers no appeal', (
    tester,
  ) async {
    final reversed = ModerationNotice(
      id: 'a2',
      number: 13,
      kind: ModerationKind.suspend,
      rule: ReportReason.spam,
      message: 'Seven days for spam.',
      createdAt: DateTime(2026, 10, 10),
      endsAt: DateTime(2026, 10, 17),
      reversedAt: DateTime(2026, 10, 11),
      reversal: 'It was a scam warning. Sorry.',
    );
    await _open(
      tester,
      const AccountStanding(status: StandingStatus.active),
      home: ModerationNoticeScreen(notice: reversed),
    );
    // Until when, not "for 7 days": a plural most of the languages this is
    // in form differently.
    expect(find.text('Suspended until Oct 17, 2026'), findsOneWidget);
    expect(find.textContaining('It was a scam warning'), findsOneWidget);
    expect(find.text('Appeal this decision'), findsNothing);
  });

  testWidgets('reads in the reader\'s language, dates included', (
    tester,
  ) async {
    // It was English whatever the phone was set to, down to the date.
    await _open(
      tester,
      AccountStanding(status: StandingStatus.active, notices: [_removed]),
      locale: const Locale('fr'),
    );
    expect(find.text('Votre compte est en règle'), findsOneWidget);
    expect(find.text('Publication supprimée'), findsOneWidget);
    expect(find.textContaining('18 oct. 2026'), findsOneWidget);
    expect(find.textContaining('Appel possible'), findsOneWidget);

    await tester.tap(find.text('Publication supprimée'));
    await tester.pumpAndSettle();
    expect(find.text('Cas 12'), findsOneWidget);
    expect(find.textContaining('Règle : Spam'), findsOneWidget);
    expect(find.text('Faire appel de cette décision'), findsOneWidget);
  });

  testWidgets('a banned account sees why, and the ways out', (tester) async {
    final ban = ModerationNotice(
      id: 'a3',
      number: 14,
      kind: ModerationKind.ban,
      rule: ReportReason.harassment,
      message: 'Replies aimed at a person, over and over.',
      createdAt: DateTime(2026, 10, 18),
      appealBy: DateTime(2027, 4, 16),
    );
    await _open(
      tester,
      AccountStanding(status: StandingStatus.banned, notices: [ban]),
      home: const RestrictedScreen(),
    );
    expect(find.text('Your account has been banned'), findsOneWidget);
    expect(find.text(ban.message), findsOneWidget);
    expect(find.text('See details and appeal'), findsOneWidget);
    expect(find.text('Contact support'), findsOneWidget);
    expect(find.text('Delete your account'), findsOneWidget);
    expect(find.text('Sign out'), findsOneWidget);
  });

  group('the refusal', () {
    DioException refused(Map<String, Object?> body) => DioException(
          requestOptions: RequestOptions(path: '/feed'),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: '/feed'),
            statusCode: 403,
            data: body,
          ),
        );

    const body = {
      'statusCode': 403,
      'code': 'ACCOUNT_RESTRICTED',
      'status': 'SUSPENDED',
      'until': '2026-10-26T12:00:00.000Z',
      'message': 'This account is suspended, so it can read but not post.',
    };

    test('is recognised, with its end', () {
      final restriction = AccountRestriction.fromResponse(body)!;
      expect(restriction.status, StandingStatus.suspended);
      expect(restriction.until?.toUtc(), DateTime.utc(2026, 10, 26, 12));
      expect(restriction.banned, isFalse);
    });

    test('is not mistaken for anything else', () {
      expect(AccountRestriction.fromResponse({'statusCode': 403}), isNull);
      expect(AccountRestriction.fromResponse('Forbidden'), isNull);
    });

    test('is not called an expired session', () {
      // "Sign in again" would be a loop: signing in changes nothing about a
      // suspension.
      expect(
        describeApiError(refused(body)),
        'This account is suspended, so it can read but not post.',
      );
    });
  });

  test('a notification about a decision opens Account status', () {
    expect(
      pushDestination({'type': 'moderation'})?.route,
      Routes.accountStatus,
    );
    // What came of a report opens the reader's reports instead.
    expect(
      pushDestination({'type': 'moderation', 'about': 'report'})?.route,
      Routes.yourReports,
    );
    expect(
      pushDestination({'type': 'moderation.queue'})?.route,
      Routes.moderation,
    );
  });
}
