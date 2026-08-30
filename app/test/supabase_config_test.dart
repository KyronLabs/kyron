import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/config/supabase_config.dart';

/// Extracts the project ref a legacy Supabase anon key was issued for.
///
/// Legacy keys are JWTs carrying `{"ref": "<project-ref>", "role": "anon"}`.
/// The newer `sb_publishable_...` keys are opaque, so this returns null for
/// them and the check below skips rather than pretending to have verified
/// something.
String? projectRefOf(String anonKey) {
  final parts = anonKey.split('.');
  if (parts.length != 3) return null;
  try {
    final payload = parts[1];
    final normalised = base64Url.normalize(payload);
    final claims = jsonDecode(utf8.decode(base64Url.decode(normalised))) as Map;
    final ref = claims['ref'];
    return ref is String ? ref : null;
  } catch (_) {
    return null;
  }
}

String? projectRefOfUrl(String url) =>
    RegExp(r'^https://([a-z0-9]+)\.supabase\.co/?$').firstMatch(url)?.group(1);

void main() {
  group('SupabaseConfig', () {
    test('is populated', () {
      expect(SupabaseConfig.url.trim(), isNotEmpty);
      expect(SupabaseConfig.anonKey.trim(), isNotEmpty);
      expect(SupabaseConfig.assertConfigured, returnsNormally);
    });

    test('the URL names a Supabase project', () {
      expect(
        projectRefOfUrl(SupabaseConfig.url),
        isNotNull,
        reason: 'SUPABASE_URL should be https://<project-ref>.supabase.co, '
            'got "${SupabaseConfig.url}"',
      );
    });

    test('the anon key belongs to the project the URL names', () {
      // The bug this exists for: the URL and the key named two different
      // projects, so the app signed users in against one Supabase while the
      // API verified tokens against another. Every authenticated request 401'd
      // and the app reported it as an expired session. Nothing at runtime can
      // notice -- a key is opaque and a wrong one fails much later, as an
      // authorization error -- but the pair can be checked here for free.
      final keyRef = projectRefOf(SupabaseConfig.anonKey);
      if (keyRef == null) {
        // An sb_publishable_... key carries no ref. Nothing to compare.
        return;
      }
      expect(
        keyRef,
        projectRefOfUrl(SupabaseConfig.url),
        reason: 'SUPABASE_ANON_KEY was issued for project "$keyRef" but '
            'SUPABASE_URL points at "${projectRefOfUrl(SupabaseConfig.url)}". '
            'They must be the same project.',
      );
    });

    test('the key is an anon key, not a service role key', () {
      // A service_role key bypasses row level security entirely. Shipping one
      // in a client hands every reader full read and write access to the
      // database, and it would otherwise "work", so nothing would flag it.
      final parts = SupabaseConfig.anonKey.split('.');
      if (parts.length != 3) return;
      final claims = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      ) as Map;
      expect(claims['role'], isNot('service_role'));
    });
  });

  group('projectRefOf', () {
    test('returns null for an opaque publishable key', () {
      expect(projectRefOf('sb_publishable_abc123'), isNull);
    });

    test('returns null for a JWT with no ref claim', () {
      String seg(Object o) =>
          base64Url.encode(utf8.encode(jsonEncode(o))).replaceAll('=', '');
      final token = '${seg({'alg': 'HS256'})}.${seg({'sub': 'x'})}.sig';
      expect(projectRefOf(token), isNull);
    });

    test('reads the ref out of a legacy anon key', () {
      String seg(Object o) =>
          base64Url.encode(utf8.encode(jsonEncode(o))).replaceAll('=', '');
      final token = '${seg({'alg': 'HS256'})}'
          '.${seg({'ref': 'abcdefghijklmnop', 'role': 'anon'})}.sig';
      expect(projectRefOf(token), 'abcdefghijklmnop');
    });
  });
}
