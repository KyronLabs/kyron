// lib/models/post_media.dart

enum MediaKind { image, video, gif, voice }

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

  /// A still from a video, uploaded beside it by the composer.
  ///
  /// A phone can only decode a handful of videos at once. Past that ceiling
  /// the next surface fails and the tile goes black, which is why a list of
  /// clips has to be a list of pictures with one player over the top. Null
  /// for anything that is not a video, and for clips posted before the
  /// composer started sending one.
  final String? thumbnailUrl;

  /// How long a voice recording runs. Null for everything else.
  final Duration? duration;

  /// Loudness over time, 0-100, one value per bar of the waveform.
  ///
  /// Sampled on the device while recording, because that is the only place the
  /// signal exists -- deriving it on the server would mean decoding every
  /// upload just to draw a picture of it.
  final List<int> waveform;

  const PostMedia({
    required this.id,
    required this.kind,
    required this.url,
    this.width,
    this.height,
    this.alt,
    this.thumbnailUrl,
    this.duration,
    this.waveform = const [],
  });

  bool get isVideo => kind == MediaKind.video;

  bool get isVoice => kind == MediaKind.voice;

  /// Whether this is something to look at rather than listen to. Decides
  /// whether an attachment belongs in the media grid or under it.
  bool get isVisual => !isVoice;

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
        thumbnailUrl: _text(json['thumbnailUrl']),
        duration: json['durationMs'] is num
            ? Duration(milliseconds: (json['durationMs'] as num).toInt())
            : null,
        waveform: (json['waveform'] as List<dynamic>? ?? const [])
            .whereType<num>()
            .map((value) => value.toInt().clamp(0, 100))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'kind': kind.name.toUpperCase(),
        if (width != null) 'width': width,
        if (height != null) 'height': height,
        if (alt != null && alt!.trim().isNotEmpty) 'alt': alt!.trim(),
        if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
        if (duration != null) 'durationMs': duration!.inMilliseconds,
        if (waveform.isNotEmpty) 'waveform': waveform,
      };

  /// A string field, with blank treated as absent. The server stores an empty
  /// string as easily as a null, and an empty URL is not a picture.
  static String? _text(Object? value) {
    final text = value is String ? value.trim() : '';
    return text.isEmpty ? null : text;
  }

  static MediaKind _kindOf(Object? value) {
    switch ((value as String?)?.toUpperCase()) {
      case 'VIDEO':
        return MediaKind.video;
      case 'GIF':
        return MediaKind.gif;
      case 'VOICE':
        return MediaKind.voice;
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

  /// A still pulled out of a chosen video, on disk.
  ///
  /// Generated the moment the clip is attached, so the tray shows the video
  /// rather than an icon standing in for one, and uploaded with it so every
  /// list that later draws the post has a picture to draw.
  final String? thumbnailPath;

  /// The uploaded still. Null until [thumbnailPath] has gone up.
  final String? thumbnailUrl;

  /// How long a voice recording runs, and its loudness over time. Both are
  /// measured while recording and carried through the upload unchanged.
  final Duration? duration;
  final List<int> waveform;

  const PendingMedia({
    required this.path,
    required this.kind,
    this.width,
    this.height,
    this.url,
    this.error,
    this.alt,
    this.thumbnailPath,
    this.thumbnailUrl,
    this.duration,
    this.waveform = const [],
  });

  bool get isVoice => kind == MediaKind.voice;

  bool get isVideo => kind == MediaKind.video;

  bool get isUploading => url == null && error == null;
  bool get isReady => url != null;

  PendingMedia copyWith({
    String? url,
    String? error,
    String? alt,
    int? width,
    int? height,
    String? thumbnailPath,
    String? thumbnailUrl,
    Duration? duration,
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
        thumbnailPath: thumbnailPath ?? this.thumbnailPath,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        duration: duration ?? this.duration,
        waveform: waveform,
      );

  /// What the create-post request carries. Only ever called once uploaded.
  Map<String, dynamic> toJson() => {
        'url': url,
        'kind': kind.name.toUpperCase(),
        if (width != null) 'width': width,
        if (height != null) 'height': height,
        if (alt != null && alt!.trim().isNotEmpty) 'alt': alt!.trim(),
        if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
        // Only a recording carries these. A clip's own duration is read off
        // the file by whatever plays it.
        if (isVoice && duration != null) 'durationMs': duration!.inMilliseconds,
        if (waveform.isNotEmpty) 'waveform': waveform,
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
