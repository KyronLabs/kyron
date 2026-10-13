// lib/widgets/online_dot.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/conversation.dart';
import '../providers/presence_provider.dart';

/// A green dot on the corner of somebody's picture while they have Kyron open.
///
/// Only ever for people the reader talks to, and only while both of them
/// show it -- the server decides that (PresenceService) and the app draws
/// what it is told. Ringed in the colour of whatever it sits on, so it reads
/// as on the picture rather than stuck to its edge.
class OnlineDot extends ConsumerWidget {
  final MessagePerson? person;

  /// The picture the dot sits on.
  final Widget child;

  /// The dot's diameter, ring included.
  final double size;

  const OnlineDot({
    super.key,
    required this.person,
    required this.child,
    this.size = 14,
  });

  static const green = Color(0xFF22C55E);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final who = person;
    final online = who != null && ref.watch(presenceProvider).of(who);
    if (!online) return child;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: -1,
          bottom: -1,
          child: Container(
            key: ValueKey('online-${who.id}'),
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: green,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: size * 0.18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Whether [person] is online, for a line of text that says so.
bool isOnline(WidgetRef ref, MessagePerson? person) =>
    person != null && ref.watch(presenceProvider).of(person);
