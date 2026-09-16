import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/services/gif_search.dart';

/// The GIF picker was on Tenor, which has stopped taking new sign-ups. GIPHY's
/// response is a different shape in three ways that would each have produced a
/// silently empty grid: the list is `data` rather than `results`, the
/// renditions are under `images` rather than `media_formats`, and the sizes
/// arrive as strings.
class _Giphy implements HttpClientAdapter {
  _Giphy(this.body);
  final Map<String, dynamic> body;
  Uri? asked;

  @override
  Future<ResponseBody> fetch(RequestOptions options, _, __) async {
    asked = options.uri;
    return ResponseBody.fromString(
      _encode(body),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

String _encode(Object? value) => const JsonCodec().encode(value);

Map<String, dynamic> _gif({
  String id = 'g1',
  String title = 'a cat, falling over',
}) => {
  'id': id,
  'title': title,
  'images': {
    'original': {
      'url': 'https://media.giphy.com/$id/giphy.gif',
      'width': '480',
      'height': '270',
    },
    'downsized': {
      'url': 'https://media.giphy.com/$id/downsized.gif',
      'width': '320',
      'height': '180',
    },
    'fixed_width_small': {
      'url': 'https://media.giphy.com/$id/200w_s.gif',
      'width': '100',
      'height': '56',
    },
  },
};

void main() {
  /// A key, so the parsing is actually reached. Without one every call
  /// returns an empty list before it asks anything, and a test of the
  /// response shape passes by doing nothing -- which is what the first draft
  /// of this file did in CI, where no key is defined.
  GifSearch searchWith(_Giphy adapter) =>
      GifSearch(client: Dio()..httpClientAdapter = adapter, key: 'test-key');

  test('reads a GIPHY result', () async {
    final adapter = _Giphy({
      'data': [_gif()],
    });
    final results = await searchWith(adapter).search('cat');

    expect(results, hasLength(1));
    final gif = results.single;
    expect(gif.id, 'g1');
    expect(gif.description, 'a cat, falling over');
    // downsized, not original: an original runs to tens of megabytes and this
    // is a picture going into a post.
    expect(gif.url, endsWith('downsized.gif'));
    expect(gif.previewUrl, endsWith('200w_s.gif'));
    // Strings on the wire, numbers here.
    expect(gif.width, 320);
    expect(gif.height, 180);
  });

  test('says nothing without a key rather than asking anyway', () async {
    final adapter = _Giphy({
      'data': [_gif()],
    });
    final results = await GifSearch(
      client: Dio()..httpClientAdapter = adapter,
      key: '',
    ).featured();

    expect(results, isEmpty);
    expect(adapter.asked, isNull, reason: 'it called GIPHY with no key');
  });

  test('asks the right endpoints, and caps the rating', () async {
    final adapter = _Giphy({'data': <Object>[]});
    await searchWith(adapter).featured();
    expect(adapter.asked!.path, endsWith('/trending'));
    expect(adapter.asked!.queryParameters['rating'], 'pg-13');

    await searchWith(adapter).search('cat');
    expect(adapter.asked!.path, endsWith('/search'));
    expect(adapter.asked!.queryParameters['q'], 'cat');
  });

  test('drops an entry with no renditions instead of the whole list', () async {
    final adapter = _Giphy({
      'data': [
        {'id': 'broken', 'title': 'no images key'},
        _gif(id: 'g2'),
      ],
    });
    final results = await searchWith(adapter).search('cat');

    expect(results.map((it) => it.id), ['g2']);
  });

  test('the attribution GIPHY requires is a real string', () {
    // Its free tier is conditional on the mark being shown, and the picker
    // draws this. An empty one would draw nothing and still look fine.
    expect(GifSearch.attribution.trim(), isNotEmpty);
    expect(GifSearch.attribution.toLowerCase(), contains('giphy'));
  });
}
