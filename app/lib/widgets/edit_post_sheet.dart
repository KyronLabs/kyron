// lib/widgets/edit_post_sheet.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/feed_post.dart';
import '../providers/feed_provider.dart' show feedRepositoryProvider;
import '../utils/api_error_message.dart';
import 'app_sheet.dart';
import 'hairline.dart';

/// Changing a post's words, in the minutes after it went out.
///
/// The words only: attachments, a poll and topics are what the post was, and
/// changing those would be a different post. The window is the server's
/// ([FeedPost.editWindow]); the sheet says how long is left, and the server
/// has the last word if it runs out while the sheet is open.
abstract final class EditPostSheet {
  /// Answers with the post as it now is, or null if nothing was changed.
  static Future<FeedPost?> show(BuildContext context, FeedPost post) =>
      showAppSheet<FeedPost>(
        context: context,
        isScrollControlled: true,
        builder: (_) => _Sheet(post: post),
      );
}

class _Sheet extends ConsumerStatefulWidget {
  final FeedPost post;

  const _Sheet({required this.post});

  @override
  ConsumerState<_Sheet> createState() => _SheetState();
}

class _SheetState extends ConsumerState<_Sheet> {
  late final _text = TextEditingController(text: widget.post.content);
  final _focus = FocusNode();
  bool _saving = false;
  String? _error;

  /// The server's limit on a post's length.
  static const _maxLength = 3000;

  @override
  void initState() {
    super.initState();
    _text.addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _focus.requestFocus();
      // At the end, where a correction usually starts.
      _text.selection = TextSelection.collapsed(offset: _text.text.length);
    });
  }

  @override
  void dispose() {
    _text.dispose();
    _focus.dispose();
    super.dispose();
  }

  bool get _changed => _text.text.trim() != widget.post.content.trim();

  /// Words or something else to stand on: an emptied post with a picture is
  /// still a post, an emptied post with nothing is not.
  bool get _valid =>
      _text.text.trim().isNotEmpty ||
      (widget.post.media.isNotEmpty && widget.post.poll == null);

  Future<void> _save() async {
    if (_saving || !_changed || !_valid) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final updated = await ref
          .read(feedRepositoryProvider)
          .edit(widget.post.id, _text.text.trim());
      unawaited(HapticFeedback.lightImpact());
      if (mounted) Navigator.pop(context, updated);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = describeApiError(e, sessionIsLive: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final left =
        FeedPost.editWindow - DateTime.now().difference(widget.post.createdAt);
    // Rounded up: with forty seconds left, "1 more min" is the honest answer.
    final minutes = (left.inSeconds / 60).ceil().clamp(1, 15);

    return Padding(
      // Above the keyboard, which this sheet always brings up.
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SpacingTokens.space16,
                SpacingTokens.space8,
                SpacingTokens.space8,
                SpacingTokens.space8,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.ui('ui_edit_post', 'Edit post'),
                          style: const TextStyle(
                            fontSize: TypographyTokens.fontSize4,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          l10n
                              .ui(
                                'ui_edit_post_left',
                                r'You can edit it for $n more min',
                              )
                              .replaceAll(r'$n', '$minutes'),
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize1,
                            color: scheme.onSurface.withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FilledButton(
                    key: const ValueKey('edit-post-save'),
                    onPressed: _changed && _valid && !_saving ? _save : null,
                    child: _saving
                        ? const SizedBox.square(
                            dimension: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.ui('ui_save', 'Save')),
                  ),
                ],
              ),
            ),
            const RuleLine(),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.45,
              ),
              child: TextField(
                key: const ValueKey('edit-post-field'),
                controller: _text,
                focusNode: _focus,
                maxLines: null,
                minLines: 4,
                maxLength: _maxLength,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(
                  fontSize: TypographyTokens.fontSize4,
                  height: 1.4,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                  contentPadding: EdgeInsets.all(SpacingTokens.space16),
                ),
              ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  SpacingTokens.space16,
                  0,
                  SpacingTokens.space16,
                  SpacingTokens.space12,
                ),
                child: Text(
                  _error!,
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize2,
                    color: scheme.error,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
