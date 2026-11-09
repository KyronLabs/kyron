// lib/widgets/check_in_sheet.dart
import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../providers/feedback_provider.dart';
import '../repositories/feedback_repository.dart';
import '../services/app_info.dart';
import '../utils/api_error_message.dart';
import 'action_button.dart';
import 'app_sheet.dart';

/// One question, a few days in: how is it going? A face to tap, and room
/// for a sentence if there is one to say.
///
/// Asked on the third and tenth day by [HomePrompts], and filed with the
/// rest of the feedback, tagged with the day -- so a test's feedback is
/// something people gave, not something nobody was asked for.
abstract final class CheckInSheet {
  static Future<void> show(BuildContext context, {required int day}) =>
      showAppSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (_) => _Sheet(day: day),
      );

  /// The five answers, worst first.
  static const faces = ['😞', '🙁', '😐', '🙂', '😍'];

  /// What is filed: the day and the face in the title, the words (or a
  /// line saying there were none) in the body.
  static ({String title, String body}) report({
    required int day,
    required int rating,
    required String words,
  }) {
    final said = words.trim();
    final rated = 'Rated $rating of 5 on day $day.';
    return (
      title: 'Day $day check-in: $rating/5',
      body: said.isEmpty ? rated : '$said\n\n$rated',
    );
  }
}

class _Sheet extends ConsumerStatefulWidget {
  final int day;

  const _Sheet({required this.day});

  @override
  ConsumerState<_Sheet> createState() => _SheetState();
}

class _SheetState extends ConsumerState<_Sheet> {
  final _words = TextEditingController();
  int? _rating;
  bool _sending = false;
  bool _sent = false;
  String? _error;

  @override
  void dispose() {
    _words.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final rating = _rating;
    if (rating == null || _sending) return;
    setState(() {
      _sending = true;
      _error = null;
    });
    final filed = CheckInSheet.report(
      day: widget.day,
      rating: rating,
      words: _words.text,
    );
    try {
      String? version;
      try {
        // Worth having, never worth waiting on.
        version =
            (await AppInfo.load().timeout(const Duration(seconds: 2))).display;
      } catch (_) {}
      await ref.read(feedbackRepositoryProvider).send(
            kind: FeedbackKind.idea,
            title: filed.title,
            body: filed.body,
            appVersion: version,
            platform: _platform(),
          );
      if (!mounted) return;
      unawaited(HapticFeedback.lightImpact());
      setState(() => _sent = true);
      await Future<void>.delayed(const Duration(milliseconds: 900));
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _sending = false;
        _error = describeApiError(e, sessionIsLive: true);
      });
    }
  }

  static String? _platform() {
    try {
      return Platform.operatingSystem;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            SpacingTokens.space20,
            SpacingTokens.space8,
            SpacingTokens.space20,
            SpacingTokens.space16,
          ),
          child: _sent
              ? SizedBox(
                  height: 160,
                  child: Center(
                    child: Text(
                      l10n.ui('ui_check_in_thanks',
                          'Thank you. We read every one.'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: TypographyTokens.fontSize4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.ui('ui_check_in_title', "How's Kyron so far?"),
                      style: const TextStyle(
                        fontSize: TypographyTokens.fontSize5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: SpacingTokens.space2),
                    Text(
                      l10n
                          .ui(
                            'ui_check_in_detail',
                            r'Day $day of your test. One tap is enough.',
                          )
                          .replaceAll(r'$day', '${widget.day}'),
                      style: TextStyle(
                        fontSize: TypographyTokens.fontSize2,
                        color: scheme.onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                    const SizedBox(height: SpacingTokens.space20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (final (i, face) in CheckInSheet.faces.indexed)
                          _Face(
                            key: ValueKey('check-in-face-${i + 1}'),
                            face: face,
                            selected: _rating == i + 1,
                            onTap: () {
                              unawaited(HapticFeedback.selectionClick());
                              setState(() => _rating = i + 1);
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: SpacingTokens.space20),
                    TextField(
                      key: const ValueKey('check-in-words'),
                      controller: _words,
                      minLines: 2,
                      maxLines: 4,
                      maxLength: 1000,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: l10n.ui(
                          'ui_check_in_hint',
                          'Anything we should fix or add? (optional)',
                        ),
                        counterText: '',
                      ),
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: SpacingTokens.space8),
                      Text(
                        _error!,
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize2,
                          color: scheme.error,
                        ),
                      ),
                    ],
                    const SizedBox(height: SpacingTokens.space16),
                    ActionButton(
                      key: const ValueKey('check-in-send'),
                      label: l10n.ui('ui_send', 'Send'),
                      expand: true,
                      busy: _sending,
                      onPressed: _rating == null ? null : _send,
                    ),
                    const SizedBox(height: SpacingTokens.space4),
                    TextButton(
                      key: const ValueKey('check-in-later'),
                      onPressed: () => Navigator.pop(context),
                      child: Text(l10n.ui('ui_not_now', 'Not now')),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _Face extends StatelessWidget {
  final String face;
  final bool selected;
  final VoidCallback onTap;

  const _Face({
    super.key,
    required this.face,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: MotionTokens.fast,
        width: 54,
        height: 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected
              ? scheme.primary.withValues(alpha: 0.14)
              : scheme.onSurface.withValues(alpha: 0.05),
          border: Border.all(
            color: selected ? scheme.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: AnimatedScale(
          duration: MotionTokens.fast,
          scale: selected ? 1.15 : 1,
          child: Text(
            face,
            style: const TextStyle(fontSize: TypographyTokens.fontSize7),
          ),
        ),
      ),
    );
  }
}
