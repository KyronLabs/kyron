import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:kyron_app/services/pwned_passwords.dart';

String _hash(String p) => sha1.convert(utf8.encode(p)).toString().toUpperCase();

void main() {
  test('only the first five characters of the hash are sent', () async {
    Uri? asked;
    final pwned = PwnedPasswords(
      client: MockClient((request) async {
        asked = request.url;
        expect(request.headers['Add-Padding'], 'true');
        return http.Response('', 200);
      }),
    );
    await pwned.isBreached('hunter2');
    expect(asked!.pathSegments.last, _hash('hunter2').substring(0, 5));
    expect(asked.toString(), isNot(contains('hunter2')));
  });

  test('a password in a breach is caught', () async {
    final suffix = _hash('password123').substring(5);
    final pwned = PwnedPasswords(
      client: MockClient(
        (_) async => http.Response('AAAAA:3\r\n$suffix:2254650\r\n', 200),
      ),
    );
    expect(await pwned.isBreached('password123'), isTrue);
  });

  test('a padding entry, count 0, is not a breach', () async {
    final suffix = _hash('Correct horse 7!').substring(5);
    final pwned = PwnedPasswords(
      client: MockClient((_) async => http.Response('$suffix:0', 200)),
    );
    expect(await pwned.isBreached('Correct horse 7!'), isFalse);
  });

  test('an outage never blocks anybody', () async {
    final pwned = PwnedPasswords(
      client: MockClient((_) async => throw Exception('offline')),
    );
    expect(await pwned.isBreached('anything'), isFalse);
  });
}
