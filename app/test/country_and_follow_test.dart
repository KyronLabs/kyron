import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/country.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/providers/follow_provider.dart';
import 'package:kyron_app/providers/profile_provider.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/repositories/profile_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/country_sheet.dart';
import 'package:kyron_app/widgets/action_button.dart';
import 'package:kyron_app/widgets/hairline.dart';
import 'package:kyron_app/widgets/post_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/signed_in_as.dart';

FeedPost _post(
  String id, {
  String author = 'u1',
  bool following = false,
  String? country,
}) =>
    FeedPost(
      id: id,
      content: 'post $id',
      createdAt: DateTime(2026, 1, 1),
      author: FeedAuthor(id: author, name: 'Ada', country: country),
      followingAuthor: following,
    );

class _Feed extends FeedRepository {
  _Feed() : super(ApiClient());

  @override
  Future<FeedPage> recent({String? cursor, int limit = 20}) async =>
      const FeedPage(items: [], nextCursor: null);
}

/// Remembers who was followed, and can be made to fail.
class _Profiles extends ProfileRepository {
  _Profiles({this.fail = false}) : super(ApiClient());

  final bool fail;
  final followed = <String>[];

  @override
  Future<void> follow(String userId) async {
    if (fail) throw Exception('offline');
    followed.add(userId);
  }
}

Future<void> _cards(
  WidgetTester tester,
  List<FeedPost> posts, {
  _Profiles? profiles,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        signedInAs(),
        feedRepositoryProvider.overrideWithValue(_Feed()),
        profileRepositoryProvider.overrideWithValue(profiles ?? _Profiles()),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: ListView(
            children: [
              for (final p in posts)
                PostCard(post: p, source: PostListSource.recent),
            ],
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  group('countries', () {
    test('a flag is two regional-indicator letters', () {
      expect(Countries.flag('NG'), '🇳🇬');
      expect(Countries.flag('gb'), '🇬🇧');
    });

    test('only codes on the list are countries', () {
      expect(Countries.isCode('NG'), isTrue);
      expect(Countries.isCode('XK'), isTrue);
      // The EU is in CLDR's list of territories, but nobody lives in it.
      expect(Countries.isCode('EU'), isFalse);
      expect(Countries.isCode('Nigeria'), isFalse);
      expect(Countries.isCode(null), isFalse);
    });

    test("the phone's regions are suggestions, each once", () {
      expect(
        Countries.suggested(['ng', null, 'US', 'NG', '419', 'ZZ']),
        ['NG', 'US'],
      );
    });

    test('every language has a name for every country', () {
      // The picker reads these files; a gap would be a blank row.
      final dir = Directory('assets/countries');
      final files = dir.listSync().whereType<File>().toList();
      final arbs = Directory('lib/l10n')
          .listSync()
          .where((f) => f.path.endsWith('.arb'))
          .length;
      expect(files, hasLength(arbs));
      for (final file in files) {
        final names = (jsonDecode(file.readAsStringSync()) as Map).keys;
        expect(names.toSet(), countryCodes.toSet(), reason: file.path);
      }
    });
  });

  group('the country sheet', () {
    Future<CountryChoice?> pick(
      WidgetTester tester, {
      String? current,
      String? search,
      Key? tap,
    }) async {
      CountryChoice? answer;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Builder(
              builder: (context) => TextButton(
                onPressed: () async =>
                    answer = await CountrySheet.pick(context, current: current),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      // The names are read from the asset bundle, which is real IO.
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 100)),
      );
      await tester.pumpAndSettle();
      if (search != null) {
        await tester.enterText(
          find.byKey(const ValueKey('country-search')),
          search,
        );
        await tester.pumpAndSettle();
      }
      if (tap != null) {
        await tester.tap(find.byKey(tap));
        await tester.pumpAndSettle();
      }
      return answer;
    }

    testWidgets('finds a country by its English name', (tester) async {
      final answer = await pick(
        tester,
        search: 'germ',
        tap: const ValueKey('country-DE'),
      );
      expect(answer, (code: 'DE'));
    });

    testWidgets('finds a country by its code', (tester) async {
      await pick(tester, search: 'ng');
      // First, ahead of Angola, Bangladesh and every other "ng".
      final nigeria = tester.getRect(find.byKey(const ValueKey('country-NG')));
      final angola = find.byKey(const ValueKey('country-AO'));
      expect(angola, findsOneWidget);
      expect(nigeria.top, lessThan(tester.getRect(angola).top));
    });

    testWidgets('says when nothing matches', (tester) async {
      await pick(tester, search: 'atlantis');
      expect(find.text('No country matches “atlantis”.'), findsOneWidget);
    });

    testWidgets('can take the country away again', (tester) async {
      // Null is an answer, and not the same as closing the sheet.
      final answer = await pick(
        tester,
        current: 'NG',
        tap: const ValueKey('country-none'),
      );
      expect(answer, (code: null));
    });
  });

  group('the country under a post', () {
    testWidgets('names it, in the reader\'s language', (tester) async {
      await _cards(tester, [_post('p1', country: 'NG')]);
      // The names are read from the asset bundle, which is real IO.
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 100)),
      );
      await tester.pump();
      expect(find.text('🇳🇬  Nigeria'), findsOneWidget);
    });

    testWidgets('is not there when the author gave none', (tester) async {
      await _cards(tester, [_post('p1')]);
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('post-country-p1')), findsNothing);
    });
  });

  group('the follow button on the picture', () {
    testWidgets('is offered on somebody you do not follow', (tester) async {
      await _cards(tester, [_post('p1')]);
      expect(find.byKey(const ValueKey('post-follow-p1')), findsOneWidget);
    });

    testWidgets('is not offered on somebody you follow', (tester) async {
      await _cards(tester, [_post('p1', following: true)]);
      expect(find.byKey(const ValueKey('post-follow-p1')), findsNothing);
    });

    testWidgets('is not offered on your own posts', (tester) async {
      await _cards(tester, [_post('p1', author: 'me')]);
      expect(find.byKey(const ValueKey('post-follow-p1')), findsNothing);
    });

    testWidgets('follows, ticks, and goes from every post of theirs', (
      tester,
    ) async {
      final profiles = _Profiles();
      await _cards(
        tester,
        [_post('p1'), _post('p2'), _post('p3', author: 'u2')],
        profiles: profiles,
      );

      await tester.tap(find.byKey(const ValueKey('post-follow-p1')));
      await tester.pump();
      expect(profiles.followed, ['u1']);
      // The one tapped says it worked before it goes; the author's other
      // post simply stops offering, and somebody else's still offers.
      expect(find.byKey(const ValueKey('follow-done')), findsOneWidget);
      expect(find.byKey(const ValueKey('post-follow-p2')), findsNothing);
      expect(find.byKey(const ValueKey('post-follow-p3')), findsOneWidget);

      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const ValueKey('post-follow-p1')), findsNothing);
    });

    testWidgets('comes back, with the reason, when the follow fails', (
      tester,
    ) async {
      await _cards(tester, [_post('p1')], profiles: _Profiles(fail: true));

      await tester.tap(find.byKey(const ValueKey('post-follow-p1')));
      await tester.pump();
      await tester.pump();
      expect(find.byKey(const ValueKey('post-follow-p1')), findsOneWidget);
      expect(find.byKey(const ValueKey('follow-plus')), findsOneWidget);
      // Let the toast run out.
      await tester.pump(const Duration(seconds: 6));
    });

    testWidgets('sits on the edge of the picture, not off its corner', (
      tester,
    ) async {
      // It hung off the box around the picture, which on a round face is
      // empty space, and read as stuck on rather than part of the avatar.
      await _cards(tester, [_post('p1')]);
      final face = tester.getRect(find.byType(PostAvatar));
      final disc = tester.getRect(find.byKey(const ValueKey('follow-plus')));
      final r = face.width / 2;
      final fromCentre = (disc.center - face.center).distance;
      expect(fromCentre, closeTo(r, 1));
      expect(disc.center.dx, greaterThan(face.center.dx));
      expect(disc.center.dy, greaterThan(face.center.dy));
      // Small beside a 32-pixel face, as on Threads.
      expect(disc.width, lessThanOrEqualTo(16));
    });

    test('a follow from the profile reaches the posts', () {
      final container = ProviderContainer(overrides: [signedInAs()]);
      addTearDown(container.dispose);
      container.read(followOverridesProvider.notifier).record('u1', true);
      expect(container.read(followOverridesProvider), {'u1': true});
    });
  });

  testWidgets('an outlined button is ringed by one device pixel', (
    tester,
  ) async {
    // "Edit profile" was ringed by a logical pixel -- three device pixels
    // on most phones -- heavier than every other line around it.
    late double expected;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            expected = hairlineWidth(context);
            return ActionButton(
              label: 'Edit profile',
              kind: ActionButtonKind.outlined,
              onPressed: () {},
            );
          },
        ),
      ),
    );
    final button = tester.widget<TextButton>(find.byType(TextButton));
    final side = button.style!.side!.resolve({})!;
    expect(side.width, expected);
  });
}
