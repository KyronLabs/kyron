// lib/widgets/person_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/profile_summary.dart';
import '../providers/api_client_provider.dart';
import '../repositories/profile_repository.dart';
import '../utils/api_error_message.dart';
import '../utils/format_count.dart';
import 'action_button.dart';
import 'toast.dart';

/// One person in a list: search results, followers, following.
///
/// One widget for all three, rather than each screen growing its own row --
/// which is how the search results ended up as bare two-line rows while the
/// same person rendered differently elsewhere.
class PersonTile extends ConsumerStatefulWidget {
  final ProfileSummary person;

  /// Called with the updated person after a follow or unfollow, so the list
  /// holding this row can keep its own copy in step.
  final ValueChanged<ProfileSummary>? onChanged;

  final VoidCallback? onOpen;

  const PersonTile({
    super.key,
    required this.person,
    this.onChanged,
    this.onOpen,
  });

  @override
  ConsumerState<PersonTile> createState() => _PersonTileState();
}

class _PersonTileState extends ConsumerState<PersonTile> {
  bool _busy = false;

  ProfileSummary get _person => widget.person;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bio = _person.bio?.trim();
    final handle = _person.handle;

    return InkWell(
      onTap: widget.onOpen,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space16,
          vertical: SpacingTokens.space12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: scheme.primary.withValues(alpha: 0.15),
              foregroundImage: _person.avatarUrl == null
                  ? null
                  : NetworkImage(_person.avatarUrl!),
              child: Icon(Iconsax.user_copy, size: 20, color: scheme.primary),
            ),
            const SizedBox(width: SpacingTokens.space12),
            // Expanded, because a Row gives a non-flex child unbounded width
            // and the ellipsis would never engage on a long name.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _person.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (handle != null)
                    Text(
                      handle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  if (bio != null && bio.isNotEmpty) ...[
                    const SizedBox(height: SpacingTokens.space4),
                    Text(
                      bio,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13, height: 1.3),
                    ),
                  ],
                  const SizedBox(height: SpacingTokens.space4),
                  Wrap(
                    spacing: SpacingTokens.space12,
                    children: [
                      _Stat(
                        icon: Iconsax.profile_2user_copy,
                        text: '${formatCount(_person.followers)} followers',
                      ),
                      if (_person.kyronPoints > 0)
                        _Stat(
                          icon: Iconsax.flash_1_copy,
                          text: '${formatCount(_person.kyronPoints)} KP',
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (!_person.isSelf) ...[
              const SizedBox(width: SpacingTokens.space8),
              ActionButton(
                label: _person.isFollowing ? 'Following' : 'Follow',
                kind: _person.isFollowing
                    ? ActionButtonKind.outlined
                    : ActionButtonKind.primary,
                busy: _busy,
                onPressed: _toggle,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _toggle() async {
    setState(() => _busy = true);
    final repo = ProfileRepository(ref.read(apiClientProvider));
    final wasFollowing = _person.isFollowing;

    try {
      if (wasFollowing) {
        await repo.unfollow(_person.id);
      } else {
        await repo.follow(_person.id);
      }
      // The follower count moves with the button, so the row does not claim a
      // number that contradicts the state right beside it.
      widget.onChanged?.call(
        _person.copyWith(
          isFollowing: !wasFollowing,
          followers:
              (_person.followers + (wasFollowing ? -1 : 1)).clamp(0, 1 << 31),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Stat({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final muted =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.55);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: muted),
        const SizedBox(width: SpacingTokens.space4),
        // Flexible, because the Wrap around this hands it whatever width is
        // left on the line: a six-figure follower count at a large text scale
        // is wider than that, and a stat that cannot shrink overflows.
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: muted),
          ),
        ),
      ],
    );
  }
}
