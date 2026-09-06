import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/notification_model.dart';
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
    test('every piece is on disk at all three densities', () {
      for (final art in _art) {
        final one = File(art.asset);
        expect(one.existsSync(), isTrue, reason: '${art.asset} is missing');
        // Declared as one path in pubspec.yaml; Flutter finds the rest by
        // name, so a missing 3x silently serves a blurry 1x instead.
        for (final density in ['2.0x', '3.0x']) {
          final scaled = File(
            art.asset.replaceFirst(
              RegExp(r'([^/]+)$'),
              '$density/${art.asset.split('/').last}',
            ),
          );
          expect(scaled.existsSync(), isTrue,
              reason: '${scaled.path} is missing');
        }
      }
    });

    test('no two states share a picture by accident', () {
      // Reuse is deliberate where it happens -- a screen asks for a meaning,
      // not a file -- but two names pointing at one file should be a choice
      // somebody made, not a copy-paste.
      final files = _art.map((art) => art.asset).toList();
      expect(files.toSet().length, files.length);
    });

    test('every piece is declared under the folder pubspec ships', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      expect(pubspec, contains('- lib/assets/empty/'));
      for (final art in _art) {
        expect(art.asset, startsWith('lib/assets/empty/'));
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

    testWidgets('the light theme grounds the art, the dark one does not',
        (tester) async {
      // The pieces were rendered on black. On white the pale ones float off
      // the page without a contact shadow under them; on a dark screen they
      // have their own contrast and a second copy would only cost a draw.
      await tester.pumpWidget(_wrap(const EmptyState(
        art: EmptyArt.topics,
        title: 'No topics yet',
      )));
      expect(find.byType(Image), findsNWidgets(2));
      expect(find.byType(ImageFiltered), findsOneWidget);

      await tester.pumpWidget(_wrap(
        const EmptyState(art: EmptyArt.topics, title: 'No topics yet'),
        dark: true,
      ));
      // MaterialApp lerps between themes, and brightness only flips at the
      // halfway point -- one pumped frame is still the light one.
      await tester.pumpAndSettle();
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(ImageFiltered), findsNothing);
    });

    testWidgets('compact is smaller, not different', (tester) async {
      await tester.pumpWidget(_wrap(const Column(children: [
        EmptyState(art: EmptyArt.noMatch, title: 'Nothing found'),
        EmptyState(
            art: EmptyArt.noMatch, title: 'Nothing found', compact: true),
      ])));

      final sizes = tester
          .widgetList<Image>(find.byType(Image))
          .where((image) => image.color == null)
          .map((image) => image.width!)
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
