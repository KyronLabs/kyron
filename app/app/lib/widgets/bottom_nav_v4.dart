import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_app/widgets/create_fab.dart';
import '../theme/app_theme.dart';

class BottomNavV4 extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavV4({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: scheme.outline.withValues(alpha: .15), width: .5)),
          color: isDark ? AppTheme.surface : AppTheme.lightSurface,
        ),
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _item(context, Iconsax.home, 'Home', 0)),
              Expanded(child: _item(context, Iconsax.discover, 'Explore', 1)),
              Expanded(child: _RingFab()), // ← FAB with ring
              Expanded(child: _item(context, Iconsax.people, 'Communities', 3)),
              Expanded(child: _item(context, Iconsax.message, 'Messages', 4)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(BuildContext context, IconData icon, String label, int index) {
    final scheme = Theme.of(context).colorScheme;
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: isActive ? scheme.primary : scheme.onSurface.withValues(alpha: .6)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isActive ? scheme.primary : scheme.onSurface.withValues(alpha: .6))),
        ],
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
    return oldDelegate.color != color || oldDelegate.ringThickness != ringThickness;
  }
}