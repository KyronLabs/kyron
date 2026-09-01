import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// What to do with a post that is being abandoned.
enum DraftChoice { save, discard, keepEditing }

/// Offered when the composer is closed with something in it.
///
/// Closing straight away throws away what was written; refusing to close is
/// worse. Asking is the only option that does not lose work or trap anyone.
class DraftSheet {
  const DraftSheet._();

  static Future<DraftChoice> show(BuildContext context) async {
    final choice = await showModalBottomSheet<DraftChoice>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Iconsax.archive_add_copy, size: 20),
              title: const Text('Save draft'),
              subtitle: const Text(
                'Keep the text and come back to it',
                style: TextStyle(fontSize: 12),
              ),
              onTap: () => Navigator.pop(sheetContext, DraftChoice.save),
            ),
            ListTile(
              leading: Icon(
                Iconsax.trash_copy,
                size: 20,
                color: Theme.of(sheetContext).colorScheme.error,
              ),
              title: Text(
                'Discard',
                style: TextStyle(
                  color: Theme.of(sheetContext).colorScheme.error,
                ),
              ),
              subtitle: const Text(
                'Throw away what you have written',
                style: TextStyle(fontSize: 12),
              ),
              onTap: () => Navigator.pop(sheetContext, DraftChoice.discard),
            ),
            ListTile(
              leading: const Icon(Iconsax.edit_2_copy, size: 20),
              title: const Text('Keep editing'),
              onTap: () => Navigator.pop(sheetContext, DraftChoice.keepEditing),
            ),
            const SizedBox(height: SpacingTokens.space8),
          ],
        ),
      ),
    );

    // Dismissed by swiping down or tapping outside: the safe reading is that
    // nobody chose to lose anything.
    return choice ?? DraftChoice.keepEditing;
  }
}
