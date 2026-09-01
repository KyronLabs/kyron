// lib/screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/profile_summary.dart';
import '../providers/current_user_provider.dart';
import '../providers/profile_provider.dart';
import '../providers/search_provider.dart';
import '../utils/api_error_message.dart';
import '../routes.dart';
import '../utils/format_count.dart';

/// Finding people. The search icon in the top bar used to print "Search" to
/// the debug console and nothing else.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    // The screen exists to be typed into, so it opens with the keyboard up.
    WidgetsBinding.instance.addPostFrameCallback((_) => _focus.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        titleSpacing: 0,
        title: TextField(
          controller: _controller,
          focusNode: _focus,
          textInputAction: TextInputAction.search,
          onChanged: ref.read(searchProvider.notifier).query,
          decoration: InputDecoration(
            hintText: 'Search people',
            border: InputBorder.none,
            suffixIcon: state.isIdle
                ? null
                : IconButton(
                    icon: const Icon(Iconsax.close_circle_copy, size: 18),
                    tooltip: 'Clear',
                    onPressed: () {
                      _controller.clear();
                      ref.read(searchProvider.notifier).clear();
                    },
                  ),
          ),
        ),
      ),
      body: SafeArea(child: _body(state)),
    );
  }

  Widget _body(SearchState state) {
    if (state.isIdle) {
      return const _Hint(
        icon: Iconsax.search_normal_1_copy,
        title: 'Find people on Kyron',
        detail: 'Search by handle or display name.',
      );
    }
    if (state.isTooShort) {
      return const _Hint(
        icon: Iconsax.keyboard_copy,
        title: 'Keep typing',
        detail: 'Two characters or more.',
      );
    }
    if (state.error != null) {
      return _Hint(
        icon: Icons.cloud_off_outlined,
        title: 'Search failed',
        detail: state.error!,
        action: 'Try again',
        onAction: ref.read(searchProvider.notifier).retry,
      );
    }
    if (state.isSearching && state.results.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.foundNothing) {
      return _Hint(
        icon: Iconsax.user_search_copy,
        title: 'No one matched',
        detail: 'Nobody on Kyron matches "${state.query.trim()}".',
      );
    }

    return ListView.separated(
      itemCount: state.results.length,
      separatorBuilder: (context, _) => Divider(
        height: 1,
        indent: SpacingTokens.space16 + 48 + SpacingTokens.space12,
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12),
      ),
      itemBuilder: (context, index) => _Result(person: state.results[index]),
    );
  }
}

/// One person in the results.
///
/// A ListTile with a follower count crammed into its subtitle read as a
/// settings row rather than a person: the avatar was the same size as a
/// leading icon, the bio was truncated to one line beside the handle, and
/// there was nothing to do from the row itself.
class _Result extends ConsumerStatefulWidget {
  final ProfileSummary person;

  const _Result({required this.person});

  @override
  ConsumerState<_Result> createState() => _ResultState();
}

class _ResultState extends ConsumerState<_Result> {
  bool _busy = false;
  bool _following = false;

  ProfileSummary get person => widget.person;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final handle = person.handle;
    final bio = person.bio?.trim();

    return InkWell(
      onTap: person.username == null
          ? null
          : () => Navigator.pushNamed(
                context,
                Routes.profile,
                arguments: person.username,
              ),
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
              foregroundImage: person.avatarUrl == null
                  ? null
                  : NetworkImage(person.avatarUrl!),
              child: Icon(Iconsax.user_copy, size: 22, color: scheme.primary),
            ),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  if (handle != null)
                    Text(
                      handle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                  if (bio != null && bio.isNotEmpty) ...[
                    const SizedBox(height: SpacingTokens.space4),
                    Text(
                      bio,
                      // Two lines, not one. A bio cut at a single line is
                      // usually cut mid-word and tells you nothing.
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13, height: 1.3),
                    ),
                  ],
                  const SizedBox(height: SpacingTokens.space4),
                  Row(
                    children: [
                      _Stat(
                        icon: Iconsax.profile_2user_copy,
                        text: '${formatCount(person.followers)} followers',
                      ),
                      if (person.kyronPoints > 0) ...[
                        const SizedBox(width: SpacingTokens.space12),
                        _Stat(
                          icon: Iconsax.flash_1_copy,
                          text: '${formatCount(person.kyronPoints)} KP',
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: SpacingTokens.space8),
            // Following from the results, rather than opening the profile and
            // coming back for it.
            _FollowButton(
              following: _following,
              busy: _busy,
              onPressed: _toggle,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggle() async {
    final wasFollowing = _following;
    setState(() {
      _busy = true;
      _following = !wasFollowing;
    });

    try {
      final repo = ref.read(profileRepositoryProvider);
      if (wasFollowing) {
        await repo.unfollow(person.id);
      } else {
        await repo.follow(person.id);
      }
      // Your own following count moved.
      ref.read(currentUserProvider.notifier).refresh();
    } catch (e) {
      if (!mounted) return;
      setState(() => _following = wasFollowing);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(describeApiError(e, sessionIsLive: true))),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}

class _FollowButton extends StatelessWidget {
  final bool following;
  final bool busy;
  final VoidCallback onPressed;

  const _FollowButton({
    required this.following,
    required this.busy,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final child = busy
        ? const SizedBox.square(
            dimension: 14,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(following ? 'Following' : 'Follow', maxLines: 1);

    final style = ButtonStyle(
      visualDensity: VisualDensity.compact,
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: SpacingTokens.space16),
      ),
    );

    return following
        ? OutlinedButton(
            onPressed: busy ? null : onPressed,
            style: style,
            child: child,
          )
        : FilledButton.tonal(
            onPressed: busy ? null : onPressed,
            style: style,
            child: child,
          );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Stat({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurface.withValues(alpha: .5);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: muted),
        const SizedBox(width: SpacingTokens.space4),
        Text(text, style: TextStyle(fontSize: 12, color: muted)),
      ],
    );
  }
}

class _Hint extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;
  final String? action;
  final VoidCallback? onAction;

  const _Hint({
    required this.icon,
    required this.title,
    required this.detail,
    this.action,
    this.onAction,
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
                size: 44, color: scheme.onSurface.withValues(alpha: .35)),
            const SizedBox(height: SpacingTokens.space16),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: SpacingTokens.space8),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurface.withValues(alpha: .7),
                  ),
            ),
            if (action != null) ...[
              const SizedBox(height: SpacingTokens.space16),
              TextButton(onPressed: onAction, child: Text(action!)),
            ],
          ],
        ),
      ),
    );
  }
}
