import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../models/profile_model.dart';

class ProfileBioBlock extends StatefulWidget {
  final ProfileModel profile;

  const ProfileBioBlock({super.key, required this.profile});

  @override
  State<ProfileBioBlock> createState() => _ProfileBioBlockState();
}

class _ProfileBioBlockState extends State<ProfileBioBlock> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textScale = MediaQuery.of(context).textScaleFactor;
    final maxLines = textScale > 1.5 ? 4 : 6;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bio text
          if (widget.profile.bio != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    widget.profile.bio!,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      color: scheme.onSurface,
                      fontFamily: 'SF Pro Rounded',
                    ),
                    maxLines: _isExpanded ? null : maxLines,
                    overflow: _isExpanded ? null : TextOverflow.ellipsis,
                  ),
                ),
                if (!_isExpanded && (widget.profile.bio!.length > 200))
                  GestureDetector(
                    onTap: () => setState(() => _isExpanded = true),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '…more',
                        style: TextStyle(
                          color: scheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          
          const SizedBox(height: 12),
          
          // Social links
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: widget.profile.socials.map((social) {
              final parts = social.split(' ');
              final emoji = parts[0];
              final handle = parts[1];
              
              return GestureDetector(
                onTap: () {
                  // Handle link based on type
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(emoji, style: const TextStyle(fontSize: 14)),
                    const SizedBox(width: 4),
                    Text(
                      handle,
                      style: TextStyle(
                        color: scheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}