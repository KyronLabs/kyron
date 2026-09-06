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
import '../utils/media_basket.dart';
import '../widgets/media_tray.dart';
import '../widgets/toast.dart';

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
  late final MediaBasket _media = MediaBasket(ref.read(feedRepositoryProvider))
    ..addListener(_onMedia);
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

  Future<void> _post() async {
    if (!_canPost) return;
    setState(() => _posting = true);
    unawaited(HapticFeedback.mediumImpact());
    try {
      await ref.read(communitiesRepositoryProvider).post(
            widget.community.slug,
            _box.text.trim(),
            media: _media.ready,
          );
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Close',
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text('Post in ${widget.community.name}'),
        titleSpacing: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: SpacingTokens.space8),
            child: FilledButton(
              onPressed: _canPost ? _post : null,
              child: _posting
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(SpacingTokens.space16),
                child: TextField(
                  controller: _box,
                  focusNode: _focus,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                  decoration: InputDecoration(
                    hintText: 'Say something to ${widget.community.name}',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            if (_media.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space16,
                ),
                child: MediaTray(
                  media: _media.items,
                  onRemove: _media.remove,
                  onRetry: _media.retry,
                  onDescribe: (item) =>
                      _media.describe(item.path, item.alt ?? ''),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SpacingTokens.space8,
                0,
                SpacingTokens.space16,
                0,
              ),
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'Add a photo',
                    onPressed:
                        _media.hasRoom ? () => _attach(video: false) : null,
                    icon: const Icon(Iconsax.gallery_copy, size: 20),
                  ),
                  IconButton(
                    tooltip: 'Add a clip',
                    onPressed:
                        _media.hasRoom ? () => _attach(video: true) : null,
                    icon: const Icon(Iconsax.video_copy, size: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SpacingTokens.space16,
                0,
                SpacingTokens.space16,
                SpacingTokens.space12,
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.people_copy,
                    size: 14,
                    color: scheme.onSurface.withValues(alpha: 0.55),
                  ),
                  const SizedBox(width: SpacingTokens.space4),
                  Expanded(
                    child: Text(
                      'Only members of ${widget.community.name} see this.',
                      style: TextStyle(
                        fontSize: 12,
                        color: scheme.onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                  ),
                  // Only once it is worth watching. A counter from character
                  // one is noise.
                  if (_count > _maxCharacters - 300)
                    Text(
                      '${_maxCharacters - _count}',
                      style: TextStyle(
                        fontSize: 12,
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
