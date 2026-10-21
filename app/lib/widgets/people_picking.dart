// lib/widgets/people_picking.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/conversation.dart';

/// The pieces of every screen where people are picked: a row per person, the
/// round mark that says they are chosen, and the chip a chosen person
/// becomes on the "To:" line.
///
/// One set, so New message, a new group and adding to a group look like one
/// app. The square checkboxes and outlined chips these replace were the
/// platform's defaults, and read as a form rather than a list of people.

/// A person's picture, or the person glyph when they have none.
class PersonAvatar extends StatelessWidget {
  final MessagePerson person;
  final double radius;

  const PersonAvatar({super.key, required this.person, this.radius = 22});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final url = person.avatarUrl;
    return CircleAvatar(
      radius: radius,
      backgroundColor: scheme.primary.withValues(alpha: .15),
      foregroundImage: url == null ? null : NetworkImage(url),
      child: Icon(Iconsax.user_copy, size: radius * 0.9, color: scheme.primary),
    );
  }
}

/// What a person is called on a row: their handle first, as they are known
/// on Kyron, with their name under it. Somebody with no handle is their name
/// alone.
({String title, String? subtitle}) personLines(MessagePerson person) {
  final username = person.username?.trim();
  final name = person.name?.trim();
  if (username == null || username.isEmpty) {
    return (title: person.displayName, subtitle: null);
  }
  return (
    title: username,
    subtitle: name == null || name.isEmpty || name == username ? null : name,
  );
}

/// One row in a list to pick from: a picture, a line or two, and whatever
/// goes at the end.
///
/// The rule under it starts where the words do, not at the edge: the
/// pictures make their own column, and a rule through them cut each one off
/// from its name.
class PickRow extends StatelessWidget {
  final Widget leading;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  /// At the end of the row: a [PickMark], a spinner, an arrow, or nothing.
  final Widget? trailing;

  const PickRow({
    super.key,
    required this.leading,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: SpacingTokens.space16),
        child: Row(
          children: [
            leading,
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: Container(
                // Two lines or one, the same height: a row with no name
                // under its handle did not sit a line shorter than the rest.
                constraints: const BoxConstraints(minHeight: 68),
                padding: const EdgeInsets.fromLTRB(
                  0,
                  SpacingTokens.space12,
                  SpacingTokens.space16,
                  SpacingTokens.space12,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: scheme.outline.withValues(alpha: 0.18),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: TypographyTokens.fontSize3,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (subtitle != null)
                            Text(
                              subtitle!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: TypographyTokens.fontSize2,
                                color: scheme.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (trailing != null) ...[
                      const SizedBox(width: SpacingTokens.space12),
                      trailing!,
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// One person in a list to pick from: their handle, their name under it.
class PersonPickRow extends StatelessWidget {
  final MessagePerson person;
  final VoidCallback? onTap;
  final Widget? trailing;

  const PersonPickRow({
    super.key,
    required this.person,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final lines = personLines(person);
    return PickRow(
      leading: PersonAvatar(person: person),
      title: lines.title,
      subtitle: lines.subtitle,
      onTap: onTap,
      trailing: trailing,
    );
  }
}

/// Chosen or not: a filled circle with a tick, or an empty ring.
class PickMark extends StatelessWidget {
  final bool chosen;

  const PickMark({super.key, required this.chosen});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // Iconsax's bold tick in a circle is that circle filled, the tick cut out
    // of it: chosen, at a glance, in the page's own ink.
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 120),
      child: chosen
          ? Icon(
              Iconsax.tick_circle,
              key: const ValueKey('chosen'),
              size: 27,
              color: scheme.onSurface,
            )
          : Container(
              key: const ValueKey('open'),
              width: 24,
              height: 24,
              margin: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: scheme.onSurface.withValues(alpha: 0.25),
                  width: 1.5,
                ),
              ),
            ),
    );
  }
}

/// A chosen person on the "To:" line: their picture and handle in a pill.
/// Tapping it lets them go.
class PersonChip extends StatelessWidget {
  final MessagePerson person;
  final VoidCallback onRemove;

  /// Read out, since the pill shows no cross: "Remove Ada".
  final String removeLabel;

  const PersonChip({
    super.key,
    required this.person,
    required this.onRemove,
    required this.removeLabel,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: removeLabel,
      excludeSemantics: true,
      child: Material(
        color: scheme.onSurface.withValues(alpha: 0.06),
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onRemove,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PersonAvatar(person: person, radius: 12),
                const SizedBox(width: 6),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 160),
                  child: Text(
                    personLines(person).title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: TypographyTokens.fontSize2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A quiet heading over a run of people: "Suggested", "Recent".
class PeopleHeading extends StatelessWidget {
  final String text;

  const PeopleHeading(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space16,
          SpacingTokens.space16,
          SpacingTokens.space16,
          SpacingTokens.space4,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: TypographyTokens.fontSize2,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface.withValues(
                  alpha: 0.5,
                ),
          ),
        ),
      );
}
