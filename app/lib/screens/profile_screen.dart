// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/profile_model.dart';
import '../providers/feed_provider.dart';
import '../providers/profile_provider.dart';
import '../routes.dart';
import '../utils/api_error_message.dart';
import '../utils/format_count.dart';
import '../widgets/post_card.dart';

/// One account: yours, or somebody else's.
///
/// What stood here rendered a profile out of `did.hashCode` -- follower counts,
/// badges, a bio reading "User with DID: ..." and a grid of numbered
/// placeholder tiles, all derived from the identifier in the route. It looked
/// like a working profile for an account that did not exist.
class ProfileScreen extends ConsumerWidget {
  /// The handle to show, without its leading @. Null means the signed-in
  /// account.
  final String? username;

  const ProfileScreen({super.key, this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider(username));

    return Scaffold(
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _Failed(username: username, error: error),
        data: (profile) => _Loaded(profile: profile, username: username),
      ),
    );
  }
}

/// The profile, once it has loaded.
///
/// This screen owns its scroll view rather than handing header slivers to the
/// shared list widget. The indirection bought nothing -- no other caller passes
/// a header -- and it put the one screen that renders a `SliverAppBar` through
/// a widget written for three that do not.
class _Loaded extends ConsumerStatefulWidget {
  final ProfileModel profile;
  final String? username;

  const _Loaded({required this.profile, required this.username});

  @override
  ConsumerState<_Loaded> createState() => _LoadedState();
}

class _LoadedState extends ConsumerState<_Loaded> {
  /// How close to the end before the next page is requested.
  static const double _loadMoreThreshold = 600;

  final ScrollController _controller = ScrollController();

  PostListSource get _source => PostListSource.author(widget.profile.id);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_maybeLoadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_maybeLoadMore);
    _controller.dispose();
    super.dispose();
  }

  void _maybeLoadMore() {
    if (!_controller.hasClients) return;
    final position = _controller.position;
    if (position.maxScrollExtent - position.pixels > _loadMoreThreshold) return;
    ref.read(postListProvider(_source).notifier).loadMore();
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;
    final posts = ref.watch(postListProvider(_source));

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(profileProvider(widget.username).notifier).load(
              force: true,
            );
        await ref.read(postListProvider(_source).notifier).refresh();
      },
      child: CustomScrollView(
        controller: _controller,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          _CoverBar(profile: profile),
          SliverToBoxAdapter(
            child: _Header(profile: profile, username: widget.username),
          ),
          _posts(profile, posts),
          const SliverToBoxAdapter(
            child: SizedBox(height: SpacingTokens.space40),
          ),
        ],
      ),
    );
  }

  Widget _posts(ProfileModel profile, FeedState state) {
    if (state.isLoadingFirstPage && state.posts.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(SpacingTokens.space32),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (state.posts.isEmpty) {
      final scheme = Theme.of(context).colorScheme;
      final failed = state.error;
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingTokens.space32,
            vertical: SpacingTokens.space32,
          ),
          child: Column(
            children: [
              Icon(
                failed == null
                    ? Icons.forum_outlined
                    : Icons.cloud_off_outlined,
                size: 40,
                color: scheme.onSurface.withValues(alpha: .35),
              ),
              const SizedBox(height: SpacingTokens.space12),
              Text(
                failed ??
                    (profile.isOwnProfile
                        ? 'Anything you post shows up here.'
                        : '${profile.displayName} has not posted anything yet.'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: scheme.onSurface.withValues(alpha: .7),
                ),
              ),
              if (failed != null)
                TextButton(
                  onPressed:
                      ref.read(postListProvider(_source).notifier).refresh,
                  child: const Text('Try again'),
                ),
            ],
          ),
        ),
      );
    }

    return SliverList.builder(
      itemCount: state.posts.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= state.posts.length) {
          return const Padding(
            padding: EdgeInsets.all(SpacingTokens.space16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return PostCard(post: state.posts[index], source: _source);
      },
    );
  }
}

/// The cover photo, collapsing into a plain bar with the name in it.
class _CoverBar extends StatelessWidget {
  final ProfileModel profile;

  const _CoverBar({required this.profile});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      expandedHeight: 170,
      pinned: true,
      backgroundColor: scheme.surface,
      // The title only appears once the cover has scrolled away, so it does
      // not sit on top of the photo.
      title: Text(profile.displayName),
      leading: const BackButton(),
      flexibleSpace: FlexibleSpaceBar(
        background: profile.coverUrl == null
            ? _DefaultCover(scheme: scheme)
            : Image.network(
                profile.coverUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _DefaultCover(scheme: scheme),
              ),
      ),
    );
  }
}

class _DefaultCover extends StatelessWidget {
  final ColorScheme scheme;

  const _DefaultCover({required this.scheme});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primary.withValues(alpha: 0.35),
            scheme.tertiary.withValues(alpha: 0.35),
          ],
        ),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  final ProfileModel profile;
  final String? username;

  const _Header({required this.profile, required this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final handle = profile.handle;
    final bio = profile.bio?.trim();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space20,
        SpacingTokens.space16,
        SpacingTokens.space20,
        SpacingTokens.space8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Flat: a ring, no drop shadow. The avatar used to float above
              // the cover on a blurred black shadow, which read as a bug
              // against a light cover.
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: scheme.surface, width: 3),
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: scheme.primary.withValues(alpha: 0.2),
                  foregroundImage: profile.avatarUrl == null
                      ? null
                      : NetworkImage(profile.avatarUrl!),
                  child:
                      Icon(Iconsax.user_copy, size: 32, color: scheme.primary),
                ),
              ),
              const Spacer(),
              _PrimaryAction(profile: profile, username: username),
            ],
          ),
          const SizedBox(height: SpacingTokens.space12),
          Text(
            profile.displayName,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          if (handle != null)
            Text(
              handle,
              style: TextStyle(
                fontSize: 14,
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          if (bio != null && bio.isNotEmpty) ...[
            const SizedBox(height: SpacingTokens.space12),
            Text(bio, style: const TextStyle(fontSize: 15, height: 1.4)),
          ],
          if (profile.location != null || profile.website != null) ...[
            const SizedBox(height: SpacingTokens.space8),
            Wrap(
              spacing: SpacingTokens.space16,
              runSpacing: SpacingTokens.space4,
              children: [
                if (profile.location != null)
                  _Meta(icon: Iconsax.location_copy, text: profile.location!),
                if (profile.website != null)
                  _Meta(icon: Iconsax.link_copy, text: profile.website!),
              ],
            ),
          ],
          const SizedBox(height: SpacingTokens.space16),
          _Counts(profile: profile),
          if (profile.did != null) ...[
            const SizedBox(height: SpacingTokens.space12),
            _DidChip(did: profile.did!),
          ],
          const SizedBox(height: SpacingTokens.space8),
          Divider(color: scheme.outline.withValues(alpha: 0.15)),
        ],
      ),
    );
  }
}

/// Posts, followers, following and points.
///
/// The follower count was the only stat the client kept, even though the same
/// response carried the others. Laid out as four equal columns rather than a
/// row of pairs: side by side with a Spacer they needed 477 logical pixels and
/// overflowed a 360-wide phone by 157, which pushed the points off the edge.
class _Counts extends StatelessWidget {
  final ProfileModel profile;

  const _Counts({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _Count(value: profile.posts, label: 'Posts')),
        Expanded(child: _Count(value: profile.followers, label: 'Followers')),
        Expanded(child: _Count(value: profile.following, label: 'Following')),
        Expanded(child: _Count(value: profile.kyronPoints, label: 'KP')),
      ],
    );
  }
}

class _Count extends StatelessWidget {
  final int value;
  final String label;

  const _Count({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formatCount(value),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
        ),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13,
            color: scheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}

/// Follow, unfollow, or edit your own profile.
class _PrimaryAction extends ConsumerStatefulWidget {
  final ProfileModel profile;
  final String? username;

  const _PrimaryAction({required this.profile, required this.username});

  @override
  ConsumerState<_PrimaryAction> createState() => _PrimaryActionState();
}

class _PrimaryActionState extends ConsumerState<_PrimaryAction> {
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    if (widget.profile.isOwnProfile) {
      return OutlinedButton.icon(
        onPressed: () => Navigator.pushNamed(context, Routes.editProfile),
        icon: const Icon(Iconsax.edit_copy, size: 16),
        label: const Text('Edit profile'),
      );
    }

    final following = widget.profile.isFollowing;

    return FilledButton.tonalIcon(
      onPressed: _busy ? null : _toggle,
      icon: _busy
          ? const SizedBox.square(
              dimension: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(following ? Iconsax.user_tick_copy : Iconsax.user_add_copy,
              size: 16),
      label: Text(following ? 'Following' : 'Follow'),
    );
  }

  Future<void> _toggle() async {
    setState(() => _busy = true);
    final message = await ref
        .read(profileProvider(widget.username).notifier)
        .toggleFollow();
    if (!mounted) return;
    setState(() => _busy = false);
    if (message != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Meta({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final muted = scheme.onSurface.withValues(alpha: 0.6);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: muted),
        const SizedBox(width: SpacingTokens.space4),
        Text(text, style: TextStyle(fontSize: 13, color: muted)),
      ],
    );
  }
}

class _DidChip extends StatelessWidget {
  final String did;

  const _DidChip({required this.did});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: did));
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('DID copied to clipboard')),
        );
      },
      borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space8,
          vertical: SpacingTokens.space4,
        ),
        decoration: BoxDecoration(
          color: scheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Iconsax.document_copy, size: 12, color: scheme.primary),
            const SizedBox(width: SpacingTokens.space4),
            // Flexible, because a Row hands a non-flex child an unbounded
            // width -- so the ellipsis never engaged and a long DID ran off
            // the edge of the chip instead.
            Flexible(
              child: Text(
                did,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11, color: scheme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Failed extends ConsumerWidget {
  final String? username;
  final Object error;

  const _Failed({required this.username, required this.error});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Column(
        children: [
          const Align(alignment: Alignment.centerLeft, child: BackButton()),
          const Spacer(),
          Icon(Icons.person_off_outlined,
              size: 48, color: scheme.onSurface.withValues(alpha: .35)),
          const SizedBox(height: SpacingTokens.space16),
          Text(
            username == null
                ? 'Could not load your profile'
                : 'Could not load @$username',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: SpacingTokens.space8),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: SpacingTokens.space32),
            child: Text(
              describeApiError(error, sessionIsLive: true),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurface.withValues(alpha: .7),
                  ),
            ),
          ),
          const SizedBox(height: SpacingTokens.space20),
          TextButton(
            onPressed: () =>
                ref.read(profileProvider(username).notifier).load(force: true),
            child: const Text('Try again'),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
