import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../models/profile_model.dart';

class ProfileCover extends StatefulWidget {
  final ProfileModel profile;
  final ScrollController scrollController;
  final VoidCallback onBack;
  final VoidCallback onSettings;

  const ProfileCover({
    super.key,
    required this.profile,
    required this.scrollController,
    required this.onBack,
    required this.onSettings,
  });

  @override
  State<ProfileCover> createState() => _ProfileCoverState();
}

class _ProfileCoverState extends State<ProfileCover> {
  double _parallaxOffset = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_updateParallax);
  }

  void _updateParallax() {
    final offset = widget.scrollController.offset;
    setState(() {
      _parallaxOffset = offset * 0.5; // 0.5x parallax
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    
    return Stack(
      children: [
        // Cover Image with Parallax
        Positioned.fill(
          child: Transform.translate(
            offset: Offset(0, _parallaxOffset),
            child: Container(
              decoration: BoxDecoration(
                image: widget.profile.coverUrl != null
                    ? DecorationImage(
                        image: NetworkImage(widget.profile.coverUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    scheme.primary.withOpacity(0.8),
                    scheme.secondary.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),
        ),
        
        // Scrim Gradient
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.4),
                ],
              ),
            ),
          ),
        ),
        
        // Floating Buttons
        Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          left: 16,
          child: _FloatingButton(
            icon: Iconsax.arrow_left,
            onTap: widget.onBack,
          ),
        ),
        
        Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          right: 16,
          child: _FloatingButton(
            icon: widget.profile.isOwnProfile ? Iconsax.setting : Iconsax.more,
            onTap: widget.onSettings,
          ),
        ),
        
        // Avatar (overlaps bottom)
        Positioned(
          bottom: -36,
          left: 20,
          child: Hero(
            tag: 'avatar-${widget.profile.did}',
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network(
                  widget.profile.avatarUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(Iconsax.user, size: 36),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FloatingButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _FloatingButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          child: Icon(icon, size: 24, color: Colors.white),
        ),
      ),
    );
  }
}