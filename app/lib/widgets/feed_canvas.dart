// lib/widgets/feed_canvas.dart
import 'package:flutter/material.dart';

class FeedCanvas extends StatelessWidget {
  final ScrollController? scrollController;

  const FeedCanvas({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [
            Colors.transparent,
            Colors.white,
          ],
          stops: const [0.0, 0.02], // Subtle fade in first 2% of height
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: ListView(
        controller: scrollController,
        padding: EdgeInsets.only(
          top: 8, // Vertical margin below InterestTabs
          bottom: MediaQuery.of(context).padding.bottom + 80, // Space for bottom nav
        ),
        physics: const BouncingScrollPhysics(), // Smooth iOS-style scrolling
        children: [
           
          // Feed content
          _buildFeedContent(context),
        ],
      ),
    );
  }

  Widget _buildFeedContent(BuildContext context) {
    return Column(
      children: List.generate(20, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User ${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '@user${index + 1}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'This is a sample post #${index + 1}. Hehe, we will replace this with our actual feed content!',
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}