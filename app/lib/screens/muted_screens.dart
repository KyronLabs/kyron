// lib/screens/muted_screens.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/profile_summary.dart';
import '../providers/moderation_provider.dart';
import '../routes.dart';
import '../utils/api_error_message.dart';

/// Words and tags that keep posts out of your feed.
class MutedWordsScreen extends ConsumerStatefulWidget {
  const MutedWordsScreen({super.key});

  @override
  ConsumerState<MutedWordsScreen> createState() => _MutedWordsScreenState();
}

class _MutedWordsScreenState extends ConsumerState<MutedWordsScreen> {
  final _controller = TextEditingController();

  List<String>? _words;
  String? _error;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final words = await ref.read(moderationRepositoryProvider).mutedWords();
      if (mounted) setState(() => _words = words);
    } catch (e) {
      if (mounted) {
        setState(() => _error = describeApiError(e, sessionIsLive: true));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final words = _words;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: const Text('Muted words and tags'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(SpacingTokens.space16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Posts containing any of these are kept out of your feed. '
                    'Matching ignores case, and a word matches inside longer '
                    'ones -- so "spoiler" also catches "spoilers".',
                    style: TextStyle(
                      fontSize: 13,
                      color: scheme.onSurface.withValues(alpha: .7),
                    ),
                  ),
                  const SizedBox(height: SpacingTokens.space12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          enabled: !_busy,
                          onSubmitted: (_) => _add(),
                          decoration: const InputDecoration(
                            hintText: 'A word, phrase or #tag',
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: SpacingTokens.space8),
                      FilledButton(
                        onPressed: _busy ? null : _add,
                        child: const Text('Mute'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space16,
                ),
                child: Text(
                  _error!,
                  style: TextStyle(color: scheme.error, fontSize: 13),
                ),
              ),
            Expanded(
              child: words == null
                  ? const Center(child: CircularProgressIndicator())
                  : words.isEmpty
                      ? _Empty(
                          icon: Iconsax.text_block_copy,
                          title: 'Nothing muted',
                          detail: 'Add a word or a tag above.',
                        )
                      : ListView.separated(
                          itemCount: words.length,
                          separatorBuilder: (_, __) => Divider(
                            height: 1,
                            color: scheme.outline.withValues(alpha: 0.15),
                          ),
                          itemBuilder: (context, index) => ListTile(
                            title: Text(words[index]),
                            trailing: IconButton(
                              icon: const Icon(Iconsax.close_circle_copy,
                                  size: 18),
                              tooltip: 'Unmute',
                              onPressed: () => _remove(words[index]),
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _add() async {
    final phrase = _controller.text.trim();
    if (phrase.length < 2) return;

    setState(() => _busy = true);
    try {
      await ref.read(moderationRepositoryProvider).muteWord(phrase);
      _controller.clear();
      await _load();
    } catch (e) {
      if (mounted) {
        setState(() => _error = describeApiError(e, sessionIsLive: true));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _remove(String phrase) async {
    setState(() => _busy = true);
    try {
      await ref.read(moderationRepositoryProvider).unmuteWord(phrase);
      await _load();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}

/// Accounts you have muted or blocked, on one screen with two tabs.
class MutedAccountsScreen extends ConsumerStatefulWidget {
  const MutedAccountsScreen({super.key});

  @override
  ConsumerState<MutedAccountsScreen> createState() =>
      _MutedAccountsScreenState();
}

class _MutedAccountsScreenState extends ConsumerState<MutedAccountsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left_copy),
            onPressed: () => Navigator.pop(context),
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          ),
          title: const Text('Muted and blocked'),
          bottom: const TabBar(
            tabs: [Tab(text: 'Muted'), Tab(text: 'Blocked')],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _People(
                load: () => ref.read(moderationRepositoryProvider).mutedUsers(),
                unmute: (id) => ref
                    .read(moderationRepositoryProvider)
                    .setUserMuted(id, false),
                action: 'Unmute',
                emptyTitle: 'Nobody muted',
                emptyDetail:
                    'Muting an account hides their posts without telling them.',
              ),
              _People(
                load: () =>
                    ref.read(moderationRepositoryProvider).blockedUsers(),
                unmute: (id) => ref
                    .read(moderationRepositoryProvider)
                    .setBlocked(id, false),
                action: 'Unblock',
                emptyTitle: 'Nobody blocked',
                emptyDetail: 'Blocking hides you from each other, both ways.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _People extends StatefulWidget {
  final Future<List<ProfileSummary>> Function() load;
  final Future<void> Function(String id) unmute;
  final String action;
  final String emptyTitle;
  final String emptyDetail;

  const _People({
    required this.load,
    required this.unmute,
    required this.action,
    required this.emptyTitle,
    required this.emptyDetail,
  });

  @override
  State<_People> createState() => _PeopleState();
}

class _PeopleState extends State<_People> {
  late Future<List<ProfileSummary>> _people = widget.load();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return FutureBuilder<List<ProfileSummary>>(
      future: _people,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _Empty(
            icon: Icons.cloud_off_outlined,
            title: 'Could not load this list',
            detail: describeApiError(snapshot.error!, sessionIsLive: true),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final people = snapshot.data!;
        if (people.isEmpty) {
          return _Empty(
            icon: Iconsax.profile_2user_copy,
            title: widget.emptyTitle,
            detail: widget.emptyDetail,
          );
        }

        return ListView.separated(
          itemCount: people.length,
          separatorBuilder: (_, __) => Divider(
            height: 1,
            color: scheme.outline.withValues(alpha: 0.15),
          ),
          itemBuilder: (context, index) {
            final person = people[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundColor: scheme.primary.withValues(alpha: 0.15),
                foregroundImage: person.avatarUrl == null
                    ? null
                    : NetworkImage(person.avatarUrl!),
                child: Icon(Iconsax.user_copy, size: 18, color: scheme.primary),
              ),
              title: Text(person.displayName),
              subtitle: person.handle == null ? null : Text(person.handle!),
              onTap: () => openProfile(
                context,
                username: person.username,
                userId: person.id,
              ),
              trailing: TextButton(
                onPressed: () async {
                  await widget.unmute(person.id);
                  setState(() => _people = widget.load());
                },
                child: Text(widget.action),
              ),
            );
          },
        );
      },
    );
  }
}

class _Empty extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;

  const _Empty({
    required this.icon,
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 40, color: scheme.onSurface.withValues(alpha: .35)),
            const SizedBox(height: SpacingTokens.space12),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: SpacingTokens.space8),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: TextStyle(color: scheme.onSurface.withValues(alpha: .7)),
            ),
          ],
        ),
      ),
    );
  }
}
