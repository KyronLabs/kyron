import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/community.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/screens/community_composer_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/hairline.dart';
import 'package:kyron_app/widgets/quoted_post_card.dart';
import 'package:kyron_app/widgets/reply_bar.dart';
import 'package:kyron_app/widgets/voice_post_player.dart';
import 'package:kyron_app/widgets/voice_waveform.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The decoration a field is actually drawn with.
InputDecoration _decorationOf(WidgetTester tester, Finder field) => tester
    .widget<InputDecorator>(
      find.descendant(of: field, matching: find.byType(InputDecorator)),
    )
    .decoration;

Future<void> _pump(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        feedRepositoryProvider.overrideWithValue(FeedRepository(ApiClient())),
      ],
      child: MaterialApp(
        theme: KyronTheme.lightTheme,
        home: child,
      ),
    ),
  );
  await tester.pump();
}

Widget _bar(TextEditingController controller, {String? replyingTo}) => Scaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: ReplyBar(
          controller: controller,
          focus: FocusNode(),
          hintText: 'Add a comment',
          canSend: false,
          sending: false,
          onSend: () {},
          canAttach: true,
          onAddMedia: () {},
          onAddGif: () {},
          media: const [],
          onRemoveMedia: (_) {},
          onRetryMedia: (_) {},
          onDescribeMedia: (_) {},
          replyingTo: replyingTo,
          onCancelReply: () {},
        ),
      ),
    );

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  group('the reply bar', () {
    testWidgets('is one line of text tall when empty', (tester) async {
      // Two full-size icon buttons and a form field with a 44-point floor
      // made a bar for a sentence most of a thumb tall.
      await _pump(tester, _bar(TextEditingController()));

      final height = tester.getSize(find.byType(ReplyBar)).height;
      expect(
        height,
        lessThanOrEqualTo(ReplyBar.fieldHeight + 2 * SpacingTokens.space8 + 1),
      );
    });

    testWidgets('is not drawn as a form field', (tester) async {
      // Naming only `border` leaves the theme's fill and its blue focus ring.
      await _pump(tester, _bar(TextEditingController()));
      await tester.tap(find.byType(TextField));
      await tester.pump();

      final decoration = _decorationOf(tester, find.byType(TextField));
      expect(decoration.filled, isFalse);
      expect(decoration.focusedBorder, InputBorder.none);
      expect(decoration.enabledBorder, InputBorder.none);
    });

    testWidgets('keeps the gallery and a GIF inside the box until you type', (
      tester,
    ) async {
      final controller = TextEditingController();
      await _pump(tester, _bar(controller));

      // One gallery button for photos and clips both, and a GIF beside it,
      // packed together: no gap between them wider than the buttons' own.
      final gallery = tester.getRect(find.byTooltip('Add a photo or clip'));
      final gif = tester.getRect(find.byTooltip('Add a GIF'));
      expect(gif.left - gallery.right, lessThanOrEqualTo(0.5));
      expect(gallery.width, lessThanOrEqualTo(32));

      controller.text = 'nice';
      await _pump(tester, _bar(controller));

      // Out of the way once there are words, when the room matters more.
      expect(find.byTooltip('Add a photo or clip'), findsNothing);
      expect(find.byTooltip('Add a GIF'), findsNothing);
    });

    testWidgets('says who is being answered in a line, not a toolbar', (
      tester,
    ) async {
      await _pump(tester, _bar(TextEditingController(), replyingTo: 'Ada'));

      expect(find.text('Replying to Ada'), findsOneWidget);
      final line = tester.getSize(
        find.ancestor(
          of: find.text('Replying to Ada'),
          matching: find.byType(Row),
        ),
      );
      expect(line.height, lessThanOrEqualTo(24));
    });
  });

  group('the community composer', () {
    const community = Community(id: 'c1', slug: 'birds', name: 'Birds');

    testWidgets('writes on the page rather than in a box', (tester) async {
      // The theme's filled field, with its blue focus ring, made a form out
      // of the one screen that is a blank page.
      await _pump(tester, const CommunityComposerScreen(community: community));
      await tester.pump();

      final decoration = _decorationOf(tester, find.byType(TextField));
      expect(decoration.filled, isFalse);
      expect(decoration.focusedBorder, InputBorder.none);
    });

    testWidgets('says who will see it above the words', (tester) async {
      await _pump(tester, const CommunityComposerScreen(community: community));

      final audience = tester.getTopLeft(
        find.text('Only members of Birds see this.'),
      );
      final field = tester.getTopLeft(find.byType(TextField));
      expect(audience.dy, lessThan(field.dy));
    });

    testWidgets('puts the caret in the box from the blank page below', (
      tester,
    ) async {
      await _pump(tester, const CommunityComposerScreen(community: community));
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pump();

      await tester.tapAt(const Offset(200, 400));
      await tester.pump();

      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.focusNode!.hasFocus, isTrue);
    });
  });

  group('cards inside a post', () {
    const voice = PostMedia(
      id: 'v1',
      kind: MediaKind.voice,
      url: 'https://example.com/v.m4a',
      duration: Duration(seconds: 8),
      waveform: [10, 50, 90, 40],
    );

    BoxDecoration cardOf(WidgetTester tester, Finder card) => tester
        .widgetList<Container>(
          find.descendant(of: card, matching: find.byType(Container)),
        )
        .map((c) => c.decoration)
        .whereType<BoxDecoration>()
        .firstWhere((d) => d.border != null);

    testWidgets('a voice post is a rounded card, not a pill', (tester) async {
      await _pump(
        tester,
        const Scaffold(body: VoicePostPlayer(media: voice)),
      );

      final card = cardOf(tester, find.byType(VoicePostPlayer));
      expect(
        card.borderRadius,
        BorderRadius.circular(RadiusTokens.radiusMd),
        reason: "the corner of a post's own pictures",
      );
    });

    testWidgets('outlines are the weight of the rule between posts', (
      tester,
    ) async {
      final scheme = KyronTheme.lightTheme.colorScheme;
      await _pump(
        tester,
        Scaffold(
          body: Column(
            children: [
              const VoicePostPlayer(media: voice),
              QuotedPostCard(
                post: QuotedPost(
                  id: 'q1',
                  content: 'hello',
                  createdAt: DateTime(2026),
                  author: const FeedAuthor(id: 'u1', username: 'ada'),
                ),
              ),
            ],
          ),
        ),
      );

      for (final card in [
        find.byType(VoicePostPlayer),
        find.byType(QuotedPostCard),
      ]) {
        final border = cardOf(tester, card).border! as Border;
        expect(border.top, postRule(scheme));
      }
      expect(postRule(scheme).width, 0.5);
    });

    testWidgets('inside a message bubble it draws no card of its own', (
      tester,
    ) async {
      await _pump(
        tester,
        const Scaffold(body: VoicePostPlayer(media: voice, framed: false)),
      );

      final framed = tester
          .widgetList<Container>(
            find.descendant(
              of: find.byType(VoicePostPlayer),
              matching: find.byType(Container),
            ),
          )
          .where((c) => c.decoration is BoxDecoration);
      expect(framed, isEmpty);
    });

    testWidgets('a voice post is the height of the reply box', (tester) async {
      // A 40-point disc, a 40-point waveform and a card's padding made a
      // recording taller than anything else a post carries.
      await _pump(
        tester,
        const Scaffold(body: VoicePostPlayer(media: voice)),
      );

      final card = find.descendant(
        of: find.byType(VoicePostPlayer),
        matching: find.byWidgetPredicate(
          (w) => w is Container && w.decoration is BoxDecoration,
        ),
      );
      expect(tester.getSize(card).height, VoicePostPlayer.height);
      expect(VoicePostPlayer.height, lessThanOrEqualTo(44));
    });

    testWidgets('play is the icon alone, in the text colour', (tester) async {
      await _pump(
        tester,
        const Scaffold(body: VoicePostPlayer(media: voice)),
      );

      final icon = tester.widget<Icon>(
        find.descendant(
          of: find.byType(VoicePostPlayer),
          matching: find.byType(Icon),
        ),
      );
      expect(icon.color, KyronTheme.lightTheme.colorScheme.onSurface);

      // Nothing filled behind it: no disc, no tinted circle.
      final discs = find.descendant(
        of: find.byType(VoicePostPlayer),
        matching: find.byWidgetPredicate(
          (w) =>
              (w is Material && w.color != null) ||
              (w is Container &&
                  w.decoration is BoxDecoration &&
                  (w.decoration! as BoxDecoration).shape == BoxShape.circle),
        ),
      );
      expect(discs, findsNothing);
    });
  });

  group('the waveform fill', () {
    test('stops part-way through a bar rather than at the next one', () {
      // Filling whole bars moved the fill a bar at a time, in steps. Ten
      // bars at 55% stops in the middle of the sixth, not at its edge.
      final played = VoiceWaveform.playedExtent(10, 0.55);
      expect(played, closeTo(5.5 * VoiceWaveform.slot, 0.001));
      expect(played % VoiceWaveform.slot, isNot(closeTo(0, 0.001)));
    });

    test('never runs past either end', () {
      expect(VoiceWaveform.playedExtent(10, -1), 0);
      expect(VoiceWaveform.playedExtent(10, 2), 10 * VoiceWaveform.slot);
    });
  });
}
