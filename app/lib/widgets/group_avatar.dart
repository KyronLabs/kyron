// lib/widgets/group_avatar.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../models/conversation.dart';

/// A group, drawn as two of its members, one over the other's shoulder --
/// or the mark for a group, while there are not two with a picture.
class GroupAvatar extends StatelessWidget {
  final List<MessagePerson> people;

  /// The radius a single avatar in the same place would have.
  final double radius;

  const GroupAvatar({super.key, required this.people, this.radius = 24});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final pictured = people.where((p) => p.avatarUrl != null).take(2).toList();
    final size = radius * 2;

    if (pictured.length < 2) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: scheme.primary.withValues(alpha: 0.15),
        child: Icon(
          Iconsax.profile_2user_copy,
          size: radius * 0.9,
          color: scheme.primary,
        ),
      );
    }

    final small = radius * 0.72;
    Widget face(MessagePerson person) => Container(
          padding: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            color: scheme.surface,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: small,
            backgroundColor: scheme.primary.withValues(alpha: 0.15),
            foregroundImage: NetworkImage(person.avatarUrl!),
          ),
        );

    return SizedBox.square(
      dimension: size,
      child: Stack(
        children: [
          Positioned(top: 0, right: 0, child: face(pictured[0])),
          Positioned(bottom: 0, left: 0, child: face(pictured[1])),
        ],
      ),
    );
  }
}
