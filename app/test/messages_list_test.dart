import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/community_chat.dart';
import 'package:kyron_app/providers/community_chats_provider.dart';
import 'package:kyron_app/widgets/toast.dart';
import 'package:kyron_app/widgets/action_button.dart';
import 'package:kyron_app/l10n/app_localizations.dart';
import 'package:kyron_app/models/conversation.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/providers/presence_provider.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/models/profile_summary.dart';
import 'package:kyron_app/providers/messages_provider.dart';
import 'package:kyron_app/providers/people_search_provider.dart';
import 'package:kyron_app/repositories/messages_repository.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/screens/messages_screen.dart';
import 'package:kyron_app/screens/messaging_settings_screen.dart';
import 'package:kyron_app/screens/new_message_screen.dart';
import 'package:kyron_app/screens/thread_screen.dart' show ThreadArgs;
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/utils/conversation_text.dart';
import 'package:kyron_app/widgets/app_drawer.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The list of conversations, and the two screens it leads to: a new
/// message, and the settings that are about messages.
final _l10n = AppLocalizations();

DirectMessage _msg({
  String body = '',
  String sender = 'me',
  List<PostMedia> media = const [],
  bool seen = false,
  DateTime? at,
}) =>
    DirectMessage(
      id: 'm',
      body: body,
      senderId: sender,
      createdAt: at ?? DateTime(2026, 10, 12, 17, 28),
      media: media,
      seen: seen,
    );

PostMedia _media(MediaKind kind, [String id = 'x']) =>
    PostMedia(id: id, kind: kind, url: 'https://cdn.invalid/$id');

Conversation _conversation(
  String id,
  String name, {
  DirectMessage? last,
  int unread = 0,
  bool online = false,
}) =>
    Conversation(
      id: id,
      people: [
        MessagePerson(
          id: 'u-$id',
          name: name,
          username: name,
          online: online,
        ),
      ],
      lastMessage: last,
      unread: unread,
      lastMessageAt: last?.createdAt ?? DateTime(2026, 10, 1),
    );

class _Repo extends MessagesRepository {
  _Repo(this.byFilter) : super(ApiClient()..dio.interceptors.clear());

  final Map<ConversationFilter, List<Conversation>> byFilter;
  final List<ConversationFilter> asked = [];
  final List<String> restored = [];
  final List<String> opened = [];
  bool receipts = true;
  final List<bool> receiptChanges = [];
  bool failReceipts = false;

  /// Set to say there is more to read past the first page.
  String? more;

  @override
  Future<ConversationPage> conversations({
    String? cursor,
    int limit = 30,
    ConversationFilter filter = ConversationFilter.all,
  }) async {
    asked.add(filter);
    return ConversationPage(
      items: cursor == null ? byFilter[filter] ?? const [] : const [],
      nextCursor: cursor == null ? more : null,
    );
  }

  @override
  Future<int> unreadCount() async => 0;

  @override
  Future<void> restore(String conversationId) async {
    restored.add(conversationId);
    // As the server does: out of Hidden, back in the list.
    final hidden = [...?byFilter[ConversationFilter.hidden]];
    final row = hidden.where((c) => c.id == conversationId).firstOrNull;
    hidden.removeWhere((c) => c.id == conversationId);
    byFilter[ConversationFilter.hidden] = hidden;
    if (row != null) {
      byFilter[ConversationFilter.all] = [
        row,
        ...?byFilter[ConversationFilter.all],
      ];
    }
  }

  @override
  Future<String> openWith(String userId) async {
    opened.add(userId);
    return 'new-$userId';
  }

  @override
  Future<bool> readReceipts() async => receipts;

  @override
  Future<bool> setReadReceipts(bool on) async {
    if (failReceipts) throw StateError('down');
    receiptChanges.add(on);
    return receipts = on;
  }

  bool online = true;
  final List<bool> onlineChanges = [];

  @override
  Future<bool> showOnline() async => online;

  @override
  Future<bool> setShowOnline(bool on) async {
    onlineChanges.add(on);
    return online = on;
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

Future<_Repo> _pump(
  WidgetTester tester,
  Widget home, {
  Map<ConversationFilter, List<Conversation>> lists = const {},
  List<ProfileSummary> found = const [],
  List<RouteSettings>? routes,
  List<CommunityChat> chats = const [],
  String? more,
}) async {
  tester.view.physicalSize = const Size(1170, 2532);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final repo = _Repo({...lists})..more = more;
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentUserProvider.overrideWith((ref) => _Me(ref)),
        messagesRepositoryProvider.overrideWithValue(repo),
        peopleSearchProvider.overrideWith((ref, q) async => found),
        // The reader's community chats, which the list mixes in.
        joinedChatsProvider.overrideWith((ref) async => chats),
      ],
      child: MaterialApp(
        theme: KyronTheme.lightTheme,
        home: home,
        onGenerateRoute: (settings) {
          routes?.add(settings);
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (_) => Scaffold(body: Text('route ${settings.name}')),
          );
        },
      ),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

Widget _messages() => Scaffold(
      body: MessagesScreen(
        drawerKey: GlobalKey<AppDrawerState>(),
        onScrollProgress: (_) {},
      ),
    );

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
  });

  group('a conversation’s last message, in a line', () {
    test('says what a message with no words carries', () {
      // The list was never sent the attachments, so a voice note read
      // "You:" and nothing else.
      expect(
        conversationPreview(_l10n, _msg(media: [_media(MediaKind.voice)])),
        'Voice note',
      );
      expect(
        conversationPreview(_l10n, _msg(media: [_media(MediaKind.image)])),
        'Photo',
      );
      expect(
        conversationPreview(
          _l10n,
          _msg(media: [_media(MediaKind.image), _media(MediaKind.image, 'y')]),
        ),
        'Photos',
      );
      expect(
        conversationPreview(
          _l10n,
          _msg(media: [_media(MediaKind.image), _media(MediaKind.voice, 'y')]),
        ),
        'Attachment',
      );
    });

    test('words win, on one line', () {
      expect(
        conversationPreview(
          _l10n,
          _msg(body: 'look\nat this', media: [_media(MediaKind.image)]),
        ),
        'look at this',
      );
    });
  });

  group('when it was said', () {
    final now = DateTime(2026, 10, 12, 18);

    test('today is a time, yesterday is a word, this week is a day', () {
      expect(
        // Newer locale data puts a narrow no-break space before PM.
        conversationTime(_l10n, DateTime(2026, 10, 12, 17, 28), now: now)
            .replaceAll('\u202f', ' '),
        '5:28 PM',
      );
      expect(
        conversationTime(_l10n, DateTime(2026, 10, 11, 9), now: now),
        'Yesterday',
      );
      expect(
        conversationTime(_l10n, DateTime(2026, 10, 8, 9), now: now),
        'Thu',
      );
    });

    test('older is a date, with the year once it is another year', () {
      expect(
        conversationTime(_l10n, DateTime(2026, 9, 3), now: now),
        'Sep 3',
      );
      expect(
        conversationTime(_l10n, DateTime(2025, 9, 3), now: now),
        'Sep 3, 2025',
      );
    });
  });

  group('the list', () {
    final lists = {
      ConversationFilter.all: [
        _conversation(
          'c1',
          'Archieee',
          last: _msg(media: [_media(MediaKind.voice)], seen: true),
        ),
        _conversation(
          'c2',
          'Wee',
          last: _msg(body: 'hmm..', sender: 'u-c2'),
          unread: 2,
        ),
      ],
      ConversationFilter.unread: [
        _conversation(
          'c2',
          'Wee',
          last: _msg(body: 'hmm..', sender: 'u-c2'),
          unread: 2,
        ),
      ],
      ConversationFilter.hidden: [
        _conversation('c9', 'Old', last: _msg(body: 'bye')),
      ],
    };

    testWidgets('a conversation with nobody left in it says Deleted account',
        (tester) async {
      // What a deletion leaves on the other side: the thread, their own
      // messages, and nobody to name it after.
      await _pump(
        tester,
        _messages(),
        lists: {
          ConversationFilter.all: [
            // No people: the default, and what the deletion left.
            Conversation(
              id: 'gone',
              lastMessage: _msg(body: 'are you there?'),
              lastMessageAt: DateTime(2026, 10, 12),
            ),
          ],
        },
      );

      expect(find.text('Deleted account'), findsOneWidget);
      expect(find.text('Empty conversation'), findsNothing);
    });

    testWidgets('says what was sent, and whether it was seen', (tester) async {
      await _pump(tester, _messages(), lists: lists);

      expect(find.text('You: Voice note'), findsOneWidget);
      expect(find.text('Seen'), findsOneWidget);
      // Theirs, unread: a count where the status would be.
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('has no tabs: a filter menu and a Hidden chip instead', (
      tester,
    ) async {
      final repo = await _pump(tester, _messages(), lists: lists);
      expect(find.byType(TabBar), findsNothing);

      await tester.tap(find.byKey(const ValueKey('messages-filter')));
      await tester.pumpAndSettle();
      expect(find.text('Unanswered'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('filter-unread')));
      await tester.pumpAndSettle();

      expect(repo.asked, contains(ConversationFilter.unread));
      expect(find.text('Archieee'), findsNothing);
      expect(find.text('Wee'), findsOneWidget);
    });

    testWidgets('a green dot on whoever has the app open', (tester) async {
      await _pump(
        tester,
        _messages(),
        lists: {
          ConversationFilter.all: [
            _conversation('c1', 'Here', last: _msg(body: 'hi'), online: true),
            _conversation('c2', 'Away', last: _msg(body: 'bye')),
          ],
        },
      );

      expect(find.byKey(const ValueKey('online-u-c1')), findsOneWidget);
      expect(find.byKey(const ValueKey('online-u-c2')), findsNothing);

      // Then the socket says otherwise, and it is believed over the page.
      final container = ProviderScope.containerOf(
        tester.element(find.byType(MessagesScreen)),
      );
      container.read(presenceProvider.notifier).changed('u-c2', true);
      container.read(presenceProvider.notifier).changed('u-c1', false);
      await tester.pump();

      expect(find.byKey(const ValueKey('online-u-c1')), findsNothing);
      expect(find.byKey(const ValueKey('online-u-c2')), findsOneWidget);
    });

    testWidgets('its chips are the size of a Follow button', (tester) async {
      // They were 36 tall with a lighter label: between Follow and the
      // full-size buttons, and like neither.
      await _pump(tester, _messages(), lists: lists);

      for (final key in [
        'messages-filter',
        'messages-groups',
        'messages-hidden',
      ]) {
        expect(
          tester.getSize(find.byKey(ValueKey(key))).height,
          ActionButton.compactHeight,
          reason: key,
        );
      }
    });

    testWidgets('Hidden shows what was removed, and a swipe puts it back', (
      tester,
    ) async {
      final repo = await _pump(tester, _messages(), lists: lists);

      await tester.tap(find.byKey(const ValueKey('messages-hidden')));
      await tester.pumpAndSettle();
      expect(find.text('Old'), findsOneWidget);

      await tester.drag(find.text('Old'), const Offset(500, 0));
      await tester.pumpAndSettle();
      expect(repo.restored, ['c9']);
      // Back in the other list, out of sight: the toast is the way to it.
      expect(find.text('Open'), findsOneWidget);
      await tester.pump(Toast.stayWithAction + const Duration(seconds: 1));
    });

    testWidgets('Groups lists the groups, and the community chats joined', (
      tester,
    ) async {
      final repo = await _pump(
        tester,
        _messages(),
        lists: {
          ...lists,
          ConversationFilter.groups: [
            Conversation(
              id: 'g1',
              group: const GroupSummary(title: 'Birders', memberCount: 4),
              lastMessage: _msg(body: 'Saturday?', sender: 'u-x'),
              lastMessageAt: DateTime(2026, 10, 12, 18),
            ),
          ],
        },
        chats: [
          CommunityChat(
            id: 'k1',
            communityId: 'c1',
            communitySlug: 'birders',
            communityName: 'Birders',
            name: 'General',
            joined: true,
            lastMessageAt: DateTime(2026, 10, 12, 17),
          ),
        ],
      );

      await tester.tap(find.byKey(const ValueKey('messages-groups')));
      await tester.pumpAndSettle();

      // Narrowed by the server, so a page of groups is a full page.
      expect(repo.asked.last, ConversationFilter.groups);
      expect(find.text('Birders'), findsOneWidget);
      expect(find.text('General'), findsOneWidget);
      // Conversations between two are not groups.
      expect(find.text('Wee'), findsNothing);
    });

    testWidgets('Groups and Hidden are one at a time', (tester) async {
      final repo = await _pump(tester, _messages(), lists: lists);

      await tester.tap(find.byKey(const ValueKey('messages-groups')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('messages-hidden')));
      await tester.pumpAndSettle();
      expect(repo.asked.last, ConversationFilter.hidden);
      expect(find.text('Old'), findsOneWidget);

      // And off again, back to everything.
      await tester.tap(find.byKey(const ValueKey('messages-hidden')));
      await tester.pumpAndSettle();
      expect(find.text('Wee'), findsOneWidget);
    });

    testWidgets('Groups says when there are none', (tester) async {
      await _pump(tester, _messages(), lists: lists);

      await tester.tap(find.byKey(const ValueKey('messages-groups')));
      await tester.pumpAndSettle();

      expect(find.text('No groups'), findsOneWidget);
    });

    testWidgets('the search box narrows the list by name', (tester) async {
      await _pump(tester, _messages(), lists: lists);

      await tester.enterText(
        find.byKey(const ValueKey('messages-search')),
        'arch',
      );
      await tester.pump();

      expect(find.text('Archieee'), findsOneWidget);
      expect(find.text('Wee'), findsNothing);
    });

    testWidgets('the bar starts a message and opens message settings', (
      tester,
    ) async {
      final routes = <RouteSettings>[];
      await _pump(tester, _messages(), lists: lists, routes: routes);

      await tester.tap(find.byKey(const ValueKey('messages-new')));
      await tester.pumpAndSettle();
      expect(routes.last.name, Routes.newMessage);

      tester.state<NavigatorState>(find.byType(Navigator)).pop();
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('messages-settings')));
      await tester.pumpAndSettle();
      expect(routes.last.name, Routes.messagingSettings);
    });
  });

  group('a new message', () {
    testWidgets('offers the people already talked to, then anybody found', (
      tester,
    ) async {
      final routes = <RouteSettings>[];
      final repo = await _pump(
        tester,
        const NewMessageScreen(),
        lists: {
          ConversationFilter.all: [_conversation('c1', 'Archieee')],
        },
        found: const [ProfileSummary(id: 'u9', name: 'Dee', username: 'dee')],
        routes: routes,
      );

      expect(find.text('Archieee'), findsOneWidget);

      await tester.enterText(
        find.byKey(const ValueKey('new-message-search')),
        'de',
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dee'));
      await tester.pumpAndSettle();

      expect(repo.opened, ['u9']);
      expect(routes.last.name, Routes.thread);
      expect((routes.last.arguments as ThreadArgs).conversationId, 'new-u9');
    });

    testWidgets('somebody already talked to opens that conversation', (
      tester,
    ) async {
      final routes = <RouteSettings>[];
      final repo = await _pump(
        tester,
        const NewMessageScreen(),
        lists: {
          ConversationFilter.all: [_conversation('c1', 'Archieee')],
        },
        routes: routes,
      );

      await tester.tap(find.text('Archieee'));
      await tester.pumpAndSettle();

      expect(repo.opened, isEmpty);
      expect((routes.last.arguments as ThreadArgs).conversationId, 'c1');
    });
  });

  group('message settings', () {
    testWidgets('read receipts are the server’s, and a refusal puts it back', (
      tester,
    ) async {
      final repo = await _pump(tester, const MessagingSettingsScreen());

      await tester.tap(find.byKey(const ValueKey('setting-read-receipts')));
      await tester.pumpAndSettle();
      expect(repo.receiptChanges, [false]);

      repo.failReceipts = true;
      await tester.tap(find.byKey(const ValueKey('setting-read-receipts')));
      await tester.pumpAndSettle();
      final tile = tester.widget<SwitchListTile>(
        find.byKey(const ValueKey('setting-read-receipts')),
      );
      expect(tile.value, isFalse, reason: 'the server did not take it');
      await tester.pump(const Duration(seconds: 4));
    });

    testWidgets(
        'showing when you are online is the server’s, and off '
        'hides everybody’s at once', (tester) async {
      final repo = await _pump(
        tester,
        const MessagingSettingsScreen(),
      );
      final container = ProviderScope.containerOf(
        tester.element(find.byType(MessagingSettingsScreen)),
      );
      container.read(presenceProvider.notifier).snapshot(['u-c1']);

      await tester.tap(find.byKey(const ValueKey('setting-show-online')));
      await tester.pumpAndSettle();

      expect(repo.onlineChanges, [false]);
      // The trade read receipts make: hide yours, see nobody's.
      expect(container.read(presenceProvider).online, isEmpty);
      expect(container.read(presenceProvider).live, isTrue);
    });

    testWidgets('typing and link previews are kept on this phone', (
      tester,
    ) async {
      await _pump(tester, const MessagingSettingsScreen());

      await tester.tap(find.byKey(const ValueKey('setting-typing')));
      await tester.tap(find.byKey(const ValueKey('setting-link-previews')));
      await tester.pumpAndSettle();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('pref_dm_typing'), isFalse);
      expect(prefs.getBool('pref_dm_link_previews'), isFalse);
    });
  });

  group('the reader’s community chats, in the list', () {
    CommunityChat chat(
      String id,
      String name,
      DateTime at, {
      int unread = 0,
      bool muted = false,
    }) =>
        CommunityChat(
          id: id,
          communityId: 'c1',
          communitySlug: 'birders',
          communityName: 'Birders',
          name: name,
          joined: true,
          unread: unread,
          muted: muted,
          lastMessageAt: at,
          lastMessage: (
            senderName: 'Ada',
            body: 'Kingfisher!',
            mine: false,
            media: null,
            poll: false,
          ),
        );
    final conversations = {
      ConversationFilter.all: [
        _conversation('a', 'Newest', last: _msg(at: DateTime(2026, 10, 12))),
        _conversation('b', 'Oldest', last: _msg(at: DateTime(2026, 10, 1))),
      ],
    };

    testWidgets('sit among conversations by when each was last spoken in', (
      tester,
    ) async {
      await _pump(
        tester,
        _messages(),
        lists: conversations,
        chats: [chat('k1', 'General', DateTime(2026, 10, 5))],
      );
      double y(String text) => tester.getTopLeft(find.text(text)).dy;
      expect(y('Newest'), lessThan(y('General')));
      expect(y('General'), lessThan(y('Oldest')));
      expect(find.text('Birders · Ada: Kingfisher!'), findsOneWidget);
    });

    testWidgets('wait until the conversations loaded reach back to them', (
      tester,
    ) async {
      // Older than the oldest conversation on the page, with a page still to
      // come: shown now, it would sit above conversations that belong first.
      await _pump(
        tester,
        _messages(),
        lists: conversations,
        more: 'next',
        chats: [
          chat('k1', 'General', DateTime(2026, 10, 5)),
          chat('k2', 'Archive talk', DateTime(2026, 9, 1)),
        ],
      );
      expect(find.text('General'), findsOneWidget);
      expect(find.text('Archive talk'), findsNothing);
    });

    testWidgets('say when they are muted, and how many are new', (
      tester,
    ) async {
      await _pump(
        tester,
        _messages(),
        lists: conversations,
        chats: [
          chat('k1', 'General', DateTime(2026, 10, 5), unread: 3, muted: true),
        ],
      );
      expect(
        find.byKey(const ValueKey('inbox-chat-muted-k1')),
        findsOneWidget,
      );
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('keep their time at the edge, in line with a conversation’s', (
      tester,
    ) async {
      // A Flexible name and a Spacer split the free width between them, and
      // the time sat halfway along the row.
      await _pump(
        tester,
        _messages(),
        lists: conversations,
        chats: [
          chat('k1', 'General', DateTime(2026, 10, 5), unread: 3, muted: true),
        ],
      );
      final chatTime = tester.getTopRight(
        find.descendant(
          of: find.byKey(const ValueKey('inbox-chat-k1')),
          matching: find.text(conversationTime(_l10n, DateTime(2026, 10, 5))),
        ),
      );
      final conversationTimeAt =
          tester.getTopRight(find.byKey(const ValueKey('when-a')));
      expect(chatTime.dx, moreOrLessEquals(conversationTimeAt.dx));
    });

    testWidgets('are found by the search box, by chat or community', (
      tester,
    ) async {
      await _pump(
        tester,
        _messages(),
        lists: conversations,
        chats: [chat('k1', 'General', DateTime(2026, 10, 5))],
      );
      await tester.enterText(
        find.byKey(const ValueKey('messages-search')),
        'bird',
      );
      await tester.pump();
      expect(find.text('General'), findsOneWidget);
      expect(find.text('Newest'), findsNothing);
    });
  });
}
