import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/profile_summary.dart';
import 'package:kyron_app/providers/moderation_provider.dart';
import 'package:kyron_app/repositories/moderation_repository.dart';
import 'package:kyron_app/screens/muted_screens.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

class _Moderation extends ModerationRepository {
  _Moderation({List<String>? words, this.failRemove = false})
      : words = words ?? [],
        super(ApiClient());

  final List<String> words;
  final bool failRemove;
  final unmutedPeople = <String>[];

  @override
  Future<List<String>> mutedWords() async => List.of(words);

  @override
  Future<void> muteWord(String phrase) async => words.add(phrase);

  @override
  Future<void> unmuteWord(String phrase) async {
    if (failRemove) throw Exception('offline');
    words.remove(phrase);
  }

  @override
  Future<List<ProfileSummary>> mutedUsers() async => const [];

  @override
  Future<List<ProfileSummary>> blockedUsers() async => const [];
}

Future<void> _pump(WidgetTester tester, Widget screen, _Moderation repo) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [moderationRepositoryProvider.overrideWithValue(repo)],
      // The app's own theme: the field vanished under it and nowhere else.
      child: MaterialApp(theme: KyronTheme.lightTheme, home: screen),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('the field to add a muted word is there to type in', (
    tester,
  ) async {
    // The theme gives every FilledButton a minimum size of
    // Size.fromHeight(44) -- infinitely wide. Beside a field in a Row that
    // cannot be laid out, and the field and its button drew as nothing,
    // under an empty state saying "Add a word or a tag above".
    await _pump(tester, const MutedWordsScreen(), _Moderation());

    expect(tester.takeException(), isNull);
    final field = find.byType(TextField);
    expect(field, findsOneWidget);
    expect(tester.getSize(field).width, greaterThan(100));
    expect(find.text('Mute'), findsOneWidget);
  });

  testWidgets('a word typed and muted joins the list', (tester) async {
    final repo = _Moderation();
    await _pump(tester, const MutedWordsScreen(), repo);

    await tester.enterText(find.byType(TextField), 'spoiler');
    await tester.pump();
    await tester.tap(find.text('Mute'));
    await tester.pumpAndSettle();

    expect(repo.words, ['spoiler']);
    expect(find.text('spoiler'), findsOneWidget);
    expect(find.text('Nothing muted'), findsNothing);
  });

  testWidgets('a word that cannot be unmuted stays, and says why', (
    tester,
  ) async {
    final repo = _Moderation(words: ['spoiler'], failRemove: true);
    await _pump(tester, const MutedWordsScreen(), repo);

    await tester.tap(find.byTooltip('Unmute'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('spoiler'), findsOneWidget);
  });

  testWidgets('muted and blocked lay out under the app theme', (tester) async {
    await _pump(tester, const MutedAccountsScreen(), _Moderation());

    expect(tester.takeException(), isNull);
    expect(find.text('Muted'), findsOneWidget);
    expect(find.text('Blocked'), findsOneWidget);
    expect(find.text('Nobody muted'), findsOneWidget);
  });
}
