import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/lens.dart';

/// One spec, two implementations.
///
/// `Lens.tryParse` here and `problems()` in `tools/lens.py` over in
/// [kyron-lenses](https://github.com/KyronLabs/kyron-lenses) apply the same
/// rules in different languages. Nothing about being in separate repositories
/// makes them agree, and the failure when they stop is quiet: a lens passes
/// the authoring tool, gets published, and is then dropped by the app --
/// leaving its explanation in a log line on a stranger's phone.
///
/// So both sides run this file. It is canonical over there and vendored here;
/// CI checks the two copies are identical, so a rule added there fails the
/// build here until somebody confirms this implementation agrees.
///
/// **Adding a rule means adding a case.**
void main() {
  final spec = jsonDecode(
    File('test/format-vectors.json').readAsStringSync(),
  ) as Map<String, dynamic>;

  final cases = (spec['cases'] as List).cast<Map<String, dynamic>>();

  test('the spec is not empty, in case the file went missing', () {
    // A vendored file that silently became `{"cases": []}` would make every
    // test below pass by having nothing to run.
    expect(cases.length, greaterThan(30));
    expect(cases.where((c) => c['accept'] == true), isNotEmpty);
    expect(cases.where((c) => c['accept'] == false), isNotEmpty);
  });

  for (final one in cases) {
    final id = one['id'] as String;
    final shouldAccept = one['accept'] as bool;

    test('${shouldAccept ? 'accepts' : 'refuses'} $id', () {
      final parsed = Lens.tryParse(one['lens']);

      expect(
        parsed != null,
        shouldAccept,
        reason: '${one['why']}\n'
            'This implementation ${parsed == null ? 'refused' : 'accepted'} it; '
            'the spec says it should be '
            '${shouldAccept ? 'accepted' : 'refused'}.\n'
            'If the rule genuinely changed, change lens.py too -- they are two '
            'halves of one thing.',
      );
    });
  }
}
