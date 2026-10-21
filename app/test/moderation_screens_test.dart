import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/account_standing.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/models/moderation_case.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/models/verification.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/providers/enforcement_provider.dart';
import 'package:kyron_app/providers/verification_provider.dart';
import 'package:kyron_app/repositories/enforcement_repository.dart';
import 'package:kyron_app/repositories/moderation_repository.dart';
import 'package:kyron_app/repositories/verification_repository.dart';
import 'package:kyron_app/screens/moderation_screens.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/action_button.dart';
import 'package:kyron_app/widgets/media_grid.dart';
import 'package:kyron_app/widgets/verified_badge.dart';
import 'package:kyron_app/widgets/voice_post_player.dart';

/// The team's side: the queues, and the decisions. Reports used to be
/// written down and read by nobody, because there was nowhere to read them.
class _Team extends EnforcementRepository {
  _Team({this.reports = const [], this.record}) : super(ApiClient());

  final List<ReportCase> reports;
  final AccountRecord? record;
  final List<AppealCase> appeals = const [];
  final acts = <Map<String, Object?>>[];
  final decisions = <(String, bool, String)>[];
  final dismissed = <String>[];

  @override
  Future<List<ReportCase>> reportQueue() async => reports;

  @override
  Future<List<AppealCase>> appealQueue() async => appeals;

  @override
  Future<AccountRecord> account(String id) async => record!;

  @override
  Future<void> dismiss(ReportTarget target, String targetId) async =>
      dismissed.add(targetId);

  @override
  Future<CaseAction> act({
    required ModerationKind kind,
    required ReportReason rule,
    required String message,
    String? subjectId,
    String? note,
    ReportTarget? target,
    String? targetId,
    bool removeContent = true,
    int? days,
  }) async {
    acts.add({
      'kind': kind,
      'rule': rule,
      'message': message,
      'subjectId': subjectId,
      'target': target,
      'targetId': targetId,
      'removeContent': removeContent,
      'days': days,
    });
    return CaseAction(
      notice: ModerationNotice(
        id: 'new',
        number: 21,
        kind: kind,
        rule: rule,
        message: message,
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> decide(
    String appealId, {
    required bool overturn,
    required String response,
  }) async =>
      decisions.add((appealId, overturn, response));
}

/// Requests for the badge, and what the team does with them.
class _Badges extends VerificationRepository {
  _Badges({this.waiting = const []}) : super(ApiClient());

  final List<VerificationCase> waiting;
  final decisions = <(String, bool, String?)>[];
  final set = <(String, bool, String)>[];

  @override
  Future<List<VerificationCase>> queue() async => waiting;

  @override
  Future<void> decide(
    String requestId, {
    required bool approve,
    String? response,
  }) async =>
      decisions.add((requestId, approve, response));

  @override
  Future<void> setVerified(
    String accountId, {
    required bool verified,
    required String reason,
  }) async =>
      set.add((accountId, verified, reason));
}

const _ada = CaseAccount(id: 'ada', username: 'ada');

VerificationCase _asking({bool own = false, bool ready = true}) =>
    VerificationCase(
      accountId: own ? 'me' : 'ada',
      name: 'Ada Birds',
      username: 'ada',
      followers: 40,
      posts: 12,
      ownRequest: own,
      request: VerificationRequestView(
        id: 'v1',
        number: 4,
        category: VerificationCategory.creator,
        about: 'I write about birds here and on my own site.',
        links: const ['https://ada.example/about'],
        status: VerificationRequestStatus.pending,
        createdAt: DateTime(2026, 10, 18),
      ),
      requirements: [
        const VerificationRequirement(
          key: 'photo',
          label: 'A profile photo',
          met: true,
        ),
        VerificationRequirement(
          key: 'standing',
          label: 'Nothing on your record in the last 90 days',
          met: ready,
        ),
      ],
    );

/// Whoever is looking, on the team as [role].
class _Me extends CurrentUserNotifier {
  _Me(super.ref, this.role);
  final String role;

  @override
  Future<void> load({bool force = false}) async {
    state = AsyncData(
      CurrentUser(
        id: 'me',
        username: 'me',
        followers: 0,
        following: 0,
        posts: 0,
        role: role,
      ),
    );
  }
}

ReportCase _report({bool urgent = false, String id = 'p1'}) => ReportCase(
      target: ReportTarget.post,
      targetId: id,
      subject: _ada,
      content: 'buy followers cheap',
      snapshot: 'buy followers cheap',
      postId: id,
      reasons: [
        (
          reason: urgent ? ReportReason.selfHarm : ReportReason.spam,
          count: 2,
        ),
      ],
      reports: [
        CaseReport(
          id: 'r1',
          reason: urgent ? ReportReason.selfHarm : ReportReason.spam,
          detail: 'Posted the same link forty times.',
          createdAt: DateTime(2026, 10, 18),
          reporter: 'cy',
        ),
      ],
      firstAt: DateTime(2026, 10, 18),
      urgent: urgent,
    );

Future<_Team> _open(
  WidgetTester tester,
  Widget home, {
  _Team? team,
  _Badges? badges,
  String role = 'MODERATOR',
}) async {
  final repo = team ?? _Team();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        enforcementRepositoryProvider.overrideWithValue(repo),
        verificationRepositoryProvider.overrideWithValue(badges ?? _Badges()),
        currentUserProvider.overrideWith((ref) => _Me(ref, role)),
      ],
      child: MaterialApp(home: home),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('the queue says what is waiting, and how much', (tester) async {
    await _open(
      tester,
      const ModerationQueueScreen(),
      team: _Team(reports: [_report(urgent: true)]),
    );
    expect(find.text('Reports (1)'), findsOneWidget);
    expect(find.text('Post by @ada'), findsOneWidget);
    expect(find.textContaining('Suicide or self-harm ×2'), findsOneWidget);
  });

  testWidgets('an empty queue says so', (tester) async {
    await _open(tester, const ModerationQueueScreen());
    expect(find.text('Nothing reported'), findsOneWidget);
  });

  testWidgets('an urgent case says what to do beyond the app', (tester) async {
    await _open(tester, ReportCaseScreen(item: _report(urgent: true)));
    expect(find.textContaining('emergency services'), findsOneWidget);
  });

  testWidgets('a reported chat message shows what it carried', (
    tester,
  ) async {
    // The team is not in the community and cannot open the chat: without
    // these, a picture reported as abuse could not be looked at.
    final item = ReportCase.fromJson({
      'target': 'COMMUNITY_MESSAGE',
      'targetId': 'm1',
      'content': 'look at this',
      'media': [
        {'id': 'a', 'kind': 'IMAGE', 'url': 'https://signed.invalid/a.jpg'},
        {'id': 'b', 'kind': 'VOICE', 'url': 'https://signed.invalid/b.m4a'},
      ],
      'reasons': [
        {'reason': 'HARASSMENT', 'count': 1},
      ],
      'reports': [],
      'firstAt': '2026-10-18T00:00:00Z',
    });
    expect(item.media.map((m) => m.kind), [MediaKind.image, MediaKind.voice]);
    await _open(tester, ReportCaseScreen(item: item));
    expect(find.byType(MediaGrid), findsOneWidget);
    expect(find.byType(VoicePostPlayer), findsOneWidget);
  });

  testWidgets('dismissing asks first, then closes the reports', (
    tester,
  ) async {
    final team = await _open(tester, ReportCaseScreen(item: _report()));
    await _tap(tester, find.text('Dismiss'));
    expect(find.text('Dismiss these reports?'), findsOneWidget);
    await _tap(tester, find.text('Dismiss').last);
    expect(team.dismissed, ['p1']);
    await tester.pump(const Duration(seconds: 6));
  });

  testWidgets('a decision starts from the reports, and says what it does', (
    tester,
  ) async {
    final team = await _open(
      tester,
      const DecisionScreen(
        subject: _ada,
        target: ReportTarget.post,
        targetId: 'p1',
        rule: ReportReason.spam,
      ),
    );

    // Removing the post is where a report about a post starts.
    expect(find.text('Remove the post'), findsOneWidget);
    final message = tester.widget<TextField>(find.byType(TextField).first);
    expect(message.controller!.text, contains("rule on spam"));
    expect(message.controller!.text, contains('It has been removed.'));

    await _tap(tester, find.text('Suspend'));
    await _tap(tester, find.text('3 days'));
    expect(find.text('Suspend for 3 days'), findsOneWidget);
    expect(
      tester.widget<TextField>(find.byType(TextField).first).controller!.text,
      contains('for 3 days'),
    );

    await _tap(tester, find.text('Suspend for 3 days'));
    expect(team.acts.single, {
      'kind': ModerationKind.suspend,
      'rule': ReportReason.spam,
      'message': contains('for 3 days'),
      'subjectId': 'ada',
      'target': ReportTarget.post,
      'targetId': 'p1',
      'removeContent': true,
      'days': 3,
    });
    await tester.pump(const Duration(seconds: 6));
  });

  testWidgets('a warning can leave the post up', (tester) async {
    final team = await _open(
      tester,
      const DecisionScreen(
        subject: _ada,
        target: ReportTarget.post,
        targetId: 'p1',
      ),
    );
    await _tap(tester, find.text('Warn'));
    await _tap(tester, find.text('Take the post down too'));
    await _tap(tester, find.text('Send warning'));
    expect(team.acts.single['removeContent'], isFalse);
    expect(team.acts.single['message'], contains('nothing is restricted'));
    await tester.pump(const Duration(seconds: 6));
  });

  testWidgets('a ban asks once more', (tester) async {
    final team = await _open(tester, const DecisionScreen(subject: _ada));
    await _tap(tester, find.text('Ban'));
    await _tap(tester, find.text('Ban @ada'));
    expect(find.text('Ban @ada?'), findsOneWidget);
    expect(team.acts, isEmpty);
    await _tap(tester, find.text('Ban').last);
    expect(team.acts.single['kind'], ModerationKind.ban);
    await tester.pump(const Duration(seconds: 6));
  });

  AppealCase appeal({required bool mine}) => AppealCase(
        id: 'ap1',
        statement: 'I was quoting the scam to warn people about it.',
        createdAt: DateTime(2026, 10, 19),
        ownDecision: mine,
        action: CaseAction(
          notice: ModerationNotice(
            id: 'a1',
            number: 12,
            kind: ModerationKind.remove,
            rule: ReportReason.spam,
            message: 'This post sells followers.',
            target: ReportTarget.post,
            snapshot: 'buy followers cheap',
            createdAt: DateTime(2026, 10, 18),
          ),
          moderator: 'me',
          subject: _ada,
        ),
      );

  testWidgets('a moderator cannot hear an appeal against their own call', (
    tester,
  ) async {
    await _open(tester, AppealCaseScreen(appeal: appeal(mine: true)));
    expect(find.textContaining('somebody else on the team'), findsOneWidget);
    final overturn = tester.widget<ActionButton>(
      find.ancestor(
        of: find.text('Overturn'),
        matching: find.byType(ActionButton),
      ),
    );
    expect(overturn.onPressed, isNull);
  });

  testWidgets('somebody else decides it, and says why', (tester) async {
    final team = await _open(
      tester,
      AppealCaseScreen(appeal: appeal(mine: false)),
    );
    expect(find.text('I was quoting the scam to warn people about it.'),
        findsOneWidget);
    await _tap(tester, find.text('Overturn'));
    await tester.enterText(
      find.byType(TextField),
      'It was a warning about the scam, not the scam.',
    );
    await tester.pump();
    await _tap(tester, find.text('Overturn').last);
    expect(team.decisions, [
      ('ap1', true, 'It was a warning about the scam, not the scam.'),
    ]);
    await tester.pump(const Duration(seconds: 6));
  });

  group('the badge', () {
    testWidgets('requests wait in their own tab', (tester) async {
      await _open(
        tester,
        const ModerationQueueScreen(),
        badges: _Badges(waiting: [_asking(ready: false)]),
      );
      await _tap(tester, find.text('Badges (1)'));
      expect(find.text('Ada Birds · Creator'), findsOneWidget);
      expect(
        find.textContaining('no longer meets the requirements'),
        findsOneWidget,
      );
    });

    testWidgets('nobody answers their own request', (tester) async {
      await _open(tester, VerificationCaseScreen(item: _asking(own: true)));
      expect(find.textContaining('somebody else on the team'), findsOneWidget);
      for (final label in ['Verify', 'Turn down']) {
        final button = tester.widget<ActionButton>(
          find.ancestor(
            of: find.text(label),
            matching: find.byType(ActionButton),
          ),
        );
        expect(button.onPressed, isNull, reason: label);
      }
    });

    testWidgets('shows where to check, then a yes asks once more', (
      tester,
    ) async {
      final badges = _Badges();
      await _open(
        tester,
        VerificationCaseScreen(item: _asking()),
        badges: badges,
      );
      expect(find.text('https://ada.example/about'), findsOneWidget);
      expect(find.text('I write about birds here and on my own site.'),
          findsOneWidget);

      await _tap(tester, find.text('Verify'));
      expect(find.text('Verify Ada Birds?'), findsOneWidget);
      expect(badges.decisions, isEmpty);
      await _tap(tester, find.text('Verify').last);
      expect(badges.decisions, [('v1', true, null)]);
      await tester.pump(const Duration(seconds: 6));
    });

    testWidgets('a no says what would have made it a yes', (tester) async {
      final badges = _Badges();
      await _open(
        tester,
        VerificationCaseScreen(item: _asking()),
        badges: badges,
      );
      await _tap(tester, find.text('Turn down'));
      expect(find.text('Turn this request down?'), findsOneWidget);
      await tester.enterText(
        find.byType(TextField),
        'Neither link mentions this account.',
      );
      await tester.pump();
      await _tap(tester, find.text('Turn down').last);
      expect(badges.decisions, [
        ('v1', false, 'Neither link mentions this account.'),
      ]);
      await tester.pump(const Duration(seconds: 6));
    });

    testWidgets('the record gives it directly, saying how it was checked', (
      tester,
    ) async {
      // No handle, which is how some early accounts still are: the sheet
      // names them, not "an account".
      final badges = _Badges();
      await _open(
        tester,
        const ModerationAccountScreen(accountId: 'yun'),
        team: _Team(
          record: const AccountRecord(
            account: CaseAccount(id: 'yun', name: 'Yunnieee'),
            openReports: 0,
            actions: [],
          ),
        ),
        badges: badges,
        role: 'ADMIN',
      );
      await _tap(tester, find.text('Give the verified badge'));
      expect(find.text('Verify Yunnieee?'), findsOneWidget);
      await tester.enterText(
        find.byType(TextField),
        'Known to the team in person.',
      );
      await tester.pump();
      await _tap(tester, find.text('Verify').last);
      expect(badges.set, [('yun', true, 'Known to the team in person.')]);
      await tester.pump(const Duration(seconds: 6));
    });

    testWidgets('the record shows the badge, and nobody changes their own', (
      tester,
    ) async {
      await _open(
        tester,
        const ModerationAccountScreen(accountId: 'me'),
        team: _Team(
          record: const AccountRecord(
            account: CaseAccount(id: 'me', name: 'Me', verified: true),
            openReports: 0,
            actions: [],
          ),
        ),
        role: 'ADMIN',
      );
      expect(find.byType(VerifiedBadge), findsOneWidget);
      final button = tester.widget<ActionButton>(
        find.ancestor(
          of: find.text('Remove the verified badge'),
          matching: find.byType(ActionButton),
        ),
      );
      expect(button.onPressed, isNull);
    });
  });
}
