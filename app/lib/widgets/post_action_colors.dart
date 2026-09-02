// lib/widgets/post_action_colors.dart
import 'package:flutter/material.dart';

/// What each post action turns when you have used it.
///
/// Fixed colours rather than slots off the colour scheme. The three actions
/// need to be told apart from each other at a glance and from anything else on
/// the card, and `scheme.tertiary` and `scheme.error` drift with the theme --
/// a repost and a like both came out reddish in dark mode.
///
/// One place, because these appear on the card, on the post screen, and in the
/// options sheet, and three copies of a hex value drift.
abstract final class PostActionColors {
  /// Green: the post moved on to somebody else's timeline.
  static const repost = Color(0xFF00BA7C);

  /// Red, and properly red rather than the theme's error tint, which is
  /// pinker and reads as a warning.
  static const like = Color(0xFFF4212E);

  /// Amber: kept for later, like a bookmark's flag.
  static const save = Color(0xFFFFB800);

  /// The colour a hashtag gets when a screen is showing that tag, so the one
  /// you searched for stands out among the others on a post.
  static const highlight = Color(0xFFFFE14D);
}
