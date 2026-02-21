import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../models/notification_model.dart';
import '../widgets/notification_item.dart';
import '../widgets/notification_skeleton.dart';
import '../widgets/empty_notifications.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _activeFilter = 'All';
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();
  
  // Filter tabs
  final List<Map<String, dynamic>> _filters = [
    {'label': 'All', 'icon': Iconsax.notification, 'type': null},
    {'label': 'Likes', 'icon': Iconsax.heart, 'type': NotificationType.like},
    {'label': 'Comments', 'icon': Iconsax.message, 'type': NotificationType.comment},
    {'label': 'Follows', 'icon': Iconsax.user_add, 'type': NotificationType.follow},
  ];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadNotifications({bool loadMore = false}) {
    if (loadMore) {
      setState(() => _isLoadingMore = true);
    } else {
      setState(() => _isLoading = true);
    }

    // Simulate API call (Doherty: first frame ≤ 400ms)
    Future.delayed(const Duration(milliseconds: 300), () {
      final newNotifications = _generateMockNotifications();
      
      setState(() {
        if (loadMore) {
          _notifications.addAll(newNotifications);
          _isLoadingMore = false;
        } else {
          _notifications = newNotifications;
          _isLoading = false;
        }
      });
    });
  }

  List<NotificationModel> _generateMockNotifications() {
    return List.generate(20, (index) {
      final types = NotificationType.values;
      return NotificationModel(
        id: 'notif_$index',
        actorDid: 'did:plc:user$index',
        actorHandle: '@user$index',
        actorAvatarUrl: 'https://avatar.placeholder.png',
        type: types[index % types.length],
        content: index % 3 == 0 ? 'Great post!' : '',
        postSnippet: index % 2 == 0 ? 'Snow leopard populations...' : null,
        timestamp: DateTime.now().subtract(Duration(minutes: index * 30)),
        isRead: index > 5,
      );
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent * 0.7) {
      _loadNotifications(loadMore: true);
    }
  }

  void _markAllAsRead() {
    setState(() {
      _notifications = _notifications.map((n) => 
        NotificationModel(
          id: n.id,
          actorDid: n.actorDid,
          actorHandle: n.actorHandle,
          actorAvatarUrl: n.actorAvatarUrl,
          type: n.type,
          content: n.content,
          postSnippet: n.postSnippet,
          timestamp: n.timestamp,
          isRead: true,
        )
      ).toList();
    });
    
    // Batch API call (Peak-End: action > friction)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All notifications marked as read')),
    );
  }

  void _markAsRead(String id) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        _notifications[index] = NotificationModel(
          id: _notifications[index].id,
          actorDid: _notifications[index].actorDid,
          actorHandle: _notifications[index].actorHandle,
          actorAvatarUrl: _notifications[index].actorAvatarUrl,
          type: _notifications[index].type,
          content: _notifications[index].content,
          postSnippet: _notifications[index].postSnippet,
          timestamp: _notifications[index].timestamp,
          isRead: true,
        );
      }
    });
  }

  List<NotificationModel> _getFilteredNotifications() {
    if (_activeFilter == 'All') return _notifications;
    
    final filterType = _filters.firstWhere(
      (f) => f['label'] == _activeFilter,
    )['type'];
    
    if (filterType == null) return _notifications;
    
    return _notifications.where((n) => n.type == filterType).toList();
  }

  Map<String, List<NotificationModel>> _getGroupedNotifications() {
    final filtered = _getFilteredNotifications();
    final groups = <String, List<NotificationModel>>{};
    
    for (var notif in filtered) {
      groups.putIfAbsent(notif.groupKey, () => []);
      groups[notif.groupKey]!.add(notif);
    }
    
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: scheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: const Text('Mark All Read'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs (48px)
          Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: scheme.onSurface.withOpacity(0.1), width: 0.33),
              ),
            ),
            child: Row(
              children: _filters.map((filter) {
                final isActive = _activeFilter == filter['label'];
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _activeFilter = filter['label']),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isActive ? scheme.primary : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: AnimatedScale(
                        scale: isActive ? 1.04 : 1.0,
                        duration: const Duration(milliseconds: 120),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              filter['icon'],
                              size: 20,
                              color: isActive ? scheme.primary : scheme.onSurface.withOpacity(0.6),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              filter['label'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                                color: isActive ? scheme.primary : scheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // List
          Expanded(
            child: _isLoading 
                ? const NotificationSkeleton()
                : _notifications.isEmpty
                    ? const EmptyNotifications()
                    : _buildGroupedList(),
          ),
          
          // Load more indicator
          if (_isLoadingMore)
            Container(
              height: 60,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildGroupedList() {
    final grouped = _getGroupedNotifications();
    
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      itemCount: grouped.length,
      itemBuilder: (context, groupIndex) {
        final groupKey = grouped.keys.elementAt(groupIndex);
        final groupNotifications = grouped[groupKey]!;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Group header
            if (groupIndex > 0)
              Divider(height: 1, thickness: 0.33, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text(
                groupKey.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  letterSpacing: 0.5,
                ),
              ),
            ),
            
            // Group items
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: groupNotifications.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                thickness: 0.33,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              ),
              itemBuilder: (context, index) {
                final notif = groupNotifications[index];
                return NotificationItem(
                  notification: notif,
                  onTap: () {
                    _markAsRead(notif.id);
                    // TODO: Navigate to post/profile
                  },
                  onMarkAsRead: () => _markAsRead(notif.id),
                  onMute: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Muted ${notif.actorHandle}')),
                    );
                  },
                  onDelete: () {
                    setState(() => _notifications.remove(notif));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Notification deleted')),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}