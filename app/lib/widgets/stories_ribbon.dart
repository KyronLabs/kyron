// lib/widgets/stories_ribbon.dart
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/stories_provider.dart';
import 'story_pill.dart';
import 'story_viewer.dart';

class StoriesRibbon extends StatefulWidget {
  final ScrollController? scrollController;
  const StoriesRibbon({super.key, this.scrollController});

  @override
  State<StoriesRibbon> createState() => _StoriesRibbonState();
}

class _StoriesRibbonState extends State<StoriesRibbon> {
  final ScrollController _ribbonController = ScrollController();
  final int _maxVisiblePills = 5;

  @override
  void dispose() {
    _ribbonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final storiesAsync = ref.watch(storiesProvider);
        final isReducedMotion = MediaQuery.of(context).accessibleNavigation;
        final scheme = Theme.of(context).colorScheme;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return storiesAsync.when(
          loading: () => _buildShimmer(),
          error: (error, stack) => const SizedBox.shrink(),
          data: (stories) {
            final visibleStories = stories.take(_maxVisiblePills).toList();
            final overflowCount = stories.length > _maxVisiblePills 
                ? stories.length - _maxVisiblePills 
                : 0;

            return Semantics(
              label: 'Stories ribbon, ${stories.length} items',
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isDark 
                          ? scheme.outline.withOpacity(0.2)
                          : scheme.outline.withOpacity(0.15),
                      width: 1,
                    ),
                  ),
                ),
                child: Container(
                  height: 110,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListView.builder(
                    controller: _ribbonController,
                    scrollDirection: Axis.horizontal,
                    physics: const _SnapScrollPhysics(),
                    itemCount: visibleStories.length + (overflowCount > 0 ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _maxVisiblePills && overflowCount > 0) {
                        return _buildOverflowPill(overflowCount);
                      }

                      final story = visibleStories[index];
                      return StoryPill(
                        handle: story.isYourStory ? null : story.handle,
                        status: story.status,
                        onTap: () => _handleTap(context, story),
                        onLongPress: () => _showProfilePreview(context, story),
                        onSwipeLeft: story.isYourStory && story.status == StoryStatus.uploading
                            ? () => _cancelUpload(context, story)
                            : () => _hideStory(context, story),
                        avatarUrl: story.avatarUrl,
                        isReducedMotion: isReducedMotion,
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildShimmer() {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark 
                ? scheme.outline.withOpacity(0.2)
                : scheme.outline.withOpacity(0.15),
            width: 1,
          ),
        ),
      ),
      child: Container(
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              width: 72,
              height: 100,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: scheme.outline.withOpacity(0.1),
                  width: 1,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOverflowPill(int count) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 72,
      height: 100,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDark 
              ? scheme.outline.withOpacity(0.3)
              : scheme.outline.withOpacity(0.2),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
        color: scheme.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: scheme.primary.withOpacity(0.3),
                width: 1.5,
              ),
              color: scheme.primaryContainer.withOpacity(0.3),
            ),
            child: Center(
              child: Text(
                '+$count',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: scheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'More',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: scheme.onSurface.withOpacity(0.7),
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _handleTap(BuildContext context, Story story) {
    if (story.isYourStory) {
      _openCameraLane(context);
    } else {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => StoryViewer(
            initialStory: story,
            allStories: [story],
          ),
          transitionDuration: const Duration(milliseconds: 80),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  void _openCameraLane(BuildContext context) {
    debugPrint('Opening AR Camera Lane');
  }

  void _showProfilePreview(BuildContext context, Story story) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _ProfilePreviewSheet(handle: story.handle),
    );
  }

  void _cancelUpload(BuildContext context, Story story) {
    debugPrint('Cancel upload for your story');
  }

  void _hideStory(BuildContext context, Story story) {
    debugPrint('Hide story from ${story.handle} for 24h');
  }
}

class _SnapScrollPhysics extends ScrollPhysics {
  const _SnapScrollPhysics({super.parent});

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _SnapScrollPhysics(parent: parent);
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    const tolerance = Tolerance.defaultTolerance;
    final target = _getTargetPixel(position);
    
    if ((target - position.pixels).abs() < tolerance.distance) return null;
    
    return ScrollSpringSimulation(
      const SpringDescription(
        mass: 0.5,
        stiffness: 100.0,
        damping: 10.0,
      ),
      position.pixels,
      target,
      velocity,
      tolerance: tolerance,
    );
  }

  double _getTargetPixel(ScrollMetrics position) {
    const pillWidth = 84;
    final currentPage = (position.pixels / pillWidth).round();
    return (currentPage * pillWidth).toDouble();
  }
}

class _ProfilePreviewSheet extends StatelessWidget {
  final String handle;

  const _ProfilePreviewSheet({required this.handle});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: scheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          '@$handle',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}