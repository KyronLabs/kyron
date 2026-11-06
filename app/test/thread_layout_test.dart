import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_comment.dart';
import 'package:kyron_app/utils/thread_layout.dart';
import 'package:kyron_app/widgets/thread.dart';

PostComment c(String id, {String? parent, int replies = 0}) => PostComment(
      id: id,
      content: id,
      createdAt: DateTime(2026),
      author: const FeedAuthor(id: 'a', name: 'A', username: 'a'),
      parentId: parent,
      replies: replies,
    );

/// Everything, so the layout reflects the tree rather than the fold rule.
const all = 1 << 30;

void main() {
  group('capBranches: a conversation on the post page is a preview', () {
    List<String> ids(CappedThread t) => t.comments.map((x) => x.id).toList();

    test('shows the first three replies, depth first, then a way to the rest',
        () {
      final t = capBranches([
        c('a', replies: 3),
        c('b', parent: 'a', replies: 2),
        c('c', parent: 'a'),
        c('d', parent: 'a'),
        c('b1', parent: 'b'),
        c('b2', parent: 'b'),
      ]);

      // b, then what answers b, before a's next reply: the order the thread
      // reads in. d and b2 are past the three.
      expect(ids(t), ['a', 'b', 'b1', 'b2', 'more:a']);
      expect(t.full, {'a'});
      // The stand-in is the conversation's last reply, so its rail ends there.
      final layout = buildThreadLayout(t.comments, collapseAfter: all);
      expect(layout.rows.last.comment.id, 'more:a');
      expect(layout.rows.last.depth, 1);
      expect(layout.rows.last.isLastChild, isTrue);
    });

    test('a conversation that fits has no stand-in', () {
      final t = capBranches([
        c('a', replies: 2),
        c('b', parent: 'a'),
        c('c', parent: 'a'),
        c('z'),
      ]);
      expect(ids(t), ['a', 'b', 'c', 'z']);
      expect(t.full, isEmpty);
      expect(t.branchOf['c'], 'a');
    });

    test('at the limit, a reply with folded answers still sends you on', () {
      final t = capBranches([
        c('a', replies: 3),
        c('b', parent: 'a'),
        c('c', parent: 'a'),
        c('d', parent: 'a', replies: 4),
      ]);
      expect(ids(t).last, 'more:a');
      expect(t.full, {'a'});
    });

    test('more answers on the server than were loaded send you on too', () {
      final t = capBranches([c('a', replies: 9), c('b', parent: 'a')]);
      expect(ids(t), ['a', 'b', 'more:a']);
      // Room left, so b may still unfold its own answers here.
      expect(t.full, isEmpty);
    });

    test('a comment not yet opened is left to its own "show replies"', () {
      final t = capBranches([c('a', replies: 12)]);
      expect(ids(t), ['a']);
    });
  });

  group('buildThreadLayout', () {
    test('depth follows the parent chain', () {
      final layout = buildThreadLayout([
        c('a'),
        c('b', parent: 'a'),
        c('c', parent: 'b'),
      ], collapseAfter: all);

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
      final layout = buildThreadLayout([
        c('a'),
        c('b', parent: 'a'),
        c('d', parent: 'a'),
      ], collapseAfter: all);

      expect(layout.rows[1].isLastChild, isFalse);
      expect(layout.rows[2].isLastChild, isTrue);
    });

    test('top-level comments are separate conversations', () {
      // Passing the sibling flag down at depth 0 drew a rail beside every
      // nested reply running on to the next top-level comment.
      final layout = buildThreadLayout([
        c('a'),
        c('b', parent: 'a'),
        c('second'),
      ], collapseAfter: all);

      expect(layout.rows[1].ancestorRails, [false]);
    });

    test('an orphan is promoted rather than dropped', () {
      final layout = buildThreadLayout([
        c('x', parent: 'gone'),
      ], collapseAfter: all);

      expect(layout.rows.single.depth, 0);
    });

    test('a comment claiming itself as its parent still appears', () {
      final layout = buildThreadLayout([
        c('loop', parent: 'loop'),
      ], collapseAfter: all);

      expect(layout.rows.single.comment.id, 'loop');
    });

    test('nested runs fold, top-level ones never do', () {
      final layout = buildThreadLayout([c('a'), c('b'), c('a1', parent: 'a')]);

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
      // Just short of the reply's face, so it arrives at it.
      expect(
        elbow.endX,
        ThreadGeometry.indentFor(1) - ThreadGeometry.elbowGap,
      );
      expect(elbow.turnY, ThreadGeometry.avatar / 2);
    });

    test('the parent rail carries on past a middle child only', () {
      expect(
        plan(depth: 1, last: false).parentRailBelowX,
        ThreadGeometry.columnFor(0),
      );
      expect(plan(depth: 1).parentRailBelowX, isNull);
    });

    test('a row draws its own rail only when replies follow it', () {
      expect(plan(depth: 0).ownRailX, isNull);
      expect(
        plan(depth: 0, children: true).ownRailX,
        ThreadGeometry.columnFor(0),
      );
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

    test('past the cap the parent rail runs on into the reply, and on past it',
        () {
      // There is no elbow there, so this is all that joins a reply to the
      // comment above it. A middle child let the rail stop at its own top,
      // and the next sibling hung from nothing.
      const depth = ThreadGeometry.maxIndent + 1;
      final column = ThreadGeometry.columnFor(depth - 1);

      final middle = plan(depth: depth, last: false);
      expect(middle.elbow, isNull);
      expect(middle.leadInX, column);
      expect(middle.parentRailBelowX, column);

      final last = plan(depth: depth);
      expect(last.leadInX, column);
      expect(last.parentRailBelowX, isNull);

      // Inside the cap there is an elbow, and nothing else to join them.
      expect(plan(depth: 1).leadInX, isNull);
    });

    testWidgets(
        "past the cap a folded branch's faces sit centred on the rail above",
        (tester) async {
      // At the cap the rail comes straight down the column. Faces narrower
      // than an avatar that start at the column's left edge hang off it.
      const depth = ThreadGeometry.maxIndent + 1;
      const face = 20.0;
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 300,
              child: ThreadItem(
                depth: depth,
                ancestorRails: [],
                hasChildrenBelow: false,
                isLastChild: true,
                avatarSize: face,
                avatar: SizedBox.square(
                  key: ValueKey('face'),
                  dimension: face,
                ),
                child: SizedBox(height: face),
              ),
            ),
          ),
        ),
      );

      final centre = tester.getCenter(find.byKey(const ValueKey('face')));
      expect(centre.dx, ThreadGeometry.columnFor(depth - 1));
    });

    test('the corner never exceeds the space it has to turn in', () {
      final elbow = plan(depth: 1).elbow!;

      expect(elbow.radius, lessThanOrEqualTo(elbow.endX - elbow.x));
      expect(elbow.radius, lessThanOrEqualTo(elbow.turnY));
    });
  });

  group('assembleThread', () {
    test('admits a run once its own parent is in the list', () {
      // b is a reply to a; c is a reply to b. Both runs are open.
      final flat = assembleThread(
        comments: [c('a')],
        replies: {
          'a': [c('b', parent: 'a')],
          'b': [c('c', parent: 'b')],
        },
        expanded: {'a', 'b'},
      );

      final layout = buildThreadLayout(flat, collapseAfter: all);
      expect(layout.rows.map((r) => r.comment.id), ['a', 'b', 'c']);
      expect(layout.rows.map((r) => r.depth), [0, 1, 2]);
    });

    test('leaves out a run whose parent is not on screen', () {
      // The run under b is still cached, but a has been collapsed, so b is
      // nowhere. Letting c through would promote it to a top-level comment --
      // a reply appearing as though it were addressed to the post.
      final flat = assembleThread(
        comments: [c('a')],
        replies: {
          'a': [c('b', parent: 'a')],
          'b': [c('c', parent: 'b')],
        },
        expanded: {'b'},
      );

      expect(flat.map((x) => x.id), ['a']);

      final layout = buildThreadLayout(flat, collapseAfter: all);
      expect(layout.rows.every((r) => r.depth == 0), isTrue);
      expect(layout.rows.map((r) => r.comment.id), ['a']);
    });

    test('order does not decide what gets in', () {
      // The deepest run is listed first. A single pass over the map would
      // drop it; the walk keeps going until nothing new is admitted.
      final flat = assembleThread(
        comments: [c('a')],
        replies: {
          'c': [c('d', parent: 'c')],
          'b': [c('c', parent: 'b')],
          'a': [c('b', parent: 'a')],
        },
        expanded: {'a', 'b', 'c'},
      );

      expect(flat.map((x) => x.id).toSet(), {'a', 'b', 'c', 'd'});
      expect(
        buildThreadLayout(flat, collapseAfter: all).rows.map((r) => r.depth),
        [0, 1, 2, 3],
      );
    });
  });

  group('endsBranch', () {
    // The tree from the screenshots: one branch three deep, then two
    // comments of their own.
    final rows = buildThreadLayout([
      c('c1'),
      c('c2', parent: 'c1'),
      c('c3', parent: 'c2'),
      c('c4'),
      c('c5'),
    ], collapseAfter: all)
        .rows;

    test('the rows come out in the order the screen draws them', () {
      expect(rows.map((r) => r.comment.id), ['c1', 'c2', 'c3', 'c4', 'c5']);
      expect(rows.map((r) => r.depth), [0, 1, 2, 0, 0]);
    });

    test('no rule inside a branch', () {
      // Between a comment and its own reply is the one place a rule must not
      // land: it reads as the end of the conversation it is in the middle of.
      expect(endsBranch(rows, 0), isFalse);
      expect(endsBranch(rows, 1), isFalse);
    });

    test('a rule where the next branch starts', () {
      expect(endsBranch(rows, 2), isTrue);
      expect(endsBranch(rows, 3), isTrue);
    });

    test('no rule after the last row', () {
      // The composer below it is its own edge.
      expect(endsBranch(rows, 4), isFalse);
    });

    test('a single comment with a reply gets no rule at all', () {
      final one = buildThreadLayout([
        c('a'),
        c('b', parent: 'a'),
      ], collapseAfter: all)
          .rows;

      expect(one.every((r) => !endsBranch(one, one.indexOf(r))), isTrue);
    });
  });
}
