import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../models/profile_model.dart';

class ProfileIdentityStrip extends SliverPersistentHeaderDelegate {
  final ProfileModel profile;
  final VoidCallback onShowDID;

  ProfileIdentityStrip({
    required this.profile,
    required this.onShowDID,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scheme = Theme.of(context).colorScheme;
    final isShrunk = shrinkOffset > 100; // Trigger when avatar reaches 64px
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: scheme.surface,
        boxShadow: isShrunk
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Smaller avatar when sticky
              AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                width: isShrunk ? 40 : 56,
                height: isShrunk ? 40 : 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: scheme.primary, width: 2),
                ),
                child: ClipOval(
                  child: Image.network(
                    profile.avatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(Iconsax.user, size: 24),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // Handle + KP
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          profile.handle,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: scheme.onSurface,
                            fontFamily: 'SF Pro Rounded',
                          ),
                        ),
                        if (profile.isVerified) ...[
                          const SizedBox(width: 4),
                          Icon(Iconsax.verify, size: 16, color: scheme.primary),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    
                    // DID chip
                    GestureDetector(
                      onTap: onShowDID,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: scheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Iconsax.document_copy, size: 10, color: scheme.primary),
                            const SizedBox(width: 4),
                            Text(
                              'did:plc:abcdef…',
                              style: TextStyle(
                                fontSize: 10,
                                color: scheme.primary,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SF Pro Rounded',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}

class ProfileActionStrip extends SliverPersistentHeaderDelegate {
  final ProfileModel profile;
  final VoidCallback onFollow;
  final VoidCallback onMessage;
  final VoidCallback onShare;
  final VoidCallback onEdit;

  ProfileActionStrip({
    required this.profile,
    required this.onFollow,
    required this.onMessage,
    required this.onShare,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scheme = Theme.of(context).colorScheme;
    final isOwnProfile = profile.isOwnProfile;
    
    return Container(
      color: scheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          if (isOwnProfile) ...[
            _ActionPill(
              label: 'Edit',
              isPrimary: true,
              onTap: onEdit,
            ),
            const SizedBox(width: 8),
            _ActionPill(
              label: 'Share',
              onTap: onShare,
            ),
            const Spacer(),
            IconButton(
              icon: Icon(Iconsax.more, color: scheme.onSurface),
              onPressed: () {
                // More options
              },
            ),
          ] else ...[
            _ActionPill(
              label: profile.isFollowing ? 'Following' : 'Follow',
              isPrimary: !profile.isFollowing,
              onTap: onFollow,
            ),
            const SizedBox(width: 8),
            _ActionPill(
              label: 'Message',
              onTap: onMessage,
            ),
            const SizedBox(width: 8),
            _ActionPill(
              label: 'Share',
              onTap: onShare,
            ),
          ],
        ],
      ),
    );
  }

  @override
  double get maxExtent => 56;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _ActionPill extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _ActionPill({
    required this.label,
    this.isPrimary = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            gradient: isPrimary
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF8A2BE2), Color(0xFF20B2AA)],
                  )
                : null,
            color: isPrimary ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
            border: isPrimary ? null : Border.all(
              color: scheme.onSurface.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isPrimary ? Colors.white : scheme.onSurface,
                fontFamily: 'SF Pro Rounded',
              ),
            ),
          ),
        ),
      ),
    );
  }
}