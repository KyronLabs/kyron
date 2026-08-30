/// Supabase connection settings.
///
/// The publishable key is designed to be shipped in clients -- it grants only
/// what row level security allows -- so a default is committed to keep debug
/// builds and CI working without extra flags. Override per build with:
///   flutter build apk --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
class SupabaseConfig {
  const SupabaseConfig._();

  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://zgzvclssemsyctstwgod.supabase.co',
  );

  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpnenZjbHNzZW1zeWN0c3R3Z29kIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQxNTkyODgsImV4cCI6MjA3OTczNTI4OH0.Yq-yTerb4EI4Qi-jpgKYZHtIUik5PkLxArxqK_cngOE',
  );
}
