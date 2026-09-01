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
import '../services/app_log.dart';
import '../utils/api_error_message.dart';
import '../utils/format_count.dart';
import '../widgets/post_card.dart';

/// One account: yours, or somebody else's.
///
/// Deliberately plain in its construction. What stood here used a
/// SliverAppBar with a FlexibleSpaceBar and Spacers inside rows, and rendered
/// blank on a real handset while passing every widget test -- so the exotic
/// parts are gone. A normal AppBar, a cover in a box, and rows that cannot
/// overflow.
class ProfileScreen extends ConsumerWidget {
  /// The handle to show, without its leading @. Null means the signed-in
  /// account.
  final String? username;

  const ProfileScreen({super.key, this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider(username));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(
          state.asData?.value.displayName ??
              (username == null ? 'Your profile' : '@$username'),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        top: false,
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => _Failed(username: username, error: error),
          data: (profile) => _Loaded(profile: profile, username: username),
        ),
      ),
    );
  }
}

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
    // Logged so a screen that comes up empty on a handset says how far it got.
    AppLog.instance.info(
      'profile',
      'Rendering ${widget.profile.handle ?? widget.profile.id} '
          '(${widget.profile.posts} posts, ${widget.profile.followers} '
          'followers, ${widget.profile.following} following)',
    );
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
        await ref
            .read(profileProvider(widget.username).notifier)
            .load(force: true);
        await ref.read(postListProvider(_source).notifier).refresh();
      },
      child: CustomScrollView(
        controller: _controller,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(child: _Cover(profile: profile)),
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
                style: TextStyle(color: scheme.onSurface.withValues(alpha: .7)),
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

/// The cover photo, as a plain box.
class _Cover extends StatelessWidget {
  final ProfileModel profile;

  const _Cover({required this.profile});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 130,
      width: double.infinity,
      child: profile.coverUrl == null
          ? _DefaultCover(scheme: scheme)
          : Image.network(
              profile.coverUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _DefaultCover(scheme: scheme),
              loadingBuilder: (context, child, progress) =>
                  progress == null ? child : _DefaultCover(scheme: scheme),
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
    final location = profile.location?.trim();
    final website = profile.website?.trim();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space20,
        SpacingTokens.space12,
        SpacingTokens.space20,
        SpacingTokens.space8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // spaceBetween rather than a Spacer. A flexible child in a row that
          // overflows is allocated negative space, which debug clamps and
          // reports and release does not -- and this row carries a button
          // whose width depends on its label.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
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
                  radius: 36,
                  backgroundColor: scheme.primary.withValues(alpha: 0.2),
                  foregroundImage: profile.avatarUrl == null
                      ? null
                      : NetworkImage(profile.avatarUrl!),
                  child:
                      Icon(Iconsax.user_copy, size: 30, color: scheme.primary),
                ),
              ),
              Flexible(
                child: _PrimaryAction(profile: profile, username: username),
              ),
            ],
          ),
          const SizedBox(height: SpacingTokens.space12),
          Text(
            profile.displayName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          if (handle != null)
            Text(
              handle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          if (bio != null && bio.isNotEmpty) ...[
            const SizedBox(height: SpacingTokens.space12),
            Text(bio, style: const TextStyle(fontSize: 15, height: 1.4)),
          ],
          if ((location != null && location.isNotEmpty) ||
              (website != null && website.isNotEmpty)) ...[
            const SizedBox(height: SpacingTokens.space8),
            Wrap(
              spacing: SpacingTokens.space16,
              runSpacing: SpacingTokens.space4,
              children: [
                if (location != null && location.isNotEmpty)
                  _Meta(icon: Iconsax.location_copy, text: location),
                if (website != null && website.isNotEmpty)
                  _Meta(icon: Iconsax.link_copy, text: website),
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
/// A Wrap, not a Row. Four figures beside four labels is the widest thing on
/// the screen, and at a large text size or on a narrow handset it is the row
/// most likely to run out of space -- so it takes a second line rather than
/// overflowing.
class _Counts extends StatelessWidget {
  final ProfileModel profile;

  const _Counts({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: SpacingTokens.space20,
      runSpacing: SpacingTokens.space8,
      children: [
        _Count(value: profile.posts, label: 'Posts'),
        _Count(value: profile.followers, label: 'Followers'),
        _Count(value: profile.following, label: 'Following'),
        _Count(value: profile.kyronPoints, label: 'KP'),
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

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          formatCount(value),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: SpacingTokens.space4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: scheme.onSurface.withValues(alpha: 0.65),
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
      return OutlinedButton(
        onPressed: () => Navigator.pushNamed(context, Routes.editProfile),
        child: const Text('Edit profile', maxLines: 1),
      );
    }

    final following = widget.profile.isFollowing;

    return FilledButton.tonal(
      onPressed: _busy ? null : _toggle,
      child: _busy
          ? const SizedBox.square(
              dimension: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(following ? 'Following' : 'Follow', maxLines: 1),
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

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person_off_outlined,
                size: 48, color: scheme.onSurface.withValues(alpha: .35)),
            const SizedBox(height: SpacingTokens.space16),
            Text(
              username == null
                  ? 'Could not load your profile'
                  : 'Could not load @$username',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: SpacingTokens.space8),
            Text(
              describeApiError(error, sessionIsLive: true),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurface.withValues(alpha: .7),
                  ),
            ),
            const SizedBox(height: SpacingTokens.space20),
            TextButton(
              onPressed: () => ref
                  .read(profileProvider(username).notifier)
                  .load(force: true),
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
