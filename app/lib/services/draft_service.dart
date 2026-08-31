import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/composer_model.dart';

/// The one unsent post the composer is holding.
///
/// The auto-save loop this used to run polled every three seconds through four
/// callbacks, three of which fed a privacy and schedule the API has never
/// accepted. The composer now saves on the way out instead.
class DraftService {
  static final DraftService _instance = DraftService._internal();
  factory DraftService() => _instance;
  DraftService._internal();

  Database? _database;
  String? _currentDraftId;

  String? get currentDraftId => _currentDraftId;

  Future<Database> get database async {
    return _database ??= await _initDB();
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'kyron_drafts.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE drafts(
            id TEXT PRIMARY KEY,
            content TEXT NOT NULL,
            privacy TEXT NOT NULL,
            scheduledAt TEXT,
            mediaPaths TEXT NOT NULL,
            createdAt TEXT NOT NULL,
            updatedAt TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> saveDraft({required String content}) async {
    final db = await database;
    final now = DateTime.now();
    final draft = ComposerDraft(
      id: _currentDraftId ?? now.millisecondsSinceEpoch.toString(),
      content: content,
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

  Future<ComposerDraft?> getLatestDraft() async {
    final db = await database;
    final rows = await db.query('drafts', orderBy: 'updatedAt DESC', limit: 1);
    if (rows.isEmpty) return null;

    final draft = ComposerDraft.fromMap(rows.first);
    _currentDraftId = draft.id;
    return draft;
  }

  Future<void> deleteDraft(String id) async {
    final db = await database;
    await db.delete('drafts', where: 'id = ?', whereArgs: [id]);
    if (_currentDraftId == id) _currentDraftId = null;
  }

  Future<void> clearAllDrafts() async {
    final db = await database;
    await db.delete('drafts');
    _currentDraftId = null;
  }
}
