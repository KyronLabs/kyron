// lib/widgets/app_sheet.dart
import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// The bar at the top of a sheet that says it can be pulled down.
///
/// Material's own (`showDragHandle`) centres a four-pixel bar in a box 48
/// tall -- the size of a tap target, for a bar nobody taps -- which left 22
/// pixels of nothing above it and 22 under it before the sheet's first line,
/// on every sheet in the app. The handful of sheets that drew their own had
/// their own gaps: 10, 12, 16, 20. This is one bar, with eight above and
/// eight under.
class SheetHandle extends StatelessWidget {
  /// Whether a screen reader's tap on it closes the sheet. Not for a sheet
  /// that must be closed with its own buttons -- a recording under way.
  final bool dismissible;

  const SheetHandle({super.key, this.dismissible = true});

  static const double width = 36;
  static const double thickness = 4;

  /// Above the bar and under it.
  static const double gap = 8;

  /// All of it: the room a sheet leaves at its top for the handle.
  static const double height = gap + thickness + gap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // Material's own colour for it, so it reads the same as it did.
    final colour = Theme.of(context).bottomSheetTheme.dragHandleColor ??
        scheme.onSurfaceVariant.withValues(alpha: 0.4);

    // What Material's says to a screen reader, and what tapping it does there:
    // close the sheet -- unless the sheet is one that cannot be dismissed,
    // which Material's would close all the same.
    return Semantics(
      key: const ValueKey('sheet-handle'),
      container: true,
      label: dismissible
          ? MaterialLocalizations.of(context).modalBarrierDismissLabel
          : null,
      onTap: dismissible ? () => Navigator.maybePop(context) : null,
      child: SizedBox(
        height: height,
        child: Center(
          child: Container(
            width: width,
            height: thickness,
            decoration: BoxDecoration(
              color: colour,
              borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
            ),
          ),
        ),
      ),
    );
  }
}

/// A sheet from the bottom with [SheetHandle] at its top, in place of
/// `showModalBottomSheet(showDragHandle: true)`.
///
/// Laid out the way Material lays out its own handle -- the handle over the
/// top of the sheet, the content pushed down by its height -- so nothing
/// inside a sheet is measured differently, only with 20 pixels above it
/// rather than 48.
Future<T?> showAppSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = false,
  bool useSafeArea = false,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    useSafeArea: useSafeArea,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    builder: (context) => Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: SheetHandle.height),
          child: builder(context),
        ),
        SheetHandle(dismissible: isDismissible),
      ],
    ),
  );
}
