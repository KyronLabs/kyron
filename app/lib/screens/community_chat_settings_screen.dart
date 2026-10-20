// lib/screens/community_chat_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/community_chat.dart';
import '../providers/community_chats_provider.dart';
import '../utils/api_error_message.dart';
import '../widgets/action_button.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/toast.dart';

/// Opening a chat in a community, or changing one. For the community's
/// owner and moderators; the server refuses anybody else whatever this
/// screen shows.
class CommunityChatSettingsScreen extends ConsumerStatefulWidget {
  /// The community a new chat goes in. Null when editing [chat].
  final String? slug;
  final CommunityChat? chat;

  const CommunityChatSettingsScreen._({this.slug, this.chat});

  /// Opens a new chat in [slug], and answers it once it exists.
  static Future<CommunityChat?> create(BuildContext context, String slug) =>
      Navigator.of(context).push<CommunityChat>(
        MaterialPageRoute(
          builder: (_) => CommunityChatSettingsScreen._(slug: slug),
        ),
      );

  /// Changes [chat]. Answers whether anything was saved.
  static Future<bool> edit(BuildContext context, CommunityChat chat) async =>
      await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (_) => CommunityChatSettingsScreen._(chat: chat),
        ),
      ) ??
      false;

  /// The slow modes offered, in seconds. 0 is off.
  static const slowModes = [0, 5, 30, 60, 300, 900, 3600];

  @override
  ConsumerState<CommunityChatSettingsScreen> createState() =>
      _CommunityChatSettingsScreenState();
}

class _CommunityChatSettingsScreenState
    extends ConsumerState<CommunityChatSettingsScreen> {
  late final _name = TextEditingController(text: widget.chat?.name ?? '');
  late final _description =
      TextEditingController(text: widget.chat?.description ?? '');
  late bool _announcements = widget.chat?.announcements ?? false;
  late int _slowMode = widget.chat?.slowModeSeconds ?? 0;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _name.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  String _slowLabel(AppLocalizations l10n, int seconds) => switch (seconds) {
        0 => l10n.ui('ui_cchat_slow_off', 'Off'),
        < 60 => l10n
            .ui('ui_cchat_slow_seconds', r'$n seconds')
            .replaceAll(r'$n', '$seconds'),
        < 3600 => l10n
            .ui('ui_cchat_slow_minutes', r'$n minutes')
            .replaceAll(r'$n', '${seconds ~/ 60}'),
        _ => l10n.ui('ui_cchat_slow_hour', '1 hour'),
      };

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty || _busy) return;
    setState(() => _busy = true);
    final repo = ref.read(communityChatsRepositoryProvider);
    final writers =
        _announcements ? ChatWriters.moderators : ChatWriters.members;
    try {
      final chat = widget.chat;
      if (chat == null) {
        final made = await repo.create(
          widget.slug!,
          name: name,
          description: _description.text,
          writers: writers,
        );
        ref.invalidate(communityChatsProvider(widget.slug!));
        if (mounted) Navigator.pop(context, made);
      } else {
        final description = _description.text.trim();
        await repo.update(
          chat.id,
          name: name,
          description: description,
          clearDescription: description.isEmpty,
          writers: writers,
          slowModeSeconds: _slowMode,
        );
        ref.invalidate(communityChatsProvider(chat.communitySlug));
        if (mounted) Navigator.pop(context, true);
      }
    } catch (error) {
      if (!mounted) return;
      setState(() => _busy = false);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final editing = widget.chat != null;
    return Scaffold(
      appBar: KyronAppBar(
        title: Text(
          editing
              ? l10n.ui('ui_cchat_edit', 'Edit chat')
              : l10n.ui('ui_cchat_new', 'New chat'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(SpacingTokens.space16),
        children: [
          TextField(
            key: const ValueKey('cchat-name'),
            controller: _name,
            autofocus: !editing,
            maxLength: 40,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l10n.ui('ui_cchat_name', 'Chat name'),
            ),
          ),
          TextField(
            key: const ValueKey('cchat-description'),
            controller: _description,
            maxLength: 200,
            maxLines: 3,
            minLines: 1,
            decoration: InputDecoration(
              labelText: l10n.ui('ui_cchat_about', 'What it is for (optional)'),
            ),
          ),
          SwitchListTile.adaptive(
            key: const ValueKey('cchat-announcements'),
            contentPadding: EdgeInsets.zero,
            value: _announcements,
            onChanged: (on) => setState(() => _announcements = on),
            title: Text(
              l10n.ui('ui_cchat_announcements', 'Only moderators can write'),
            ),
            subtitle: Text(
              l10n.ui(
                'ui_cchat_announcements_detail',
                'For announcements. Everyone in the community can still read '
                    'and react.',
              ),
            ),
          ),
          if (editing)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.ui('ui_cchat_slow', 'Slow mode')),
              subtitle: Text(
                l10n.ui(
                  'ui_cchat_slow_detail',
                  'How long people wait between messages. Not moderators.',
                ),
              ),
              trailing: DropdownButton<int>(
                key: const ValueKey('cchat-slow'),
                value: _slowMode,
                onChanged: (value) =>
                    setState(() => _slowMode = value ?? _slowMode),
                items: [
                  for (final seconds in CommunityChatSettingsScreen.slowModes)
                    DropdownMenuItem(
                      value: seconds,
                      child: Text(_slowLabel(l10n, seconds)),
                    ),
                ],
              ),
            ),
          const SizedBox(height: SpacingTokens.space8),
          Text(
            l10n.ui(
              'ui_cchat_not_encrypted',
              'Community chats are not end-to-end encrypted. The '
                  "community's moderators and Kyron can read them.",
            ),
            style: TextStyle(
              fontSize: TypographyTokens.fontSize1,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: SpacingTokens.space24),
          ActionButton(
            key: const ValueKey('cchat-save'),
            label: editing ? l10n.save : l10n.create,
            expand: true,
            busy: _busy,
            onPressed: _name.text.trim().isEmpty ? null : _save,
          ),
        ],
      ),
    );
  }
}
