import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/overlap_stack.dart';

/// The quoted message sits behind; the reply overlaps its lower edge; the
/// pair is exactly as tall as what is drawn.
void main() {
  Widget host(OverlapStack stack, {TextDirection? direction}) => Directionality(
        textDirection: direction ?? TextDirection.ltr,
        child: Align(alignment: Alignment.topLeft, child: stack),
      );

  const quote = SizedBox(key: Key('quote'), width: 150, height: 50);
  const reply = SizedBox(key: Key('reply'), width: 100, height: 40);

  testWidgets('overlaps the reply onto the quote and sizes to both',
      (tester) async {
    await tester.pumpWidget(
      // The default overlap, 14: the reply starts 14 above the quote's foot.
      host(OverlapStack(back: quote, front: reply)),
    );

    expect(tester.getSize(find.byType(OverlapStack)), const Size(150, 76));
    expect(tester.getTopLeft(find.byKey(const Key('quote'))), Offset.zero);
    expect(
      tester.getTopLeft(find.byKey(const Key('reply'))),
      const Offset(0, 36),
    );
  });

  testWidgets('lines both up on the right for your own messages',
      (tester) async {
    await tester.pumpWidget(
      host(OverlapStack(back: quote, front: reply, alignEnd: true)),
    );
    expect(
      tester.getTopRight(find.byKey(const Key('quote'))).dx,
      tester.getTopRight(find.byKey(const Key('reply'))).dx,
    );
    expect(tester.getTopLeft(find.byKey(const Key('reply'))).dx, 50);
  });

  testWidgets('and on the left for them in a right-to-left language',
      (tester) async {
    await tester.pumpWidget(
      host(
        OverlapStack(back: quote, front: reply, alignEnd: true),
        direction: TextDirection.rtl,
      ),
    );
    expect(tester.getTopLeft(find.byKey(const Key('reply'))).dx, 0);
  });

  testWidgets('never overlaps more than the quote is tall', (tester) async {
    await tester.pumpWidget(
      host(
        OverlapStack(
          back: const SizedBox(key: Key('quote'), width: 80, height: 10),
          front: reply,
          overlap: 30,
        ),
      ),
    );
    // Swallowed whole would be 40 tall with the reply at y = -20.
    expect(tester.getSize(find.byType(OverlapStack)).height, 40);
    expect(tester.getTopLeft(find.byKey(const Key('reply'))).dy, 0);
  });

  testWidgets('a tap where they overlap reaches the reply on top',
      (tester) async {
    final taps = <String>[];
    await tester.pumpWidget(
      host(
        OverlapStack(
          back: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => taps.add('quote'),
            child: const SizedBox(width: 150, height: 50),
          ),
          front: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => taps.add('reply'),
            child: const SizedBox(width: 100, height: 40),
          ),
        ),
      ),
    );
    // Inside both: below the reply's top edge, above the quote's bottom.
    await tester.tapAt(const Offset(20, 45));
    expect(taps, ['reply']);
  });
}
