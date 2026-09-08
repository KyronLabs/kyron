/// Supabase connection settings.
///
/// The anon key is designed to be shipped in clients -- it grants only what
/// row level security allows -- so committing one is safe. Committing the
/// *wrong* one is not: the default here once named a different project
/// entirely, so every build that did not pass --dart-define signed users in
/// against it. Thirteen accounts were created there before anyone noticed,
/// and the API -- pointed at the real project -- refused every token those
/// sign-ins produced, because the two were never issued by the same Supabase.
///
/// Nothing in the app can tell that a key belongs to another project: it is
/// opaque, and a wrong one fails as an authorization error on the first
/// request, far from the cause. So the values are checked for presence at
/// launch by [assertConfigured], and the pair is checked against each other
/// by the API, which reports the issuer it accepts on GET /health.
///
/// Override per build with:
///   flutter build apk --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
class SupabaseConfig {
  const SupabaseConfig._();

  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://zgzvclssemsyctstwgod.supabase.co',
  );

  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpnenZjbHNzZW1zeWN0c3R3Z29kIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQxNTkyODgsImV4cCI6MjA3OTczNTI4OH0.Yq-yTerb4EI4Qi-jpgKYZHtIUik5PkLxArxqK_cngOE',
  );

  /// Where Supabase sends someone after they tap a link in one of its emails.
  ///
  /// Confirmation and password-reset mails were arriving with no redirect at
  /// all, so Supabase fell back to the project's Site URL -- which is a
  /// developer's `http://localhost:3000`. Tapping "reset my password" on a
  /// phone opened a browser tab that could not connect to anything, and the
  /// account stayed locked.
  ///
  /// A custom scheme rather than an https link: an https one has to be proven
  /// to belong to the app (assetlinks.json on the domain, an entitlement on
  /// iOS) and silently opens the browser instead when that proof is missing or
  /// stale, which is the failure being fixed here. The scheme is the
  /// application id backwards-compatible with itself, so it cannot collide
  /// with another app on the device.
  ///
  /// **This value must also be listed** under Authentication → URL
  /// Configuration → Redirect URLs in the Supabase dashboard. Supabase
  /// silently falls back to the Site URL for any redirect not on that list,
  /// which looks exactly like this bug. See docs/AUTH_EMAILS.md.
  static const String authRedirect = 'so.kyron.app://auth-callback';

  /// Throws unless both values are present, naming the one that is not.
  ///
  /// Reached when a build passes an empty --dart-define, which otherwise
  /// overrides the defaults above with nothing. Supabase.initialize accepts an
  /// empty key happily and fails later, on the first request.
  static void assertConfigured() {
    if (url.trim().isEmpty) {
      throw StateError(
        'SUPABASE_URL is empty. Pass it with '
        '--dart-define=SUPABASE_URL=https://<project-ref>.supabase.co',
      );
    }
    if (anonKey.trim().isEmpty) {
      throw StateError(
        'SUPABASE_ANON_KEY is empty, so this build cannot reach Supabase. '
        'Pass the anon key for $url with '
        '--dart-define=SUPABASE_ANON_KEY=...',
      );
    }
  }
}
