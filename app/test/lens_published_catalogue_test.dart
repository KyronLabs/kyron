import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/lens.dart';
import 'package:kyron_app/services/lens_catalogue.dart';

/// The catalogue that actually gets published, read by the code that will
/// actually read it.
///
/// The authoring tool has its own copy of these rules in Python. If the two
/// drift, a lens passes `lens.py check`, gets published, and then silently
/// does not appear on anybody's phone -- with the log line explaining why
/// sitting on the device rather than in front of whoever published it. This
/// test is what stops that being discovered in production.
void main() {
  final file = File('../lenses/lenses.json');

  test('the published catalogue is one this app can read', () {
    expect(
      file.existsSync(),
      isTrue,
      reason: 'lenses/lenses.json is the source of truth and should be here',
    );

    final lenses = LensCatalogue.parse(file.readAsStringSync());

    // Not "some parsed" -- every single entry. A dropped lens is the exact
    // failure this is looking for, and parse() drops silently by design.
    final published = file.readAsStringSync();
    final entries = RegExp(r'"id"\s*:').allMatches(published).length;
    expect(
      lenses,
      hasLength(entries),
      reason: 'every published lens must survive Lens.tryParse',
    );
  });

  test('it carries the built-ins, so a future client needs no bundle', () {
    final lenses = LensCatalogue.parse(file.readAsStringSync());
    final ids = lenses.map((lens) => lens.id).toSet();

    for (final builtIn in Lens.builtIn) {
      expect(ids, contains(builtIn.id), reason: builtIn.id);
    }
  });

  test('the built-in matrices in the catalogue match the app exactly', () {
    // The catalogue is generated from the Dart. If somebody tunes a matrix in
    // one place and not the other, the lens looks different depending on
    // whether the catalogue loaded -- which is the least debuggable bug
    // available here.
    final published = {
      for (final lens in LensCatalogue.parse(file.readAsStringSync()))
        lens.id: lens,
    };

    for (final builtIn in Lens.builtIn) {
      expect(
        published[builtIn.id]!.matrix,
        builtIn.matrix,
        reason: '${builtIn.id} differs between the app and the catalogue',
      );
    }
  });
}
