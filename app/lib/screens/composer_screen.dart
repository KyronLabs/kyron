// lib/screens/composer_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/feed_post.dart';
import '../models/post_media.dart';
import '../providers/composer_provider.dart';
import '../providers/current_user_provider.dart';
import '../routes.dart';
import '../services/draft_service.dart';
import '../widgets/create_post/char_counter.dart';
import '../widgets/create_post/url_preview.dart';
import '../widgets/draft_sheet.dart';
import '../widgets/gif_picker_sheet.dart';
import '../widgets/interaction_settings_sheet.dart';
import '../widgets/media_tray.dart';
import '../widgets/quoted_post_card.dart';

/// Writing a post.
///
/// The screen this replaces had a ribbon of five controls, of which one did
/// anything: privacy and scheduling the API has never accepted, an AI Assist
/// panel that opened a "coming soon" card, a media picker whose attachments
/// were dropped on send, and hashtag, mention and voice buttons that were
/// empty TODOs. The Post button itself slept for a second, printed to the
/// console and cleared the box without writing anything.
class ComposerScreen extends ConsumerStatefulWidget {
  /// Set when the composer was opened to quote a post.
  final QuotedPost? quoting;

  const ComposerScreen({super.key, this.quoting});

  @override
  ConsumerState<ComposerScreen> createState() => _ComposerScreenState();
}

class _ComposerScreenState extends ConsumerState<ComposerScreen> {
  late final TextEditingController _textController;
  final FocusNode _focusNode = FocusNode();

  int _draftCount = 0;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final quoting = widget.quoting;
      if (quoting != null) {
        ref.read(composerProvider.notifier).quote(quoting);
      }

      // The provider may already hold a restored draft.
      final content = ref.read(composerProvider).content;
      if (content.isNotEmpty && _textController.text.isEmpty) {
        _textController.value = TextEditingValue(
          text: content,
          selection: TextSelection.collapsed(offset: content.length),
        );
      }
      _focusNode.requestFocus();
      _countDrafts();
    });
  }

  Future<void> _countDrafts() async {
    final count = await DraftService().count();
    if (mounted) setState(() => _draftCount = count);
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
          // Tight against the close button. The default leading width leaves a
          // gap wide enough to read as an indent.
          leadingWidth: 40,
          titleSpacing: 0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Close',
            onPressed: _close,
          ),
          title: Text(state.quoting == null ? 'New post' : 'Quote post'),
          actions: [
            _DraftsButton(count: _draftCount, onTap: _openDrafts),
            const SizedBox(width: SpacingTokens.space4),
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
                      const SizedBox(height: SpacingTokens.space8),
                      _InteractionButton(policy: state.replyPolicy),
                      const SizedBox(height: SpacingTokens.space8),
                      _composerField(scheme),
                      MediaTray(
                        media: state.media,
                        onRemove:
                            ref.read(composerProvider.notifier).removeMedia,
                        onRetry: ref.read(composerProvider.notifier).retryMedia,
                        onDescribe: _describe,
                      ),
                      if (state.quoting != null) ...[
                        const SizedBox(height: SpacingTokens.space12),
                        QuotedPostCard(post: state.quoting!),
                      ],
                      const UrlPreview(),
                    ],
                  ),
                ),
              ),
              const CharCounter(),
              _toolbar(scheme, state),
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
      minLines: 4,
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

  Widget _toolbar(ColorScheme scheme, ComposerState state) {
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
          _tool(
            icon: Iconsax.gallery_copy,
            tooltip: 'Add a photo',
            enabled: state.canAddMedia,
            onTap: () => _addMedia(video: false),
          ),
          _tool(
            icon: Iconsax.video_copy,
            tooltip: 'Add a video',
            enabled: state.canAddMedia,
            onTap: () => _addMedia(video: true),
          ),
          _tool(
            icon: Iconsax.emoji_happy_copy,
            tooltip: 'Add a GIF',
            enabled: state.canAddMedia,
            onTap: _addGif,
          ),
          const VerticalDivider(indent: 14, endIndent: 14, width: 8),
          _tool(
            icon: Iconsax.hashtag_copy,
            tooltip: 'Add a hashtag',
            onTap: () => _insert('#'),
          ),
          _tool(
            icon: Iconsax.tag_user_copy,
            tooltip: 'Mention someone',
            onTap: () => _insert('@'),
          ),
        ],
      ),
    );
  }

  Widget _tool({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    bool enabled = true,
  }) {
    return IconButton(
      icon: Icon(icon, size: 20),
      tooltip: tooltip,
      onPressed: enabled ? onTap : null,
    );
  }

  Future<void> _addMedia({required bool video}) async {
    final message =
        await ref.read(composerProvider.notifier).addMedia(video: video);
    if (message != null && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _addGif() async {
    final path = await GifPickerSheet.show(context);
    if (path == null || !mounted) return;
    await ref.read(composerProvider.notifier).attachFile(path, MediaKind.gif);
  }

  Future<void> _describe(PendingMedia item) async {
    final alt = await askForAltText(context, item.alt);
    if (alt == null || !mounted) return;
    ref.read(composerProvider.notifier).describeMedia(item.path, alt);
  }

  Future<void> _openDrafts() async {
    await Navigator.pushNamed(context, Routes.drafts);
    if (!mounted) return;

    // The drafts screen may have loaded one into the composer.
    final content = ref.read(composerProvider).content;
    _textController.value = TextEditingValue(
      text: content,
      selection: TextSelection.collapsed(offset: content.length),
    );
    await _countDrafts();
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

  /// Closing with something written offers to keep it. Closing straight away
  /// throws away what was typed; refusing to close is worse.
  Future<void> _close() async {
    final notifier = ref.read(composerProvider.notifier);
    if (!ref.read(composerProvider).hasContent) {
      notifier.clear();
      if (mounted) Navigator.pop(context);
      return;
    }

    final choice = await DraftSheet.show(context);
    if (!mounted) return;

    switch (choice) {
      case DraftChoice.keepEditing:
        return;
      case DraftChoice.save:
        await notifier.saveDraft();
        notifier.clear();
        if (!mounted) return;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Draft saved')),
        );
      case DraftChoice.discard:
        await notifier.discardDraft();
        if (mounted) Navigator.pop(context);
    }
  }
}

/// The reply setting, as a chip under the author line.
class _InteractionButton extends ConsumerWidget {
  final ReplyPolicy policy;

  const _InteractionButton({required this.policy});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () async {
        final chosen = await InteractionSettingsSheet.show(context, policy);
        if (chosen != null) {
          ref.read(composerProvider.notifier).setReplyPolicy(chosen);
        }
      },
      borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: scheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Iconsax.global_copy, size: 14, color: scheme.primary),
            const SizedBox(width: SpacingTokens.space4),
            Text(
              policy.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: scheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DraftsButton extends StatelessWidget {
  final int count;
  final VoidCallback onTap;

  const _DraftsButton({required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: scheme.onSurface.withValues(alpha: 0.8),
        padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        count == 0 ? 'Drafts' : 'Drafts ($count)',
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
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
          child: Icon(Iconsax.user_copy, size: 18, color: scheme.primary),
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
          Icon(Iconsax.warning_2_copy,
              size: 18, color: scheme.onErrorContainer),
          const SizedBox(width: SpacingTokens.space8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(fontSize: 13, color: scheme.onErrorContainer),
            ),
          ),
          if (onRetry != null)
            TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
