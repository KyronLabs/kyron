import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProfileChips extends StatelessWidget {
  final List<Map<String, dynamic>> chips;
  final ValueChanged<int> onChipSelected;
  final int selectedIndex;

  const ProfileChips({
    super.key,
    required this.chips,
    required this.onChipSelected,
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppTheme.lightTextPrimary;
    final surfaceColor = isDark ? AppTheme.surface : AppTheme.lightSurface;
    final textSecondaryColor = isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary;

    return SizedBox(
      height: 48, // CRITICAL: Fixed height constraint
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: chips.length,
        itemBuilder: (context, index) {
          final chip = chips[index];
          final isActive = index == selectedIndex;

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onChipSelected(index),
              borderRadius: BorderRadius.circular(24),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                curve: Curves.easeOutQuad,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppTheme.accent.withOpacity(.18)
                      : surfaceColor.withOpacity(.08),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isActive
                        ? AppTheme.accent
                        : textSecondaryColor.withOpacity(.18),
                    width: isActive ? 2 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // icon / platform emoji
                    Text(
                      chip['icon']?.toString() ?? chip['platform']?.toString() ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 6),

                    // label
                    Text(
                      chip['label'] as String,
                      style: TextStyle(
                        color: isActive ? AppTheme.accent : textColor,
                        fontSize: 14,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),

                    // optional count
                    if (chip['count'] != null) ...[
                      const SizedBox(width: 4),
                      Text(
                        '${chip['count']}',
                        style: TextStyle(
                          color: isActive ? AppTheme.accent : textSecondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}