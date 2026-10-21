// lib/screens/group_people_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/conversation.dart';
import '../models/profile_summary.dart';
import '../providers/messages_provider.dart';
import '../providers/people_search_provider.dart';
import '../utils/api_error_message.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/people_picking.dart';
import '../widgets/toast.dart';

/// The most people a group holds, its owner included. The server holds the
/// same line: past it, every message is sealed for more devices than is
/// worth the wait. See docs/MESSAGING.md.
const maxGroupSize = 32;

/// Chooses people to add to a group. Answers who was chosen, or null when
/// the reader backed out. [exclude] are not offered -- the people already in
/// the group -- and no more than [room] can be chosen.
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

/// Starts a group: its name in the bar at the top, the people under it, and
/// Done makes it. Answers the new group and who was put in it, or null when
/// the reader backed out.
///
/// One screen, where there were two -- a list of square boxes, then a form
/// for the name. Whether people added later join as spectators is a setting
/// of the group, there in its details, rather than a question to answer
/// before it exists.
Future<({String id, List<MessagePerson> people})?> startGroup(
  BuildContext context,
) =>
    Navigator.of(context).push<({String id, List<MessagePerson> people})>(
      MaterialPageRoute(
        builder: (_) => const _PeoplePicker(
          title: '',
          action: '',
          exclude: {},
          room: maxGroupSize - 1,
          starting: true,
        ),
      ),
    );

class _PeoplePicker extends ConsumerStatefulWidget {
  final String title;
  final String action;
  final Set<String> exclude;
  final int room;

  /// Starting a group, rather than adding to one: the bar holds its name,
  /// and Done makes it.
  final bool starting;

  const _PeoplePicker({
    required this.title,
    required this.action,
    required this.exclude,
    required this.room,
    this.starting = false,
  });

  @override
  ConsumerState<_PeoplePicker> createState() => _PeoplePickerState();
}

class _PeoplePickerState extends ConsumerState<_PeoplePicker> {
  final _query = TextEditingController();
  final _name = TextEditingController();
  final _nameFocus = FocusNode();
  bool _busy = false;

  /// In the order they were chosen, so the "To:" line reads that way.
  final Map<String, MessagePerson> _chosen = {};

  @override
  void initState() {
    super.initState();
    _query.addListener(() => setState(() {}));
    _name.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _query.dispose();
    _name.dispose();
    _nameFocus.dispose();
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
      // Picked from a search: the search has done its job.
      _query.clear();
    });
  }

  Future<void> _done() async {
    final people = _chosen.values.toList();
    if (people.isEmpty || _busy) return;
    if (!widget.starting) {
      Navigator.pop(context, people);
      return;
    }
    final l10n = AppLocalizations.of(context);
    final name = _name.text.trim();
    if (name.isEmpty) {
      // A group needs a name; the place for it is the bar, so go there.
      _nameFocus.requestFocus();
      Toast.show(
          context, l10n.ui('ui_group_name_first', 'Name the group first.'));
      return;
    }
    setState(() => _busy = true);
    try {
      final id = await ref.read(messagesRepositoryProvider).createGroup(
        name,
        [for (final p in people) p.id],
      );
      if (mounted) Navigator.pop(context, (id: id, people: people));
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
    final ready = _chosen.isNotEmpty && !_busy;

    return Scaffold(
      appBar: KyronAppBar(
        centerTitle: true,
        title: widget.starting
            ? TextField(
                key: const ValueKey('new-group-name'),
                textAlignVertical: TextAlignVertical.center,
                controller: _name,
                focusNode: _nameFocus,
                // Not maxLength: that keeps room under the field for a
                // counter, hidden or not, and pushed the name up off the
                // line the back arrow and Done sit on.
                inputFormatters: [LengthLimitingTextInputFormatter(80)],
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
                style: const TextStyle(
                  fontSize: TypographyTokens.fontSize4,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText:
                      '+ ${l10n.ui('ui_group_add_name', 'Add group name')}',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: scheme.onSurface.withValues(alpha: 0.4),
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
              )
            : Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: SpacingTokens.space8),
            child: _busy
                ? const Padding(
                    padding: EdgeInsets.all(SpacingTokens.space12),
                    child: SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : TextButton(
                    key: const ValueKey('pick-people-done'),
                    onPressed: ready ? _done : null,
                    style: TextButton.styleFrom(
                      foregroundColor: scheme.onSurface,
                      disabledForegroundColor:
                          scheme.onSurface.withValues(alpha: 0.3),
                      textStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: TypographyTokens.fontSize3,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: Text(widget.starting ? l10n.done : widget.action),
                  ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ToLine(
            chosen: _chosen.values.toList(),
            query: _query,
            onRemove: _toggle,
          ),
          Expanded(
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.only(bottom: SpacingTokens.space24),
              children: [
                if (query.length < 2 && offered.isNotEmpty)
                  PeopleHeading(l10n.ui('ui_group_suggested', 'Suggested')),
                for (final person in offered)
                  PersonPickRow(
                    key: ValueKey('pick-${person.id}'),
                    person: person,
                    onTap: () => _toggle(person),
                    trailing: PickMark(chosen: _chosen.containsKey(person.id)),
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

/// "To:", the people chosen so far, and the search, on lines that wrap as
/// they fill -- the way an address line does. Nothing scrolls sideways out
/// of sight.
class _ToLine extends StatelessWidget {
  final List<MessagePerson> chosen;
  final TextEditingController query;
  final ValueChanged<MessagePerson> onRemove;

  const _ToLine({
    required this.chosen,
    required this.query,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space16,
        SpacingTokens.space8,
        SpacingTokens.space16,
        SpacingTokens.space4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The height of a chip, its words centred, so "To:" sits on the
          // line of the first row of chips and the search.
          SizedBox(
            height: 32,
            child: Center(
              child: Text(
                l10n.ui('ui_dm_new_to', 'To:'),
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize3,
                  color: scheme.onSurface.withValues(alpha: 0.45),
                ),
              ),
            ),
          ),
          const SizedBox(width: SpacingTokens.space8),
          Expanded(
            child: Wrap(
              spacing: SpacingTokens.space8,
              runSpacing: SpacingTokens.space8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                for (final person in chosen)
                  PersonChip(
                    key: ValueKey('chosen-${person.id}'),
                    person: person,
                    removeLabel: '${l10n.remove} ${person.displayName}',
                    onRemove: () => onRemove(person),
                  ),
                SizedBox(
                  width: 160,
                  child: TextField(
                    key: const ValueKey('pick-people-search'),
                    controller: query,
                    textAlignVertical: TextAlignVertical.center,
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    style:
                        const TextStyle(fontSize: TypographyTokens.fontSize3),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
