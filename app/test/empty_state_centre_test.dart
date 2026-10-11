import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/empty_state.dart';

/// An empty state sits in the middle of the width it is given, whatever the
/// length of what it says.
///
/// It used to sit at the left edge, as wide as its widest line. Search with
/// no results said "Nothing on Kyron matches "turrr"" a third of the way
/// across the screen, while the idle state -- whose detail wraps -- looked
/// centred.
void main() {
  for (final (label, detail) in [
    ('a short detail', 'Nothing on Kyron matches "turrr"'),
    (
      'a long one',
      'Words, or a filter — an account, a date range, or what a post carries.',
    ),
  ]) {
    testWidgets('is centred with $label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              art: EmptyArt.noMatch,
              title: 'Nothing matched',
              detail: detail,
            ),
          ),
        ),
      );

      final screen = tester.getSize(find.byType(Scaffold)).width;
      expect(
        tester.getCenter(find.text('Nothing matched')).dx,
        closeTo(screen / 2, 1),
      );
      expect(tester.getCenter(find.text(detail)).dx, closeTo(screen / 2, 1));
    });
  }
}
