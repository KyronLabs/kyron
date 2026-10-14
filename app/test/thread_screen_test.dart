import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:kyron_app/models/conversation.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/providers/presence_provider.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/providers/messages_provider.dart';
import 'package:kyron_app/providers/preferences_provider.dart';
import 'package:kyron_app/repositories/keys_repository.dart';
import 'package:kyron_app/repositories/messages_repository.dart';
import 'package:kyron_app/screens/thread_screen.dart';
import 'package:kyron_app/screens/chat_wallpaper_screen.dart';
import 'package:kyron_app/screens/conversation_info_screen.dart';
import 'package:kyron_app/models/chat_wallpaper.dart';
import 'package:kyron_app/providers/chat_wallpaper_provider.dart';
import 'package:kyron_app/widgets/chat_wallpaper_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/message_crypto.dart';
import 'package:kyron_app/services/message_vault.dart';
import 'package:kyron_app/services/link_card_reader.dart';
import 'package:kyron_app/models/message_link_card.dart';
import 'package:kyron_app/utils/emoji_only.dart';
import 'package:kyron_app/widgets/media_grid.dart';
import 'package:kyron_app/widgets/overlap_stack.dart';

/// The chat screen, driven the way somebody uses it: big emoji, pulling a
/// message across to answer it, the wave that opens an empty conversation,
/// and how a thread is laid out -- turns, times, receipts, and what it says
/// about encryption.
class _Repo extends MessagesRepository {
  _Repo(
    this.thread, {
    this.lastReadAt,
    this.people = const [MessagePerson(id: 'them', name: 'Ada')],
  }) : super(ApiClient()..dio.interceptors.clear());

  /// Newest first, the way the server sends a page.
  final List<DirectMessage> thread;
  final DateTime? lastReadAt;

  /// Everybody else in it. Empty once they have deleted their account.
  final List<MessagePerson> people;

  final List<String> bodies = [];
  final List<String?> repliedTo = [];
  final List<List<PendingMedia>> sentMedia = [];
  final List<String?> cards = [];
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
        people: people,
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
    String? linkCard,
  }) async {
    bodies.add(body);
    repliedTo.add(replyToId);
    sentMedia.add(media);
    cards.add(linkCard);
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

  final List<String> hidden = [];

  @override
  Future<void> hide(String conversationId) async => hidden.add(conversationId);

  @override
  Future<void> setMuted(String conversationId, bool muted) async {}

  @override
  Future<SharedMediaPage> sharedMedia(
    String conversationId, {
    String? cursor,
    int limit = 30,
  }) async =>
      const SharedMediaPage(items: []);

  @override
  Future<List<RemoteWallpaper>> wallpapers() async => const [
        RemoteWallpaper(
          id: '01-quiet-dunes.jpg',
          url: 'https://cdn.invalid/wallpapers/01-quiet-dunes.jpg',
        ),
      ];
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
  LinkCardReader? reader,
  List<MessagePerson>? people,
}) async {
  final repo = people == null
      ? _Repo(thread, lastReadAt: lastReadAt)
      : _Repo(thread, lastReadAt: lastReadAt, people: people);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        // Never the network: a link typed in a test reads no page.
        linkCardReaderProvider.overrideWithValue(reader ?? _NoPages()),
        currentUserProvider.overrideWith((ref) => _Me(ref)),
        threadProvider.overrideWith(
          (ref, id) => ThreadNotifier(
            repo,
            MessageVault(KeysRepository(ApiClient())),
            id,
          ),
        ),
        messagesRepositoryProvider.overrideWithValue(repo),
      ],
      child: const MaterialApp(
        home: ThreadScreen(args: ThreadArgs(conversationId: 'c1')),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

/// Reads the stored preferences in, as the app's root does at launch.
Future<void> _loadPreferences(WidgetTester tester) async {
  ProviderScope.containerOf(tester.element(find.byType(ThreadScreen)))
      .read(preferencesProvider);
  await tester.pumpAndSettle();
}

class _NoPages extends LinkCardReader {
  @override
  Future<MessageLinkCard?> read(String url) async => null;
}

/// Answers every link with the same card.
class _OnePage extends LinkCardReader {
  _OnePage(this.card);
  final MessageLinkCard card;
  final List<String> asked = [];

  @override
  Future<MessageLinkCard?> read(String url) async {
    asked.add(url);
    return MessageLinkCard(
      url: url,
      title: card.title,
      siteName: card.siteName,
      image: card.image,
    );
  }
}

/// A message sealed for a device that is not this one. The vault in these
/// tests has no key, so it cannot be opened -- which is the case being drawn.
final _sealedForSomebodyElse = SealedMessage(
  nonce: List.filled(24, 1),
  body: const [1, 2, 3],
  mac: List.filled(16, 2),
).encode();

List<PostMedia> _photos(int count) => [
      for (var i = 0; i < count; i++)
        PostMedia(
          id: 'p$i',
          kind: MediaKind.image,
          url: 'https://example.invalid/$i.jpg',
          width: 800,
          height: 600,
        ),
    ];

double? _fontSizeOf(WidgetTester tester, String text) =>
    tester.widget<Text>(find.text(text)).style?.fontSize;

void main() {
  // The vault reads this device's key from secure storage when nothing has
  // unlocked it. An empty store is a phone with no key yet -- which is what
  // these screens are drawn against -- and without one the read goes to a
  // platform channel no test has.
  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    // Fresh preferences for every test: one that turns link previews off
    // must not leave them off for the next.
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('the header says when the other person has the app open', (
    tester,
  ) async {
    await _open(tester, const []);
    expect(find.byKey(const ValueKey('thread-online')), findsNothing);

    ProviderScope.containerOf(tester.element(find.byType(ThreadScreen)))
        .read(presenceProvider.notifier)
        .snapshot(['them']);
    await tester.pump();

    expect(find.byKey(const ValueKey('thread-online')), findsOneWidget);
    expect(find.text('Online'), findsOneWidget);
    expect(find.byKey(const ValueKey('online-them')), findsOneWidget);
  });

  testWidgets('a conversation whose other side deleted their account says so',
      (tester) async {
    // The deletion takes their membership and their messages; the reader's
    // stay, and there is nobody left to send anything to.
    await _open(
      tester,
      [_msg('m1', 'still here', 'me', DateTime(2026, 1, 1, 9))],
      people: const [],
    );

    expect(find.text('Deleted account'), findsOneWidget);
    expect(find.byKey(const ValueKey('thread-gone')), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
    expect(find.text('still here'), findsOneWidget);
  });

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

  testWidgets('Send waits for something to send, and there is no heart',
      (tester) async {
    final repo = await _open(tester, [
      _msg('m1', 'made it home', 'them', DateTime(2026, 1, 1, 9)),
    ]);

    IconButton send() => tester.widget<IconButton>(
          find.ancestor(
            of: find.byIcon(Iconsax.send_1),
            matching: find.byType(IconButton),
          ),
        );

    expect(find.byIcon(Iconsax.heart), findsNothing);
    // Nothing to send, so the place Send goes holds the microphone.
    expect(find.byIcon(Iconsax.send_1), findsNothing);
    expect(find.byKey(const ValueKey('composer-voice')), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'same');
    await tester.pump();
    expect(send().onPressed, isNotNull);
    await tester.tap(find.byIcon(Iconsax.send_1));
    await tester.pumpAndSettle();

    expect(repo.bodies, ['same']);
  });

  testWidgets('the box is one line tall until there is more to say',
      (tester) async {
    await _open(tester, [
      _msg('m1', 'made it home', 'them', DateTime(2026, 1, 1, 9)),
    ]);

    // It was a filled field a full control high, inside a bar of its own.
    expect(
        tester.getSize(find.byType(TextField)).height, lessThanOrEqualTo(44));
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.decoration?.focusedBorder, InputBorder.none);
  });

  testWidgets('the time is said once above a turn, not under every message',
      (tester) async {
    await _open(tester, [
      _msg('m4', 'back now', 'them', DateTime(2026, 1, 1, 9, 30)),
      _msg('m3', 'third', 'them', DateTime(2026, 1, 1, 9, 5)),
      _msg('m2', 'second', 'them', DateTime(2026, 1, 1, 9, 2)),
      _msg('m1', 'first', 'them', DateTime(2026, 1, 1, 9)),
    ]);

    // Matched without the "AM": the platform's date data puts a narrow
    // no-break space before it.
    expect(find.textContaining('9:00'), findsOneWidget);
    expect(find.textContaining('9:02'), findsNothing);
    expect(find.textContaining('9:05'), findsNothing);
    // After a pause, the time again.
    expect(find.textContaining('9:30'), findsOneWidget);
    expect(
      tester.getTopLeft(find.textContaining('9:30')).dy,
      lessThan(tester.getTopLeft(find.text('back now')).dy),
    );
  });

  testWidgets('a turn tucks its corners in where its messages meet',
      (tester) async {
    await _open(tester, [
      _msg('m4', 'on its own', 'me', DateTime(2026, 1, 1, 9, 2)),
      _msg('m3', 'third', 'them', DateTime(2026, 1, 1, 9, 1)),
      _msg('m2', 'second', 'them', DateTime(2026, 1, 1, 9, 0, 30)),
      _msg('m1', 'first', 'them', DateTime(2026, 1, 1, 9)),
    ]);

    BorderRadius corners(String text) {
      final box = tester.widget<Container>(
        find
            .ancestor(of: find.text(text), matching: find.byType(Container))
            .first,
      );
      return (box.decoration! as BoxDecoration).borderRadius! as BorderRadius;
    }

    const round = Radius.circular(RadiusTokens.radius20);
    const tucked = Radius.circular(RadiusTokens.radius4);

    // Theirs hang from the left: the left corners tuck where two meet.
    expect(corners('first').topLeft, round);
    expect(corners('first').bottomLeft, tucked);
    expect(corners('second').topLeft, tucked);
    expect(corners('second').bottomLeft, tucked);
    expect(corners('third').topLeft, tucked);
    expect(corners('third').bottomLeft, round);
    // The right side never tucks.
    expect(corners('second').topRight, round);
    // One message on its own is round all round.
    final single = corners('on its own');
    expect(
      [single.topLeft, single.topRight, single.bottomLeft, single.bottomRight],
      everyElement(round),
    );
  });

  testWidgets('"Seen" sits under your newest message, once', (tester) async {
    await _open(tester, [
      DirectMessage(
        id: 'm2',
        body: 'and you?',
        senderId: 'me',
        createdAt: DateTime(2026, 1, 1, 9, 1),
        seen: true,
      ),
      DirectMessage(
        id: 'm1',
        body: 'home',
        senderId: 'me',
        createdAt: DateTime(2026, 1, 1, 9),
        seen: true,
      ),
    ]);

    expect(find.text('Seen'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('Seen')).dy,
      greaterThan(tester.getTopLeft(find.text('and you?')).dy),
    );
  });

  testWidgets('and not at all once the other person has answered',
      (tester) async {
    await _open(tester, [
      _msg('m2', 'yes', 'them', DateTime(2026, 1, 1, 9, 1)),
      DirectMessage(
        id: 'm1',
        body: 'home?',
        senderId: 'me',
        createdAt: DateTime(2026, 1, 1, 9),
        seen: true,
      ),
    ]);

    expect(find.text('Seen'), findsNothing);
    expect(find.text('Sent'), findsNothing);
  });

  testWidgets('a message that cannot be opened says so, in italics',
      (tester) async {
    await _open(tester, [
      _msg('m1', _sealedForSomebodyElse, 'them', DateTime(2026, 1, 1, 9)),
    ]);

    const said = 'This message cannot be read on this device.';
    expect(find.text(said), findsOneWidget);
    expect(tester.widget<Text>(find.text(said)).style?.fontStyle,
        FontStyle.italic);
    expect(find.textContaining('k1.'), findsNothing);
  });

  testWidgets('encryption is announced where it starts, and lapses marked',
      (tester) async {
    await _open(tester, [
      _msg('m2', 'sent as written', 'them', DateTime(2026, 1, 1, 9, 2)),
      _msg('m1', _sealedForSomebodyElse, 'them', DateTime(2026, 1, 1, 9, 1)),
      _msg('m0', 'from before keys', 'them', DateTime(2026, 1, 1, 9)),
    ]);

    const notice = 'Messages are end-to-end encrypted';
    expect(find.text(notice), findsOneWidget);
    // Between the history from before and the first sealed message.
    expect(
      tester.getTopLeft(find.text(notice)).dy,
      greaterThan(tester.getTopLeft(find.text('from before keys')).dy),
    );
    expect(
      tester.getTopLeft(find.text(notice)).dy,
      lessThan(
        tester
            .getTopLeft(
              find.text('This message cannot be read on this device.'),
            )
            .dy,
      ),
    );
    // Only the plain message after that point is marked; the history from
    // before is plain throughout, and marking all of it would be noise.
    expect(find.byIcon(Iconsax.unlock_copy), findsOneWidget);
    expect(
      find.bySemanticsLabel(RegExp('Not end-to-end encrypted')),
      findsOneWidget,
    );
    expect(
      tester.getCenter(find.byIcon(Iconsax.unlock_copy)).dy,
      greaterThan(tester.getTopLeft(find.text('sent as written')).dy),
    );
  });

  testWidgets('photos sit outside the bubble, three at most with a count',
      (tester) async {
    await _open(tester, [
      DirectMessage(
        id: 'm1',
        body: 'from last night',
        senderId: 'me',
        createdAt: DateTime(2026, 1, 1, 9),
        media: _photos(4),
      ),
    ]);

    expect(find.text('+1'), findsOneWidget);
    // Not inside the coloured bubble: that drew a frame of it round every
    // photo. The words still have their bubble, under the pictures.
    final scheme = Theme.of(tester.element(find.byType(MediaGrid))).colorScheme;
    final frames = find.ancestor(
      of: find.byType(MediaGrid),
      matching: find.byWidgetPredicate(
        (w) =>
            w is Container &&
            w.decoration is BoxDecoration &&
            (w.decoration! as BoxDecoration).color == scheme.primary,
      ),
    );
    expect(frames, findsNothing);
    expect(
      tester.getTopLeft(find.text('from last night')).dy,
      greaterThan(tester.getBottomLeft(find.byType(MediaGrid)).dy),
    );
  });

  testWidgets('a photo with no words is not marked as a lapse', (tester) async {
    // There is nothing in it to seal. Marking it put a lock beside every
    // photo in an otherwise sealed conversation.
    await _open(tester, [
      DirectMessage(
        id: 'm2',
        body: '',
        senderId: 'them',
        createdAt: DateTime(2026, 1, 1, 9, 1),
        media: _photos(1),
      ),
      _msg('m1', _sealedForSomebodyElse, 'them', DateTime(2026, 1, 1, 9)),
    ]);

    expect(find.text('Messages are end-to-end encrypted'), findsOneWidget);
    expect(find.byIcon(Iconsax.unlock_copy), findsNothing);
  });

  testWidgets('the + sheet offers the camera', (tester) async {
    await _open(tester, [
      _msg('m1', 'made it home', 'them', DateTime(2026, 1, 1, 9)),
    ]);

    await tester.tap(find.byIcon(Iconsax.add_circle_copy));
    await tester.pumpAndSettle();

    expect(find.text('Take a photo'), findsOneWidget);
    expect(find.byIcon(Iconsax.camera_copy), findsOneWidget);
  });

  testWidgets('and says nothing about it in a conversation that never was',
      (tester) async {
    await _open(tester, [
      _msg('m2', 'hello', 'them', DateTime(2026, 1, 1, 9, 1)),
      _msg('m1', 'hi', 'me', DateTime(2026, 1, 1, 9)),
    ]);

    expect(find.text('Messages are end-to-end encrypted'), findsNothing);
    expect(find.byIcon(Iconsax.unlock_copy), findsNothing);
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

  testWidgets('a tap on a quote goes to the message and points it out',
      (tester) async {
    // A long thread: the message being answered is far above the screen,
    // and its row has not even been built.
    final thread = <DirectMessage>[
      _msg(
        'last',
        'about that',
        'me',
        DateTime(2026, 1, 3, 9),
        replyToId: 'first',
      ),
      for (var i = 58; i >= 1; i--)
        _msg('m$i', 'message number $i', i.isEven ? 'me' : 'them',
            DateTime(2026, 1, 2, 9, i)),
      _msg('first', 'the very first thing', 'them', DateTime(2026, 1, 1, 9)),
    ];
    await _open(tester, thread);

    // Opened at the newest, so the first message is nowhere on screen: the
    // only place its words appear is the quote of it.
    expect(find.text('the very first thing'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('quote-last')));
    for (var i = 0; i < 40; i++) {
      await tester.pump(const Duration(milliseconds: 50));
      if (find.byKey(const ValueKey('pulsing-first')).evaluate().isNotEmpty) {
        break;
      }
    }

    // There, on screen, and being pointed out.
    expect(find.byKey(const ValueKey('pulsing-first')), findsOneWidget);
    expect(
      find
          .descendant(
            of: find.byKey(const ValueKey('pulsing-first')),
            matching: find.text('the very first thing'),
          )
          .hitTestable(),
      findsOneWidget,
    );

    // And then it settles back to an ordinary bubble.
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('pulsing-first')), findsNothing);
  });

  testWidgets('a quote of a message that is gone says so', (tester) async {
    await _open(tester, [
      _msg('r', 'replying', 'me', DateTime(2026, 1, 3), replyToId: 'deleted'),
    ]);

    await tester.tap(find.byKey(const ValueKey('quote-r')));
    await tester.pump();

    expect(find.text('That message is no longer here.'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });

  group("the conversation's details", () {
    Future<_Repo> details(WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      // A phone, so the pages are laid out the size they are used at.
      tester.view.physicalSize = const Size(1170, 2532);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      final repo = await _open(tester, [
        _msg('m1', 'made it home', 'them', DateTime(2026, 1, 1, 9)),
      ]);
      await tester.tap(find.byTooltip('Details'));
      await tester.pumpAndSettle();
      return repo;
    }

    testWidgets('the header menu opens them, with the person and actions',
        (tester) async {
      await details(tester);

      expect(find.byType(ConversationInfoScreen), findsOneWidget);
      expect(find.text('Ada'), findsWidgets);
      expect(find.text('Mute notifications'), findsOneWidget);
      expect(find.text('Wallpaper'), findsWidgets);
    });

    testWidgets('a wallpaper chosen there is drawn behind the thread',
        (tester) async {
      await details(tester);

      await tester.tap(find.text('Wallpaper').last);
      await tester.pumpAndSettle();
      expect(find.byType(ChatWallpaperScreen), findsOneWidget);
      // The built-in ones, and the folder's, by the names they are given.
      expect(find.text('Dusk'), findsOneWidget);
      await tester.scrollUntilVisible(find.text('Quiet dunes'), 300);
      expect(find.text('Quiet dunes'), findsOneWidget);
      await tester.scrollUntilVisible(find.text('Dusk'), -300);

      // A tap previews; nothing changes until Apply.
      TextButton apply() => tester.widget<TextButton>(
            find.byKey(const ValueKey('wallpaper-apply')),
          );
      expect(apply().onPressed, isNull);
      await tester.tap(find.text('Dusk'));
      await tester.pumpAndSettle();
      final prefsBefore = await SharedPreferences.getInstance();
      expect(prefsBefore.getString(ChatWallpaperNotifier.keyFor('c1')), isNull);
      expect(apply().onPressed, isNotNull);

      await tester.tap(find.byKey(const ValueKey('wallpaper-apply')));
      await tester.pumpAndSettle();
      // Apply goes back to the details page; back again to the thread.
      expect(find.byType(ChatWallpaperScreen), findsNothing);
      await tester.pageBack();
      await tester.pumpAndSettle();

      final drawn = tester.widget<ChatWallpaperView>(
        find.descendant(
          of: find.byType(ThreadScreen),
          matching: find.byType(ChatWallpaperView),
        ),
      );
      expect(drawn.wallpaper.builtIn, BuiltInWallpaper.dusk);

      // And it is this phone's choice for this conversation, kept.
      final prefs = await SharedPreferences.getInstance();
      expect(
        prefs.getString(ChatWallpaperNotifier.keyFor('c1')),
        'builtin:dusk',
      );
    });

    testWidgets('removing the conversation there closes the thread too',
        (tester) async {
      final repo = await details(tester);

      await tester.scrollUntilVisible(
        find.byIcon(Iconsax.trash_copy),
        200,
        scrollable: find
            .descendant(
              of: find.byType(ConversationInfoScreen),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.tap(find.byIcon(Iconsax.trash_copy));
      await tester.pumpAndSettle();
      // The dialog's confirming button: the second of its two.
      await tester.tap(
        find
            .descendant(
              of: find.byType(AlertDialog),
              matching: find.byType(TextButton),
            )
            .last,
      );
      await tester.pumpAndSettle();

      expect(repo.hidden, ['c1']);
      expect(find.byType(ConversationInfoScreen), findsNothing);
      expect(find.byType(ThreadScreen), findsNothing);
    });
  });

  group('message settings, in a chat', () {
    testWidgets('with "typing" off, nothing says the reader is typing', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({'pref_dm_typing': false});
      final repo = await _open(tester, const []);
      await _loadPreferences(tester);

      await tester.enterText(find.byType(TextField), 'hello');
      await tester.pump();

      expect(repo.typingSent, 0);
    });

    testWidgets('with link previews off, no page is read', (tester) async {
      SharedPreferences.setMockInitialValues({'pref_dm_link_previews': false});
      final reader = _OnePage(
        const MessageLinkCard(url: 'https://example.com/a', title: 'A'),
      );
      final repo = await _open(tester, const [], reader: reader);
      await _loadPreferences(tester);

      await tester.enterText(
        find.byType(TextField),
        'look https://example.com/a',
      );
      await tester.pump(const Duration(milliseconds: 700));
      await tester.tap(find.byIcon(Iconsax.send_1));
      await tester.pumpAndSettle();

      expect(reader.asked, isEmpty);
      expect(repo.cards.single, isNull);
    });
  });

  group('a long-pressed message', () {
    testWidgets('floats where it was, reactions above and options below', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1170, 2532);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      await _open(tester, [
        _msg('m1', 'made it home', 'them', DateTime(2026, 1, 1, 9)),
      ]);
      final before = tester.getRect(find.text('made it home'));

      await tester.longPress(find.text('made it home'));
      await tester.pumpAndSettle();

      // The page behind is blurred, and a tap on it is caught there.
      expect(
        find.byKey(const ValueKey('message-focus-backdrop')),
        findsOneWidget,
      );
      final lifted = find.descendant(
        of: find.byKey(const ValueKey('message-focus-message')),
        matching: find.text('made it home'),
      );
      expect(lifted, findsOneWidget);
      // Lifted in place, not moved somewhere else on the screen.
      expect(tester.getCenter(lifted).dy, closeTo(before.center.dy, 2));

      final reactions = tester.getRect(find.text('😂').last);
      final reply = tester.getRect(
        find.byKey(const ValueKey('message-focus-reply')),
      );
      expect(reactions.bottom, lessThanOrEqualTo(tester.getRect(lifted).top));
      expect(reply.top, greaterThanOrEqualTo(tester.getRect(lifted).bottom));
      // From the sender's side: their message, so the left.
      expect(reply.left, lessThan(200));
    });

    testWidgets('the copy is set exactly as the message is', (tester) async {
      // The overlay has no Material of its own. Without the page's text style
      // carried over, the copy's words took the framework's fallback --
      // another size, and on a phone a yellow underline -- and a long message
      // overflowed the space it had been measured into.
      const long = 'it took two trains and a bus, and the second train sat '
          'outside the station for forty minutes for no reason anyone gave';
      await _open(tester, [
        _msg('m1', long, 'them', DateTime(2026, 1, 1, 9)),
      ]);
      final before = tester.getSize(find.text(long));

      await tester.longPress(find.text(long));
      await tester.pumpAndSettle();

      final copy = find.descendant(
        of: find.byKey(const ValueKey('message-focus-message')),
        matching: find.text(long),
      );
      expect(tester.getSize(copy), before);
      final style = DefaultTextStyle.of(tester.element(copy)).style;
      expect(style.decoration, isNot(TextDecoration.underline));
    });

    testWidgets('the original is hidden while its copy floats', (
      tester,
    ) async {
      await _open(tester, [
        _msg('m1', 'made it home', 'them', DateTime(2026, 1, 1, 9)),
      ]);

      await tester.longPress(find.text('made it home'));
      await tester.pumpAndSettle();

      final hidden = tester.widgetList<Opacity>(
        find.ancestor(
          of: find.text('made it home').first,
          matching: find.byType(Opacity),
        ),
      );
      expect(hidden.any((o) => o.opacity == 0), isTrue);

      // A tap off it puts everything back, with nothing done.
      await tester.tapAt(const Offset(20, 120));
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('message-focus-backdrop')),
        findsNothing,
      );
      final shown = tester.widgetList<Opacity>(
        find.ancestor(
          of: find.text('made it home'),
          matching: find.byType(Opacity),
        ),
      );
      expect(shown.every((o) => o.opacity == 1), isTrue);
    });

    testWidgets('Reply from the menu answers that message', (tester) async {
      final repo = await _open(tester, [
        _msg('m1', 'made it home', 'them', DateTime(2026, 1, 1, 9)),
      ]);

      await tester.longPress(find.text('made it home'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('message-focus-reply')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'good');
      await tester.pump();
      await tester.tap(find.byIcon(Iconsax.send_1));
      await tester.pumpAndSettle();
      expect(repo.repliedTo, ['m1']);
    });

    testWidgets('a message at the bottom moves up to make room for its menu', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1170, 2532);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      await _open(tester, [
        // Newest first, as the server sends them: line 29 is at the bottom.
        for (var i = 29; i >= 0; i--)
          _msg('m$i', 'line $i', 'them', DateTime(2026, 1, 1, 9, i)),
      ]);

      await tester.longPress(find.text('line 29'));
      await tester.pumpAndSettle();

      // The last row of the menu is on the screen, and the message moved up
      // to make room for it rather than the menu going off the bottom.
      final screen = tester.view.physicalSize / tester.view.devicePixelRatio;
      final last = find.byKey(const ValueKey('message-focus-copy'));
      expect(tester.getRect(last).bottom, lessThan(screen.height));
      final lifted = find.descendant(
        of: find.byKey(const ValueKey('message-focus-message')),
        matching: find.text('line 29'),
      );
      expect(
        tester.getRect(lifted).bottom,
        lessThan(tester.getRect(last).top),
      );
    });
  });

  group('a link card', () {
    const page = MessageLinkCard(
      url: 'https://example.com/post',
      title: 'A post worth reading',
      siteName: 'Example',
    );

    testWidgets('is drawn in the bubble, above the words', (tester) async {
      const body = 'look https://example.com/post';
      await _open(tester, [
        DirectMessage(
          id: 'm1',
          body: body,
          senderId: 'them',
          createdAt: DateTime(2026),
          linkCardRaw: page.encode(),
        ),
      ]);

      final card = find.byKey(const ValueKey('link-card-m1'));
      expect(card, findsOneWidget);
      expect(find.text('A post worth reading'), findsOneWidget);
      expect(
        tester.getTopLeft(card).dy,
        lessThan(tester.getTopLeft(find.text(body)).dy),
      );
    });

    testWidgets('is made while the link is written, and sent with it', (
      tester,
    ) async {
      final reader = _OnePage(page);
      final repo = await _open(tester, const [], reader: reader);

      await tester.enterText(
        find.byType(TextField),
        'look https://example.com/post',
      );
      // Read once the typing settles, not on every character.
      await tester.pump(const Duration(milliseconds: 100));
      expect(reader.asked, isEmpty);
      await tester.pump(const Duration(milliseconds: 700));
      await tester.pump();
      expect(reader.asked, ['https://example.com/post']);
      expect(find.text('A post worth reading'), findsOneWidget);

      await tester.tap(find.byTooltip('Send'));
      await tester.pumpAndSettle();

      final sent = MessageLinkCard.tryDecode(
        repo.cards.single!,
        body: repo.bodies.single,
      );
      expect(sent?.title, 'A post worth reading');
    });

    testWidgets('pasted and sent at once, it still goes with its card', (
      tester,
    ) async {
      // Sending used to take only a card already made, and a link pasted and
      // sent straight away never waited out the pause in typing that starts
      // one -- so the way most links are sent carried no card at all.
      final repo = await _open(tester, const [], reader: _OnePage(page));

      await tester.enterText(
        find.byType(TextField),
        'look https://example.com/post',
      );
      await tester.pump();
      await tester.tap(find.byIcon(Iconsax.send_1));
      await tester.pumpAndSettle();

      final sent = MessageLinkCard.tryDecode(
        repo.cards.single!,
        body: repo.bodies.single,
      );
      expect(sent?.title, 'A post worth reading');
    });

    testWidgets('taken off, the message goes without it', (tester) async {
      final repo = await _open(tester, const [], reader: _OnePage(page));

      await tester.enterText(
        find.byType(TextField),
        'look https://example.com/post',
      );
      await tester.pump(const Duration(milliseconds: 700));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('link-draft-drop')));
      await tester.pump();
      expect(find.text('A post worth reading'), findsNothing);

      await tester.tap(find.byTooltip('Send'));
      await tester.pumpAndSettle();
      expect(repo.cards.single, isNull);
    });
  });

  group('a voice note', () {
    ThreadNotifier notifier(_Repo repo) => ThreadNotifier(
          repo,
          MessageVault(KeysRepository(ApiClient())),
          'c1',
        );

    const recording = PendingMedia(
      path: '/tmp/note.m4a',
      kind: MediaKind.voice,
      duration: Duration(seconds: 4),
      waveform: [10, 60, 30],
    );

    test('goes up, then is sent as its own message, answering', () async {
      final repo = _Repo(const []);
      final thread = notifier(repo);
      await Future<void>.delayed(Duration.zero);

      final uploaded = <String>[];
      await thread.sendVoice(
        recording,
        senderId: 'me',
        replyToId: 'm1',
        upload: (r) async {
          uploaded.add(r.path);
          return r.copyWith(url: 'https://cdn.invalid/note.m4a');
        },
      );

      expect(uploaded, ['/tmp/note.m4a']);
      expect(repo.bodies, ['']);
      expect(repo.repliedTo, ['m1']);
      expect(repo.sentMedia.single.single.url, 'https://cdn.invalid/note.m4a');
      expect(repo.sentMedia.single.single.isVoice, isTrue);
    });

    test('that failed is sent again as the recording, not as nothing',
        () async {
      final repo = _Repo(const []);
      final thread = notifier(repo);
      await Future<void>.delayed(Duration.zero);

      var attempts = 0;
      Future<PendingMedia> flaky(PendingMedia r) async {
        attempts++;
        if (attempts == 1) throw Exception('offline');
        return r.copyWith(url: 'https://cdn.invalid/note.m4a');
      }

      await thread.sendVoice(recording, senderId: 'me', upload: flaky);
      final failed = thread.state.messages.single;
      expect(failed.failed, isTrue);
      expect(repo.bodies, isEmpty);

      await thread.retry(failed);

      expect(attempts, 2);
      expect(repo.sentMedia.single.single.isVoice, isTrue);
      expect(thread.state.messages.where((m) => m.failed), isEmpty);
    });
  });
}
