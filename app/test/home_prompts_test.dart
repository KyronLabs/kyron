import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/providers/feedback_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:kyron_app/repositories/feedback_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/home_prompts.dart';
import 'package:kyron_app/widgets/check_in_sheet.dart';
import 'package:kyron_app/widgets/whats_new_sheet.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

WhatsNewVersion _v(String version, [String title = 'A thing']) =>
    WhatsNewVersion(
      version: version,
      items: [(title: title, detail: 'It does more.')],
    );

final _notes = [_v('0.1.44'), _v('0.1.43'), _v('0.1.42'), _v('0.1.9')];
final _day0 = DateTime(2026, 11, 9, 12);

Future<SharedPreferences> _prefs([Map<String, Object> values = const {}]) {
  SharedPreferences.setMockInitialValues(values);
  return SharedPreferences.getInstance();
}

Future<HomePrompt?> _decide(
  SharedPreferences prefs, {
  String version = '0.1.42',
  int day = 0,
}) =>
    HomePrompts.decide(
      prefs: prefs,
      version: version,
      now: _day0.add(Duration(days: day, hours: 1)),
      notes: _notes,
    );

class _Feedback extends FeedbackRepository {
  _Feedback() : super(ApiClient());
  final sent = <({String title, String body})>[];

  @override
  Future<FiledReport> send({
    required FeedbackKind kind,
    required String title,
    required String body,
    String? appVersion,
    String? platform,
    String? log,
  }) async {
    sent.add((title: title, body: body));
    return const FiledReport(number: 1);
  }
}

void main() {
  group('deciding', () {
    test('the first launch shows nothing, and starts counting', () async {
      final prefs = await _prefs();
      expect(await _decide(prefs), isNull);
      expect(prefs.getString(HomePrompts.seenVersionKey), '0.1.42');
      expect(prefs.getInt(HomePrompts.firstOpenKey), isNotNull);
    });

    test('an update shows what changed since, newest first, once', () async {
      final prefs = await _prefs();
      await _decide(prefs);
      final prompt = await _decide(prefs, version: '0.1.44', day: 1);
      expect(prompt, isA<WhatsNewPrompt>());
      expect(
        (prompt! as WhatsNewPrompt).versions.map((v) => v.version),
        ['0.1.44', '0.1.43'],
      );
      expect(await _decide(prefs, version: '0.1.44', day: 1), isNull);
    });

    test('versions compare by number: 0.1.9 is older than 0.1.42', () async {
      final prefs = await _prefs();
      await _decide(prefs, version: '0.1.9');
      final prompt = await _decide(prefs, version: '0.1.42', day: 1);
      expect(
        (prompt! as WhatsNewPrompt).versions.map((v) => v.version),
        ['0.1.42'],
      );
    });

    test('a check-in on day 3 and on day 10, each once', () async {
      final prefs = await _prefs();
      await _decide(prefs);
      expect(await _decide(prefs, day: 2), isNull);
      expect((await _decide(prefs, day: 3) as CheckInPrompt?)?.day, 3);
      expect(await _decide(prefs, day: 4), isNull);
      expect((await _decide(prefs, day: 10) as CheckInPrompt?)?.day, 10);
      expect(await _decide(prefs, day: 12), isNull);
    });

    test('away past both days, asked once, not twice in a row', () async {
      final prefs = await _prefs();
      await _decide(prefs);
      expect((await _decide(prefs, day: 11) as CheckInPrompt?)?.day, 10);
      expect(await _decide(prefs, day: 11), isNull);
    });

    test('never both on one launch: an update waits the check-in', () async {
      final prefs = await _prefs();
      await _decide(prefs);
      expect(
        await _decide(prefs, version: '0.1.43', day: 3),
        isA<WhatsNewPrompt>(),
      );
      expect(
        await _decide(prefs, version: '0.1.43', day: 3),
        isA<CheckInPrompt>(),
      );
    });

    test('reads the notes the build carries', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      final notes = await HomePrompts.bundledNotes();
      expect(notes, isNotEmpty);
      expect(notes.first.items, isNotEmpty);
      expect(notes.first.items.first.title, isNotEmpty);
    });
  });

  group('the sheets', () {
    setUp(
      () => PackageInfo.setMockInitialValues(
        appName: 'Kyron',
        packageName: 'so.kyron',
        version: '0.1.42',
        buildNumber: '1',
        buildSignature: '',
      ),
    );

    Future<void> open(
      WidgetTester tester,
      Future<void> Function(BuildContext) show, {
      _Feedback? feedback,
    }) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            feedbackRepositoryProvider.overrideWithValue(
              feedback ?? _Feedback(),
            ),
          ],
          child: MaterialApp(
            theme: KyronTheme.lightTheme,
            home: Builder(
              builder: (context) => Scaffold(
                body: TextButton(
                  onPressed: () => show(context),
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
    }

    testWidgets('What\'s new lists each headline, and Got it closes it', (
      tester,
    ) async {
      await open(
        tester,
        (c) => WhatsNewSheet.show(c, [_v('0.1.44', 'Gifts in a pill')]),
      );
      expect(find.text('Kyron 0.1.44'), findsOneWidget);
      expect(find.text('Gifts in a pill'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('whats-new-done')));
      await tester.pumpAndSettle();
      expect(find.text('Gifts in a pill'), findsNothing);
    });

    testWidgets('a check-in sends nothing until a face is picked', (
      tester,
    ) async {
      final feedback = _Feedback();
      await open(
        tester,
        (c) => CheckInSheet.show(c, day: 3),
        feedback: feedback,
      );
      expect(
          find.text('Day 3 of your test. One tap is enough.'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('check-in-send')));
      await tester.pump();
      expect(feedback.sent, isEmpty);

      await tester.tap(find.byKey(const ValueKey('check-in-face-4')));
      await tester.enterText(
        find.byKey(const ValueKey('check-in-words')),
        'Loving the gifts',
      );
      await tester.tap(find.byKey(const ValueKey('check-in-send')));
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }
      expect(feedback.sent.single.title, 'Day 3 check-in: 4/5');
      expect(feedback.sent.single.body, contains('Loving the gifts'));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(find.text('Day 3 of your test. One tap is enough.'), findsNothing);
    });
  });

  test('a face alone still files something worth reading', () {
    final filed = CheckInSheet.report(day: 10, rating: 5, words: '  ');
    expect(filed.title, 'Day 10 check-in: 5/5');
    // The API asks for ten characters at least.
    expect(filed.body.length, greaterThanOrEqualTo(10));
  });

  test('the asset is listed in the build', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    expect(
      await rootBundle.loadString(HomePrompts.notesAsset),
      contains('"version"'),
    );
  });
}
