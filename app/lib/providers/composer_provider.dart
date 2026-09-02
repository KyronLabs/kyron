import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:characters/characters.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';

import '../models/feed_post.dart';
import '../models/post_media.dart';
import '../services/app_log.dart';
import '../services/draft_service.dart';
import '../utils/api_error_message.dart';
import 'feed_provider.dart';
import '../models/composer_poll.dart';

final composerProvider = StateNotifierProvider<ComposerNotifier, ComposerState>(
  (ref) => ComposerNotifier(ref, DraftService()),
);

class ComposerState {
  final String content;
  final bool isPosting;
  final bool hasUnsavedChanges;
  final String placeholderText;

  /// Attachments chosen on the device, uploading or uploaded.
  final List<PendingMedia> media;

  /// Who may reply to the post being written.
  final ReplyPolicy replyPolicy;

  /// The post being quoted, if this composer was opened from one.
  final QuotedPost? quoting;

  /// The poll being attached, or null. A post carries at most one.
  final ComposerPoll? poll;

  /// Set when the last attempt to post failed, so the screen can say why
  /// rather than clearing the box and hoping.
  final String? error;

  const ComposerState({
    required this.content,
    this.isPosting = false,
    this.hasUnsavedChanges = false,
    required this.placeholderText,
    this.media = const [],
    this.replyPolicy = ReplyPolicy.everyone,
    this.quoting,
    this.poll,
    this.error,
  });

  /// The server's limit. Named here so the field, the counter and the check
  /// below cannot disagree about it.
  static const maxCharacters = 1000;

  /// How many attachments one post may carry, matching the server.
  static const maxMedia = 4;

  ComposerState copyWith({
    String? content,
    bool? isPosting,
    bool? hasUnsavedChanges,
    String? placeholderText,
    List<PendingMedia>? media,
    ReplyPolicy? replyPolicy,
    QuotedPost? quoting,
    ComposerPoll? poll,
    String? error,
    bool clearError = false,
    bool clearPoll = false,
  }) {
    return ComposerState(
      content: content ?? this.content,
      isPosting: isPosting ?? this.isPosting,
      hasUnsavedChanges: hasUnsavedChanges ?? this.hasUnsavedChanges,
      placeholderText: placeholderText ?? this.placeholderText,
      media: media ?? this.media,
      replyPolicy: replyPolicy ?? this.replyPolicy,
      quoting: quoting ?? this.quoting,
      poll: clearPoll ? null : (poll ?? this.poll),
      error: clearError ? null : (error ?? this.error),
    );
  }

  int get charCount => content.characters.length;

  double get charProgress => (charCount / maxCharacters).clamp(0.0, 1.0);

  bool get isOverLimit => charCount > maxCharacters;

  bool get hasMedia => media.isNotEmpty;

  bool get isUploading => media.any((m) => m.isUploading);

  /// True when there is something a draft would be worth keeping.
  bool get hasContent =>
      content.trim().isNotEmpty || media.isNotEmpty || poll != null;

  /// A poll takes the whole post: an answer people are meant to pick between
  /// should not be competing with four photographs above it.
  bool get canAddMedia => media.length < maxMedia && poll == null;

  bool get hasPoll => poll != null;

  /// Attachments that actually uploaded. Only these are sent.
  bool get hasReadyMedia => media.any((m) => m.isReady);

  /// True when an attachment failed and nothing else would go with it.
  bool get onlyFailedMedia =>
      content.trim().isEmpty && media.isNotEmpty && !hasReadyMedia;

  /// A post carrying only an attachment is a post; one that is empty and
  /// unattached is not, which is what the server enforces too.
  ///
  /// Checked against *uploaded* attachments, not chosen ones. With pictures
  /// that all failed to upload the old check saw content and enabled Post,
  /// which then sent no text and no media and came back "A post needs text
  /// or an attachment" -- naming a problem the composer was already showing
  /// on every tile.
  bool get canPost =>
      (content.trim().isNotEmpty || hasReadyMedia) &&
      // A poll needs a question above it and two answers under it, so the
      // Post button is inert until both are there rather than the server
      // rejecting it after the fact.
      (poll == null || (poll!.isComplete && content.trim().isNotEmpty)) &&
      !isPosting &&
      !isOverLimit &&
      !isUploading;
}

class ComposerNotifier extends StateNotifier<ComposerState> {
  final Ref _ref;
  final DraftService _draftService;
  final ImagePicker _picker = ImagePicker();
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
    // No haptic here. This fires on every keystroke, so typing a sentence
    // buzzed the handset forty times.
    state = state.copyWith(
      content: value,
      hasUnsavedChanges: true,
      clearError: true,
    );
  }

  void setReplyPolicy(ReplyPolicy policy) {
    HapticFeedback.selectionClick();
    state = state.copyWith(replyPolicy: policy, hasUnsavedChanges: true);
  }

  /// Opens the composer on a post being quoted.
  void quote(QuotedPost post) {
    state = state.copyWith(quoting: post);
  }

  // ---- Attachments --------------------------------------------------------

  /// Picks images or a video and starts uploading them straight away.
  ///
  /// Uploading as they are chosen rather than on send: a slow upload should
  /// happen while the post is still being written, not after the Post button
  /// has been pressed.
  Future<String?> addMedia({required bool video}) async {
    if (!state.canAddMedia) {
      return 'A post can carry at most ${ComposerState.maxMedia} attachments.';
    }

    try {
      final List<XFile> picked;
      if (video) {
        final clip = await _picker.pickVideo(
          source: ImageSource.gallery,
          // image_picker does not compress, so this is the only lever on how
          // big the file arrives. A minute of phone video is already close to
          // the server's limit.
          maxDuration: const Duration(minutes: 1),
        );
        picked = clip == null ? const [] : [clip];
      } else {
        picked = await _picker.pickMultiImage(
          limit: ComposerState.maxMedia - state.media.length,
        );
      }

      if (picked.isEmpty) return null;

      final room = ComposerState.maxMedia - state.media.length;
      for (final file in picked.take(room)) {
        await _attach(file, video: video);
      }
      return null;
    } catch (e) {
      AppLog.instance.error('composer', 'Could not pick media: $e');
      return 'Could not open your gallery.';
    }
  }

  /// Attaches something already downloaded, such as a chosen GIF.
  Future<void> attachFile(String path, MediaKind kind) async {
    await _attach(XFile(path), video: kind == MediaKind.video, kind: kind);
  }

  /// The server's limit, mirrored so an oversized file is refused here rather
  /// than after uploading it and being told 413.
  static const maxAttachmentBytes = 25 * 1024 * 1024;

  Future<void> _attach(XFile file,
      {required bool video, MediaKind? kind}) async {
    final resolved = kind ?? (video ? MediaKind.video : MediaKind.image);

    final bytes = await file.length();
    if (bytes > maxAttachmentBytes) {
      state = state.copyWith(
        media: [
          ...state.media,
          PendingMedia(
            path: file.path,
            kind: resolved,
            error: 'That file is larger than '
                '${maxAttachmentBytes ~/ (1024 * 1024)} MB.',
          ),
        ],
      );
      return;
    }

    // Measured here, where the image is already being decoded for the preview.
    // Doing it on the server would mean decoding untrusted image data there
    // for a number used only for layout.
    var width = 0;
    var height = 0;
    if (resolved != MediaKind.video) {
      final size = await _decodeSize(file.path);
      width = size.$1;
      height = size.$2;
    }

    final pending = PendingMedia(
      path: file.path,
      kind: resolved,
      width: width > 0 ? width : null,
      height: height > 0 ? height : null,
    );

    state = state.copyWith(
      media: [...state.media, pending],
      hasUnsavedChanges: true,
    );

    try {
      final uploaded =
          await _ref.read(feedRepositoryProvider).uploadMedia(pending);
      _replaceMedia(pending.path, uploaded);
    } catch (e) {
      _replaceMedia(
        pending.path,
        pending.copyWith(error: describeApiError(e, sessionIsLive: true)),
      );
      AppLog.instance.error('composer', 'Attachment upload failed: $e');
    }
  }

  Future<(int, int)> _decodeSize(String path) async {
    try {
      final bytes = await File(path).readAsBytes();
      final descriptor = await ui.instantiateImageCodec(bytes);
      final frame = await descriptor.getNextFrame();
      final size = (frame.image.width, frame.image.height);
      frame.image.dispose();
      descriptor.dispose();
      return size;
    } catch (_) {
      // Not fatal: without dimensions the grid falls back to a fixed box.
      return (0, 0);
    }
  }

  void removeMedia(String path) {
    state = state.copyWith(
      media: state.media.where((m) => m.path != path).toList(),
      hasUnsavedChanges: true,
    );
  }

  void describeMedia(String path, String alt) {
    state = state.copyWith(
      media: [
        for (final m in state.media) m.path == path ? m.copyWith(alt: alt) : m,
      ],
    );
  }

  /// Retries one failed upload without disturbing the others.
  Future<void> retryMedia(String path) async {
    final failed = state.media.where((m) => m.path == path).firstOrNull;
    if (failed == null) return;

    _replaceMedia(path, failed.copyWith(clearError: true));
    try {
      final uploaded =
          await _ref.read(feedRepositoryProvider).uploadMedia(failed);
      _replaceMedia(path, uploaded);
    } catch (e) {
      _replaceMedia(
        path,
        failed.copyWith(error: describeApiError(e, sessionIsLive: true)),
      );
    }
  }

  void _replaceMedia(String path, PendingMedia updated) {
    state = state.copyWith(
      media: [
        for (final m in state.media) m.path == path ? updated : m,
      ],
    );
  }

  // ---- Sending ------------------------------------------------------------

  /// Publishes the post and puts it at the top of the feed.
  ///
  /// This used to sleep for a second, print the content to the debug console
  /// and clear the box. The Post button reported success every time and no
  /// post was ever written.
  /// Attaches a blank poll, or removes the one already there.
  ///
  /// Removing does not ask: nothing has been posted, and the answers are two
  /// short strings that are quick to retype. Attaching one clears any
  /// attachments, because a post carries either.
  void togglePoll() {
    if (state.poll != null) {
      state = state.copyWith(clearPoll: true, hasUnsavedChanges: true);
      return;
    }
    state = state.copyWith(
      poll: ComposerPoll.blank(),
      media: const [],
      hasUnsavedChanges: true,
    );
  }

  void setPoll(ComposerPoll poll) {
    state = state.copyWith(poll: poll, hasUnsavedChanges: true);
  }

  Future<bool> post() async {
    if (!state.canPost) return false;

    state = state.copyWith(isPosting: true, clearError: true);
    HapticFeedback.mediumImpact();

    try {
      final FeedPost created = await _ref.read(feedRepositoryProvider).create(
            state.content.trim(),
            media: state.media,
            quotedPostId: state.quoting?.id,
            replyPolicy: state.replyPolicy,
            poll: state.poll,
          );

      // Straight to the top of the feed, so the post is visible the moment
      // the screen closes rather than after the next refresh.
      _ref
          .read(postListProvider(PostListSource.recent).notifier)
          .prepend(created);

      final draftId = _draftService.currentDraftId;
      if (draftId != null) await _draftService.deleteDraft(draftId);

      clear();
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
  ///
  /// Attachments are not kept: they live in a cache directory the system may
  /// clear, so a restored draft would point at files that are no longer there.
  Future<void> saveDraft() async {
    if (state.content.trim().isEmpty) return;
    await _draftService.saveDraft(content: state.content);
  }

  Future<void> discardDraft() async {
    final id = _draftService.currentDraftId;
    if (id != null) await _draftService.deleteDraft(id);
    clear();
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
