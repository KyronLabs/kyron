import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cryptography/cryptography.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/conversation.dart';
import 'package:kyron_app/models/link_preview.dart';
import 'package:kyron_app/models/message_link_card.dart';
import 'package:kyron_app/widgets/link_preview_card.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/providers/messages_provider.dart';
import 'package:kyron_app/repositories/keys_repository.dart';
import 'package:kyron_app/repositories/messages_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/link_card_reader.dart';
import 'package:kyron_app/services/message_crypto.dart';
import 'package:kyron_app/services/message_vault.dart';

/// Link cards in direct messages.
///
/// The design worth holding: **the server never learns the address.** A post's
/// card is read by the server, which reads the post anyway. A message is
/// sealed before it leaves the phone, so its card is made on the sender's
/// phone and sealed with it, and readers draw it without contacting the
/// linked site.
void main() {
  group('reading a page', () {
    test('prefers Open Graph, and resolves a picture given as a path', () {
      final card = parseCard(
        '<html><head>'
        '<title>Tab title</title>'
        '<meta property="og:title" content="Card title">'
        '<meta name="description" content="Plain">'
        '<meta property="og:description" content="Fish &amp; chips">'
        '<meta property="og:image" content="/img/c.jpg">'
        "<meta property='og:site_name' content='The Site'>"
        '</head><body><meta property="og:title" content="Body"></body>',
        Uri.parse('https://example.com/a/b'),
      );

      expect(card.title, 'Card title');
      expect(card.description, 'Fish & chips');
      expect(card.imageUrl, 'https://example.com/img/c.jpg');
      expect(card.siteName, 'The Site');
    });

    test('falls back to the title tag, and drops a picture that is not web',
        () {
      final card = parseCard(
        '<head><title>  Just   a page </title>'
        '<meta property="og:image" content="javascript:alert(1)"></head>',
        Uri.parse('https://example.com'),
      );

      expect(card.title, 'Just a page');
      expect(card.imageUrl, isNull);
    });

    test('a pasted link to this phone or its network is never read', () {
      for (final url in [
        'http://localhost:8080/x',
        'http://127.0.0.1/',
        'http://192.168.1.1/admin',
        'http://10.0.0.2/',
        'http://172.20.1.1/',
        'http://[::1]/',
        'http://printer.local/',
        'ftp://example.com/file',
      ]) {
        expect(LinkCardReader.isFetchable(Uri.parse(url)), isFalse,
            reason: url);
      }
      expect(
        LinkCardReader.isFetchable(Uri.parse('https://kyron.app/about')),
        isTrue,
      );
    });

    test('with its own client: the session token never goes to a page',
        () async {
      final seen = <RequestOptions>[];
      final dio = Dio()
        ..httpClientAdapter = _Pages(seen, {
          'https://example.com/post': (
            'text/html; charset=utf-8',
            utf8.encode(
              '<head><meta property="og:title" content="A post"></head>',
            ),
          ),
        });

      final card = await LinkCardReader(http: dio).read(
        'https://example.com/post',
      );

      expect(card?.title, 'A post');
      expect(card?.url, 'https://example.com/post');
      expect(seen.single.headers.keys.map((k) => k.toLowerCase()),
          isNot(contains('authorization')));
    });

    test('a page that will not load is a message without a card', () async {
      final dio = Dio()..httpClientAdapter = _Pages([], {});
      expect(
        await LinkCardReader(http: dio).read('https://example.com/gone'),
        isNull,
      );
    });

    testWidgets('a picture is cut to the card and shrunk', (tester) async {
      await tester.runAsync(() async {
        final big = await _png(1600, 1200);
        final small = await LinkCardReader.shrink(big);

        expect(small, isNotNull);
        expect(small!.length, lessThanOrEqualTo(MessageLinkCard.maxImageBytes));
        // A JPEG, whatever came in.
        expect(small.sublist(0, 2), [0xff, 0xd8]);

        final buffer = await ui.ImmutableBuffer.fromUint8List(small);
        final descriptor = await ui.ImageDescriptor.encoded(buffer);
        expect(descriptor.width, LinkCardReader.imageWidth);
        expect(descriptor.height, closeTo(LinkCardReader.imageHeight, 1));
      });
    });
  });

  testWidgets('a card with no picture lays out in a scrolling list', (
    tester,
  ) async {
    // The picture-less row was stretched to the height it was given, and a
    // list gives none: every title-only card in the feed failed to lay out.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: const [
              LinkCard(
                preview: LinkPreview(
                  url: 'https://example.com',
                  host: 'example.com',
                  title: 'Only a title',
                ),
              ),
            ],
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Only a title'), findsOneWidget);
    expect(
      tester.getSize(find.byType(LinkCard)).height,
      greaterThanOrEqualTo(72),
    );
  });

  group('a card that arrived', () {
    const card = MessageLinkCard(
      url: 'https://example.com/post',
      title: 'A post',
      siteName: 'Example',
    );

    test('reads back what was sent', () {
      final back = MessageLinkCard.tryDecode(
        card.encode(),
        body: 'look https://example.com/post',
      );
      expect(back?.title, 'A post');
      expect(back?.asPreview.label, 'Example');
    });

    test('must point at a link the words show', () {
      // Otherwise "kyron.app" in the words could carry a card that goes
      // somewhere else entirely.
      expect(
        MessageLinkCard.tryDecode(card.encode(), body: 'look kyron.app'),
        isNull,
      );
      // A bare host in the words is the https address it was read as.
      expect(
        MessageLinkCard.tryDecode(card.encode(), body: 'example.com/post !'),
        isNotNull,
      );
    });

    test('is never anything but a web address', () {
      final bad = jsonEncode({'url': 'javascript:alert(1)', 'title': 'x'});
      expect(
        MessageLinkCard.tryDecode(bad, body: 'javascript:alert(1)'),
        isNull,
      );
      expect(MessageLinkCard.tryDecode('not json', body: 'x'), isNull);
    });

    test('drops a picture too large to have come from this app', () {
      final raw = jsonEncode({
        'url': 'https://example.com/post',
        'title': 'A post',
        'image': base64Encode(Uint8List(MessageLinkCard.maxImageBytes + 1)),
      });
      final back = MessageLinkCard.tryDecode(
        raw,
        body: 'https://example.com/post',
      );
      expect(back?.title, 'A post');
      expect(back?.image, isNull);
    });
  });

  group('in a thread', () {
    test('goes sealed beside sealed words, and opens on the other side',
        () async {
      final ada = await _device('ada');
      final bo = await _device('bo');
      final keys = _Keys([await ada.published(), await bo.published()]);
      final repo = _Repo();
      final notifier = ThreadNotifier(repo, ada.vault(keys), 'c1');
      await pumpEventQueue();

      await notifier.send(
        'look https://example.com/post',
        senderId: 'ada',
        linkCard: card,
      );

      // Neither the words nor the address went to the server readable.
      expect(repo.cards.single, startsWith('k2.'));
      expect(repo.cards.single, isNot(contains('example.com')));
      expect(notifier.state.messages.single.linkCard?.title, 'A post');

      // Bo's phone opens both.
      final reader = ThreadNotifier(
        _Repo(thread: [repo.stored.single]),
        bo.vault(keys),
        'c1',
      );
      await pumpEventQueue(times: 50);
      expect(reader.state.messages.single.linkCard?.title, 'A post');
    });

    test('an open card beside sealed words is not drawn', () async {
      final ada = await _device('ada');
      final bo = await _device('bo');
      final keys = _Keys([await ada.published(), await bo.published()]);
      final sealed = await ada.vault(keys).seal(
            'look https://example.com/post',
            'c1',
          );

      final reader = ThreadNotifier(
        _Repo(thread: [
          DirectMessage(
            id: 'm1',
            body: sealed!,
            senderId: 'ada',
            createdAt: DateTime(2026),
            linkCardRaw: card.encode(),
          ),
        ]),
        bo.vault(keys),
        'c1',
      );
      await pumpEventQueue(times: 50);

      expect(reader.state.messages.single.body, contains('example.com'));
      expect(reader.state.messages.single.linkCard, isNull);
    });

    test('a card is not sent with a picture that has no words', () async {
      final repo = _Repo();
      final notifier = ThreadNotifier(
        repo,
        MessageVault(KeysRepository(ApiClient())),
        'c1',
      );
      await pumpEventQueue();

      await notifier.send(
        '',
        senderId: 'me',
        media: const [
          PendingMedia(
            path: '/tmp/a.jpg',
            kind: MediaKind.image,
            url: 'https://cdn.invalid/a.jpg',
          ),
        ],
        linkCard: card,
      );

      expect(repo.cards.single, isNull);
    });
  });
}

const card = MessageLinkCard(
  url: 'https://example.com/post',
  title: 'A post',
  siteName: 'Example',
);

class _Repo extends MessagesRepository {
  _Repo({this.thread = const []})
      : super(ApiClient()..dio.interceptors.clear());

  final List<DirectMessage> thread;
  final List<String?> cards = [];
  final List<DirectMessage> stored = [];

  @override
  Future<MessagePage> messages(
    String id, {
    String? cursor,
    int limit = 40,
  }) async =>
      MessagePage(items: thread);

  @override
  Future<DirectMessage> send(
    String id,
    String body, {
    List<PendingMedia> media = const [],
    String? replyToId,
    String? linkCard,
    OnceUpload? once,
  }) async {
    cards.add(linkCard);
    final message = DirectMessage(
      id: 'server-${stored.length}',
      body: body,
      senderId: 'ada',
      createdAt: DateTime(2026),
      linkCardRaw: linkCard,
    );
    stored.add(message);
    return message;
  }

  @override
  Future<void> markRead(String id) async {}
}

class _Keys extends KeysRepository {
  _Keys(this.published) : super(ApiClient()..dio.interceptors.clear());

  final List<PublishedKey> published;

  @override
  Future<List<PublishedKey>> forConversation(String conversationId) async =>
      published;

  @override
  Future<void> publish(String publicKey, String deviceId) async {}
}

class _Device {
  _Device(this.user, this.pair);
  final String user;
  final SimpleKeyPair pair;

  Future<PublishedKey> published() async => PublishedKey(
        userId: user,
        deviceId: '$user-${pair.hashCode}',
        publicKey: MessageCrypto.encodePublicKey(await pair.extractPublicKey()),
      );

  MessageVault vault(_Keys keys) => MessageVault(keys)..adopt(pair);
}

Future<_Device> _device(String user) async =>
    _Device(user, await MessageCrypto().newKeyPair());

/// Serves fixed pages, and remembers every request.
class _Pages implements HttpClientAdapter {
  _Pages(this.seen, this.pages);
  final List<RequestOptions> seen;
  final Map<String, (String, List<int>)> pages;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    seen.add(options);
    final page = pages[options.uri.toString()];
    if (page == null) {
      return ResponseBody.fromString('', 404);
    }
    return ResponseBody.fromBytes(
      page.$2,
      200,
      headers: {
        Headers.contentTypeHeader: [page.$1],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// A [width] by [height] PNG with something in it.
Future<Uint8List> _png(int width, int height) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  canvas.drawRect(
    ui.Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    ui.Paint()
      ..shader = ui.Gradient.linear(
        ui.Offset.zero,
        ui.Offset(width.toDouble(), height.toDouble()),
        [const Color(0xff1d4ed8), const Color(0xfff59e0b)],
      ),
  );
  final image = await recorder.endRecording().toImage(width, height);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  return data!.buffer.asUint8List();
}
