import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:kyron_app/models/lens.dart';
import 'package:kyron_app/services/lens_catalogue.dart';

/// A lens as the catalogue would publish it.
Map<String, Object?> published(
  String id, {
  String? name,
  List<double>? matrix,
}) =>
    {
      'id': id,
      'name': name ?? id,
      'matrix': matrix ?? List<double>.filled(Lens.matrixLength, 0.5),
    };

String catalogue(List<Object?> lenses) => jsonEncode({'lenses': lenses});

void main() {
  group('Lens.tryParse', () {
    test('reads a published lens', () {
      final lens = Lens.tryParse(published('sepia', name: 'Sepia'));

      expect(lens, isNotNull);
      expect(lens!.id, 'sepia');
      expect(lens.name, 'Sepia');
      expect(lens.matrix, hasLength(Lens.matrixLength));
      expect(lens.filter, isNotNull);
    });

    test('survives a round trip through JSON', () {
      // What the authoring tool writes has to be what the app reads.
      final original = Lens.builtIn.firstWhere((l) => l.id == 'punch');
      final round = Lens.tryParse(jsonDecode(jsonEncode(original.toJson())));

      expect(round!.id, original.id);
      expect(round.matrix, original.matrix);
    });

    test('refuses a matrix of the wrong length', () {
      // Nineteen numbers is not a lens missing a number, it is a file that
      // cannot be trusted about anything.
      for (final length in [0, 19, 21, 100]) {
        expect(
          Lens.tryParse({
            'id': 'x',
            'name': 'X',
            'matrix': List<double>.filled(length, 1),
          }),
          isNull,
          reason: 'length $length',
        );
      }
    });

    test('refuses NaN and infinity', () {
      // Both survive some JSON encoders and both poison every pixel they
      // touch: a single NaN turns the whole frame transparent.
      for (final poison in [double.nan, double.infinity, -double.infinity]) {
        final matrix = List<double>.filled(Lens.matrixLength, 0.5);
        matrix[7] = poison;
        expect(
          Lens.tryParse({'id': 'x', 'name': 'X', 'matrix': matrix}),
          isNull,
          reason: '$poison',
        );
      }
    });

    test('refuses absurd coefficients but allows real ones', () {
      final wild = List<double>.filled(Lens.matrixLength, 0.5);
      wild[0] = 1e9;
      expect(Lens.tryParse({'id': 'x', 'name': 'X', 'matrix': wild}), isNull);

      // Punch peaks at 1.47 and has to keep working.
      final punch = Lens.builtIn.firstWhere((l) => l.id == 'punch');
      expect(
        Lens.tryParse({'id': 'p', 'name': 'P', 'matrix': punch.matrix}),
        isNotNull,
      );
    });

    test('allows a full-range offset, which is not a coefficient', () {
      // The fifth of each row is an offset in 0-255, so it is held to a
      // different limit than the four before it.
      final matrix = List<double>.filled(Lens.matrixLength, 0.5);
      matrix[4] = 200;
      expect(
        Lens.tryParse({'id': 'x', 'name': 'X', 'matrix': matrix}),
        isNotNull,
      );

      matrix[4] = 4000;
      expect(Lens.tryParse({'id': 'x', 'name': 'X', 'matrix': matrix}), isNull);
    });

    test('refuses an id that is not an id', () {
      // Ids are cache keys and appear in log lines.
      for (final id in [
        '',
        '../etc',
        'Has Spaces',
        'CAPS',
        '-leading',
        'a' * 60
      ]) {
        expect(
          Lens.tryParse({'id': id, 'name': 'X'}),
          isNull,
          reason: id,
        );
      }
    });

    test('refuses a missing or empty name', () {
      expect(Lens.tryParse({'id': 'x'}), isNull);
      expect(Lens.tryParse({'id': 'x', 'name': '   '}), isNull);
    });

    test('refuses things that are not lenses at all', () {
      for (final junk in [
        null,
        'a string',
        42,
        <int>[1, 2, 3]
      ]) {
        expect(Lens.tryParse(junk), isNull, reason: '$junk');
      }
    });

    test('reads the identity lens, which has no matrix', () {
      final lens = Lens.tryParse({'id': 'plain', 'name': 'Plain'});
      expect(lens, isNotNull);
      expect(lens!.filter, isNull);
    });
  });

  group('LensCatalogue.parse', () {
    test('reads a whole catalogue', () {
      final lenses = LensCatalogue.parse(
        catalogue([published('a'), published('b')]),
      );
      expect(lenses.map((l) => l.id), ['a', 'b']);
    });

    test('drops one bad lens rather than the whole file', () {
      // One typo in a published catalogue should cost one lens.
      final lenses = LensCatalogue.parse(
        catalogue([
          published('good'),
          {
            'id': 'bad',
            'name': 'Bad',
            'matrix': <double>[1, 2]
          },
          published('alsogood'),
        ]),
      );
      expect(lenses.map((l) => l.id), ['good', 'alsogood']);
    });

    test('answers nothing for a file that is not a catalogue', () {
      expect(LensCatalogue.parse('not json'), isEmpty);
      expect(LensCatalogue.parse('{}'), isEmpty);
      expect(LensCatalogue.parse('{"lenses": "no"}'), isEmpty);
      expect(LensCatalogue.parse('[]'), isEmpty);
    });

    test('stops at the ceiling rather than filling the strip', () {
      final many = List.generate(
        LensCatalogue.maxRemote + 50,
        (i) => published('lens$i'),
      );
      expect(
        LensCatalogue.parse(catalogue(many)),
        hasLength(LensCatalogue.maxRemote),
      );
    });
  });

  group('LensCatalogue', () {
    late Directory temp;

    setUp(() => temp = Directory.systemTemp.createTempSync('lenses'));
    tearDown(() => temp.deleteSync(recursive: true));

    LensCatalogue build(http.Client client) =>
        LensCatalogue(client: client, directory: () async => temp);

    test('answers the built-ins when there is nothing else', () async {
      final subject = build(MockClient((_) async => http.Response('', 500)));
      expect(await subject.lenses(), Lens.builtIn);
    });

    test('adds what the catalogue publishes, after the built-ins', () async {
      final subject = build(
        MockClient(
          (_) async => http.Response(catalogue([published('sepia')]), 200),
        ),
      );

      final lenses = await subject.refresh();

      expect(lenses, isNotNull);
      expect(lenses!.take(Lens.builtIn.length), Lens.builtIn);
      expect(lenses.last.id, 'sepia');
    });

    test('will not let a catalogue redefine a built-in', () async {
      // A published file that redefined `mono` would change what somebody's
      // saved photographs looked like.
      final hostile = List<double>.filled(Lens.matrixLength, 2.0);
      final subject = build(
        MockClient(
          (_) async => http.Response(
            catalogue([published('mono', name: 'Hijacked', matrix: hostile)]),
            200,
          ),
        ),
      );

      final lenses = await subject.refresh();

      final mono = lenses!.where((l) => l.id == 'mono');
      expect(mono, hasLength(1));
      expect(mono.first.name, 'Mono');
      expect(mono.first.matrix, isNot(hostile));
    });

    test('keeps the built-ins when the server errors', () async {
      final subject = build(MockClient((_) async => http.Response('', 503)));
      expect(await subject.refresh(), isNull);
      expect(await subject.lenses(), Lens.builtIn);
    });

    test('keeps the built-ins when the server sends rubbish', () async {
      final subject = build(
        MockClient((_) async => http.Response('<html>nope</html>', 200)),
      );
      expect(await subject.refresh(), isNull);
      expect(await subject.lenses(), Lens.builtIn);
    });

    test('keeps the built-ins when the network is gone', () async {
      final subject = build(
        MockClient((_) async => throw const SocketException('offline')),
      );
      expect(await subject.refresh(), isNull);
      expect(await subject.lenses(), Lens.builtIn);
    });

    test('refuses a file over the ceiling', () async {
      // A wrong URL should not pull something enormous onto a phone.
      final huge = 'x' * (LensCatalogue.maxBytes + 1);
      final subject = build(MockClient((_) async => http.Response(huge, 200)));
      expect(await subject.refresh(), isNull);
    });

    test('serves the cache before the network', () async {
      // Written by a previous run.
      File('${temp.path}/lenses.json')
          .writeAsStringSync(catalogue([published('cached')]));

      var called = false;
      final subject = build(MockClient((_) async {
        called = true;
        return http.Response('', 500);
      }));

      final lenses = await subject.lenses();

      expect(lenses.last.id, 'cached');
      expect(called, isFalse, reason: 'the strip must not wait on a request');
    });

    test('caches what it fetched, for the next launch', () async {
      final subject = build(
        MockClient(
          (_) async => http.Response(catalogue([published('fresh')]), 200),
        ),
      );
      await subject.refresh();

      final next = build(MockClient((_) async => http.Response('', 500)));
      expect((await next.lenses()).last.id, 'fresh');
    });
  });
}
