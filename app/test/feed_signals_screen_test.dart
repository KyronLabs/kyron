import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/interest_signal.dart';
import 'package:kyron_app/providers/moderation_provider.dart';
import 'package:kyron_app/repositories/moderation_repository.dart';
import 'package:kyron_app/screens/feed_signals_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// "Not interested" used to be a near-mute on the author that nobody could
/// see or take back. This is where the reader sees every signal still being
/// read, and stops any of them.
class _Moderation extends ModerationRepository {
  _Moderation(this.signals, {this.failClear = false}) : super(ApiClient());

  final List<InterestSignal> signals;
  final bool failClear;
  final cleared = <String>[];

  @override
  Future<List<InterestSignal>> interestSignals() async => List.of(signals);

  @override
  Future<void> clearInterest(String postId) async {
    if (failClear) throw Exception('offline');
    cleared.add(postId);
    signals.removeWhere((s) => s.postId == postId);
  }
}

InterestSignal _signal(
  String id, {
  bool more = false,
  double strength = 1,
  String excerpt = 'A post about the derby',
}) =>
    InterestSignal(
      postId: id,
      more: more,
      givenAt: DateTime(2026, 10, 20),
      strength: strength,
      excerpt: excerpt,
      authorName: 'Ada',
      authorUsername: 'ada',
      topics: const ['Football'],
      hashtags: const ['derby'],
    );

Future<void> _pump(WidgetTester tester, _Moderation repo) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [moderationRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(
        theme: KyronTheme.lightTheme,
        home: const FeedSignalsScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('lists each signal with what it said and what it was about', (
    tester,
  ) async {
    await _pump(
      tester,
      _Moderation([
        _signal('p1'),
        _signal('p2', more: true, strength: 0.3, excerpt: 'Jazz tonight'),
      ]),
    );

    expect(find.text('A post about the derby'), findsOneWidget);
    expect(
      find.text('Not interested · Ada · Football, #derby'),
      findsOneWidget,
    );
    // An old one says it is fading, so the list reads true at a glance.
    expect(
      find.text('Show more like this · Ada · Football, #derby · Fading'),
      findsOneWidget,
    );
  });

  testWidgets('removing one takes it back and drops the row', (tester) async {
    final repo = _Moderation([_signal('p1'), _signal('p2', excerpt: 'Other')]);
    await _pump(tester, repo);

    await tester.tap(find.byTooltip('Remove').first);
    await tester.pumpAndSettle();

    expect(repo.cleared, ['p1']);
    expect(find.text('A post about the derby'), findsNothing);
    expect(find.text('Other'), findsOneWidget);
    // Let the "Removed" toast run out.
    await tester.pump(const Duration(seconds: 6));
  });

  testWidgets('a failed remove keeps the row and says so', (tester) async {
    await _pump(tester, _Moderation([_signal('p1')], failClear: true));

    await tester.tap(find.byTooltip('Remove'));
    await tester.pumpAndSettle();

    expect(find.text('A post about the derby'), findsOneWidget);
    expect(find.textContaining('did not go through'), findsOneWidget);
    await tester.pump(const Duration(seconds: 6));
  });

  testWidgets('says how to add one when there are none', (tester) async {
    await _pump(tester, _Moderation([]));

    expect(find.text('Nothing here yet'), findsOneWidget);
  });

  test('reads a signal off the wire, and refuses what is not one', () {
    final signal = InterestSignal.tryFrom({
      'postId': 'p1',
      'kind': 'LESS',
      'givenAt': '2026-10-20T10:00:00.000Z',
      'strength': 0.75,
      'excerpt': 'Hello',
      'author': {'id': 'a', 'name': '', 'username': 'ada'},
      'topics': ['Football'],
      'hashtags': ['derby'],
    })!;
    expect(signal.more, isFalse);
    expect(signal.strength, 0.75);
    // No display name: the handle stands in for it.
    expect(signal.authorName, 'ada');

    expect(InterestSignal.tryFrom({'postId': 'p1', 'kind': 'MAYBE'}), isNull);
  });
}
