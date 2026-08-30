import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isOutlined;
  final bool isLoading; // Loading state

  /// When false the button is visibly inert. Screens used to fake this by
  /// returning early from onTap, which is indistinguishable from a broken
  /// button: it depresses and nothing happens.
  final bool enabled;

  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isOutlined = false,
    this.isLoading = false,
    this.enabled = true,
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

    final isInteractive = enabled && !isLoading;

    return AnimatedScale(
      scale: isLoading ? 0.98 : 1.0, // Slight shrink when loading
      duration: const Duration(milliseconds: 120),
      child: isOutlined
          ? OutlinedButton(
              onPressed: isInteractive ? onTap : null,
              style: style,
              child: _buildContent(context),
            )
          : ElevatedButton(
              onPressed: isInteractive ? onTap : null,
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
