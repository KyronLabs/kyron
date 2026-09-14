import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_app/models/explore_entry.dart';
import 'package:kyron_app/providers/explore_provider.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/interest_tabs.dart';

/// Stands in for the network being down.
class _Down implements Exception {}

class _FakeFeed extends FeedRepository {
  _FakeFeed({this.tags = const [], this.fails = false}) : super(ApiClient());

  final List<TrendingTag> tags;
  final bool fails;

  @override
  Future<List<TrendingTag>> trendingTags({int limit = 25}) async {
    if (fails) throw _Down();
    return tags;
  }
}

/// A primary nobody would pick by hand, so that anything drawing the accent
/// from the theme is obvious and anything writing its own is too.
const _loudPrimary = Color(0xFFFF00FF);

ThemeData _theme() => ThemeData(
      colorScheme: const ColorScheme.light(
        primary: _loudPrimary,
        primaryContainer: Color(0xFFEFEFEF),
        onPrimaryContainer: Color(0xFF111111),
      ),
    );

Future<void> _pump(
  WidgetTester tester, {
  List<TrendingTag> tags = const [],
  bool fails = false,
  List<String>? tabs,
}) async {
  final repo = _FakeFeed(tags: tags, fails: fails);

  tester.view.physicalSize = const Size(1080, 2340);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        trendingProvider.overrideWith((ref) => TrendingNotifier(repo)),
        if (tabs != null)
          interestTabsProvider.overrideWith((ref) {
            final notifier = InterestTabsNotifier();
            notifier.state = tabs;
            return notifier;
          }),
      ],
      child: MaterialApp(
        theme: _theme(),
        home: const Scaffold(body: InterestTabs()),
      ),
    ),
  );
  await tester.pump();
}

Future<void> _openPicker(WidgetTester tester) async {
  await tester.tap(find.byIcon(Iconsax.add));
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('the interest picker', () {
    testWidgets('offers what is trending, not a list written into the file',
        (tester) async {
      await _pump(tester, tags: const [
        TrendingTag(tag: 'Lagos', posts: 90, recent: 12),
        TrendingTag(tag: 'Harmattan', posts: 40, recent: 8),
      ]);
      await _openPicker(tester);

      expect(find.text('#Lagos'), findsOneWidget);
      expect(find.text('#Harmattan'), findsOneWidget);

      // The twelve hashtags this file used to carry. None of them had to
      // exist, so adding one could hand the reader an empty tab.
      for (final invented in const [
        '#SnowLeopard',
        '#ClimateLens',
        '#MemeEconomy',
        '#HotTakes',
      ]) {
        expect(find.text(invented), findsNothing, reason: '$invented is back');
      }
    });

    testWidgets('says so when the read fails, and offers a retry',
        (tester) async {
      await _pump(tester, fails: true);
      await _openPicker(tester);

      expect(find.text('Could not load trending tags'), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);
    });

    testWidgets('an empty network reads as nothing trending', (tester) async {
      await _pump(tester);
      await _openPicker(tester);

      expect(find.text('Nothing is trending yet'), findsOneWidget);
    });

    testWidgets('adding one makes a tab that reads that hashtag',
        (tester) async {
      await _pump(tester, tags: const [TrendingTag(tag: 'Lagos')]);
      await _openPicker(tester);

      await tester.tap(find.text('#Lagos'));
      await tester.pumpAndSettle();

      // It moves out of the offered list and into Your tabs.
      expect(find.text('#Lagos'), findsOneWidget);

      final source = feedSourceForTab('#Lagos');
      expect(source, PostListSource.hashtag('Lagos'));
    });

    testWidgets('the fifth tab is the last, and it says why', (tester) async {
      await _pump(
        tester,
        tags: const [TrendingTag(tag: 'Lagos'), TrendingTag(tag: 'Kano')],
        tabs: const ['For You', 'Following', 'Videos', '#Abuja'],
      );
      await _openPicker(tester);

      expect(find.textContaining('most the strip holds'), findsNothing);

      await tester.tap(find.text('#Lagos'));
      await tester.pumpAndSettle();

      expect(find.textContaining('most the strip holds'), findsOneWidget);
    });
  });

  group('the tab strip', () {
    testWidgets('takes its accent from the theme', (tester) async {
      await _pump(tester);

      // For You is selected by default.
      final active = tester.widget<Text>(find.text('For You'));
      expect(active.style?.color, _loudPrimary,
          reason: 'the active tab is not drawing the theme accent');

      // Every colour in here used to be #4C8FFF written out by hand, which is
      // neither the documented accent nor anything the theme can change.
      final idle = tester.widget<Text>(find.text('Videos'));
      expect(idle.style?.color, isNot(const Color(0xFF4C8FFF)));
    });

    testWidgets('every target in it clears 44', (tester) async {
      await _pump(tester);

      final add = tester.getSize(find.bySemanticsLabel('Add an interest'));
      expect(add.height, greaterThanOrEqualTo(44),
          reason: 'the add button is ${add.height} high');
      expect(add.width, greaterThanOrEqualTo(44),
          reason: 'the add button is ${add.width} wide');

      // The pill is drawn shorter than the strip; the target is not.
      final pill = tester.getSize(
        find
            .ancestor(
              of: find.text('For You'),
              matching: find.byType(GestureDetector),
            )
            .first,
      );
      expect(pill.height, greaterThanOrEqualTo(44),
          reason: 'a tab is ${pill.height} high');
    });
  });
}
