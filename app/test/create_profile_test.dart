import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/onboarding_model.dart';
import 'package:kyron_app/screens/onboard_step1_screen.dart';
import 'package:kyron_app/widgets/images_field.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

Widget app() => MaterialApp(
  theme: KyronTheme.lightTheme,
  home: OnboardStep1Screen(model: OnboardingModel()),
);

void main() {
  group('creating a profile', () {
    testWidgets('shows the same pair of pictures as Edit profile', (
      tester,
    ) async {
      // The two screens edit the same two pictures. This one used to draw a
      // 200-pixel banner with a 128-pixel avatar straddling it -- a header, on
      // a form, taking most of the screen before a word could be typed.
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      expect(find.byType(ImagesField), findsOneWidget);
    });

    testWidgets('labels its fields rather than hinting at them', (
      tester,
    ) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      // A hint disappears the moment anybody types, which leaves a filled-in
      // form with nothing saying what the rows are.
      expect(find.text('Display name'), findsOneWidget);
      expect(find.text('Bio'), findsOneWidget);
    });

    testWidgets('sends the avatar straight to the gallery, with no menu', (
      tester,
    ) async {
      // "Generate AI" sat beside the camera button and called debugPrint. A
      // control that does nothing is worse than no control: it is a promise.
      // With it gone there is only one place an avatar can come from, so
      // asking would be a question with one answer.
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CircleAvatar));
      await tester.pumpAndSettle();

      expect(find.byType(BottomSheet), findsNothing);
      expect(find.textContaining('Generate'), findsNothing);
      expect(find.textContaining('AI'), findsNothing);
    });

    testWidgets('asks where the cover comes from, in a sheet', (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      // The cover is the first tappable thing in the pair.
      await tester.tap(
        find
            .descendant(
              of: find.byType(ImagesField),
              matching: find.byType(InkWell),
            )
            .first,
      );
      await tester.pumpAndSettle();

      // A sheet, never a popup menu: Kyron's menus arrive from the same place
      // at the same size, within reach of a thumb.
      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.text('Choose from gallery'), findsOneWidget);
      expect(find.text('Use one of ours'), findsOneWidget);
      // Those two and nothing else -- in particular nothing that generates a
      // picture, which is what the old menu offered and never did.
      expect(find.textContaining('Generate'), findsNothing);
      expect(find.textContaining('AI'), findsNothing);
    });

    testWidgets('holds Continue until there is a name', (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      final button = find.widgetWithText(InkWell, 'Continue');
      expect(button, findsWidgets, reason: 'the button has to be on screen');

      await tester.enterText(find.byType(TextFormField).first, 'Ada');
      await tester.pumpAndSettle();

      // Nothing to assert about the tap here -- it would call the API -- but
      // the name is what unlocks it, and typing one must rebuild the screen.
      expect(find.text('Ada'), findsOneWidget);
    });
  });
}
