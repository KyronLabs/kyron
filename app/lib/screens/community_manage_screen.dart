// lib/screens/community_manage_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/community.dart';
import '../providers/communities_provider.dart';
import '../utils/api_error_message.dart';
import '../widgets/empty_state.dart';
import '../widgets/hairline.dart';
import '../widgets/section_tabs.dart';
import '../widgets/toast.dart';

/// Running a community: its details, who is in it, and who is not welcome.
///
/// Reachable from the community's own overflow menu, and only by somebody who
/// may act on it -- a plain member has nothing to do here, and a screen full
/// of buttons that refuse is worse than no screen.
class CommunityManageScreen extends ConsumerStatefulWidget {
  final Community community;

  const CommunityManageScreen({super.key, required this.community});

  @override
  ConsumerState<CommunityManageScreen> createState() =>
      _CommunityManageScreenState();
}

class _CommunityManageScreenState extends ConsumerState<CommunityManageScreen>
    with SingleTickerProviderStateMixin {
  late Community _community = widget.community;
  late final TabController _tabs = TabController(
    length: _community.role?.canModerate ?? false ? 3 : 2,
    vsync: this,
  );

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  bool get _canEdit => _community.role?.canEdit ?? false;
  bool get _canModerate => _community.role?.canModerate ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context, _community),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(_community.name),
      ),
      body: Column(
        children: [
          SectionTabs(
            controller: _tabs,
            labels: [
              'Details',
              'Members',
              if (_canModerate) 'Removed',
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _Details(
                  community: _community,
                  editable: _canEdit,
                  onSaved: (updated) => setState(() => _community = updated),
                ),
                _Members(community: _community),
                if (_canModerate) _Removed(community: _community),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Name, description, pictures, and closing it.
class _Details extends ConsumerStatefulWidget {
  final Community community;
  final bool editable;
  final void Function(Community) onSaved;

  const _Details({
    required this.community,
    required this.editable,
    required this.onSaved,
  });

  @override
  ConsumerState<_Details> createState() => _DetailsState();
}

class _DetailsState extends ConsumerState<_Details> {
  late final _name = TextEditingController(text: widget.community.name);
  late final _description =
      TextEditingController(text: widget.community.description ?? '');
  late final _avatar =
      TextEditingController(text: widget.community.avatarUrl ?? '');
  late final _banner =
      TextEditingController(text: widget.community.bannerUrl ?? '');
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _avatar.dispose();
    _banner.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      final updated = await ref.read(communitiesRepositoryProvider).update(
            widget.community.slug,
            name: _name.text.trim(),
            description: _description.text.trim(),
            avatarUrl: _avatar.text.trim(),
            bannerUrl: _banner.text.trim(),
          );
      widget.onSaved(updated);
      if (mounted) Toast.show(context, 'Saved');
    } catch (error) {
      if (mounted) {
        Toast.show(context, describeApiError(error, sessionIsLive: true));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _close() async {
    final sure = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Close ${widget.community.name}?'),
        content: const Text(
          'Nobody can post in it or join it again. Posts already written into '
          'it keep working, so nothing anybody wrote disappears.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Close it'),
          ),
        ],
      ),
    );
    if (sure != true) return;

    try {
      await ref
          .read(communitiesRepositoryProvider)
          .remove(widget.community.slug);
      if (!mounted) return;
      // Back past this screen and the community itself, both of which are now
      // about something that is gone.
      Navigator.of(context)
        ..pop()
        ..pop();
    } catch (error) {
      if (mounted) {
        Toast.show(context, describeApiError(error, sessionIsLive: true));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    if (!widget.editable) {
      return const EmptyState(
        compact: true,
        art: EmptyArt.communities,
        title: 'Only the owner can change this',
        detail: 'You can still see who is in it and remove people.',
      ).scrollable;
    }

    return ListView(
      padding: const EdgeInsets.all(SpacingTokens.space20),
      children: [
        TextField(
          controller: _name,
          maxLength: 60,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        const SizedBox(height: SpacingTokens.space16),
        TextField(
          controller: _description,
          maxLength: 400,
          maxLines: 4,
          minLines: 2,
          decoration: const InputDecoration(labelText: 'Description'),
        ),
        const SizedBox(height: SpacingTokens.space16),
        TextField(
          controller: _avatar,
          keyboardType: TextInputType.url,
          decoration: const InputDecoration(
            labelText: 'Picture',
            hintText: 'https://…',
          ),
        ),
        const SizedBox(height: SpacingTokens.space16),
        TextField(
          controller: _banner,
          keyboardType: TextInputType.url,
          decoration: const InputDecoration(
            labelText: 'Banner',
            hintText: 'https://…',
          ),
        ),
        const SizedBox(height: SpacingTokens.space24),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: _saving
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
        const SizedBox(height: SpacingTokens.space32),
        const Hairline(),
        const SizedBox(height: SpacingTokens.space16),
        Text(
          'Closing it',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: scheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: SpacingTokens.space8),
        Text(
          'Nobody can post in it or join it again. What was written into it '
          'keeps working.',
          style: TextStyle(
            fontSize: 13,
            color: scheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: SpacingTokens.space12),
        OutlinedButton(
          onPressed: _close,
          style: OutlinedButton.styleFrom(foregroundColor: scheme.error),
          child: const Text('Close this community'),
        ),
      ],
    );
  }
}

/// The roll, with what a moderator may do to each row.
class _Members extends ConsumerStatefulWidget {
  final Community community;

  const _Members({required this.community});

  @override
  ConsumerState<_Members> createState() => _MembersState();
}

class _MembersState extends ConsumerState<_Members> {
  late Future<CommunityMemberPage> _page = _load();

  Future<CommunityMemberPage> _load() =>
      ref.read(communitiesRepositoryProvider).members(widget.community.slug);

  void _reload() => setState(() => _page = _load());

  bool get _canModerate => widget.community.role?.canModerate ?? false;
  bool get _canEdit => widget.community.role?.canEdit ?? false;

  Future<void> _remove(CommunityMember member) async {
    final sure = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove ${member.displayName}?'),
        content: const Text(
          'They leave the community and cannot rejoin until you let them '
          'back in.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (sure != true) return;

    try {
      await ref
          .read(communitiesRepositoryProvider)
          .removeMember(widget.community.slug, member.id);
      _reload();
    } catch (error) {
      if (mounted) {
        Toast.show(context, describeApiError(error, sessionIsLive: true));
      }
    }
  }

  Future<void> _setRole(CommunityMember member, CommunityRole role) async {
    try {
      await ref
          .read(communitiesRepositoryProvider)
          .setRole(widget.community.slug, member.id, role);
      _reload();
    } catch (error) {
      if (mounted) {
        Toast.show(context, describeApiError(error, sessionIsLive: true));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CommunityMemberPage>(
      future: _page,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return EmptyState.failed(
            title: 'Could not load the members',
            detail: describeApiError(snapshot.error!, sessionIsLive: true),
            onAction: _reload,
          ).scrollable;
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final members = snapshot.data!.items;
        if (members.isEmpty) {
          return const EmptyState(
            art: EmptyArt.people,
            title: 'Nobody here yet',
            detail: 'People who join show up on this list.',
          ).scrollable;
        }

        return ListView.separated(
          itemCount: members.length,
          separatorBuilder: (_, __) => const Hairline(),
          itemBuilder: (context, index) => _MemberRow(
            member: members[index],
            canModerate: _canModerate,
            canEdit: _canEdit,
            onRemove: () => _remove(members[index]),
            onRole: (role) => _setRole(members[index], role),
          ),
        );
      },
    );
  }
}

class _MemberRow extends StatelessWidget {
  final CommunityMember member;
  final bool canModerate;
  final bool canEdit;
  final VoidCallback onRemove;
  final void Function(CommunityRole) onRole;

  const _MemberRow({
    required this.member,
    required this.canModerate,
    required this.canEdit,
    required this.onRemove,
    required this.onRole,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final role = member.role;
    // The owner is nobody's to act on, and neither is a moderator unless you
    // are the owner. Showing a menu that only refuses is worse than none.
    final actionable = canModerate &&
        role != CommunityRole.owner &&
        (canEdit || role == CommunityRole.member);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space16,
        vertical: SpacingTokens.space4,
      ),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: scheme.primary.withValues(alpha: 0.15),
        foregroundImage:
            member.avatarUrl == null ? null : NetworkImage(member.avatarUrl!),
        child: Icon(Iconsax.user_copy, size: 18, color: scheme.primary),
      ),
      title: Text(
        member.displayName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      subtitle: Text(
        [
          if (member.handle != null) member.handle!,
          if (role != null && role != CommunityRole.member) role.label,
        ].join(' · '),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 13,
          color: scheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      trailing: !actionable
          ? null
          : PopupMenuButton<String>(
              tooltip: 'Manage',
              icon: Icon(
                Iconsax.more,
                size: 18,
                color: scheme.onSurface.withValues(alpha: 0.5),
              ),
              onSelected: (value) => switch (value) {
                'promote' => onRole(CommunityRole.moderator),
                'demote' => onRole(CommunityRole.member),
                _ => onRemove(),
              },
              itemBuilder: (context) => [
                if (canEdit && role == CommunityRole.member)
                  const PopupMenuItem(
                    value: 'promote',
                    child: Text('Make a moderator'),
                  ),
                if (canEdit && role == CommunityRole.moderator)
                  const PopupMenuItem(
                    value: 'demote',
                    child: Text('Remove as moderator'),
                  ),
                PopupMenuItem(
                  value: 'remove',
                  child: Text(
                    'Remove from community',
                    style: TextStyle(color: scheme.error),
                  ),
                ),
              ],
            ),
    );
  }
}

/// Who is kept out, and letting them back.
class _Removed extends ConsumerStatefulWidget {
  final Community community;

  const _Removed({required this.community});

  @override
  ConsumerState<_Removed> createState() => _RemovedState();
}

class _RemovedState extends ConsumerState<_Removed> {
  late Future<List<CommunityMember>> _page = _load();

  Future<List<CommunityMember>> _load() =>
      ref.read(communitiesRepositoryProvider).bans(widget.community.slug);

  void _reload() => setState(() => _page = _load());

  Future<void> _unban(CommunityMember member) async {
    try {
      await ref
          .read(communitiesRepositoryProvider)
          .unban(widget.community.slug, member.id);
      _reload();
    } catch (error) {
      if (mounted) {
        Toast.show(context, describeApiError(error, sessionIsLive: true));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return FutureBuilder<List<CommunityMember>>(
      future: _page,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return EmptyState.failed(
            title: 'Could not load this list',
            detail: describeApiError(snapshot.error!, sessionIsLive: true),
            onAction: _reload,
          ).scrollable;
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final removed = snapshot.data!;
        if (removed.isEmpty) {
          return const EmptyState(
            art: EmptyArt.muted,
            title: 'Nobody has been removed',
            detail: 'People you remove show up here, and you can let them '
                'back in from this list.',
          ).scrollable;
        }

        return ListView.separated(
          itemCount: removed.length,
          separatorBuilder: (_, __) => const Hairline(),
          itemBuilder: (context, index) {
            final member = removed[index];
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: SpacingTokens.space16,
                vertical: SpacingTokens.space4,
              ),
              leading: CircleAvatar(
                radius: 20,
                backgroundColor: scheme.primary.withValues(alpha: 0.15),
                foregroundImage: member.avatarUrl == null
                    ? null
                    : NetworkImage(member.avatarUrl!),
                child: Icon(Iconsax.user_copy, size: 18, color: scheme.primary),
              ),
              title: Text(member.displayName),
              subtitle: member.handle == null ? null : Text(member.handle!),
              trailing: TextButton(
                onPressed: () => _unban(member),
                child: const Text('Let back in'),
              ),
            );
          },
        );
      },
    );
  }
}
