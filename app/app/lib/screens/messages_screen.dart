// lib/screens/messages_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/app_drawer.dart';

class MessagesScreen extends StatefulWidget {
  final GlobalKey<AppDrawerState> drawerKey;
  final Function(double progress) onScrollProgress;

  const MessagesScreen({
    super.key,
    required this.drawerKey,
    required this.onScrollProgress,
  });

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;

    final currentOffset = _scrollController.offset;
    final direction = _scrollController.position.userScrollDirection;

    if (direction == ScrollDirection.reverse && currentOffset > 0) {
      if (!_isScrollingDown) {
        _isScrollingDown = true;
        widget.onScrollProgress(1.0);
      }
    } else if (direction == ScrollDirection.forward) {
      if (_isScrollingDown) {
        _isScrollingDown = false;
        widget.onScrollProgress(0.0);
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: SimpleAppBar(
            title: 'Messages',
            onAvatarTap: () {
              widget.drawerKey.currentState?.toggleDrawer();
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: scheme.outline.withValues(alpha: 0.15),
                width: 0.5,
              ),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            indicatorColor: scheme.primary,
            labelColor: scheme.primary,
            unselectedLabelColor: scheme.onSurface.withValues(alpha: 0.6),
            labelStyle:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Unread'),
              Tab(text: 'Groups'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildAllTab(),
              _buildUnreadTab(),
              _buildGroupsTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAllTab() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withValues(alpha: 0.3),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.2),
                  child: Icon(Icons.person,
                      color: Theme.of(context).colorScheme.primary, size: 28),
                ),
                if (index < 5)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.surface,
                            width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            title: Text(
              'User ${index + 1}',
              style: TextStyle(
                fontWeight: index < 3 ? FontWeight.w700 : FontWeight.w600,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              index < 3 ? 'Hey! How are you doing?' : 'Last message preview...',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
                fontWeight: index < 3 ? FontWeight.w600 : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${index + 1}m',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.5),
                  ),
                ),
                if (index < 3)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUnreadTab() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color:
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            leading: CircleAvatar(
              radius: 28,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
              child: Icon(Icons.person,
                  color: Theme.of(context).colorScheme.primary, size: 28),
            ),
            title: Text(
              'User ${index + 1}',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            subtitle: Text(
              'Unread message preview...',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGroupsTab() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withValues(alpha: 0.3),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            leading: CircleAvatar(
              radius: 28,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
              child: Icon(Icons.group,
                  color: Theme.of(context).colorScheme.primary, size: 28),
            ),
            title: Text(
              'Group ${index + 1}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            subtitle: Text(
              '${(index + 1) * 3} members',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
              ),
            ),
            trailing: Text(
              '${index + 1}h',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.5),
              ),
            ),
          ),
        );
      },
    );
  }
}
