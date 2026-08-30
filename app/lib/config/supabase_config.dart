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
