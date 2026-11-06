import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/post_text.dart';
import 'package:kyron_app/widgets/selection_menu.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

Widget _host(Widget child, {bool dark = false, VoidCallback? onTap}) =>
    MaterialApp(
      theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
      onGenerateRoute: (s) => MaterialPageRoute(
        builder: (_) => Scaffold(body: Text('route ${s.name} ${s.arguments}')),
      ),
      home: Scaffold(
        body: Center(
          child: GestureDetector(onTap: onTap, child: child),
        ),
      ),
    );

void main() {
  testWidgets('a tap still opens the post the words are in', (tester) async {
    var opened = 0;
    await tester.pumpWidget(
      _host(
        PostText(
          content: 'Golden hour on the harbour wall',
          onTap: () => opened++,
        ),
      ),
    );
    await tester.tap(find.textContaining('Golden hour'));
    await tester.pumpAndSettle();
    expect(opened, 1);
  });

  testWidgets('a long press selects, with Copy, Search and Select all', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(const PostText(content: 'Golden hour on the harbour wall')),
    );
    await tester.longPress(find.textContaining('Golden hour'));
    await tester.pumpAndSettle();

    expect(find.byType(SelectionMenu), findsOneWidget);
    expect(find.text('Copy'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Select all'), findsOneWidget);

    // Search takes the chosen words to the search screen.
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();
    expect(find.textContaining('route /search'), findsOneWidget);
  });

  test('black on white in the light, white on black in the dark', () {
    final light = SelectionMenu.coloursOf(Brightness.light);
    final dark = SelectionMenu.coloursOf(Brightness.dark);
    expect(light.fill, const Color(0xFFFFFFFF));
    expect(light.ink, const Color(0xFF000000));
    expect(dark.fill, const Color(0xFF000000));
    expect(dark.ink, const Color(0xFFFFFFFF));
  });

  testWidgets('a post of a few emoji draws them large', (tester) async {
    await tester.pumpWidget(_host(const PostText(content: '🤣🤣')));
    final big = tester.widget<Text>(find.text('🤣🤣'));
    expect(big.style?.fontSize, PostText.jumboSize(2));

    await tester.pumpWidget(_host(const PostText(content: 'so funny 🤣')));
    expect(find.text('🤣🤣'), findsNothing);
  });
}
