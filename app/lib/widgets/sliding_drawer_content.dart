// lib/widgets/sliding_drawer_content.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/current_user.dart';
import '../providers/current_user_provider.dart';
import '../routes.dart';
import '../services/app_info.dart';
import '../utils/api_error_message.dart';
import '../utils/format_count.dart';

class SlidingDrawerContent extends ConsumerWidget {
  final VoidCallback onCloseDrawer;

  /// Switches the app shell to one of its bottom-nav tabs.
  ///
  /// Communities is a tab, not a route: pushing '/communities' matched nothing
  /// and opened the splash screen. The drawer asks the shell to switch instead.
  final void Function(int index)? onSelectTab;

  /// The bottom-nav index Communities sits at, kept beside the shell that
  /// defines it.
  static const communitiesTab = 3;

  const SlidingDrawerContent({
    super.key,
    required this.onCloseDrawer,
    this.onSelectTab,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
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
              loading: () => _headerSkeleton(scheme),
              error: (error, _) => _headerError(context, ref, scheme, error),
              data: (user) => _header(context, scheme, user),
            ),
            const SizedBox(height: SpacingTokens.space16),
            _sectionDivider(scheme),
            // Expanded, with no Spacer under it. Both were flexible before, so
            // the list and the gap below it split the leftover space evenly
            // and the last item was cut off halfway down.
            Expanded(child: _navigation(context)),
            _footer(context, scheme),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 6),
          ],
        ),
      ),
    );
  }

  // ============= HEADER SECTION =============

  Widget _header(BuildContext context, ColorScheme scheme, CurrentUser user) {
    final handle = user.handle;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _go(context, Routes.profile),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: scheme.primary, width: 2),
              ),
              child: ClipOval(
                child: CircleAvatar(
                  backgroundColor: scheme.tertiaryContainer,
                  foregroundImage: user.avatarUrl == null
                      ? null
                      : NetworkImage(user.avatarUrl!),
                  child: Icon(Iconsax.user_copy,
                      size: 24, color: scheme.onTertiaryContainer),
                ),
              ),
            ),
          ),
          const SizedBox(height: SpacingTokens.space12),
          Text(
            user.displayName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
          ),
          if (handle != null)
            Text(
              handle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          const SizedBox(height: SpacingTokens.space8),

          // Followers and following. Both arrive in the same /profile/me
          // response the avatar above comes from; the client used to read the
          // follower count and drop the other.
          Row(
            children: [
              _stat(context, user.followers, 'Followers'),
              const SizedBox(width: SpacingTokens.space16),
              _stat(context, user.following, 'Following'),
              const SizedBox(width: SpacingTokens.space16),
              Text(
                '${formatCount(user.kyronPoints)} KP',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: scheme.secondary,
                ),
              ),
            ],
          ),

          if (user.did != null) ...[
            const SizedBox(height: SpacingTokens.space8),
            GestureDetector(
              onTap: () => _showDIDModal(context, user.did!),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space8,
                  vertical: SpacingTokens.space4,
                ),
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(RadiusTokens.radius8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Iconsax.document_copy,
                        size: 12, color: scheme.primary),
                    const SizedBox(width: SpacingTokens.space4),
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
        ],
      ),
    );
  }

  Widget _stat(BuildContext context, int value, String label) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          formatCount(value),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
        ),
        const SizedBox(width: SpacingTokens.space4),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: scheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _headerSkeleton(ColorScheme scheme) {
    Widget block(double width, double height, double radius) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(radius),
          ),
        );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          block(56, 56, 28),
          const SizedBox(height: SpacingTokens.space12),
          block(140, 20, 4),
          const SizedBox(height: SpacingTokens.space8),
          block(180, 16, 4),
        ],
      ),
    );
  }

  /// A failed load says what went wrong and offers a retry. It used to show
  /// "Unable to load profile" and nothing else -- no reason, no way back.
  Widget _headerError(
    BuildContext context,
    WidgetRef ref,
    ColorScheme scheme,
    Object error,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space20),
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
            child: Icon(Iconsax.user_copy,
                size: 24, color: scheme.onErrorContainer),
          ),
          const SizedBox(height: SpacingTokens.space12),
          Text(
            'Could not load your profile',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: scheme.error,
            ),
          ),
          const SizedBox(height: SpacingTokens.space4),
          Text(
            describeApiError(error, sessionIsLive: true),
            style: TextStyle(
              fontSize: 12,
              color: scheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: SpacingTokens.space4),
          TextButton(
            onPressed: () => ref.read(currentUserProvider.notifier).refresh(),
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }

  String _truncateDID(String did) =>
      did.length <= 15 ? did : '${did.substring(0, 15)}…';

  // ============= NAVIGATION SECTION =============

  Widget _sectionDivider(ColorScheme scheme) => Divider(
        height: 1,
        thickness: 1,
        color: scheme.onSurface.withValues(alpha: 0.1),
      );

  Widget _navigation(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space12),
      // Scrollable rather than shrink-wrapped: on a short screen, or at a
      // large text size, the items no longer have to fit to be reachable.
      children: [
        _pillButton(
          context,
          icon: Iconsax.people_copy,
          label: 'Communities',
          onTap: () {
            onCloseDrawer();
            onSelectTab?.call(communitiesTab);
          },
        ),
        _pillButton(
          context,
          icon: Iconsax.archive_add_copy,
          label: 'Saved posts',
          onTap: () => _go(context, Routes.savedPosts),
        ),
        _pillButton(
          context,
          icon: Iconsax.heart_copy,
          label: 'Liked posts',
          onTap: () => _go(context, Routes.likedPosts),
        ),
        _pillButton(
          context,
          icon: Iconsax.setting_copy,
          label: 'Settings',
          onTap: () => _go(context, Routes.settings),
        ),
        _pillButton(
          context,
          icon: Iconsax.info_circle_copy,
          label: 'Help & Support',
          onTap: () => _go(context, Routes.help),
        ),
      ],
    );
  }

  Widget _pillButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    String? badge,
    VoidCallback? onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space12,
        vertical: SpacingTokens.space4,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
          child: Container(
            height: 48,
            padding:
                const EdgeInsets.symmetric(horizontal: SpacingTokens.space16),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
              border: Border.all(
                color: scheme.onSurface.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              children: [
                Icon(icon,
                    size: 20, color: scheme.onSurface.withValues(alpha: 0.8)),
                const SizedBox(width: SpacingTokens.space12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: scheme.onSurface,
                    ),
                  ),
                ),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpacingTokens.space8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.secondary,
                      borderRadius: BorderRadius.circular(RadiusTokens.radius8),
                    ),
                    child: Text(
                      badge,
                      style: TextStyle(
                        fontSize: 11,
                        color: scheme.onSecondary,
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
  }

  // ============= FOOTER SECTION =============

  Widget _footer(BuildContext context, ColorScheme scheme) {
    return Padding(
      padding: EdgeInsets.only(
        left: SpacingTokens.space20,
        right: SpacingTokens.space20,
        bottom: MediaQuery.of(context).padding.bottom + SpacingTokens.space20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textLink(context, 'Terms',
                  onTap: () => _go(context, Routes.terms)),
              const SizedBox(width: SpacingTokens.space16),
              Text('•',
                  style: TextStyle(
                    color: scheme.onSurface.withValues(alpha: 0.3),
                    fontSize: 10,
                  )),
              const SizedBox(width: SpacingTokens.space16),
              _textLink(context, 'Privacy',
                  onTap: () => _go(context, Routes.privacy)),
            ],
          ),
          const SizedBox(height: SpacingTokens.space12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _chipButton(context, 'Help', Iconsax.info_circle_copy,
                  onTap: () => _go(context, Routes.help)),
              const SizedBox(width: SpacingTokens.space12),
              _chipButton(context, 'Feedback', Iconsax.message_edit_copy,
                  onTap: () => _go(context, Routes.settingsFeedback)),
            ],
          ),
          const SizedBox(height: SpacingTokens.space16),

          // The running build, read from the bundle. This line was the literal
          // string "Kyron v1.0.0", so it said 1.0.0 on every build ever
          // shipped.
          FutureBuilder<AppInfo>(
            future: AppInfo.load(),
            builder: (context, snapshot) {
              final version = snapshot.data?.display;
              return GestureDetector(
                onTap: () => _go(context, Routes.about),
                child: Text(
                  version == null ? 'Kyron' : 'Kyron $version',
                  style: TextStyle(
                    fontSize: 10,
                    color: scheme.onSurface.withValues(alpha: 0.4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
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
        ),
      ),
    );
  }

  Widget _chipButton(
    BuildContext context,
    String label,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RadiusTokens.radius8),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingTokens.space12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: isDark ? 0.1 : 0.08),
            borderRadius: BorderRadius.circular(RadiusTokens.radius8),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Closes the drawer, then navigates. Doing it in this order stops the
  /// drawer sliding shut behind the screen that just opened.
  void _go(BuildContext context, String route) {
    onCloseDrawer();
    Navigator.pushNamed(context, route);
  }

  // ============= DID MODAL =============

  void _showDIDModal(BuildContext context, String did) {
    final scheme = Theme.of(context).colorScheme;

    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(RadiusTokens.radius20)),
      ),
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.all(SpacingTokens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: SpacingTokens.space20),
              decoration: BoxDecoration(
                color: scheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(RadiusTokens.radius2),
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
            const SizedBox(height: SpacingTokens.space16),
            Container(
              padding: const EdgeInsets.all(SpacingTokens.space16),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
                border: Border.all(
                  color: scheme.outline.withValues(alpha: 0.2),
                ),
              ),
              child: SelectableText(
                did,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'monospace',
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: SpacingTokens.space20),
            FilledButton.icon(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: did));
                if (!sheetContext.mounted) return;
                Navigator.pop(sheetContext);
                ScaffoldMessenger.of(sheetContext).showSnackBar(
                  const SnackBar(content: Text('DID copied to clipboard')),
                );
              },
              icon: const Icon(Iconsax.copy_copy, size: 18),
              label: const Text('Copy'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
