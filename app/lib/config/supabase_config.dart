/// Supabase connection settings.
///
/// The publishable key is designed to be shipped in clients -- it grants only
/// what row level security allows -- so committing one is safe. Committing the
/// *wrong* one is not: the previous default here named a different project
/// entirely, so every build that did not pass --dart-define signed users in
/// against it. Thirteen accounts were created there before anyone noticed,
/// and the API -- pointed at the real project -- refused every token those
/// sign-ins produced, because the two were never issued by the same Supabase.
///
/// Hence [assertConfigured]: an empty key stops the app at launch with a
/// message naming what is missing, rather than silently sending credentials
/// somewhere they do not belong.
///
/// Override per build with:
///   flutter build apk --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
class SupabaseConfig {
  const SupabaseConfig._();

  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://zgzvclssemsyctstwgod.supabase.co',
  );

  /// No default: an absent key is caught by [assertConfigured] at launch,
  /// which is the whole point of not carrying one that names another project.
  static const String anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  /// Throws unless both values are present, naming the one that is not.
  ///
  /// Supabase.initialize accepts an empty key and fails later, on the first
  /// request, as an opaque authorization error -- far from the cause.
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
        'Pass the publishable key for $url with '
        '--dart-define=SUPABASE_ANON_KEY=...',
      );
    }
  }
}
