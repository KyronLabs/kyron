import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/community.dart';
import 'package:kyron_app/models/community_chat.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/providers/community_chats_provider.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/providers/realtime_provider.dart';
import 'package:kyron_app/repositories/community_chats_repository.dart';
import 'package:kyron_app/repositories/moderation_repository.dart';
import 'package:kyron_app/screens/community_chat_screen.dart';
import 'package:kyron_app/screens/community_chat_settings_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/realtime_client.dart';
import 'package:kyron_app/widgets/community_chats_section.dart';
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
  }) async {
    final fail = sendFails;
    if (fail != null) throw fail;
    sent.add(body);
    return _msg('sent-${sent.length}', const ChatPerson(id: 'me'), body);
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
}
