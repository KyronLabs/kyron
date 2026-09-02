// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:share_plus/share_plus.dart';

import '../models/post_media.dart';
import '../models/profile_model.dart';
import '../providers/feed_provider.dart';
import '../providers/profile_provider.dart';
import '../routes.dart';
import '../services/app_log.dart';
import '../utils/api_error_message.dart';
import '../utils/format_count.dart';
import '../widgets/action_button.dart';
import '../widgets/post_card.dart';
import '../widgets/media_tile_grid.dart';
import '../widgets/media_viewer.dart';

/// Which of the profile's tabs is showing.
enum ProfileTab { posts, media, likes }

extension on ProfileTab {
  String get label => switch (this) {
        ProfileTab.posts => 'Posts',
        ProfileTab.media => 'Media',
        ProfileTab.likes => 'Likes',
      };
}

/// One account: yours, or somebody else's.
///
/// Built as a single [CustomScrollView] with the tab strip as a pinned sliver,
/// rather than a NestedScrollView over a TabBarView. One scroll controller,
/// one scrollable, and no coordination between an outer and inner position --
/// which is what the previous version got wrong badly enough to render blank
/// on a handset while passing every widget test.
class ProfileScreen extends ConsumerWidget {
  /// The handle to show, without its leading @. Null means the signed-in
  /// account.
  final String? username;

  const ProfileScreen({super.key, this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider(username));

    return Scaffold(
      // The cover runs to the very top of the screen, under the status bar,
      // so the bar and its back button float over the image rather than
      // sitting on a white strip above it.
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: const _GlassBack(),
        actions: [
          if (state.hasValue)
            Padding(
              padding: const EdgeInsets.only(right: SpacingTokens.space8),
              child: _GlassAction(
                icon: Iconsax.export_1_copy,
                tooltip: 'Share this profile',
                onPressed: () => shareProfile(state.value!),
              ),
            ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _Failed(username: username, error: error),
        data: (profile) => _Loaded(profile: profile, username: username),
      ),
    );
  }
}

/// Hands the profile's public address to the system share sheet.
Future<void> shareProfile(ProfileModel profile) async {
  final handle = profile.username?.trim();
  final url = handle == null || handle.isEmpty
      ? 'https://kyron.so/u/${profile.id}'
      : 'https://kyron.so/@$handle';
  await Share.share(url, subject: '${profile.displayName} on Kyron');
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
  ProfileTab _tab = ProfileTab.posts;

  PostListSource get _source => switch (_tab) {
        ProfileTab.posts => PostListSource.author(widget.profile.id),
        ProfileTab.media => PostListSource.authorMedia(widget.profile.id),
        ProfileTab.likes => PostListSource.liked,
      };

  @override
  void initState() {
    super.initState();
    _controller.addListener(_maybeLoadMore);
    // Logged so a screen that comes up empty on a handset says how far it got.
    AppLog.instance.info(
      'profile',
      'Rendering ${widget.profile.handle ?? widget.profile.id} '
          '(${widget.profile.followers} followers, '
          '${widget.profile.following} following)',
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

  /// Pulls the view back inside the content when the content gets shorter.
  ///
  /// Switching from a long tab to a short one -- Posts to Likes, say -- leaves
  /// the position where it was while everything under it shrinks, so the
  /// reader is left staring at a screen of blank below the end of a list they
  /// have not scrolled. Same for a post being deleted from under them. Run on
  /// every frame that changes the body, because a tab's posts arrive from the
  /// network some frames after the tab is chosen.
  void _clampScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_controller.hasClients) return;
      final position = _controller.position;
      // Only while nothing is moving. Being past the end is the normal state
      // during an overscroll and for every frame of a fling that runs off it,
      // and jumping the position there stops the gesture dead -- which is what
      // turned a flick into something that had to be shoved.
      if (position.isScrollingNotifier.value) return;
      if (position.pixels > position.maxScrollExtent) {
        _controller.jumpTo(position.maxScrollExtent);
      }
    });
  }

  /// The tabs on offer. Likes are private, so only your own profile has one.
  List<ProfileTab> get _tabs => [
        ProfileTab.posts,
        ProfileTab.media,
        if (widget.profile.isOwnProfile) ProfileTab.likes,
      ];

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;
    final posts = ref.watch(postListProvider(_source));
    _clampScroll();

    return RefreshIndicator(
      onRefresh: () async {
        await ref
            .read(profileProvider(widget.username).notifier)
            .load(force: true);
        await ref.read(postListProvider(_source).notifier).refresh();
      },
      child: CustomScrollView(
        controller: _controller,
        // Clamping, not bouncing. With bouncing physics a pull-to-refresh
        // drags the whole list -- cover and all -- away from the top of the
        // screen and leaves a band of blank behind it. Clamping holds the
        // content still and lets the spinner come down over it.
        physics: const AlwaysScrollableScrollPhysics(
          parent: ClampingScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: _CoverAndHeader(
              profile: profile,
              username: widget.username,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabStrip(
              tabs: _tabs,
              selected: _tab,
              onSelect: (tab) {
                if (tab == _tab) return;
                setState(() => _tab = tab);
              },
              background: Theme.of(context).colorScheme.surface,
            ),
          ),
          ..._body(profile, posts),
          const SliverToBoxAdapter(
            child: SizedBox(height: SpacingTokens.space40),
          ),
        ],
      ),
    );
  }

  List<Widget> _body(ProfileModel profile, FeedState state) {
    if (state.isLoadingFirstPage && state.posts.isEmpty) {
      return const [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(SpacingTokens.space32),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      ];
    }

    if (state.posts.isEmpty) {
      return [SliverToBoxAdapter(child: _empty(profile, state.error))];
    }

    // Media is a wall, not a column of cards: the point of the tab is seeing
    // everything at a glance, and a caption above each attachment defeats it.
    if (_tab == ProfileTab.media) {
      return [
        MediaTileGrid(posts: state.posts),
        if (state.isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(SpacingTokens.space16),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ];
    }

    return [
      SliverList.builder(
        itemCount: state.posts.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= state.posts.length) {
            return const Padding(
              padding: EdgeInsets.all(SpacingTokens.space16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final post = state.posts[index];
          // Keyed, so recycling a card's element keeps it on the same post.
          return PostCard(key: ValueKey(post.id), post: post, source: _source);
        },
      ),
    ];
  }

  Widget _empty(ProfileModel profile, String? failed) {
    final scheme = Theme.of(context).colorScheme;
    final who =
        profile.isOwnProfile ? 'You have' : '${profile.displayName} has';

    final message = failed ??
        switch (_tab) {
          ProfileTab.posts => profile.isOwnProfile
              ? 'Anything you post shows up here.'
              : '$who not posted anything yet.',
          ProfileTab.media => '$who not posted any photos or clips.',
          ProfileTab.likes => 'Posts you like are kept here, just for you.',
        };

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space32,
        vertical: SpacingTokens.space32,
      ),
      child: Column(
        children: [
          Icon(
            failed == null ? Iconsax.document_copy : Iconsax.cloud_cross_copy,
            size: 40,
            color: scheme.onSurface.withValues(alpha: .35),
          ),
          const SizedBox(height: SpacingTokens.space12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: scheme.onSurface.withValues(alpha: .7)),
          ),
          if (failed != null) ...[
            const SizedBox(height: SpacingTokens.space12),
            ActionButton(
              label: 'Try again',
              icon: Iconsax.refresh_copy,
              kind: ActionButtonKind.tonal,
              onPressed: ref.read(postListProvider(_source).notifier).refresh,
            ),
          ],
        ],
      ),
    );
  }
}

/// The tab strip, pinned under the header once it reaches the top.
class _TabStrip extends SliverPersistentHeaderDelegate {
  final List<ProfileTab> tabs;
  final ProfileTab selected;
  final ValueChanged<ProfileTab> onSelect;
  final Color background;

  const _TabStrip({
    required this.tabs,
    required this.selected,
    required this.onSelect,
    required this.background,
  });

  static const double _height = 46;

  @override
  double get minExtent => _height;

  @override
  double get maxExtent => _height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlaps) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: background,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                for (final tab in tabs)
                  Expanded(
                    child: InkWell(
                      onTap: () => onSelect(tab),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Center(
                            child: Text(
                              tab.label,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: tab == selected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: tab == selected
                                    ? scheme.onSurface
                                    : scheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          ),
                          if (tab == selected)
                            Container(
                              height: 3,
                              width: 32,
                              decoration: BoxDecoration(
                                color: scheme.primary,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(3),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
            color: scheme.outline.withValues(alpha: 0.2),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_TabStrip old) =>
      old.selected != selected ||
      old.background != background ||
      old.tabs.length != tabs.length;
}

/// The cover, the avatar straddling its lower edge, and everything under it.
///
/// One widget, because the avatar has to be drawn *outside* the cover's box --
/// half of it hangs below the photograph. Two stacked children in a Column
/// cannot do that; a Stack with `clipBehavior: Clip.none` can.
class _CoverAndHeader extends StatelessWidget {
  final ProfileModel profile;
  final String? username;

  const _CoverAndHeader({required this.profile, required this.username});

  /// The avatar's radius, and the white ring around it.
  static const double avatarRadius = 42;
  static const double avatarRing = 3.5;

  static double get _avatarSize => (avatarRadius + avatarRing) * 2;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final coverHeight = _Cover.heightIn(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Cover(profile: profile),
            // The band the avatar's lower half occupies. The action buttons
            // sit in it, to the right of the avatar, which is where they line
            // up with it rather than floating above the name.
            SizedBox(
              height: _avatarSize / 2 + SpacingTokens.space8,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: SpacingTokens.space20,
                  right: SpacingTokens.space20,
                  top: SpacingTokens.space8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: _Actions(profile: profile, username: username),
                    ),
                  ],
                ),
              ),
            ),
            _Header(profile: profile, username: username),
          ],
        ),
        Positioned(
          left: SpacingTokens.space20,
          // Half above the cover's lower edge, half below it.
          top: coverHeight - _avatarSize / 2,
          child: GestureDetector(
            // A picture of someone at 84 pixels across is a thumbnail of a
            // picture. Tapping it opens the picture.
            onTap: profile.avatarUrl == null
                ? null
                : () => MediaViewer.open(context, [
                      PostMedia(
                        id: 'avatar-${profile.id}',
                        kind: MediaKind.image,
                        url: profile.avatarUrl!,
                        alt: '${profile.displayName}\u2019s profile picture',
                      ),
                    ]),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: scheme.surface, width: avatarRing),
              ),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: scheme.primary.withValues(alpha: 0.2),
                foregroundImage: profile.avatarUrl == null
                    ? null
                    : NetworkImage(profile.avatarUrl!),
                child: Icon(Iconsax.user_copy, size: 32, color: scheme.primary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// The cover photo, running the full width and up under the status bar.
class _Cover extends StatelessWidget {
  final ProfileModel profile;

  const _Cover({required this.profile});

  /// Plus the status bar, because the body starts behind it.
  ///
  /// A third shorter than it was. At 160 the cover pushed the name, the counts
  /// and the tabs so far down that a phone opened on the picture and almost
  /// nothing else.
  static const double bannerHeight = 107;

  static double heightIn(BuildContext context) =>
      bannerHeight + MediaQuery.paddingOf(context).top;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: heightIn(context),
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (profile.coverUrl == null)
            _DefaultCover(scheme: scheme)
          else
            Image.network(
              profile.coverUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _DefaultCover(scheme: scheme),
              loadingBuilder: (context, child, progress) =>
                  progress == null ? child : _DefaultCover(scheme: scheme),
            ),
          // Keeps the white back and share buttons legible over a pale cover.
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x66000000), Color(0x00000000)],
                stops: [0, 0.45],
              ),
            ),
          ),
        ],
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

/// A back button that stays visible over a photograph.
class _GlassBack extends StatelessWidget {
  const _GlassBack();

  @override
  Widget build(BuildContext context) {
    return _GlassAction(
      icon: Iconsax.arrow_left_copy,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () => Navigator.pop(context),
    );
  }
}

class _GlassAction extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _GlassAction({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Tooltip(
        message: tooltip,
        child: Semantics(
          button: true,
          label: tooltip,
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x59000000),
              ),
              child: Icon(icon, size: 19, color: Colors.white),
            ),
          ),
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

    // The avatar and the action buttons live in _CoverAndHeader, which draws
    // them across the cover's lower edge. What is left here starts at the name.
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space20,
        0,
        SpacingTokens.space20,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profile.displayName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          if (handle != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                handle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  color: scheme.onSurface.withValues(alpha: 0.6),
                ),
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
          const SizedBox(height: SpacingTokens.space12),
        ],
      ),
    );
  }
}

/// Followers, following and points.
///
/// The post count is gone: it sits directly above a tab called Posts, which
/// then shows them. Followers and following open the list they name.
class _Counts extends StatelessWidget {
  final ProfileModel profile;

  const _Counts({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: SpacingTokens.space20,
      runSpacing: SpacingTokens.space8,
      children: [
        _Count(
          value: profile.followers,
          label: 'Followers',
          onTap: () => Navigator.pushNamed(
            context,
            Routes.followers,
            arguments: FollowListArgs(
              userId: profile.id,
              title: profile.displayName,
              followers: true,
            ),
          ),
        ),
        _Count(
          value: profile.following,
          label: 'Following',
          onTap: () => Navigator.pushNamed(
            context,
            Routes.following,
            arguments: FollowListArgs(
              userId: profile.id,
              title: profile.displayName,
              followers: false,
            ),
          ),
        ),
        _Count(value: profile.kyronPoints, label: 'KP'),
      ],
    );
  }
}

/// What a followers-or-following screen needs to open.
class FollowListArgs {
  final String userId;
  final String title;

  /// True for the people following this account, false for those it follows.
  final bool followers;

  const FollowListArgs({
    required this.userId,
    required this.title,
    required this.followers,
  });
}

class _Count extends StatelessWidget {
  final int value;
  final String label;
  final VoidCallback? onTap;

  const _Count({required this.value, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          formatCount(value),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
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

    if (onTap == null) return content;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: content,
      ),
    );
  }
}

/// Follow or unfollow, or edit and share your own.
class _Actions extends ConsumerStatefulWidget {
  final ProfileModel profile;
  final String? username;

  const _Actions({required this.profile, required this.username});

  @override
  ConsumerState<_Actions> createState() => _ActionsState();
}

class _ActionsState extends ConsumerState<_Actions> {
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ActionIconButton(
          icon: Iconsax.export_1_copy,
          tooltip: 'Share this profile',
          onPressed: () => shareProfile(profile),
        ),
        const SizedBox(width: SpacingTokens.space8),
        Flexible(
          child: profile.isOwnProfile
              ? ActionButton(
                  label: 'Edit profile',
                  icon: Iconsax.edit_2_copy,
                  kind: ActionButtonKind.outlined,
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.editProfile),
                )
              : ActionButton(
                  label: profile.isFollowing ? 'Following' : 'Follow',
                  icon: profile.isFollowing
                      ? Iconsax.tick_circle_copy
                      : Iconsax.add,
                  kind: profile.isFollowing
                      ? ActionButtonKind.outlined
                      : ActionButtonKind.primary,
                  busy: _busy,
                  onPressed: _toggle,
                ),
        ),
      ],
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
            Icon(Iconsax.profile_delete_copy,
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
            ActionButton(
              label: 'Try again',
              icon: Iconsax.refresh_copy,
              kind: ActionButtonKind.tonal,
              onPressed: () => ref
                  .read(profileProvider(username).notifier)
                  .load(force: true),
            ),
          ],
        ),
      ),
    );
  }
}
