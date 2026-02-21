// lib/widgets/sliding_drawer_content.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../providers/current_user_provider.dart';

class SlidingDrawerContent extends ConsumerWidget {
  final VoidCallback onCloseDrawer;
  
  const SlidingDrawerContent({super.key, required this.onCloseDrawer});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final userAsync = ref.watch(currentUserProvider);
    
    return Material(
      color: scheme.surface,
      child: SafeArea(
        right: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 18),
            userAsync.when(
              loading: () => _headerSkeleton(context, scheme),
              error: (_, __) => _headerError(context, scheme),
              data: (user) => _header(context, scheme, user),
            ),
            const SizedBox(height: 16),
            _sectionDivider(scheme),
            _navigation(context, scheme, isDark),
            const Spacer(),
            _footerV2(context, scheme, isDark),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 6),
          ],
        ),
      ),
    );
  }
  
  // ============= HEADER SECTION =============
  
  Widget _header(BuildContext context, ColorScheme scheme, dynamic user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Avatar
          GestureDetector(
            onTap: () {
              onCloseDrawer();
              Navigator.pushNamed(context, '/profile');
            },
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: scheme.primary, width: 2),
                color: scheme.tertiaryContainer,
              ),
              child: user.avatarUrl != null
                  ? ClipOval(
                      child: Image.network(
                        user.avatarUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Iconsax.user,
                            size: 24,
                            color: scheme.onTertiaryContainer,
                          );
                        },
                      ),
                    )
                  : Icon(
                      Iconsax.user,
                      size: 24,
                      color: scheme.onTertiaryContainer,
                    ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Username & KP
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                user.username != null ? '@${user.username}' : '@user',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  '${user.kyronPoints} KP',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: scheme.secondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          
          // DID Badge
          if (user.did != null)
            GestureDetector(
              onTap: () => _showDIDModal(context, user.did!),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: scheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Iconsax.document_copy, size: 12, color: scheme.primary),
                    const SizedBox(width: 4),
                    Text(
                      _truncateDID(user.did!),
                      style: TextStyle(
                        fontSize: 11,
                        color: scheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  // Loading skeleton for header
  Widget _headerSkeleton(BuildContext context, ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar skeleton
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: scheme.surfaceContainerHighest,
            ),
          ),
          const SizedBox(height: 12),
          
          // Username skeleton
          Container(
            width: 120,
            height: 20,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          
          // DID skeleton
          Container(
            width: 100,
            height: 20,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
    );
  }
  
  // Error state for header
  Widget _headerError(BuildContext context, ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: scheme.errorContainer,
              border: Border.all(color: scheme.error, width: 2),
            ),
            child: Icon(
              Iconsax.user,
              size: 24,
              color: scheme.onErrorContainer,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Unable to load profile',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: scheme.error,
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper to truncate DID
  String _truncateDID(String did) {
    if (did.length <= 15) return did;
    return '${did.substring(0, 15)}…';
  }
  
  // ============= FOOTER SECTION =============
    
  Widget _footerV2(BuildContext context, ColorScheme scheme, bool isDark) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).padding.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Row 1: Terms & Privacy
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textLink(context, 'Terms', onTap: () {
                onCloseDrawer();
                Navigator.pushNamed(context, '/terms');
              }),
              const SizedBox(width: 16),
              Text('•', style: TextStyle(color: scheme.onSurface.withOpacity(0.3), fontSize: 10)),
              const SizedBox(width: 16),
              _textLink(context, 'Privacy', onTap: () {
                onCloseDrawer();
                Navigator.pushNamed(context, '/privacy');
              }),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Row 2: Help & Feedback
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _chipButton(context, 'Help', Iconsax.info_circle, onTap: () {
                onCloseDrawer();
                Navigator.pushNamed(context, '/help-center');
              }),
              const SizedBox(width: 12),
              _chipButton(context, 'Feedback', Iconsax.message_edit, onTap: () {
                onCloseDrawer();
                Navigator.pushNamed(context, '/feedback');
              }),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Version info
          Text(
            'Kyron v1.0.0',
            style: TextStyle(
              fontSize: 10,
              color: scheme.onSurface.withOpacity(0.4),
              fontWeight: FontWeight.w500,
              fontFamily: 'SF Pro Rounded',
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _textLink(BuildContext context, String label, {VoidCallback? onTap}) {
    final scheme = Theme.of(context).colorScheme;
    
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: scheme.primary,
          fontWeight: FontWeight.w500,
          fontFamily: 'SF Pro Rounded',
        ),
      ),
    );
  }
  
  Widget _chipButton(BuildContext context, String label, IconData icon, {VoidCallback? onTap}) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: isDark ? 0.1 : 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 12, color: scheme.primary),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: scheme.primary,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SF Pro Rounded',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // ============= NAVIGATION SECTION =============
  
  Widget _sectionDivider(ColorScheme scheme) {
    return Divider(height: 1, thickness: 1, color: scheme.onSurface.withOpacity(0.1));
  }
  
  Widget _navigation(BuildContext context, ColorScheme scheme, bool isDark) {
    return Flexible(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _pillButton(
            icon: Iconsax.people,
            label: 'Communities',
            badge: '3 new posts',
            onTap: () {
              onCloseDrawer();
              Navigator.pushNamed(context, '/communities');
            },
          ),
          _pillButton(
            icon: Iconsax.bookmark,
            label: 'Saved Posts',
            onTap: () {
              onCloseDrawer();
              Navigator.pushNamed(context, '/saved');
            },
          ),
          _pillButton(
            icon: Iconsax.setting,
            label: 'Settings',
            onTap: () {
              onCloseDrawer();
              Navigator.pushNamed(context, '/settings');
            },
          ),
          _pillButton(
            icon: Iconsax.info_circle,
            label: 'Help & Support',
            onTap: () {
              onCloseDrawer();
              Navigator.pushNamed(context, '/help');
            },
          ),
        ],
      ),
    );
  }
  
  Widget _pillButton({
    required IconData icon,
    required String label,
    String? badge,
    VoidCallback? onTap,
  }) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final pillBgColor = isDark ? const Color(0xFF1F1F23) : const Color(0xFFF7F7F7);
        final onSurfaceColor = isDark ? const Color(0xFFE5EBF5) : const Color(0xFF1A202C);
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: pillBgColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: onSurfaceColor.withOpacity(0.1)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(icon, size: 20, color: onSurfaceColor.withOpacity(0.8)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: onSurfaceColor,
                        ),
                      ),
                    ),
                    if (badge != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          badge,
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
  // ============= DID MODAL =============
  
  void _showDIDModal(BuildContext context, String did) {
    final scheme = Theme.of(context).colorScheme;
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: scheme.onSurface.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            Text(
              'Decentralized ID',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: scheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            
            // DID Display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: scheme.outline.withOpacity(0.2),
                ),
              ),
              child: SelectableText(
                did,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'monospace',
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: did));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('DID copied to clipboard'),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Iconsax.copy, size: 18),
                    label: const Text('Copy'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: () {
                      Navigator.pop(context);
                      // TODO: Implement QR code display
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('QR Code feature coming soon'),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Iconsax.scan_barcode, size: 18),
                    label: const Text('QR Code'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}