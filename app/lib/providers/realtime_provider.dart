// lib/providers/realtime_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/notification_model.dart';
import '../services/realtime_client.dart';
import 'api_client_provider.dart';
import 'messages_provider.dart';
import 'notifications_provider.dart';

/// The socket, for the life of the app.
final realtimeClientProvider = Provider<RealtimeClient>((ref) {
  final client = RealtimeClient(
    baseUrl: ref.read(apiClientProvider).dio.options.baseUrl,
  );
  ref.onDispose(client.dispose);
  return client;
});

/// What the server has said, as a stream anything can listen to.
final realtimeEventsProvider = StreamProvider<RealtimeEvent>((ref) {
  final client = ref.watch(realtimeClientProvider);
  client.start();
  return client.events;
});

/// Keeps the socket open and applies what arrives.
///
/// A provider rather than a listener on a widget, because applying an event
/// needs a [Ref] -- a widget only has a [WidgetRef], which cannot ask whether
/// a provider is already alive. Watch it once, high in the tree, to start it.
final realtimeBridgeProvider = Provider<void>((ref) {
  ref.listen(realtimeEventsProvider, (previous, next) {
    final event = next.value;
    if (event != null) applyRealtimeEvent(ref, event);
  });
});

/// Folds an event into whatever state it affects.
///
/// One place, rather than a listener per screen: a message arriving has to
/// move the thread, the conversation list and the badge, and only one of the
/// three is ever on screen. Screens that are not built simply have no
/// notifier to hold state, and the provider family answers that cheaply.
void applyRealtimeEvent(Ref ref, RealtimeEvent event) {
  switch (event.type) {
    case 'message.new':
      final conversationId = event.conversationId;
      if (conversationId != null) {
        // Only if that thread is open. Reading the notifier for a closed one
        // would build it, fetch a page nobody is looking at, and leave it
        // alive holding the result.
        if (ref.exists(threadProvider(conversationId))) {
          ref.read(threadProvider(conversationId).notifier).pullNewest();
        }
      }
      _refreshConversationLists(ref);

    case 'message.deleted':
    case 'message.read':
      final conversationId = event.conversationId;
      if (conversationId != null &&
          ref.exists(threadProvider(conversationId))) {
        ref.read(threadProvider(conversationId).notifier).refresh();
      }

    case 'notification.new':
      // The badge always; the list only where a tab is actually built, since
      // invalidating a family key nobody holds would construct it.
      ref.invalidate(unreadNotificationsProvider);
      for (final kind in [null, ...NotificationType.values]) {
        if (ref.exists(notificationListProvider(kind))) {
          ref.read(notificationListProvider(kind).notifier).refresh();
        }
      }
  }
}

void _refreshConversationLists(Ref ref) {
  for (final unreadOnly in [false, true]) {
    if (ref.exists(conversationListProvider(unreadOnly))) {
      ref.read(conversationListProvider(unreadOnly).notifier).refresh();
    }
  }
  ref.invalidate(unreadConversationsProvider);
}
