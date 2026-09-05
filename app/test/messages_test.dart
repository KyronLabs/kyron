import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/conversation.dart';
import 'package:kyron_app/providers/messages_provider.dart';
import 'package:kyron_app/repositories/messages_repository.dart';
import 'package:kyron_app/services/api_client.dart';

class _Down implements Exception {}

class _FakeMessages extends MessagesRepository {
  _FakeMessages({
    this.thread = const [],
    this.people = const [],
    this.rows = const [],
    this.sendFails = false,
    this.listFails = false,
  }) : super(ApiClient());

  final List<DirectMessage> thread;
  final List<MessagePerson> people;
  final List<Conversation> rows;
  final bool sendFails;
  final bool listFails;

  final List<String> sent = [];
  final List<String> readMarks = [];
  final List<String> hidden = [];
  final List<String> removed = [];
  int _next = 0;

  @override
  Future<MessagePage> messages(String id,
      {String? cursor, int limit = 40}) async {
    if (listFails) throw _Down();
    return MessagePage(items: thread, people: people);
  }

  @override
  Future<DirectMessage> send(String id, String body) async {
    sent.add(body);
    if (sendFails) throw _Down();
    return DirectMessage(
      id: 'server-${_next++}',
      body: body,
      senderId: 'me',
      createdAt: DateTime(2026, 1, 2),
    );
  }

  @override
  Future<void> markRead(String id) async => readMarks.add(id);

  @override
  Future<void> hide(String id) async => hidden.add(id);

  @override
  Future<void> remove(String id) async => removed.add(id);

  @override
  Future<ConversationPage> conversations({
    String? cursor,
    int limit = 30,
    bool unreadOnly = false,
  }) async {
    if (listFails) throw _Down();
    return ConversationPage(items: rows);
  }
}

DirectMessage _msg(String id, String body, String sender, DateTime at) =>
    DirectMessage(id: id, body: body, senderId: sender, createdAt: at);

void main() {
  group('a thread', () {
    test('is held oldest last, whichever order the server answers in',
        () async {
      // The server pages newest first, because that is what a cursor over
      // "most recent" has to do. A chat is read the other way round.
      final repo = _FakeMessages(thread: [
        _msg('c', 'third', 'me', DateTime(2026, 1, 3)),
        _msg('b', 'second', 'them', DateTime(2026, 1, 2)),
        _msg('a', 'first', 'me', DateTime(2026, 1, 1)),
      ]);
      final notifier = ThreadNotifier(repo, 'c1');
      await pumpEventQueue();

      expect(
        notifier.state.messages.map((m) => m.body),
        ['first', 'second', 'third'],
      );
    });

    test('marks itself read when it opens', () async {
      final repo = _FakeMessages();
      ThreadNotifier(repo, 'c1');
      await pumpEventQueue();
      expect(repo.readMarks, ['c1']);
    });

    test('carries who is in it, for the header', () async {
      const ada = MessagePerson(id: 'ada', name: 'Ada', username: 'ada');
      final notifier = ThreadNotifier(
        _FakeMessages(people: const [ada]),
        'c1',
      );
      await pumpEventQueue();
      expect(notifier.state.people.single.id, 'ada');
    });

    test('shows what was typed before the server has it', () async {
      // A chat that sits still until a round trip completes feels broken on a
      // slow connection.
      final repo = _FakeMessages();
      final notifier = ThreadNotifier(repo, 'c1');
      await pumpEventQueue();

      final sending = notifier.send('hello', senderId: 'me');
      expect(notifier.state.messages.single.body, 'hello');
      expect(notifier.state.messages.single.sending, isTrue);

      await sending;
      expect(notifier.state.messages.single.sending, isFalse);
      expect(notifier.state.messages.single.id, 'server-0');
    });

    test('keeps a message that failed, and says so', () async {
      // Quietly dropping it loses what somebody wrote.
      final repo = _FakeMessages(sendFails: true);
      final notifier = ThreadNotifier(repo, 'c1');
      await pumpEventQueue();

      await notifier.send('hello', senderId: 'me');

      expect(notifier.state.messages.single.body, 'hello');
      expect(notifier.state.messages.single.failed, isTrue);
      expect(notifier.state.messages.single.sending, isFalse);
    });

    test('sends a failed one again without duplicating it', () async {
      final repo = _FakeMessages(sendFails: true);
      final notifier = ThreadNotifier(repo, 'c1');
      await pumpEventQueue();
      await notifier.send('hello', senderId: 'me');

      await notifier.retry(notifier.state.messages.single);

      expect(notifier.state.messages, hasLength(1));
      expect(repo.sent, ['hello', 'hello']);
    });

    test('will not send nothing', () async {
      final repo = _FakeMessages();
      final notifier = ThreadNotifier(repo, 'c1');
      await pumpEventQueue();

      await notifier.send('   ', senderId: 'me');

      expect(repo.sent, isEmpty);
      expect(notifier.state.messages, isEmpty);
    });

    test('drops a failed message without asking the server', () async {
      final repo = _FakeMessages(sendFails: true);
      final notifier = ThreadNotifier(repo, 'c1');
      await pumpEventQueue();
      await notifier.send('hello', senderId: 'me');

      await notifier.remove(notifier.state.messages.single);

      expect(notifier.state.messages, isEmpty);
      expect(repo.removed, isEmpty);
    });

    test('says why it could not be read', () async {
      final notifier = ThreadNotifier(_FakeMessages(listFails: true), 'c1');
      await pumpEventQueue();
      expect(notifier.state.error, isNotNull);
      expect(notifier.state.loadingFirstPage, isFalse);
    });
  });

  group('the conversation list', () {
    Conversation row(String id, {int unread = 0}) => Conversation(
          id: id,
          people: [MessagePerson(id: 'p-$id', name: 'Person $id')],
          unread: unread,
          lastMessageAt: DateTime(2026, 1, 1),
        );

    test('clears a badge once the thread has been opened', () async {
      final repo = _FakeMessages(rows: [row('a', unread: 3)]);
      final notifier = ConversationListNotifier(repo, unreadOnly: false);
      await pumpEventQueue();

      notifier.markRead('a');

      expect(notifier.state.items.single.unread, 0);
    });

    test('takes a removed conversation off the list at once', () async {
      final repo = _FakeMessages(rows: [row('a'), row('b')]);
      final notifier = ConversationListNotifier(repo, unreadOnly: false);
      await pumpEventQueue();

      await notifier.hide(notifier.state.items.first);

      expect(notifier.state.items.map((c) => c.id), ['b']);
      expect(repo.hidden, ['a']);
    });

    test('asks the server for the unread tab rather than filtering a page',
        () async {
      // Filtering after paging gives short pages and a tab that looks empty
      // while there is more behind the cursor.
      var askedUnread = false;
      final repo = _UnreadSpy(() => askedUnread = true);
      ConversationListNotifier(repo, unreadOnly: true);
      await pumpEventQueue();
      expect(askedUnread, isTrue);
    });
  });
}

class _UnreadSpy extends MessagesRepository {
  _UnreadSpy(this.onUnread) : super(ApiClient());
  final void Function() onUnread;

  @override
  Future<ConversationPage> conversations({
    String? cursor,
    int limit = 30,
    bool unreadOnly = false,
  }) async {
    if (unreadOnly) onUnread();
    return const ConversationPage();
  }
}
