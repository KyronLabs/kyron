import 'package:dio/dio.dart';

import '../models/explore_entry.dart';
import '../models/feed_post.dart';
import '../models/post_media.dart';
import '../models/post_comment.dart';
import '../services/api_client.dart';
import '../services/app_log.dart';
import '../models/composer_poll.dart';
import '../models/link_preview.dart';

class FeedRepository {
  final ApiClient _api;

  FeedRepository(this._api);

  /// One page of the feed, newest first.
  ///
  /// [cursor] is the `nextCursor` of the previous page. The server uses keyset
  /// pagination, so passing it back is what keeps a page boundary stable while
  /// people are posting.
  Future<FeedPage> recent({String? cursor, int limit = 20}) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/feed/recent',
      queryParameters: {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
      },
    );
    return FeedPage.fromJson(res.data ?? const {});
  }

  /// One account's posts, newest first, with the same cursor rules as [recent].
  ///
  /// [has] narrows to posts carrying an attachment: `media` for anything
  /// visual, or `image`, `gif` or `video` for one kind. That is what the
  /// profile's Media and Videos tabs read.
  Future<FeedPage> byAuthor(
    String userId, {
    String? cursor,
    int limit = 20,
    String? has,
  }) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/feed/users/$userId/posts',
      queryParameters: {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
        if (has != null) 'has': has,
      },
    );
    return FeedPage.fromJson(res.data ?? const {});
  }

  /// Posts from the accounts you follow, newest first.
  Future<FeedPage> following({String? cursor, int limit = 20}) =>
      _page('/feed/following', cursor, limit);

  /// Posts carrying a video, newest first.
  Future<FeedPage> videos({String? cursor, int limit = 20}) =>
      _page('/feed/videos', cursor, limit);

  /// Post search. At least one of [query] and [from] has to be given.
  Future<FeedPage> search({
    String? query,
    String? from,
    DateTime? after,
    DateTime? before,
    String? has,
    String? cursor,
    int limit = 20,
  }) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/feed/search',
      queryParameters: {
        'limit': limit,
        if (query != null && query.isNotEmpty) 'q': query,
        if (from != null && from.isNotEmpty) 'from': from,
        // Sent as an instant rather than a local date, so a filter set in one
        // timezone means the same moment when the server applies it.
        if (after != null) 'after': after.toUtc().toIso8601String(),
        if (before != null) 'before': before.toUtc().toIso8601String(),
        if (has != null && has.isNotEmpty) 'has': has,
        if (cursor != null) 'cursor': cursor,
      },
    );
    return FeedPage.fromJson(res.data ?? const {});
  }

  /// Takes a vote back and answers with the post carrying the updated poll.
  Future<FeedPost> retractVote(String postId) async {
    final res = await _api.dio.delete<Map<String, dynamic>>(
      '/feed/posts/$postId/poll/vote',
    );
    return FeedPost.fromJson(res.data ?? const {});
  }

  /// Records a vote and answers with the post carrying the updated poll.
  Future<FeedPost> voteOnPoll(String postId, String optionId) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/feed/posts/$postId/poll/vote',
      data: {'optionId': optionId},
    );
    return FeedPost.fromJson(res.data ?? const {});
  }

  /// The Open Graph card for a link, or null when it has none.
  Future<LinkPreview?> linkPreview(String url) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/links/preview',
      queryParameters: {'url': url},
    );
    final preview = res.data?['preview'];
    return preview is Map<String, dynamic>
        ? LinkPreview.fromJson(preview)
        : null;
  }

  /// The posts you have liked, most recently liked first.
  Future<FeedPage> liked({String? cursor, int limit = 20}) =>
      _page('/feed/liked', cursor, limit);

  /// The posts you have saved. Private to you -- there is no path for another
  /// account's saves.
  Future<FeedPage> saved({String? cursor, int limit = 20}) =>
      _page('/feed/saved', cursor, limit);

  Future<FeedPage> _page(String path, String? cursor, int limit) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      path,
      queryParameters: {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
      },
    );
    return FeedPage.fromJson(res.data ?? const {});
  }

  /// Returns the post's recounted like total, so the screen shows the server's
  /// number rather than its own guess.
  Future<int> setLiked(String postId, bool liked) async {
    final path = '/feed/posts/$postId/like';
    final res = liked
        ? await _api.dio.put<Map<String, dynamic>>(path)
        : await _api.dio.delete<Map<String, dynamic>>(path);
    return (res.data?['likes'] as num?)?.toInt() ?? 0;
  }

  Future<void> setSaved(String postId, bool saved) async {
    final path = '/feed/posts/$postId/save';
    if (saved) {
      await _api.dio.put<void>(path);
    } else {
      await _api.dio.delete<void>(path);
    }
  }

  Future<FeedPost> create(
    String content, {
    List<PendingMedia> media = const [],
    String? quotedPostId,
    ReplyPolicy replyPolicy = ReplyPolicy.everyone,
    ComposerPoll? poll,
  }) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/feed/posts',
      // No author: the server takes it from the access token and rejects any
      // attempt to name one.
      data: {
        'content': content,
        if (media.isNotEmpty)
          'media':
              media.where((m) => m.isReady).map((m) => m.toJson()).toList(),
        if (quotedPostId != null) 'quotedPostId': quotedPostId,
        if (poll != null) 'poll': poll.toJson(),
        'replyPolicy': replyPolicy.wire,
      },
    );
    return FeedPost.fromJson(res.data ?? const {});
  }

  /// Uploads one attachment and answers with what to attach.
  ///
  /// Separate from creating the post so a slow upload does not hold a
  /// half-typed post hostage, and a failed post does not lose the pictures.
  ///
  /// A clip goes up with the still the composer pulled out of it, so every
  /// list that later draws the post has a picture rather than having to open a
  /// decoder for it.
  Future<PendingMedia> uploadMedia(PendingMedia pending) async {
    final url = await _upload(
      pending.path,
      width: pending.width,
      height: pending.height,
    );

    var thumbnailUrl = pending.thumbnailUrl;
    final still = pending.thumbnailPath;
    if (thumbnailUrl == null && still != null) {
      // Best effort, and deliberately not fatal: a clip whose still would not
      // upload is still a clip worth posting, and the reader falls back to
      // opening a player for it. Logged rather than swallowed so a run of
      // these is visible.
      try {
        thumbnailUrl = await _upload(still);
      } catch (error) {
        AppLog.instance
            .error('media', 'A clip went up without its still: $error');
      }
    }

    return pending.copyWith(
      url: url,
      thumbnailUrl: thumbnailUrl,
      clearError: true,
    );
  }

  /// Puts one file on the server and answers with the URL it was given.
  Future<String> _upload(String path, {int? width, int? height}) async {
    final form = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        path,
        filename: path.split('/').last,
      ),
      if (width != null) 'width': '$width',
      if (height != null) 'height': '$height',
    });

    final res = await _api.dio.post<Map<String, dynamic>>(
      '/media',
      data: form,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );

    final url = res.data?['url'] as String?;
    if (url == null) throw StateError('The upload returned no URL.');
    return url;
  }

  /// Returns the post's recounted repost total.
  Future<int> setReposted(String postId, bool reposted) async {
    final path = '/feed/posts/$postId/repost';
    final res = reposted
        ? await _api.dio.put<Map<String, dynamic>>(path)
        : await _api.dio.delete<Map<String, dynamic>>(path);
    return (res.data?['reposts'] as num?)?.toInt() ?? 0;
  }

  /// Posts carrying a hashtag, given without its leading #.
  Future<FeedPage> byHashtag(String tag, {String? cursor, int limit = 20}) =>
      _page('/feed/tags/${Uri.encodeComponent(tag)}', cursor, limit);

  /// Posts by the people who follow a topic.
  Future<FeedPage> byTopic(String slug, {String? cursor, int limit = 20}) =>
      _page('/feed/topics/${Uri.encodeComponent(slug)}', cursor, limit);

  /// The hashtags being used right now, most used first.
  Future<List<TrendingTag>> trendingTags({int limit = 25}) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/feed/trending/tags',
      queryParameters: {'limit': limit},
    );
    return (res.data?['items'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(TrendingTag.fromJson)
        .toList();
  }

  Future<void> delete(String postId) => _api.dio.delete('/feed/posts/$postId');

  /// Changes who may reply, after the post has gone out.
  Future<void> setReplyPolicy(String postId, ReplyPolicy policy) =>
      _api.dio.patch<void>(
        '/feed/posts/$postId/reply-policy',
        data: {'replyPolicy': policy.wire},
      );

  /// One post on its own, for the screen that shows it with its thread.
  Future<FeedPost> byId(String postId) async {
    final res = await _api.dio.get<Map<String, dynamic>>('/feed/posts/$postId');
    return FeedPost.fromJson(res.data ?? const {});
  }

  Future<CommentPage> comments(String postId,
      {String? cursor, int limit = 20}) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/feed/posts/$postId/comments',
      queryParameters: {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
      },
    );
    return CommentPage.fromJson(res.data ?? const {});
  }

  Future<CommentPage> replies(String commentId,
      {String? cursor, int limit = 20}) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/feed/comments/$commentId/replies',
      queryParameters: {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
      },
    );
    return CommentPage.fromJson(res.data ?? const {});
  }

  Future<PostComment> addComment(
    String postId,
    String content, {
    String? parentId,
    List<PendingMedia> media = const [],
  }) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/feed/posts/$postId/comments',
      data: {
        'content': content,
        if (parentId != null) 'parentId': parentId,
        if (media.isNotEmpty)
          'media':
              media.where((m) => m.isReady).map((m) => m.toJson()).toList(),
      },
    );
    return PostComment.fromJson(res.data ?? const {});
  }

  Future<void> deleteComment(String commentId) =>
      _api.dio.delete<void>('/feed/comments/$commentId');

  /// Records that this reader opened the post. Idempotent per reader, and the
  /// author's own opens are not counted.
  Future<void> recordView(String postId) =>
      _api.dio.put<void>('/feed/posts/$postId/view');

  /// How the post is doing. Answers 404 to anyone but its author.
  Future<PostAnalytics> analytics(String postId) async {
    final res = await _api.dio
        .get<Map<String, dynamic>>('/feed/posts/$postId/analytics');
    return PostAnalytics.fromJson(res.data ?? const {});
  }
}
