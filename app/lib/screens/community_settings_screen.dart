// lib/screens/community_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/community.dart';
import '../providers/communities_provider.dart';
import '../providers/feed_provider.dart';
import '../providers/preferences_provider.dart';
import '../utils/api_error_message.dart';
import '../widgets/community_avatar.dart';
import '../widgets/settings_scaffold.dart';
import '../widgets/toast.dart';
import 'community_manage_screen.dart';

/// Whether this account's community posts also appear in Home, as the server
/// holds it.
final communityPostsInHomeProvider = FutureProvider.autoDispose<bool>(
  (ref) => ref.read(communitiesRepositoryProvider).postsInHome(),
);

/// The settings that are about communities, in one place.
///
/// Every switch here does what it says. Whether community posts appear in
/// Home is the server's, because Home is built there; whether the list shows
/// counts is this phone's. And the communities the reader runs, one tap from
/// managing each, rather than found by scrolling for them.
class CommunitySettingsScreen extends ConsumerStatefulWidget {
  const CommunitySettingsScreen({super.key});

  @override
  ConsumerState<CommunitySettingsScreen> createState() =>
      _CommunitySettingsScreenState();
}

class _CommunitySettingsScreenState
    extends ConsumerState<CommunitySettingsScreen> {
  /// The reader's choice while the server is being told, so the switch moves
  /// under their thumb rather than after a round trip.
  bool? _inHome;

  Future<void> _setInHome(bool on) async {
    setState(() => _inHome = on);
    try {
      await ref.read(communitiesRepositoryProvider).setPostsInHome(on);
      ref.invalidate(communityPostsInHomeProvider);
      // Home is built on the server, so it has to be read again to show the
      // change; the two tabs of it both follow the setting.
      ref.invalidate(postListProvider(PostListSource.recent));
      ref.invalidate(postListProvider(PostListSource.following));
    } catch (error) {
      if (!mounted) return;
      // Put back: a switch showing a setting the server did not take is a
      // switch that lies.
      setState(() => _inHome = !on);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final prefs = ref.watch(preferencesProvider);
    final inHome =
        _inHome ?? ref.watch(communityPostsInHomeProvider).asData?.value;
    final running = ref.watch(myCommunitiesProvider(CommunityFilter.running));

    return SettingsScaffold(
      title: l10n.communities,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Heading(l10n.ui('ui_community_settings_home', 'Home')),
          SwitchListTile(
            key: const ValueKey('setting-community-home'),
            contentPadding: EdgeInsets.zero,
            value: inHome ?? true,
            // Not until the server has said what it is: a switch drawn on
            // and then flipping to off would look like it changed itself.
            onChanged: inHome == null ? null : _setInHome,
            title: Text(
              l10n.ui('ui_community_in_home', 'Community posts in Home'),
            ),
            subtitle: Text(
              l10n.ui(
                'ui_community_in_home_detail',
                'Posts from your communities also appear in Home. Off, they '
                    'stay here in Communities, where each one shows what is '
                    'new.',
              ),
            ),
          ),
          const SizedBox(height: SpacingTokens.space16),
          _Heading(l10n.ui('ui_community_settings_list', 'Your list')),
          SwitchListTile(
            key: const ValueKey('setting-community-counts'),
            contentPadding: EdgeInsets.zero,
            value: prefs.communityCounts,
            onChanged:
                ref.read(preferencesProvider.notifier).setCommunityCounts,
            title: Text(l10n.ui('ui_community_counts', 'New-post counts')),
            subtitle: Text(
              l10n.ui(
                'ui_community_counts_detail',
                'Show how many posts are new in each community since you '
                    'last opened it.',
              ),
            ),
          ),
          const SizedBox(height: SpacingTokens.space16),
          _Heading(
              l10n.ui('ui_community_settings_running', 'Communities you run')),
          if (running.loadingFirstPage)
            const Padding(
              padding: EdgeInsets.all(SpacingTokens.space16),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (running.items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SpacingTokens.space8,
              ),
              child: Text(
                l10n.ui(
                  'ui_community_running_none_detail',
                  'Communities you start, or moderate, are listed here.',
                ),
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
              ),
            )
          else
            for (final community in running.items)
              ListTile(
                key: ValueKey('setting-run-${community.id}'),
                contentPadding: EdgeInsets.zero,
                leading: CommunityAvatar(
                  avatarUrl: community.avatarUrl,
                  initial: community.name.trim().isEmpty
                      ? '#'
                      : community.name.trim()[0].toUpperCase(),
                ),
                title: Text(
                  community.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  community.role == CommunityRole.owner
                      ? l10n.ui('ui_community_role_owner', 'Owner')
                      : l10n.ui('ui_community_role_moderator', 'Moderator'),
                ),
                trailing: const Icon(Iconsax.arrow_right_3_copy, size: 18),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => CommunityManageScreen(community: community),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  final String text;

  const _Heading(this.text);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: SpacingTokens.space4),
        child: Text(
          text,
          style: TextStyle(
            fontSize: TypographyTokens.fontSize1,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            color: Theme.of(context).colorScheme.onSurface.withValues(
                  alpha: 0.55,
                ),
          ),
        ),
      );
}
