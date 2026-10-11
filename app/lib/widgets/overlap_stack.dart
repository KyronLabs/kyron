// lib/widgets/overlap_stack.dart
import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// One thing drawn over the lower edge of another, and exactly as tall as both.
///
/// Chats use this shape twice. A reply: the message being answered sits
/// behind, muted, and the answer overlaps the bottom of it, so the two read as
/// one exchange rather than a card with a line of text under it. And a
/// reaction: the little ❤️ pill that sits on the bottom corner of a bubble.
///
/// None of Flutter's stock layouts can do this. A Column cannot overlap, a
/// Stack sizes to its largest child rather than to both, and a translated
/// child leaves the gap it moved out of behind it. So this is a small render
/// object: lay both out, put [front] [overlap] pixels up into [back], and be
/// exactly as tall as what is drawn.
class OverlapStack extends MultiChildRenderObjectWidget {
  OverlapStack({
    super.key,
    required Widget back,
    required Widget front,
    this.overlap = 14,
    this.alignEnd = false,
  }) : super(children: [back, front]);

  /// How far [front] rides up over [back]. Never more than [back] is tall, so
  /// a short one is not swallowed whole.
  final double overlap;

  /// True to line both up with the end of the row -- the right in English, the
  /// left in Arabic -- as the reader's own messages are.
  final bool alignEnd;

  @override
  RenderOverlapStack createRenderObject(BuildContext context) =>
      RenderOverlapStack(
        overlap: overlap,
        alignEnd: alignEnd,
        textDirection: Directionality.of(context),
      );

  @override
  void updateRenderObject(
      BuildContext context, RenderOverlapStack renderObject) {
    renderObject
      ..overlap = overlap
      ..alignEnd = alignEnd
      ..textDirection = Directionality.of(context);
  }
}

class _OverlapStackParentData extends ContainerBoxParentData<RenderBox> {}

class RenderOverlapStack extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _OverlapStackParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _OverlapStackParentData> {
  RenderOverlapStack({
    required double overlap,
    required bool alignEnd,
    required TextDirection textDirection,
  })  : _overlap = overlap,
        _alignEnd = alignEnd,
        _textDirection = textDirection;

  double _overlap;
  set overlap(double value) {
    if (value == _overlap) return;
    _overlap = value;
    markNeedsLayout();
  }

  bool _alignEnd;
  set alignEnd(bool value) {
    if (value == _alignEnd) return;
    _alignEnd = value;
    markNeedsLayout();
  }

  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    if (value == _textDirection) return;
    _textDirection = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _OverlapStackParentData) {
      child.parentData = _OverlapStackParentData();
    }
  }

  RenderBox get _back => firstChild!;
  RenderBox get _front => lastChild!;

  /// Whether children line up on the right-hand side.
  bool get _right => _alignEnd == (_textDirection == TextDirection.ltr);

  Size _measure(BoxConstraints constraints, {required bool dry}) {
    final loose = constraints.loosen();
    final back = dry ? _back.getDryLayout(loose) : _layout(_back, loose);
    final front = dry ? _front.getDryLayout(loose) : _layout(_front, loose);
    final overlap = math.min(_overlap, back.height);
    return constraints.constrain(
      Size(
        math.max(back.width, front.width),
        back.height + front.height - overlap,
      ),
    );
  }

  Size _layout(RenderBox child, BoxConstraints constraints) {
    child.layout(constraints, parentUsesSize: true);
    return child.size;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) =>
      _measure(constraints, dry: true);

  @override
  void performLayout() {
    size = _measure(constraints, dry: false);
    final overlap = math.min(_overlap, _back.size.height);

    double x(RenderBox child) => _right ? size.width - child.size.width : 0;

    (_back.parentData! as _OverlapStackParentData).offset = Offset(x(_back), 0);
    (_front.parentData! as _OverlapStackParentData).offset =
        Offset(x(_front), _back.size.height - overlap);
  }

  @override
  double computeMinIntrinsicWidth(double height) => math.max(
        _back.getMinIntrinsicWidth(double.infinity),
        _front.getMinIntrinsicWidth(double.infinity),
      );

  @override
  double computeMaxIntrinsicWidth(double height) => math.max(
        _back.getMaxIntrinsicWidth(double.infinity),
        _front.getMaxIntrinsicWidth(double.infinity),
      );

  @override
  double computeMinIntrinsicHeight(double width) {
    final back = _back.getMinIntrinsicHeight(width);
    return back +
        _front.getMinIntrinsicHeight(width) -
        math.min(_overlap, back);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final back = _back.getMaxIntrinsicHeight(width);
    return back +
        _front.getMaxIntrinsicHeight(width) -
        math.min(_overlap, back);
  }

  // Painted in child order, so [front] is on top; hit-tested in reverse, so a
  // tap where they overlap lands on [front], which is what is on top.
  @override
  void paint(PaintingContext context, Offset offset) =>
      defaultPaint(context, offset);

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);
}
