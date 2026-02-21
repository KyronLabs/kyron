import 'package:flutter/material.dart';

class AppLanguageSelector extends StatelessWidget {
  final String selected;
  final void Function(String)? onChanged;

  const AppLanguageSelector({super.key, this.selected = 'English', this.onChanged});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(selected, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: 8),
          const Icon(Icons.language, size: 18),
        ],
      ),
      itemBuilder: (_) => [
        const PopupMenuItem(value: 'English', child: Text('English')),
        const PopupMenuItem(value: 'Español', child: Text('Español')),
        const PopupMenuItem(value: 'Français', child: Text('Français')),
      ],
      onSelected: onChanged,
    );
  }
}
