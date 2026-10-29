import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/conversation.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/message_link_card.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/providers/keys_provider.dart';
import 'package:kyron_app/providers/messages_provider.dart';
import 'package:kyron_app/providers/people_search_provider.dart';
import 'package:kyron_app/repositories/keys_repository.dart';
import 'package:kyron_app/repositories/messages_repository.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/app_browser.dart';
import 'package:kyron_app/services/kyron_links.dart';
import 'package:kyron_app/services/message_vault.dart';
import 'package:kyron_app/widgets/share_into_kyron_sheet.dart';
import 'package:kyron_app/widgets/share_post_sheet.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// Sending a post to somebody on Kyron. Every way to share a post led out
/// of the app; there was no way to send one to a person in it.
final _post = FeedPost(
  id: 'p1',
  content:
      'Never let the struggles of today make you forget how far you have come.',
  createdAt: DateTime(2026, 10, 21),
  author: const FeedAuthor(id: 'u9', name: 'Kobby', username: 'kobby'),
);

class _Repo extends MessagesRepository {
  _Repo() : super(ApiClient()..dio.interceptors.clear());

  final List<(String, String, String?)> sent = [];

  @override
  Future<ConversationPage> conversations({
    String? cursor,
    int limit = 30,
    ConversationFilter filter = ConversationFilter.all,
  }) async =>
      ConversationPage(
        items: [
          Conversation(
            id: 'c1',
            people: const [MessagePerson(id: 'u1', name: 'Ada')],
            lastMessageAt: DateTime(2026),
          ),
        ],
      );

  @override
  Future<int> unreadCount() async => 0;

  @override
  Future<DirectMessage> send(
    String id,
    String body, {
    List<PendingMedia> media = const [],
    String? replyToId,
    String? linkCard,
    OnceUpload? once,
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

Future<(_Repo, List<RouteSettings>)> _pump(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1170, 2532);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  final repo = _Repo();
  final routes = <RouteSettings>[];
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        messagesRepositoryProvider.overrideWithValue(repo),
        messageVaultProvider.overrideWithValue(
          MessageVault(KeysRepository(ApiClient())),
        ),
        peopleSearchProvider.overrideWith((ref, q) async => const []),
      ],
      child: MaterialApp(
        theme: KyronTheme.lightTheme,
        onGenerateRoute: (settings) {
          routes.add(settings);
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (context) => settings.name == '/'
                ? Scaffold(
                    body: Center(
                      child: Builder(
                        builder: (context) => TextButton(
                          onPressed: () => SharePostSheet.show(context, _post),
                          child: const Text('share'),
                        ),
                      ),
                    ),
                  )
                : Text('route ${settings.name}'),
          );
        },
      ),
    ),
  );
  await tester.tap(find.text('share'));
  await tester.pumpAndSettle();
  return (repo, routes);
}

void main() {
  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  group("Kyron's own links", () {
    test('are read as the screen they name', () {
      final post = KyronLinks.parse(Uri.parse(KyronLinks.post('p1')));
      expect(post?.kind, KyronLinkKind.post);
      expect(post?.value, 'p1');
      expect(
        KyronLinks.parse(Uri.parse('https://kyron.so/@ada'))?.kind,
        KyronLinkKind.profile,
      );
      expect(
        KyronLinks.parse(Uri.parse('https://www.kyron.so/c/runners'))?.value,
        'runners',
      );
    });

    test("nobody else's are", () {
      expect(
          KyronLinks.parse(Uri.parse('https://example.com/post/p1')), isNull);
      expect(KyronLinks.parse(Uri.parse('https://kyron.so/about')), isNull);
    });

    testWidgets('open in the app, not in its browser', (tester) async {
      final routes = <RouteSettings>[];
      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            routes.add(settings);
            return MaterialPageRoute<void>(
              settings: settings,
              builder: (context) => Builder(
                builder: (context) => TextButton(
                  onPressed: () =>
                      AppBrowser.open(context, KyronLinks.post('p1')),
                  child: const Text('tap'),
                ),
              ),
            );
          },
        ),
      );
      await tester.tap(find.text('tap'));
      await tester.pumpAndSettle();
      expect(routes.last.name, Routes.postDetail);
      expect(routes.last.arguments, 'p1');
    });
  });

  testWidgets('the share sheet offers people on Kyron first', (tester) async {
    await _pump(tester);
    final send = tester.getTopLeft(
      find.byKey(const ValueKey('share-send-in-message')),
    );
    final out = tester.getTopLeft(find.textContaining('Share via'));
    expect(send.dy, lessThan(out.dy));
  });

  testWidgets('sends the post, with its card, to whoever is ticked', (
    tester,
  ) async {
    final (repo, _) = await _pump(tester);
    await tester.tap(find.byKey(const ValueKey('share-send-in-message')));
    await tester.pumpAndSettle();

    // What is being sent is on screen: whose, and how it starts.
    expect(find.byKey(const ValueKey('share-shared-post')), findsOneWidget);
    expect(find.text('Kobby'), findsOneWidget);

    await tester.tap(find.text('Ada'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('share-send')));
    await tester.pumpAndSettle();

    expect(repo.sent.single.$1, 'c1');
    expect(repo.sent.single.$2, KyronLinks.post('p1'));
    final card = MessageLinkCard.tryDecode(
      repo.sent.single.$3!,
      body: repo.sent.single.$2,
    );
    expect(card?.title, 'Kobby');
    expect(card?.description, startsWith('Never let the struggles'));
    await tester.pump(const Duration(seconds: 10));
  });

  testWidgets('or quotes it in a post of your own', (tester) async {
    final (_, routes) = await _pump(tester);
    await tester.tap(find.byKey(const ValueKey('share-send-in-message')));
    await tester.pumpAndSettle();

    expect(find.text('Quote'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('share-post')));
    await tester.pumpAndSettle();
    expect(routes.last.name, Routes.composer);
    expect(routes.last.arguments, same(_post));
  });
}
