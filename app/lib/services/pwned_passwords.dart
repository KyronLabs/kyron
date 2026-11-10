import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

/// Whether a password appears in a known data breach, from Have I Been
/// Pwned's range API.
///
/// Supabase does this on the server only on its paid plans, so the app asks
/// instead, before a password is set: at sign-up and when it is changed.
///
/// The password never leaves the phone. Only the first five characters of
/// its SHA-1 hash are sent; the service answers with every breached hash
/// starting with them, padded with decoys so the reply's size says nothing
/// either, and the match is made here.
///
/// A check the app makes can be skipped by calling Supabase directly. It is
/// not meant to stop an attacker -- it stops a person choosing a password
/// that is already in the lists attackers try first.
class PwnedPasswords {
  PwnedPasswords({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const timeout = Duration(seconds: 5);

  /// True when [password] is in a breach. False when it is not, and also
  /// when the service cannot be reached: an outage there must not stop
  /// anybody signing up.
  Future<bool> isBreached(String password) async {
    final hash = sha1.convert(utf8.encode(password)).toString().toUpperCase();
    final prefix = hash.substring(0, 5);
    final suffix = hash.substring(5);
    try {
      final response = await _client.get(
        Uri.parse('https://api.pwnedpasswords.com/range/$prefix'),
        headers: const {'Add-Padding': 'true'},
      ).timeout(timeout);
      if (response.statusCode != 200) return false;
      for (final line in const LineSplitter().convert(response.body)) {
        final split = line.indexOf(':');
        if (split < 0) continue;
        if (line.substring(0, split) != suffix) continue;
        // Padding entries carry a count of 0.
        return (int.tryParse(line.substring(split + 1).trim()) ?? 0) > 0;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
