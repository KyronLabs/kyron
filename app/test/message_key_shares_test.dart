import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/conversation.dart';
import 'package:kyron_app/models/key_share.dart';
import 'package:kyron_app/providers/messages_provider.dart';
import 'package:kyron_app/repositories/messages_repository.dart';
import 'package:kyron_app/repositories/keys_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/message_crypto.dart';
import 'package:kyron_app/services/message_vault.dart';

/// A device that came after a message, reading it anyway.
///
/// A message is sealed for the devices listed when it is sent. A reviewer
/// wrote to an account at 11:00; the phone reading that account at 12:30 was
/// a fresh install with a key made at 12:15, and the message could never be
/// opened there. Now the new install asks, a device that can open the message
/// seals its key again for the new one, and the message opens -- with nothing
/// readable passing through the server on the way.

/// The server's part: published keys, and requests and their answers.
class _Server {
  final keys = <PublishedKey>[];
  final messages = <String, ({String body, String? linkCard})>{};
  final requests = <({
    String id,
    String messageId,
    String userId,
    String publicKey,
  })>[];
  final answers = <String, String>{};

  /// What the thread would be sent for [user]: the answers for their keys.
  List<KeyShare> sharesFor(String user, String messageId) => [
        for (final r in requests)
          if (r.userId == user &&
              r.messageId == messageId &&
              answers[r.id] != null)
            KeyShare(publicKey: r.publicKey, sealed: answers[r.id]!),
      ];
}

/// One install's connection to it, signed in as [user].
class _Keys extends KeysRepository {
  _Keys(this.server, this.user) : super(ApiClient()..dio.interceptors.clear());

  final _Server server;
  final String user;

  @override
  Future<void> publish(String publicKey, String deviceId) async {
    server.keys
      ..removeWhere((k) => k.userId == user && k.deviceId == deviceId)
      ..insert(
        0,
        PublishedKey(userId: user, deviceId: deviceId, publicKey: publicKey),
      );
  }

  @override
  Future<List<PublishedKey>> forConversation(String conversationId) async =>
      List.of(server.keys);

  @override
  Future<void> requestShares(
    String conversationId,
    String deviceId,
    List<String> messageIds,
  ) async {
    final key = server.keys
        .firstWhere((k) => k.userId == user && k.deviceId == deviceId)
        .publicKey;
    for (final id in messageIds) {
      server.requests.add((
        id: 'r${server.requests.length}',
        messageId: id,
        userId: user,
        publicKey: key,
      ));
    }
  }

  @override
  Future<List<KeyRequest>> pendingRequests() async => [
        for (final r in server.requests)
          if (server.answers[r.id] == null)
            KeyRequest(
              id: r.id,
              conversationId: 'c1',
              messageId: r.messageId,
              body: server.messages[r.messageId]!.body,
              linkCard: server.messages[r.messageId]!.linkCard,
              publicKey: r.publicKey,
            ),
      ];

  @override
  Future<void> shareKeys(List<({String id, String sealed})> shares) async {
    for (final s in shares) {
      server.answers.putIfAbsent(s.id, () => s.sealed);
    }
  }
}

/// A phone's own keychain: two installs never share one.
class _Install extends FlutterSecureStorage {
  final _values = <String, String>{};

  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      _values[key];

  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value == null) {
      _values.remove(key);
    } else {
      _values[key] = value;
    }
  }

  @override
  Future<void> delete({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      _values.remove(key);
}

/// The thread as the server sends it to [user]: each message with the
/// answers for their devices.
class _Thread extends MessagesRepository {
  _Thread(this.server, this.user) : super(ApiClient());

  final _Server server;
  final String user;

  @override
  Future<MessagePage> messages(
    String id, {
    String? cursor,
    int limit = 40,
  }) async =>
      MessagePage(
        items: [
          for (final entry in server.messages.entries)
            DirectMessage(
              id: entry.key,
              body: entry.value.body,
              senderId: 'reviewer',
              createdAt: DateTime.now(),
              keyShares: server.sharesFor(user, entry.key),
            ),
        ],
      );

  @override
  Future<void> markRead(String id) async {}
}

Future<MessageVault> _install(_Server server, String user) async {
  final vault = MessageVault(_Keys(server, user), storage: _Install());
  await vault.unlock(user);
  return vault;
}

void main() {
  test('a new install asks, the sender answers, and the message opens',
      () async {
    final server = _Server();
    final reviewer = await _install(server, 'reviewer');
    await _install(server, 'yun'); // the install that was wiped

    final sealed = (await reviewer.seal('hello from review', 'c1'))!;
    server.messages['m1'] = (body: sealed, linkCard: null);

    // The phone reading as Yun now: a new install, a new key.
    final newPhone = await _install(server, 'yun');
    expect(await newPhone.open(sealed, 'c1'), isNull);

    await newPhone.requestKeys('c1', ['m1']);
    expect(server.requests, hasLength(1));
    expect(await reviewer.answerPending(), 1);

    expect(
      await newPhone.open(
        sealed,
        'c1',
        shares: server.sharesFor('yun', 'm1'),
      ),
      'hello from review',
    );
    // And the conversation list's preview, which never fetches keys.
    expect(
      await newPhone.openOffline(
        sealed,
        'c1',
        shares: server.sharesFor('yun', 'm1'),
      ),
      'hello from review',
    );
  });

  test('another of the reader\'s own devices can answer too', () async {
    final server = _Server();
    final ada = await _install(server, 'ada');
    final boTablet = await _install(server, 'bo');
    final sealed = (await ada.seal('for both of yours', 'c1'))!;
    server.messages['m1'] = (body: sealed, linkCard: null);

    final boPhone = await _install(server, 'bo');
    await boPhone.requestKeys('c1', ['m1']);
    // Ada is nowhere to be seen; Bo's tablet was sealed for, and answers.
    expect(await boTablet.answerPending(), 1);

    expect(
      await boPhone.open(sealed, 'c1', shares: server.sharesFor('bo', 'm1')),
      'for both of yours',
    );
  });

  test('the link card opens with the same answer', () async {
    final server = _Server();
    final ada = await _install(server, 'ada');
    await _install(server, 'bo');
    final body = (await ada.seal('look https://kyron.so', 'c1'))!;
    final card = (await ada.seal('{"url":"https://kyron.so"}', 'c1'))!;
    server.messages['m1'] = (body: body, linkCard: card);

    final boPhone = await _install(server, 'bo');
    await boPhone.requestKeys('c1', ['m1']);
    await ada.answerPending();
    final shares = server.sharesFor('bo', 'm1');

    expect(await boPhone.open(body, 'c1', shares: shares), contains('look'));
    expect(
      await boPhone.open(card, 'c1', shares: shares, card: true),
      '{"url":"https://kyron.so"}',
    );
  });

  test('an answer opens only on the device it was sealed for', () async {
    final server = _Server();
    final ada = await _install(server, 'ada');
    await _install(server, 'bo'); // an install of Bo's since lost
    final sealed = (await ada.seal('just for the new phone', 'c1'))!;
    server.messages['m1'] = (body: sealed, linkCard: null);
    final boPhone = await _install(server, 'bo');
    await boPhone.requestKeys('c1', ['m1']);
    await ada.answerPending();

    // A device that is not the one that asked -- the same account, even --
    // gets nothing out of the answer.
    final elsewhere = await _install(server, 'bo');
    expect(
      await elsewhere.open(sealed, 'c1', shares: server.sharesFor('bo', 'm1')),
      isNull,
    );
  });

  test('a device answers only what it can open itself', () async {
    final server = _Server();
    final ada = await _install(server, 'ada');
    await _install(server, 'bo'); // an install of Bo's since lost
    final sealed = (await ada.seal('hi', 'c1'))!;
    server.messages['m1'] = (body: sealed, linkCard: null);

    // Cy's device was never sealed for, so it has nothing to give.
    final cy = await _install(server, 'cy');
    final boPhone = await _install(server, 'bo');
    await boPhone.requestKeys('c1', ['m1']);

    expect(await cy.answerPending(), 0);
    expect(server.answers, isEmpty);
    // Nor does the asking device answer its own request.
    expect(await boPhone.answerPending(), 0);
  });

  test('asks once per message, however often the thread is drawn', () async {
    final server = _Server();
    final ada = await _install(server, 'ada');
    await _install(server, 'bo'); // an install of Bo's since lost
    final sealed = (await ada.seal('hi', 'c1'))!;
    server.messages['m1'] = (body: sealed, linkCard: null);
    final boPhone = await _install(server, 'bo');

    await boPhone.requestKeys('c1', ['m1']);
    await boPhone.requestKeys('c1', ['m1']);

    expect(server.requests, hasLength(1));
  });

  test('only recent sealed messages are worth asking for', () {
    final now = DateTime.now();
    expect(MessageVault.canAskFor('k2.x', now), isTrue);
    expect(
      MessageVault.canAskFor('k2.x', now.subtract(const Duration(days: 45))),
      isFalse,
    );
    // The old single-key form has no per-device key to share.
    expect(MessageVault.canAskFor('k1.x', now), isFalse);
  });

  test('a share names who answered, and opens for nobody else', () async {
    final server = _Server();
    final ada = await _install(server, 'ada');
    await _install(server, 'bo'); // an install of Bo's since lost
    final sealed = (await ada.seal('secret', 'c1'))!;
    server.messages['m1'] = (body: sealed, linkCard: null);
    final boPhone = await _install(server, 'bo');
    await boPhone.requestKeys('c1', ['m1']);
    await ada.answerPending();

    // `<answering key>.<nonce>.<sealed key>.<mac>`: the server checks the
    // first part is a key the answering account published.
    final share = server.answers.values.single;
    final parts = share.split('.');
    expect(parts, hasLength(4));
    expect(parts.first,
        server.keys.firstWhere((k) => k.userId == 'ada').publicKey);

    final crypto = MessageCrypto();
    expect(
      await crypto.openShare(share, mine: await crypto.newKeyPair()),
      isNull,
    );
  });

  test('the thread says it is waiting, asks, and opens when answered',
      () async {
    final server = _Server();
    final reviewer = await _install(server, 'reviewer');
    await _install(server, 'yun');
    final sealed = (await reviewer.seal('hello from review', 'c1'))!;
    server.messages['m1'] = (body: sealed, linkCard: null);

    final newPhone = await _install(server, 'yun');
    final thread = ThreadNotifier(_Thread(server, 'yun'), newPhone, 'c1');
    await pumpEventQueue();

    final waiting = thread.state.messages.single;
    expect(waiting.unreadable, isTrue);
    expect(waiting.awaitingKey, isTrue);
    expect(server.requests, hasLength(1), reason: 'drawing it asked');

    await reviewer.answerPending();
    await thread.keysArrived();

    final opened = thread.state.messages.single;
    expect(opened.body, 'hello from review');
    expect(opened.unreadable, isFalse);
    expect(opened.awaitingKey, isFalse);
    thread.dispose();
  });
}
