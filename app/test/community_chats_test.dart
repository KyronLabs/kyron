import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/community.dart';
import 'package:kyron_app/models/community_chat.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/providers/community_chats_provider.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/providers/realtime_provider.dart';
import 'package:kyron_app/repositories/community_chats_repository.dart';
import 'package:kyron_app/repositories/moderation_repository.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/screens/community_chat_screen.dart';
import 'package:kyron_app/screens/community_chat_search_screen.dart';
import 'package:kyron_app/screens/community_chat_settings_screen.dart';
import 'package:kyron_app/screens/community_poll_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/push_tap.dart';
import 'package:kyron_app/services/realtime_client.dart';
import 'package:kyron_app/utils/media_basket.dart';
import 'package:kyron_app/widgets/community_chats_section.dart';
import 'package:kyron_app/widgets/media_grid.dart';
import 'package:kyron_app/widgets/voice_post_player.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Community chats on the screens that show them: reading as a spectator,
/// joining, what each role is offered, sending, and being shut out.

const _ben = ChatPerson(id: 'ben', name: 'Ben', role: CommunityRole.member);
const _owner = ChatPerson(id: 'own', name: 'Olu', role: CommunityRole.owner);

CommunityChat _chat({
  bool joined = true,
  bool canWrite = true,
  bool canModerate = false,
  CommunityRole myRole = CommunityRole.member,
  ChatWriters writers = ChatWriters.members,
  int slowMode = 0,
}) =>
    CommunityChat(
      id: 'chat-1',
      communityId: 'c1',
      communitySlug: 'birders',
      communityName: 'Birders',
      name: 'General',
      writers: writers,
      slowModeSeconds: slowMode,
      joinedCount: 12,
      joined: joined,
      canWrite: canWrite,
      canModerate: canModerate,
      myRole: myRole,
    );

CommunityChatMessage _msg(String id, ChatPerson by, String body) =>
    CommunityChatMessage(
      id: id,
      body: body,
      sender: by,
      createdAt: DateTime(2026, 10, 21, 9),
    );

class _Repo extends CommunityChatsRepository {
  _Repo(this.chat, {this.thread = const []})
      : super(ApiClient()..dio.interceptors.clear());

  CommunityChat chat;

  /// Newest first, as a page arrives.
  List<CommunityChatMessage> thread;
  Object? refuse;
  Object? sendFails;
  final List<String> sent = [];
  final List<(String, String?)> reacted = [];
  final List<String> deleted = [];
  int joins = 0;
  final List<(String, ChatWriters)> created = [];
  List<CommunityChat> listed = const [];
  int gets = 0;
  int pages = 0;

  @override
  Future<CommunityChat> get(String chatId) async {
    gets++;
    final r = refuse;
    if (r != null) throw r;
    return chat;
  }

  @override
  Future<({List<CommunityChatMessage> items, String? nextCursor})> messages(
    String chatId, {
    String? cursor,
    int limit = 40,
  }) async {
    pages++;
    return (items: thread, nextCursor: null);
  }

  @override
  Future<void> markRead(String chatId) async {}

  @override
  Future<CommunityChat> join(String chatId) async {
    joins++;
    return chat = _chat();
  }

  @override
  Future<CommunityChatMessage> send(
    String chatId,
    String body, {
    String? replyToId,
    List<ChatUpload> media = const [],
    ({List<String> options, bool multiple})? poll,
  }) async {
    final fail = sendFails;
    if (fail != null) throw fail;
    sent.add(body);
    sentMedia.add(media);
    sentPolls.add(poll);
    return _msg('sent-${sent.length}', const ChatPerson(id: 'me'), body);
  }

  final List<List<ChatUpload>> sentMedia = [];
  final List<({List<String> options, bool multiple})?> sentPolls = [];
  final List<String> uploaded = [];
  final List<(String, String)> edits = [];
  final List<(String, List<String>)> votes = [];
  final List<String> closedPolls = [];
  final List<bool> mutes = [];
  List<CommunityChatMessage> found = const [];
  final List<String> searched = [];
  Object? voteFails;

  @override
  Future<ChatUpload> upload(PendingMedia pending) async {
    uploaded.add(pending.path);
    return ChatUpload(
      ref: 'chat/me_${uploaded.length}.jpg',
      kind: pending.kind,
    );
  }

  @override
  Future<CommunityChatMessage> edit(
    String chatId,
    String messageId,
    String body,
  ) async {
    edits.add((messageId, body));
    final was = thread.firstWhere((m) => m.id == messageId);
    return was.copyWith(body: body, editedAt: DateTime(2026, 10, 21, 9, 1));
  }

  @override
  Future<CommunityChatMessage> vote(
    String chatId,
    String messageId,
    List<String> optionIds,
  ) async {
    final fail = voteFails;
    if (fail != null) throw fail;
    votes.add((messageId, optionIds));
    final was = thread.firstWhere((m) => m.id == messageId);
    return was.copyWith(poll: was.poll!.answering(optionIds));
  }

  @override
  Future<void> unvote(String chatId, String messageId) async =>
      votes.add((messageId, const []));

  @override
  Future<void> closePoll(String chatId, String messageId) async =>
      closedPolls.add(messageId);

  @override
  Future<void> setMuted(String chatId, bool muted) async => mutes.add(muted);

  @override
  Future<List<CommunityChatMessage>> search(String chatId, String query) async {
    searched.add(query);
    return found;
  }

  @override
  Future<void> react(String chatId, String messageId, String emoji) async =>
      reacted.add((messageId, emoji));

  @override
  Future<void> unreact(String chatId, String messageId) async =>
      reacted.add((messageId, null));

  @override
  Future<void> delete(String chatId, String messageId) async =>
      deleted.add(messageId);

  @override
  Future<List<CommunityChat>> list(String slug) async => listed;

  @override
  Future<CommunityChat> create(
    String slug, {
    required String name,
    String? description,
    ChatWriters writers = ChatWriters.members,
  }) async {
    created.add((name, writers));
    return _chat(canModerate: true, myRole: CommunityRole.moderator);
  }
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

List<Override> _overrides(_Repo repo) => [
      currentUserProvider.overrideWith((ref) => _Me(ref)),
      communityChatsRepositoryProvider.overrideWithValue(repo),
    ];

Future<void> _pump(WidgetTester tester, _Repo repo, Widget home) async {
  tester.view.physicalSize = const Size(1170, 2532);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: _overrides(repo),
      child: MaterialApp(theme: KyronTheme.lightTheme, home: home),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _open(WidgetTester tester, _Repo repo) =>
    _pump(tester, repo, const CommunityChatScreen(chatId: 'chat-1'));

DioException _status(int code) => DioException(
      requestOptions: RequestOptions(path: '/x'),
      response: Response(
          requestOptions: RequestOptions(path: '/x'), statusCode: code),
    );

void main() {
  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    SharedPreferences.setMockInitialValues({});
  });

  group('what the server sends, read', () {
    test('a chat, with the reader’s place in it', () {
      final chat = CommunityChat.fromJson({
        'id': 'x',
        'community': {'id': 'c', 'slug': 'birders', 'name': 'Birders'},
        'name': 'News',
        'writers': 'MODERATORS',
        'joinedCount': 3,
        'joined': true,
        'canWrite': false,
        'canModerate': false,
        'role': 'MEMBER',
        'slowModeSeconds': 30,
      });
      expect(chat.announcements, isTrue);
      expect(chat.myRole, CommunityRole.member);
      expect(chat.communitySlug, 'birders');
      expect(chat.slowModeSeconds, 30);
    });

    test('reactions move with the reader’s own', () {
      final m = CommunityChatMessage.fromJson({
        'id': 'm',
        'body': 'hi',
        'sender': {'id': 'ben', 'role': 'MODERATOR'},
        'reactions': [
          {'emoji': '❤️', 'count': 2},
        ],
        'mine': null,
        'createdAt': '2026-10-21T09:00:00Z',
      });
      expect(m.sender.role, CommunityRole.moderator);
      final liked = m.withMine('❤️');
      expect(liked.reactions.single.count, 3);
      final changed = liked.withMine('😂');
      expect(
        {for (final r in changed.reactions) r.emoji: r.count},
        {'❤️': 2, '😂': 1},
      );
      expect(changed.withMine(null).reactions.single.count, 2);
    });

    test('a community message is a target the app can report and review', () {
      expect(
        ReportTarget.fromWire('COMMUNITY_MESSAGE'),
        ReportTarget.communityMessage,
      );
    });
  });

  group('as it happens', () {
    /// Applies an event the way the realtime bridge does, with a real Ref.
    final apply = Provider<void Function(RealtimeEvent)>(
      (ref) => (event) => applyRealtimeEvent(ref, event),
    );

    ({ProviderContainer container, List<String> Function() ids}) opened(
      _Repo repo,
    ) {
      final container = ProviderContainer(overrides: _overrides(repo));
      addTearDown(container.dispose);
      final keep =
          container.listen(communityChatProvider('chat-1'), (_, __) {});
      addTearDown(keep.close);
      return (
        container: container,
        ids: () => [
              for (final m
                  in container.read(communityChatProvider('chat-1')).messages)
                m.id,
            ],
      );
    }

    test('leaves a chat nobody has open alone', () async {
      final repo = _Repo(_chat());
      final container = ProviderContainer(overrides: _overrides(repo));
      addTearDown(container.dispose);
      for (final type in [
        'community.chat.message',
        'community.chat.reaction',
        'community.chat.message.deleted',
        'community.chat.updated',
      ]) {
        container.read(apply)(
          RealtimeEvent(type, {'chatId': 'chat-1', 'messageId': 'm1'}),
        );
      }
      await pumpEventQueue();
      expect(repo.gets + repo.pages, 0, reason: 'nothing asked for');
      expect(container.exists(communityChatProvider('chat-1')), isFalse);
    });

    test('brings in what was said, and takes out what was taken down',
        () async {
      final repo = _Repo(
        _chat(),
        thread: [_msg('m2', _ben, 'two'), _msg('m1', _ben, 'one')],
      );
      final chat = opened(repo);
      await pumpEventQueue();
      expect(chat.ids(), ['m1', 'm2']);

      repo.thread = [_msg('m3', _ben, 'three'), ...repo.thread];
      chat.container.read(apply)(
        const RealtimeEvent(
          'community.chat.message',
          {'chatId': 'chat-1', 'messageId': 'm3'},
        ),
      );
      await pumpEventQueue();
      expect(chat.ids(), ['m1', 'm2', 'm3']);

      chat.container.read(apply)(
        const RealtimeEvent(
          'community.chat.message.deleted',
          {'chatId': 'chat-1', 'messageId': 'm1'},
        ),
      );
      expect(chat.ids(), ['m2', 'm3']);
    });

    test('keeps a takedown down when an older page lands after it', () async {
      final repo = _Repo(
        _chat(),
        thread: [_msg('m2', _owner, 'two'), _msg('m1', _ben, 'abuse')],
      );
      final chat = opened(repo);
      await pumpEventQueue();
      chat.container.read(apply)(
        const RealtimeEvent(
          'community.chat.message.deleted',
          {'chatId': 'chat-1', 'messageId': 'm1'},
        ),
      );
      // The server still had it when this page was read.
      await chat.container
          .read(communityChatProvider('chat-1').notifier)
          .pullNewest();
      expect(chat.ids(), ['m2']);
      await chat.container
          .read(communityChatProvider('chat-1').notifier)
          .refresh();
      expect(chat.ids(), ['m2']);
    });

    test('an update the reader may no longer see shuts the chat', () async {
      final repo = _Repo(_chat(), thread: [_msg('m1', _ben, 'one')]);
      final chat = opened(repo);
      await pumpEventQueue();
      repo.refuse = _status(403);
      chat.container.read(apply)(
        const RealtimeEvent('community.chat.updated', {'chatId': 'chat-1'}),
      );
      await pumpEventQueue();
      expect(
        chat.container.read(communityChatProvider('chat-1')).shut,
        isTrue,
      );
    });
  });

  group('a chat', () {
    testWidgets('says it is not end-to-end encrypted', (tester) async {
      await _open(tester, _Repo(_chat(), thread: [_msg('m1', _ben, 'hi')]));
      expect(find.byKey(const ValueKey('cchat-not-encrypted')), findsOneWidget);
      expect(
        find.textContaining('not end-to-end encrypted'),
        findsOneWidget,
      );
    });

    testWidgets('lets a spectator read, and join to write', (tester) async {
      final repo = _Repo(
        _chat(joined: false, canWrite: false),
        thread: [_msg('m1', _ben, 'Kingfisher!')],
      );
      await _open(tester, repo);

      expect(find.text('Kingfisher!'), findsOneWidget);
      expect(find.byKey(const ValueKey('cchat-box')), findsNothing);
      await tester.tap(find.byKey(const ValueKey('cchat-join')));
      await tester.pumpAndSettle();
      expect(repo.joins, 1);
      expect(find.byKey(const ValueKey('cchat-box')), findsOneWidget);
    });

    testWidgets('keeps an announcements chat to its moderators',
        (tester) async {
      await _open(
        tester,
        _Repo(_chat(canWrite: false, writers: ChatWriters.moderators)),
      );
      expect(find.byKey(const ValueKey('cchat-readonly')), findsOneWidget);
      expect(find.byKey(const ValueKey('cchat-box')), findsNothing);
    });

    testWidgets('sends, and says so when a message did not go', (tester) async {
      final repo = _Repo(_chat());
      await _open(tester, repo);

      await tester.enterText(find.byKey(const ValueKey('cchat-box')), 'Hello');
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('cchat-send')));
      await tester.pumpAndSettle();
      expect(repo.sent, ['Hello']);
      expect(find.text('Hello'), findsOneWidget);

      repo.sendFails = _status(429);
      await tester.enterText(find.byKey(const ValueKey('cchat-box')), 'Again');
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('cchat-send')));
      await tester.pumpAndSettle();
      expect(find.text('Again'), findsOneWidget);
      expect(find.textContaining('Not sent'), findsOneWidget);
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('shows the slow mode', (tester) async {
      await _open(tester, _Repo(_chat(slowMode: 30)));
      expect(
        find.text('Slow mode: one message every 30 seconds'),
        findsOneWidget,
      );
    });

    testWidgets('says plainly when the reader has been shut out',
        (tester) async {
      await _open(tester, _Repo(_chat())..refuse = _status(403));
      expect(find.text('You cannot see this chat any more.'), findsOneWidget);
      expect(find.byKey(const ValueKey('cchat-box')), findsNothing);
      expect(find.byKey(const ValueKey('cchat-spectator')), findsNothing);
    });

    testWidgets('a reaction pill is a toggle', (tester) async {
      final repo = _Repo(
        _chat(),
        thread: [
          CommunityChatMessage(
            id: 'm1',
            body: 'look',
            sender: _ben,
            createdAt: DateTime(2026, 10, 21, 9),
            reactions: const [(emoji: '❤️', count: 2)],
          ),
        ],
      );
      await _open(tester, repo);
      await tester.tap(find.text('❤️ 2'));
      await tester.pumpAndSettle();
      expect(repo.reacted, [('m1', '❤️')]);
      expect(find.text('❤️ 3'), findsOneWidget);
    });
  });

  group('what each role is offered on a message', () {
    Future<void> longPress(WidgetTester tester, String text) async {
      await tester.longPress(find.text(text));
      await tester.pumpAndSettle();
    }

    testWidgets('a member: report somebody else’s, never delete it', (
      tester,
    ) async {
      await _open(
          tester, _Repo(_chat(), thread: [_msg('m1', _ben, 'from ben')]));
      await longPress(tester, 'from ben');
      expect(find.text('Report'), findsOneWidget);
      expect(find.text('Delete'), findsNothing);
      expect(find.text('Pin to the top'), findsNothing);
    });

    testWidgets('a moderator: delete and pin a member’s, not the owner’s', (
      tester,
    ) async {
      final repo = _Repo(
        _chat(canModerate: true, myRole: CommunityRole.moderator),
        thread: [_msg('m2', _owner, 'from olu'), _msg('m1', _ben, 'from ben')],
      );
      await _open(tester, repo);

      await longPress(tester, 'from ben');
      expect(find.text('Delete'), findsOneWidget);
      expect(find.text('Pin to the top'), findsOneWidget);
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      await longPress(tester, 'from olu');
      expect(find.text('Delete'), findsNothing);
    });

    testWidgets('the owner: delete anybody’s', (tester) async {
      final repo = _Repo(
        _chat(canModerate: true, myRole: CommunityRole.owner),
        thread: [
          _msg(
            'm1',
            const ChatPerson(
                id: 'mod', name: 'Mo', role: CommunityRole.moderator),
            'from a moderator',
          ),
        ],
      );
      await _open(tester, repo);
      await longPress(tester, 'from a moderator');
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Remove'));
      await tester.pumpAndSettle();
      expect(repo.deleted, ['m1']);
    });
  });

  group('a community’s page', () {
    Community community({required bool joined, CommunityRole? role}) =>
        Community(
          id: 'c1',
          slug: 'birders',
          name: 'Birders',
          members: 40,
          posts: 3,
          joined: joined,
          role: role,
        );

    Widget section(Community c) => Scaffold(
        body:
            SingleChildScrollView(child: CommunityChatsSection(community: c)));

    testWidgets('asks somebody outside to join, and does not fetch', (
      tester,
    ) async {
      final repo = _Repo(_chat())..listed = [_chat()];
      await _pump(tester, repo, section(community(joined: false)));
      expect(find.textContaining('Join the community'), findsOneWidget);
      expect(find.text('General'), findsNothing);
    });

    testWidgets('lists the chats for a member', (tester) async {
      // One with unread messages: its badge once took the whole row.
      final repo = _Repo(_chat())
        ..listed = [
          _chat(),
          const CommunityChat(
            id: 'chat-2',
            communityId: 'c1',
            communitySlug: 'birders',
            communityName: 'Birders',
            name: 'News',
            unread: 3,
            joined: true,
          ),
        ];
      await _pump(
        tester,
        repo,
        section(community(joined: true, role: CommunityRole.member)),
      );
      expect(find.text('General'), findsOneWidget);
      expect(find.text('12 joined'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.byKey(const ValueKey('cchat-new')), findsNothing);
    });

    testWidgets('lets a moderator open a new one', (tester) async {
      final repo = _Repo(_chat())..listed = const [];
      await _pump(
        tester,
        repo,
        section(community(joined: true, role: CommunityRole.moderator)),
      );
      await tester.tap(find.byKey(const ValueKey('cchat-new')));
      await tester.pumpAndSettle();
      expect(find.byType(CommunityChatSettingsScreen), findsOneWidget);
      await tester.enterText(
        find.byKey(const ValueKey('cchat-name')),
        'Announcements',
      );
      await tester.tap(find.byKey(const ValueKey('cchat-announcements')));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('cchat-save')));
      await tester.pumpAndSettle();
      final (name, writers) = repo.created.single;
      expect(name, 'Announcements');
      expect(writers, ChatWriters.moderators);
      // And straight into it.
      expect(find.byType(CommunityChatScreen), findsOneWidget);
    });
  });

  group('more than words', () {
    final soon = DateTime.now().add(const Duration(minutes: 10));

    CommunityChatMessage mine(String id, String body) => CommunityChatMessage(
          id: id,
          body: body,
          sender: const ChatPerson(id: 'me', name: 'Me'),
          createdAt: DateTime(2026, 10, 21, 9),
          editableUntil: soon,
        );

    CommunityChatMessage poll(
      String id, {
      ChatPerson by = _ben,
      List<String> mineChosen = const [],
      bool multiple = false,
      bool closed = false,
    }) =>
        CommunityChatMessage(
          id: id,
          body: 'Saturday or Sunday?',
          sender: by,
          createdAt: DateTime(2026, 10, 21, 9),
          poll: ChatPoll(
            id: 'p-$id',
            multiple: multiple,
            closed: closed,
            voters: mineChosen.isEmpty ? 3 : 4,
            mine: mineChosen,
            options: [
              ChatPollOption(
                id: 'sat',
                text: 'Saturday',
                votes: mineChosen.contains('sat') ? 3 : 2,
              ),
              ChatPollOption(
                id: 'sun',
                text: 'Sunday',
                votes: mineChosen.contains('sun') ? 2 : 1,
              ),
            ],
          ),
        );

    test('reads mute, edits, media and polls off the wire', () {
      final chat = CommunityChat.fromJson({
        'id': 'k',
        'community': {'id': 'c', 'slug': 'birders', 'name': 'Birders'},
        'name': 'General',
        'muted': true,
        'lastMessage': {
          'senderName': 'Ada',
          'body': '',
          'mine': false,
          'media': 'VOICE',
          'poll': false,
        },
      });
      expect(chat.muted, isTrue);
      expect(chat.lastMessage?.media, MediaKind.voice);

      final m = CommunityChatMessage.fromJson({
        'id': 'm',
        'body': 'look',
        'sender': {'id': 'ben'},
        'editedAt': '2026-10-21T09:05:00Z',
        'editableUntil': '2026-10-21T09:15:00Z',
        'media': [
          {'id': 'x', 'kind': 'IMAGE', 'url': 'https://signed.test/a'},
        ],
        'poll': {
          'id': 'p',
          'multiple': true,
          'closed': false,
          'voters': 2,
          'mine': ['o1'],
          'options': [
            {'id': 'o1', 'text': 'Yes', 'votes': 2},
          ],
        },
        'createdAt': '2026-10-21T09:00:00Z',
      });
      expect(m.edited, isTrue);
      expect(m.media.single.kind, MediaKind.image);
      expect(m.poll?.multiple, isTrue);
      expect(m.poll?.mine, ['o1']);
      // A poll is never edited, whatever the window says.
      expect(m.editableAt(DateTime.utc(2026, 10, 21, 9, 10)), isFalse);
    });

    test('a changed answer moves its count, not anybody else’s', () {
      final asked = poll('q', mineChosen: const ['sat']).poll!;
      final changed = asked.answering(const ['sun']);
      expect(changed.options.map((o) => o.votes), [2, 2]);
      expect(changed.voters, asked.voters);
      final takenBack = changed.answering(const []);
      expect(takenBack.options.map((o) => o.votes), [2, 1]);
      expect(takenBack.voters, asked.voters - 1);
    });

    testWidgets('edits the reader’s own message, and says it was', (
      tester,
    ) async {
      final repo = _Repo(_chat(), thread: [mine('m1', 'teh plan')]);
      await _open(tester, repo);
      await tester.longPress(find.text('teh plan'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('cchat-editing')), findsOneWidget);

      await tester.enterText(
        find.byKey(const ValueKey('cchat-box')),
        'the plan',
      );
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('cchat-send')));
      await tester.pumpAndSettle();
      expect(repo.edits, [('m1', 'the plan')]);
      expect(find.textContaining('the plan'), findsOneWidget);
      expect(find.textContaining('edited'), findsOneWidget);
      expect(find.byKey(const ValueKey('cchat-editing')), findsNothing);
    });

    testWidgets('offers no edit once the window has passed', (tester) async {
      final late = CommunityChatMessage(
        id: 'm1',
        body: 'long ago',
        sender: const ChatPerson(id: 'me', name: 'Me'),
        createdAt: DateTime(2026, 10, 21, 9),
        editableUntil: DateTime.now().subtract(const Duration(minutes: 1)),
      );
      await _open(tester, _Repo(_chat(), thread: [late]));
      await tester.longPress(find.text('long ago'));
      await tester.pumpAndSettle();
      expect(find.text('Edit'), findsNothing);
    });

    testWidgets('mutes from the menu, and unmutes', (tester) async {
      final repo = _Repo(_chat());
      await _open(tester, repo);
      await tester.tap(find.byKey(const ValueKey('cchat-more')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Mute'));
      await tester.pumpAndSettle();
      expect(repo.mutes, [true]);

      await tester.tap(find.byKey(const ValueKey('cchat-more')));
      await tester.pumpAndSettle();
      expect(find.text('Unmute'), findsOneWidget);
    });

    testWidgets('a poll: answered, its counts shown, and taken back', (
      tester,
    ) async {
      final repo = _Repo(_chat(), thread: [poll('q')]);
      await _open(tester, repo);
      // Not answered and not theirs: no counts yet, to sway nobody.
      expect(find.text('67%'), findsNothing);

      await tester.tap(find.text('Saturday'));
      await tester.pumpAndSettle();
      expect(repo.votes.single.$1, 'q');
      expect(repo.votes.single.$2, ['sat']);
      expect(find.text('75%'), findsOneWidget);
      expect(find.text('4 answered'), findsOneWidget);

      // The same answer again takes it back.
      await tester.tap(find.text('Saturday'));
      await tester.pumpAndSettle();
      expect(repo.votes.last.$2, isEmpty);
    });

    testWidgets('a poll answered and refused is put back as it was', (
      tester,
    ) async {
      final repo = _Repo(_chat(), thread: [poll('q')])
        ..voteFails = _status(403);
      await _open(tester, repo);
      await tester.tap(find.text('Saturday'));
      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.text('75%'), findsNothing);
    });

    testWidgets('closes a poll its asker asked', (tester) async {
      final repo = _Repo(
        _chat(),
        thread: [poll('q', by: const ChatPerson(id: 'me', name: 'Me'))],
      );
      await _open(tester, repo);
      await tester.longPress(find.text('Saturday or Sunday?'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Close poll'));
      await tester.pumpAndSettle();
      expect(repo.closedPolls, ['q']);
      expect(find.text('Closed'), findsOneWidget);
    });

    testWidgets('shows pictures in a grid and plays voice notes', (
      tester,
    ) async {
      final repo = _Repo(
        _chat(),
        thread: [
          CommunityChatMessage(
            id: 'v',
            body: '',
            sender: _ben,
            createdAt: DateTime(2026, 10, 21, 9, 1),
            media: const [
              PostMedia(
                id: 'n',
                kind: MediaKind.voice,
                url: 'https://signed.test/n.m4a',
                duration: Duration(seconds: 4),
              ),
            ],
          ),
          CommunityChatMessage(
            id: 'p',
            body: 'two kingfishers',
            sender: _ben,
            createdAt: DateTime(2026, 10, 21, 9),
            media: const [
              PostMedia(
                id: 'i',
                kind: MediaKind.image,
                url: 'https://signed.test/i.jpg',
              ),
            ],
          ),
        ],
      );
      await _open(tester, repo);
      expect(find.byType(MediaGrid), findsOneWidget);
      expect(find.byType(VoicePostPlayer), findsOneWidget);
      expect(find.text('two kingfishers'), findsOneWidget);
    });

    testWidgets('asks a poll written on its own screen', (tester) async {
      final repo = _Repo(_chat());
      await _open(tester, repo);
      await tester.tap(find.byKey(const ValueKey('cchat-attach')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('New poll'));
      await tester.pumpAndSettle();
      expect(find.byType(CommunityPollScreen), findsOneWidget);

      await tester.enterText(
        find.byKey(const ValueKey('poll-question')),
        'Saturday or Sunday?',
      );
      await tester.enterText(
        find.byKey(const ValueKey('poll-option-0')),
        'Saturday',
      );
      // The same answer twice is not a poll.
      await tester.enterText(
        find.byKey(const ValueKey('poll-option-1')),
        'saturday',
      );
      await tester.pump();
      expect(find.text('Each answer can be in a poll once.'), findsOneWidget);
      await tester.enterText(
        find.byKey(const ValueKey('poll-option-1')),
        'Sunday',
      );
      await tester.tap(find.byKey(const ValueKey('poll-multiple')));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('poll-send')));
      await tester.pumpAndSettle();

      expect(repo.sent.single, 'Saturday or Sunday?');
      final asked = repo.sentPolls.single!;
      expect(asked.options, ['Saturday', 'Sunday']);
      expect(asked.multiple, isTrue);
    });

    test('leaves out what the server would refuse, by kind', () {
      // MediaService.maxBytesFor. A photo under the old flat 25 MB check
      // went up only to be refused at 8, and its message could never send.
      const mb = 1024 * 1024;
      expect(MediaBasket.maxBytesFor(MediaKind.image), 8 * mb);
      expect(MediaBasket.maxBytesFor(MediaKind.gif), 12 * mb);
      expect(MediaBasket.maxBytesFor(MediaKind.voice), 12 * mb);
      expect(MediaBasket.maxBytesFor(MediaKind.video), 25 * mb);
    });

    test('uploads pictures before the message that carries them', () async {
      final repo = _Repo(_chat());
      final container = ProviderContainer(overrides: _overrides(repo));
      addTearDown(container.dispose);
      final keep =
          container.listen(communityChatProvider('chat-1'), (_, __) {});
      addTearDown(keep.close);
      await pumpEventQueue();

      final error = await container
          .read(communityChatProvider('chat-1').notifier)
          .sendMedia(
        const [
          PendingMedia(path: '/tmp/a.jpg', kind: MediaKind.image),
          PendingMedia(path: '/tmp/b.jpg', kind: MediaKind.image),
        ],
        me: const ChatPerson(id: 'me'),
        caption: ' look ',
      );
      expect(error, isNull);
      expect(repo.uploaded, ['/tmp/a.jpg', '/tmp/b.jpg']);
      expect(repo.sent.single, 'look');
      expect(repo.sentMedia.single.map((m) => m.ref), [
        'chat/me_1.jpg',
        'chat/me_2.jpg',
      ]);
    });

    test('sends the same files again on a retry, not new copies', () async {
      // Slow mode refuses after the pictures went up. Uploading them anew on
      // each retry left the earlier copies in the bucket, never sent.
      final repo = _Repo(_chat())..sendFails = _status(429);
      final container = ProviderContainer(overrides: _overrides(repo));
      addTearDown(container.dispose);
      final keep =
          container.listen(communityChatProvider('chat-1'), (_, __) {});
      addTearDown(keep.close);
      await pumpEventQueue();
      final chat = container.read(communityChatProvider('chat-1').notifier);

      expect(
        await chat.sendMedia(
          const [
            PendingMedia(path: '/tmp/a.jpg', kind: MediaKind.image),
            PendingMedia(path: '/tmp/b.jpg', kind: MediaKind.image),
          ],
          me: const ChatPerson(id: 'me'),
        ),
        isNotNull,
      );
      final failed = container
          .read(communityChatProvider('chat-1'))
          .messages
          .singleWhere((m) => m.failed);

      repo.sendFails = null;
      expect(await chat.retry(failed, me: const ChatPerson(id: 'me')), isNull);
      expect(repo.uploaded, ['/tmp/a.jpg', '/tmp/b.jpg']);
      expect(repo.sentMedia.single.map((m) => m.ref), [
        'chat/me_1.jpg',
        'chat/me_2.jpg',
      ]);
      expect(
        container
            .read(communityChatProvider('chat-1'))
            .messages
            .where((m) => m.failed),
        isEmpty,
      );
    });

    test('takes "already sent" on a retry as sent, and shows that message',
        () async {
      // The first try went through and its answer was lost: the files are in
      // a message already, and that message is the one to show.
      final went = _msg('m-went', const ChatPerson(id: 'me'), '');
      final repo = _Repo(_chat())..sendFails = _status(502);
      final container = ProviderContainer(overrides: _overrides(repo));
      addTearDown(container.dispose);
      final keep =
          container.listen(communityChatProvider('chat-1'), (_, __) {});
      addTearDown(keep.close);
      await pumpEventQueue();
      final chat = container.read(communityChatProvider('chat-1').notifier);
      await chat.sendMedia(
        const [PendingMedia(path: '/tmp/a.jpg', kind: MediaKind.image)],
        me: const ChatPerson(id: 'me'),
      );
      final failed = container
          .read(communityChatProvider('chat-1'))
          .messages
          .singleWhere((m) => m.failed);

      repo
        ..sendFails = _status(409)
        ..thread = [went];
      expect(await chat.retry(failed, me: const ChatPerson(id: 'me')), isNull);
      final shown = container.read(communityChatProvider('chat-1')).messages;
      expect(shown.where((m) => m.failed || m.sending), isEmpty);
      expect(shown.map((m) => m.id), contains('m-went'));
      expect(repo.uploaded, ['/tmp/a.jpg']);
    });

    testWidgets('a search goes back to where it was said', (tester) async {
      final said = _msg('m9', _ben, 'Kingfisher at the bridge');
      final repo = _Repo(_chat(), thread: [said])..found = [said];
      await _open(tester, repo);
      await tester.tap(find.byKey(const ValueKey('cchat-more')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Search this chat'));
      await tester.pumpAndSettle();
      expect(find.byType(CommunityChatSearchScreen), findsOneWidget);

      await tester.enterText(
        find.byKey(const ValueKey('cchat-search-field')),
        'bridge',
      );
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pumpAndSettle();
      expect(repo.searched, ['bridge']);
      await tester.tap(find.byKey(const ValueKey('cchat-found-m9')));
      await tester.pumpAndSettle();
      expect(find.byType(CommunityChatSearchScreen), findsNothing);
      expect(find.text('Kingfisher at the bridge'), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
    });

    test('a tapped notification opens its chat', () {
      expect(
        pushDestination({'type': 'community.chat', 'chatId': 'k1'}),
        (route: Routes.communityChat, arguments: 'k1'),
      );
      expect(pushDestination({'type': 'community.chat'}), isNull);
    });
  });

  group('as it happens, beyond the open chat', () {
    final apply = Provider<void Function(RealtimeEvent)>(
      (ref) => (event) => applyRealtimeEvent(ref, event),
    );

    test('reads the Messages list again a moment after a message, once',
        () async {
      final repo = _Repo(_chat());
      var reads = 0;
      final container = ProviderContainer(
        overrides: [
          ..._overrides(repo),
          joinedChatsProvider.overrideWith((ref) async {
            reads++;
            return const <CommunityChat>[];
          }),
        ],
      );
      addTearDown(container.dispose);
      final keep = container.listen(joinedChatsProvider, (_, __) {});
      addTearDown(keep.close);
      await pumpEventQueue();
      expect(reads, 1);

      for (var i = 0; i < 5; i++) {
        container.read(apply)(
          RealtimeEvent('community.chat.message', {
            'chatId': 'chat-9',
            'messageId': 'm$i',
          }),
        );
      }
      await pumpEventQueue();
      expect(reads, 1, reason: 'not yet: more may be coming');
      await Future<void>.delayed(
        ChatListRefresher.wait + const Duration(milliseconds: 200),
      );
      await pumpEventQueue();
      expect(reads, 2, reason: 'once, for all five');
    });

    test('pulls an open chat a beat after an edit or a vote', () async {
      final repo = _Repo(_chat(), thread: [_msg('m1', _ben, 'one')]);
      final container = ProviderContainer(overrides: _overrides(repo));
      addTearDown(container.dispose);
      final keep =
          container.listen(communityChatProvider('chat-1'), (_, __) {});
      addTearDown(keep.close);
      await pumpEventQueue();
      final before = repo.pages;
      for (final type in [
        'community.chat.message.edited',
        'community.chat.poll'
      ]) {
        container.read(apply)(
          RealtimeEvent(type, {'chatId': 'chat-1', 'messageId': 'm1'}),
        );
      }
      await pumpEventQueue();
      expect(repo.pages, before, reason: 'a beat later, not at once');
      await Future<void>.delayed(const Duration(milliseconds: 500));
      await pumpEventQueue();
      expect(repo.pages, before + 1, reason: 'one read for both');
    });
  });
}
