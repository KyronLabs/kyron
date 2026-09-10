import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/composer_model.dart';
import '../models/composer_poll.dart';
import '../models/feed_post.dart';
import '../models/post_media.dart';

import 'platform_support.dart';

/// The unsent posts held on this device.
///
/// The auto-save loop this used to run polled every three seconds through four
/// callbacks, three of which fed a privacy and schedule the API has never
/// accepted. What replaced it saved only on the way out, which meant the app
/// being killed with the composer open lost everything -- and the phone taking
/// a call is not a rare event. The composer now saves shortly after a change
/// and again when the app goes to the background, which is not a poll: nothing
/// is written unless something was edited.
class DraftService {
  static final DraftService _instance = DraftService._internal();
  factory DraftService() => _instance;
  DraftService._internal();

  Database? _database;
  String? _currentDraftId;

  String? get currentDraftId => _currentDraftId;

  /// Which draft the composer is editing. Set when one is opened from the
  /// drafts screen, so saving updates it rather than adding a duplicate.
  set currentDraftId(String? id) => _currentDraftId = id;

  /// Whether there is a store to write to at all.
  ///
  /// sqflite ships android, ios and macos. Everywhere else a draft has nowhere
  /// to live, and every method below answers as though the table were empty
  /// rather than throwing -- a composer that cannot keep drafts is a smaller
  /// loss than a composer that crashes when you close it.
  bool get isAvailable => PlatformSupport.current.localDatabase;

  Future<Database> get database async {
    return _database ??= await _initDB();
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'kyron_drafts.db'),
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE drafts(
            id TEXT PRIMARY KEY,
            content TEXT NOT NULL,
            privacy TEXT NOT NULL,
            scheduledAt TEXT,
            mediaPaths TEXT NOT NULL,
            payload TEXT,
            createdAt TEXT NOT NULL,
            updatedAt TEXT NOT NULL
          )
        ''');
      },
      // Added rather than rebuilt, and nullable, so an install upgrading with
      // an unsent draft in the table keeps it. A row with no payload reads
      // back as text with no poll, which is exactly what it was.
      onUpgrade: (db, from, to) async {
        if (from < 2) {
          await db.execute('ALTER TABLE drafts ADD COLUMN payload TEXT');
        }
      },
    );
  }

  /// Writes one draft, replacing the one being edited rather than adding to it.
  ///
  /// Everything the composer holds bar the attachments: those live in a cache
  /// directory the system may clear, so a restored draft would point at files
  /// that are no longer there.
  Future<void> saveDraft({
    required String content,
    ReplyPolicy replyPolicy = ReplyPolicy.everyone,
    ComposerPoll? poll,
    List<String> topics = const [],
    QuotedPost? quoting,
  }) async {
    if (!isAvailable) return;
    final db = await database;
    final now = DateTime.now();
    final draft = ComposerDraft(
      id: _currentDraftId ?? now.millisecondsSinceEpoch.toString(),
      content: content,
      replyPolicy: replyPolicy,
      poll: poll,
      topics: topics,
      quoting: quoting,
      createdAt: now,
      updatedAt: now,
    );
    _currentDraftId = draft.id;

    await db.insert(
      'drafts',
      draft.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Every draft, most recently touched first.
  Future<List<ComposerDraft>> allDrafts() async {
    if (!isAvailable) return const [];
    final db = await database;
    final rows = await db.query('drafts', orderBy: 'updatedAt DESC');
    return rows.map(ComposerDraft.fromMap).toList();
  }

  Future<int> count() async {
    if (!isAvailable) return 0;
    final db = await database;
    final rows = await db.rawQuery('SELECT COUNT(*) AS n FROM drafts');
    return (rows.first['n'] as int?) ?? 0;
  }

  Future<ComposerDraft?> getLatestDraft() async {
    if (!isAvailable) return null;
    final db = await database;
    final rows = await db.query('drafts', orderBy: 'updatedAt DESC', limit: 1);
    if (rows.isEmpty) return null;

    final draft = ComposerDraft.fromMap(rows.first);
    _currentDraftId = draft.id;
    return draft;
  }

  Future<void> deleteDraft(String id) async {
    if (!isAvailable) return;
    final db = await database;
    await db.delete('drafts', where: 'id = ?', whereArgs: [id]);
    if (_currentDraftId == id) _currentDraftId = null;
  }

  Future<void> clearAllDrafts() async {
    if (!isAvailable) return;
    final db = await database;
    await db.delete('drafts');
    _currentDraftId = null;
  }
}
