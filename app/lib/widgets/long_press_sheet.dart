import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class LongPressSheet extends StatelessWidget {
  final Map<String, IconData> items;
  const LongPressSheet({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /* ---------- handle ---------- */
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: scheme.outline.withValues(alpha: .3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),

          /* ---------- rounded card ---------- */
          Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(20),
            color: isDark ? AppTheme.surface : AppTheme.lightSurface,
            child: Column(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  ListTile(
                    leading: Icon(items.values.elementAt(i),
                        color: scheme.onSurface.withValues(alpha: .75)),
                    title: Text(items.keys.elementAt(i)),
                    onTap: () => Navigator.pop(context, items.keys.elementAt(i)),
                    shape: RoundedRectangleBorder(
                      borderRadius: i == 0
                          ? const BorderRadius.vertical(top: Radius.circular(20))
                          : i == items.length - 1
                              ? const BorderRadius.vertical(bottom: Radius.circular(20))
                              : BorderRadius.zero,
                    ),
                  ),
                  if (i < items.length - 1)
                    Divider(height: 1, thickness: 1, color: scheme.outline.withValues(alpha: .15)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
