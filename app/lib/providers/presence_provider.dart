// lib/providers/presence_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/conversation.dart';

/// Who the reader can see is online right now, as the socket has said.
///
/// Until the socket has said anything ([live] false), what each page said
/// when it was read stands. After that the socket is the truth: it sends the
/// whole list as it connects (`presence.snapshot`) and every change since
/// (`presence`), so a person it has not named is not online.
class PresenceState {
  final Set<String> online;
  final bool live;

  const PresenceState({this.online = const {}, this.live = false});

  /// Whether to draw [person] as online.
  bool of(MessagePerson person) =>
      live ? online.contains(person.id) : person.online;
}

class PresenceNotifier extends StateNotifier<PresenceState> {
  PresenceNotifier() : super(const PresenceState());

  /// Everybody who is online, as the server sees it.
  void snapshot(Iterable<String> online) =>
      state = PresenceState(online: {...online}, live: true);

  /// One person came or went.
  void changed(String userId, bool online) {
    final next = {...state.online};
    if (online) {
      next.add(userId);
    } else {
      next.remove(userId);
    }
    state = PresenceState(online: next, live: true);
  }

  /// Nobody, at once: the reader stopped showing theirs, and sees nobody's.
  void hideAll() => state = const PresenceState(live: true);
}

final presenceProvider = StateNotifierProvider<PresenceNotifier, PresenceState>(
  (ref) => PresenceNotifier(),
);
