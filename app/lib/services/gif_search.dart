// lib/services/gif_search.dart
import 'package:dio/dio.dart';

/// One GIF from the provider.
class GifResult {
  final String id;
  final String previewUrl;
  final String url;
  final int width;
  final int height;
  final String? description;

  const GifResult({
    required this.id,
    required this.previewUrl,
    required this.url,
    required this.width,
    required this.height,
    this.description,
  });
}

/// Searching Tenor for a GIF.
///
/// The key is supplied at build time rather than committed, and there is no
/// fallback: without one the picker says so plainly instead of showing an
/// empty grid that looks like a network fault. Tenor is used because it is the
/// provider whose free tier does not require attribution UI we do not have.
class GifSearch {
  GifSearch({Dio? client}) : _dio = client ?? Dio();

  final Dio _dio;

  /// Passed with --dart-define=TENOR_API_KEY=... at build time.
  static const apiKey = String.fromEnvironment('TENOR_API_KEY');

  static bool get isConfigured => apiKey.isNotEmpty;

  static const _base = 'https://tenor.googleapis.com/v2';

  Future<List<GifResult>> featured({int limit = 30}) =>
      _fetch('$_base/featured', {'limit': '$limit'});

  Future<List<GifResult>> search(String query, {int limit = 30}) =>
      _fetch('$_base/search', {'q': query, 'limit': '$limit'});

  Future<List<GifResult>> _fetch(
    String url,
    Map<String, String> parameters,
  ) async {
    if (!isConfigured) return const [];

    final res = await _dio.get<Map<String, dynamic>>(
      url,
      queryParameters: {
        ...parameters,
        'key': apiKey,
        'client_key': 'kyron',
        // Only the two formats we render: the full GIF and a small preview.
        'media_filter': 'gif,tinygif',
        'contentfilter': 'medium',
      },
    );

    return ((res.data?['results'] as List<dynamic>?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(_parse)
        .whereType<GifResult>()
        .toList();
  }

  static GifResult? _parse(Map<String, dynamic> json) {
    final formats = json['media_formats'];
    if (formats is! Map) return null;

    final full = formats['gif'];
    final preview = formats['tinygif'] ?? full;
    if (full is! Map || preview is! Map) return null;

    final url = full['url'] as String?;
    final previewUrl = preview['url'] as String?;
    if (url == null || previewUrl == null) return null;

    final dims = (full['dims'] as List<dynamic>?) ?? const [];
    return GifResult(
      id: json['id'] as String? ?? url,
      url: url,
      previewUrl: previewUrl,
      width: dims.isNotEmpty ? (dims[0] as num).toInt() : 0,
      height: dims.length > 1 ? (dims[1] as num).toInt() : 0,
      description: json['content_description'] as String?,
    );
  }
}
