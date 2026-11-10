import 'package:supabase_flutter/supabase_flutter.dart';

/// Two-step sign-in for staff: an authenticator app's six-digit code, on top
/// of the password or Google sign-in.
///
/// Supabase keeps the factors and checks the codes; a session that has
/// passed one carries `aal2` in its token, which the API asks of staff
/// powers (STAFF_REQUIRE_SECOND_FACTOR). Only staff are ever shown any of
/// this.
class SecondFactor {
  SecondFactor({GoTrueClient? auth})
      : _auth = auth ?? Supabase.instance.client.auth;

  final GoTrueClient _auth;

  /// The enrolled, confirmed authenticator, if there is one.
  Future<Factor?> verifiedFactor() async {
    final factors = await _auth.mfa.listFactors();
    for (final factor in factors.totp) {
      if (factor.status == FactorStatus.verified) return factor;
    }
    return null;
  }

  /// Whether this session has already passed the second factor.
  bool get sessionPassed =>
      _auth.mfa.getAuthenticatorAssuranceLevel().currentLevel ==
      AuthenticatorAssuranceLevels.aal2;

  /// Starts enrolling an authenticator. Returns the factor to confirm and
  /// the QR code (SVG) and setup key to show.
  ///
  /// A setup abandoned halfway leaves an unconfirmed factor behind, and a
  /// second enrolment beside it is refused; those are cleared first.
  Future<({String factorId, String qrSvg, String secret})> start() async {
    final factors = await _auth.mfa.listFactors();
    for (final factor in factors.totp) {
      if (factor.status != FactorStatus.verified) {
        await _auth.mfa.unenroll(factor.id);
      }
    }
    final enrolled = await _auth.mfa.enroll(
      factorType: FactorType.totp,
      issuer: 'Kyron',
      friendlyName: 'Authenticator',
    );
    final totp = enrolled.totp!;
    return (factorId: enrolled.id, qrSvg: totp.qrCode, secret: totp.secret);
  }

  /// Checks a code against [factorId]. Confirms a new enrolment, or lifts
  /// this session to `aal2`; throws when the code is wrong.
  Future<void> verify(String factorId, String code) async {
    await _auth.mfa.challengeAndVerify(factorId: factorId, code: code.trim());
  }

  /// Removes the authenticator. Supabase asks for a session that has
  /// passed it first.
  Future<void> remove(String factorId) async {
    await _auth.mfa.unenroll(factorId);
  }
}
