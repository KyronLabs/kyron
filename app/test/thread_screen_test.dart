import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_app/models/conversation.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/providers/messages_provider.dart';
import 'package:kyron_app/repositories/keys_repository.dart';
import 'package:kyron_app/repositories/messages_repository.dart';
import 'package:kyron_app/screens/thread_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/message_vault.dart';
import 'package:kyron_app/utils/emoji_only.dart';
import 'package:kyron_app/widgets/quote_stack.dart';

/// The chat screen, driven the way somebody uses it: big emoji, pulling a
/// message across to answer it, the wave that opens an empty conversation,
/// and the heart beside an empty box.
class _Repo extends MessagesRepository {
  _Repo(this.thread) : super(ApiClient()..dio.interceptors.clear());

  /// Newest first, the way the server sends a page.
  final List<DirectMessage> thread;

  final List<String> bodies = [];
  final List<String?> repliedTo = [];

  @override
  Future<MessagePage> messages(
    String id, {
    String? cursor,
    int limit = 40,
  }) async =>
      MessagePage(
        items: thread,
        people: const [MessagePerson(id: 'them', name: 'Ada')],
      );

  @override
  Future<DirectMessage> send(
    String id,
    String body, {
    List<PendingMedia> media = const [],
    String? replyToId,
  }) async {
    bodies.add(body);
    repliedTo.add(replyToId);
    return DirectMessage(
      id: 'sent-${bodies.length}',
      body: body,
      senderId: 'me',
      createdAt: DateTime(2026, 1, 9),
      replyToId: replyToId,
    );
  }

  @override
  Future<void> markRead(String id) async {}
}

class _Me extends CurrentUserNotifier {
  _Me(super.ref);

  @override
  Future<void> load({bool force = false}) async {
    state = const AsyncData(
      CurrentUser(id: 'me', name: 'Me', followers: 0, following: 0, posts: 0),
    );
  }
}

DirectMessage _msg(
  String id,
  String body,
  String sender,
  DateTime at, {
  String? replyToId,
}) =>
    DirectMessage(
      id: id,
      body: body,
      senderId: sender,
      createdAt: at,
      replyToId: replyToId,
    );

Future<_Repo> _open(WidgetTester tester, List<DirectMessage> thread) async {
  final repo = _Repo(thread);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentUserProvider.overrideWith((ref) => _Me(ref)),
        threadProvider.overrideWith(
          (ref, id) => ThreadNotifier(
            repo,
            MessageVault(KeysRepository(ApiClient())),
            id,
          ),
        ),
      ],
      child: const MaterialApp(
        home: ThreadScreen(args: ThreadArgs(conversationId: 'c1')),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

double? _fontSizeOf(WidgetTester tester, String text) =>
    tester.widget<Text>(find.text(text)).style?.fontSize;

void main() {
  testWidgets('a message of only emoji is drawn large; with words it is not',
      (tester) async {
    await _open(tester, [
      _msg('m2', 'lol 😂', 'them', DateTime(2026, 1, 1, 9, 5)),
      _msg('m1', '😂', 'them', DateTime(2026, 1, 1, 9)),
    ]);

    expect(_fontSizeOf(tester, '😂'), jumboEmojiSize(1));
    expect(_fontSizeOf(tester, 'lol 😂'), lessThan(jumboEmojiSize(3)));
  });

  testWidgets('pulling a message across starts a reply to it', (tester) async {
    final repo = await _open(tester, [
      _msg('m1', 'is it raining?', 'them', DateTime(2026, 1, 1, 9)),
    ]);

    await tester.drag(find.text('is it raining?'), const Offset(120, 0));
    await tester.pumpAndSettle();

    // The message, and now the same words above the box saying what is being
    // answered, with a way out.
    expect(find.text('is it raining?'), findsNWidgets(2));
    expect(find.byIcon(Iconsax.close_circle_copy), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'yes');
    await tester.pump();
    await tester.tap(find.byIcon(Iconsax.send_1));
    await tester.pumpAndSettle();

    expect(repo.bodies, ['yes']);
    expect(repo.repliedTo, ['m1']);
  });

  testWidgets('a reply is drawn over the message it answers, and says who',
      (tester) async {
    await _open(tester, [
      _msg(
        'm1',
        'every day',
        'them',
        DateTime(2026, 1, 1, 9, 1),
        replyToId: 'm0',
      ),
      _msg('m0', 'is it raining?', 'me', DateTime(2026, 1, 1, 9)),
    ]);

    expect(find.byType(QuoteStack), findsOneWidget);
    expect(find.text('Ada replied'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(QuoteStack),
        matching: find.text('is it raining?'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('an empty conversation offers a wave, and the wave is sent',
      (tester) async {
    final repo = await _open(tester, const []);

    expect(find.text('Ada'), findsWidgets);
    await tester.tap(find.textContaining('Wave'));
    await tester.pumpAndSettle();

    expect(repo.bodies, ['👋']);
  });

  testWidgets('the heart beside an empty box sends a heart', (tester) async {
    final repo = await _open(tester, [
      _msg('m1', 'made it home', 'them', DateTime(2026, 1, 1, 9)),
    ]);

    expect(find.byIcon(Iconsax.send_1), findsNothing);
    await tester.tap(find.byIcon(Iconsax.heart));
    await tester.pumpAndSettle();

    expect(repo.bodies, ['❤️']);
  });

  testWidgets('a run from one person shares one avatar', (tester) async {
    await _open(tester, [
      _msg('m3', 'third', 'them', DateTime(2026, 1, 1, 9, 0, 40)),
      _msg('m2', 'second', 'them', DateTime(2026, 1, 1, 9, 0, 20)),
      _msg('m1', 'first', 'them', DateTime(2026, 1, 1, 9)),
    ]);

    expect(
      find.descendant(
        of: find.byType(ListView),
        matching: find.byType(CircleAvatar),
      ),
      findsOneWidget,
    );
  });
}
