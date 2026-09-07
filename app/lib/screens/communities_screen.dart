// lib/screens/communities_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/community.dart';
import '../providers/communities_provider.dart';
import '../routes.dart';
import '../utils/api_error_message.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_nav_v4.dart';
import '../widgets/community_tile.dart';
import '../widgets/empty_state.dart';
import '../widgets/section_tabs.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/toast.dart';
import '../widgets/skeleton.dart';

/// Communities the reader is in, and communities to join.
///
/// What this replaces was ten rows of "My Community 1 - 234 members", twenty
/// of "Community 1 - 1234 members" with a Join button that did nothing, and an
/// Invites tab with no invites behind it in any sense.
class CommunitiesScreen extends ConsumerStatefulWidget {
  final GlobalKey<AppDrawerState> drawerKey;
  final Function(double progress) onScrollProgress;

  const CommunitiesScreen({
    super.key,
    required this.drawerKey,
    required this.onScrollProgress,
  });

  @override
  ConsumerState<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends ConsumerState<CommunitiesScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 2, vsync: this);
  bool _hidden = false;

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  bool _onScroll(UserScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) return false;
    if (notification.direction == ScrollDirection.reverse && !_hidden) {
      _hidden = true;
      widget.onScrollProgress(1);
    } else if (notification.direction == ScrollDirection.forward && _hidden) {
      _hidden = false;
      widget.onScrollProgress(0);
    }
    return false;
  }

  Future<void> _create() async {
    final created = await showModalBottomSheet<Community>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const _NewCommunitySheet(),
    );
    if (created == null || !mounted) return;
    ref.read(myCommunitiesProvider.notifier).add(created);
    _tabs.animateTo(0);
    await Navigator.pushNamed(
      context,
      Routes.community,
      arguments: created.slug,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SafeArea(
              bottom: false,
              child: SimpleAppBar(
                title: 'Communities',
                onAvatarTap: () =>
                    widget.drawerKey.currentState?.toggleDrawer(),
              ),
            ),
            SectionTabs(
              controller: _tabs,
              // No Invites tab. There is no invite in the model, so it was a
              // tab nothing could ever have put anything in.
              labels: const ['My communities', 'Discover'],
            ),
            Expanded(
              child: NotificationListener<UserScrollNotification>(
                onNotification: _onScroll,
                // The chrome above sits inside a SafeArea, and it is a
                // sibling of this body rather than its parent -- so the
                // status bar inset is still on the MediaQuery down here. A
                // scroll view built without an explicit padding quietly
                // adopts it, which is what put a band of empty screen
                // between the tab strip and the first row.
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: TabBarView(
                    controller: _tabs,
                    children: [
                      _MineTab(onCreate: _create),
                      const _DiscoverTab(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        // Clear of the bottom bar. The container extends the body behind it,
        // so a button at the bottom of the screen is a button behind the nav.
        Positioned(
          right: SpacingTokens.space16,
          bottom: BottomNavV4.height +
              MediaQuery.paddingOf(context).bottom +
              SpacingTokens.space16,
          child: FloatingActionButton(
            onPressed: _create,
            tooltip: 'Start a community',
            child: const Icon(Iconsax.add),
          ),
        ),
      ],
    );
  }
}

/// How much room a list leaves under itself: the bottom bar, its safe area,
/// and the floating button that sits above both.
double _listFootroom(BuildContext context) =>
    BottomNavV4.height +
    MediaQuery.paddingOf(context).bottom +
    SpacingTokens.space40 +
    SpacingTokens.space16;

class _MineTab extends ConsumerStatefulWidget {
  final VoidCallback onCreate;

  const _MineTab({required this.onCreate});

  @override
  ConsumerState<_MineTab> createState() => _MineTabState();
}

class _MineTabState extends ConsumerState<_MineTab> {
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 400) {
      ref.read(myCommunitiesProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myCommunitiesProvider);
    final notifier = ref.read(myCommunitiesProvider.notifier);

    if (state.loadingFirstPage) {
      return SkeletonList.communities();
    }

    return RefreshIndicator(
      onRefresh: notifier.refresh,
      child: state.items.isEmpty
          ? (state.error != null
                  ? EmptyState.failed(
                      title: 'Could not load your communities',
                      detail: state.error,
                      onAction: notifier.refresh,
                    )
                  : EmptyState(
                      art: EmptyArt.communities,
                      title: 'You are not in any communities',
                      detail: 'Find one on Discover, or start your own.',
                      action: 'Start a community',
                      onAction: widget.onCreate,
                    ))
              .scrollable
          : ListView.separated(
              controller: _scroll,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: _listFootroom(context)),
              itemCount: state.items.length + (state.loadingMore ? 1 : 0),
              separatorBuilder: (context, index) => Divider(
                height: 1,
                thickness: 0.5,
                indent: 76,
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.15),
              ),
              itemBuilder: (context, index) {
                if (index >= state.items.length) {
                  return const Padding(
                    padding: EdgeInsets.all(SpacingTokens.space16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final community = state.items[index];
                return CommunityTile(
                  community: community,
                  onOpen: () => Navigator.pushNamed(
                    context,
                    Routes.community,
                    arguments: community.slug,
                  ),
                  // Left, so it belongs on Discover rather than here.
                  onChanged: (next) {
                    if (!next.joined) notifier.remove(next.id);
                    ref.invalidate(discoverCommunitiesProvider);
                  },
                );
              },
            ),
    );
  }
}

class _DiscoverTab extends ConsumerStatefulWidget {
  const _DiscoverTab();

  @override
  ConsumerState<_DiscoverTab> createState() => _DiscoverTabState();
}

class _DiscoverTabState extends ConsumerState<_DiscoverTab> {
  final TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(discoverCommunitiesProvider);
    final notifier = ref.read(discoverCommunitiesProvider.notifier);
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            SpacingTokens.space16,
            SpacingTokens.space12,
            SpacingTokens.space16,
            SpacingTokens.space8,
          ),
          child: TextField(
            controller: _search,
            textInputAction: TextInputAction.search,
            onSubmitted: notifier.search,
            decoration: InputDecoration(
              hintText: 'Search communities',
              isDense: true,
              filled: true,
              fillColor: scheme.surfaceContainerHighest.withValues(alpha: .45),
              prefixIcon: const Icon(Iconsax.search_normal_1_copy, size: 18),
              suffixIcon: _search.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      tooltip: 'Clear',
                      onPressed: () {
                        _search.clear();
                        notifier.search('');
                      },
                    ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: SpacingTokens.space16,
                vertical: SpacingTokens.space12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: state.loadingFirstPage
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: notifier.refresh,
                  child: state.items.isEmpty
                      ? (state.error != null
                              ? EmptyState.failed(
                                  title: 'Could not load communities',
                                  detail: state.error,
                                  onAction: notifier.refresh,
                                )
                              : EmptyState(
                                  art: notifier.query.isEmpty
                                      ? EmptyArt.communities
                                      : EmptyArt.noMatch,
                                  title: notifier.query.isEmpty
                                      ? 'Nothing left to join'
                                      : 'No communities match that',
                                  detail: notifier.query.isEmpty
                                      ? 'You are already in every community '
                                          'on Kyron. Start another one.'
                                      : 'Try a different word, or start a '
                                          'community by that name.',
                                ))
                          .scrollable
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                            bottom: _listFootroom(context),
                          ),
                          itemCount: state.items.length,
                          separatorBuilder: (context, index) => Divider(
                            height: 1,
                            thickness: 0.5,
                            indent: 76,
                            color: scheme.outline.withValues(alpha: 0.15),
                          ),
                          itemBuilder: (context, index) {
                            final community = state.items[index];
                            return CommunityTile(
                              community: community,
                              onOpen: () => Navigator.pushNamed(
                                context,
                                Routes.community,
                                arguments: community.slug,
                              ),
                              onChanged: (next) {
                                if (next.joined) {
                                  notifier.joined(next.id);
                                  ref
                                      .read(myCommunitiesProvider.notifier)
                                      .add(next);
                                }
                              },
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }
}

/// Starts a community. Name, an optional description, and the address it will
/// have -- shown while the name is typed rather than after the fact.
class _NewCommunitySheet extends ConsumerStatefulWidget {
  const _NewCommunitySheet();

  @override
  ConsumerState<_NewCommunitySheet> createState() => _NewCommunitySheetState();
}

class _NewCommunitySheetState extends ConsumerState<_NewCommunitySheet> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _name.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  /// The same rule the server applies, so what is shown is what will happen.
  String get _slug => _name.text
      .toLowerCase()
      .trim()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');

  bool get _canCreate => _slug.isNotEmpty && !_busy;

  Future<void> _create() async {
    if (!_canCreate) return;
    setState(() => _busy = true);
    try {
      final created = await ref
          .read(communitiesRepositoryProvider)
          .create(_name.text, description: _description.text);
      if (!mounted) return;
      Navigator.pop(context, created);
    } catch (error) {
      if (!mounted) return;
      setState(() => _busy = false);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        left: SpacingTokens.space16,
        right: SpacingTokens.space16,
        top: SpacingTokens.space20,
        bottom: MediaQuery.viewInsetsOf(context).bottom + SpacingTokens.space20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Start a community',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: SpacingTokens.space16),
          TextField(
            controller: _name,
            autofocus: true,
            maxLength: 60,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Lagos Design',
              counterText: '',
            ),
          ),
          const SizedBox(height: SpacingTokens.space4),
          Text(
            _slug.isEmpty
                ? 'Its address is made from the name.'
                : 'People will find it at c/$_slug',
            style: TextStyle(
              fontSize: 12,
              color: scheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: SpacingTokens.space16),
          TextField(
            controller: _description,
            maxLength: 400,
            maxLines: 3,
            minLines: 2,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'What is it for? (optional)',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: SpacingTokens.space8),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _canCreate ? _create : null,
              child: _busy
                  ? const SizedBox.square(
                      dimension: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Create'),
            ),
          ),
        ],
      ),
    );
  }
}
