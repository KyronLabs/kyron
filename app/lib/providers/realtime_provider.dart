// lib/providers/realtime_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/notification_model.dart';
import '../services/realtime_client.dart';
import 'api_client_provider.dart';
import 'enforcement_provider.dart';
import 'verification_provider.dart';
import 'messages_provider.dart';
import 'notifications_provider.dart';
import 'presence_provider.dart';
import 'current_user_provider.dart';
import 'keys_provider.dart';

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

    case 'message.read':
      // Applied to what is already held rather than refetched. Refreshing
      // empties the list and shows a spinner, so a thread somebody is reading
      // would blink every time the other person opened it.
      final readIn = event.conversationId;
      final me = ref.read(currentUserProvider).asData?.value.id;
      if (readIn != null && me != null && ref.exists(threadProvider(readIn))) {
        ref.read(threadProvider(readIn).notifier).markSeenByOther(me);
      }

    case 'message.deleted':
      final deletedIn = event.conversationId;
      final messageId = event.messageId;
      if (deletedIn != null &&
          messageId != null &&
          ref.exists(threadProvider(deletedIn))) {
        ref.read(threadProvider(deletedIn).notifier).withdrawn(messageId);
      }
      // The list shows the last message, which may have been that one.
      _refreshConversationLists(ref);

    case 'message.reaction':
      final reactedIn = event.conversationId;
      final reactedTo = event.messageId;
      if (reactedIn != null &&
          reactedTo != null &&
          ref.exists(threadProvider(reactedIn))) {
        ref
            .read(threadProvider(reactedIn).notifier)
            .reactionsChanged(reactedTo);
      }

    case 'message.typing':
      // Only for a thread that is open: "is typing" about a conversation
      // nobody is looking at is nothing, and is gone in seconds anyway.
      final typingIn = event.conversationId;
      final who = event.data['userId'] as String?;
      if (typingIn != null &&
          who != null &&
          ref.exists(threadProvider(typingIn))) {
        ref.read(threadProvider(typingIn).notifier).otherTyping(who);
      }

    case 'message.opened':
      // Somebody opened one of the reader's view-once messages.
      final openedIn = event.conversationId;
      final opened = event.messageId;
      if (openedIn != null &&
          opened != null &&
          ref.exists(threadProvider(openedIn))) {
        ref.read(threadProvider(openedIn).notifier).onceOpened(opened);
      }

    case 'conversation.updated':
      // A group changed: its name, who is in it, or somebody's place in it.
      // The event says which group, and the rest is read behind the same
      // membership check as the thread -- which is also how somebody taken
      // out of it finds out.
      final changed = event.conversationId;
      if (changed != null) {
        if (ref.exists(threadProvider(changed))) {
          ref.read(threadProvider(changed).notifier).pullNewest();
        }
        ref.invalidate(groupMembersProvider(changed));
      }
      _refreshConversationLists(ref);

    case 'message.keys.requested':
      // A device in one of this reader's conversations is waiting on a
      // message it was not sealed for. This one may be able to open it.
      ref.read(messageVaultProvider).answerPending();

    case 'message.keys.shared':
      // Somebody answered: the waiting messages in that thread can open.
      final sharedIn = event.conversationId;
      if (sharedIn != null && ref.exists(threadProvider(sharedIn))) {
        ref.read(threadProvider(sharedIn).notifier).keysArrived();
      }
      // The list's preview may be one of them.
      _refreshConversationLists(ref);

    case 'notification.new':
      // The badge always; the list only where a tab is actually built, since
      // invalidating a family key nobody holds would construct it.
      ref.invalidate(unreadNotificationsProvider);
      for (final kind in [null, ...NotificationType.values]) {
        if (ref.exists(notificationListProvider(kind))) {
          ref.read(notificationListProvider(kind).notifier).refresh();
        }
      }

    case 'moderation.updated':
      // A decision about this account, an answer to its appeal, an outcome
      // for something it reported, or the badge given or taken.
      ref.invalidate(standingProvider);
      ref.invalidate(verificationStatusProvider);
      ref.read(currentUserProvider.notifier).refresh();

    case 'moderation.queue':
      // The team only: a report or an appeal is waiting.
      ref.invalidate(reportQueueProvider);
      ref.invalidate(appealQueueProvider);
      ref.invalidate(verificationQueueProvider);

    case 'presence':
      final who = event.data['userId'];
      final online = event.data['online'];
      if (who is String && online is bool) {
        ref.read(presenceProvider.notifier).changed(who, online);
      }

    case 'presence.snapshot':
      // Sent as the socket connects, which is also when this device comes
      // back from wherever it was: answer what was asked of it meanwhile.
      ref.read(messageVaultProvider).answerPending();
      final online = event.data['online'];
      if (online is List) {
        ref
            .read(presenceProvider.notifier)
            .snapshot(online.whereType<String>());
      }
  }
}

void _refreshConversationLists(Ref ref) {
  for (final filter in ConversationFilter.values) {
    if (ref.exists(conversationListProvider(filter))) {
      ref.read(conversationListProvider(filter).notifier).refresh();
    }
  }
  ref.invalidate(unreadConversationsProvider);
}
