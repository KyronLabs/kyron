import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/action_button.dart';
import 'package:kyron_app/widgets/app_button.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// The login button is the button. Every full-width button is it exactly,
/// every button in a row is its height, and the compact one is the one
/// smaller size there is -- measured as drawn, not as declared, so a theme
/// or a style that disagrees fails here (design system,
/// frontend/components/buttons.md, "The one height").
void main() {
  for (final dark in [false, true]) {
    testWidgets(
        "every button is the login button's height "
        '(${dark ? 'dark' : 'light'})', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppButton(
                    key: const ValueKey('login'),
                    label: 'Log in',
                    onTap: () {},
                  ),
                  ActionButton(
                    key: const ValueKey('full'),
                    label: 'Got it',
                    expand: true,
                    onPressed: () {},
                  ),
                  Row(
                    children: [
                      ActionButton(
                        key: const ValueKey('inline'),
                        label: 'Follow',
                        onPressed: () {},
                      ),
                      ActionButton(
                        key: const ValueKey('compact'),
                        label: 'Save',
                        compact: true,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      /// The pill as it is painted: the button's own Material, not the tap
      /// target around it.
      Size drawn(String key) => tester.getSize(
            find
                .descendant(
                  of: find.byKey(ValueKey(key)),
                  matching: find.byType(Material),
                )
                .first,
          );
      TextStyle label(String key, String text) => tester
          .widget<RichText>(
            find.descendant(
              of: find.byKey(ValueKey(key)),
              matching: find.byType(RichText),
            ),
          )
          .text
          .style!;

      const height = KyronTheme.buttonHeight;
      expect(height, 40);
      expect(drawn('login').height, height);
      expect(drawn('full').height, height);
      expect(drawn('full').width, drawn('login').width);
      expect(drawn('inline').height, height);
      expect(drawn('compact').height, ActionButton.compactHeight);
      // Full width reads as the login button reads.
      expect(
          label('full', 'Got it').fontSize, label('login', 'Log in').fontSize);
      expect(
        label('full', 'Got it').fontWeight,
        label('login', 'Log in').fontWeight,
      );
    });
  }
}
