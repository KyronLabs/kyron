// lib/utils/thread_layout.dart
//
// Turns a flat comment list into the rows a thread actually renders.
//
// Comments arrive flat, each carrying a parentId, which says nothing about how
// to draw them. Every rendered row needs three things the flat list does not
// carry, and all three are about connectors:
//
//   * its depth, for the indent;
//   * whether it has replies rendered directly beneath it, so a row with none
//     does not trail a dangling rail into an unrelated comment;
//   * for every ancestor, whether that ancestor's thread continues past this
//     row, so the rail passing on the left is drawn only where a sibling is
//     still to come.
//
// Kept out of the widget so it can be tested as a pure function, which matters
// because a connector bug is invisible to a smoke test.
import '../models/post_comment.dart';

/// One rendered row of a thread.
class ThreadRow {
  final PostComment comment;

  /// 0 for a top-level comment, 1 for a reply to it, and so on.
  final int depth;

  /// For ancestor levels 0 … depth-1: does that ancestor still have a later
  /// sibling, so its rail passes this row?
  final List<bool> ancestorRails;

  /// Whether replies to this row are rendered immediately below it. False for
  /// a childless comment -- the case that draws a rail to nowhere.
  final bool hasChildrenBelow;

  /// Whether this is its parent's final child, which is what tells the
  /// parent's rail to stop at this row's elbow.
  final bool isLastChild;

  const ThreadRow({
    required this.comment,
    required this.depth,
    required this.ancestorRails,
    required this.hasChildrenBelow,
    required this.isLastChild,
  });
}

/// A node whose replies are folded behind a "show replies" row.
class ThreadCollapsed {
  final String parentId;
  final int depth;
  final List<PostComment> hidden;
  final List<bool> ancestorRails;

  const ThreadCollapsed({
    required this.parentId,
    required this.depth,
    required this.hidden,
    required this.ancestorRails,
  });
}

/// The flattened thread: rows in render order, and the folded runs between
/// them keyed by the row index they follow.
class ThreadLayout {
  final List<ThreadRow> rows;
  final Map<int, ThreadCollapsed> collapsed;

  const ThreadLayout({required this.rows, required this.collapsed});
}

/// Build the render order for [comments].
///
/// [expanded] holds the comment ids whose folded runs have been opened.
///
/// [collapseAfter] is how many answers a comment shows before the rest are
/// held back. Zero by default: a comment's answers are folded until asked for,
/// because a conversation is browsed at the level of comments and three chatty
/// exchanges should not push the fourth comment off the screen. A chain of
/// single replies is exactly the case a "more than three" rule never folds,
/// and exactly the case that grows longest.
ThreadLayout buildThreadLayout(
  List<PostComment> comments, {
  Set<String> expanded = const {},
  int collapseAfter = 0,
}) {
  final byParent = <String?, List<PostComment>>{};
  final ids = {for (final c in comments) c.id};

  for (final comment in comments) {
    // An orphan -- its parent deleted, or hidden by a block -- is promoted to
    // top level rather than dropped, so nothing silently disappears. So is a
    // comment claiming itself as its own parent: it would otherwise be filed
    // under a node the walk can never reach, and vanish from the thread.
    final parentId = comment.parentId;
    final parent =
        (parentId != null && parentId != comment.id && ids.contains(parentId))
            ? parentId
            : null;
    byParent.putIfAbsent(parent, () => []).add(comment);
  }

  final rows = <ThreadRow>[];
  final collapsed = <int, ThreadCollapsed>{};
  // A cycle among parent ids would otherwise recurse until the stack gives
  // out. Server data should not contain one, but a thread renderer is not the
  // place to find out that it does.
  final walked = <String>{};

  void walk(String? parentId, int depth, List<bool> ancestorRails) {
    if (parentId != null && !walked.add(parentId)) return;
    final children = byParent[parentId] ?? const <PostComment>[];
    // Only nested runs fold. Top-level comments are the conversation itself,
    // and hiding them behind a tap would hide the whole thread.
    final shouldCollapse = depth > 0 &&
        parentId != null &&
        children.length > collapseAfter &&
        !expanded.contains(parentId);
    final shown =
        shouldCollapse ? children.take(collapseAfter).toList() : children;

    for (var i = 0; i < shown.length; i++) {
      final child = shown[i];
      final isLast = i == shown.length - 1;
      final grandChildren = byParent[child.id] ?? const <PostComment>[];

      // A run ending in a folded marker is not really finished, so the
      // parent's rail has to carry on to reach it.
      final moreAfterThis = !isLast || (shouldCollapse && isLast);

      rows.add(ThreadRow(
        comment: child,
        depth: depth,
        ancestorRails: List.unmodifiable(ancestorRails),
        hasChildrenBelow: grandChildren.isNotEmpty,
        isLastChild: !moreAfterThis,
      ));

      // Top-level comments are separate conversations, not siblings in one
      // thread. Passing `moreAfterThis` down at depth 0 draws a rail beside
      // every nested reply that runs on to the next unrelated comment,
      // stitching two of them together. Below the root, a sibling still to
      // come is exactly what a passing rail means.
      final railContinues = depth > 0 && moreAfterThis;
      walk(child.id, depth + 1, [...ancestorRails, railContinues]);
    }

    if (shouldCollapse) {
      collapsed[rows.length - 1] = ThreadCollapsed(
        parentId: parentId,
        depth: depth,
        hidden: children.skip(shown.length).toList(),
        ancestorRails: List.unmodifiable(ancestorRails),
      );
    }
  }

  walk(null, 0, const []);
  return ThreadLayout(rows: rows, collapsed: collapsed);
}

/// The flat list a post's comment thread renders, from the comments loaded
/// and whichever reply runs have been opened.
///
/// Runs are admitted outwards from the comments already in, never by walking
/// [expanded] on its own. A run whose own parent is not in the list has
/// nothing to hang under, and [buildThreadLayout] promotes a comment it cannot
/// find a parent for to the top level -- so a reply to a reply surfaced as a
/// top-level comment of its own, which is what made a reply look as though it
/// had been posted against the wrong person.
List<PostComment> assembleThread({
  required List<PostComment> comments,
  required Map<String, List<PostComment>> replies,
  required Set<String> expanded,
}) {
  final flat = <PostComment>[...comments];
  final present = {for (final c in flat) c.id};
  final pending = {
    for (final run in replies.entries)
      if (expanded.contains(run.key)) run.key: run.value,
  };

  // Each pass admits the runs whose parent has just arrived. It ends when a
  // pass admits nothing, which leaves a run orphaned by a collapse -- or by a
  // parent that was never loaded -- out rather than at the top.
  var admitted = true;
  while (admitted) {
    admitted = false;
    for (final key in pending.keys.toList()) {
      if (!present.contains(key)) continue;
      final run = pending.remove(key)!;
      flat.addAll(run);
      present.addAll(run.map((c) => c.id));
      admitted = true;
    }
  }
  return flat;
}
