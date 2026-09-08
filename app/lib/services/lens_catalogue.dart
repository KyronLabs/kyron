// lib/services/lens_catalogue.dart
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/lens.dart';
import 'app_log.dart';

/// The lenses the camera offers: the ones built into the app, plus whatever
/// the catalogue adds.
///
/// The point of this is that a new lens does not need an app release. A lens
/// is twenty numbers (see [Lens]), so publishing one is publishing a line of
/// JSON -- no store review, no version anybody has to install.
///
/// Three rules, in this order:
///
/// 1. **The built-ins always win.** They are bundled, they work offline, and a
///    catalogue cannot replace or remove them. A published file that redefined
///    `mono` could otherwise change what somebody's saved photographs looked
///    like, or empty the strip entirely.
/// 2. **The cache is used before the network.** The strip is drawn from disk
///    immediately; the fetch refreshes it for next time. A camera that waits
///    on a request before it can show a lens is a camera that is slow.
/// 3. **Every failure ends at the built-ins.** No network, bad JSON, a
///    hostile file, a server that is down -- all of them leave seven working
///    lenses rather than an error.
class LensCatalogue {
  final http.Client _http;
  final Future<Directory> Function() _directory;

  LensCatalogue({http.Client? client, Future<Directory> Function()? directory})
      : _http = client ?? http.Client(),
        _directory = directory ?? getApplicationSupportDirectory;

  /// Where the published catalogue lives.
  ///
  /// GitHub Pages, published from the kyron-lenses repository by its own CI.
  /// A stable public URL on a CDN needing no token, which is what fetching a
  /// file at runtime requires -- and until Pages is switched on there it
  /// answers 404, which this treats as "no catalogue" and falls back to the
  /// built-ins. Nothing breaks; nothing new appears.
  ///
  /// Overridable at build time so a staging build can point somewhere else:
  /// `--dart-define=KYRON_LENS_CATALOGUE=https://...`. Empty disables the
  /// fetch entirely and leaves the built-ins, which is what a build with no
  /// catalogue to talk to should do.
  static const catalogueUrl = String.fromEnvironment(
    'KYRON_LENS_CATALOGUE',
    defaultValue: 'https://kyronlabs.github.io/kyron-lenses/lenses.json',
  );

  /// A ceiling on the published file, so a wrong URL cannot pull down
  /// something enormous onto a phone. A thousand lenses is roughly 300 KB.
  static const maxBytes = 512 * 1024;

  /// How many lenses may come from the catalogue. The strip is a horizontal
  /// list somebody scrolls with a thumb; past this it is not a feature.
  static const maxRemote = 120;

  static const _cacheFile = 'lenses.json';

  List<Lens>? _resolved;

  /// Everything to show, built-ins first.
  ///
  /// Answers from memory after the first call. Cheap enough to call from a
  /// build method.
  Future<List<Lens>> lenses() async {
    final already = _resolved;
    if (already != null) return already;

    final cached = await _readCache();
    final resolved = _merge(cached);
    _resolved = resolved;
    return resolved;
  }

  /// Fetches the published catalogue and writes it to the cache.
  ///
  /// Answers with the merged list when something changed, and null when
  /// nothing did -- so a caller can avoid a rebuild it does not need. Never
  /// throws: the camera works without this having succeeded.
  Future<List<Lens>?> refresh() async {
    if (catalogueUrl.isEmpty) return null;

    final Uri url;
    try {
      url = Uri.parse(catalogueUrl);
    } catch (_) {
      AppLog.instance.error('lens', 'The catalogue URL is not a URL.');
      return null;
    }

    try {
      final response = await _http.get(url).timeout(const Duration(seconds: 8));

      if (response.statusCode != 200) {
        AppLog.instance.error(
          'lens',
          'The lens catalogue answered ${response.statusCode}.',
        );
        return null;
      }
      if (response.bodyBytes.length > maxBytes) {
        AppLog.instance.error(
          'lens',
          'The lens catalogue is ${response.bodyBytes.length} bytes, over the '
              '$maxBytes ceiling. Ignored.',
        );
        return null;
      }

      final fetched = parse(response.body);
      if (fetched.isEmpty) return null;

      await _writeCache(response.body);

      final resolved = _merge(fetched);
      _resolved = resolved;
      return resolved;
    } catch (error) {
      // Offline is the ordinary case here, not an incident.
      AppLog.instance.info('lens', 'Could not refresh the catalogue: $error');
      return null;
    }
  }

  /// Reads a published catalogue. Static and separate so it can be tested
  /// against real files without a network or a disk.
  ///
  /// Drops entries it cannot read and says which, rather than refusing the
  /// whole file: one bad lens should cost one lens.
  static List<Lens> parse(String body) {
    final Object? decoded;
    try {
      decoded = jsonDecode(body);
    } catch (_) {
      AppLog.instance.error('lens', 'The lens catalogue is not JSON.');
      return const [];
    }

    if (decoded is! Map || decoded['lenses'] is! List) {
      AppLog.instance.error(
        'lens',
        'The lens catalogue has no "lenses" list in it.',
      );
      return const [];
    }

    final lenses = <Lens>[];
    var dropped = 0;
    for (final entry in decoded['lenses'] as List) {
      final lens = Lens.tryParse(entry);
      if (lens == null) {
        dropped += 1;
        continue;
      }
      lenses.add(lens);
      if (lenses.length >= maxRemote) break;
    }

    if (dropped > 0) {
      AppLog.instance.error(
        'lens',
        '$dropped lens(es) in the catalogue could not be read and were '
            'dropped. Check them against docs/LENS_FORMAT.md.',
      );
    }
    return lenses;
  }

  /// Built-ins, then everything else, with duplicates of a built-in id
  /// discarded.
  List<Lens> _merge(List<Lens> extra) {
    final seen = Lens.builtIn.map((lens) => lens.id).toSet();
    final merged = <Lens>[...Lens.builtIn];

    for (final lens in extra) {
      // A catalogue that redefines `mono` would change what a lens somebody
      // has already used looks like. The built-in wins and this is not an
      // error worth interrupting anybody for.
      if (!seen.add(lens.id)) continue;
      merged.add(lens);
    }
    return merged;
  }

  Future<List<Lens>> _readCache() async {
    try {
      final file = File(p.join((await _directory()).path, _cacheFile));
      if (!await file.exists()) return const [];
      return parse(await file.readAsString());
    } catch (error) {
      AppLog.instance.info('lens', 'No usable cached catalogue: $error');
      return const [];
    }
  }

  Future<void> _writeCache(String body) async {
    try {
      final file = File(p.join((await _directory()).path, _cacheFile));
      await file.writeAsString(body, flush: true);
    } catch (error) {
      // The lenses are in memory and work for this run; the next launch just
      // fetches again.
      AppLog.instance.info('lens', 'Could not cache the catalogue: $error');
    }
  }
}
