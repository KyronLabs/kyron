// lib/widgets/feed_canvas.dart
import 'package:flutter/material.dart';

class FeedCanvas extends StatelessWidget {
  final ScrollController? scrollController;

  const FeedCanvas({super.key, this.scrollController});

  /// Height of the fade under the tab strip, in logical pixels.
  static const double _topFadeHeight = 16;

  @override
  Widget build(BuildContext context) {
    // A Stack with a small gradient at the top, rather than a ShaderMask over
    // the whole list. ShaderMask pushes its entire subtree into an offscreen
    // layer and recomposites it every frame the list moves -- a full-viewport
    // cost for a 16-pixel effect. This paints only the strip it covers.
    return Stack(
      children: [
        ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.only(
            top: 8, // Vertical margin below InterestTabs
            bottom: MediaQuery.of(context).padding.bottom +
                80, // Space for bottom nav
          ),
          physics: const BouncingScrollPhysics(), // Smooth iOS-style scrolling
          // Builder, not a Column of every post: the list used to construct
          // all of them up front, whether or not any were on screen.
          itemCount: 20,
          itemBuilder: _buildPost,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: _topFadeHeight,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).scaffoldBackgroundColor,
                    Theme.of(context)
                        .scaffoldBackgroundColor
                        .withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPost(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.3),
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
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.2),
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
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6),
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
  }
}
