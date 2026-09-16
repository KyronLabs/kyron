// lib/models/link_preview.dart

/// The Open Graph card for a link, as the server read it.
///
/// Fetched by the API rather than the device: a card fetched on the client
/// would have every reader of a post request the linked site directly, which
/// hands that site a view of everyone who scrolled past, and points the whole
/// readership at one server at once.
class LinkPreview {
  /// The URL as it was normalised, which is also the cache key.
  final String url;

  /// The host on its own, for the line under the title.
  final String host;

  final String? title;
  final String? description;
  final String? imageUrl;
  final String? siteName;

  const LinkPreview({
    required this.url,
    required this.host,
    this.title,
    this.description,
    this.imageUrl,
    this.siteName,
  });

  factory LinkPreview.fromJson(Map<String, dynamic> json) => LinkPreview(
        url: json['url'] as String? ?? '',
        host: json['host'] as String? ?? '',
        title: _text(json['title']),
        description: _text(json['description']),
        imageUrl: _text(json['imageUrl']),
        siteName: _text(json['siteName']),
      );

  /// What to print under the title: the site's own name if it gave one, else
  /// the host. `www.` is dropped because nobody reads it.
  String get label {
    final name = siteName?.trim();
    if (name != null && name.isNotEmpty) return name;
    return host.startsWith('www.') ? host.substring(4) : host;
  }

  /// A card with neither a title nor a picture has nothing to show, and is
  /// worse than no card: it renders as an empty grey box under the post.
  bool get isRenderable =>
      (title != null && title!.isNotEmpty) || imageUrl != null;

  static String? _text(Object? value) {
    if (value is! String) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
