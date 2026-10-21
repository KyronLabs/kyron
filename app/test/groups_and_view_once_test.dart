import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/l10n/app_localizations.dart';
import 'package:kyron_app/models/conversation.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/models/profile_summary.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/providers/messages_provider.dart';
import 'package:kyron_app/providers/people_search_provider.dart';
import 'package:kyron_app/repositories/keys_repository.dart';
import 'package:kyron_app/repositories/messages_repository.dart';
import 'package:kyron_app/screens/group_info_screen.dart';
import 'package:kyron_app/screens/new_message_screen.dart';
import 'package:kyron_app/screens/thread_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/link_card_reader.dart';
import 'package:kyron_app/services/message_vault.dart';
import 'package:kyron_app/models/message_link_card.dart';
import 'package:kyron_app/utils/conversation_text.dart';
import 'package:kyron_app/widgets/view_once.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Groups -- roles, spectators, raised hands, lines about the group -- and
/// view-once messages, on the screens that show them.
final _l10n = AppLocalizations();

/// A transparent 1x1 PNG: a picture that decodes, with no network.
final _pixel = Uint8List.fromList(const [
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, //
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
]);

const _ada = MessagePerson(id: 'ada', name: 'Ada');
const _ben = MessagePerson(id: 'ben', name: 'Ben');

GroupSummary _group({
  MemberRole role = MemberRole.member,
  bool handRaised = false,
  int handsRaised = 0,
  MemberRole joinRole = MemberRole.member,
}) =>
    GroupSummary(
      title: 'Birders',
      memberCount: 3,
      role: role,
      joinRole: joinRole,
      handRaised: handRaised,
      handsRaised: handsRaised,
    );

DirectMessage _said(String id, String body, String sender, int minute) =>
    DirectMessage(
      id: id,
      body: body,
      senderId: sender,
      createdAt: DateTime(2026, 10, 20, 9, minute),
    );

DirectMessage _once(
  String id,
  String sender, {
  MediaKind kind = MediaKind.image,
  bool opened = false,
  int openedCount = 0,
  int recipients = 1,
  bool gone = false,
}) =>
    DirectMessage(
      id: id,
      body: '',
      senderId: sender,
      createdAt: DateTime(2026, 10, 20, 9, 30),
      once: ViewOnce(
        kind: kind,
        opened: opened,
        openedCount: openedCount,
        recipients: recipients,
        gone: gone,
      ),
    );

class _Repo extends MessagesRepository {
  _Repo({
    this.thread = const [],
    this.group,
    this.people = const [_ada, _ben],
    this.memberList = const [],
  }) : super(ApiClient()..dio.interceptors.clear());

  /// Newest first, the way the server sends a page.
  List<DirectMessage> thread;
  GroupSummary? group;
  final List<MessagePerson> people;
  List<GroupMember> memberList;

  /// Set to answer the next page with "not found": the reader was taken out.
  bool gone = false;

  final List<String> opened = [];
  Object? openFails;
  final List<bool> hands = [];
  final List<(String, MemberRole)> roles = [];
  final List<String> removed = [];
  final List<String> dismissed = [];
  final List<String> uploadedOnce = [];
  final List<OnceUpload?> sentOnce = [];
  final List<(String, List<String>, MemberRole)> created = [];
  bool failUpload = false;

  @override
  Future<MessagePage> messages(
    String id, {
    String? cursor,
    int limit = 40,
  }) async {
    if (gone) {
      throw DioException(
        requestOptions: RequestOptions(path: '/messages/$id'),
        response: Response(
          requestOptions: RequestOptions(path: '/messages/$id'),
          statusCode: 404,
        ),
      );
    }
    return MessagePage(items: thread, people: people, group: group);
  }

  @override
  Future<void> markRead(String id) async {}

  @override
  Future<OpenedOnce> openOnce(String conversationId, String messageId) async {
    opened.add(messageId);
    final fail = openFails;
    if (fail != null) throw fail;
    return OpenedOnce(
      url: 'https://storage.invalid/once/$messageId',
      expiresAt: DateTime.now().add(const Duration(minutes: 2)),
      kind: MediaKind.image,
    );
  }

  @override
  Future<OnceUpload> uploadOnce(PendingMedia pending) async {
    if (failUpload) throw StateError('offline');
    uploadedOnce.add(pending.path);
    return OnceUpload(ref: 'once/me_1_x.jpg', kind: pending.kind);
  }

  @override
  Future<DirectMessage> send(
    String id,
    String body, {
    List<PendingMedia> media = const [],
    String? replyToId,
    String? linkCard,
    OnceUpload? once,
  }) async {
    sentOnce.add(once);
    return DirectMessage(
      id: 'sent-${sentOnce.length}',
      body: body,
      senderId: 'me',
      createdAt: DateTime(2026, 10, 20, 10),
      once: once == null ? null : ViewOnce(kind: once.kind, recipients: 2),
    );
  }

  @override
  Future<void> setHandRaised(String conversationId, bool raised) async =>
      hands.add(raised);

  @override
  Future<List<GroupMember>> members(String conversationId) async => memberList;

  @override
  Future<void> setRole(
    String conversationId,
    String userId,
    MemberRole role,
  ) async =>
      roles.add((userId, role));

  @override
  Future<void> removeMember(String conversationId, String userId) async =>
      removed.add(userId);

  @override
  Future<void> dismissHand(String conversationId, String userId) async =>
      dismissed.add(userId);

  @override
  Future<String> createGroup(
    String title,
    List<String> userIds, {
    MemberRole joinRole = MemberRole.member,
  }) async {
    created.add((title, userIds, joinRole));
    return 'g-new';
  }

  @override
  Future<ConversationPage> conversations({
    String? cursor,
    int limit = 30,
    ConversationFilter filter = ConversationFilter.all,
  }) async =>
      ConversationPage(
        items: [
          for (final person in [_ada, _ben])
            Conversation(
              id: 'dm-${person.id}',
              people: [person],
              lastMessageAt: DateTime(2026, 10, 1),
            ),
        ],
      );

  @override
  Future<int> unreadCount() async => 0;

  @override
  Future<void> setMuted(String conversationId, bool muted) async {}
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

class _NoPages extends LinkCardReader {
  @override
  Future<MessageLinkCard?> read(String url) async => null;
}

List<Override> _overrides(_Repo repo,
        {List<ProfileSummary> found = const []}) =>
    [
      linkCardReaderProvider.overrideWithValue(_NoPages()),
      // A view-once picture, without the network.
      onceBytesProvider.overrideWithValue((url) async => _pixel),
      currentUserProvider.overrideWith((ref) => _Me(ref)),
      threadProvider.overrideWith(
        (ref, id) => ThreadNotifier(
          repo,
          MessageVault(KeysRepository(ApiClient())),
          id,
        ),
      ),
      messagesRepositoryProvider.overrideWithValue(repo),
      peopleSearchProvider.overrideWith((ref, q) async => found),
    ];

Future<void> _thread(WidgetTester tester, _Repo repo) async {
  tester.view.physicalSize = const Size(1170, 2532);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: _overrides(repo),
      child: MaterialApp(
        theme: KyronTheme.lightTheme,
        home: const ThreadScreen(args: ThreadArgs(conversationId: 'g1')),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

ProviderContainer _container(WidgetTester tester) =>
    ProviderScope.containerOf(tester.element(find.byType(MaterialApp)));

void main() {
  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    SharedPreferences.setMockInitialValues({});
  });

  group('what the server sends, read', () {
    test('a view-once message is its kind and its state, with no address', () {
      final message = DirectMessage.fromJson({
        'id': 'm1',
        'body': '',
        'senderId': 'ada',
        'createdAt': '2026-10-20T09:00:00Z',
        'viewOnce': true,
        'media': [
          {
            'id': 'x',
            'kind': 'VOICE',
            'url': '',
            'durationMs': 4200,
            'waveform': [10, 50],
          },
        ],
        'once': {
          'opened': false,
          'openedCount': 0,
          'recipients': 2,
          'gone': false,
        },
      });
      expect(message.viewOnce, isTrue);
      expect(message.once!.kind, MediaKind.voice);
      expect(message.once!.duration, const Duration(milliseconds: 4200));
      expect(message.once!.recipients, 2);
      // No address to draw, and still not an empty message.
      expect(message.media, isEmpty);
      expect(message.isEmpty, isFalse);
    });

    test('a group is called by its name, and has no one "other"', () {
      final conversation = Conversation.fromJson({
        'id': 'g1',
        'kind': 'GROUP',
        'group': {'title': 'Birders', 'memberCount': 3, 'role': 'SPECTATOR'},
        'people': [
          {'id': 'ada', 'name': 'Ada'},
          {'id': 'ben', 'name': 'Ben'},
        ],
        'lastMessageAt': '2026-10-20T09:00:00Z',
      });
      expect(conversation.isGroup, isTrue);
      expect(conversation.title, 'Birders');
      expect(conversation.other, isNull);
      expect(conversation.group!.role, MemberRole.spectator);
      expect(conversation.group!.role.canWrite, isFalse);
    });

    test('a line about the group reads with the names it had', () {
      GroupEvent event(Map<String, dynamic> extra) => GroupEvent.fromJson({
            'actor': {'id': 'ada', 'name': 'Ada'},
            ...extra,
          })!;
      final users = [
        {'id': 'ben', 'name': 'Ben'},
        {'id': 'cy', 'name': 'Cy'},
      ];
      expect(
        groupEventText(_l10n, event({'type': 'created', 'title': 'Birders'})),
        'Ada created the group',
      );
      expect(
        groupEventText(_l10n, event({'type': 'added', 'users': users})),
        'Ada added Ben, Cy',
      );
      expect(
        groupEventText(_l10n, event({'type': 'renamed', 'title': 'Owls'})),
        'Ada renamed the group “Owls”',
      );
      expect(
        groupEventText(
          _l10n,
          event({
            'type': 'role',
            'users': users.take(1).toList(),
            'role': 'ADMIN'
          }),
        ),
        'Ada made Ben an admin',
      );
      expect(
        groupEventText(_l10n, event({'type': 'joinRole', 'role': 'SPECTATOR'})),
        'Ada set new people to join as spectators',
      );
      expect(groupEventText(_l10n, event({'type': 'left'})), 'Ada left');
      // A name with the placeholder in it is printed, not substituted again.
      expect(
        groupEventText(
          _l10n,
          GroupEvent.fromJson({
            'type': 'left',
            'actor': {'id': 'x', 'name': r'$users'},
          })!,
        ),
        r'$users left',
      );
      // A kind of line this app does not know is no line at all.
      expect(GroupEvent.fromJson({'type': 'poll', 'actor': {}}), isNull);
    });

    test('the list says what a view-once message or a group line is', () {
      expect(
        conversationPreview(_l10n, _once('m', 'ada', kind: MediaKind.video)),
        'Video · View once',
      );
      expect(
        conversationPreview(
          _l10n,
          DirectMessage(
            id: 'e',
            body: '',
            senderId: 'ada',
            createdAt: DateTime(2026),
            event: GroupEvent.fromJson({
              'type': 'left',
              'actor': {'id': 'ada', 'name': 'Ada'},
            }),
          ),
        ),
        'Ada left',
      );
    });
  });

  group('a group thread', () {
    testWidgets('is headed by its name and says who is speaking', (
      tester,
    ) async {
      await _thread(
        tester,
        _Repo(
          group: _group(),
          thread: [
            _said('m3', 'And me', 'me', 3),
            _said('m2', 'Over the bridge', 'ada', 2),
            _said('m1', 'Kingfisher!', 'ada', 1),
            DirectMessage(
              id: 'e1',
              body: '',
              senderId: 'ada',
              createdAt: DateTime(2026, 10, 20, 9),
              event: GroupEvent.fromJson({
                'type': 'added',
                'actor': {'id': 'ada', 'name': 'Ada'},
                'users': [
                  {'id': 'me', 'name': 'Me'},
                ],
              }),
            ),
          ],
        ),
      );

      expect(find.text('Birders'), findsOneWidget);
      expect(find.text('3 members'), findsOneWidget);
      expect(find.text('Ada added Me'), findsOneWidget);
      // Once over Ada's turn, never over the reader's own.
      expect(find.text('Ada'), findsOneWidget);
      expect(find.text('Me'), findsNothing);
    });

    testWidgets('keeps a spectator to reading, and lets them raise a hand', (
      tester,
    ) async {
      final repo = _Repo(group: _group(role: MemberRole.spectator));
      await _thread(tester, repo);

      expect(find.byType(TextField), findsNothing);
      expect(find.byKey(const ValueKey('thread-spectator')), findsOneWidget);
      expect(find.text('You are a spectator'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('thread-hand')));
      await tester.pumpAndSettle();
      expect(repo.hands, [true]);
      expect(find.text('Lower hand'), findsOneWidget);
      expect(
        find.text('Hand raised. The admins have been told.'),
        findsOneWidget,
      );
      // The toast's own timer.
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('shows its admins the hands raised', (tester) async {
      await _thread(
        tester,
        _Repo(group: _group(role: MemberRole.admin, handsRaised: 2)),
      );
      expect(find.text('2 asking to write'), findsOneWidget);
    });

    testWidgets('says so when the reader has been taken out of it', (
      tester,
    ) async {
      final repo = _Repo(group: _group());
      await _thread(tester, repo);
      expect(find.byType(TextField), findsOneWidget);

      repo.gone = true;
      await _container(tester).read(threadProvider('g1').notifier).pullNewest();
      await tester.pumpAndSettle();
      expect(find.text('You are no longer in this group.'), findsOneWidget);
      expect(find.byType(TextField), findsNothing);
    });
  });

  group('view once', () {
    testWidgets('opens once, and then is only "Opened"', (tester) async {
      final repo = _Repo(group: null, thread: [_once('m1', 'ada')]);
      await _thread(tester, repo);
      // The ring says it opens once; the line says what it is.
      expect(find.text('Photo'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('once-label')));
      await tester.pumpAndSettle();
      expect(repo.opened, ['m1']);
      expect(find.byType(ViewOnceViewer), findsOneWidget);

      await tester.tap(find.byTooltip('Close'));
      await tester.pumpAndSettle();
      expect(find.text('Opened'), findsOneWidget);

      // A second tap goes nowhere.
      await tester.tap(find.byKey(const ValueKey('once-label')));
      await tester.pumpAndSettle();
      expect(repo.opened, ['m1']);
      expect(find.byType(ViewOnceViewer), findsNothing);
    });

    testWidgets('is not the sender’s to open', (tester) async {
      final repo = _Repo(thread: [_once('m1', 'me', recipients: 2)]);
      await _thread(tester, repo);
      expect(find.text('Photo'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('once-label')));
      await tester.pump();
      expect(repo.opened, isEmpty);
      expect(
        find.text('Only the people you sent this to can open it, once.'),
        findsOneWidget,
      );
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });

    testWidgets('tells its sender, in a group, how many have opened it', (
      tester,
    ) async {
      final repo = _Repo(
        group: _group(),
        thread: [_once('m1', 'me', recipients: 2)],
      );
      await _thread(tester, repo);
      _container(tester).read(threadProvider('g1').notifier).onceOpened('m1');
      await tester.pumpAndSettle();
      expect(find.text('Photo · Opened by 1 of 2'), findsOneWidget);
    });

    testWidgets('is a pill the height of a line of text, not a card', (
      tester,
    ) async {
      final repo = _Repo(
        group: null,
        thread: [
          DirectMessage(
            id: 't1',
            body: 'hello',
            senderId: 'ada',
            createdAt: DateTime(2026, 10, 20, 9),
          ),
          _once('m1', 'ada'),
        ],
      );
      await _thread(tester, repo);
      Finder bubbleOf(Finder inside) => find
          .ancestor(
            of: inside,
            matching: find.byWidgetPredicate(
              (w) =>
                  w is Container &&
                  w.decoration is BoxDecoration &&
                  (w.decoration! as BoxDecoration).borderRadius != null,
            ),
          )
          .first;
      final once =
          tester.getSize(bubbleOf(find.byKey(const ValueKey('once-label'))));
      final text = tester.getSize(bubbleOf(find.text('hello')));
      // A hair over at most: the ring may stand a pixel proud of the line.
      expect(once.height, lessThanOrEqualTo(text.height + 2));
    });

    test('counts an open only once the server has said something', () async {
      final repo = _Repo(thread: [_once('m1', 'ada')]);
      final notifier = ThreadNotifier(
        repo,
        MessageVault(KeysRepository(ApiClient())),
        'c1',
      );
      addTearDown(notifier.dispose);
      await notifier.refresh();

      // The request never got there: still there to open.
      repo.openFails = DioException(
        requestOptions: RequestOptions(path: '/open'),
        type: DioExceptionType.connectionError,
      );
      await expectLater(
        notifier.openOnce(notifier.state.messages.single),
        throwsA(isA<DioException>()),
      );
      expect(notifier.state.messages.single.once!.opened, isFalse);

      // Refused as already opened: marked so, and gone.
      repo.openFails = DioException(
        requestOptions: RequestOptions(path: '/open'),
        response: Response(
          requestOptions: RequestOptions(path: '/open'),
          statusCode: 410,
        ),
      );
      await expectLater(
        notifier.openOnce(notifier.state.messages.single),
        throwsA(isA<DioException>()),
      );
      expect(notifier.state.messages.single.once!.opened, isTrue);
      expect(notifier.state.messages.single.once!.gone, isTrue);
    });

    test('goes to the private upload, never the public one', () async {
      final repo = _Repo();
      final notifier = ThreadNotifier(
        repo,
        MessageVault(KeysRepository(ApiClient())),
        'c1',
      );
      addTearDown(notifier.dispose);
      await notifier.refresh();

      await notifier.sendOnce(
        const PendingMedia(path: '/tmp/a.jpg', kind: MediaKind.image),
        senderId: 'me',
      );
      expect(repo.uploadedOnce, ['/tmp/a.jpg']);
      expect(repo.sentOnce.single!.ref, 'once/me_1_x.jpg');
      expect(notifier.state.messages.single.viewOnce, isTrue);
      expect(notifier.state.messages.single.body, isEmpty);
    });

    test('a failed send keeps the file, and a retry sends it', () async {
      final repo = _Repo()..failUpload = true;
      final notifier = ThreadNotifier(
        repo,
        MessageVault(KeysRepository(ApiClient())),
        'c1',
      );
      addTearDown(notifier.dispose);
      await notifier.refresh();

      await notifier.sendOnce(
        const PendingMedia(path: '/tmp/v.m4a', kind: MediaKind.voice),
        senderId: 'me',
      );
      final failed = notifier.state.messages.single;
      expect(failed.failed, isTrue);
      expect(failed.viewOnce, isTrue);

      repo.failUpload = false;
      await notifier.retry(failed);
      expect(repo.uploadedOnce, ['/tmp/v.m4a']);
      expect(notifier.state.messages.single.failed, isFalse);
      expect(notifier.state.messages.single.viewOnce, isTrue);
    });
  });

  group('a group’s page', () {
    Future<_Repo> info(
      WidgetTester tester, {
      required MemberRole role,
      List<GroupMember>? members,
    }) async {
      tester.view.physicalSize = const Size(1170, 2532);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      final repo = _Repo(
        group: _group(role: role),
        memberList: members ??
            [
              GroupMember(
                person: const MessagePerson(id: 'me', name: 'Me'),
                role: role,
              ),
              const GroupMember(person: _ada, role: MemberRole.admin),
              const GroupMember(person: _ben),
            ],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: _overrides(repo),
          child: MaterialApp(
            theme: KyronTheme.lightTheme,
            home: Builder(
              builder: (context) => Scaffold(
                body: TextButton(
                  onPressed: () =>
                      GroupInfoScreen.open(context, conversationId: 'g1'),
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      );
      // The thread is what holds the group's details.
      _container(tester).read(threadProvider('g1'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      return repo;
    }

    testWidgets('offers its owner everything', (tester) async {
      final repo = await info(tester, role: MemberRole.owner);
      expect(find.byKey(const ValueKey('group-add')), findsOneWidget);
      expect(find.byKey(const ValueKey('group-rename')), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('member-ben')));
      await tester.pumpAndSettle();
      expect(find.text('Make admin'), findsOneWidget);
      expect(find.text('Make spectator'), findsOneWidget);
      expect(find.text('Make owner'), findsOneWidget);
      expect(find.text('Remove from group'), findsOneWidget);

      await tester.tap(find.text('Make spectator'));
      await tester.pumpAndSettle();
      expect(repo.roles, [('ben', MemberRole.spectator)]);
    });

    testWidgets('keeps an admin to members and spectators', (tester) async {
      await info(tester, role: MemberRole.admin);

      await tester.tap(find.byKey(const ValueKey('member-ben')));
      await tester.pumpAndSettle();
      expect(find.text('Make spectator'), findsOneWidget);
      expect(find.text('Remove from group'), findsOneWidget);
      expect(find.text('Make admin'), findsNothing);
      expect(find.text('Make owner'), findsNothing);
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      // Another admin is the owner's to change.
      await tester.tap(find.byKey(const ValueKey('member-ada')));
      await tester.pumpAndSettle();
      expect(find.text('View profile'), findsOneWidget);
      expect(find.text('Remove from group'), findsNothing);
    });

    testWidgets('offers a member nothing but the way out', (tester) async {
      final repo = await info(tester, role: MemberRole.member);
      expect(find.byKey(const ValueKey('group-add')), findsNothing);
      expect(find.byKey(const ValueKey('group-rename')), findsNothing);

      await tester.tap(find.byKey(const ValueKey('member-ben')));
      await tester.pumpAndSettle();
      expect(find.text('View profile'), findsOneWidget);
      expect(find.text('Remove from group'), findsNothing);
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.byKey(const ValueKey('group-leave')),
        200,
      );
      await tester.tap(find.byKey(const ValueKey('group-leave')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('group-leave-confirm')));
      await tester.pumpAndSettle();
      expect(repo.removed, ['me']);
      expect(find.byType(GroupInfoScreen), findsNothing);
    });

    testWidgets('puts raised hands first, to answer', (tester) async {
      final repo = await info(
        tester,
        role: MemberRole.admin,
        members: const [
          GroupMember(person: MessagePerson(id: 'me', name: 'Me')),
          GroupMember(
            person: _ben,
            role: MemberRole.spectator,
            handRaised: true,
          ),
        ],
      );
      expect(find.text('Asking to write'), findsOneWidget);
      await tester.tap(find.byTooltip('Let them write'));
      await tester.pumpAndSettle();
      expect(repo.roles, [('ben', MemberRole.member)]);
    });
  });

  testWidgets('a group is started from New message', (tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final repo = _Repo();
    final routes = <RouteSettings>[];
    await tester.pumpWidget(
      ProviderScope(
        overrides: _overrides(repo),
        child: MaterialApp(
          theme: KyronTheme.lightTheme,
          home: const NewMessageScreen(),
          onGenerateRoute: (settings) {
            routes.add(settings);
            return MaterialPageRoute<void>(
              settings: settings,
              builder: (_) => Text('route ${settings.name}'),
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('new-group')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('pick-ada')));
    await tester.tap(find.byKey(const ValueKey('pick-ben')));
    await tester.pump();
    // Chosen, they are on the "To:" line; tapping one there lets them go.
    expect(find.byKey(const ValueKey('chosen-ada')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('chosen-ben')));
    await tester.pump();
    expect(find.byKey(const ValueKey('chosen-ben')), findsNothing);
    await tester.tap(find.byKey(const ValueKey('pick-ben')));
    await tester.pump();

    // No name yet: asked for, and nothing made.
    await tester.tap(find.byKey(const ValueKey('pick-people-done')));
    await tester.pump();
    expect(find.text('Name the group first.'), findsOneWidget);
    expect(repo.created, isEmpty);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.enterText(
      find.byKey(const ValueKey('new-group-name')),
      'Birders',
    );
    await tester.tap(find.byKey(const ValueKey('pick-people-done')));
    await tester.pumpAndSettle();

    final (title, ids, joinRole) = repo.created.single;
    expect(title, 'Birders');
    expect(ids, ['ada', 'ben']);
    // Spectators-on-join is a setting of the group, made after.
    expect(joinRole, MemberRole.member);
    expect(
      (routes.last.arguments as ThreadArgs).conversationId,
      'g-new',
    );
  });
}
