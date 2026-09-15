import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:kyron_app/widgets/hairline.dart';
import 'package:kyron_app/widgets/kyron_app_bar.dart';

/// The top bars used to turn faintly blue the moment a list moved under them,
/// and only then -- Material 3 raising the bar to `scrolledUnderElevation` and
/// washing it in `surfaceTint`. The themes turn that off; this is what
/// replaces it.
void main() {
  Widget host({PreferredSizeWidget? bottom, ScrollController? controller}) =>
      MaterialApp(
        theme: KyronTheme.darkTheme,
        home: Scaffold(
          appBar: KyronAppBar(title: const Text('Kyron'), bottom: bottom),
          body: ListView.builder(
            controller: controller,
            itemCount: 60,
            itemBuilder: (_, i) => SizedBox(height: 56, child: Text('row $i')),
          ),
        ),
      );

  /// The hairline's opacity, whether or not it is drawn.
  double lineOpacity(WidgetTester tester) {
    final fade = tester.widget<AnimatedOpacity>(
      find
          .ancestor(
            of: find.byType(Hairline),
            matching: find.byType(AnimatedOpacity),
          )
          .first,
    );
    return fade.opacity;
  }

  testWidgets('no line at the top of the page', (tester) async {
    await tester.pumpWidget(host());
    await tester.pumpAndSettle();
    expect(lineOpacity(tester), 0,
        reason: 'a bar over the top of a page needs no edge');
  });

  testWidgets('a line once the page has scrolled under it', (tester) async {
    await tester.pumpWidget(host());
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();

    expect(lineOpacity(tester), 1,
        reason: 'nothing separates the bar from the rows running under it');
  });

  testWidgets('and it goes again when the page comes back', (tester) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(host(controller: controller));
    await tester.pumpAndSettle();

    controller.jumpTo(300);
    await tester.pumpAndSettle();
    expect(lineOpacity(tester), 1);

    controller.jumpTo(0);
    await tester.pumpAndSettle();
    expect(lineOpacity(tester), 0);
  });

  testWidgets('the bar does not grow when the line appears', (tester) async {
    await tester.pumpWidget(host());
    await tester.pumpAndSettle();
    final before = tester.getSize(find.byType(AppBar));

    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();

    // A hairline is a fraction of a logical pixel, and adding it to the
    // toolbar's height would shift every row on the page down by that much
    // the first time somebody scrolled.
    expect(tester.getSize(find.byType(AppBar)), before);
  });

  testWidgets('the line sits under the screen\'s own bottom, not in it',
      (tester) async {
    await tester.pumpWidget(
      host(
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: SizedBox(height: 40, child: Text('pager')),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();

    expect(lineOpacity(tester), 1);

    // At the bottom of the whole header rather than between the toolbar and
    // the pager: the line separates the header from the content, and a line
    // through the middle of the header would be saying something else. It
    // sits *on* that edge rather than below it, because below it would grow
    // the bar -- which the test above forbids.
    final header = tester.getRect(find.byType(AppBar));
    final line = tester.getRect(find.byType(Hairline));
    final pager = tester.getRect(find.text('pager'));

    expect(line.bottom, closeTo(header.bottom, 0.01),
        reason: 'the line is not on the header\'s bottom edge');
    expect(line.top, greaterThanOrEqualTo(pager.top),
        reason: 'the line is above the pager, splitting the header in two');
  });
}
