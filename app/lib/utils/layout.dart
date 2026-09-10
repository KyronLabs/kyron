// lib/utils/layout.dart
import 'package:flutter/widgets.dart';

/// Where Kyron stops being a phone.
///
/// The app was drawn for one hand: a bar across the bottom, a drawer that
/// arrives on a swipe, and one column of posts as wide as the screen. On a
/// desktop window none of those are right -- the bottom of a 1280-wide window
/// is nowhere near the pointer, a swipe is not a gesture a mouse makes, and a
/// column of text that wide is harder to read rather than easier.
abstract final class Layout {
  /// The width at which navigation moves to a rail down the side.
  ///
  /// Chosen so a window has room for the rail and a full reading column beside
  /// it with margins: 260 + 620 + gutters. Narrower than this and the rail is
  /// taking space the posts need, so the phone layout is the better one -- and
  /// a Windows window dragged narrow gets it, which is the point of measuring
  /// the window rather than asking which platform this is.
  static const double railAt = 900;

  /// How wide the rail is when there is one.
  static const double railWidth = 260;

  /// The widest a column of posts gets, however much window there is.
  ///
  /// Past roughly this the eye loses the start of the next line on the way
  /// back from the end of the last one. Every reading surface uses it, so a
  /// maximised window shows a column with space around it rather than
  /// sentences running the width of a monitor.
  static const double readingWidth = 620;

  /// Whether this window is wide enough for the rail.
  static bool hasRail(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= railAt;

  /// The margin each side of a column of [measure] points inside [width].
  ///
  /// Zero when there is no room to spare, which is every phone, so a narrow
  /// screen keeps exactly the layout it had.
  static double gutter(double width, double measure) {
    final spare = (width - measure) / 2;
    return spare.isFinite && spare > 0 ? spare : 0;
  }
}
