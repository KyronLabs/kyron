import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_button.dart';

class ProfileEventHorizon extends StatelessWidget {
  final VoidCallback onShuffle;

  const ProfileEventHorizon({
    super.key,
    required this.onShuffle,
  });

  @override
  Widget build(BuildContext context) {
    final messages = [
      "You've reached the edge of your universe… again. Maybe touch grass?",
      "Infinity achieved. But have you tried the shuffle?",
      "The void stares back. Long-press a card to begin.",
      "All caught up. Time to create something new?",
      "End of line. But every ending is a new beginning.",
    ];
    
    final message = messages[DateTime.now().day % messages.length];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surface.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.textSecondary.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.7),
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'Shuffle Universe',
            onTap: onShuffle,
            isOutlined: true,
          ),
        ],
      ),
    );
  }
}
