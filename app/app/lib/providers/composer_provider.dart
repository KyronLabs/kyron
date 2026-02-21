import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/composer_model.dart';
import '../services/draft_service.dart';

final composerProvider = StateNotifierProvider<ComposerNotifier, ComposerState>(
  (ref) => ComposerNotifier(DraftService()),
);

class ComposerState {
  final String content;
  final String privacy;
  final DateTime? scheduledAt;
  final List<String> mediaPaths;
  final bool isPosting;
  final bool hasUnsavedChanges;
  final String placeholderText;

  ComposerState({
    required this.content,
    required this.privacy,
    this.scheduledAt,
    this.mediaPaths = const [],
    this.isPosting = false,
    this.hasUnsavedChanges = false,
    required this.placeholderText,
  });

  ComposerState copyWith({
    String? content,
    String? privacy,
    DateTime? scheduledAt,
    List<String>? mediaPaths,
    bool? isPosting,
    bool? hasUnsavedChanges,
    String? placeholderText,
  }) {
    return ComposerState(
      content: content ?? this.content,
      privacy: privacy ?? this.privacy,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      mediaPaths: mediaPaths ?? this.mediaPaths,
      isPosting: isPosting ?? this.isPosting,
      hasUnsavedChanges: hasUnsavedChanges ?? this.hasUnsavedChanges,
      placeholderText: placeholderText ?? this.placeholderText,
    );
  }

  bool get canPost => content.trim().isNotEmpty && !isPosting;
  int get charCount => content.characters.length;
  double get charProgress => (charCount / 1000).clamp(0.0, 1.0);
}

class ComposerNotifier extends StateNotifier<ComposerState> {
  final DraftService _draftService;
  Timer? _placeholderTimer;

  ComposerNotifier(this._draftService) 
    : super(ComposerState(
        content: '',
        privacy: 'Public',
        placeholderText: _getRandomPlaceholder(),
      )) {
    _loadDraft();
  }

  static final _placeholders = [
    "What's rattling around your head?",
    "Say something only you can say…",
    "Drop a hot take (or a warm one)",
    "This is your signal — send it",
    "Type, speak, or think-out-loud",
  ];

  static String _getRandomPlaceholder() {
    return _placeholders[DateTime.now().millisecondsSinceEpoch % _placeholders.length];
  }

  void rotatePlaceholder() {
    state = state.copyWith(placeholderText: _getRandomPlaceholder());
  }

  void startPlaceholderRotation() {
    _placeholderTimer?.cancel();
    _placeholderTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      rotatePlaceholder();
    });
  }

  void stopPlaceholderRotation() {
    _placeholderTimer?.cancel();
  }

  Future<void> _loadDraft() async {
    final draft = await _draftService.getLatestDraft();
    if (draft != null && draft.content.trim().isNotEmpty) {
      state = state.copyWith(
        content: draft.content,
        privacy: draft.privacy,
        scheduledAt: draft.scheduledAt,
        mediaPaths: draft.mediaPaths,
        hasUnsavedChanges: true,
      );
    }
  }

  void updateContent(String value) {
    HapticFeedback.selectionClick();
    state = state.copyWith(
      content: value,
      hasUnsavedChanges: true,
    );
  }

  void setPrivacy(String privacy) {
    state = state.copyWith(privacy: privacy);
    HapticFeedback.lightImpact();
  }

  void toggleSchedule() {
    if (state.scheduledAt == null) {
      state = state.copyWith(scheduledAt: DateTime.now().add(const Duration(minutes: 30)));
    } else {
      state = state.copyWith(scheduledAt: null);
    }
    HapticFeedback.lightImpact();
  }

  void setSchedule(DateTime? dateTime) {
    state = state.copyWith(scheduledAt: dateTime);
  }

  Future<void> post() async {
  if (!state.canPost) return;
  
  state = state.copyWith(isPosting: true);
  HapticFeedback.mediumImpact();

  try {
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('Posted: ${state.content} | Privacy: ${state.privacy} | Scheduled: ${state.scheduledAt}');
    
    // Use the public getter
    await _draftService.deleteDraft(_draftService.currentDraftId ?? '');
    
    state = ComposerState(
      content: '',
      privacy: 'Public',
      placeholderText: _getRandomPlaceholder(),
    );
  } catch (e) {
    debugPrint('Post failed: $e');
    state = state.copyWith(isPosting: false);
    rethrow;
  }
 }

  void addMedia(String path) {
    state = state.copyWith(mediaPaths: [...state.mediaPaths, path]);
  }

  void removeMedia(String path) {
    state = state.copyWith(mediaPaths: state.mediaPaths.where((p) => p != path).toList());
  }

  @override
  void dispose() {
    _placeholderTimer?.cancel();
    super.dispose();
  }
}