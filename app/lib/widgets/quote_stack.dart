// lib/widgets/quote_stack.dart
import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// A quoted message with the reply drawn over its lower edge.
///
/// How a reply reads in the apps people already message in: the message
/// being answered sits behind, muted, and the answer overlaps the bottom of
/// it, so the two read as one exchange rather than as a card with a line of
/// text under it.
///
/// None of Flutter's stock layouts can do this. A Column cannot overlap, a
/// Stack sizes to its largest child rather than to both, and a translated
/// child leaves the gap it moved out of behind it. So this is a small render
/// object: lay both out, put the front one [overlap] pixels up into the back
/// one, and be exactly as tall as what is drawn.
class QuoteStack extends MultiChildRenderObjectWidget {
  QuoteStack({
    super.key,
    required Widget quote,
    required Widget reply,
    this.overlap = 14,
    this.alignEnd = false,
  }) : super(children: [quote, reply]);

  /// How far the reply rides up over the quote. Never more than the quote is
  /// tall, so a one-line quote is not swallowed whole.
  final double overlap;

  /// True for the reader's own messages, which line up with the end of the
  /// row -- the right in English, the left in Arabic.
  final bool alignEnd;

  @override
  RenderQuoteStack createRenderObject(BuildContext context) => RenderQuoteStack(
        overlap: overlap,
        alignEnd: alignEnd,
        textDirection: Directionality.of(context),
      );

  @override
  void updateRenderObject(BuildContext context, RenderQuoteStack renderObject) {
    renderObject
      ..overlap = overlap
      ..alignEnd = alignEnd
      ..textDirection = Directionality.of(context);
  }
}

class _QuoteStackParentData extends ContainerBoxParentData<RenderBox> {}

class RenderQuoteStack extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _QuoteStackParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _QuoteStackParentData> {
  RenderQuoteStack({
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
    if (child.parentData is! _QuoteStackParentData) {
      child.parentData = _QuoteStackParentData();
    }
  }

  RenderBox get _quote => firstChild!;
  RenderBox get _reply => lastChild!;

  /// Whether children line up on the right-hand side.
  bool get _right => _alignEnd == (_textDirection == TextDirection.ltr);

  Size _measure(BoxConstraints constraints, {required bool dry}) {
    final loose = constraints.loosen();
    final quote = dry ? _quote.getDryLayout(loose) : _layout(_quote, loose);
    final reply = dry ? _reply.getDryLayout(loose) : _layout(_reply, loose);
    final overlap = math.min(_overlap, quote.height);
    return constraints.constrain(
      Size(
        math.max(quote.width, reply.width),
        quote.height + reply.height - overlap,
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
    final overlap = math.min(_overlap, _quote.size.height);

    double x(RenderBox child) => _right ? size.width - child.size.width : 0;

    (_quote.parentData! as _QuoteStackParentData).offset = Offset(x(_quote), 0);
    (_reply.parentData! as _QuoteStackParentData).offset =
        Offset(x(_reply), _quote.size.height - overlap);
  }

  @override
  double computeMinIntrinsicWidth(double height) => math.max(
        _quote.getMinIntrinsicWidth(double.infinity),
        _reply.getMinIntrinsicWidth(double.infinity),
      );

  @override
  double computeMaxIntrinsicWidth(double height) => math.max(
        _quote.getMaxIntrinsicWidth(double.infinity),
        _reply.getMaxIntrinsicWidth(double.infinity),
      );

  @override
  double computeMinIntrinsicHeight(double width) {
    final quote = _quote.getMinIntrinsicHeight(width);
    return quote +
        _reply.getMinIntrinsicHeight(width) -
        math.min(_overlap, quote);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final quote = _quote.getMaxIntrinsicHeight(width);
    return quote +
        _reply.getMaxIntrinsicHeight(width) -
        math.min(_overlap, quote);
  }

  // Painted in child order, so the reply is on top; hit-tested in reverse, so
  // a tap where they overlap lands on the reply, which is what is on top.
  @override
  void paint(PaintingContext context, Offset offset) =>
      defaultPaint(context, offset);

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);
}
