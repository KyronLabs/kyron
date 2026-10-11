import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/providers/service_status_provider.dart';
import 'package:kyron_app/screens/about_subscreens.dart';

/// The status screen, as a status page: one line on whether everything
/// works, a bar a day per component, and what went wrong.
class _Status extends ServiceStatusNotifier {
  _Status(super.ref);

  @override
  Future<void> check() async {
    state = const AsyncData(
      ServiceStatus(
        status: 'ok',
        database: 'reachable',
        mirrorTables: 'present',
        auth: {'supabase': 'configured'},
        latency: Duration(milliseconds: 120),
      ),
    );
  }
}

String _day(int daysAgo) {
  final now = DateTime.now().toUtc();
  return DateTime.utc(now.year, now.month, now.day)
      .subtract(Duration(days: daysAgo))
      .toIso8601String()
      .substring(0, 10);
}

ServiceHistory _history({List<StatusIncident> incidents = const []}) =>
    ServiceHistory(
      days: 60,
      intervalMinutes: 5,
      components: [
        StatusComponent(
          id: 'api',
          uptime: 100,
          days: {_day(0): const StatusDay(checks: 288, failures: 0)},
        ),
        StatusComponent(
          id: 'database',
          uptime: 99.5,
          days: {
            _day(1): const StatusDay(checks: 288, failures: 3),
            _day(0): const StatusDay(checks: 100, failures: 0),
          },
        ),
        const StatusComponent(id: 'auth', uptime: null, days: {}),
      ],
      incidents: incidents,
    );

Future<void> _open(WidgetTester tester, ServiceHistory? history) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        serviceStatusProvider.overrideWith((ref) => _Status(ref)),
        serviceHistoryProvider.overrideWith((ref) async => history),
      ],
      child: const MaterialApp(home: ServiceStatusScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

/// The bars, by their tooltips: "Oct 11 · 100%". The app bar's buttons have
/// tooltips too.
final _dayBars = find.byWidgetPredicate(
  (w) => w is Tooltip && (w.message ?? '').contains(' · '),
);

void main() {
  testWidgets('says everything is working, then shows the history',
      (tester) async {
    await _open(tester, _history());

    expect(find.text('All systems operational'), findsOneWidget);
    expect(find.text('Uptime'), findsOneWidget);
    for (final name in ['API', 'Database', 'Sign-in']) {
      expect(find.text(name), findsWidgets);
    }
    expect(find.text('100%'), findsOneWidget);
    expect(find.text('99.5%'), findsOneWidget);
    // A component never checked has no uptime to claim.
    expect(find.text('—'), findsOneWidget);
  });

  testWidgets('draws a bar for each of the sixty days, every component',
      (tester) async {
    await _open(tester, _history());

    expect(_dayBars, findsNWidgets(3 * 60));
    // Yesterday's database checks: 285 of 288 passed.
    expect(
      find.byWidgetPredicate(
        (w) => w is Tooltip && (w.message ?? '').endsWith('98.96%'),
      ),
      findsOneWidget,
    );
    // A day with no checks says so, rather than passing for up.
    expect(
      find.byWidgetPredicate(
        (w) => w is Tooltip && (w.message ?? '').endsWith('No data'),
      ),
      findsWidgets,
    );
  });

  testWidgets('lists incidents, and marks the one still going on',
      (tester) async {
    await _open(
      tester,
      _history(
        incidents: [
          StatusIncident(
            component: 'auth',
            startedAt: DateTime(2026, 10, 11, 10, 5),
            detail: 'Supabase Auth answered 503.',
          ),
          StatusIncident(
            component: 'database',
            startedAt: DateTime(2026, 10, 10, 9),
            endedAt: DateTime(2026, 10, 10, 9, 15),
          ),
        ],
      ),
    );
    await tester.scrollUntilVisible(find.text('Ongoing'), 200);

    expect(find.text('Recent incidents'), findsOneWidget);
    expect(find.text('Ongoing'), findsOneWidget);
    expect(find.text('Supabase Auth answered 503.'), findsOneWidget);
  });

  testWidgets('an open incident is not "all systems operational"',
      (tester) async {
    // /health answers from inside the API, and cannot see sign-in failing
    // at Supabase. The history can.
    await _open(
      tester,
      _history(
        incidents: [
          StatusIncident(
            component: 'auth',
            startedAt: DateTime(2026, 10, 11, 10, 5),
          ),
        ],
      ),
    );

    expect(find.text('All systems operational'), findsNothing);
    expect(find.text('Some systems are having problems'), findsOneWidget);
  });

  testWidgets('says plainly when there is no history to show', (tester) async {
    await _open(tester, null);

    expect(find.text('Uptime history is not available yet.'), findsOneWidget);
    expect(_dayBars, findsNothing);
    // The details are still there.
    expect(find.text('reachable'), findsOneWidget);
  });
}
