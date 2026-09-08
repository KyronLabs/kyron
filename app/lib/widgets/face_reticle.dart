// lib/widgets/face_reticle.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// Shown when a lens wants a face and there is not one yet.
///
/// Delayed rather than immediate: tracking picks a face up within a frame or
/// two, and a hint that flashes on every blink is worse than no hint. It
/// appears once somebody has plainly been pointing the camera at nothing.
class FaceReticle extends StatefulWidget {
  const FaceReticle({super.key});

  @override
  State<FaceReticle> createState() => _FaceReticleState();
}

class _FaceReticleState extends State<FaceReticle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _breath = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  )..repeat(reverse: true);

  Timer? _delay;
  bool _shown = false;

  @override
  void initState() {
    super.initState();
    _delay = Timer(const Duration(milliseconds: 900), () {
      if (mounted) setState(() => _shown = true);
    });
  }

  @override
  void dispose() {
    _delay?.cancel();
    _breath.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedOpacity(
        opacity: _shown ? 1 : 0,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _breath,
                builder: (context, child) {
                  final t = Curves.easeInOut.transform(_breath.value);
                  return Transform.scale(
                    scale: 0.97 + t * 0.06,
                    child: Opacity(opacity: 0.45 + t * 0.35, child: child),
                  );
                },
                child: CustomPaint(
                  size: const Size(148, 178),
                  painter: const _ReticlePainter(),
                ),
              ),
              const SizedBox(height: SpacingTokens.space16),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SpacingTokens.space16,
                    vertical: SpacingTokens.space8,
                  ),
                  child: Text(
                    'Looking for a face',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Four corner brackets. Not a full rectangle: a closed box reads as a thing
/// that has found something, and this is the state where it has not.
class _ReticlePainter extends CustomPainter {
  const _ReticlePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    const radius = 18.0;
    final arm = size.width * 0.28;
    final rect = Offset.zero & size;

    for (final corner in [
      (rect.topLeft, 1.0, 1.0),
      (rect.topRight, -1.0, 1.0),
      (rect.bottomLeft, 1.0, -1.0),
      (rect.bottomRight, -1.0, -1.0),
    ]) {
      final (origin, sx, sy) = corner;
      final path = Path()
        ..moveTo(origin.dx + sx * arm, origin.dy)
        ..lineTo(origin.dx + sx * radius, origin.dy)
        ..quadraticBezierTo(
          origin.dx,
          origin.dy,
          origin.dx,
          origin.dy + sy * radius,
        )
        ..lineTo(origin.dx, origin.dy + sy * arm);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_ReticlePainter oldDelegate) => false;
}
