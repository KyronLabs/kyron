// lib/screens/new_message_screen.dart
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
import '../widgets/toast.dart';
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
  final String id;
  final String name;
  final String? handle;
  final String? avatarUrl;

  /// Set when there is a conversation with them already.
  final String? conversationId;

  const _Person({
    required this.id,
    required this.name,
    this.handle,
    this.avatarUrl,
    this.conversationId,
  });

  MessagePerson get asPerson => MessagePerson(
        id: id,
        name: name,
        username: handle,
        avatarUrl: avatarUrl,
      );
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
        arguments: ThreadArgs(conversationId: id, people: [person.asPerson]),
      );
    } catch (error) {
      if (!mounted) return;
      setState(() => _opening = null);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
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
          c.other!.id: _Person(
            id: c.other!.id,
            name: c.other!.displayName,
            handle: c.other!.username,
            avatarUrl: c.other!.avatarUrl,
            conversationId: c.id,
          ),
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
                id: p.id,
                name: p.name?.trim().isNotEmpty == true
                    ? p.name!.trim()
                    : '@${p.username ?? ''}',
                handle: p.username,
                avatarUrl: p.avatarUrl,
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
              SpacingTokens.space8,
            ),
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: SpacingTokens.space12,
              ),
              decoration: BoxDecoration(
                color: scheme.surfaceContainer,
                borderRadius: BorderRadius.circular(RadiusTokens.radius20),
              ),
              child: Row(
                children: [
                  Text(
                    l10n.ui('ui_dm_new_to', 'To:'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(width: SpacingTokens.space8),
                  Expanded(
                    child: TextField(
                      key: const ValueKey('new-message-search'),
                      controller: _query,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(
                        fontSize: TypographyTokens.fontSize3,
                      ),
                      decoration: InputDecoration(
                        hintText: l10n.ui('ui_share_search', 'Search'),
                        isDense: true,
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
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
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: SpacingTokens.space24),
              children: [
                if (people.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      SpacingTokens.space16,
                      SpacingTokens.space8,
                      SpacingTokens.space16,
                      SpacingTokens.space4,
                    ),
                    child: Text(
                      heading,
                      style: TextStyle(
                        fontSize: TypographyTokens.fontSize1,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                        color: scheme.onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                  ),
                for (final person in people)
                  ListTile(
                    key: ValueKey('new-message-${person.id}'),
                    onTap: () => _open(person),
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: scheme.primary.withValues(alpha: .15),
                      foregroundImage: person.avatarUrl == null
                          ? null
                          : NetworkImage(person.avatarUrl!),
                      child: Icon(
                        Iconsax.user_copy,
                        size: 20,
                        color: scheme.primary,
                      ),
                    ),
                    title: Text(
                      person.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: person.handle == null
                        ? null
                        : Text(
                            '@${person.handle}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
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
