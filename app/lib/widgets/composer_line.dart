// lib/widgets/composer_line.dart
import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// How tall a composer's field is with one line in it, and so how tall the
/// buttons beside and inside it must be.
///
/// The message and reply bars line their buttons up along the bottom, so
/// that they stay on the last line as the field grows. That only centres them
/// on a one-line field if the buttons are exactly that field's height. They
/// were a fixed 40 points, and the field is 40 only at the default text size:
/// with the phone's text made larger it grows, and the +, the microphone and
/// the photo and GIF buttons sat low, below the middle of the box and of the
/// words in it.
///
/// [lineHeight] is the field's line height multiplier and [padding] its
/// vertical content padding, top plus bottom -- the two numbers the field is
/// built with, so this is its height and not a guess at it.
double composerLineHeight(
  BuildContext context, {
  required double lineHeight,
  double fontSize = TypographyTokens.fontSize3,
  double padding = 20,
  double floor = 40,
}) {
  final text = MediaQuery.textScalerOf(context).scale(fontSize) * lineHeight;
  return math.max(floor, (text + padding).ceilToDouble());
}
