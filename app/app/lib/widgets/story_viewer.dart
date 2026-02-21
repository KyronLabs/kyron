import 'package:flutter/material.dart';
import '../providers/stories_provider.dart';

class StoryViewer extends StatefulWidget {
  final Story initialStory;
  final List<Story> allStories;

  const StoryViewer({
    super.key,
    required this.initialStory,
    required this.allStories,
  });

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {
  late PageController _pageController;
  late int _currentIndex;
  bool _isReducedMotion = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.allStories.indexWhere((s) => s.id == widget.initialStory.id);
    _pageController = PageController(initialPage: _currentIndex);
    _checkReducedMotion();
  }

  Future<void> _checkReducedMotion() async {
    // Check platform reduced motion setting
    // This is a placeholder - implement platform-specific check
    setState(() {
      _isReducedMotion = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 20) {
            Navigator.pop(context);
          }
        },
        child: Stack(
          children: [
            // Story content
            PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemCount: widget.allStories.length,
              itemBuilder: (context, index) {
                final story = widget.allStories[index];
                return _buildStoryPage(story);
              },
            ),
            // Top bar with creator info
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              right: 16,
              child: _buildTopBar(widget.allStories[_currentIndex]),
            ),
            // Tap targets for navigation
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (_currentIndex > 0) {
                        _pageController.previousPage(
                          duration: _isReducedMotion ? Duration.zero : const Duration(milliseconds: 150),
                          curve: Curves.easeOut,
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (_currentIndex < widget.allStories.length - 1) {
                        _pageController.nextPage(
                          duration: _isReducedMotion ? Duration.zero : const Duration(milliseconds: 150),
                          curve: Curves.easeOut,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryPage(Story story) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              story.isYourStory ? Icons.person : Icons.people,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              story.isYourStory ? 'Your Story' : '@${story.handle}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _getTimeLeft(story),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(Story story) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white24,
          child: story.isYourStory
              ? const Icon(Icons.person, color: Colors.white)
              : Text(story.handle[0].toUpperCase()),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                story.isYourStory ? 'Your Story' : '@${story.handle}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _getTimeLeft(story),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () {
            // Copy story link
            debugPrint('Copy story link');
          },
        ),
      ],
    );
  }

  String _getTimeLeft(Story story) {
    // In real app, calculate from expiry time
    return '3h ago';
  }
}