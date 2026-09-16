import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/conversation.dart';
import 'package:kyron_app/providers/messages_provider.dart';
import 'package:kyron_app/repositories/keys_repository.dart';
import 'package:kyron_app/repositories/messages_repository.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/message_vault.dart';

/// Replying to a message in a chat.
///
/// The design decision worth holding: **only the id crosses the wire.** Direct
/// messages are sealed before they leave the phone, so the server stores
/// ciphertext it cannot read -- a reply carrying the quoted *words* would have
/// written that text into the database in the clear, undoing the encryption
/// for every message anybody ever replied to. The thread is decrypted here, so
/// the quote is resolved here.
class _Repo extends MessagesRepository {
  _Repo({this.thread = const [], this.sendFails = false})
    : super(ApiClient()..dio.interceptors.clear());

  final List<DirectMessage> thread;
  final bool sendFails;

  /// What each send said it was answering. Null for a plain one.
  final List<String?> repliedTo = [];
  final List<String> bodies = [];
  int _next = 0;

  @override
  Future<MessagePage> messages(
    String id, {
    String? cursor,
    int limit = 40,
  }) async => MessagePage(items: thread, people: const []);

  @override
  Future<DirectMessage> send(
    String id,
    String body, {
    List<PendingMedia> media = const [],
    String? replyToId,
  }) async {
    bodies.add(body);
    repliedTo.add(replyToId);
    if (sendFails) throw StateError('down');
    return DirectMessage(
      id: 'server-${_next++}',
      body: body,
      senderId: 'me',
      createdAt: DateTime(2026, 1, 9),
      replyToId: replyToId,
    );
  }

  @override
  Future<void> markRead(String id) async {}
}

DirectMessage _msg(
  String id,
  String body,
  String sender,
  DateTime at, {
  String? replyToId,
}) => DirectMessage(
  id: id,
  body: body,
  senderId: sender,
  createdAt: at,
  replyToId: replyToId,
);

MessageVault _lockedVault() => MessageVault(KeysRepository(ApiClient()));

void main() {
  test('a reply sends the id of what it answers', () async {
    final repo = _Repo(
      thread: [_msg('m0', 'is it raining?', 'them', DateTime(2026, 1, 1))],
    );
    final notifier = ThreadNotifier(repo, _lockedVault(), 'c1');
    await pumpEventQueue();

    await notifier.send('yes', senderId: 'me', replyToId: 'm0');

    expect(repo.repliedTo, ['m0']);
  });

  test('and never the quoted words', () async {
    final repo = _Repo(
      thread: [_msg('m0', 'is it raining?', 'them', DateTime(2026, 1, 1))],
    );
    final notifier = ThreadNotifier(repo, _lockedVault(), 'c1');
    await pumpEventQueue();

    await notifier.send('yes', senderId: 'me', replyToId: 'm0');

    // The body that went is the reply's own, with nothing of the question in
    // it. On a build where the vault is unlocked this would be ciphertext, and
    // the quote would have been plaintext beside it.
    expect(repo.bodies.single, 'yes');
    expect(repo.bodies.single, isNot(contains('raining')));
  });

  test('a message that answers nothing says so', () async {
    final repo = _Repo();
    final notifier = ThreadNotifier(repo, _lockedVault(), 'c1');
    await pumpEventQueue();

    await notifier.send('hello', senderId: 'me');

    expect(repo.repliedTo, [null]);
  });

  test('the quote is resolved from the thread, not from the server', () async {
    final repo = _Repo(
      thread: [
        _msg('m1', 'yes', 'me', DateTime(2026, 1, 2), replyToId: 'm0'),
        _msg('m0', 'is it raining?', 'them', DateTime(2026, 1, 1)),
      ],
    );
    final notifier = ThreadNotifier(repo, _lockedVault(), 'c1');
    await pumpEventQueue();

    final reply = notifier.state.messages.firstWhere((m) => m.id == 'm1');
    expect(notifier.state.answered(reply)?.body, 'is it raining?');
  });

  test('a quote older than the loaded pages resolves to nothing', () async {
    // Drawn as a placeholder rather than left blank: a reply whose quote
    // silently vanished reads as a remark that does not follow.
    final repo = _Repo(
      thread: [
        _msg('m1', 'yes', 'me', DateTime(2026, 1, 2), replyToId: 'long-ago'),
      ],
    );
    final notifier = ThreadNotifier(repo, _lockedVault(), 'c1');
    await pumpEventQueue();

    final reply = notifier.state.messages.single;
    expect(reply.replyToId, 'long-ago');
    expect(notifier.state.answered(reply), isNull);
  });

  test('a message that answers nothing has nothing to resolve', () async {
    final repo = _Repo(
      thread: [_msg('m0', 'hello', 'them', DateTime(2026, 1, 1))],
    );
    final notifier = ThreadNotifier(repo, _lockedVault(), 'c1');
    await pumpEventQueue();

    expect(notifier.state.answered(notifier.state.messages.single), isNull);
  });

  test('the bubble shown while it sends already carries the quote', () async {
    // Otherwise the quote appears only once the round trip lands, and the
    // reply looks like a loose remark for as long as the network takes.
    final repo = _Repo(
      thread: [_msg('m0', 'is it raining?', 'them', DateTime(2026, 1, 1))],
      sendFails: true,
    );
    final notifier = ThreadNotifier(repo, _lockedVault(), 'c1');
    await pumpEventQueue();

    await notifier.send('yes', senderId: 'me', replyToId: 'm0');

    final pending = notifier.state.messages.last;
    expect(pending.failed, isTrue);
    expect(pending.replyToId, 'm0');
  });

  test('sending a failed reply again is still a reply', () async {
    // It came back as a loose remark before, and the thread stopped making
    // sense.
    final repo = _Repo(
      thread: [_msg('m0', 'is it raining?', 'them', DateTime(2026, 1, 1))],
      sendFails: true,
    );
    final notifier = ThreadNotifier(repo, _lockedVault(), 'c1');
    await pumpEventQueue();
    await notifier.send('yes', senderId: 'me', replyToId: 'm0');

    await notifier.retry(notifier.state.messages.last);

    expect(repo.repliedTo, ['m0', 'm0']);
  });
}
