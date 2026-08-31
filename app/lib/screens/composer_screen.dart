// lib/screens/composer_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/composer_provider.dart';
import '../providers/current_user_provider.dart';
import '../widgets/create_post/char_counter.dart';
import '../widgets/create_post/emoji_picker_sheet.dart';
import '../widgets/create_post/url_preview.dart';

/// Writing a text post.
///
/// The screen this replaces had a ribbon of five controls, of which one did
/// anything: privacy and scheduling the API has never accepted, an AI Assist
/// panel that opened a "coming soon" card, a media picker whose attachments
/// were dropped on send, and hashtag, mention and voice buttons that were
/// empty TODOs. The Post button itself slept for a second, printed to the
/// console and cleared the box without writing anything.
class ComposerScreen extends ConsumerStatefulWidget {
  const ComposerScreen({super.key});

  @override
  ConsumerState<ComposerScreen> createState() => _ComposerScreenState();
}

class _ComposerScreenState extends ConsumerState<ComposerScreen> {
  late final TextEditingController _textController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();

    // The provider may already hold a restored draft.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final content = ref.read(composerProvider).content;
      if (content.isNotEmpty && _textController.text.isEmpty) {
        _textController.value = TextEditingValue(
          text: content,
          selection: TextSelection.collapsed(offset: content.length),
        );
      }
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final state = ref.watch(composerProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        await _close();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Close',
            onPressed: _close,
          ),
          title: const Text('New post'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: SpacingTokens.space8),
              child: FilledButton(
                onPressed: state.canPost ? _handlePost : null,
                child: state.isPosting
                    ? const SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Post'),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              if (state.error != null)
                _ErrorBanner(
                  message: state.error!,
                  onRetry: state.canPost ? _handlePost : null,
                ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(SpacingTokens.space16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _AuthorLine(),
                      const SizedBox(height: SpacingTokens.space12),
                      _composerField(scheme),
                      const UrlPreview(),
                    ],
                  ),
                ),
              ),
              const CharCounter(),
              _toolbar(scheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _composerField(ColorScheme scheme) {
    return TextField(
      controller: _textController,
      focusNode: _focusNode,
      maxLines: null,
      minLines: 5,
      autocorrect: true,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      onChanged: ref.read(composerProvider.notifier).updateContent,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.4),
      decoration: InputDecoration(
        hintText: ref.watch(
          composerProvider.select((s) => s.placeholderText),
        ),
        hintStyle: TextStyle(color: scheme.onSurface.withValues(alpha: .5)),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        // The screen has its own counter under the field; the built-in one
        // rendered a second, differently formatted count beside it.
        counterText: '',
      ),
    );
  }

  /// What is left once the controls with nothing behind them are gone: the
  /// three that put a character where the cursor is.
  Widget _toolbar(ColorScheme scheme) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: scheme.outline.withValues(alpha: .15),
            width: .5,
          ),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: SpacingTokens.space8),
          _toolButton(
            icon: Iconsax.hashtag,
            tooltip: 'Add a hashtag',
            onTap: () => _insert('#'),
          ),
          _toolButton(
            icon: Iconsax.tag_user,
            tooltip: 'Mention someone',
            onTap: () => _insert('@'),
          ),
          _toolButton(
            icon: Iconsax.emoji_happy,
            tooltip: 'Insert an emoji',
            onTap: _insertEmoji,
          ),
        ],
      ),
    );
  }

  Widget _toolButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return IconButton(
      icon: Icon(icon, size: 20),
      tooltip: tooltip,
      onPressed: onTap,
    );
  }

  /// Puts [text] where the cursor is and leaves the cursor after it, so typing
  /// carries straight on. Appending to the end would drop a stray '#' at the
  /// bottom of whatever was being edited mid-sentence.
  void _insert(String text) {
    HapticFeedback.selectionClick();
    final value = _textController.value;
    final selection = value.selection;
    final base = value.text;

    final start = selection.isValid ? selection.start : base.length;
    final end = selection.isValid ? selection.end : base.length;
    final updated = base.replaceRange(start, end, text);

    _textController.value = TextEditingValue(
      text: updated,
      selection: TextSelection.collapsed(offset: start + text.length),
    );
    ref.read(composerProvider.notifier).updateContent(updated);
    _focusNode.requestFocus();
  }

  Future<void> _insertEmoji() async {
    final emoji = await EmojiPickerSheet.show(context);
    // The picker used to return the chosen emoji into a variable nobody read,
    // so picking one closed the sheet and did nothing.
    if (emoji != null) _insert(emoji.emoji);
  }

  Future<void> _handlePost() async {
    final posted = await ref.read(composerProvider.notifier).post();
    if (!mounted || !posted) return;

    HapticFeedback.heavyImpact();
    _textController.clear();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Posted')),
    );
  }

  /// Keeps whatever is written before leaving, so backing out by accident does
  /// not lose it.
  Future<void> _close() async {
    await ref.read(composerProvider.notifier).saveDraft();
    if (!mounted) return;
    Navigator.pop(context);
  }
}

class _AuthorLine extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final user = ref.watch(currentUserProvider).asData?.value;

    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: scheme.primary.withValues(alpha: 0.2),
          foregroundImage:
              user?.avatarUrl == null ? null : NetworkImage(user!.avatarUrl!),
          child: Icon(Iconsax.user, size: 18, color: scheme.primary),
        ),
        const SizedBox(width: SpacingTokens.space12),
        Expanded(
          child: Text(
            user?.displayName ?? 'Posting as you',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const _ErrorBanner({required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      color: scheme.errorContainer,
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space16,
        vertical: SpacingTokens.space12,
      ),
      child: Row(
        children: [
          Icon(Iconsax.warning_2, size: 18, color: scheme.onErrorContainer),
          const SizedBox(width: SpacingTokens.space8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 13,
                color: scheme.onErrorContainer,
              ),
            ),
          ),
          if (onRetry != null)
            TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
