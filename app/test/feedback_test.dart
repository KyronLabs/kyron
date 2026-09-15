// test/feedback_test.dart
//
// "Send Feedback" used to open an EmptyState saying feedback had nowhere to
// go. It now files a real issue on the repository, through the API -- the
// GitHub token stays on the server, because a token shipped inside an
// installed app is a token anybody can read out of it.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/providers/feedback_provider.dart';
import 'package:kyron_app/repositories/feedback_repository.dart';
import 'package:kyron_app/screens/settings_subscreens.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/action_button.dart';

class _Refused implements Exception {
  @override
  String toString() => 'GitHub would not take it';
}

class _FakeFeedback extends FeedbackRepository {
  _FakeFeedback({this.available = true, this.sendFails = false})
      : super(ApiClient());

  final bool available;
  final bool sendFails;

  /// Every report this took, so a test can read back exactly what was filed.
  final List<Map<String, Object?>> filed = [];

  @override
  Future<bool> isAvailable() async => available;

  @override
  Future<FiledReport> send({
    required FeedbackKind kind,
    required String title,
    required String body,
    String? appVersion,
    String? platform,
  }) async {
    filed.add({
      'kind': kind,
      'title': title,
      'body': body,
      'appVersion': appVersion,
      'platform': platform,
    });
    if (sendFails) throw _Refused();
    return const FiledReport(
      number: 42,
      url: 'https://github.com/KyronLabs/kyron/issues/42',
    );
  }
}

void main() {
  Future<void> pump(WidgetTester tester, _FakeFeedback repo) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [feedbackRepositoryProvider.overrideWithValue(repo)],
        child: const MaterialApp(home: SettingsFeedbackScreen()),
      ),
    );
    // The screen asks whether reports can be filed before offering a form.
    await tester.pumpAndSettle();
  }

  /// The Send button, whatever else is on the screen.
  Finder sendButton() => find.ancestor(
        of: find.text('Send'),
        matching: find.byType(ActionButton),
      );

  testWidgets('says so before anything is typed, when it cannot be sent',
      (tester) async {
    // The whole point of asking first. Being told after writing three
    // paragraphs that they went nowhere is the version worth avoiding.
    await pump(tester, _FakeFeedback(available: false));

    expect(find.text('Feedback cannot be sent right now'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
  });

  testWidgets('offers the form when it can', (tester) async {
    await pump(tester, _FakeFeedback());

    expect(find.byType(TextField), findsNWidgets(2));
    for (final kind in FeedbackKind.values) {
      expect(find.text(kind.label), findsOneWidget);
    }
  });

  testWidgets('will not send until there is something to read',
      (tester) async {
    final repo = _FakeFeedback();
    await pump(tester, repo);

    ActionButton button() => tester.widget<ActionButton>(sendButton());
    expect(button().onPressed, isNull, reason: 'nothing typed yet');

    await tester.enterText(find.byType(TextField).first, 'No Post button');
    await tester.pump();
    expect(
      button().onPressed,
      isNull,
      reason: 'a title with no description is a report nobody can act on',
    );

    await tester.enterText(
      find.byType(TextField).last,
      'The composer has no Post button on a small screen.',
    );
    await tester.pump();
    expect(button().onPressed, isNotNull);
  });

  testWidgets('files what was written, trimmed, under the chosen kind',
      (tester) async {
    final repo = _FakeFeedback();
    await pump(tester, repo);

    await tester.enterText(find.byType(TextField).first, '  No Post button  ');
    await tester.enterText(
      find.byType(TextField).last,
      '  It is off the right-hand edge.  ',
    );
    await tester.tap(find.text('An idea'));
    await tester.pump();

    // Below the fold on a test-sized surface, where a tap would land on
    // nothing at all.
    await tester.ensureVisible(find.text('Send'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Send'));
    await tester.pump();
    // Not pumpAndSettle: a sent report raises a toast, whose timer keeps the
    // scheduler busy for as long as it is up.
    await tester.pump(const Duration(seconds: 6));

    expect(repo.filed, hasLength(1));
    final report = repo.filed.single;
    expect(report['kind'], FeedbackKind.idea);
    expect(report['title'], 'No Post button');
    expect(report['body'], 'It is off the right-hand edge.');
    // Which platform it came from, so a report can be placed. The version is
    // best-effort and absent here, because a test has no package metadata --
    // which is the point: the report goes either way.
    expect(report['platform'], isNotNull);
  });

  testWidgets('keeps the words on screen when sending fails', (tester) async {
    // Clearing the form on a failure loses what somebody wrote, and they have
    // no copy of it.
    final repo = _FakeFeedback(sendFails: true);
    await pump(tester, repo);

    await tester.enterText(find.byType(TextField).first, 'Crash on open');
    await tester.enterText(
      find.byType(TextField).last,
      'It closes as soon as the camera screen opens.',
    );
    await tester.pump();
    // Below the fold on a test-sized surface, where a tap would land on
    // nothing at all.
    await tester.ensureVisible(find.text('Send'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Send'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 6));

    expect(find.text('Crash on open'), findsOneWidget);
    expect(
      find.text('It closes as soon as the camera screen opens.'),
      findsOneWidget,
    );
    // And the button comes back, rather than staying busy forever.
    expect(tester.widget<ActionButton>(sendButton()).onPressed, isNotNull);
  });

  testWidgets('warns that the report will be public, and unattributed',
      (tester) async {
    // Somebody about to paste a screenshot of their inbox into "what
    // happened" should know where it is going before they do.
    await pump(tester, _FakeFeedback());

    final note = tester
        .widgetList<Text>(find.byType(Text))
        .map((t) => t.data ?? '')
        .firstWhere((t) => t.contains('public repository'), orElse: () => '');

    expect(note, isNotEmpty, reason: 'no warning that the issue is public');
    expect(note, contains('read by anybody'));
    expect(note, contains('are not attached'));
  });
}
