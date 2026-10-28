import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/insights_report.dart';
import 'package:kyron_app/providers/insights_provider.dart';
import 'package:kyron_app/repositories/insights_repository.dart';
import 'package:kyron_app/screens/insights_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// What the server sends, shaped the way it sends it.
Map<String, dynamic> _json({
  int days = 30,
  bool enough = true,
  List<Map<String, dynamic>> tips = const [],
}) {
  final hours = List<int>.filled(168, 0);
  hours[36] = 12; // Tuesday 12:00 UTC
  return {
    'days': days,
    'reach': {'current': 23311, 'previous': 2520},
    'followersReached': 11,
    'opens': {'current': 400, 'previous': 0},
    'likes': {'current': 90, 'previous': 100},
    'comments': {'current': 12, 'previous': 12},
    'reposts': {'current': 0, 'previous': 0},
    'saves': {'current': 3, 'previous': 1},
    'newFollowers': {'current': 10, 'previous': 1},
    'followers': 11,
    'timeline': [
      for (var i = 0; i < days; i++)
        {
          'date': DateTime.utc(2026, 9, 29)
              .add(Duration(days: i))
              .toIso8601String()
              .substring(0, 10),
          'reach': i == 2 ? 11000 : i * 10,
        },
    ],
    'audience': {
      'enough': enough,
      'ages': enough
          ? [
              {'band': '18-24', 'count': 60},
              {'band': '25-34', 'count': 40},
            ]
          : [],
      'agesKnown': enough ? 100 : 0,
      'interests': enough
          ? [
              {'slug': 'books', 'name': 'Books', 'count': 915},
            ]
          : [],
      'communities': enough
          ? [
              {'slug': 'cats', 'name': 'Cats of Kyron', 'count': 316},
            ]
          : [],
      'activeHours': hours,
    },
    'topPosts': [
      {
        'id': 'p1',
        'excerpt': 'The post that went round',
        'createdAt': '2026-09-30T10:00:00Z',
        'reach': 20000,
        'likes': 80,
        'comments': 9,
        'reposts': 0,
      },
    ],
    'summary': [
      {
        'code': 'reach_up_times',
        'params': {'times': 9, 'reach': 23311},
      },
      {
        'code': 'mostly_strangers',
        'params': {'pct': 99},
      },
    ],
    'tips': tips,
  };
}

class _Insights extends InsightsRepository {
  _Insights(this.json) : super(ApiClient());

  final Map<String, dynamic> Function(int days) json;
  final asked = <int>[];

  @override
  Future<InsightsReport> report({required int days}) async {
    asked.add(days);
    return InsightsReport.fromJson(json(days));
  }
}

Future<_Insights> _pump(
  WidgetTester tester,
  Map<String, dynamic> Function(int days) json,
) async {
  final repo = _Insights(json);
  await tester.binding.setSurfaceSize(const Size(420, 1600));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    ProviderScope(
      overrides: [insightsRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(
        theme: KyronTheme.lightTheme,
        onGenerateRoute: (settings) => MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => Text('route ${settings.name} ${settings.arguments}'),
        ),
        home: const InsightsScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

void main() {
  testWidgets('says how the period went, in words and numbers', (
    tester,
  ) async {
    final repo = await _pump(tester, (days) => _json(days: days));

    expect(repo.asked, [30]);
    expect(
      find.text(
        'You reached 23.3K people, 9× as many as the period before. '
        '99% of them do not follow you yet: your posts are being found.',
      ),
      findsOneWidget,
    );
    expect(find.text('People reached'), findsOneWidget);
    // +825% against the period before, as Threads shows it.
    expect(find.text('+825%'), findsOneWidget);
    // Nothing before is "New", not a percentage over zero.
    expect(find.text('New'), findsOneWidget);
    expect(find.text('The post that went round'), findsOneWidget);
  });

  testWidgets('a tip says what to do and takes you there', (tester) async {
    await _pump(
      tester,
      (days) => _json(
        tips: [
          {
            'code': 'answer_comments',
            'params': {'received': 12, 'answered': 2},
          },
          {'code': 'add_bio', 'params': <String, Object>{}},
        ],
      ),
    );

    expect(find.text('How to grow'), findsOneWidget);
    expect(
      find.textContaining('12 people replied to your posts and you answered 2'),
      findsOneWidget,
    );
    await tester.tap(find.text('Edit your profile'));
    await tester.pumpAndSettle();
    expect(find.text('route /profile/edit null'), findsOneWidget);
  });

  testWidgets('changing the period asks again', (tester) async {
    final repo = await _pump(tester, (days) => _json(days: days));

    await tester.tap(find.byKey(const ValueKey('insights-period')).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Last 7 days').last);
    await tester.pumpAndSettle();

    expect(repo.asked, [30, 7]);
  });

  testWidgets('the audience: who they are, and when', (tester) async {
    await _pump(tester, (days) => _json());

    await tester.tap(find.text('Audience'));
    await tester.pumpAndSettle();

    expect(find.text('Not following you'), findsOneWidget);
    expect(find.text('18-24'), findsOneWidget);
    expect(find.text('60%'), findsOneWidget);
    expect(find.text('Books · 915'), findsOneWidget);
    expect(find.text('Cats of Kyron · 316'), findsOneWidget);
    expect(find.text('When they are around'), findsOneWidget);
    expect(find.textContaining('does not collect'), findsOneWidget);
  });

  testWidgets('a small audience is not described at all', (tester) async {
    await _pump(tester, (days) => _json(enough: false));

    await tester.tap(find.text('Audience'));
    await tester.pumpAndSettle();

    expect(find.text('Not enough people yet'), findsOneWidget);
    expect(find.text('Ages'), findsNothing);
    expect(find.text('When they are around'), findsNothing);
  });

  test('busiest slots are summed into three-hour blocks', () {
    final hours = List<int>.filled(168, 0);
    hours[0] = 2;
    hours[1] = 3;
    hours[100] = 4;
    final slots = busiestSlots(hours);
    expect(slots.first.count, greaterThanOrEqualTo(4));
    expect(slots.fold<int>(0, (n, s) => n + s.count), 9);
  });
}
