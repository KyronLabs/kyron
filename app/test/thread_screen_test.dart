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
import 'package:kyron_app/widgets/overlap_stack.dart';

/// The chat screen, driven the way somebody uses it: big emoji, pulling a
/// message across to answer it, the wave that opens an empty conversation,
/// and the heart beside an empty box.
class _Repo extends MessagesRepository {
  _Repo(this.thread, {this.lastReadAt})
      : super(ApiClient()..dio.interceptors.clear());

  /// Newest first, the way the server sends a page.
  final List<DirectMessage> thread;
  final DateTime? lastReadAt;

  final List<String> bodies = [];
  final List<String?> repliedTo = [];
  final List<(String, String)> reacted = [];
  final List<String> unreacted = [];
  int typingSent = 0;

  @override
  Future<MessagePage> messages(
    String id, {
    String? cursor,
    int limit = 40,
  }) async =>
      MessagePage(
        items: thread,
        people: const [MessagePerson(id: 'them', name: 'Ada')],
        lastReadAt: lastReadAt,
      );

  @override
  Future<void> react(String c, String messageId, String emoji) async =>
      reacted.add((messageId, emoji));

  @override
  Future<void> unreact(String c, String messageId) async =>
      unreacted.add(messageId);

  @override
  Future<List<MessageReaction>> reactions(String c, String m) async => const [];

  @override
  Future<void> typing(String c) async => typingSent++;

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
  List<MessageReaction> reactions = const [],
}) =>
    DirectMessage(
      id: id,
      body: body,
      senderId: sender,
      createdAt: at,
      replyToId: replyToId,
      reactions: reactions,
    );

Future<_Repo> _open(
  WidgetTester tester,
  List<DirectMessage> thread, {
  DateTime? lastReadAt,
}) async {
  final repo = _Repo(thread, lastReadAt: lastReadAt);
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

    expect(find.byType(OverlapStack), findsOneWidget);
    expect(find.text('Ada replied'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(OverlapStack),
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

  testWidgets('a double tap hearts a message', (tester) async {
    final repo = await _open(tester, [
      _msg('m1', 'made it home', 'them', DateTime(2026, 1, 1, 9)),
    ]);

    await tester.tap(find.text('made it home'));
    await tester.pump(const Duration(milliseconds: 60));
    await tester.tap(find.text('made it home'));
    await tester.pumpAndSettle();

    expect(repo.reacted, [('m1', '❤️')]);
    expect(find.text('❤️'), findsOneWidget);
  });

  testWidgets('a long press offers the quick reactions above the rest',
      (tester) async {
    final repo = await _open(tester, [
      _msg('m1', 'made it home', 'them', DateTime(2026, 1, 1, 9)),
    ]);

    await tester.longPress(find.text('made it home'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('😂').last);
    await tester.pumpAndSettle();

    expect(repo.reacted, [('m1', '😂')]);
  });

  testWidgets('a tap on your own reaction takes it back', (tester) async {
    final repo = await _open(tester, [
      _msg(
        'm1',
        'made it home',
        'them',
        DateTime(2026, 1, 1, 9),
        reactions: const [MessageReaction(userId: 'me', emoji: '😮')],
      ),
    ]);

    await tester.tap(find.text('😮'));
    await tester.pumpAndSettle();

    expect(repo.unreacted, ['m1']);
    expect(find.text('😮'), findsNothing);
  });

  testWidgets('the other person’s reaction is shown and is not yours to take',
      (tester) async {
    final repo = await _open(tester, [
      _msg(
        'm1',
        'made it home',
        'me',
        DateTime(2026, 1, 1, 9),
        reactions: const [MessageReaction(userId: 'them', emoji: '❤️')],
      ),
    ]);

    await tester.tap(find.text('❤️'));
    await tester.pumpAndSettle();

    expect(find.text('❤️'), findsOneWidget);
    expect(repo.unreacted, isEmpty);
  });

  testWidgets('"New messages" sits above where the reader left off',
      (tester) async {
    await _open(
      tester,
      [
        _msg('m3', 'are you there?', 'them', DateTime(2026, 1, 1, 9, 30)),
        _msg('m2', 'hello?', 'them', DateTime(2026, 1, 1, 9, 20)),
        _msg('m1', 'see you at six', 'me', DateTime(2026, 1, 1, 9)),
      ],
      lastReadAt: DateTime(2026, 1, 1, 9, 10),
    );

    expect(find.text('New messages'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('New messages')).dy,
      lessThan(tester.getTopLeft(find.text('hello?')).dy),
    );
    expect(
      tester.getTopLeft(find.text('New messages')).dy,
      greaterThan(tester.getTopLeft(find.text('see you at six')).dy),
    );
  });

  testWidgets('and is not there when everything had been read', (tester) async {
    await _open(
      tester,
      [
        _msg('m2', 'hello?', 'them', DateTime(2026, 1, 1, 9, 20)),
        _msg('m1', 'see you at six', 'me', DateTime(2026, 1, 1, 9)),
      ],
      lastReadAt: DateTime(2026, 1, 1, 10),
    );
    expect(find.text('New messages'), findsNothing);
  });

  testWidgets('"is typing" shows at the foot of the thread', (tester) async {
    await _open(tester, [
      _msg('m1', 'made it home', 'them', DateTime(2026, 1, 1, 9)),
    ]);
    final container = ProviderScope.containerOf(
      tester.element(find.byType(ThreadScreen)),
    );

    container.read(threadProvider('c1').notifier).otherTyping('them');
    await tester.pump();
    expect(find.bySemanticsLabel('Ada is typing'), findsOneWidget);

    // And goes on its own once they pause.
    await tester.pump(ThreadNotifier.typingLapse);
    await tester.pump();
    expect(find.bySemanticsLabel('Ada is typing'), findsNothing);
  });

  testWidgets('typing tells the other side, but not on every keystroke',
      (tester) async {
    final repo = await _open(tester, [
      _msg('m1', 'made it home', 'them', DateTime(2026, 1, 1, 9)),
    ]);

    await tester.enterText(find.byType(TextField), 'h');
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'he');
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'hey');
    await tester.pump();

    expect(repo.typingSent, 1);
  });
}
