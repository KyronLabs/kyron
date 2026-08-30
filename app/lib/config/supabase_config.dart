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
    defaultValue: 'https://iyajzmgnykgkivabxiuw.supabase.co',
  );

  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'sb_publishable_uemaN4qKH1_K2h8STNCQDw_a4iO58do',
  );
}
