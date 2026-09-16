// lib/widgets/language_sheet.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/language.dart';
import 'hairline.dart';

/// Picking a language, or several.
///
/// A sheet, because Kyron does not use dropdowns -- and a *searchable* one,
/// because this list is long and getting longer. Sixty-odd rows is a scroll
/// somebody has to read every line of; a field at the top turns it into three
/// keystrokes. It matches the English name, the endonym and the code, so
/// "German", "Deutsch" and "de" all find the same row.
class LanguageSheet {
  const LanguageSheet._();

  /// Picks one. Answers with the chosen language, or null if it was dismissed.
  static Future<Language?> pickOne(
    BuildContext context, {
    required String title,
    required Language current,
  }) async {
    final chosen = await _show(
      context,
      title: title,
      selected: {current.code},
      multiple: false,
    );
    if (chosen == null || chosen.isEmpty) return null;
    return chosen.first;
  }

  /// Picks any number. Answers with the whole set, or null if it was
  /// dismissed -- which is not the same as an empty set, and the caller has to
  /// be able to tell "I chose none" from "I changed my mind".
  static Future<List<Language>?> pickMany(
    BuildContext context, {
    required String title,
    required List<Language> current,
  }) =>
      _show(
        context,
        title: title,
        selected: {for (final l in current) l.code},
        multiple: true,
      );

  static Future<List<Language>?> _show(
    BuildContext context, {
    required String title,
    required Set<String> selected,
    required bool multiple,
  }) {
    return showModalBottomSheet<List<Language>>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => _LanguageSheetBody(
        title: title,
        selected: selected,
        multiple: multiple,
      ),
    );
  }
}

class _LanguageSheetBody extends StatefulWidget {
  const _LanguageSheetBody({
    required this.title,
    required this.selected,
    required this.multiple,
  });

  final String title;
  final Set<String> selected;
  final bool multiple;

  @override
  State<_LanguageSheetBody> createState() => _LanguageSheetBodyState();
}

class _LanguageSheetBodyState extends State<_LanguageSheetBody> {
  final _query = TextEditingController();
  late final Set<String> _chosen = {...widget.selected};

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  void _toggle(Language language) {
    if (!widget.multiple) {
      Navigator.pop(context, [language]);
      return;
    }
    setState(() {
      if (!_chosen.remove(language.code)) _chosen.add(language.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final matches = Languages.search(_query.text);

    return Padding(
      // Lifts the sheet clear of the keyboard the search field raises.
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.85,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  SpacingTokens.space20,
                  0,
                  SpacingTokens.space20,
                  SpacingTokens.space12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize2,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                          color: scheme.onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                    ),
                    if (widget.multiple)
                      TextButton(
                        onPressed: () => Navigator.pop(
                          context,
                          Languages.fromCodes(_chosen),
                        ),
                        child: const Text('Done'),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space20,
                ),
                child: TextField(
                  controller: _query,
                  autocorrect: false,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Search languages',
                    prefixIcon:
                        const Icon(Iconsax.search_normal_1_copy, size: 18),
                    suffixIcon: _query.text.isEmpty
                        ? null
                        : IconButton(
                            icon:
                                const Icon(Iconsax.close_circle_copy, size: 18),
                            tooltip: 'Clear',
                            onPressed: () => setState(_query.clear),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: SpacingTokens.space12),
              const Hairline(),
              Flexible(
                child: matches.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(SpacingTokens.space24),
                        // Named, so it is clear the search ran and found
                        // nothing rather than that the list failed to load.
                        child: Text(
                          'No language here matches “${_query.text}”.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize2,
                            color: scheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: matches.length,
                        itemBuilder: (context, i) {
                          final language = matches[i];
                          final on = _chosen.contains(language.code);
                          return ListTile(
                            onTap: () => _toggle(language),
                            // The endonym leads. Somebody looking for their
                            // own language is looking for the name they write
                            // it in, not for ours.
                            title: Text(
                              language.nativeName,
                              textDirection:
                                  language.rtl ? TextDirection.rtl : null,
                            ),
                            subtitle:
                                language.nativeName == language.englishName
                                    ? null
                                    : Text(language.englishName),
                            trailing: on
                                ? Icon(Iconsax.tick_circle_copy,
                                    color: scheme.primary)
                                : null,
                            selected: on,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
