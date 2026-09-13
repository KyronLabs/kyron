class Validators {
  static String? nonEmpty(String? v) {
    if (v == null || v.trim().isEmpty) return 'Cannot be empty';
    return null;
  }

  /// Enough of an address to be worth sending to.
  ///
  /// Deliberately loose. The only address that is provably valid is one that
  /// accepted a message, so the job here is to catch the typo -- a missing @,
  /// a trailing comma, a space -- and then get out of the way. The last part
  /// used to be `{2,4}`, which turned away every one of the hundreds of
  /// top-level domains longer than four letters: nobody on a .online or a
  /// .digital address could get past it.
  static String? email(String? v) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return 'Enter your email address';
    final pattern = RegExp(r'^[\w.+-]+@([\w-]+\.)+[A-Za-z]{2,}$');
    if (!pattern.hasMatch(value)) {
      return 'That does not look like an email address';
    }
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.length < 8) return 'Password must be at least 8 chars';
    return null;
  }
}
