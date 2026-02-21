import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/composer_model.dart';

class DraftService {
  static final DraftService _instance = DraftService._internal();
  factory DraftService() => _instance;
  String? get currentDraftId => _currentDraftId;
  DraftService._internal();

  Database? _database;
  Timer? _autoSaveTimer;
  String? _currentDraftId;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
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

  void startAutoSave({
    required Function() onSave,
    required String Function() getCurrentContent,
    required String Function() getCurrentPrivacy,
    required DateTime? Function() getCurrentSchedule,
  }) {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      final content = getCurrentContent();
      if (content.trim().isNotEmpty) {
        await saveDraft(
          content: content,
          privacy: getCurrentPrivacy(),
          scheduledAt: getCurrentSchedule(),
        );
        onSave();
      }
    });
  }

  void stopAutoSave() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = null;
  }

  Future<void> saveDraft({
    required String content,
    required String privacy,
    required DateTime? scheduledAt,
    List<String> mediaPaths = const [],
  }) async {
    final db = await database;
    final draft = ComposerDraft(
      id: _currentDraftId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      privacy: privacy,
      scheduledAt: scheduledAt,
      mediaPaths: mediaPaths,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
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
    final List<Map<String, dynamic>> maps = await db.query(
      'drafts',
      orderBy: 'updatedAt DESC',
      limit: 1,
    );
    if (maps.isNotEmpty) {
      final draft = ComposerDraft.fromMap(maps.first);
      _currentDraftId = draft.id;
      return draft;
    }
    return null;
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