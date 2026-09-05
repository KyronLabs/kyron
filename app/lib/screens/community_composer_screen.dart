// lib/screens/community_composer_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/community.dart';
import '../providers/communities_provider.dart';
import '../utils/api_error_message.dart';
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
  bool _posting = false;

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
    _box.dispose();
    _focus.dispose();
    super.dispose();
  }

  int get _count => _box.text.characters.length;

  bool get _canPost =>
      _box.text.trim().isNotEmpty && _count <= _maxCharacters && !_posting;

  Future<void> _post() async {
    if (!_canPost) return;
    setState(() => _posting = true);
    unawaited(HapticFeedback.mediumImpact());
    try {
      await ref
          .read(communitiesRepositoryProvider)
          .post(widget.community.slug, _box.text.trim());
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
