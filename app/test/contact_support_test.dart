import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/providers/feedback_provider.dart';
import 'package:kyron_app/repositories/feedback_repository.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/screens/settings_subscreens.dart';
import 'package:kyron_app/services/api_client.dart';

/// Contact support said to "open an issue", and linked nowhere. Every way in
/// it offers now is one that arrives.
class _Inbox extends FeedbackRepository {
  _Inbox() : super(ApiClient());

  @override
  Future<bool> isAvailable() async => true;
}

const _launcher = MethodChannel('plugins.flutter.io/url_launcher');

/// What was handed to another app, and whether one took it.
class _Phone {
  _Phone({required this.hasMailApp});

  final bool hasMailApp;
  final opened = <String>[];
  String? clipboard;

  void install(WidgetTester tester) {
    final messenger = tester.binding.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(_launcher, (call) async {
      if (call.method != 'launch') return false;
      opened.add((call.arguments as Map)['url'] as String);
      return hasMailApp;
    });
    messenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') {
        clipboard = (call.arguments as Map)['text'] as String;
      }
      return null;
    });
    addTearDown(() {
      messenger.setMockMethodCallHandler(_launcher, null);
      messenger.setMockMethodCallHandler(SystemChannels.platform, null);
    });
  }
}

Future<void> _open(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [feedbackRepositoryProvider.overrideWithValue(_Inbox())],
      child: const MaterialApp(
        home: SettingsContactSupportScreen(),
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _tap(WidgetTester tester, String text) async {
  await tester.ensureVisible(find.text(text));
  await tester.pumpAndSettle();
  await tester.tap(find.text(text));
}

void main() {
  testWidgets('points nowhere it cannot reach', (tester) async {
    await _open(tester);

    final words = tester
        .widgetList<Text>(find.byType(Text))
        .map((t) => t.data ?? '')
        .join('\n');
    expect(words, isNot(contains('open an issue')));
    expect(words, isNot(contains('kyron.so')));
    // The two the published privacy policy names, and nothing else.
    expect(words, contains('abuse@spidroid.com'));
    expect(words, contains('privacy@spidroid.com'));
  });

  testWidgets('asking a question opens the form on a question', (
    tester,
  ) async {
    await _open(tester);

    await _tap(tester, 'Ask a question');
    await tester.pumpAndSettle();

    expect(find.byType(SettingsFeedbackScreen), findsOneWidget);
    final form = tester.widget<SettingsFeedbackScreen>(
      find.byType(SettingsFeedbackScreen),
    );
    expect(form.kind, FeedbackKind.question);
    // And it reads as one: not "what happened".
    expect(find.text('Your question'), findsOneWidget);
    expect(find.text('What happened'), findsNothing);
  });

  testWidgets('reporting a problem opens it on a problem', (tester) async {
    await _open(tester);

    await _tap(tester, 'Report a problem');
    await tester.pumpAndSettle();

    final form = tester.widget<SettingsFeedbackScreen>(
      find.byType(SettingsFeedbackScreen),
    );
    expect(form.kind, FeedbackKind.bug);
  });

  testWidgets('safety opens a mail to the abuse address', (tester) async {
    final phone = _Phone(hasMailApp: true)..install(tester);
    await _open(tester);

    await _tap(tester, 'Safety and abuse');
    await tester.pumpAndSettle();

    expect(phone.opened, ['mailto:abuse@spidroid.com']);
    expect(phone.clipboard, isNull);
  });

  testWidgets('with no mail app, the address is copied and it says so', (
    tester,
  ) async {
    // Plenty of phones have none set up. A row that does nothing reads as a
    // broken button.
    final phone = _Phone(hasMailApp: false)..install(tester);
    await _open(tester);

    await _tap(tester, 'Privacy and your data');
    await tester.pump();
    await tester.pump();

    expect(phone.opened, ['mailto:privacy@spidroid.com']);
    expect(phone.clipboard, 'privacy@spidroid.com');
    expect(
        find.textContaining('privacy@spidroid.com is copied'), findsOneWidget);
    await tester.pump(const Duration(seconds: 6));
  });
}
