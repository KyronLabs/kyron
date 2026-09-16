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

/// Searching GIPHY for a GIF.
///
/// This was Tenor. Tenor has stopped taking new sign-ups, so a key cannot be
/// obtained for it any more and the picker would have been permanently off for
/// every build made from here on.
///
/// The swap carries one condition Tenor did not. GIPHY's terms require the
/// mark to be shown wherever its results are -- "Powered By GIPHY" -- and the
/// picker draws it; see [attribution]. That is not decoration to be tidied
/// away later, it is the price of the free tier, and the reason the comment
/// this replaces gave for choosing Tenor in the first place.
///
/// The key is supplied at build time rather than committed, and there is no
/// fallback: without one the picker says so plainly instead of showing an
/// empty grid that looks like a network fault.
class GifSearch {
  /// [key] is for a test, which otherwise cannot reach the parsing at all:
  /// without one every call returns an empty list before it asks anything, so
  /// a test of the response shape would pass by doing nothing.
  GifSearch({Dio? client, String? key})
    : _dio = client ?? Dio(),
      _key = key ?? apiKey;

  final Dio _dio;
  final String _key;

  /// Passed with --dart-define=GIPHY_API_KEY=... at build time.
  static const apiKey = String.fromEnvironment('GIPHY_API_KEY');

  static bool get isConfigured => apiKey.isNotEmpty;

  /// What GIPHY requires to be shown beside its results.
  static const attribution = 'Powered by GIPHY';

  static const _base = 'https://api.giphy.com/v1/gifs';

  /// GIPHY's ratings run g, pg, pg-13, r. This is the ceiling, and it is the
  /// same line Tenor's `contentfilter: medium` drew.
  static const _rating = 'pg-13';

  Future<List<GifResult>> featured({int limit = 30}) =>
      _fetch('$_base/trending', {'limit': '$limit'});

  Future<List<GifResult>> search(String query, {int limit = 30}) =>
      _fetch('$_base/search', {'q': query, 'limit': '$limit'});

  Future<List<GifResult>> _fetch(
    String url,
    Map<String, String> parameters,
  ) async {
    if (_key.isEmpty) return const [];

    final res = await _dio.get<Map<String, dynamic>>(
      url,
      queryParameters: {
        ...parameters,
        'api_key': _key,
        'rating': _rating,
        // GIPHY asks callers to identify themselves, and it is what the rate
        // limit is counted against.
        'bundle': 'messaging_non_clips',
      },
    );

    return ((res.data?['data'] as List<dynamic>?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(_parse)
        .whereType<GifResult>()
        .toList();
  }

  /// GIPHY nests every rendition under `images`, and gives sizes as strings.
  static GifResult? _parse(Map<String, dynamic> json) {
    final images = json['images'];
    if (images is! Map) return null;

    // `downsized` before `original`: originals run to tens of megabytes and
    // this is a picture going into a post, not a wallpaper. The preview is
    // the small still-sized rendition, which is what a grid cell needs.
    final full = images['downsized'] ?? images['original'];
    final preview =
        images['fixed_width_small'] ??
        images['fixed_width_downsampled'] ??
        full;
    if (full is! Map || preview is! Map) return null;

    final url = full['url'] as String?;
    final previewUrl = preview['url'] as String?;
    if (url == null || previewUrl == null) return null;

    return GifResult(
      id: json['id'] as String? ?? url,
      url: url,
      previewUrl: previewUrl,
      width: _side(full['width']),
      height: _side(full['height']),
      // GIPHY's `title` is what Tenor called content_description.
      description: (json['title'] as String?)?.trim(),
    );
  }

  /// Sizes arrive as strings -- "480" rather than 480.
  static int _side(Object? value) => switch (value) {
    final num n => n.toInt(),
    final String s => int.tryParse(s) ?? 0,
    _ => 0,
  };
}
