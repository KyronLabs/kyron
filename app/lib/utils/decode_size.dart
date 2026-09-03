// lib/utils/decode_size.dart
import 'package:flutter/widgets.dart';

/// How wide to decode an image that will be drawn at [fraction] of the screen.
///
/// Without this, `Image.network` decodes at the file's own size: a photograph
/// off a phone camera is four thousand pixels across, which is a fifty-megabyte
/// bitmap held to fill a tile four hundred pixels wide. Half a dozen of those
/// in a feed is what a scroll spends its frame budget on.
///
/// Answers in physical pixels, because that is what the decoder wants, and
/// caps at [maxWidth] so an unusually large screen cannot ask for more than
/// any of these pictures actually is.
int decodeWidth(
  BuildContext context, {
  double fraction = 1.0,
  int maxWidth = 1440,
}) {
  final logical = MediaQuery.sizeOf(context).width * fraction;
  final physical = logical * MediaQuery.devicePixelRatioOf(context);
  // A floor, so a tile measured before layout does not ask for a thumbnail.
  return physical.round().clamp(320, maxWidth);
}
