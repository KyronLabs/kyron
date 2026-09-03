// lib/widgets/answer_shape.dart
import 'package:kyron_design_system/kyron_design_system.dart';

/// The shape of a row that states one thing.
///
/// A poll answer and a toast are the same object seen twice: a solid rounded
/// bar, tall enough to read and to press, saying one thing. Drawing them at
/// the same size is what makes the second one read as something the app
/// already showed you rather than as a new kind of box.
///
/// Named here rather than on either of them so neither has to import the
/// other to agree with it.
abstract final class AnswerShape {
  /// A minimum rather than a fixed height: at a larger text size a fixed row
  /// crops what is written inside it.
  static const double minHeight = 52;

  static const double radius = RadiusTokens.radiusLg;
}
