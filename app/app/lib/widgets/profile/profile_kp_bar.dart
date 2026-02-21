import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProfileKPBar extends StatelessWidget {
  final int kyronPoints;

  const ProfileKPBar({
    super.key,
    required this.kyronPoints,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (kyronPoints % 1000) / 1000; // Progress to next 1000
    
    return SizedBox(
      width: 32,
      height: 4,
      child: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Foreground (animated)
          AnimatedFractionallySizedBox(
            widthFactor: progress,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutQuad,
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.accent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}                                                                                   
