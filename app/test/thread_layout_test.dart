import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_comment.dart';
import 'package:kyron_app/utils/thread_layout.dart';
import 'package:kyron_app/widgets/thread.dart';

PostComment c(String id, {String? parent}) => PostComment(
      id: id,
      content: id,
      createdAt: DateTime(2026),
      author: const FeedAuthor(id: 'a', name: 'A', username: 'a'),
      parentId: parent,
    );

/// Everything, so the layout reflects the tree rather than the fold rule.
const all = 1 << 30;

void main() {
  group('buildThreadLayout', () {
    test('depth follows the parent chain', () {
      final layout = buildThreadLayout(
        [c('a'), c('b', parent: 'a'), c('c', parent: 'b')],
        collapseAfter: all,
      );

      expect(layout.rows.map((r) => r.comment.id), ['a', 'b', 'c']);
      expect(layout.rows.map((r) => r.depth), [0, 1, 2]);
    });

    test('a childless comment trails no rail', () {
      // The bug this guards: a rail under a comment with no replies runs on
      // and appears to join it to the next, unrelated, comment.
      final layout = buildThreadLayout([c('a'), c('b')], collapseAfter: all);

      expect(layout.rows.every((r) => !r.hasChildrenBelow), isTrue);
    });

    test('a parent rail stops at its last child', () {
      final layout = buildThreadLayout(
        [c('a'), c('b', parent: 'a'), c('d', parent: 'a')],
        collapseAfter: all,
      );

      expect(layout.rows[1].isLastChild, isFalse);
      expect(layout.rows[2].isLastChild, isTrue);
    });

    test('top-level comments are separate conversations', () {
      // Passing the sibling flag down at depth 0 drew a rail beside every
      // nested reply running on to the next top-level comment.
      final layout = buildThreadLayout(
        [c('a'), c('b', parent: 'a'), c('second')],
        collapseAfter: all,
      );

      expect(layout.rows[1].ancestorRails, [false]);
    });

    test('an orphan is promoted rather than dropped', () {
      final layout =
          buildThreadLayout([c('x', parent: 'gone')], collapseAfter: all);

      expect(layout.rows.single.depth, 0);
    });

    test('a comment claiming itself as its parent still appears', () {
      final layout =
          buildThreadLayout([c('loop', parent: 'loop')], collapseAfter: all);

      expect(layout.rows.single.comment.id, 'loop');
    });

    test('nested runs fold, top-level ones never do', () {
      final layout = buildThreadLayout([
        c('a'),
        c('b'),
        c('a1', parent: 'a'),
      ]);

      expect(layout.rows.map((r) => r.comment.id), ['a', 'b']);
      expect(layout.collapsed.values.single.hidden.single.id, 'a1');
    });

    test('opening a folded run shows it', () {
      final layout = buildThreadLayout(
        [c('a'), c('a1', parent: 'a')],
        expanded: {'a'},
      );

      expect(layout.rows.map((r) => r.comment.id), ['a', 'a1']);
    });
  });

  group('ThreadConnectorPlan', () {
    ThreadConnectorPlan plan({
      required int depth,
      List<bool> rails = const [],
      bool children = false,
      bool last = true,
    }) =>
        ThreadConnectorPlan.forRow(
          depth: depth,
          ancestorRails: rails,
          hasChildrenBelow: children,
          isLastChild: last,
          avatarSize: ThreadGeometry.avatar,
        );

    test('a top-level row has no elbow', () {
      expect(plan(depth: 0).elbow, isNull);
    });

    test('a reply turns out of its parent column into its own', () {
      final elbow = plan(depth: 1).elbow!;

      expect(elbow.x, ThreadGeometry.columnFor(0));
      expect(elbow.endX, ThreadGeometry.indentFor(1));
      expect(elbow.turnY, ThreadGeometry.avatar / 2);
    });

    test('the parent rail carries on past a middle child only', () {
      expect(plan(depth: 1, last: false).parentRailBelowX,
          ThreadGeometry.columnFor(0));
      expect(plan(depth: 1).parentRailBelowX, isNull);
    });

    test('a row draws its own rail only when replies follow it', () {
      expect(plan(depth: 0).ownRailX, isNull);
      expect(
          plan(depth: 0, children: true).ownRailX, ThreadGeometry.columnFor(0));
    });

    test('an ancestor rail sits one column left of the ancestor', () {
      // Drawn at the ancestor's own column it hangs under a reply's avatar
      // and runs down to that reply's aunt, as though the two were related.
      final p = plan(depth: 2, rails: const [false, true]);

      expect(p.railXs, [ThreadGeometry.columnFor(0)]);
    });

    test('past the indent cap the elbow is dropped, not inverted', () {
      // Parent and child share a column there, so there is no gap to cross;
      // an elbow drawn anyway hooks right and comes back through the avatar.
      final deep = plan(depth: ThreadGeometry.maxIndent + 2);

      expect(deep.elbow, isNull);
    });

    test('rails never land on top of the row own avatar', () {
      final p = plan(
        depth: ThreadGeometry.maxIndent + 1,
        rails: List.filled(ThreadGeometry.maxIndent + 1, true),
      );

      for (final x in p.railXs) {
        expect(x, lessThan(ThreadGeometry.indentFor(ThreadGeometry.maxIndent)));
      }
    });

    test('the corner never exceeds the space it has to turn in', () {
      final elbow = plan(depth: 1).elbow!;

      expect(elbow.radius, lessThanOrEqualTo(elbow.endX - elbow.x));
      expect(elbow.radius, lessThanOrEqualTo(elbow.turnY));
    });
  });
}
