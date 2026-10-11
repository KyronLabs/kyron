import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:kyron_app/models/conversation.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/providers/messages_provider.dart';
import 'package:kyron_app/repositories/keys_repository.dart';
import 'package:kyron_app/repositories/messages_repository.dart';
import 'package:kyron_app/screens/thread_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/message_crypto.dart';
import 'package:kyron_app/services/message_vault.dart';
import 'package:kyron_app/utils/emoji_only.dart';
import 'package:kyron_app/widgets/media_grid.dart';
import 'package:kyron_app/widgets/overlap_stack.dart';

/// The chat screen, driven the way somebody uses it: big emoji, pulling a
/// message across to answer it, the wave that opens an empty conversation,
/// and how a thread is laid out -- turns, times, receipts, and what it says
/// about encryption.
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
    expect(send().onPressed, isNull);

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

    final grid = tester.widget<MediaGrid>(find.byType(MediaGrid));
    expect(grid.maxTiles, 3);
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
}
