// lib/screens/coming_soon_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../routes.dart';
import '../widgets/empty_state.dart';

/// A post type that is announced but not built.
///
/// AR lenses, polls and audio spaces are all on the create menu, and none of
/// them exists: tapping them used to close the sheet and do nothing at all,
/// which reads as a broken button rather than an unfinished feature. This says
/// which it is, and offers the one composer that does work.
class ComingSoonScreen extends StatelessWidget {
  final String title;
  final EmptyArt art;
  final String heading;
  final String detail;

  const ComingSoonScreen({
    super.key,
    required this.title,
    required this.art,
    required this.heading,
    required this.detail,
  });

  const ComingSoonScreen.arLens({super.key})
      : title = 'AR Lens',
        art = EmptyArt.lens,
        heading = 'Lenses are not ready yet',
        detail =
            'Recording and publishing AR lenses is still being built. Nothing '
                'you capture would be saved yet, so the camera stays closed.';

  const ComingSoonScreen.poll({super.key})
      : title = 'Poll',
        art = EmptyArt.polls,
        heading = 'Polls are not ready yet',
        detail =
            'Polls need somewhere to keep the options and count the votes. '
                'That is not in place yet, so a poll posted today would lose '
                'every answer.';

  const ComingSoonScreen.live({super.key})
      : title = 'Go live',
        art = EmptyArt.live,
        heading = 'Going live is not ready yet',
        detail = 'Going live needs a media server Kyron does not run yet. '
            'Starting a broadcast now would put you in a room nobody could '
            'join. Recording a voice post works today.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(title),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: EmptyState(
              art: art,
              title: heading,
              detail: detail,
              action: 'Write a text post instead',
              onAction: () => Navigator.pushReplacementNamed(
                context,
                Routes.composer,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
