import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/composer_provider.dart';

class CharCounter extends ConsumerWidget {
  const CharCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(composerProvider);
    final progress = state.charProgress;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Theme.of(context).colorScheme.surface,
              valueColor: AlwaysStoppedAnimation<Color>(
                progress > 0.9 ? Colors.teal : Colors.deepPurple,
              ),
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 4),
          // Count
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${state.charCount}/1000',
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}