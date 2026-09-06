// lib/utils/media_basket.dart
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../models/post_media.dart';
import '../repositories/feed_repository.dart';
import 'api_error_message.dart';

/// Attachments being picked and uploaded, for whatever is writing them.
///
/// The composer, the reply box and the community composer all do the same
/// three things -- pick from the gallery, upload each one, let a failed one be
/// retried or removed -- and each had written its own. This is that once, as a
/// plain listenable, so a screen can own a basket without needing a provider
/// per screen.
class MediaBasket extends ChangeNotifier {
  final FeedRepository _repo;

  /// How many one post may carry. The server enforces the same number.
  final int limit;

  MediaBasket(this._repo, {this.limit = 4});

  final List<PendingMedia> _items = [];

  List<PendingMedia> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;
  bool get isNotEmpty => _items.isNotEmpty;

  /// True while anything is still going up. Posting before that finishes
  /// would send a reference to a file the server does not have.
  bool get isUploading => _items.any((m) => m.isUploading);

  bool get hasRoom => _items.length < limit;

  /// The ones that made it, in the shape the API takes.
  List<PendingMedia> get ready => _items.where((m) => m.isReady).toList();

  /// Picks from the gallery and starts the uploads. Returns a message to show
  /// the reader, or null when it went fine.
  Future<String?> attach({required bool video}) async {
    if (!hasRoom) return 'A post can carry at most $limit attachments.';

    final picker = ImagePicker();
    try {
      final List<XFile> picked;
      if (video) {
        final clip = await picker.pickVideo(
          source: ImageSource.gallery,
          maxDuration: const Duration(minutes: 2),
        );
        picked = clip == null ? const [] : [clip];
      } else {
        picked = await picker.pickMultiImage(limit: limit - _items.length);
      }
      if (picked.isEmpty) return null;

      for (final file in picked.take(limit - _items.length)) {
        await _upload(
          PendingMedia(
            path: file.path,
            kind: video ? MediaKind.video : MediaKind.image,
          ),
        );
      }
      return null;
    } catch (_) {
      return 'Could not open your gallery.';
    }
  }

  Future<void> _upload(PendingMedia pending) async {
    _items.add(pending);
    notifyListeners();
    try {
      _replace(pending.path, await _repo.uploadMedia(pending));
    } catch (error) {
      // Kept in the tray carrying its error rather than dropped: a picture
      // that disappears on a bad connection looks like the app lost it.
      _replace(
        pending.path,
        pending.copyWith(error: describeApiError(error, sessionIsLive: true)),
      );
    }
  }

  void remove(String path) {
    _items.removeWhere((m) => m.path == path);
    notifyListeners();
  }

  Future<void> retry(String path) async {
    final failed = _items.firstWhere(
      (m) => m.path == path,
      orElse: () => const PendingMedia(path: '', kind: MediaKind.image),
    );
    if (failed.path.isEmpty) return;
    remove(path);
    await _upload(PendingMedia(path: failed.path, kind: failed.kind));
  }

  void describe(String path, String alt) {
    final index = _items.indexWhere((m) => m.path == path);
    if (index < 0) return;
    _items[index] = _items[index].copyWith(alt: alt);
    notifyListeners();
  }

  void _replace(String path, PendingMedia updated) {
    final index = _items.indexWhere((m) => m.path == path);
    if (index < 0) return;
    _items[index] = updated;
    notifyListeners();
  }
}
