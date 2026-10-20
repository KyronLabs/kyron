// lib/screens/group_info_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/conversation.dart';
import '../providers/current_user_provider.dart';
import '../providers/messages_provider.dart';
import '../routes.dart';
import '../utils/api_error_message.dart';
import '../utils/conversation_text.dart' show memberRoleLabel;
import '../widgets/action_sheet.dart';
import '../widgets/group_avatar.dart';
import '../widgets/hairline.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/toast.dart';
import '../widgets/verified_badge.dart';
import 'chat_wallpaper_screen.dart';
import 'group_people_screen.dart';

/// A group's page: its name, who is in it and as what, the hands raised to
/// ask to write, and the way out.
///
/// What it offers follows what the reader may do: everybody sees the
/// members and can leave; admins add, remove, rename, and move people
/// between member and spectator; only the owner makes admins or hands the
/// group on. The server holds the same rules -- this only leaves out
/// buttons that would be refused.
class GroupInfoScreen extends ConsumerWidget {
  final String conversationId;

  const GroupInfoScreen({super.key, required this.conversationId});

  /// Opens the page. Answers true when the reader left the group, so the
  /// thread behind it closes too.
  static Future<bool> open(
    BuildContext context, {
    required String conversationId,
  }) async =>
      await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (_) => GroupInfoScreen(conversationId: conversationId),
        ),
      ) ??
      false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final thread = ref.watch(threadProvider(conversationId));
    final group = thread.group;
    final members = ref.watch(groupMembersProvider(conversationId));
    final me = ref.watch(currentUserProvider).asData?.value.id;

    if (group == null) {
      return Scaffold(
        appBar:
            KyronAppBar(title: Text(l10n.ui('ui_status_details', 'Details'))),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final admin = group.role.isAdmin;
    final list = members.asData?.value ?? const <GroupMember>[];
    final hands = [
      for (final m in list)
        if (m.handRaised && m.role == MemberRole.spectator) m,
    ];

    return Scaffold(
      appBar: KyronAppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text(l10n.ui('ui_status_details', 'Details')),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(groupMembersProvider(conversationId));
          await ref.read(threadProvider(conversationId).notifier).pullNewest();
        },
        child: ListView(
          padding: const EdgeInsets.only(bottom: SpacingTokens.space40),
          children: [
            const SizedBox(height: SpacingTokens.space16),
            Center(child: GroupAvatar(people: thread.people, radius: 40)),
            const SizedBox(height: SpacingTokens.space12),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SpacingTokens.space24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      group.title,
                      key: const ValueKey('group-title'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: TypographyTokens.fontSize5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (admin)
                    IconButton(
                      key: const ValueKey('group-rename'),
                      tooltip: l10n.ui('ui_group_rename', 'Rename'),
                      icon: const Icon(Iconsax.edit_2_copy, size: 18),
                      onPressed: () => _rename(context, ref, group.title),
                    ),
                ],
              ),
            ),
            Text(
              l10n
                  .ui('ui_group_member_count', r'$count members')
                  .replaceAll(r'$count', '${group.memberCount}'),
              textAlign: TextAlign.center,
              style: TextStyle(color: scheme.onSurface.withValues(alpha: .6)),
            ),
            const SizedBox(height: SpacingTokens.space16),

            // Hands, first: somebody is waiting on an answer.
            if (admin && hands.isNotEmpty) ...[
              _Heading(l10n.ui('ui_group_hands_heading', 'Asking to write')),
              for (final member in hands)
                ListTile(
                  key: ValueKey('hand-${member.id}'),
                  leading: _Face(person: member.person),
                  title: Text(member.person.displayName),
                  // Two marks rather than two worded buttons: worded, they do
                  // not fit beside a name on a narrow phone.
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: l10n.ui('ui_group_dismiss', 'Dismiss'),
                        icon: const Icon(Iconsax.close_circle_copy),
                        onPressed: () => _act(
                          context,
                          ref,
                          () => ref
                              .read(messagesRepositoryProvider)
                              .dismissHand(conversationId, member.id),
                        ),
                      ),
                      IconButton.filledTonal(
                        tooltip:
                            l10n.ui('ui_group_let_write', 'Let them write'),
                        icon: const Icon(Iconsax.tick_circle_copy),
                        onPressed: () => _act(
                          context,
                          ref,
                          () => ref.read(messagesRepositoryProvider).setRole(
                                conversationId,
                                member.id,
                                MemberRole.member,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],

            _Heading(l10n.ui('ui_group_members', 'Members')),
            if (admin && group.memberCount < maxGroupSize)
              ListTile(
                key: const ValueKey('group-add'),
                leading: CircleAvatar(
                  backgroundColor: scheme.primary.withValues(alpha: .12),
                  child: Icon(Iconsax.user_add_copy, color: scheme.primary),
                ),
                title: Text(l10n.ui('ui_group_add', 'Add people')),
                onTap: () => _add(context, ref, list, group),
              ),
            if (members.isLoading && list.isEmpty)
              const Padding(
                padding: EdgeInsets.all(SpacingTokens.space24),
                child: Center(child: CircularProgressIndicator()),
              ),
            if (members.hasError && list.isEmpty)
              Padding(
                padding: const EdgeInsets.all(SpacingTokens.space16),
                child: Text(
                  describeApiError(members.error!, sessionIsLive: true),
                  textAlign: TextAlign.center,
                ),
              ),
            for (final member in list)
              ListTile(
                key: ValueKey('member-${member.id}'),
                leading: _Face(person: member.person),
                title: NameWithBadge(
                  name: member.id == me
                      ? '${member.person.displayName} (${l10n.ui('ui_group_you', 'you')})'
                      : member.person.displayName,
                  verified: member.person.verified,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: member.person.handle == null
                    ? null
                    : Text(member.person.handle!, maxLines: 1),
                trailing: member.role == MemberRole.member
                    ? null
                    : _RoleTag(role: member.role),
                onTap: () => _memberOptions(context, ref, group, member, me),
              ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: SpacingTokens.space8),
              child: Hairline(),
            ),
            if (admin)
              SwitchListTile.adaptive(
                key: const ValueKey('group-join-spectators'),
                secondary: const Icon(Iconsax.eye_copy),
                value: group.joinRole == MemberRole.spectator,
                title: Text(
                  l10n.ui(
                    'ui_group_join_spectators',
                    'People added later join as spectators',
                  ),
                ),
                subtitle: Text(
                  l10n.ui(
                    'ui_group_spectators_detail',
                    'Spectators can read, react and raise a hand to ask to '
                        'write.',
                  ),
                ),
                onChanged: (on) => _act(
                  context,
                  ref,
                  () => ref.read(messagesRepositoryProvider).updateGroup(
                        conversationId,
                        joinRole: on ? MemberRole.spectator : MemberRole.member,
                      ),
                ),
              ),
            SwitchListTile.adaptive(
              secondary: Icon(
                thread.muted
                    ? Iconsax.volume_slash_copy
                    : Iconsax.notification_copy,
              ),
              value: thread.muted,
              title: Text(l10n.ui('ui_dm_info_mute_row', 'Mute notifications')),
              onChanged: (muted) async {
                final error = await ref
                    .read(threadProvider(conversationId).notifier)
                    .setMuted(muted);
                if (error != null && context.mounted) {
                  Toast.show(context, error);
                }
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.brush_2_copy),
              title: Text(l10n.ui('ui_dm_info_wallpaper', 'Wallpaper')),
              onTap: () => ChatWallpaperScreen.open(
                context,
                conversationId: conversationId,
              ),
            ),
            ListTile(
              key: const ValueKey('group-leave'),
              leading: Icon(Iconsax.logout_copy, color: scheme.error),
              title: Text(
                l10n.ui('ui_group_leave', 'Leave group'),
                style: TextStyle(color: scheme.error),
              ),
              onTap: me == null ? null : () => _leave(context, ref, me),
            ),
          ],
        ),
      ),
    );
  }

  /// Runs one change, then reads the group again. The server tells every
  /// member's app too, over the socket; this is the reader's own.
  Future<void> _act(
    BuildContext context,
    WidgetRef ref,
    Future<void> Function() change,
  ) async {
    try {
      await change();
    } catch (error) {
      if (context.mounted) {
        Toast.show(context, describeApiError(error, sessionIsLive: true));
      }
      return;
    }
    ref.invalidate(groupMembersProvider(conversationId));
    await ref.read(threadProvider(conversationId).notifier).pullNewest();
  }

  Future<void> _rename(BuildContext context, WidgetRef ref, String now) async {
    final l10n = AppLocalizations.of(context);
    final box = TextEditingController(text: now);
    final title = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.ui('ui_group_rename', 'Rename')),
        content: TextField(
          key: const ValueKey('group-rename-field'),
          controller: box,
          autofocus: true,
          maxLength: 80,
          decoration: InputDecoration(
            labelText: l10n.ui('ui_group_name', 'Group name'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, box.text.trim()),
            child: Text(l10n.save),
          ),
        ],
      ),
    );
    box.dispose();
    if (title == null || title.isEmpty || title == now || !context.mounted) {
      return;
    }
    await _act(
      context,
      ref,
      () => ref
          .read(messagesRepositoryProvider)
          .updateGroup(conversationId, title: title),
    );
  }

  Future<void> _add(
    BuildContext context,
    WidgetRef ref,
    List<GroupMember> members,
    GroupSummary group,
  ) async {
    final l10n = AppLocalizations.of(context);
    final chosen = await pickPeople(
      context,
      title: l10n.ui('ui_group_add', 'Add people'),
      action: l10n.ui('ui_group_add_action', 'Add'),
      exclude: {for (final m in members) m.id},
      room: maxGroupSize - group.memberCount,
    );
    if (chosen == null || chosen.isEmpty || !context.mounted) return;
    await _act(
      context,
      ref,
      () => ref
          .read(messagesRepositoryProvider)
          .addMembers(conversationId, [for (final p in chosen) p.id]),
    );
  }

  Future<void> _leave(BuildContext context, WidgetRef ref, String me) async {
    final l10n = AppLocalizations.of(context);
    final sure = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.ui('ui_group_leave_title', 'Leave this group?')),
            content: Text(
              l10n.ui(
                'ui_group_leave_detail',
                'It leaves your list, and you will not see what is said '
                    'after. Somebody would have to add you again.',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(l10n.cancel),
              ),
              TextButton(
                key: const ValueKey('group-leave-confirm'),
                onPressed: () => Navigator.pop(context, true),
                child: Text(l10n.ui('ui_group_leave', 'Leave group')),
              ),
            ],
          ),
        ) ??
        false;
    if (!sure || !context.mounted) return;
    try {
      await ref
          .read(messagesRepositoryProvider)
          .removeMember(conversationId, me);
    } catch (error) {
      if (context.mounted) {
        Toast.show(context, describeApiError(error, sessionIsLive: true));
      }
      return;
    }
    await refreshConversations(ref);
    if (context.mounted) Navigator.pop(context, true);
  }

  /// What the reader may do to [member], as a sheet. Only what the server
  /// would allow is offered.
  Future<void> _memberOptions(
    BuildContext context,
    WidgetRef ref,
    GroupSummary group,
    GroupMember member,
    String? me,
  ) async {
    final l10n = AppLocalizations.of(context);
    final owner = group.role == MemberRole.owner;
    final admin = group.role.isAdmin;
    final self = member.id == me;
    final ordinary =
        member.role == MemberRole.member || member.role == MemberRole.spectator;
    final canTouch = !self && (owner || (admin && ordinary));

    final choice = await ActionSheet.show<String>(
      context,
      title: member.person.displayName,
      actions: [
        SheetAction(
          value: 'profile',
          label: l10n.ui('ui_group_view_profile', 'View profile'),
          icon: Iconsax.user_copy,
        ),
        if (canTouch && member.role == MemberRole.spectator)
          SheetAction(
            value: 'member',
            label: l10n.ui('ui_group_let_write', 'Let them write'),
            icon: Iconsax.edit_copy,
          ),
        if (canTouch && member.role == MemberRole.member)
          SheetAction(
            value: 'spectator',
            label: l10n.ui('ui_group_make_spectator', 'Make spectator'),
            icon: Iconsax.eye_copy,
          ),
        if (owner && !self && member.role != MemberRole.admin)
          SheetAction(
            value: 'admin',
            label: l10n.ui('ui_group_make_admin', 'Make admin'),
            icon: Iconsax.security_user_copy,
          ),
        if (owner && !self && member.role == MemberRole.admin)
          SheetAction(
            value: 'member',
            label: l10n.ui('ui_group_remove_admin', 'Remove as admin'),
            icon: Iconsax.user_minus_copy,
          ),
        if (owner && !self)
          SheetAction(
            value: 'owner',
            label: l10n.ui('ui_group_make_owner', 'Make owner'),
            icon: Iconsax.crown_copy,
          ),
        if (canTouch)
          SheetAction(
            value: 'remove',
            label: l10n.ui('ui_group_remove', 'Remove from group'),
            icon: Iconsax.user_remove_copy,
            destructive: true,
          ),
      ],
    );
    if (choice == null || !context.mounted) return;
    final repo = ref.read(messagesRepositoryProvider);
    switch (choice) {
      case 'profile':
        openProfile(
          context,
          username: member.person.username,
          userId: member.id,
        );
      case 'member':
        await _act(
          context,
          ref,
          () => repo.setRole(conversationId, member.id, MemberRole.member),
        );
      case 'spectator':
        await _act(
          context,
          ref,
          () => repo.setRole(conversationId, member.id, MemberRole.spectator),
        );
      case 'admin':
        await _act(
          context,
          ref,
          () => repo.setRole(conversationId, member.id, MemberRole.admin),
        );
      case 'owner':
        final sure = await _confirm(
          context,
          title: l10n
              .ui('ui_group_owner_title', r'Make $name the owner?')
              .replaceAll(r'$name', member.person.displayName),
          detail: l10n.ui(
            'ui_group_owner_detail',
            'There is one owner. You will stay on as an admin.',
          ),
        );
        if (!sure || !context.mounted) return;
        await _act(
          context,
          ref,
          () => repo.setRole(conversationId, member.id, MemberRole.owner),
        );
      case 'remove':
        await _act(
          context,
          ref,
          () => repo.removeMember(conversationId, member.id),
        );
    }
  }

  static Future<bool> _confirm(
    BuildContext context, {
    required String title,
    required String detail,
  }) async =>
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(detail),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(AppLocalizations.of(context).cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(MaterialLocalizations.of(context).okButtonLabel),
            ),
          ],
        ),
      ) ??
      false;
}

class _Heading extends StatelessWidget {
  final String text;

  const _Heading(this.text);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space16,
          SpacingTokens.space16,
          SpacingTokens.space16,
          SpacingTokens.space4,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: TypographyTokens.fontSize1,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: .55),
          ),
        ),
      );
}

class _Face extends StatelessWidget {
  final MessagePerson person;

  const _Face({required this.person});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return CircleAvatar(
      backgroundColor: scheme.primary.withValues(alpha: .15),
      foregroundImage:
          person.avatarUrl == null ? null : NetworkImage(person.avatarUrl!),
      child: Icon(Iconsax.user_copy, size: 18, color: scheme.primary),
    );
  }
}

/// Owner, Admin or Spectator, beside the name. Members carry no tag: it is
/// what most people are.
class _RoleTag extends StatelessWidget {
  final MemberRole role;

  const _RoleTag({required this.role});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: role.isAdmin
            ? scheme.primary.withValues(alpha: .12)
            : scheme.onSurface.withValues(alpha: .06),
        borderRadius: BorderRadius.circular(RadiusTokens.radius20),
      ),
      child: Text(
        memberRoleLabel(AppLocalizations.of(context), role),
        style: TextStyle(
          fontSize: TypographyTokens.fontSize1,
          fontWeight: FontWeight.w600,
          color: role.isAdmin
              ? scheme.primary
              : scheme.onSurface.withValues(alpha: .65),
        ),
      ),
    );
  }
}
