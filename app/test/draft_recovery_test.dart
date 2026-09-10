import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/composer_model.dart';
import 'package:kyron_app/models/composer_poll.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/providers/composer_provider.dart';
import 'package:kyron_app/services/draft_service.dart';
import 'package:sqflite/sqflite.dart';

final _quoted = QuotedPost(
  id: 'q1',
  content: 'the post being quoted',
  createdAt: DateTime(2026, 9, 7),
  author: const FeedAuthor(id: 'u2', username: 'ada', name: 'Ada'),
);

ComposerDraft _draft({
  String content = 'half a thought',
  ReplyPolicy replyPolicy = ReplyPolicy.everyone,
  ComposerPoll? poll,
  List<String> topics = const [],
  QuotedPost? quoting,
}) =>
    ComposerDraft(
      id: 'd1',
      content: content,
      replyPolicy: replyPolicy,
      poll: poll,
      topics: topics,
      quoting: quoting,
      createdAt: DateTime(2026, 9, 8),
      updatedAt: DateTime(2026, 9, 8),
    );

/// A draft store in memory, so the composer can be tested without a database.
class _FakeDrafts implements DraftService {
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

void main() {
  // The reply-setting and poll buttons buzz the handset, which needs the
  // services binding even when nothing is being rendered.
  TestWidgetsFlutterBinding.ensureInitialized();
  group('a saved draft', () {
    /// What sqflite hands back: a map with the payload as a JSON string.
    Map<String, Object?> stored(ComposerDraft draft) => draft.toMap();

    test('keeps the poll somebody filled in', () {
      // Saving used to write the text and nothing else, so a poll went into
      // the draft sheet and came back out as a bare sentence.
      final poll = const ComposerPoll(
        options: ['tabs', 'spaces', ''],
        durationMinutes: 360,
      );

      final back = ComposerDraft.fromMap(stored(_draft(poll: poll)));

      expect(back.poll, isNotNull);
      // The answers as typed, blank one included: a draft is saved mid-edit,
      // and dropping the empty box takes away the one being typed into.
      expect(back.poll!.options, ['tabs', 'spaces', '']);
      expect(back.poll!.durationMinutes, 360);
    });

    test('keeps who was allowed to reply', () {
      final back = ComposerDraft.fromMap(
        stored(_draft(replyPolicy: ReplyPolicy.followers)),
      );

      expect(back.replyPolicy, ReplyPolicy.followers);
    });

    test('keeps the topics it was filed under', () {
      final back =
          ComposerDraft.fromMap(stored(_draft(topics: ['tech', 'design'])));

      expect(back.topics, ['tech', 'design']);
    });

    test('keeps the post it was quoting, whole', () {
      // By id alone it would need a network the composer may not have, and a
      // restored quote-post without its quote is a different post.
      final back = ComposerDraft.fromMap(stored(_draft(quoting: _quoted)));

      expect(back.quoting?.id, 'q1');
      expect(back.quoting?.content, 'the post being quoted');
      expect(back.quoting?.author.username, 'ada');
    });

    test('reads a row written before any of this existed', () {
      // An install upgrading has rows with no payload column. They are still
      // somebody's unsent post.
      final back = ComposerDraft.fromMap({
        'id': 'old',
        'content': 'written last week',
        'privacy': '',
        'scheduledAt': null,
        'mediaPaths': '[]',
        'createdAt': '2026-09-01T10:00:00.000',
        'updatedAt': '2026-09-01T10:00:00.000',
      });

      expect(back.content, 'written last week');
      expect(back.poll, isNull);
      expect(back.replyPolicy, ReplyPolicy.everyone);
    });

    test('keeps the words when the extras will not parse', () {
      final back = ComposerDraft.fromMap({
        'id': 'broken',
        'content': 'still worth keeping',
        'payload': '{not json',
        'createdAt': '2026-09-01T10:00:00.000',
        'updatedAt': '2026-09-01T10:00:00.000',
      });

      expect(back.content, 'still worth keeping');
      expect(back.poll, isNull);
    });

    test('counts a poll with no question as worth keeping', () {
      expect(_draft(content: '  ').hasContent, isFalse);
      expect(
        _draft(content: '  ', poll: ComposerPoll.blank()).hasContent,
        isTrue,
      );
    });
  });

  group('the composer', () {
    ({ComposerNotifier notifier, _FakeDrafts drafts}) composer() {
      final drafts = _FakeDrafts();
      final container = ProviderContainer(
        overrides: [draftServiceProvider.overrideWithValue(drafts)],
      );
      addTearDown(container.dispose);

      final probe = Provider<ComposerNotifier>(
        (ref) => ComposerNotifier(
          ref,
          drafts,
          autosaveDelay: const Duration(milliseconds: 10),
        ),
      );
      return (notifier: container.read(probe), drafts: drafts);
    }

    /// Long enough for the shortened debounce above to have fired.
    Future<void> settle() =>
        Future<void>.delayed(const Duration(milliseconds: 40));

    test('writes what was typed without being asked', () async {
      // Saving only on the way out meant the app being killed with the
      // composer open lost everything, and a phone taking a call is not rare.
      final c = composer();
      await pumpEventQueue();

      c.notifier.updateContent('a thought');
      await settle();

      expect(c.drafts.held?.content, 'a thought');
    });

    test('writes once for a sentence, not once per keystroke', () async {
      final c = composer();
      await pumpEventQueue();

      for (final text in ['a', 'a t', 'a th', 'a thought']) {
        c.notifier.updateContent(text);
      }
      await settle();

      expect(c.drafts.writes, 1);
      expect(c.drafts.held?.content, 'a thought');
    });

    test('writes nothing at all when nothing was written', () async {
      final c = composer();
      await pumpEventQueue();
      await settle();

      // The loop this replaces wrote on a three-second tick whether or not
      // anything had changed.
      expect(c.drafts.writes, 0);
    });

    test('writes on demand when the app is going away', () async {
      // The debounce has not fired yet, and a backgrounded process can be
      // killed without warning.
      final c = composer();
      await pumpEventQueue();
      c.notifier.updateContent('mid-sentence');

      await c.notifier.flushDraft();

      expect(c.drafts.held?.content, 'mid-sentence');
    });

    test('has nothing to flush when nothing changed', () async {
      final c = composer();
      await pumpEventQueue();

      await c.notifier.flushDraft();

      expect(c.drafts.writes, 0);
    });

    test('saves the poll and the topics, not just the words', () async {
      final c = composer();
      await pumpEventQueue();

      c.notifier.updateContent('tabs or spaces?');
      c.notifier.togglePoll();
      c.notifier.toggleTopic('tech');
      c.notifier.setReplyPolicy(ReplyPolicy.followers);
      await settle();

      expect(c.drafts.held?.poll, isNotNull);
      expect(c.drafts.held?.topics, ['tech']);
      expect(c.drafts.held?.replyPolicy, ReplyPolicy.followers);
    });

    test('restores the whole draft, not only its words', () async {
      final c = composer();
      await pumpEventQueue();

      c.notifier.restore(_draft(
        content: 'half a thought',
        poll: ComposerPoll.blank(),
        topics: ['design'],
        replyPolicy: ReplyPolicy.mentioned,
        quoting: _quoted,
      ));

      expect(c.notifier.state.content, 'half a thought');
      expect(c.notifier.state.poll, isNotNull);
      expect(c.notifier.state.topics, ['design']);
      expect(c.notifier.state.replyPolicy, ReplyPolicy.mentioned);
      expect(c.notifier.state.quoting?.id, 'q1');
    });

    test('does not rewrite a draft for having been opened', () async {
      // It would move to the top of the drafts list every time it was looked
      // at, which is not what "most recently edited" means.
      final c = composer();
      await pumpEventQueue();

      c.notifier.restore(_draft());
      await settle();

      expect(c.drafts.writes, 0);
    });

    test('stops writing once the composer is cleared', () async {
      final c = composer();
      await pumpEventQueue();
      c.notifier.updateContent('sent already');

      c.notifier.clear();
      await settle();

      // Otherwise the pending write puts back a draft for a post that has
      // just gone out.
      expect(c.drafts.writes, 0);
    });
  });
}
