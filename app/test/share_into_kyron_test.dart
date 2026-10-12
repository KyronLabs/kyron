import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/conversation.dart';
import 'package:kyron_app/models/message_link_card.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/models/profile_summary.dart';
import 'package:kyron_app/providers/keys_provider.dart';
import 'package:kyron_app/providers/messages_provider.dart';
import 'package:kyron_app/repositories/keys_repository.dart';
import 'package:kyron_app/repositories/messages_repository.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/link_card_reader.dart';
import 'package:kyron_app/services/message_vault.dart';
import 'package:kyron_app/services/share_inbox.dart';
import 'package:kyron_app/widgets/share_into_kyron_sheet.dart';
import 'package:kyron_app/providers/people_search_provider.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:kyron_app/providers/api_client_provider.dart';
import 'package:kyron_app/providers/composer_provider.dart';
import 'package:kyron_app/screens/composer_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/fake_drafts.dart';

/// Sharing into Kyron from another app's share sheet: to a new post, or to
/// one or more people at once.
class _Repo extends MessagesRepository {
  _Repo() : super(ApiClient()..dio.interceptors.clear());

  final List<(String, String, String?)> sent = [];
  final List<String> opened = [];

  @override
  Future<ConversationPage> conversations({
    String? cursor,
    int limit = 30,
    ConversationFilter filter = ConversationFilter.all,
  }) async =>
      ConversationPage(
        items: [
          for (final (id, name) in [('c1', 'Ada'), ('c2', 'Bo'), ('c3', 'Cy')])
            Conversation(
              id: id,
              people: [MessagePerson(id: 'u-$id', name: name)],
              lastMessageAt: DateTime(2026),
            ),
        ],
      );

  @override
  Future<int> unreadCount() async => 0;

  @override
  Future<String> openWith(String userId) async {
    opened.add(userId);
    return 'new-$userId';
  }

  @override
  Future<DirectMessage> send(
    String id,
    String body, {
    List<PendingMedia> media = const [],
    String? replyToId,
    String? linkCard,
  }) async {
    sent.add((id, body, linkCard));
    return DirectMessage(
      id: 'm${sent.length}',
      body: body,
      senderId: 'me',
      createdAt: DateTime(2026),
    );
  }
}

class _Reader extends LinkCardReader {
  @override
  Future<MessageLinkCard?> read(String url) async =>
      MessageLinkCard(url: url, title: 'A post', siteName: 'Example');
}

Future<_Repo> _pump(
  WidgetTester tester,
  SharedContent content, {
  List<ProfileSummary> found = const [],
  List<String>? routes,
}) async {
  tester.view.physicalSize = const Size(1170, 2532);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  final repo = _Repo();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        messagesRepositoryProvider.overrideWithValue(repo),
        messageVaultProvider.overrideWithValue(
          MessageVault(KeysRepository(ApiClient())),
        ),
        linkCardReaderProvider.overrideWithValue(_Reader()),
        peopleSearchProvider.overrideWith((ref, q) async => found),
      ],
      child: MaterialApp(
        theme: KyronTheme.lightTheme,
        onGenerateRoute: (settings) {
          routes?.add(settings.name ?? '');
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (context) => settings.name == Routes.composer
                ? Text(
                    'composer: ${(settings.arguments as SharedContent).text}')
                : Scaffold(
                    body: Center(
                      child: Builder(
                        builder: (context) => TextButton(
                          onPressed: () =>
                              ShareIntoKyronSheet.show(context, content),
                          child: const Text('open'),
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return repo;
}

void main() {
  // The vault reads this device's key from secure storage; an empty store is
  // a phone with no key yet, and without one the read waits on a platform
  // channel no test has.
  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  group('what another app hands over', () {
    test('is read from the channel, and nothing malformed is trusted', () {
      final content = SharedContent.fromChannel({
        'text': '  https://example.com/a  ',
        'files': ['/cache/shared/1.jpg', 3, null],
      });
      expect(content?.text, 'https://example.com/a');
      expect(content?.files, ['/cache/shared/1.jpg']);

      expect(SharedContent.fromChannel(null), isNull);
      expect(SharedContent.fromChannel('text'), isNull);
      expect(SharedContent.fromChannel({'text': '  ', 'files': []}), isNull);
    });
  });

  testWidgets('a share opens the composer with its words in the box', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          draftServiceProvider.overrideWithValue(FakeDrafts()),
          apiClientProvider.overrideWithValue(
            ApiClient()..dio.interceptors.clear(),
          ),
        ],
        child: MaterialApp(
          theme: KyronTheme.lightTheme,
          home: const ComposerScreen(
            shared: SharedContent(text: 'worth a read, from another app'),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));

    final box = tester.widget<TextField>(find.byType(TextField).first);
    expect(box.controller?.text, 'worth a read, from another app');
  });

  group('the share sheet', () {
    const shared = SharedContent(text: 'look https://example.com/a');

    testWidgets('offers a post first, then the people talked to', (
      tester,
    ) async {
      await _pump(tester, shared);

      final post = tester.getTopLeft(find.byKey(const ValueKey('share-post')));
      final ada = tester.getTopLeft(find.byKey(const ValueKey('share-c:c1')));
      expect(post.dx, lessThan(ada.dx));
      expect(find.text('Bo'), findsOneWidget);
      expect(find.text('look https://example.com/a'), findsOneWidget);
      // Nothing to send to yet, so nothing to send.
      expect(find.byKey(const ValueKey('share-send')), findsNothing);
    });

    testWidgets('sends to everybody ticked, with the line written beside it', (
      tester,
    ) async {
      final repo = await _pump(tester, shared);

      await tester.tap(find.text('Ada'));
      await tester.tap(find.text('Cy'));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('share-tick')), findsNWidgets(2));

      await tester.enterText(
        find.byKey(const ValueKey('share-note')),
        'thought of you',
      );
      await tester.tap(find.byKey(const ValueKey('share-send')));
      await tester.pumpAndSettle();

      expect(repo.sent.map((s) => (s.$1, s.$2)), [
        ('c1', 'look https://example.com/a'),
        ('c1', 'thought of you'),
        ('c3', 'look https://example.com/a'),
        ('c3', 'thought of you'),
      ]);
      // The shared link carries its card; the line beside it has none.
      final card = MessageLinkCard.tryDecode(
        repo.sent.first.$3!,
        body: repo.sent.first.$2,
      );
      expect(card?.title, 'A post');
      expect(repo.sent[1].$3, isNull);
      // And the sheet is gone, saying so.
      expect(find.byType(ShareIntoKyronSheet), findsNothing);
      expect(find.text('Sent'), findsOneWidget);
      await tester.pump(const Duration(seconds: 10));
    });

    testWidgets('a person found by searching is written to', (tester) async {
      final repo = await _pump(
        tester,
        shared,
        found: const [
          ProfileSummary(id: 'u9', name: 'Dee', username: 'dee'),
          // Already talked to: shown once, as the conversation.
          ProfileSummary(id: 'u-c1', name: 'Ada', username: 'ada'),
        ],
      );

      await tester.enterText(find.byKey(const ValueKey('share-search')), 'de');
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pumpAndSettle();
      expect(find.text('Ada'), findsNothing);

      await tester.tap(find.text('Dee'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('share-send')));
      await tester.pumpAndSettle();

      expect(repo.opened, ['u9']);
      expect(repo.sent.single.$1, 'new-u9');
      await tester.pump(const Duration(seconds: 10));
    });

    testWidgets('Post hands the share to the composer', (tester) async {
      final routes = <String>[];
      final repo = await _pump(tester, shared, routes: routes);

      await tester.tap(find.byKey(const ValueKey('share-post')));
      await tester.pumpAndSettle();

      expect(routes.last, Routes.composer);
      expect(find.text('composer: look https://example.com/a'), findsOneWidget);
      expect(repo.sent, isEmpty);
    });
  });
}
