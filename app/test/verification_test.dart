import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/models/verification.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/providers/verification_provider.dart';
import 'package:kyron_app/repositories/current_user_repository.dart';
import 'package:kyron_app/repositories/verification_repository.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/screens/verification_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/action_button.dart';
import 'package:kyron_app/widgets/sliding_drawer_content.dart';
import 'package:kyron_app/widgets/verified_badge.dart';

import 'support/signed_in_as.dart';

/// Asking for the verified badge, from the account's side: what it says
/// about where you stand, what it needs before you can ask, and the stamp
/// in the sidebar that leads there.

const _all = [
  VerificationRequirement(key: 'photo', label: 'A profile photo', met: true),
  VerificationRequirement(
    key: 'name',
    label: 'Your name on the profile',
    met: true,
  ),
  VerificationRequirement(
    key: 'bio',
    label: 'A bio that says who you are',
    met: true,
  ),
  VerificationRequirement(
    key: 'age',
    label: 'An account at least 7 days old',
    met: true,
  ),
  VerificationRequirement(
    key: 'standing',
    label: 'Nothing on your record in the last 90 days',
    met: true,
  ),
];

VerificationRequestView _request(
  VerificationRequestStatus status, {
  String? response,
}) =>
    VerificationRequestView(
      id: 'v1',
      number: 4,
      category: VerificationCategory.journalist,
      about: 'I report on the city council for the Gazette.',
      links: const ['https://gazette.example/staff/ada'],
      status: status,
      response: response,
      createdAt: DateTime(2026, 10, 18),
    );

/// The API, as far as one account asking for the badge goes: what it says
/// changes with what the account does, the way the server's would.
class _Badge extends VerificationRepository {
  _Badge(this.state) : super(ApiClient());

  VerificationState state;
  final sent = <(VerificationCategory, String, List<String>)>[];
  var withdrawn = 0;

  @override
  Future<VerificationState> status() async => state;

  @override
  Future<VerificationRequestView> apply({
    required VerificationCategory category,
    required String about,
    required List<String> links,
  }) async {
    sent.add((category, about, links));
    final request = _request(VerificationRequestStatus.pending);
    state = VerificationState(
      verified: false,
      canApply: false,
      requirements: state.requirements,
      request: request,
    );
    return request;
  }

  @override
  Future<void> withdraw() async {
    withdrawn++;
    state = VerificationState(
      verified: false,
      canApply: true,
      requirements: state.requirements,
      request: _request(VerificationRequestStatus.withdrawn),
    );
  }
}

Future<_Badge> _open(WidgetTester tester, VerificationState state) async {
  // Tall enough that the whole page is built: it is one long list.
  tester.view.physicalSize = const Size(1170, 7200);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  final repo = _Badge(state);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        verificationRepositoryProvider.overrideWithValue(repo),
        signedInAs(),
      ],
      child: const MaterialApp(home: VerificationScreen()),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

ActionButton _button(WidgetTester tester, String label) =>
    tester.widget<ActionButton>(
      find.ancestor(of: find.text(label), matching: find.byType(ActionButton)),
    );

class _Answers extends CurrentUserRepository {
  _Answers(this.user) : super(ApiClient());
  final CurrentUser user;

  @override
  Future<CurrentUser> fetchMe({bool force = false}) async => user;
}

CurrentUser _me({bool verified = false}) => CurrentUser(
      id: 'u1',
      name: 'Ada Lovelace',
      username: 'ada',
      followers: 12,
      following: 3,
      posts: 7,
      verified: verified,
    );

Future<void> _drawer(WidgetTester tester, {required bool verified}) async {
  tester.view.physicalSize = const Size(1170, 4800);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentUserRepositoryProvider.overrideWithValue(
          _Answers(_me(verified: verified)),
        ),
      ],
      child: MaterialApp(
        routes: {
          Routes.verification: (_) => const Scaffold(body: Text('asking')),
          Routes.likedPosts: (_) => const Scaffold(body: Text('liked list')),
        },
        home: Scaffold(body: SlidingDrawerContent(onCloseDrawer: () {})),
      ),
    ),
  );
  await tester.pump();
  await tester.pump();
}

void main() {
  group('what the API says', () {
    test('where an account stands, with the request it made', () {
      final state = VerificationState.fromJson({
        'verified': false,
        'verifiedAt': null,
        'canApply': false,
        'nextApplyAt': '2026-11-17T09:00:00.000Z',
        'requirements': [
          {'key': 'photo', 'label': 'A profile photo', 'met': true},
          {'key': 'bio', 'label': 'A bio', 'met': false},
        ],
        'request': {
          'id': 'v1',
          'number': 4,
          'category': 'PUBLIC_FIGURE',
          'about': 'Mayor of a small town.',
          'links': ['https://town.example/mayor'],
          'status': 'DENIED',
          'response': 'The page does not mention Kyron.',
          'createdAt': '2026-10-18T09:00:00.000Z',
          'decidedAt': '2026-10-18T12:00:00.000Z',
        },
      });
      expect(state.eligible, isFalse);
      expect(state.pending, isFalse);
      expect(state.nextApplyAt, isNotNull);
      expect(state.request!.category, VerificationCategory.publicFigure);
      expect(state.request!.status, VerificationRequestStatus.denied);
      expect(state.request!.links, ['https://town.example/mayor']);
      expect(state.request!.response, 'The page does not mention Kyron.');
    });

    test('a request in the team queue, with the account behind it', () {
      final item = VerificationCase.fromJson({
        'request': {
          'id': 'v1',
          'number': 4,
          'category': 'SOMETHING_NEW',
          'about': 'A bakery.',
          'links': ['https://bakery.example'],
          'status': 'PENDING',
          'createdAt': '2026-10-18T09:00:00.000Z',
        },
        'account': {
          'id': 'u1',
          'name': 'Rye & Co',
          'username': null,
          'followers': 40,
          'posts': 12,
          'createdAt': '2026-09-01T09:00:00.000Z',
        },
        'requirements': [
          {'key': 'photo', 'label': 'A profile photo', 'met': true},
        ],
        'ownRequest': true,
      });
      // An unknown category from a newer server is "something else", not a
      // crash.
      expect(item.request.category, VerificationCategory.other);
      expect(item.handle, 'Rye & Co');
      expect(item.followers, 40);
      expect(item.ownRequest, isTrue);
    });

    test('the badge rides along with the signed-in account', () {
      final me = CurrentUser.fromJson({
        'user': {'id': 'u1', 'name': 'Ada', 'verified': true},
      });
      expect(me.verified, isTrue);
      // And survives the cached copy the app starts from.
      expect(CurrentUser.fromJson(me.toJson()).verified, isTrue);
    });
  });

  group('the page', () {
    testWidgets('leads with what the badge is, and is not', (tester) async {
      await _open(
        tester,
        const VerificationState(
          verified: false,
          canApply: true,
          requirements: _all,
        ),
      );
      expect(find.bySemanticsLabel('Get verified on Kyron'), findsOneWidget);
      expect(find.textContaining('it is not for sale'), findsOneWidget);
      expect(find.text('A person\nchecks'), findsOneWidget);
    });

    testWidgets('a verified account is told so, and what keeps it', (
      tester,
    ) async {
      await _open(
        tester,
        VerificationState(
          verified: true,
          verifiedAt: DateTime(2026, 10, 19),
          canApply: false,
          requirements: _all,
        ),
      );
      expect(find.text("You're verified"), findsOneWidget);
      expect(find.textContaining('Change your name'), findsOneWidget);
      expect(find.text('Ask to be verified'), findsNothing);
    });

    testWidgets('a request waiting can be withdrawn', (tester) async {
      final repo = await _open(
        tester,
        VerificationState(
          verified: false,
          canApply: false,
          requirements: _all,
          request: _request(VerificationRequestStatus.pending),
        ),
      );
      expect(find.text('Request 4 is with a person'), findsOneWidget);
      expect(find.textContaining('as journalist'), findsOneWidget);
      await tester.tap(find.text('Withdraw the request'));
      await tester.pumpAndSettle();
      expect(repo.withdrawn, 1);
      expect(find.text('Ask to be verified'), findsOneWidget);
      await tester.pump(const Duration(seconds: 6));
    });

    testWidgets('a no says why, and when to ask again', (tester) async {
      await _open(
        tester,
        VerificationState(
          verified: false,
          canApply: false,
          requirements: _all,
          nextApplyAt: DateTime(2026, 11, 17),
          request: _request(
            VerificationRequestStatus.denied,
            response: 'The page does not mention Kyron.',
          ),
        ),
      );
      expect(find.text('Request 4 was not approved'), findsOneWidget);
      expect(find.text('The page does not mention Kyron.'), findsOneWidget);
      expect(find.textContaining('You can ask again from'), findsOneWidget);
      expect(find.text('Ask to be verified'), findsNothing);
    });

    testWidgets('says what is missing, and will not send until it is done', (
      tester,
    ) async {
      await _open(
        tester,
        VerificationState(
          verified: false,
          canApply: false,
          requirements: [
            for (final r in _all)
              r.key == 'bio'
                  ? VerificationRequirement(
                      key: r.key,
                      label: r.label,
                      met: false,
                    )
                  : r,
          ],
        ),
      );
      expect(find.text('Edit your profile'), findsOneWidget);
      expect(
        find.text('Everything above needs a tick before you can ask.'),
        findsOneWidget,
      );

      // Even a complete form waits on the profile.
      await tester.enterText(
        find.widgetWithText(TextField, 'Who you are'),
        'I report on the city council for the Gazette.',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Where we can check'),
        'https://gazette.example/staff/ada',
      );
      await tester.pump();
      expect(_button(tester, 'Ask to be verified').onPressed, isNull);
    });

    testWidgets('asks with who you are and a link that proves it', (
      tester,
    ) async {
      final repo = await _open(
        tester,
        const VerificationState(
          verified: false,
          canApply: true,
          requirements: _all,
        ),
      );
      expect(find.text('Edit your profile'), findsNothing);
      expect(_button(tester, 'Ask to be verified').onPressed, isNull);

      await tester.tap(find.text('Journalist'));
      await tester.pump();

      // Too short to tell a reviewer anything.
      await tester.enterText(
        find.widgetWithText(TextField, 'Who you are'),
        'Reporter.',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Where we can check'),
        'https://gazette.example/staff/ada',
      );
      await tester.pump();
      expect(_button(tester, 'Ask to be verified').onPressed, isNull);

      await tester.enterText(
        find.widgetWithText(TextField, 'Who you are'),
        'I report on the city council for the Gazette.',
      );
      // Not a link anyone can follow.
      await tester.enterText(
        find.widgetWithText(TextField, 'Where we can check'),
        'my website',
      );
      await tester.pump();
      expect(_button(tester, 'Ask to be verified').onPressed, isNull);

      await tester.enterText(
        find.widgetWithText(TextField, 'Where we can check'),
        'https://gazette.example/staff/ada',
      );
      await tester.tap(find.text('Add another link'));
      await tester.pump();
      await tester.enterText(
        find.widgetWithText(TextField, 'Another link'),
        'not a link',
      );
      await tester.pump();

      await tester.tap(find.text('Ask to be verified'));
      await tester.pumpAndSettle();
      final (category, about, links) = repo.sent.single;
      expect(category, VerificationCategory.journalist);
      expect(about, 'I report on the city council for the Gazette.');
      // Only the link that is one: the second box held "not a link".
      expect(links, ['https://gazette.example/staff/ada']);
      expect(find.text('Request 4 is with a person'), findsOneWidget);
      await tester.pump(const Duration(seconds: 6));
    });
  });

  group('the sidebar', () {
    /// Where [finder] sits, top to bottom.
    double top(WidgetTester tester, Finder finder) =>
        tester.getTopLeft(finder).dy;

    testWidgets('offers the badge to an account without it, last', (
      tester,
    ) async {
      await _drawer(tester, verified: false);
      final card = find.byKey(const ValueKey('drawer-verification'));
      expect(card, findsOneWidget);
      expect(find.text('Get verified'), findsOneWidget);
      // After everything somebody opens the menu to reach.
      expect(
        top(tester, card),
        greaterThan(top(tester, find.text('Help & Support'))),
      );
      expect(
        find.descendant(
          of: find.byType(NameWithBadge),
          matching: find.byType(VerifiedBadge),
        ),
        findsNothing,
      );

      await tester.tap(card);
      await tester.pumpAndSettle();
      expect(find.text('asking'), findsOneWidget);
    });

    testWidgets('leaves it out once it is given: the name says so', (
      tester,
    ) async {
      await _drawer(tester, verified: true);
      expect(find.byKey(const ValueKey('drawer-verification')), findsNothing);
      expect(find.text("You're verified"), findsNothing);
      expect(
        find.descendant(
          of: find.byType(NameWithBadge),
          matching: find.byType(VerifiedBadge),
        ),
        findsOneWidget,
      );
    });

    testWidgets('puts Saved and Liked side by side, without "posts"', (
      tester,
    ) async {
      await _drawer(tester, verified: true);
      final saved = find.byKey(const ValueKey('drawer-saved'));
      final liked = find.byKey(const ValueKey('drawer-liked'));
      expect(find.descendant(of: saved, matching: find.text('Saved')),
          findsOneWidget);
      expect(find.descendant(of: liked, matching: find.text('Liked')),
          findsOneWidget);
      expect(find.textContaining('posts'), findsNothing);

      // One row: the same height on screen, the same width, Saved first.
      expect(top(tester, saved), top(tester, liked));
      expect(tester.getSize(saved).width, tester.getSize(liked).width);
      expect(
        tester.getTopLeft(saved).dx,
        lessThan(tester.getTopLeft(liked).dx),
      );
    });

    testWidgets('fits a long translation on one line rather than wrapping', (
      tester,
    ) async {
      await _drawer(tester, verified: true);
      // Labels are scaled to fit, never wrapped or cut: a second line would
      // not fit the pill.
      final label = tester.widget<Text>(find.text('Saved'));
      expect(label.maxLines, 1);
      expect(
        find.ancestor(of: find.text('Saved'), matching: find.byType(FittedBox)),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('goes to the right list from each half of the row', (
      tester,
    ) async {
      await _drawer(tester, verified: true);
      await tester.tap(find.byKey(const ValueKey('drawer-liked')));
      await tester.pumpAndSettle();
      expect(find.text('liked list'), findsOneWidget);
    });
  });

  group('the badge beside a name', () {
    Future<void> show(WidgetTester tester, {required bool verified}) =>
        tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 120,
                child: NameWithBadge(
                  name: 'A rather long display name that will not fit',
                  verified: verified,
                ),
              ),
            ),
          ),
        );

    testWidgets('only when verified', (tester) async {
      await show(tester, verified: false);
      expect(find.byType(VerifiedBadge), findsNothing);
      await show(tester, verified: true);
      expect(find.bySemanticsLabel('Verified'), findsOneWidget);
    });

    testWidgets('a long name gives way, never the badge', (tester) async {
      await show(tester, verified: true);
      expect(tester.takeException(), isNull);
      final badge = tester.getRect(find.byType(VerifiedBadge));
      expect(badge.right, lessThanOrEqualTo(120));
    });

    testWidgets("is the size of the name's capitals, at any size", (
      tester,
    ) async {
      // It was a full em or more, set by hand at each use, and read as
      // larger than the name beside it.
      for (final fontSize in [13.1, 15.0, 20.6]) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NameWithBadge(
                name: 'Gremlin',
                verified: true,
                style: TextStyle(fontSize: fontSize),
              ),
            ),
          ),
        );
        final badge = tester.getSize(find.byType(VerifiedBadge));
        expect(badge.width, closeTo(fontSize * VerifiedBadge.perEm, 0.01));
        expect(badge.width, lessThan(fontSize));
      }
    });
  });
}
