// lib/widgets/story_pill.dart
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import '../theme/app_theme.dart';
import '../providers/stories_provider.dart';

class StoryPill extends StatefulWidget {
  final String? handle;
  final StoryStatus status;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback? onSwipeLeft;
  final String? avatarUrl;
  final bool isReducedMotion;

  const StoryPill({
    super.key,
    this.handle,
    required this.status,
    required this.onTap,
    required this.onLongPress,
    this.onSwipeLeft,
    this.avatarUrl,
    required this.isReducedMotion,
  });

  @override
  State<StoryPill> createState() => _StoryPillState();
}

class _StoryPillState extends State<StoryPill> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  double _dragOffset = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isReducedMotion) {
      _pulseController.stop();
    } else if (widget.status == StoryStatus.unseen && !_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    }

    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return GestureDetector(
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          onHorizontalDragStart: (_) => setState(() => _isDragging = true),
          onHorizontalDragUpdate: (details) {
            setState(() {
              _dragOffset = details.localPosition.dx - 36;
            });
          },
          onHorizontalDragEnd: (details) {
            setState(() {
              _isDragging = false;
              if (_dragOffset < -20 && widget.onSwipeLeft != null) {
                widget.onSwipeLeft!();
              }
              _dragOffset = 0.0;
            });
          },
          child: Transform.translate(
            offset: Offset(_isDragging ? _dragOffset.clamp(-40, 0) : 0, 0),
            child: Container(
              width: 72,
              height: 100,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _getBorderColor(context),
                  width: _getBorderWidth(),
                ),
                borderRadius: BorderRadius.circular(12),
                color: _getBackgroundColor(context),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer ring for unseen stories (animated gradient)
                      if (widget.status == StoryStatus.unseen && !widget.isReducedMotion)
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF8B5CF6),
                                const Color(0xFF14B8A6),
                              ],
                              transform: GradientRotation(_pulseController.value * 2 * 3.14159),
                            ),
                          ),
                        ),
                      // Static ring for other statuses
                      if (widget.status != StoryStatus.unseen || widget.isReducedMotion)
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _getRingColor(context),
                              width: 2,
                            ),
                          ),
                        ),
                      // Inner white spacer ring
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      // Avatar container with border
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _getAvatarBorderColor(context),
                            width: 1.5,
                          ),
                          color: _getAvatarBackground(context),
                        ),
                        child: Center(
                          child: _buildAvatarContent(context),
                        ),
                      ),
                      if (widget.status == StoryStatus.uploading)
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 28,
                    child: Text(
                      _getLabel(),
                      style: TextStyle(
                        fontSize: 12,
                        color: _getLabelColor(context),
                        fontWeight: widget.status == StoryStatus.yourStory 
                            ? FontWeight.w600 
                            : FontWeight.w500,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvatarContent(BuildContext context) {
    switch (widget.status) {
      case StoryStatus.yourStory:
        return const Icon(Icons.add, size: 22, color: Colors.white);
      case StoryStatus.uploading:
        return const SizedBox.shrink();
      default:
        if (widget.avatarUrl != null) {
          return ClipOval(
            child: Image.network(
              widget.avatarUrl!,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _defaultAvatar(),
            ),
          );
        }
        return _defaultAvatar();
    }
  }

  Widget _defaultAvatar() {
    return Icon(
      Icons.person,
      size: 20,
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
    );
  }

  Color _getBorderColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (widget.status) {
      case StoryStatus.unseen:
        return isDark 
            ? scheme.primary.withOpacity(0.4)
            : scheme.primary.withOpacity(0.3);
      case StoryStatus.yourStory:
      case StoryStatus.uploading:
        return isDark
            ? scheme.primary.withOpacity(0.5)
            : scheme.primary.withOpacity(0.4);
      case StoryStatus.seen:
        return isDark
            ? scheme.outline.withOpacity(0.3)
            : scheme.outline.withOpacity(0.25);
      case StoryStatus.expired:
        return isDark
            ? scheme.outline.withOpacity(0.2)
            : scheme.outline.withOpacity(0.15);
    }
  }

  double _getBorderWidth() {
    switch (widget.status) {
      case StoryStatus.unseen:
      case StoryStatus.yourStory:
      case StoryStatus.uploading:
        return 1.5;
      case StoryStatus.seen:
      case StoryStatus.expired:
        return 1.0;
    }
  }

  Color _getBackgroundColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (widget.status) {
      case StoryStatus.yourStory:
      case StoryStatus.uploading:
        return isDark
            ? scheme.primaryContainer.withOpacity(0.15)
            : scheme.primaryContainer.withOpacity(0.1);
      case StoryStatus.unseen:
        return isDark
            ? scheme.surface.withOpacity(0.5)
            : scheme.surface.withOpacity(0.8);
      case StoryStatus.seen:
      case StoryStatus.expired:
        return isDark
            ? scheme.surfaceContainerHighest.withOpacity(0.3)
            : scheme.surfaceContainerHighest.withOpacity(0.5);
    }
  }

  Color _getRingColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    switch (widget.status) {
      case StoryStatus.unseen:
        return Colors.transparent; // Handled by gradient
      case StoryStatus.seen:
        return scheme.onSurface.withOpacity(0.3);
      case StoryStatus.expired:
        return scheme.onSurface.withOpacity(0.2);
      case StoryStatus.yourStory:
      case StoryStatus.uploading:
        return scheme.primary.withOpacity(0.4);
    }
  }

  Color _getAvatarBorderColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (widget.status) {
      case StoryStatus.yourStory:
      case StoryStatus.uploading:
        return scheme.primary.withOpacity(0.3);
      case StoryStatus.unseen:
        return isDark
            ? scheme.outline.withOpacity(0.2)
            : scheme.outline.withOpacity(0.15);
      case StoryStatus.seen:
      case StoryStatus.expired:
        return scheme.outline.withOpacity(0.15);
    }
  }

  Color _getAvatarBackground(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    switch (widget.status) {
      case StoryStatus.yourStory:
      case StoryStatus.uploading:
        return scheme.primary;
      case StoryStatus.unseen:
      case StoryStatus.seen:
      case StoryStatus.expired:
        return scheme.surfaceContainerHighest;
    }
  }

  Color _getLabelColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    switch (widget.status) {
      case StoryStatus.yourStory:
      case StoryStatus.uploading:
        return scheme.primary;
      case StoryStatus.unseen:
        return scheme.onSurface;
      case StoryStatus.seen:
        return scheme.onSurface.withOpacity(0.6);
      case StoryStatus.expired:
        return scheme.onSurface.withOpacity(0.4);
    }
  }

  String _getLabel() {
    switch (widget.status) {
      case StoryStatus.yourStory:
        return 'Add';
      case StoryStatus.uploading:
        return 'Posting…';
      default:
        return widget.handle ?? '';
    }
  }
}