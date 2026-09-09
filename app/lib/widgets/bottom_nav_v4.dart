import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_app/widgets/create_fab.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

class BottomNavV4 extends StatelessWidget {
  /// The bar's own height, before the safe area under it.
  ///
  /// Named because the body extends behind this bar: anything a screen floats
  /// over its own content -- a button to start a community, say -- has to sit
  /// above it, and guessing the number is how it ends up half hidden.
  static const double height = 64;

  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavV4(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Whatever the phone reserves at the bottom for its gesture bar.
    final inset = MediaQuery.paddingOf(context).bottom;

    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      // The inset goes *under* the bar rather than out of it.
      //
      // This was a SafeArea inside a fixed 64, which took the gesture bar out
      // of the row's own height. Measured against a 34px inset: the row got
      // 30, the icon and label overflowed it by 11, and a tab answered over 29
      // logical pixels of the 64 it looked like it owned -- against the 48
      // Material asks for. That is the whole of "it takes too precise a tap",
      // and it only ever appeared on a phone with gesture navigation, which is
      // why the bar looked right everywhere it was checked.
      child: Container(
        height: height + inset,
        padding: EdgeInsets.only(bottom: inset),
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: scheme.outline.withValues(alpha: .15), width: .5)),
          color: isDark ? KyronTheme.darkSurface : KyronTheme.lightSurface,
        ),
        // Stretch, so each tab's box is the full height of the bar and a
        // thumb landing anywhere in it counts.
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _item(context, Iconsax.home_copy, Iconsax.home, 'Home', 0),
            ),
            Expanded(
                child: _item(context, Iconsax.discover_copy, Iconsax.discover,
                    'Explore', 1)),
            Expanded(child: _RingFab()), // ← FAB with ring
            Expanded(
                child: _item(context, Iconsax.people_copy, Iconsax.people,
                    'Communities', 3)),
            Expanded(
                child: _item(context, Iconsax.message_copy, Iconsax.message,
                    'Messages', 4)),
          ],
        ),
      ),
    );
  }

  /// The tab you are on is drawn filled, the rest outlined.
  ///
  /// Outlining every tab left colour as the only thing distinguishing the
  /// current one, which is a weak signal and no signal at all to anyone who
  /// cannot separate the two hues.
  Widget _item(
    BuildContext context,
    IconData icon,
    IconData activeIcon,
    String label,
    int index,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final isActive = currentIndex == index;

    final colour =
        isActive ? scheme.primary : scheme.onSurface.withValues(alpha: .6);

    return Semantics(
      button: true,
      selected: isActive,
      label: label,
      child: GestureDetector(
        // Opaque, so the whole cell answers rather than only the pixels the
        // icon and the label happen to paint. deferToChild -- the default --
        // left the space around them swallowing taps.
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isActive ? activeIcon : icon, size: 22, color: colour),
            const SizedBox(height: 2),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: colour,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom widget that combines the FAB with a translucent ring
class _RingFab extends StatelessWidget {
  const _RingFab();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    // Total size including ring
    const double totalSize = 56.0;
    // Reduced FAB size
    const double fabSize = 42.0;
    // Ring thickness (takes up the space from reduced FAB)
    const double ringThickness = (totalSize - fabSize) / 2;

    return SizedBox(
      width: totalSize,
      height: totalSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ring using CustomPaint
          CustomPaint(
            size: const Size(totalSize, totalSize),
            painter: _RingPainter(
              color: scheme.primary.withValues(alpha: 0.15),
              ringThickness: ringThickness,
            ),
          ),
          // Smaller FAB
          SizedBox(
            width: fabSize,
            height: fabSize,
            child: CreateFab(),
          ),
        ],
      ),
    );
  }
}

// CustomPainter to draw the translucent ring
class _RingPainter extends CustomPainter {
  final Color color;
  final double ringThickness;

  _RingPainter({
    required this.color,
    required this.ringThickness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = ringThickness
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (ringThickness / 2);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.ringThickness != ringThickness;
  }
}
