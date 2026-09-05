import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/explore_entry.dart';
import 'package:kyron_app/providers/composer_provider.dart';
import 'package:kyron_app/providers/explore_provider.dart';
import 'package:kyron_app/repositories/profile_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/topic_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeProfile extends ProfileRepository {
  _FakeProfile(this.catalogue) : super(ApiClient());
  final List<Topic> catalogue;
  @override
  Future<List<Topic>> topics() async => catalogue;
}

const _catalogue = [
  Topic(slug: 'music', name: 'Music'),
  Topic(slug: 'code', name: 'Software'),
  Topic(slug: 'art', name: 'Art'),
  Topic(slug: 'food', name: 'Food'),
];

/// Pumps the picker and hands back the scope it is running in.
///
/// A ProviderScope rather than a container of our own, so the composer's
/// placeholder timer is cancelled when the tree comes down rather than when a
/// tear-down runs -- which is after the test framework has already checked for
/// pending timers.
Future<ProviderContainer> _pump(
  WidgetTester tester, {
  List<Topic> catalogue = _catalogue,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        topicsProvider
            .overrideWith((ref) => TopicsNotifier(_FakeProfile(catalogue))),
      ],
      child: const MaterialApp(
        home: Scaffold(body: Center(child: TopicPicker())),
      ),
    ),
  );
  await tester.pumpAndSettle();
  // There is no draft store under a widget test, so the composer records that
  // it could not read one -- and the log's flush is a two-second timer the
  // test framework will otherwise report as still pending.
  await tester.pump(const Duration(seconds: 3));
  return ProviderScope.containerOf(
    tester.element(find.byType(TopicPicker)),
  );
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('offers the catalogue the server has', (tester) async {
    await _pump(tester);
    expect(find.text('Music'), findsOneWidget);
    expect(find.text('Software'), findsOneWidget);
    expect(find.text('Add a topic'), findsOneWidget);
  });

  testWidgets('is nothing at all when there is no catalogue', (tester) async {
    // A row of controls that cannot do anything is worse than no row.
    await _pump(tester, catalogue: const []);
    expect(find.byType(SizedBox), findsWidgets);
    expect(find.text('Add a topic'), findsNothing);
  });

  testWidgets('files the post under what the author taps', (tester) async {
    final container = await _pump(tester);

    await tester.tap(find.text('Music'));
    await tester.pumpAndSettle();

    expect(container.read(composerProvider).topics, ['music']);
    expect(find.text('Filed under 1 of 3'), findsOneWidget);
  });

  testWidgets('takes it back out on a second tap', (tester) async {
    final container = await _pump(tester);

    await tester.tap(find.text('Music'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Music'));
    await tester.pumpAndSettle();

    expect(container.read(composerProvider).topics, isEmpty);
  });

  testWidgets('stops at three, without taking a tap to say so', (tester) async {
    final container = await _pump(tester);

    for (final name in ['Music', 'Software', 'Art', 'Food']) {
      await tester.tap(find.text(name), warnIfMissed: false);
      await tester.pumpAndSettle();
    }

    expect(container.read(composerProvider).topics, ['music', 'code', 'art']);
    expect(find.text('Filed under 3 of 3'), findsOneWidget);
  });

  testWidgets('carries no topics until one is chosen', (tester) async {
    final container = await _pump(tester);
    expect(container.read(composerProvider).topics, isEmpty);
  });
}
