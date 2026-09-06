import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_language.dart';
import '../providers/preferences_provider.dart';
import 'action_sheet.dart';

/// The language picker on the get-started screen.
///
/// It used to take a hard-coded `selected: 'English'` and an `onChanged` that
/// did nothing, over its own list of three languages -- a control that visibly
/// changed and then had no effect anywhere. It now reads and writes the same
/// stored preference the settings screen does, over the same list, so choosing
/// a language before signing in is still the choice afterwards.
class AppLanguageSelector extends ConsumerWidget {
  const AppLanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(preferencesProvider).language;

    return TextButton.icon(
      onPressed: () async {
        final chosen = await ActionSheet.show<AppLanguage>(
          context,
          title: 'LANGUAGE',
          actions: [
            for (final language in AppLanguage.values)
              SheetAction(
                value: language,
                label: language.nativeName,
                icon: Icons.language,
                selected: language == selected,
              ),
          ],
        );
        if (chosen != null) {
          ref.read(preferencesProvider.notifier).setLanguage(chosen);
        }
      },
      icon: Text(
        selected.nativeName,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      label: const Icon(Icons.language, size: 18),
    );
  }
}
