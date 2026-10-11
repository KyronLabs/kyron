import '../l10n/app_localizations.dart';

// lib/screens/community_composer_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/community.dart';
import '../providers/communities_provider.dart';
import '../providers/feed_provider.dart' show feedRepositoryProvider;
import '../utils/api_error_message.dart';
import '../providers/composer_provider.dart' show ComposerState;
import '../utils/media_basket.dart';
import '../utils/mention_token.dart';
import '../widgets/hairline.dart';
import '../widgets/media_tray.dart';
import '../widgets/mention_picker_sheet.dart';
import '../widgets/toast.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/action_button.dart';

/// Writes a post into one community.
///
/// Its own screen rather than the main composer with a community attached: the
/// main composer carries a draft, a poll, a quote and a topic picker, none of
/// which mean the same thing here, and hiding half of it would be a composer
/// that behaves differently depending on how you got to it.
class CommunityComposerScreen extends ConsumerStatefulWidget {
  final Community community;

  const CommunityComposerScreen({super.key, required this.community});

  @override
  ConsumerState<CommunityComposerScreen> createState() =>
      _CommunityComposerScreenState();
}

class _CommunityComposerScreenState
    extends ConsumerState<CommunityComposerScreen> {
  final TextEditingController _box = TextEditingController();
  final FocusNode _focus = FocusNode();
  // A community post is a post, and carries as many.
  late final MediaBasket _media = MediaBasket(
    ref.read(feedRepositoryProvider),
    limit: ComposerState.maxMedia,
  )..addListener(_onMedia);
  bool _posting = false;

  void _onMedia() => setState(() {});

  /// The server's limit, named here so the counter and the check agree.
  static const int _maxCharacters = 3000;

  @override
  void initState() {
    super.initState();
    _box.addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) => _focus.requestFocus());
  }

  @override
  void dispose() {
    _media.removeListener(_onMedia);
    _media.dispose();
    _box.dispose();
    _focus.dispose();
    super.dispose();
  }

  int get _count => _box.text.characters.length;

  bool get _canPost =>
      // A picture with no words is a post; an empty box is not. Never while
      // an upload is still going, or the server is sent a file it does not
      // have yet.
      (_box.text.trim().isNotEmpty || _media.ready.isNotEmpty) &&
      _count <= _maxCharacters &&
      !_posting &&
      !_media.isUploading;

  Future<void> _attach({required bool video}) async {
    final message = await _media.attach(video: video);
    if (message != null && mounted) Toast.show(context, message);
  }

  /// Finds somebody and writes their handle in, replacing the mention being
  /// typed if the caret is in one.
  Future<void> _tagSomeone() async {
    final value = _box.value;
    final caret =
        value.selection.isValid ? value.selection.end : value.text.length;
    final typing = mentionAt(value.text, caret);

    final handle = await MentionPickerSheet.show(
      context,
      initialQuery: typing?.query ?? '',
    );
    if (handle == null || !mounted) return;

    _box.value = insertMention(_box.value, handle);
    _focus.requestFocus();
  }

  Future<void> _post() async {
    if (!_canPost) return;
    setState(() => _posting = true);
    unawaited(HapticFeedback.mediumImpact());
    try {
      await ref
          .read(communitiesRepositoryProvider)
          .post(widget.community.slug, _box.text.trim(), media: _media.ready);
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;
      setState(() => _posting = false);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final over = _count > _maxCharacters;

    return Scaffold(
      appBar: KyronAppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.close_circle_copy),
          tooltip: 'Close',
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text('Post in ${widget.community.name}'),
        titleSpacing: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: SpacingTokens.space8),
            // The same fix as the main composer's, for the same reason: the
            // design system's button themes carry an infinite-width minimum,
            // which an app bar's actions row cannot satisfy, so this button
            // was never drawn either.
            child: ActionButton(
              label: AppLocalizations.of(context).post,
              compact: true,
              busy: _posting,
              onPressed: _canPost ? _post : null,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Words, then whatever is attached to them, then nothing. The
            // pictures used to be pinned to the foot of the screen under a
            // box the height of four lines, so a post with one photo was a
            // short line at the top, a photo at the bottom and a screen of
            // nothing between them.
            Expanded(
              child: GestureDetector(
                // Anywhere in the blank space below puts the caret in the box,
                // which is what tapping a page you are writing on means.
                behavior: HitTestBehavior.translucent,
                onTap: _focus.requestFocus,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    SpacingTokens.space16,
                    SpacingTokens.space8,
                    SpacingTokens.space16,
                    SpacingTokens.space16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Who will see it, before it is written rather than
                      // under the toolbar after.
                      Row(
                        children: [
                          Icon(
                            Iconsax.people_copy,
                            size: 14,
                            color: scheme.onSurface.withValues(alpha: 0.55),
                          ),
                          const SizedBox(width: SpacingTokens.space4),
                          Expanded(
                            child: Text(
                              'Only members of ${widget.community.name} see '
                              'this.',
                              style: TextStyle(
                                fontSize: TypographyTokens.fontSize1,
                                color: scheme.onSurface.withValues(alpha: 0.55),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: SpacingTokens.space12),
                      TextField(
                        controller: _box,
                        focusNode: _focus,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                        style: const TextStyle(
                          fontSize: TypographyTokens.fontSize4,
                          height: 1.4,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Say something to ${widget.community.name}',
                          hintStyle: TextStyle(
                            fontSize: TypographyTokens.fontSize4,
                            color: scheme.onSurface.withValues(alpha: 0.5),
                          ),
                          // Writing on the page, not filling in a form: no
                          // fill, and every border named, because naming only
                          // `border` leaves the theme's blue focus ring.
                          filled: false,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          isCollapsed: true,
                          contentPadding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                      if (_media.isNotEmpty) ...[
                        const SizedBox(height: SpacingTokens.space12),
                        MediaTray(
                          media: _media.items,
                          onRemove: _media.remove,
                          onRetry: _media.retry,
                          onDescribe: (item) =>
                              _media.describe(item.path, item.alt ?? ''),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            // The main composer's toolbar: on the keyboard, behind a hairline.
            Container(
              height: 52,
              decoration: BoxDecoration(
                border: Border(top: postRule(scheme)),
              ),
              padding: const EdgeInsets.only(
                left: SpacingTokens.space8,
                right: SpacingTokens.space16,
              ),
              child: Row(
                children: [
                  IconButton(
                    tooltip: AppLocalizations.of(context).literaladdAPhoto,
                    onPressed:
                        _media.hasRoom ? () => _attach(video: false) : null,
                    icon: const Icon(Iconsax.gallery_copy, size: 20),
                  ),
                  IconButton(
                    tooltip: AppLocalizations.of(context).literaladdAClip,
                    onPressed:
                        _media.hasRoom ? () => _attach(video: true) : null,
                    icon: const Icon(Iconsax.video_copy, size: 20),
                  ),
                  IconButton(
                    tooltip: AppLocalizations.of(context).literaltagSomeone,
                    onPressed: _tagSomeone,
                    icon: const Icon(Iconsax.tag_user_copy, size: 20),
                  ),
                  const Spacer(),
                  // Only once it is worth watching. A counter from character
                  // one is noise.
                  if (_count > _maxCharacters - 300)
                    Text(
                      '${_maxCharacters - _count}',
                      style: TextStyle(
                        fontSize: TypographyTokens.fontSize1,
                        fontWeight: FontWeight.w700,
                        color: over ? scheme.error : scheme.onSurface,
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
