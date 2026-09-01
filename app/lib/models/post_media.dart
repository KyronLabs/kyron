// lib/models/post_media.dart

enum MediaKind { image, video, gif }

/// One attachment on a post or a comment.
class PostMedia {
  final String id;
  final MediaKind kind;
  final String url;

  /// Carried so a list can reserve the right space before the bytes arrive.
  /// Without them every image pops the layout as it loads.
  final int? width;
  final int? height;

  /// The author's description, read out by a screen reader.
  final String? alt;

  const PostMedia({
    required this.id,
    required this.kind,
    required this.url,
    this.width,
    this.height,
    this.alt,
  });

  bool get isVideo => kind == MediaKind.video;

  /// Width over height, or null when the server did not record them. Callers
  /// fall back to a fixed box rather than guessing a shape.
  double? get aspectRatio {
    final w = width;
    final h = height;
    if (w == null || h == null || w <= 0 || h <= 0) return null;
    return w / h;
  }

  factory PostMedia.fromJson(Map<String, dynamic> json) => PostMedia(
        id: json['id'] as String? ?? '',
        kind: _kindOf(json['kind']),
        url: json['url'] as String? ?? '',
        width: (json['width'] as num?)?.toInt(),
        height: (json['height'] as num?)?.toInt(),
        alt: json['alt'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'kind': kind.name.toUpperCase(),
        if (width != null) 'width': width,
        if (height != null) 'height': height,
        if (alt != null && alt!.trim().isNotEmpty) 'alt': alt!.trim(),
      };

  static MediaKind _kindOf(Object? value) {
    switch ((value as String?)?.toUpperCase()) {
      case 'VIDEO':
        return MediaKind.video;
      case 'GIF':
        return MediaKind.gif;
      default:
        return MediaKind.image;
    }
  }

  static List<PostMedia> listFrom(Object? value) {
    if (value is! List) return const [];
    return value
        .whereType<Map<String, dynamic>>()
        .map(PostMedia.fromJson)
        .where((m) => m.url.isNotEmpty)
        .toList();
  }
}

/// An attachment chosen on the device but not yet posted.
class PendingMedia {
  /// Where it is on disk, for the preview before it is uploaded.
  final String path;
  final MediaKind kind;
  final int? width;
  final int? height;

  /// Set once the upload finishes. Null while it is in flight.
  final String? url;

  /// Why the upload failed, if it did.
  final String? error;

  final String? alt;

  const PendingMedia({
    required this.path,
    required this.kind,
    this.width,
    this.height,
    this.url,
    this.error,
    this.alt,
  });

  bool get isUploading => url == null && error == null;
  bool get isReady => url != null;

  PendingMedia copyWith({
    String? url,
    String? error,
    String? alt,
    int? width,
    int? height,
    bool clearError = false,
  }) =>
      PendingMedia(
        path: path,
        kind: kind,
        width: width ?? this.width,
        height: height ?? this.height,
        url: url ?? this.url,
        error: clearError ? null : (error ?? this.error),
        alt: alt ?? this.alt,
      );

  /// What the create-post request carries. Only ever called once uploaded.
  Map<String, dynamic> toJson() => {
        'url': url,
        'kind': kind.name.toUpperCase(),
        if (width != null) 'width': width,
        if (height != null) 'height': height,
        if (alt != null && alt!.trim().isNotEmpty) 'alt': alt!.trim(),
      };
}

/// Who may reply to a post.
enum ReplyPolicy {
  everyone,
  followers,
  mentioned,
  nobody;

  static ReplyPolicy fromJson(Object? value) {
    switch ((value as String?)?.toUpperCase()) {
      case 'FOLLOWERS':
        return ReplyPolicy.followers;
      case 'MENTIONED':
        return ReplyPolicy.mentioned;
      case 'NOBODY':
        return ReplyPolicy.nobody;
      default:
        return ReplyPolicy.everyone;
    }
  }

  String get wire => name.toUpperCase();

  /// What the composer's button says.
  String get label => switch (this) {
        ReplyPolicy.everyone => 'Anyone can interact',
        ReplyPolicy.followers => 'People who follow you',
        ReplyPolicy.mentioned => 'People you mention',
        ReplyPolicy.nobody => 'Nobody can reply',
      };

  String get detail => switch (this) {
        ReplyPolicy.everyone => 'Anyone on Kyron can reply to this post.',
        ReplyPolicy.followers =>
          'Only people who follow you can reply to this post.',
        ReplyPolicy.mentioned =>
          'Only the people you @mention in this post can reply.',
        ReplyPolicy.nobody => 'Replies are turned off. You can still reply.',
      };
}
