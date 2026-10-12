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

  /// Picks photos and clips from the gallery in one go and starts the
  /// uploads. Returns a message to show the reader, or null when it went fine.
  Future<String?> attachFromGallery() async {
    if (!hasRoom) return 'A post can carry at most $limit attachments.';
    try {
      final picked = await pickGalleryMedia(room: limit - _items.length);
      for (final item in picked.items) {
        await _upload(item);
      }
      return picked.message;
    } catch (_) {
      return 'Could not open your gallery.';
    }
  }

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

  /// Takes a photo with the camera and starts its upload. Returns a message
  /// to show the reader, or null when it went fine -- or when they backed out
  /// without taking one.
  ///
  /// Scaled to 2048 across and saved at 85% quality: straight off a phone's
  /// sensor a photo is 4 to 12 MB, which is a slow upload over mobile data
  /// for a picture that is shown a third of a screen wide.
  Future<String?> capture() async {
    if (!hasRoom) return 'A post can carry at most $limit attachments.';
    try {
      final shot = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 2048,
        maxHeight: 2048,
        imageQuality: 85,
      );
      if (shot == null) return null;
      await _upload(PendingMedia(path: shot.path, kind: MediaKind.image));
      return null;
    } catch (_) {
      return 'Could not open the camera.';
    }
  }

  /// The server's limit, mirrored so an oversized file is refused here rather
  /// than after uploading it and being told 413.
  static const maxAttachmentBytes = 25 * 1024 * 1024;

  /// Adds a file that is already on the device -- a GIF the picker has just
  /// downloaded -- and starts its upload. Returns a message to show the
  /// reader, or null when it went fine.
  Future<String?> attachFile(String path, MediaKind kind) async {
    if (!hasRoom) return 'A post can carry at most $limit attachments.';
    final bytes = await XFile(path).length();
    if (bytes > maxAttachmentBytes) {
      return 'That file is larger than '
          '${maxAttachmentBytes ~/ (1024 * 1024)} MB.';
    }
    await _upload(PendingMedia(path: path, kind: kind));
    return null;
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

  /// Empties it, after whatever was holding it has been sent.
  void clear() {
    _items.clear();
    notifyListeners();
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

/// What a gallery pick came back with, and anything worth telling the reader
/// about what was left out.
class GalleryPick {
  final List<PendingMedia> items;
  final String? message;

  const GalleryPick(this.items, [this.message]);
}

/// Photos and clips from the gallery, in one picker.
///
/// One button for both, where a reply box used to have one for each: two
/// buttons for "something from my gallery" was room the box needed for the
/// GIF button. Files over the server's size limit are left out and said so,
/// rather than uploaded and refused.
Future<GalleryPick> pickGalleryMedia({required int room}) async {
  if (room <= 0) return const GalleryPick([]);
  final picked = await ImagePicker().pickMultipleMedia(
    // The picker refuses a limit under two; a single free slot is enforced
    // by taking one below.
    limit: room >= 2 ? room : null,
  );

  final items = <PendingMedia>[];
  var tooBig = 0;
  for (final file in picked.take(room)) {
    if (await file.length() > MediaBasket.maxAttachmentBytes) {
      tooBig++;
      continue;
    }
    items.add(PendingMedia(path: file.path, kind: mediaKindOf(file)));
  }
  return GalleryPick(
    items,
    tooBig == 0
        ? null
        : '${tooBig == 1 ? 'One file was' : '$tooBig files were'} larger than '
            '${MediaBasket.maxAttachmentBytes ~/ (1024 * 1024)} MB and left out.',
  );
}

/// What kind of attachment a picked file is: by its type when the platform
/// says, by its extension when it does not (Android often does not).
MediaKind mediaKindOf(XFile file) {
  final mime = file.mimeType;
  if (mime != null) {
    if (mime.startsWith('video/')) return MediaKind.video;
    if (mime == 'image/gif') return MediaKind.gif;
    return MediaKind.image;
  }
  final dot = file.path.lastIndexOf('.');
  final extension = dot < 0 ? '' : file.path.substring(dot + 1).toLowerCase();
  const clips = {'mp4', 'mov', 'm4v', '3gp', 'webm', 'mkv', 'avi'};
  if (clips.contains(extension)) return MediaKind.video;
  if (extension == 'gif') return MediaKind.gif;
  return MediaKind.image;
}
