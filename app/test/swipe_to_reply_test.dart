import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/swipe_to_reply.dart';

/// Pulling a message sideways answers it -- but only on purpose.
void main() {
  Widget app({
    required VoidCallback onReply,
    bool enabled = true,
    TextDirection direction = TextDirection.ltr,
  }) =>
      MaterialApp(
        home: Directionality(
          textDirection: direction,
          child: Scaffold(
            body: Center(
              child: SwipeToReply(
                onReply: onReply,
                enabled: enabled,
                child: const SizedBox(
                  width: 200,
                  height: 40,
                  child: Text('a message'),
                ),
              ),
            ),
          ),
        ),
      );

  testWidgets('replies when pulled past the threshold', (tester) async {
    var replies = 0;
    await tester.pumpWidget(app(onReply: () => replies++));
    await tester.drag(find.text('a message'), const Offset(120, 0));
    await tester.pumpAndSettle();
    expect(replies, 1);
  });

  testWidgets('does nothing when let go short of it', (tester) async {
    var replies = 0;
    await tester.pumpWidget(app(onReply: () => replies++));
    await tester.drag(find.text('a message'), const Offset(30, 0));
    await tester.pumpAndSettle();
    expect(replies, 0);
  });

  testWidgets('does nothing when pulled the other way', (tester) async {
    var replies = 0;
    await tester.pumpWidget(app(onReply: () => replies++));
    await tester.drag(find.text('a message'), const Offset(-120, 0));
    await tester.pumpAndSettle();
    expect(replies, 0);
  });

  testWidgets('pulls towards the reading end in a right-to-left language',
      (tester) async {
    var replies = 0;
    await tester.pumpWidget(
      app(onReply: () => replies++, direction: TextDirection.rtl),
    );
    await tester.drag(find.text('a message'), const Offset(120, 0));
    await tester.pumpAndSettle();
    expect(replies, 0, reason: 'rightwards is backwards in Arabic');

    await tester.drag(find.text('a message'), const Offset(-120, 0));
    await tester.pumpAndSettle();
    expect(replies, 1);
  });

  testWidgets('a message that cannot be answered cannot be pulled',
      (tester) async {
    var replies = 0;
    await tester.pumpWidget(app(onReply: () => replies++, enabled: false));
    await tester.drag(find.text('a message'), const Offset(120, 0));
    await tester.pumpAndSettle();
    expect(replies, 0);
  });

  testWidgets('springs back to where it started', (tester) async {
    await tester.pumpWidget(app(onReply: () {}));
    final before = tester.getTopLeft(find.text('a message'));
    await tester.drag(find.text('a message'), const Offset(120, 0));
    await tester.pumpAndSettle();
    expect(tester.getTopLeft(find.text('a message')), before);
  });

  testWidgets('a vertical drag is left to the list', (tester) async {
    var replies = 0;
    await tester.pumpWidget(app(onReply: () => replies++));
    await tester.drag(find.text('a message'), const Offset(10, 200));
    await tester.pumpAndSettle();
    expect(replies, 0);
  });
}
