import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isOutlined;
  final bool isLoading; // Loading state

  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isOutlined = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    
    final style = isOutlined
        ? OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            foregroundColor: scheme.primary,
            side: BorderSide(color: scheme.primary.withOpacity(0.24)),
          )
        : ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            foregroundColor: Colors.white,
            backgroundColor: scheme.primary,
          );

    return AnimatedScale(
      scale: isLoading ? 0.98 : 1.0, // Slight shrink when loading
      duration: const Duration(milliseconds: 120),
      child: isOutlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onTap, // Disable when loading
              style: style,
              child: _buildContent(context),
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onTap, // Disable when loading
              style: style,
              child: _buildContent(context),
            ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    
    return Row(
      mainAxisSize: MainAxisSize.min, // Keeps content centered
      children: [
        Text(label),
        if (isLoading) ...[
          const SizedBox(width: 12), // Space between text and loader
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                isOutlined ? scheme.primary : Colors.white,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
