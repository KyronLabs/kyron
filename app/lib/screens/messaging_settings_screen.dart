// lib/screens/messaging_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../providers/messages_provider.dart';
import '../providers/preferences_provider.dart';
import '../providers/presence_provider.dart';
import '../routes.dart';
import '../utils/api_error_message.dart';
import '../widgets/settings_scaffold.dart';
import '../widgets/toast.dart';

/// Whether this account shares read receipts, as the server holds it.
final readReceiptsProvider = FutureProvider.autoDispose<bool>(
  (ref) => ref.read(messagesRepositoryProvider).readReceipts(),
);

/// Whether this account shows when it is online, as the server holds it.
final showOnlineProvider = FutureProvider.autoDispose<bool>(
  (ref) => ref.read(messagesRepositoryProvider).showOnline(),
);

/// The settings that are about messages, in one place rather than scattered
/// through the app's general ones.
///
/// Every switch here does what it says. Read receipts and being shown online
/// are held by the server, because they are about what other people are
/// told; typing and link previews are this phone's, because they are about
/// what this phone sends.
class MessagingSettingsScreen extends ConsumerStatefulWidget {
  const MessagingSettingsScreen({super.key});

  @override
  ConsumerState<MessagingSettingsScreen> createState() =>
      _MessagingSettingsScreenState();
}

class _MessagingSettingsScreenState
    extends ConsumerState<MessagingSettingsScreen> {
  /// The reader's choice while the server is being told, so the switch moves
  /// under their thumb rather than after a round trip.
  bool? _receipts;
  bool? _online;

  Future<void> _setOnline(bool on) async {
    setState(() => _online = on);
    // Nobody's dot, at once, when the reader stops showing theirs: the
    // server says so too, but this is the reader's own switch and should
    // not wait on a round trip to look like it worked.
    if (!on) ref.read(presenceProvider.notifier).hideAll();
    try {
      await ref.read(messagesRepositoryProvider).setShowOnline(on);
      ref.invalidate(showOnlineProvider);
    } catch (error) {
      if (!mounted) return;
      setState(() => _online = !on);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  Future<void> _setReceipts(bool on) async {
    setState(() => _receipts = on);
    try {
      await ref.read(messagesRepositoryProvider).setReadReceipts(on);
      ref.invalidate(readReceiptsProvider);
    } catch (error) {
      if (!mounted) return;
      // Put back: a switch showing a setting the server did not take is the
      // one thing a privacy switch must never do.
      setState(() => _receipts = !on);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final prefs = ref.watch(preferencesProvider);
    final notifier = ref.read(preferencesProvider.notifier);
    final receipts = _receipts ?? ref.watch(readReceiptsProvider).asData?.value;
    final online = _online ?? ref.watch(showOnlineProvider).asData?.value;

    return SettingsScaffold(
      title: l10n.ui('ui_dm_settings', 'Messages'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Heading(l10n.ui('ui_dm_settings_privacy', 'Privacy')),
          SwitchListTile(
            key: const ValueKey('setting-read-receipts'),
            contentPadding: EdgeInsets.zero,
            value: receipts ?? true,
            // Not until the server has said what it is: a switch drawn on
            // and then flipping to off would look like it changed itself.
            onChanged: receipts == null ? null : _setReceipts,
            title: Text(l10n.ui('ui_dm_read_receipts', 'Read receipts')),
            subtitle: Text(
              l10n.ui(
                'ui_dm_read_receipts_detail',
                "When this is off, people won't see when you've read their "
                    "messages, and you won't see when they've read yours.",
              ),
            ),
          ),
          SwitchListTile(
            key: const ValueKey('setting-show-online'),
            contentPadding: EdgeInsets.zero,
            value: online ?? true,
            onChanged: online == null ? null : _setOnline,
            title:
                Text(l10n.ui('ui_dm_show_online', "Show when you're online")),
            subtitle: Text(
              l10n.ui(
                'ui_dm_show_online_detail',
                'People you message see a green dot while you have Kyron '
                    "open. When this is off, you won't see theirs either.",
              ),
            ),
          ),
          SwitchListTile(
            key: const ValueKey('setting-typing'),
            contentPadding: EdgeInsets.zero,
            value: prefs.typingShown,
            onChanged: notifier.setTypingShown,
            title: Text(
                l10n.ui('ui_dm_typing_setting', "Show when you're typing")),
            subtitle: Text(
              l10n.ui(
                'ui_dm_typing_setting_detail',
                'The person you are writing to sees that you are writing.',
              ),
            ),
          ),
          SwitchListTile(
            key: const ValueKey('setting-link-previews'),
            contentPadding: EdgeInsets.zero,
            value: prefs.linkPreviews,
            onChanged: notifier.setLinkPreviews,
            title: Text(l10n.ui('ui_dm_link_previews', 'Link previews')),
            subtitle: Text(
              l10n.ui(
                'ui_dm_link_previews_detail',
                'Your phone opens a link you send to make its preview, so '
                    "the site sees your phone ask. Kyron's server never sees "
                    'the link.',
              ),
            ),
          ),
          const SizedBox(height: SpacingTokens.space16),
          _Heading(l10n.notifications),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Iconsax.notification_copy),
            title: Text(l10n.ui(
                'ui_dm_settings_notifications', 'Notifications for messages')),
            trailing: const Icon(Iconsax.arrow_right_3_copy, size: 18),
            onTap: () =>
                Navigator.pushNamed(context, Routes.settingsNotifications),
          ),
          const SizedBox(height: SpacingTokens.space24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Iconsax.lock_1_copy,
                size: 16,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.55),
              ),
              const SizedBox(width: SpacingTokens.space8),
              Expanded(
                child: Text(
                  l10n.ui(
                    'ui_dm_settings_e2ee',
                    'Messages are end-to-end encrypted. Kyron cannot read '
                        'them, and nothing here changes that.',
                  ),
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize1,
                    height: 1.4,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
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
