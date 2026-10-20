// lib/screens/group_people_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/conversation.dart';
import '../models/profile_summary.dart';
import '../providers/messages_provider.dart';
import '../providers/people_search_provider.dart';
import '../utils/api_error_message.dart';
import '../widgets/action_button.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/toast.dart';

/// The most people a group holds, its owner included. The server holds the
/// same line: past it, every message is sealed for more devices than is
/// worth the wait. See docs/MESSAGING.md.
const maxGroupSize = 32;

/// Chooses people: for a new group, or to add to one.
///
/// Answers who was chosen, or null when the reader backed out. [exclude]
/// are not offered -- the people already in the group -- and no more than
/// [room] can be chosen.
Future<List<MessagePerson>?> pickPeople(
  BuildContext context, {
  required String title,
  required String action,
  Set<String> exclude = const {},
  int room = maxGroupSize - 1,
}) =>
    Navigator.of(context).push<List<MessagePerson>>(
      MaterialPageRoute(
        builder: (_) => _PeoplePicker(
          title: title,
          action: action,
          exclude: exclude,
          room: room,
        ),
      ),
    );

class _PeoplePicker extends ConsumerStatefulWidget {
  final String title;
  final String action;
  final Set<String> exclude;
  final int room;

  const _PeoplePicker({
    required this.title,
    required this.action,
    required this.exclude,
    required this.room,
  });

  @override
  ConsumerState<_PeoplePicker> createState() => _PeoplePickerState();
}

class _PeoplePickerState extends ConsumerState<_PeoplePicker> {
  final _query = TextEditingController();

  /// In the order they were chosen, so the row of chips reads that way.
  final Map<String, MessagePerson> _chosen = {};

  @override
  void initState() {
    super.initState();
    _query.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  void _toggle(MessagePerson person) {
    setState(() {
      if (_chosen.remove(person.id) != null) return;
      if (_chosen.length >= widget.room) {
        Toast.show(
          context,
          AppLocalizations.of(context)
              .ui('ui_group_full', r'A group can have at most $count people.')
              .replaceAll(r'$count', '$maxGroupSize'),
        );
        return;
      }
      _chosen[person.id] = person;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final query = _query.text.trim();

    final List<MessagePerson> people;
    if (query.length < 2) {
      people = [
        for (final c in ref
            .watch(conversationListProvider(ConversationFilter.all))
            .items)
          if (c.other != null) c.other!,
      ];
    } else {
      people = [
        for (final p in ref.watch(peopleSearchProvider(query)).asData?.value ??
            const <ProfileSummary>[])
          MessagePerson(
            id: p.id,
            name: p.name,
            username: p.username,
            avatarUrl: p.avatarUrl,
          ),
      ];
    }
    final offered = [
      for (final p in people)
        if (!widget.exclude.contains(p.id)) p,
    ];

    return Scaffold(
      appBar: KyronAppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: SpacingTokens.space8),
            child: TextButton(
              key: const ValueKey('pick-people-done'),
              onPressed: _chosen.isEmpty
                  ? null
                  : () => Navigator.pop(context, _chosen.values.toList()),
              child: Text(widget.action),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              SpacingTokens.space16,
              SpacingTokens.space8,
              SpacingTokens.space16,
              SpacingTokens.space8,
            ),
            child: TextField(
              key: const ValueKey('pick-people-search'),
              controller: _query,
              autofocus: true,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: l10n.ui('ui_share_search', 'Search'),
                prefixIcon: const Icon(Iconsax.search_normal_1_copy, size: 18),
                isDense: true,
              ),
            ),
          ),
          if (_chosen.isNotEmpty)
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space16,
                ),
                children: [
                  for (final person in _chosen.values)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: SpacingTokens.space8,
                      ),
                      child: InputChip(
                        label: Text(person.displayName),
                        onDeleted: () => _toggle(person),
                      ),
                    ),
                ],
              ),
            ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: SpacingTokens.space24),
              children: [
                for (final person in offered)
                  CheckboxListTile(
                    key: ValueKey('pick-${person.id}'),
                    value: _chosen.containsKey(person.id),
                    onChanged: (_) => _toggle(person),
                    secondary: CircleAvatar(
                      radius: 20,
                      backgroundColor: scheme.primary.withValues(alpha: .15),
                      foregroundImage: person.avatarUrl == null
                          ? null
                          : NetworkImage(person.avatarUrl!),
                      child: Icon(
                        Iconsax.user_copy,
                        size: 18,
                        color: scheme.primary,
                      ),
                    ),
                    title: Text(
                      person.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: person.handle == null
                        ? null
                        : Text(person.handle!, maxLines: 1),
                  ),
                if (offered.isEmpty && query.length >= 2)
                  Padding(
                    padding: const EdgeInsets.all(SpacingTokens.space24),
                    child: Text(
                      l10n.ui('ui_dm_new_nobody', 'Nobody by that name.'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: scheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A new group's name, and whether people added to it later start as
/// spectators. Answers the new group's id once it exists.
class NewGroupScreen extends ConsumerStatefulWidget {
  final List<MessagePerson> people;

  const NewGroupScreen({super.key, required this.people});

  @override
  ConsumerState<NewGroupScreen> createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends ConsumerState<NewGroupScreen> {
  final _name = TextEditingController();
  bool _spectators = false;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _name.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    final title = _name.text.trim();
    if (title.isEmpty || _busy) return;
    setState(() => _busy = true);
    try {
      final id = await ref.read(messagesRepositoryProvider).createGroup(
            title,
            [for (final p in widget.people) p.id],
            joinRole: _spectators ? MemberRole.spectator : MemberRole.member,
          );
      if (mounted) Navigator.pop(context, id);
    } catch (error) {
      if (!mounted) return;
      setState(() => _busy = false);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: KyronAppBar(
        title: Text(l10n.ui('ui_group_new', 'Create group chat')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(SpacingTokens.space16),
        children: [
          TextField(
            key: const ValueKey('new-group-name'),
            controller: _name,
            autofocus: true,
            maxLength: 80,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l10n.ui('ui_group_name', 'Group name'),
            ),
          ),
          SwitchListTile.adaptive(
            key: const ValueKey('new-group-spectators'),
            contentPadding: EdgeInsets.zero,
            value: _spectators,
            onChanged: (on) => setState(() => _spectators = on),
            title: Text(
              l10n.ui(
                'ui_group_join_spectators',
                'People added later join as spectators',
              ),
            ),
            subtitle: Text(
              l10n.ui(
                'ui_group_spectators_detail',
                'Spectators can read, react and raise a hand to ask to write.',
              ),
            ),
          ),
          const SizedBox(height: SpacingTokens.space8),
          Text(
            widget.people.map((p) => p.displayName).join(', '),
            style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.6)),
          ),
          const SizedBox(height: SpacingTokens.space8),
          Text(
            l10n.ui(
              'ui_group_e2ee',
              'Messages in this group are end-to-end encrypted, like any '
                  'other conversation.',
            ),
            style: TextStyle(
              fontSize: TypographyTokens.fontSize1,
              color: scheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: SpacingTokens.space24),
          ActionButton(
            key: const ValueKey('new-group-create'),
            label: l10n.create,
            expand: true,
            busy: _busy,
            onPressed: _name.text.trim().isEmpty ? null : _create,
          ),
        ],
      ),
    );
  }
}
