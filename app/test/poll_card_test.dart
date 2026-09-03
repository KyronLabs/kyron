import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/poll.dart';
import 'package:kyron_app/widgets/poll_card.dart';

Poll _poll({
  String? voted,
  bool closed = false,
  int yes = 3,
  int no = 1,
}) =>
    Poll(
      id: 'poll-1',
      closesAt: DateTime.now().add(const Duration(hours: 12)),
      closed: closed,
      totalVotes: yes + no,
      votedOptionId: voted,
      options: [
        PollOption(id: 'o1', text: 'Yes', votes: yes),
        PollOption(id: 'o2', text: 'No', votes: no),
      ],
    );

Future<void> _pump(WidgetTester tester, Poll poll, {double scale = 1.0}) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(scale)),
            child: SizedBox(
              width: 360,
              child: PollCard(postId: 'p1', poll: poll),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

/// The rendered height of the row carrying [label].
double _rowHeight(WidgetTester tester, String label) {
  final row = find.ancestor(
    of: find.text(label).first,
    matching: find.byType(ClipRRect),
  );
  return tester.getSize(row.first).height;
}

void main() {
  testWidgets('draws each answer twice, once per colour scheme',
      (tester) async {
    // The bar is one layer on the track and one on the fill, clipped to the
    // share. A label straddling the boundary is legible on both sides only
    // because both layers exist.
    await _pump(tester, _poll());

    expect(find.text('Yes'), findsNWidgets(2));
    expect(find.text('No'), findsNWidgets(2));
  });

  testWidgets('states each answer\'s share', (tester) async {
    await _pump(tester, _poll(yes: 3, no: 1));

    expect(find.text('75%'), findsNWidgets(2));
    expect(find.text('25%'), findsNWidgets(2));
  });

  testWidgets('a bar fills the width it is given', (tester) async {
    await _pump(tester, _poll());

    final row = find
        .ancestor(of: find.text('Yes').first, matching: find.byType(ClipRRect))
        .first;
    expect(tester.getSize(row).width, 360);
  });

  testWidgets('a row is tall enough to read and to press', (tester) async {
    await _pump(tester, _poll());
    expect(_rowHeight(tester, 'Yes'), greaterThanOrEqualTo(48));
  });

  testWidgets('a row grows with the text rather than cropping it',
      (tester) async {
    // A fixed height crops the answer at a larger text size, which is what
    // the old 38-pixel row did.
    await _pump(tester, _poll(), scale: 1.6);

    expect(_rowHeight(tester, 'Yes'), greaterThan(48));
    expect(tester.takeException(), isNull);
  });

  testWidgets('says how to take a vote back, once there is one to take',
      (tester) async {
    await _pump(tester, _poll(voted: 'o1'));
    expect(
      find.text('Tap your answer again to take your vote back.'),
      findsOneWidget,
    );
  });

  testWidgets('says nothing about taking a vote back before you have voted',
      (tester) async {
    await _pump(tester, _poll());
    expect(
      find.text('Tap your answer again to take your vote back.'),
      findsNothing,
    );
  });

  testWidgets('offers no way out once voting has closed', (tester) async {
    await _pump(tester, _poll(voted: 'o1', closed: true));
    expect(
      find.text('Tap your answer again to take your vote back.'),
      findsNothing,
    );
    expect(find.textContaining('Final results'), findsOneWidget);
  });

  testWidgets('counts the votes in words', (tester) async {
    await _pump(tester, _poll(yes: 1, no: 0));
    expect(find.textContaining('1 vote  \u00b7'), findsOneWidget);

    await _pump(tester, _poll(yes: 2, no: 0));
    expect(find.textContaining('2 votes  \u00b7'), findsOneWidget);
  });

  testWidgets('the footer wraps rather than running off the edge',
      (tester) async {
    // Three texts in a row had nothing to give way, so at a larger text size
    // the time remaining ran past the right edge of the card.
    await _pump(tester, _poll(), scale: 1.6);
    expect(tester.takeException(), isNull);
  });
}
