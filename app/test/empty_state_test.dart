import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/notification_model.dart';
import 'package:kyron_app/widgets/empty_artwork.dart';
import 'package:kyron_app/widgets/empty_state.dart';

/// Every picture an empty state can ask for.
const _art = <EmptyArt>[
  EmptyArt.posts,
  EmptyArt.videos,
  EmptyArt.messages,
  EmptyArt.caughtUp,
  EmptyArt.people,
  EmptyArt.communities,
  EmptyArt.topics,
  EmptyArt.trending,
  EmptyArt.tag,
  EmptyArt.noMatch,
  EmptyArt.saved,
  EmptyArt.likes,
  EmptyArt.drafts,
  EmptyArt.muted,
  EmptyArt.lens,
  EmptyArt.live,
  EmptyArt.polls,
  EmptyArt.offline,
];

Widget _wrap(Widget child, {bool dark = false}) => MaterialApp(
      theme: ThemeData(brightness: dark ? Brightness.dark : Brightness.light),
      home: Scaffold(body: child),
    );

void main() {
  group('the artwork', () {
    test('every state names a mark and a chip', () {
      // The whole set is one drawing with two things swapped, so the only way
      // to have a picture at all is to have both.
      for (final art in _art) {
        expect(art.mark, isNotNull);
        expect(art.chip, isNotNull);
      }
    });

    testWidgets('draws in both themes without a fixed colour in it',
        (tester) async {
      // The point of drawing these rather than shipping them.
      //
      // The set this replaced was eighteen PNGs, each one a fixed colour, so
      // a pale card stack would have been a white smear at night and a dark
      // one a hole in the day. Nothing here is a literal: the cards, the
      // pane, the marks and the chip all come off the scheme, and this fails
      // if any of them stops doing that.
      final shots = <bool, Color>{};

      for (final dark in [false, true]) {
        await tester.pumpWidget(_wrap(
          const Center(
            child: EmptyArtwork(mark: EmptyMark.lines, chip: Icons.circle),
          ),
          dark: dark,
        ));
        await tester.pumpAndSettle();

        final card = tester
            .widgetList<Container>(find.byType(Container))
            .map((c) => c.decoration)
            .whereType<BoxDecoration>()
            .firstWhere((d) => d.color != null);
        shots[dark] = card.color!;
      }

      expect(
        shots[false],
        isNot(shots[true]),
        reason: 'a card that is the same colour in both themes is a literal, '
            'which is the thing the images got wrong',
      );
    });

    testWidgets('every state in the set builds', (tester) async {
      for (final art in _art) {
        await tester.pumpWidget(_wrap(EmptyState(art: art, title: 'x')));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
    });
  });

  group('EmptyState', () {
    testWidgets('says what is missing and offers the way out', (tester) async {
      var tapped = 0;
      await tester.pumpWidget(_wrap(EmptyState(
        art: EmptyArt.communities,
        title: 'You are not in any communities',
        detail: 'Find one on Discover, or start your own.',
        action: 'Start a community',
        onAction: () => tapped++,
      )));

      expect(find.text('You are not in any communities'), findsOneWidget);
      expect(find.text('Find one on Discover, or start your own.'),
          findsOneWidget);

      await tester.tap(find.text('Start a community'));
      expect(tapped, 1);
    });

    testWidgets('leaves the button out when it would do nothing',
        (tester) async {
      // A label with no callback used to render a dead button.
      await tester.pumpWidget(_wrap(const EmptyState(
        art: EmptyArt.topics,
        title: 'No topics yet',
        action: 'Refresh',
      )));

      expect(find.byType(FilledButton), findsNothing);
      expect(find.text('Refresh'), findsNothing);
    });

    testWidgets('a failure keeps its own picture and a retry', (tester) async {
      var retried = 0;
      await tester.pumpWidget(_wrap(EmptyState.failed(
        title: 'Could not load these posts',
        detail: 'The server is not answering.',
        onAction: () => retried++,
      )));

      final state = tester.widget<EmptyState>(find.byType(EmptyState));
      expect(state.art, EmptyArt.offline);

      await tester.tap(find.text('Try again'));
      expect(retried, 1);
    });

    testWidgets('the picture is not read out on top of the title',
        (tester) async {
      await tester.pumpWidget(_wrap(const EmptyState(
        art: EmptyArt.messages,
        title: 'No messages yet',
      )));

      for (final image in tester.widgetList<Image>(find.byType(Image))) {
        expect(image.excludeFromSemantics, isTrue);
        expect(image.semanticLabel, isNull);
      }
    });

    testWidgets('compact is smaller, not different', (tester) async {
      await tester.pumpWidget(_wrap(const Column(children: [
        EmptyState(art: EmptyArt.noMatch, title: 'Nothing found'),
        EmptyState(
            art: EmptyArt.noMatch, title: 'Nothing found', compact: true),
      ])));

      final sizes = tester
          .widgetList<EmptyArtwork>(find.byType(EmptyArtwork))
          .map((art) => art.size)
          .toList();
      expect(sizes, hasLength(2));
      expect(sizes.first, greaterThan(sizes.last));
    });

    testWidgets('scrollable still scrolls when there is nothing in it',
        (tester) async {
      // Pull-to-refresh needs something that moves; a Column would not.
      await tester.pumpWidget(_wrap(
        const EmptyState(art: EmptyArt.caughtUp, title: 'All caught up')
            .scrollable,
      ));

      final view = tester.widget<ListView>(find.byType(ListView));
      expect(view.physics, isA<AlwaysScrollableScrollPhysics>());
    });
  });

  group('a notification', () {
    NotificationModel parse(Map<String, dynamic> json) =>
        NotificationModel.fromJson(json);

    test('reads what the server sent', () {
      final row = parse({
        'id': 'comment:c1',
        'kind': 'comment',
        'actor': {'id': 'u1', 'name': 'Ada', 'username': 'ada'},
        'postId': 'p1',
        'postSnippet': 'a post',
        'content': 'nice one',
        'createdAt': '2026-09-06T10:00:00.000Z',
        'unread': true,
      });

      expect(row.type, NotificationType.comment);
      expect(row.actor.label, 'Ada');
      expect(row.content, 'nice one');
      expect(row.isRead, isFalse);
      expect(row.actionText, 'replied to your post');
    });

    test('falls back through the name to the handle', () {
      expect(
        parse({
          'actor': {'id': 'u1', 'username': 'ada'}
        }).actor.label,
        '@ada',
      );
      expect(parse({'actor': <String, dynamic>{}}).actor.label, 'Someone');
    });

    test('an unknown kind is a like rather than a crash', () {
      // The server could add one before the app knows about it.
      expect(parse({'kind': 'sparkle'}).type, NotificationType.like);
    });

    test('groups by how long ago it was', () {
      NotificationModel aged(Duration ago) => NotificationModel(
            id: 'x',
            type: NotificationType.like,
            actor: const NotificationActor(id: 'u'),
            timestamp: DateTime.now().subtract(ago),
            isRead: true,
          );

      expect(aged(const Duration(minutes: 5)).groupKey, 'Today');
      expect(aged(const Duration(days: 1)).groupKey, 'Yesterday');
      expect(aged(const Duration(days: 3)).groupKey, 'This week');
      expect(aged(const Duration(days: 30)).groupKey, 'Older');
    });
  });
}
