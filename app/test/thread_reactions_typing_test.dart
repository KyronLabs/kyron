import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/conversation.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/providers/messages_provider.dart';
import 'package:kyron_app/repositories/keys_repository.dart';
import 'package:kyron_app/repositories/messages_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/message_vault.dart';

/// Reactions, "is typing" and where "New messages" goes -- the thread's
/// bookkeeping, without a screen.
class _Repo extends MessagesRepository {
  _Repo({
    this.thread = const [],
    this.lastReadAt,
    this.failReact = false,
  }) : super(ApiClient()..dio.interceptors.clear());

  /// Newest first, the way the server sends a page.
  List<DirectMessage> thread;
  final DateTime? lastReadAt;
  final bool failReact;

  final List<(String, String)> reacted = [];
  final List<String> unreacted = [];
  int typingSent = 0;
  List<MessageReaction> serverReactions = const [];

  @override
  Future<MessagePage> messages(
    String id, {
    String? cursor,
    int limit = 40,
  }) async =>
      MessagePage(items: thread, lastReadAt: lastReadAt);

  @override
  Future<void> markRead(String id) async {}

  @override
  Future<void> react(String c, String messageId, String emoji) async {
    if (failReact) throw StateError('down');
    reacted.add((messageId, emoji));
  }

  @override
  Future<void> unreact(String c, String messageId) async =>
      unreacted.add(messageId);

  @override
  Future<List<MessageReaction>> reactions(String c, String messageId) async =>
      serverReactions;

  @override
  Future<void> typing(String c) async => typingSent++;

  @override
  Future<DirectMessage> send(
    String id,
    String body, {
    List<PendingMedia> media = const [],
    String? replyToId,
    String? linkCard,
  }) async =>
      throw UnimplementedError();
}

DirectMessage _msg(String id, String sender, DateTime at) =>
    DirectMessage(id: id, body: id, senderId: sender, createdAt: at);

MessageVault _vault() => MessageVault(KeysRepository(ApiClient()));

Future<ThreadNotifier> _open(_Repo repo) async {
  final notifier = ThreadNotifier(repo, _vault(), 'c1');
  await pumpEventQueue();
  return notifier;
}

void main() {
  group('where "New messages" goes', () {
    final t0 = DateTime(2026, 10, 1, 9);
    ThreadState state(List<DirectMessage> oldestFirst, DateTime? readUpTo) =>
        ThreadState(
          messages: oldestFirst,
          loadingFirstPage: false,
          readUpTo: readUpTo,
        );

    test('above the first message from them after the read mark', () {
      final s = state([
        _msg('a', 'them', t0),
        _msg('b', 'me', t0.add(const Duration(minutes: 1))),
        _msg('c', 'them', t0.add(const Duration(minutes: 5))),
        _msg('d', 'them', t0.add(const Duration(minutes: 6))),
      ], t0.add(const Duration(minutes: 2)));
      expect(s.firstUnreadFor('me'), 'c');
    });

    test('nowhere when everything had been read', () {
      final s = state([
        _msg('a', 'them', t0),
      ], t0.add(const Duration(minutes: 1)));
      expect(s.firstUnreadFor('me'), isNull);
    });

    test('never for the reader’s own messages', () {
      final s = state([
        _msg('a', 'them', t0),
        _msg('b', 'me', t0.add(const Duration(minutes: 5))),
      ], t0.add(const Duration(minutes: 1)));
      expect(s.firstUnreadFor('me'), isNull);
    });

    test('not above the very first message, which says nothing', () {
      final s = state([
        _msg('a', 'them', t0),
        _msg('b', 'them', t0.add(const Duration(minutes: 1))),
      ], null);
      expect(s.firstUnreadFor('me'), isNull);
    });

    test('stays where it was after the thread is marked read', () async {
      final repo = _Repo(
        thread: [
          _msg('new', 'them', t0.add(const Duration(minutes: 5))),
          _msg('old', 'them', t0),
        ],
        lastReadAt: t0.add(const Duration(minutes: 1)),
      );
      final notifier = await _open(repo);
      // Opening it marked it read; the divider still marks where it was.
      expect(notifier.state.firstUnreadFor('me'), 'new');
    });
  });

  group('is typing', () {
    testWidgets('shows who, and lapses on its own', (tester) async {
      final notifier = await tester.runAsync(() => _open(_Repo()));
      notifier!.otherTyping('them');
      expect(notifier.state.typing, 'them');

      await tester
          .pump(ThreadNotifier.typingLapse - const Duration(seconds: 1));
      expect(notifier.state.typing, 'them');

      await tester.pump(const Duration(seconds: 2));
      expect(notifier.state.typing, isNull);
      notifier.dispose();
    });

    testWidgets('a fresh sign of typing keeps it up', (tester) async {
      final notifier = await tester.runAsync(() => _open(_Repo()));
      notifier!.otherTyping('them');
      await tester.pump(const Duration(seconds: 4));
      notifier.otherTyping('them');
      await tester.pump(const Duration(seconds: 4));
      expect(notifier.state.typing, 'them');
      notifier.dispose();
    });

    test('goes when their message arrives', () async {
      final repo = _Repo(thread: [_msg('a', 'them', DateTime(2026))]);
      final notifier = await _open(repo);
      notifier.otherTyping('them');

      repo.thread = [
        _msg('b', 'them', DateTime(2026, 1, 2)),
        _msg('a', 'them', DateTime(2026)),
      ];
      await notifier.pullNewest();
      expect(notifier.state.typing, isNull);
      notifier.dispose();
    });

    test('is sent at most every few seconds, however fast the typing',
        () async {
      final repo = _Repo();
      final notifier = await _open(repo);
      final t = DateTime(2026, 10, 1, 9);

      for (var i = 0; i < 10; i++) {
        await notifier.sendTyping(now: t.add(Duration(milliseconds: 200 * i)));
      }
      expect(repo.typingSent, 1);

      await notifier.sendTyping(now: t.add(ThreadNotifier.typingEvery));
      expect(repo.typingSent, 2);
    });
  });

  group('reactions', () {
    final message = _msg('m1', 'them', DateTime(2026));

    test('are on screen at once and sent', () async {
      final repo = _Repo(thread: [message]);
      final notifier = await _open(repo);

      await notifier.react(message, '😂', me: 'me');

      expect(notifier.state.messages.single.reactionOf('me'), '😂');
      expect(repo.reacted, [('m1', '😂')]);
    });

    test('replace the reader’s previous one rather than adding', () async {
      final repo = _Repo(thread: [message]);
      final notifier = await _open(repo);

      await notifier.react(message, '😂', me: 'me');
      await notifier.react(message, '❤️', me: 'me');

      expect(notifier.state.messages.single.reactions, [
        const MessageReaction(userId: 'me', emoji: '❤️'),
      ]);
    });

    test('are put back when the server refuses, and say why', () async {
      final repo = _Repo(thread: [message], failReact: true);
      final notifier = await _open(repo);

      final error = await notifier.react(message, '😂', me: 'me');

      expect(error, isNotNull);
      expect(notifier.state.messages.single.reactions, isEmpty);
    });

    test('a double tap hearts, and a second takes it back', () async {
      final repo = _Repo(thread: [message]);
      final notifier = await _open(repo);

      await notifier.toggleHeart(message, me: 'me');
      expect(notifier.state.messages.single.reactionOf('me'), '❤️');

      await notifier.toggleHeart(message, me: 'me');
      expect(notifier.state.messages.single.reactionOf('me'), isNull);
      expect(repo.unreacted, ['m1']);
    });

    test('never on a message still on its way', () async {
      final repo = _Repo(thread: [message]);
      final notifier = await _open(repo);
      final sending = DirectMessage(
        id: 'pending-0',
        body: 'hi',
        senderId: 'me',
        createdAt: DateTime(2026),
        sending: true,
      );
      await notifier.react(sending, '❤️', me: 'me');
      expect(repo.reacted, isEmpty);
    });

    test('from the other side are read when the socket says they changed',
        () async {
      final repo = _Repo(thread: [message])
        ..serverReactions = const [
          MessageReaction(userId: 'them', emoji: '😮'),
        ];
      final notifier = await _open(repo);

      await notifier.reactionsChanged('m1');

      expect(notifier.state.messages.single.reactionOf('them'), '😮');
    });
  });
}
