import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AtomicCard extends StatefulWidget {
  final String avatarUrl;
  final String handle;
  final String? bio;
  final bool isInitiallyFollowing;
  final VoidCallback? onFollowToggle;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const AtomicCard({
    super.key,
    required this.avatarUrl,
    required this.handle,
    this.bio,
    this.isInitiallyFollowing = false,
    this.onFollowToggle,
    this.onTap,
    this.onLongPress,
  });

  @override
  State<AtomicCard> createState() => _AtomicCardState();
}

class _AtomicCardState extends State<AtomicCard> with SingleTickerProviderStateMixin {
  late bool _isFollowing;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _isFollowing = widget.isInitiallyFollowing;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.1), weight: 0.5),
      TweenSequenceItem(tween: Tween<double>(begin: 1.1, end: 1.0), weight: 0.5),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });
    _controller.forward(from: 0);
    HapticFeedback.lightImpact();
    widget.onFollowToggle?.call();
  }

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    final scheme = Theme.of(context).colorScheme;
    
    // Card dimensions
    const cardWidth = 100.0;
    const cardHeight = 120.0;
    const avatarSize = 40.0;
    const buttonHeight = 32.0;
    const buttonWidth = 80.0;
    const padding = 12.0;
    
    return Semantics(
      label: '${widget.handle}, ${widget.bio ?? 'Creator'}, Follow button',
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: scheme.onSurface.withOpacity(0.3),
              width: 1,
            ),
            color: Colors.transparent,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              onLongPress: widget.onLongPress,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Avatar (40px)
                    Container(
                      width: avatarSize,
                      height: avatarSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: scheme.primary,
                          width: 1,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          widget.avatarUrl,
                          width: avatarSize,
                          height: avatarSize,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Iconsax.user,
                              size: 20,
                              color: scheme.onSurface.withOpacity(0.6),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // @handle (15pt)
                    Text(
                      widget.handle,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SF Pro Rounded',
                        color: scheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    // Bio (13pt, 2 lines)
                    if (widget.bio != null && widget.bio!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        widget.bio!,
                        style: TextStyle(
                          fontSize: 13,
                          color: scheme.onSurface.withOpacity(0.7),
                          fontFamily: 'SF Pro Rounded',
                        ),
                        textAlign: TextAlign.center,
                        maxLines: textScale > 1.5 ? 3 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    
                    const Spacer(),
                    
                    // Follow button (32px height, 80px width)
                    _buildButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    final scheme = Theme.of(context).colorScheme;
    
    return Container(
      width: 80.0,
      height: 32.0,
      decoration: _isFollowing
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: scheme.onSurface.withOpacity(0.3),
                width: 1,
              ),
              color: Colors.transparent,
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF8A2BE2), Color(0xFF20B2AA)],
              ),
            ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _toggleFollow,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Text(
              _isFollowing ? 'Following' : 'Follow',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _isFollowing ? scheme.onSurface : Colors.white,
                fontFamily: 'SF Pro Rounded',
              ),
            ),
          ),
        ),
      ),
    );
  }
}