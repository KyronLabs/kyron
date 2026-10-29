import '../l10n/app_localizations.dart';

// lib/widgets/country_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/country.dart';
import 'app_sheet.dart';
import 'hairline.dart';

/// What the country sheet answered: a code, or null for "no country". The
/// sheet itself answers null when it was dismissed, which is not the same.
typedef CountryChoice = ({String? code});

/// Picking the country on your profile.
///
/// Searchable, like the language sheet: 250 rows is a scroll nobody should
/// have to read. It matches the name in the reader's language, the English
/// name and the code, so "Allemagne", "Germany" and "DE" find the same row.
class CountrySheet {
  const CountrySheet._();

  static Future<CountryChoice?> pick(
    BuildContext context, {
    required String? current,
  }) {
    return showAppSheet<CountryChoice>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _CountrySheetBody(current: current),
    );
  }
}

class _CountrySheetBody extends ConsumerStatefulWidget {
  const _CountrySheetBody({required this.current});

  final String? current;

  @override
  ConsumerState<_CountrySheetBody> createState() => _CountrySheetBodyState();
}

class _CountrySheetBodyState extends ConsumerState<_CountrySheetBody> {
  final _query = TextEditingController();
  late final _suggested = Countries.suggested();

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final language = Localizations.localeOf(context).languageCode;
    final names = ref.watch(countryNamesProvider(language)).value;
    final english = ref.watch(countryNamesProvider('en')).value;
    final query = _query.text.trim().toLowerCase();

    String name(String code) => names?[code] ?? english?[code] ?? code;
    bool matches(String code) =>
        query.isEmpty ||
        code.toLowerCase() == query ||
        name(code).toLowerCase().contains(query) ||
        (english?[code]?.toLowerCase().contains(query) ?? false);

    // In the reader's alphabet order, not by code: "Deutschland" is not
    // where a German reader looks for Germany under D-E.
    final all = [...countryCodes]
      ..sort((a, b) => name(a).toLowerCase().compareTo(name(b).toLowerCase()));
    // A code typed whole ("NG", "de") is somebody who knows exactly which
    // one they mean: it goes first, ahead of every name with those letters.
    final found = all.where(matches).toList()
      ..sort(
        (a, b) =>
            (b.toLowerCase() == query ? 1 : 0) -
            (a.toLowerCase() == query ? 1 : 0),
      );
    final suggested = query.isEmpty
        ? [
            for (final c in _suggested)
              if (c != widget.current) c
          ]
        : const <String>[];

    Widget row(String code) {
      final on = code == widget.current;
      return ListTile(
        key: ValueKey('country-$code'),
        onTap: () => Navigator.pop(context, (code: code)),
        leading: Text(
          Countries.flag(code),
          style: const TextStyle(fontSize: TypographyTokens.fontSize6),
        ),
        title: Text(name(code)),
        subtitle: names != null &&
                english != null &&
                language != 'en' &&
                english[code] != name(code)
            ? Text(english[code]!)
            : null,
        trailing:
            on ? Icon(Iconsax.tick_circle_copy, color: scheme.primary) : null,
        selected: on,
      );
    }

    Widget label(String text) => Padding(
          padding: const EdgeInsets.fromLTRB(
            SpacingTokens.space20,
            SpacingTokens.space12,
            SpacingTokens.space20,
            SpacingTokens.space4,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: TypographyTokens.fontSize1,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
              color: scheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
        );

    final entries = <Widget Function()>[
      if (suggested.isNotEmpty) ...[
        () =>
            label(l10n.ui('country_suggested', 'From your phone\'s settings')),
        for (final code in suggested) () => row(code),
        () => const Hairline(),
      ],
      if (query.isEmpty && widget.current != null)
        () => ListTile(
              key: const ValueKey('country-none'),
              onTap: () => Navigator.pop(context, (code: null)),
              leading: const Icon(Iconsax.global_copy),
              title: Text(l10n.ui('country_none', 'Don\'t show a country')),
            ),
      if (found.isEmpty)
        () => Padding(
              padding: const EdgeInsets.all(SpacingTokens.space24),
              child: Text(
                l10n
                    .ui('country_no_match', 'No country matches “{query}”.')
                    .replaceAll('{query}', _query.text.trim()),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize2,
                  color: scheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            )
      else
        for (final code in found) () => row(code),
    ];

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
                  SpacingTokens.space4,
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    l10n.ui('profile_country', 'Country'),
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize2,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: scheme.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  SpacingTokens.space20,
                  0,
                  SpacingTokens.space20,
                  SpacingTokens.space8,
                ),
                child: Text(
                  l10n.ui(
                    'country_shown',
                    'Shown on your profile and under your posts. When you see someone\'s posts, your country is counted in their Insights, only in groups of five or more and never by name.',
                  ),
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize1,
                    color: scheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space20,
                ),
                child: TextField(
                  key: const ValueKey('country-search'),
                  controller: _query,
                  autocorrect: false,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: l10n.ui('country_search', 'Search countries'),
                    prefixIcon: const Icon(
                      Iconsax.search_normal_1_copy,
                      size: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: SpacingTokens.space12),
              const Hairline(),
              Flexible(
                // Built as it scrolls: 250 rows, most never seen.
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: entries.length,
                  itemBuilder: (context, i) => entries[i](),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A country as a flag and its name in the reader's language.
///
/// Until the names have been read -- once, the first time -- just the flag,
/// rather than a code that would change under the reader a moment later.
class CountryLabel extends ConsumerWidget {
  const CountryLabel(this.code, {super.key, this.style});

  final String code;
  final TextStyle? style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = Localizations.localeOf(context).languageCode;
    final name = ref.watch(countryNamesProvider(language)).value?[code];

    return Text(
      name == null ? Countries.flag(code) : '${Countries.flag(code)}  $name',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }
}

/// The country row on a profile form: reads as a field, opens the sheet.
///
/// Not a text field, on purpose. See [Countries].
class CountryField extends StatelessWidget {
  const CountryField({super.key, required this.code, required this.onChanged});

  final String? code;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return InkWell(
      key: const ValueKey('country-field'),
      borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
      onTap: () async {
        final choice = await CountrySheet.pick(context, current: code);
        if (choice != null) onChanged(choice.code);
      },
      child: InputDecorator(
        isEmpty: code == null,
        decoration: InputDecoration(
          labelText: l10n.ui('profile_country', 'Country'),
          helperText: l10n.ui(
            'country_helper',
            'Shown on your profile and under your posts.',
          ),
          prefixIcon: const Icon(Iconsax.location_copy, size: 18),
          suffixIcon: const Icon(Iconsax.arrow_down_1_copy, size: 18),
        ),
        child: code == null ? null : CountryLabel(code!),
      ),
    );
  }
}
