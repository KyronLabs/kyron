import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

import '../../providers/composer_provider.dart';

/// Public API — just swap your old [UrlPreview] with this one.
class UrlPreview extends ConsumerWidget {
  const UrlPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(composerProvider.select((s) => s.content));
    final url = UrlDetector.extractUrl(content);
    if (url == null) return const SizedBox.shrink();

    final async = ref.watch(urlMetadataProvider(url));
    return async.when(
      loading: () => _RawPreview(url: url, isLoading: true),
      error: (_, __) => _RawPreview(url: url, isLoading: false),
      data: (meta) => meta == null
          ? _RawPreview(url: url, isLoading: false)
          : _MetaPreview(meta: meta),
    );
  }
}

/* =================================================================
   INTELLIGENT URL DETECTOR
   ================================================================= */

class UrlDetector {
  UrlDetector._();

  /// Main entry point - extracts and normalizes the first valid URL from text
  static String? extractUrl(String text) {
    if (text.trim().isEmpty) return null;

    // Try each detection strategy in order of specificity
    String? url = _extractExplicitUrl(text) ??
        _extractImplicitUrl(text) ??
        _extractDomainUrl(text);

    return url != null ? _normalizeUrl(url) : null;
  }

  /// Strategy 1: Explicit URLs with protocol (http://, https://, ftp://)
  static String? _extractExplicitUrl(String text) {
    final regex = RegExp(
      r'(?:https?|ftp)://(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
      caseSensitive: false,
    );
    return regex.firstMatch(text)?.group(0);
  }

  /// Strategy 2: www. prefixed URLs (www.example.com)
  static String? _extractImplicitUrl(String text) {
    final regex = RegExp(
      r'\bwww\.[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
      caseSensitive: false,
    );
    return regex.firstMatch(text)?.group(0);
  }

  /// Strategy 3: Domain-like patterns (example.com, github.io, sub.domain.co.uk)
  static String? _extractDomainUrl(String text) {
    // Common TLDs and patterns
    final regex = RegExp(
      r'\b(?<!\.)(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.)+(?:com|org|net|edu|gov|mil|int|info|biz|name|museum|coop|aero|asia|cat|jobs|mobi|tel|travel|xxx|pro|app|dev|io|ai|co|me|tv|cc|ws|tech|online|site|store|blog|club|xyz|link|live|news|today|world|space|top|vip|work|design|art|photo|music|video|film|shop|email|team|cloud|host|zone|page|click|global|digital|network|software|systems|solutions|technology|services|group|agency|company|consulting|media|marketing|studio|ventures|industries|international|foundation|institute|academy|university|college|school|health|care|medical|legal|finance|bank|insurance|realestate|property|estate|construction|engineering|manufacturing|energy|transport|logistics|travel|hotel|restaurant|food|fashion|beauty|fitness|sports|games|entertainment|events|tickets|social|community|forum|wiki|docs|guide|tips|help|support|tools|app|apps|software|platform|api|web|mobile|android|ios|windows|mac|linux)[a-zA-Z]{0,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
      caseSensitive: false,
    );

    final match = regex.firstMatch(text);
    if (match == null) return null;

    final candidate = match.group(0)!;

    // Validation: must have at least one dot and valid structure
    if (!_isValidDomain(candidate)) return null;

    return candidate;
  }

  /// Validates domain structure
  static bool _isValidDomain(String domain) {
    // Remove trailing punctuation that might be caught
    domain = domain.replaceAll(RegExp(r'[.,;:!?\)\]]+$'), '');

    // Must contain at least one dot
    if (!domain.contains('.')) return false;

    // Split into parts
    final parts = domain.split('.');

    // Must have at least 2 parts (domain + TLD)
    if (parts.length < 2) return false;

    // Last part should be valid TLD (2-6 chars, only letters)
    final tld = parts.last;
    if (tld.length < 2 ||
        tld.length > 6 ||
        !RegExp(r'^[a-zA-Z]+$').hasMatch(tld)) {
      return false;
    }

    // Domain part shouldn't be just numbers (except for specific cases)
    final domainPart = parts[parts.length - 2];
    if (RegExp(r'^\d+$').hasMatch(domainPart) && tld != 'io') {
      return false;
    }

    // Check for common false positives
    final fullDomain = parts.join('.');
    if (_isFalsePositive(fullDomain)) return false;

    return true;
  }

  /// Filter out common false positives
  static bool _isFalsePositive(String domain) {
    final lowerDomain = domain.toLowerCase();

    // Common false positives in regular text
    final falsePositives = [
      'e.g.',
      'i.e.',
      'etc.com',
      'vs.com',
      'mr.com',
      'mrs.com',
      'dr.com',
      'no.com',
    ];

    return falsePositives.any((fp) => lowerDomain.startsWith(fp));
  }

  /// Normalizes URL by ensuring it has a protocol
  static String _normalizeUrl(String url) {
    // Already has protocol
    if (url.startsWith(RegExp(r'https?://', caseSensitive: false))) {
      return url;
    }

    // Has ftp protocol
    if (url.startsWith(RegExp(r'ftp://', caseSensitive: false))) {
      return url;
    }

    // Add https:// prefix
    return 'https://$url';
  }

  /// Validates if a string is a complete, valid URL
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(_normalizeUrl(url));
      return uri.hasScheme &&
          uri.host.isNotEmpty &&
          uri.host.contains('.') &&
          _isValidDomain(uri.host);
    } catch (_) {
      return false;
    }
  }

  /// Extracts all URLs from text (not just the first one)
  static List<String> extractAllUrls(String text) {
    final urls = <String>[];
    final words = text.split(RegExp(r'\s+'));

    for (final word in words) {
      final url = extractUrl(word);
      if (url != null && !urls.contains(url)) {
        urls.add(url);
      }
    }

    return urls;
  }
}

/* =================================================================
   UI LAYER  (pure, stateless, testable)
   ================================================================= */

/// Shown while we are fetching or when we have no metadata.
class _RawPreview extends StatelessWidget {
  const _RawPreview({required this.url, required this.isLoading});
  final String url;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: 'Link preview for $url',
      child: _Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Thumbnail(
              icon: Icons.link,
              isLoading: isLoading,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Link',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface.withOpacity(.9),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    url,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: scheme.onSurface.withOpacity(.65),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _OpenButton(url: url),
          ],
        ),
      ),
    );
  }
}

/// Shown when we have full metadata.
class _MetaPreview extends StatelessWidget {
  const _MetaPreview({required this.meta});
  final UrlMetadata meta;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: 'Link preview for ${meta.title}',
      child: _Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Thumbnail(imageUrl: meta.imageUrl),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meta.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface.withOpacity(.9),
                    ),
                  ),
                  if (meta.description case final d?)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        d,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: scheme.onSurface.withOpacity(.65),
                        ),
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    meta.domain,
                    style: TextStyle(
                      fontSize: 11,
                      color: scheme.onSurface.withOpacity(.55),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _OpenButton(url: meta.url),
          ],
        ),
      ),
    );
  }
}

/// Common card wrapper.
class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: scheme.outline.withOpacity(.15),
        ),
      ),
      child: child,
    );
  }
}

/// Thumbnail widget — shows icon while loading or when no image.
class _Thumbnail extends StatelessWidget {
  const _Thumbnail({this.imageUrl, this.icon, this.isLoading = false});
  final String? imageUrl;
  final IconData? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const size = 60.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: size,
        height: size,
        child: imageUrl == null
            ? Container(
                color: scheme.primaryContainer,
                child: Icon(
                  icon ?? Icons.link,
                  color: scheme.onPrimaryContainer,
                ),
              )
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                gaplessPlayback: true,
                errorBuilder: (_, __, ___) => Container(
                  color: scheme.primaryContainer,
                  child: Icon(
                    Icons.broken_image,
                    color: scheme.onPrimaryContainer,
                  ),
                ),
                loadingBuilder: (_, child, loading) {
                  return loading == null
                      ? child
                      : Container(
                          color: scheme.primaryContainer,
                          child: const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        );
                },
              ),
      ),
    );
  }
}

/// Opens URL with a small tap target.
class _OpenButton extends StatelessWidget {
  const _OpenButton({required this.url});
  final String url;

  Future<void> _open() async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.open_in_new, size: 18),
      onPressed: _open,
      splashRadius: 20,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
    );
  }
}

/* =================================================================
   DOMAIN LAYER  (pure Dart, no Flutter, fully testable)
   ================================================================= */

/// Immutable metadata object.
@immutable
class UrlMetadata {
  const UrlMetadata({
    required this.url,
    required this.title,
    required this.domain,
    this.description,
    this.imageUrl,
  });

  final String url;
  final String title;
  final String domain;
  final String? description;
  final String? imageUrl;

  Map<String, dynamic> toJson() => {
        'url': url,
        'title': title,
        'domain': domain,
        'description': description,
        'imageUrl': imageUrl,
      };

  factory UrlMetadata.fromJson(Map<String, dynamic> j) => UrlMetadata(
        url: j['url'],
        title: j['title'],
        domain: j['domain'],
        description: j['description'],
        imageUrl: j['imageUrl'],
      );
}

/// Parses HTML in an isolate so we never block the UI thread.
Future<UrlMetadata?> _parseHtml(String html, String url) async {
  return Isolate.run(() {
    final doc = html_parser.parse(html);
    String? title =
        doc.querySelector('meta[property="og:title"]')?.attributes['content'] ??
            doc
                .querySelector('meta[name="twitter:title"]')
                ?.attributes['content'] ??
            doc.querySelector('title')?.text;
    String? description = doc
            .querySelector('meta[property="og:description"]')
            ?.attributes['content'] ??
        doc
            .querySelector('meta[name="twitter:description"]')
            ?.attributes['content'] ??
        doc.querySelector('meta[name="description"]')?.attributes['content'];
    String? image = doc
            .querySelector('meta[property="og:image"]')
            ?.attributes['content'] ??
        doc.querySelector('meta[name="twitter:image"]')?.attributes['content'];

    title = title?.trim().replaceAll(RegExp(r'\s+'), ' ');
    description = description?.trim().replaceAll(RegExp(r'\s+'), ' ');
    image = image?.trim();
    if (image != null && image.startsWith('//')) image = 'https:$image';

    final uri = Uri.parse(url);
    final domain = uri.host.replaceAll('www.', '');

    if (title == null || title.isEmpty) return null;

    return UrlMetadata(
      url: url,
      title: title,
      domain: domain,
      description: description,
      imageUrl: image,
    );
  });
}

/// Fetches HTML with timeout + retry.
Future<String?> _fetchHtml(String url) async {
  final client = http.Client();
  try {
    final resp = await client.get(
      Uri.parse(url),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (compatible; Bot/1.0; +https://example.com/bot)'
      },
    ).timeout(const Duration(seconds: 8));
    if (resp.statusCode == 200) return resp.body;
  } on TimeoutException {
    debugPrint('Timeout for $url');
  } on SocketException {
    debugPrint('Offline for $url');
  } catch (e) {
    debugPrint('Fetch error for $url: $e');
  } finally {
    client.close();
  }
  return null;
}

/* =================================================================
   INFRASTRUCTURE LAYER  (Riverpod providers)
   ================================================================= */

/// In-memory + persisted cache object.
class _UrlCache extends Notifier<Map<String, UrlMetadata?>> {
  @override
  Map<String, UrlMetadata?> build() {
    _load();
    return {};
  }

  static const _key = 'url_metadata_cache';
  static const _ttl = Duration(hours: 24);

  DateTime? _lastPersisted;
  final _timestamps = <String, DateTime>{};

  Future<void> _load() async {
    final raw = await SecureStorage.instance.read(key: _key);
    if (raw == null) return;
    try {
      final map = Map<String, dynamic>.from(jsonDecode(raw));
      final cached = map.map((k, v) => MapEntry(k, UrlMetadata.fromJson(v)));
      state = cached;
    } catch (_) {}
  }

  Future<void> _persist() async {
    final now = DateTime.now();
    if (_lastPersisted != null && now.difference(_lastPersisted!) < _ttl)
      return;
    _lastPersisted = now;
    final encoded = jsonEncode(state.map((k, v) => MapEntry(k, v?.toJson())));
    await SecureStorage.instance.write(key: _key, value: encoded);
  }

  UrlMetadata? get(String url) {
    final meta = state[url];
    if (meta == null) return null;
    final ts = _timestamps[url];
    if (ts != null && DateTime.now().difference(ts) > _ttl) {
      state.remove(url);
      _timestamps.remove(url);
      return null;
    }
    return meta;
  }

  void set(String url, UrlMetadata? meta) {
    state = {...state, url: meta};
    _timestamps[url] = DateTime.now();
    _persist();
  }
}

final _cacheProvider =
    NotifierProvider<_UrlCache, Map<String, UrlMetadata?>>(_UrlCache.new);

/// Single source of truth for a given URL.
final urlMetadataProvider =
    FutureProvider.family<UrlMetadata?, String>((ref, url) async {
  final cache = ref.read(_cacheProvider.notifier);
  final cached = cache.get(url);
  if (cached != null) return cached;

  final html = await _fetchHtml(url);
  if (html == null) return null;

  final meta = await _parseHtml(html, url);
  if (meta != null) cache.set(url, meta);
  return meta;
});

/* =================================================================
   HELPERS  (secure storage abstraction)
   ================================================================= */

/// Thin wrapper so we can swap implementation (flutter_secure_storage, shared_preferences, etc.).
class SecureStorage {
  const SecureStorage._();
  static SecureStorage get instance => const SecureStorage._();

  Future<String?> read({required String key}) async {
    // TODO: plug flutter_secure_storage here
    return null;
  }

  Future<void> write({required String key, required String value}) async {
    // TODO: plug flutter_secure_storage here
  }
}
