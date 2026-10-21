// lib/screens/new_message_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/conversation.dart';
import '../models/profile_summary.dart';
import '../providers/messages_provider.dart';
import '../providers/people_search_provider.dart';
import '../routes.dart';
import '../utils/api_error_message.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/people_picking.dart';
import '../widgets/toast.dart';
import 'group_people_screen.dart';
import 'thread_screen.dart' show ThreadArgs;

/// Starting a conversation: somebody to write to, found by name, with the
/// people already talked to offered before anything is typed.
///
/// There was no way to start one from Messages at all -- only from a
/// profile, which meant finding the person somewhere else first.
class NewMessageScreen extends ConsumerStatefulWidget {
  const NewMessageScreen({super.key});

  @override
  ConsumerState<NewMessageScreen> createState() => _NewMessageScreenState();
}

/// Somebody who can be written to: from a conversation already held, or
/// from a search.
class _Person {
  final MessagePerson person;

  /// Set when there is a conversation with them already.
  final String? conversationId;

  const _Person(this.person, {this.conversationId});

  String get id => person.id;
}

class _NewMessageScreenState extends ConsumerState<NewMessageScreen> {
  final _query = TextEditingController();

  /// Whose conversation is being opened, while it is.
  String? _opening;

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

  Future<void> _open(_Person person) async {
    if (_opening != null) return;
    setState(() => _opening = person.id);
    try {
      final id = person.conversationId ??
          await ref.read(messagesRepositoryProvider).openWith(person.id);
      if (!mounted) return;
      // In place of this screen: back from the conversation is back to the
      // list, not to a search the reader has finished with.
      await Navigator.pushReplacementNamed(
        context,
        Routes.thread,
        arguments: ThreadArgs(conversationId: id, people: [person.person]),
      );
    } catch (error) {
      if (!mounted) return;
      setState(() => _opening = null);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  /// Starts a group, and opens it in place of this screen.
  Future<void> _newGroup() async {
    final made = await startGroup(context);
    if (made == null || made.id.isEmpty || !mounted) return;
    unawaited(refreshConversations(ref));
    await Navigator.pushReplacementNamed(
      context,
      Routes.thread,
      arguments: ThreadArgs(conversationId: made.id, people: made.people),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final query = _query.text.trim();

    final talkedTo = <String, _Person>{
      for (final c
          in ref.watch(conversationListProvider(ConversationFilter.all)).items)
        if (c.other != null)
          c.other!.id: _Person(c.other!, conversationId: c.id),
    };

    final List<_Person> people;
    final String heading;
    if (query.length < 2) {
      heading = l10n.ui('ui_dm_new_recent', 'Recent');
      people = talkedTo.values.toList();
    } else {
      heading = l10n.ui('ui_dm_new_people', 'People');
      people = [
        for (final p in ref.watch(peopleSearchProvider(query)).asData?.value ??
            const <ProfileSummary>[])
          talkedTo[p.id] ??
              _Person(
                MessagePerson(
                  id: p.id,
                  name: p.name,
                  username: p.username,
                  avatarUrl: p.avatarUrl,
                ),
              ),
      ];
    }
    final searching =
        query.length >= 2 && ref.watch(peopleSearchProvider(query)).isLoading;

    return Scaffold(
      appBar: KyronAppBar(
        title: Text(l10n.ui('ui_dm_new', 'New message')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              SpacingTokens.space16,
              SpacingTokens.space8,
              SpacingTokens.space16,
              SpacingTokens.space4,
            ),
            child: Row(
              children: [
                Text(
                  l10n.ui('ui_dm_new_to', 'To:'),
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize3,
                    color: scheme.onSurface.withValues(alpha: 0.45),
                  ),
                ),
                const SizedBox(width: SpacingTokens.space8),
                Expanded(
                  child: TextField(
                    key: const ValueKey('new-message-search'),
                    controller: _query,
                    textAlignVertical: TextAlignVertical.center,
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    style: const TextStyle(
                      fontSize: TypographyTokens.fontSize3,
                    ),
                    decoration: InputDecoration(
                      hintText: l10n.ui('ui_share_search', 'Search'),
                      hintStyle: TextStyle(
                        color: scheme.onSurface.withValues(alpha: 0.35),
                      ),
                      isDense: true,
                      filled: false,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      // Not the theme's 44-point floor: this field sits in a
                      // line of its own height, and centred its text in 44.
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ),
                if (searching)
                  const SizedBox.square(
                    dimension: 14,
                    child: CircularProgressIndicator(strokeWidth: 1.5),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: SpacingTokens.space24),
              children: [
                if (query.isEmpty)
                  PickRow(
                    key: const ValueKey('new-group'),
                    onTap: _newGroup,
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: scheme.onSurface.withValues(alpha: .06),
                      child: Icon(
                        Iconsax.profile_2user_copy,
                        size: 20,
                        color: scheme.onSurface,
                      ),
                    ),
                    title: l10n.ui('ui_group_new', 'Create group chat'),
                    trailing: Icon(
                      Iconsax.arrow_right_3_copy,
                      size: 18,
                      color: scheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                if (people.isNotEmpty) PeopleHeading(heading),
                for (final person in people)
                  PersonPickRow(
                    key: ValueKey('new-message-${person.id}'),
                    person: person.person,
                    onTap: () => _open(person),
                    trailing: _opening == person.id
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : null,
                  ),
                if (people.isEmpty && query.length >= 2 && !searching)
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
