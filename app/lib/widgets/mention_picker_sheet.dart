import '../l10n/app_localizations.dart';

// lib/widgets/mention_picker_sheet.dart
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/profile_summary.dart';
import '../providers/api_client_provider.dart';
import '../providers/search_provider.dart' show SearchState;
import '../utils/api_error_message.dart';
import '../utils/format_count.dart';

import 'skeleton.dart';

/// Picks somebody to tag, and answers with their handle.
///
/// A sheet rather than a list that unrolls under the caret: it arrives from
/// the same place at the same size whatever was being typed, its rows are big
/// enough to hit, and it leaves the keyboard's own suggestion strip alone.
///
/// Only accounts that have a handle are offered. A mention is written as
/// `@handle` and read back by resolving that handle, so offering somebody who
/// has none would insert text that resolves to nobody -- which is what the
/// composer's tag button used to do for everyone: it inserted a bare '@'.
class MentionPickerSheet {
  const MentionPickerSheet._();

  /// The handle chosen, without its leading @, or null if nothing was.
  static Future<String?> show(
    BuildContext context, {
    String initialQuery = '',
  }) {
    return showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => _MentionPicker(initialQuery: initialQuery),
    );
  }
}

class _MentionPicker extends ConsumerStatefulWidget {
  final String initialQuery;

  const _MentionPicker({required this.initialQuery});

  @override
  ConsumerState<_MentionPicker> createState() => _MentionPickerState();
}

class _MentionPickerState extends ConsumerState<_MentionPicker> {
  /// Long enough that typing a name does not fire a request per keystroke,
  /// short enough that stopping feels like an answer.
  static const _debounce = Duration(milliseconds: 250);

  /// What the server will search on. Mirrored here so one letter says "keep
  /// typing" rather than firing a request the API answers with a 400.
  static const _minimum = SearchState.minimumQueryLength;

  late final TextEditingController _query = TextEditingController(
    text: widget.initialQuery,
  );
  final _focus = FocusNode();

  Timer? _pending;

  /// Counts searches, so a slow one that lands after a newer one has been
  /// asked for is dropped rather than overwriting it.
  int _token = 0;

  List<ProfileSummary> _results = const [];
  bool _searching = false;
  String? _error;

  /// What [_results] answers. Kept so the empty state can name it.
  String _answered = '';

  @override
  void initState() {
    super.initState();
    if (widget.initialQuery.trim().isNotEmpty) _run(immediate: true);
    // Focused so the keyboard is already up: this opens in the middle of
    // typing a post, and asking somebody to tap a field first is a step.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focus.requestFocus();
    });
  }

  @override
  void dispose() {
    _pending?.cancel();
    _query.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _run({bool immediate = false}) {
    _pending?.cancel();
    final text = _query.text.trim();

    if (text.length < _minimum) {
      _token++;
      setState(() {
        _results = const [];
        _searching = false;
        _error = null;
        _answered = '';
      });
      return;
    }

    setState(() {
      _searching = true;
      _error = null;
    });

    if (immediate) {
      unawaited(_search(++_token, text));
    } else {
      _pending = Timer(_debounce, () {
        if (mounted) unawaited(_search(++_token, text));
      });
    }
  }

  Future<void> _search(int token, String text) async {
    try {
      final api = ref.read(apiClientProvider);
      final res = await api.dio.get<Map<String, dynamic>>(
        '/profile/search',
        queryParameters: {'q': text, 'limit': 25},
      );
      if (!mounted || token != _token) return;

      final people = ((res.data?['items'] as List<dynamic>?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(ProfileSummary.fromJson)
          // A mention is written as @handle, so somebody with no handle
          // cannot be one.
          .where((p) => (p.username ?? '').trim().isNotEmpty)
          .toList();

      setState(() {
        _results = people;
        _searching = false;
        _answered = text;
      });
    } on DioException catch (error) {
      if (!mounted || token != _token) return;
      setState(() {
        _searching = false;
        _error = describeApiError(error, sessionIsLive: true);
      });
    }
  }

  void _choose(ProfileSummary person) {
    HapticFeedback.selectionClick();
    Navigator.pop(context, person.username!.replaceFirst('@', ''));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      // Above the keyboard, which is up the whole time this is open.
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.7,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SpacingTokens.space16,
                0,
                SpacingTokens.space16,
                SpacingTokens.space12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tag someone',
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize4,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: SpacingTokens.space12),
                  TextField(
                    controller: _query,
                    focusNode: _focus,
                    autocorrect: false,
                    textInputAction: TextInputAction.search,
                    onChanged: (_) => _run(),
                    onSubmitted: (_) => _run(immediate: true),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)
                          .searchByNameOrHandle,
                      prefixIcon: const Icon(
                        Iconsax.search_normal_1_copy,
                        size: 18,
                      ),
                      filled: true,
                      fillColor: scheme.surfaceContainerHighest.withValues(
                        alpha: 0.5,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          RadiusTokens.radiusMd,
                        ),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: SpacingTokens.space12,
                        vertical: SpacingTokens.space12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: _body(scheme)),
          ],
        ),
      ),
    );
  }

  Widget _body(ColorScheme scheme) {
    if (_error != null) {
      return _Notice(
        icon: Iconsax.warning_2_copy,
        title: AppLocalizations.of(context).literalcouldNotSearch,
        detail: _error!,
        action: 'Try again',
        onAction: () => _run(immediate: true),
      );
    }

    // Only while there is nothing to show: keeping the last results up while
    // the next letter is searched stops the list flashing under the finger.
    if (_searching && _results.isEmpty) {
      return SingleChildScrollView(child: SkeletonList.people(count: 6));
    }

    if (_query.text.trim().length < _minimum) {
      return const _Notice(
        icon: Iconsax.tag_user_copy,
        title: AppLocalizations.of(context).literalwhoDoYouWantToTag,
        detail: 'Type at least two characters of a name or a handle.',
      );
    }

    if (_results.isEmpty) {
      return _Notice(
        icon: Iconsax.search_normal_1_copy,
        title: AppLocalizations.of(context).literalnobodyFound,
        detail: 'No account matches "$_answered".',
      );
    }

    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.only(bottom: SpacingTokens.space16),
      itemCount: _results.length,
      itemBuilder: (context, index) => _PersonRow(
        person: _results[index],
        onTap: () => _choose(_results[index]),
      ),
    );
  }
}

class _PersonRow extends StatelessWidget {
  final ProfileSummary person;
  final VoidCallback onTap;

  const _PersonRow({required this.person, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final handle = person.username!.replaceFirst('@', '');
    final name = (person.name ?? '').trim();

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space16,
          vertical: SpacingTokens.space12,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: scheme.primary.withValues(alpha: 0.15),
              foregroundImage: person.avatarUrl == null
                  ? null
                  : NetworkImage(person.avatarUrl!),
              child: Icon(Iconsax.user_copy, size: 20, color: scheme.primary),
            ),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name.isEmpty ? '@$handle' : name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize3,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    // The handle is what gets written into the post, so it is
                    // always shown -- even when it is also the line above.
                    '@$handle · ${formatCount(person.followers)} followers',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize1,
                      color: scheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;
  final String? action;
  final VoidCallback? onAction;

  const _Notice({
    required this.icon,
    required this.title,
    required this.detail,
    this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: scheme.onSurface.withValues(alpha: .4)),
            const SizedBox(height: SpacingTokens.space12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: TypographyTokens.fontSize3,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
            const SizedBox(height: SpacingTokens.space4),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: TypographyTokens.fontSize2,
                color: scheme.onSurface.withValues(alpha: 0.65),
              ),
            ),
            if (action != null) ...[
              const SizedBox(height: SpacingTokens.space12),
              TextButton(onPressed: onAction, child: Text(action!)),
            ],
          ],
        ),
      ),
    );
  }
}
