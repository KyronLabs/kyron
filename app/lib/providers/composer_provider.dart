import 'dart:async';

import 'package:characters/characters.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/feed_post.dart';
import '../services/app_log.dart';
import '../services/draft_service.dart';
import '../utils/api_error_message.dart';
import 'feed_provider.dart';

final composerProvider = StateNotifierProvider<ComposerNotifier, ComposerState>(
  (ref) => ComposerNotifier(ref, DraftService()),
);

class ComposerState {
  final String content;
  final bool isPosting;
  final bool hasUnsavedChanges;
  final String placeholderText;

  /// Set when the last attempt to post failed, so the screen can say why
  /// rather than clearing the box and hoping.
  final String? error;

  const ComposerState({
    required this.content,
    this.isPosting = false,
    this.hasUnsavedChanges = false,
    required this.placeholderText,
    this.error,
  });

  /// The server's limit. Named here so the field, the counter and the check
  /// below cannot disagree about it.
  static const maxCharacters = 1000;

  ComposerState copyWith({
    String? content,
    bool? isPosting,
    bool? hasUnsavedChanges,
    String? placeholderText,
    String? error,
    bool clearError = false,
  }) {
    return ComposerState(
      content: content ?? this.content,
      isPosting: isPosting ?? this.isPosting,
      hasUnsavedChanges: hasUnsavedChanges ?? this.hasUnsavedChanges,
      placeholderText: placeholderText ?? this.placeholderText,
      error: clearError ? null : (error ?? this.error),
    );
  }

  int get charCount => content.characters.length;

  double get charProgress => (charCount / maxCharacters).clamp(0.0, 1.0);

  bool get isOverLimit => charCount > maxCharacters;

  bool get canPost => content.trim().isNotEmpty && !isPosting && !isOverLimit;
}

class ComposerNotifier extends StateNotifier<ComposerState> {
  final Ref _ref;
  final DraftService _draftService;
  Timer? _placeholderTimer;

  ComposerNotifier(this._ref, this._draftService)
      : super(ComposerState(
          content: '',
          placeholderText: _randomPlaceholder(),
        )) {
    _loadDraft();
  }

  static final _placeholders = [
    "What's rattling around your head?",
    'Say something only you can say…',
    'Drop a hot take (or a warm one)',
    'This is your signal — send it',
    'Type, speak, or think-out-loud',
  ];

  static String _randomPlaceholder() => _placeholders[
      DateTime.now().millisecondsSinceEpoch % _placeholders.length];

  void rotatePlaceholder() {
    state = state.copyWith(placeholderText: _randomPlaceholder());
  }

  void startPlaceholderRotation() {
    _placeholderTimer?.cancel();
    _placeholderTimer =
        Timer.periodic(const Duration(seconds: 10), (_) => rotatePlaceholder());
  }

  void stopPlaceholderRotation() => _placeholderTimer?.cancel();

  Future<void> _loadDraft() async {
    final draft = await _draftService.getLatestDraft();
    if (draft != null && draft.content.trim().isNotEmpty) {
      state = state.copyWith(
        content: draft.content,
        hasUnsavedChanges: true,
      );
    }
  }

  void updateContent(String value) {
    // No haptic here. This fires on every keystroke, so typing a sentence buzzed
    // the handset forty times.
    state = state.copyWith(
      content: value,
      hasUnsavedChanges: true,
      clearError: true,
    );
  }

  /// Publishes the post and puts it at the top of the feed.
  ///
  /// This used to sleep for a second, print the content to the debug console
  /// and clear the box. The Post button reported success every time and no
  /// post was ever written -- which is why the feed stayed empty however much
  /// people typed into it.
  Future<bool> post() async {
    if (!state.canPost) return false;

    state = state.copyWith(isPosting: true, clearError: true);
    HapticFeedback.mediumImpact();

    try {
      final FeedPost created =
          await _ref.read(feedRepositoryProvider).create(state.content.trim());

      // Straight to the top of the feed, so the post is visible the moment
      // the screen closes rather than after the next refresh.
      _ref
          .read(postListProvider(PostListSource.recent).notifier)
          .prepend(created);

      final draftId = _draftService.currentDraftId;
      if (draftId != null) await _draftService.deleteDraft(draftId);

      state = ComposerState(
        content: '',
        placeholderText: _randomPlaceholder(),
      );
      return true;
    } catch (e) {
      final message = describeApiError(e, sessionIsLive: true);
      AppLog.instance.error('composer', 'Post failed: $message');
      // The text stays put. Losing what someone wrote because the network
      // blinked is worse than the failure itself.
      state = state.copyWith(isPosting: false, error: message);
      return false;
    }
  }

  /// Keeps what is typed so it survives leaving the screen.
  Future<void> saveDraft() async {
    if (state.content.trim().isEmpty) return;
    await _draftService.saveDraft(content: state.content);
  }

  void clear() {
    state = ComposerState(
      content: '',
      placeholderText: _randomPlaceholder(),
    );
  }

  @override
  void dispose() {
    _placeholderTimer?.cancel();
    super.dispose();
  }
}
