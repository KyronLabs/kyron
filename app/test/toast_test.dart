import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/answer_shape.dart';
import 'package:kyron_app/widgets/toast.dart';

/// A screen with something under the toast, and a context to show one from.
Future<BuildContext> _pump(WidgetTester tester) async {
  late BuildContext ctx;
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            ctx = context;
            return TextButton(
              onPressed: () => tapped++,
              child: const Text('underneath'),
            );
          },
        ),
      ),
    ),
  );
  return ctx;
}

int tapped = 0;

void main() {
  setUp(() {
    tapped = 0;
    Toast.dismiss();
  });

  /// Takes the message away and lets the frame settle.
  ///
  /// Inside the test body rather than in a teardown: the framework checks for
  /// stray timers as soon as the body returns, and the auto-dismiss is one.
  Future<void> clear(WidgetTester tester) async {
    Toast.dismiss();
    await tester.pump();
  }

  testWidgets('says what it was given', (tester) async {
    final ctx = await _pump(tester);
    Toast.show(ctx, 'Link copied');
    await tester.pumpAndSettle();

    expect(find.text('Link copied'), findsOneWidget);
    await clear(tester);
  });

  testWidgets('goes away on its own', (tester) async {
    final ctx = await _pump(tester);
    Toast.show(ctx, 'Draft saved', stay: const Duration(milliseconds: 300));
    await tester.pump();
    expect(find.text('Draft saved'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();
    expect(find.text('Draft saved'), findsNothing);
    expect(Toast.isShowing, isFalse);
  });

  testWidgets('a second message replaces the first', (tester) async {
    // Two in a row almost always means the second supersedes the first, and a
    // queue makes somebody wait to be told something that is no longer true.
    final ctx = await _pump(tester);
    Toast.show(ctx, 'first');
    await tester.pump();
    Toast.show(ctx, 'second');
    await tester.pump();

    expect(find.text('first'), findsNothing);
    expect(find.text('second'), findsOneWidget);
    await clear(tester);
  });

  testWidgets('tapping it takes it away', (tester) async {
    final ctx = await _pump(tester);
    Toast.show(ctx, 'Link copied');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Link copied'));
    await tester.pump();

    expect(find.text('Link copied'), findsNothing);
  });

  testWidgets('does not block the screen it is reporting on', (tester) async {
    // A message is not a wall: everything around the card stays tappable.
    final ctx = await _pump(tester);
    Toast.show(ctx, 'Saved', spot: ToastSpot.bottom);
    await tester.pumpAndSettle();

    await tester.tap(find.text('underneath'));
    await tester.pump();

    expect(tapped, 1);
    await clear(tester);
  });

  testWidgets('sits in the middle when asked to', (tester) async {
    final ctx = await _pump(tester);
    Toast.show(ctx, 'Link copied', spot: ToastSpot.middle);
    await tester.pumpAndSettle();

    final screen = tester.getRect(find.byType(MaterialApp));
    final card = tester.getRect(find.text('Link copied'));
    expect(
      card.center.dy,
      closeTo(screen.center.dy, 1),
      reason: 'vertically centred',
    );
    await clear(tester);
  });

  testWidgets('sits along the bottom otherwise', (tester) async {
    final ctx = await _pump(tester);
    Toast.show(ctx, 'Saved');
    await tester.pumpAndSettle();

    final screen = tester.getRect(find.byType(MaterialApp));
    final card = tester.getRect(find.text('Saved'));
    expect(card.center.dy, greaterThan(screen.center.dy));
    await clear(tester);
  });

  testWidgets('is one poll answer tall', (tester) async {
    // One shape used in both places is one shape to recognise, and both take
    // it from the same place so neither can drift.
    expect(Toast.minHeight, AnswerShape.minHeight);
    expect(Toast.radius, AnswerShape.radius);

    final ctx = await _pump(tester);
    Toast.show(ctx, 'Saved');
    await tester.pumpAndSettle();

    final card = find.ancestor(
      of: find.text('Saved'),
      matching: find.byType(Container),
    );
    expect(tester.getSize(card.first).height, AnswerShape.minHeight);
    await clear(tester);
  });

  testWidgets('a message asked for from a dead context is simply not shown',
      (tester) async {
    // Sheets report what they did after they have popped. Nothing here is
    // worth throwing over.
    final ctx = await _pump(tester);
    final overlay = Toast.anchor(ctx);
    await tester.pumpWidget(const SizedBox.shrink());

    expect(() => Toast.showOn(overlay, 'gone'), returnsNormally);
    expect(Toast.isShowing, isFalse);
  });
}
