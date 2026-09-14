import 'package:kyron_app/models/composer_model.dart';
import 'package:kyron_app/models/composer_poll.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/services/draft_service.dart';
import 'package:sqflite/sqflite.dart';

/// A draft store in memory, so the composer can be tested without a database.
class FakeDrafts implements DraftService {
  ComposerDraft? held;
  int writes = 0;
  int deletes = 0;

  /// How long a read takes. Non-zero stands in for sqflite, which goes over a
  /// platform channel and is never done within the first frame.
  Duration readDelay = Duration.zero;

  /// In memory, so there is always somewhere to put a draft.
  @override
  bool get isAvailable => true;

  @override
  String? currentDraftId;

  @override
  Future<void> saveDraft({
    required String content,
    ReplyPolicy replyPolicy = ReplyPolicy.everyone,
    ComposerPoll? poll,
    List<String> topics = const [],
    QuotedPost? quoting,
  }) async {
    writes++;
    currentDraftId ??= 'd1';
    held = ComposerDraft(
      id: currentDraftId,
      content: content,
      replyPolicy: replyPolicy,
      poll: poll,
      topics: topics,
      quoting: quoting,
      createdAt: DateTime(2026, 9, 8),
      updatedAt: DateTime(2026, 9, 8),
    );
  }

  @override
  Future<ComposerDraft?> getLatestDraft() async {
    if (readDelay > Duration.zero) await Future<void>.delayed(readDelay);
    return held;
  }

  @override
  Future<List<ComposerDraft>> allDrafts() async => held == null ? [] : [held!];

  @override
  Future<int> count() async => held == null ? 0 : 1;

  @override
  Future<void> deleteDraft(String id) async {
    deletes++;
    held = null;
    currentDraftId = null;
  }

  @override
  Future<void> clearAllDrafts() async {
    held = null;
    currentDraftId = null;
  }

  @override
  Future<Database> get database => throw UnimplementedError();
}
